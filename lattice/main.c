/*
 * lattice — run a wave-encoded walk, print the pipeline result.
 *
 *   lattice walk.bin        run a pre-assembled walk, print result as decimal
 *   lattice --info          print active SIMD width and exit
 *
 * The walk file is raw bytes produced by hodos from a .w source.
 * After the walker returns, the pipeline value (= last monomial result =
 * the answer) is printed to stdout as a signed decimal integer followed
 * by a newline. Exit code is 0 if the walk ran; nonzero on I/O errors.
 *
 * Tests are shell-driven: build the .w → run it → compare stdout line
 * to the expected integer.
 *
 * SIMD width selection:
 * The lattice has four parallel bond dispatch tables — scalar / xmm /
 * ymm / zmm — one per Cayley-Dickson algebra dimension (R / H / O / S).
 * At startup we probe CPU capabilities via __builtin_cpu_supports and
 * point bond_fn_table_active at the widest supported table. All four
 * tables currently hold the same scalar function pointers; when a bond
 * gets a hand-written SIMD variant, the appropriate table slot is
 * swapped for the new function. No other code changes needed.
 *
 * See wit/draft/03-simd.md (prior/nomos) for the theoretical basis:
 * x86 SIMD widths (1/4/8/16 floats) follow the Cayley-Dickson chain
 * exactly, and sedenion zero divisors explain why AVX-1024 never shipped.
 */

#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <string.h>
#include <errno.h>
#include <fcntl.h>
#include <unistd.h>
#include <sys/mman.h>
#include <sys/stat.h>

extern uint64_t walk_run(const uint8_t *walk, int len);
extern uint64_t rho;

/* ──────────────────────────────────────────────────────────────
 * Primality sieve (Tier C infrastructure, Turn 11)
 *
 * Pre-computed bit array of primes up to SIEVE_MAX. Built once on
 * first `./lattice` invocation that isn't `--info`, then cached to
 * disk for subsequent runs (mmap'd instant). Exposes:
 *
 *   extern uint8_t *sieve_bits_ptr  — NULL before ensure_sieve(),
 *                                     points to a bit array after.
 *   extern uint64_t sieve_max       — upper bound (exclusive).
 *
 * The walker accesses these via `fn_is_prime_bit` bond at |D|=+41
 * for O(1) primality lookup. Replaces trial division in phase 1 of
 * shell_identity.winc at N≥17 where trial division is too slow.
 *
 * Sized for x_20 = 1,743,392,200 (Turn 14 discriminator). ~250 MB
 * bit array, cold build ~15 sec then mmap cached.
 * ────────────────────────────────────────────────────────────── */

#define SIEVE_MAX        2000000000UL
#define SIEVE_BYTES      ((SIEVE_MAX / 8) + 1)
#define SIEVE_CACHE_FILE "lattice_sieve.bin"

/* Exported to core.asm via extern. `sieve_bits_ptr` is read by
 * fn_is_prime_bit; `sieve_max` is read for the bounds check. */
uint8_t *sieve_bits_ptr = NULL;
const uint64_t sieve_max = SIEVE_MAX;

/* Standard bit-level Eratosthenes up to SIEVE_MAX. gcc -O3 -march=native
 * auto-vectorizes the inner loop; ~1-2 seconds cold build on modern CPUs. */
static void build_sieve(uint8_t *bits) {
    memset(bits, 0xFF, SIEVE_BYTES);
    bits[0] &= ~0x03;                  /* 0 and 1 are not prime */
    for (uint64_t p = 2; p * p < SIEVE_MAX; p++) {
        if (bits[p >> 3] & (1u << (p & 7))) {
            for (uint64_t k = p * p; k < SIEVE_MAX; k += p) {
                bits[k >> 3] &= (uint8_t)~(1u << (k & 7));
            }
        }
    }
}

/* ──────────────────────────────────────────────────────────────
 * Parallel Phase 1 for shell-identity Tier C tests.
 *
 * Replaces shell_phase1_sieve.winc's serial walker loop with an
 * OpenMP-parallelized C implementation. Identical algorithm:
 * sieve-backed primality check, balanced-ternary N-digit decode,
 * increment per-cell A_z counter by 2 for signed counterpart.
 *
 * For N=18 this cuts the 67-second serial walk to ~4 seconds on
 * a 16-core box (Ryzen 9 3950X). Correctness is cross-validated
 * by the shell_gcd_N{3,4,12}_c.w test walks which match the
 * walker-side shell_gcd_N{3,4,12}.w results at 13, 5, 91.
 *
 * Called from the fn_shell_phase1_c bond (core.asm |D|=+43).
 * ────────────────────────────────────────────────────────────── */

void shell_phase1_compute(uint32_t N, uint32_t x_N,
                          uint64_t *A_out, uint64_t *pi_out) {
    /* sieve must be built before we call this — bond-side call
     * sequence ensures ensure_sieve() has run via main(). */
    uint64_t A_local[32] = {0};
    uint64_t pi_count = 0;

    /* Inclusive upper bound. n=0 and n=1 are handled by the sieve
     * (those bits are 0), so the loop is safe to start at 2. */
    #pragma omp parallel for reduction(+:A_local[:32]) reduction(+:pi_count)
    for (uint64_t n = 2; n <= (uint64_t)x_N; n++) {
        /* sieve lookup — single byte + bit test */
        if (!((sieve_bits_ptr[n >> 3] >> (n & 7)) & 1)) continue;

        pi_count++;

        /* Balanced-ternary N-digit decode, counting zeros.
         * Matches shell_phase1_sieve.winc's walker loop exactly:
         *   r = p mod 3
         *   if r == 0: zeros++
         *   p = (p + (r >> 1)) / 3    // r>>1 is 0 for r∈{0,1}, 1 for r=2
         */
        uint64_t p = n;
        uint32_t zeros = 0;
        for (uint32_t i = 0; i < N; i++) {
            uint64_t r = p % 3;
            if (r == 0) zeros++;
            p = (p + (r >> 1)) / 3;
        }

        A_local[zeros] += 2;  /* signed counterpart: +p and −p */
    }

    /* Copy reduced A values to output buffer */
    for (uint32_t z = 0; z <= N && z < 32; z++) {
        A_out[z] = A_local[z];
    }
    *pi_out = pi_count;
}

