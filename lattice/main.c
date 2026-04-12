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

/* ──────────────────────────────────────────────────────────────
 * Cayley-Dickson multiplication, C implementations.
 *
 * MAX_CD_DIM: every local array in the CD pipeline is sized to this.
 * Bump this ONE number when adding a new doubling level. If you add
 * d=256, set it to 256. This kills the recurring buffer-overflow bug
 * where enumerate_zd_pairs / chains_d_compute had undersized arrays
 * (hit at d=64 and d=128, same root cause both times).
 *
 * `cd_mul_d4_compute` is the C mirror of the walker-native
 * `fn_cd_mul_d4` bond, used as cross-validation at d4. Same exact
 * quaternion formulas, just in C so we can trust gcc -O3's codegen
 * independently of the hand-written asm.
 *
 * `cd_mul_d8_compute` is the first C-only CD step — octonion
 * multiplication via Cayley-Dickson doubling of quaternions:
 *   (A,B)·(C,D) = (AC − D̄B, DA + BC̄)
 * where (A,B) and (C,D) are each split into two quaternion halves,
 * bars denote quaternion conjugation, · is quaternion multiplication.
 *
 * These are input prep for Tier D.3/D.4 (zero divisor counts and
 * chain enumeration). Those stay walker-side as the theorems under
 * test; mul is prep, same framework-purity license as shell phase 1.
 * ────────────────────────────────────────────────────────────── */

#define MAX_CD_DIM 128   /* bump when adding the next doubling level */

static inline void q_mul_inner(const int64_t *a, const int64_t *b, int64_t *out) {
    out[0] = a[0]*b[0] - a[1]*b[1] - a[2]*b[2] - a[3]*b[3];
    out[1] = a[0]*b[1] + a[1]*b[0] + a[2]*b[3] - a[3]*b[2];
    out[2] = a[0]*b[2] - a[1]*b[3] + a[2]*b[0] + a[3]*b[1];
    out[3] = a[0]*b[3] + a[1]*b[2] - a[2]*b[1] + a[3]*b[0];
}

void cd_mul_d4_compute(const int64_t *a, const int64_t *b, int64_t *out) {
    q_mul_inner(a, b, out);
}

void cd_mul_d8_compute(const int64_t *a, const int64_t *b, int64_t *out) {
    /* Split each octonion into two quaternion halves. */
    const int64_t *A = a;
    const int64_t *B = a + 4;
    const int64_t *C = b;
    const int64_t *D = b + 4;

    /* Conjugates: flip the sign of the non-scalar components. */
    int64_t C_conj[4] = { C[0], -C[1], -C[2], -C[3] };
    int64_t D_conj[4] = { D[0], -D[1], -D[2], -D[3] };

    int64_t AC[4], D_conj_B[4];
    int64_t DA[4], BC_conj[4];

    q_mul_inner(A, C, AC);
    q_mul_inner(D_conj, B, D_conj_B);
    q_mul_inner(D, A, DA);
    q_mul_inner(B, C_conj, BC_conj);

    /* out_low = AC − D̄B */
    for (int i = 0; i < 4; i++) out[i] = AC[i] - D_conj_B[i];
    /* out_high = DA + BC̄ */
    for (int i = 0; i < 4; i++) out[i + 4] = DA[i] + BC_conj[i];
}

void cd_mul_d16_compute(const int64_t *a, const int64_t *b, int64_t *out) {
    /* Sedenion: pair of octonions, same doubling formula as d8. */
    const int64_t *A = a;
    const int64_t *B = a + 8;
    const int64_t *C = b;
    const int64_t *D = b + 8;

    int64_t C_conj[8] = { C[0], -C[1], -C[2], -C[3],
                          -C[4], -C[5], -C[6], -C[7] };
    int64_t D_conj[8] = { D[0], -D[1], -D[2], -D[3],
                          -D[4], -D[5], -D[6], -D[7] };

    int64_t AC[8], D_conj_B[8];
    int64_t DA[8], BC_conj[8];

    cd_mul_d8_compute(A, C, AC);
    cd_mul_d8_compute(D_conj, B, D_conj_B);
    cd_mul_d8_compute(D, A, DA);
    cd_mul_d8_compute(B, C_conj, BC_conj);

    for (int i = 0; i < 8; i++) out[i] = AC[i] - D_conj_B[i];
    for (int i = 0; i < 8; i++) out[i + 8] = DA[i] + BC_conj[i];
}