/* Lazy-load the sieve. First call builds (or reads cache file),
 * subsequent calls are no-ops. */
static void ensure_sieve(void) {
    if (sieve_bits_ptr != NULL) return;

    /* try to mmap an existing cache file first */
    int fd = open(SIEVE_CACHE_FILE, O_RDONLY);
    if (fd >= 0) {
        struct stat st;
        if (fstat(fd, &st) == 0 && (size_t)st.st_size == SIEVE_BYTES) {
            void *m = mmap(NULL, SIEVE_BYTES, PROT_READ, MAP_SHARED, fd, 0);
            close(fd);
            if (m != MAP_FAILED) {
                sieve_bits_ptr = (uint8_t *)m;
                return;
            }
        } else {
            close(fd);
        }
    }

    /* cold build — allocate, sieve, write cache, point at in-memory copy */
    uint8_t *bits = (uint8_t *)malloc(SIEVE_BYTES);
    if (!bits) { perror("sieve malloc"); exit(1); }
    build_sieve(bits);

    fd = open(SIEVE_CACHE_FILE, O_WRONLY | O_CREAT | O_TRUNC, 0644);
    if (fd >= 0) {
        ssize_t written = 0;
        size_t remaining = SIEVE_BYTES;
        while (remaining > 0) {
            ssize_t w = write(fd, bits + written, remaining);
            if (w <= 0) break;
            written += w;
            remaining -= (size_t)w;
        }
        close(fd);
    }

    sieve_bits_ptr = bits;
}

/* The four dispatch tables, one per SIMD width. NASM exports each as a
 * 16-entry array of function pointers. bond_fn_table_active is a
 * writable qword in .data holding the address of whichever table is
 * currently selected. */
extern void *bond_fn_table_scalar[16];
extern void *bond_fn_table_xmm[16];
extern void *bond_fn_table_ymm[16];
extern void *bond_fn_table_zmm[16];
extern void *bond_fn_table_active;

/* Probe CPU and select the widest bond table. Returns a short name for
 * printing. The zmm table will be selected only on AVX-512-capable
 * silicon (Zen 4+, Intel Skylake-SP+); ymm on any AVX2 CPU (Haswell+,
 * Zen+); xmm on any SSE2 CPU (baseline x86-64); scalar otherwise. */
static const char *select_width(void) {
    __builtin_cpu_init();
    if (__builtin_cpu_supports("avx512f")) {
        bond_fn_table_active = bond_fn_table_zmm;
        return "ZMM (AVX-512, 16-wide, sedenion-width)";
    }
    if (__builtin_cpu_supports("avx2")) {
        bond_fn_table_active = bond_fn_table_ymm;
        return "YMM (AVX2, 8-wide, octonion-width)";
    }
    if (__builtin_cpu_supports("sse2")) {
        bond_fn_table_active = bond_fn_table_xmm;
        return "XMM (SSE2, 4-wide, quaternion-width)";
    }
    /* bond_fn_table_active already initialized to scalar in NASM .data */
    return "scalar (real-width, no SIMD)";
}

int main(int argc, char **argv) {
    /* --info: print active SIMD width and exit. Used by ./run as a
     * preflight so the per-test invocations don't spam banners. */
    if (argc >= 2 && strcmp(argv[1], "--info") == 0) {
        const char *level = select_width();
        printf("%s\n", level);
        return 0;
    }

    if (argc < 2) {
        fprintf(stderr, "usage: %s walk.bin\n"
                        "       %s --info\n", argv[0], argv[0]);
        return 2;
    }

    /* Always select width on every run. CPUID is cached by the kernel
     * after first query; cost is a handful of instructions. */
    select_width();

    /* Build or mmap the primality sieve before running any walk that
     * might use fn_is_prime_bit. First cold build ~1-2 seconds; all
     * subsequent invocations mmap the cached file (~ms). */
    ensure_sieve();

    FILE *f = fopen(argv[1], "rb");
    if (!f) {
        fprintf(stderr, "lattice: %s: %s\n", argv[1], strerror(errno));
        return 1;
    }

    if (fseek(f, 0, SEEK_END) != 0) { perror("fseek"); fclose(f); return 1; }
    long len = ftell(f);
    if (len < 0) { perror("ftell"); fclose(f); return 1; }
    rewind(f);

    uint8_t *buf = malloc((size_t)len);
    if (!buf) { perror("malloc"); fclose(f); return 1; }

    if (fread(buf, 1, (size_t)len, f) != (size_t)len) {
        fprintf(stderr, "lattice: short read on %s\n", argv[1]);
        free(buf);
        fclose(f);
        return 1;
    }
    fclose(f);

    uint64_t result = walk_run(buf, (int)len);
    free(buf);

    /* Print signed — most lattice answers are small positive integers,
       but the walker is 64-bit and some bonds (negate, sub) can produce
       negatives. Print as signed decimal so either reads naturally. */
    printf("%lld\n", (long long)(int64_t)result);
    return 0;
}