void cd_mul_d32_compute(const int64_t *a, const int64_t *b, int64_t *out) {
    /* Pathion: pair of sedenions, same doubling as d16. */
    const int64_t *A = a;
    const int64_t *B = a + 16;
    const int64_t *C = b;
    const int64_t *D = b + 16;

    int64_t C_conj[16], D_conj[16];
    C_conj[0] = C[0];
    D_conj[0] = D[0];
    for (int i = 1; i < 16; i++) {
        C_conj[i] = -C[i];
        D_conj[i] = -D[i];
    }

    int64_t AC[16], D_conj_B[16];
    int64_t DA[16], BC_conj[16];

    cd_mul_d16_compute(A, C, AC);
    cd_mul_d16_compute(D_conj, B, D_conj_B);
    cd_mul_d16_compute(D, A, DA);
    cd_mul_d16_compute(B, C_conj, BC_conj);

    for (int i = 0; i < 16; i++) out[i] = AC[i] - D_conj_B[i];
    for (int i = 0; i < 16; i++) out[i + 16] = DA[i] + BC_conj[i];
}

void cd_mul_d64_compute(const int64_t *a, const int64_t *b, int64_t *out) {
    /* Chingon: pair of pathions, same doubling as d32. */
    const int64_t *A = a;
    const int64_t *B = a + 32;
    const int64_t *C = b;
    const int64_t *D = b + 32;

    int64_t C_conj[32], D_conj[32];
    C_conj[0] = C[0];
    D_conj[0] = D[0];
    for (int i = 1; i < 32; i++) {
        C_conj[i] = -C[i];
        D_conj[i] = -D[i];
    }

    int64_t AC[32], D_conj_B[32];
    int64_t DA[32], BC_conj[32];

    cd_mul_d32_compute(A, C, AC);
    cd_mul_d32_compute(D_conj, B, D_conj_B);
    cd_mul_d32_compute(D, A, DA);
    cd_mul_d32_compute(B, C_conj, BC_conj);

    for (int i = 0; i < 32; i++) out[i] = AC[i] - D_conj_B[i];
    for (int i = 0; i < 32; i++) out[i + 32] = DA[i] + BC_conj[i];
}

/* ──────────────────────────────────────────────────────────────
 * Zero-divisor enumeration at dim 16 (Tier D.3 structural probe).
 *
 * Canonical form per wit/thoughts/prime-lattice/code/cayley_dickson_integer.py:
 *
 *   A = e_i + e_j          (1 ≤ i < j ≤ 15)
 *   B = e_k + sign · e_l   (1 ≤ k < l ≤ 15, sign ∈ {−1, +1})
 *
 * The pair (A, B) is a "canonical zero divisor" if A · B = 0.
 * Skip the single case (i,j)==(k,l) with sign=+1 (A == B).
 * Total pairs tested = C(15,2)² · 2 − C(15,2) = 105² · 2 − 105 = 21945.
 * Wit-side Python compute says exactly 168 of these are zero divisors.
 *
 * Walker bond fn_zero_divisors_d16 calls this function and returns
 * the integer count in the pipeline. If the walker returns 168, Tier
 * D.3 at d=16 is machine-verified and the chain probe at Turn 19 can
 * use this enumerator as a subroutine.
 * ────────────────────────────────────────────────────────────── */

/* Generic enumerator. cd_mul is the dimension-matching mul fn. */
typedef void (*cd_mul_fn)(const int64_t *, const int64_t *, int64_t *);

static uint64_t zero_divisors_d_compute(int D, cd_mul_fn cd_mul) {
    int64_t A[MAX_CD_DIM], B[MAX_CD_DIM], prod[MAX_CD_DIM];
    uint64_t count = 0;

    for (int i = 1; i < D; i++) {
        for (int j = i + 1; j < D; j++) {
            for (int m = 0; m < D; m++) A[m] = 0;
            A[i] = 1;
            A[j] = 1;

            for (int k = 1; k < D; k++) {
                for (int l = k + 1; l < D; l++) {
                    for (int sign_l = -1; sign_l <= 1; sign_l += 2) {
                        if (i == k && j == l && sign_l == 1) continue;

                        for (int m = 0; m < D; m++) B[m] = 0;
                        B[k] = 1;
                        B[l] = sign_l;

                        cd_mul(A, B, prod);

                        int all_zero = 1;
                        for (int m = 0; m < D; m++) {
                            if (prod[m] != 0) { all_zero = 0; break; }
                        }
                        if (all_zero) count++;
                    }
                }
            }
        }
    }

    return count;
}

uint64_t zero_divisors_d16_compute(void) {
    return zero_divisors_d_compute(16, cd_mul_d16_compute);
}

uint64_t zero_divisors_d32_compute(void) {
    return zero_divisors_d_compute(32, cd_mul_d32_compute);
}

/* ──────────────────────────────────────────────────────────────
 * Chain enumeration at dim D (Tier D.4).
 *
 * Counts triples (A, B, C) of canonical zero-divisor pairs such that
 *   A · B = 0  AND  B · C = 0  AND  A · C = 0
 * under the same canonical-form rule as zero_divisors_d_compute.
 *
 * Matches cayley_dickson_integer.py's count_chains() exactly. The
 * middle element B must itself appear as an "A-form" (+1-sign) in
 * some other zero-divisor pair, i.e. the middle element's sign_l
 * must be +1 for the chain to potentially extend.
 *
 * For d=16, Python reports 0 chains out of 252 candidate triples.
 * For d=32, this is the previously-uncomputed integer — THE target
 * of the prime-lattice Tier D effort.
 * ────────────────────────────────────────────────────────────── */

typedef struct { int i, j, k, l, sign_l; } zd_pair_t;

/* Upper bound on zd pair count: 21945 at d=16, 431985 at d=32.
 * Reserve enough for d=32; d=16 uses a tiny subset. */
#define MAX_ZD_PAIRS 524288

static int enumerate_zd_pairs(int D, cd_mul_fn cd_mul,
                              zd_pair_t *out_pairs, int cap) {
    int64_t A[MAX_CD_DIM], B[MAX_CD_DIM], prod[MAX_CD_DIM];
    int n = 0;

    for (int i = 1; i < D; i++) {
        for (int j = i + 1; j < D; j++) {
            for (int m = 0; m < D; m++) A[m] = 0;
            A[i] = 1; A[j] = 1;

            for (int k = 1; k < D; k++) {
                for (int l = k + 1; l < D; l++) {
                    for (int sl = -1; sl <= 1; sl += 2) {
                        if (i == k && j == l && sl == 1) continue;

                        for (int m = 0; m < D; m++) B[m] = 0;
                        B[k] = 1; B[l] = sl;

                        cd_mul(A, B, prod);
                        int all_zero = 1;
                        for (int m = 0; m < D; m++) {
                            if (prod[m] != 0) { all_zero = 0; break; }
                        }
                        if (all_zero && n < cap) {
                            out_pairs[n].i = i;
                            out_pairs[n].j = j;
                            out_pairs[n].k = k;
                            out_pairs[n].l = l;
                            out_pairs[n].sign_l = sl;
                            n++;
                        }
                    }
                }
            }
        }
    }

    return n;
}

static uint64_t chains_d_compute(int D, cd_mul_fn cd_mul, uint64_t *candidates_out) {
    static zd_pair_t pairs[MAX_ZD_PAIRS];
    int n_pairs = enumerate_zd_pairs(D, cd_mul, pairs, MAX_ZD_PAIRS);

    int64_t A[MAX_CD_DIM], C_vec[MAX_CD_DIM], prod[MAX_CD_DIM];
    uint64_t chains = 0;
    uint64_t candidates = 0;

    for (int p = 0; p < n_pairs; p++) {
        /* B is the middle element: e_{pairs[p].k} + sign_l · e_{pairs[p].l}.
         * For B to match another pair's "A-form" (which is always +1-sign
         * on both basis elements), we need pairs[p].sign_l == +1. */
        if (pairs[p].sign_l != 1) continue;

        int B_i = pairs[p].k;
        int B_j = pairs[p].l;

        /* A = e_{pairs[p].i} + e_{pairs[p].j} */
        for (int m = 0; m < D; m++) A[m] = 0;
        A[pairs[p].i] = 1;
        A[pairs[p].j] = 1;

        /* Look for pairs q where q's A-form equals our B,
         * i.e. q.i == B_i and q.j == B_j. */
        for (int q = 0; q < n_pairs; q++) {
            if (pairs[q].i != B_i || pairs[q].j != B_j) continue;

            /* Skip trivial: C == A. */
            if (pairs[q].sign_l == 1 &&
                pairs[q].k == pairs[p].i &&
                pairs[q].l == pairs[p].j) continue;

            candidates++;

            for (int m = 0; m < D; m++) C_vec[m] = 0;
            C_vec[pairs[q].k] = 1;
            C_vec[pairs[q].l] = pairs[q].sign_l;

            cd_mul(A, C_vec, prod);
            int all_zero = 1;
            for (int m = 0; m < D; m++) {
                if (prod[m] != 0) { all_zero = 0; break; }
            }
            if (all_zero) chains++;
        }
    }

    if (candidates_out) *candidates_out = candidates;
    return chains;
}

uint64_t chains_d16_compute(void) {
    return chains_d_compute(16, cd_mul_d16_compute, NULL);
}

uint64_t chains_d32_compute(void) {
    return chains_d_compute(32, cd_mul_d32_compute, NULL);
}

uint64_t chains_d32_candidates_compute(void) {
    uint64_t candidates = 0;
    (void)chains_d_compute(32, cd_mul_d32_compute, &candidates);
    return candidates;
}

void cd_mul_d128_compute(const int64_t *a, const int64_t *b, int64_t *out) {
    const int64_t *A = a;
    const int64_t *B = a + 64;
    const int64_t *C = b;
    const int64_t *D = b + 64;

    int64_t C_conj[64], D_conj[64];
    C_conj[0] = C[0];
    D_conj[0] = D[0];
    for (int i = 1; i < 64; i++) {
        C_conj[i] = -C[i];
        D_conj[i] = -D[i];
    }

    int64_t AC[64], D_conj_B[64];
    int64_t DA[64], BC_conj[64];

    cd_mul_d64_compute(A, C, AC);
    cd_mul_d64_compute(D_conj, B, D_conj_B);
    cd_mul_d64_compute(D, A, DA);
    cd_mul_d64_compute(B, C_conj, BC_conj);

    for (int i = 0; i < 64; i++) out[i] = AC[i] - D_conj_B[i];
    for (int i = 0; i < 64; i++) out[i + 64] = DA[i] + BC_conj[i];
}

uint64_t zero_divisors_d64_compute(void) {
    return zero_divisors_d_compute(64, cd_mul_d64_compute);
}

uint64_t chains_d64_compute(void) {
    return chains_d_compute(64, cd_mul_d64_compute, NULL);
}

uint64_t chains_d64_candidates_compute(void) {
    uint64_t candidates = 0;
    (void)chains_d_compute(64, cd_mul_d64_compute, &candidates);
    return candidates;
}

uint64_t zero_divisors_d128_compute(void) {
    return zero_divisors_d_compute(128, cd_mul_d128_compute);
}

uint64_t chains_d128_compute(void) {
    return chains_d_compute(128, cd_mul_d128_compute, NULL);
}

uint64_t chains_d128_candidates_compute(void) {
    uint64_t candidates = 0;
    (void)chains_d_compute(128, cd_mul_d128_compute, &candidates);
    return candidates;
}

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
