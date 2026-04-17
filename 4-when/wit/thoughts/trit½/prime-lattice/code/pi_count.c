/* pi_count.c — segmented Eratosthenes for π(x) at shell boundaries
 *
 * Usage: ./pi_count N   (computes π(x_N) where x_N = (3^N - 1)/2)
 *    or: ./pi_count -x VALUE   (computes π(VALUE) directly)
 *
 * Segmented sieve uses O(√x) memory regardless of x.
 * Handles up to ~10^12 comfortably.
 *
 * Compile: gcc -O3 -o pi_count pi_count.c -lm
 */

#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <string.h>
#include <math.h>

#define SEGMENT_SIZE (1 << 19)  /* 512K bits per segment = 64KB */

static uint8_t small_sieve[1 << 20];  /* primes up to ~10^6 */
static uint32_t small_primes[80000];   /* enough for primes up to 10^6 */
static int n_small_primes = 0;

static void build_small_sieve(uint64_t limit) {
    uint64_t sq = (uint64_t)sqrt((double)limit) + 1;
    if (sq > sizeof(small_sieve) * 8) sq = sizeof(small_sieve) * 8;

    memset(small_sieve, 0xFF, (sq / 8) + 1);
    small_sieve[0] &= ~3u;  /* 0 and 1 not prime */

    for (uint64_t p = 2; p * p < sq; p++) {
        if (small_sieve[p >> 3] & (1 << (p & 7))) {
            for (uint64_t j = p * p; j < sq; j += p)
                small_sieve[j >> 3] &= ~(1 << (j & 7));
        }
    }

    n_small_primes = 0;
    for (uint64_t i = 2; i < sq && n_small_primes < 80000; i++) {
        if (small_sieve[i >> 3] & (1 << (i & 7)))
            small_primes[n_small_primes++] = (uint32_t)i;
    }
}

static uint64_t count_primes(uint64_t limit) {
    if (limit < 2) return 0;

    build_small_sieve(limit);

    uint64_t count = 0;
    uint8_t seg[SEGMENT_SIZE / 8 + 1];
    uint64_t *next = calloc(n_small_primes, sizeof(uint64_t));

    /* initialize starting positions for each small prime */
    for (int i = 0; i < n_small_primes; i++) {
        uint64_t p = small_primes[i];
        next[i] = p * p;
    }

    for (uint64_t lo = 0; lo <= limit; lo += SEGMENT_SIZE) {
        uint64_t hi = lo + SEGMENT_SIZE - 1;
        if (hi > limit) hi = limit;

        uint64_t seg_len = hi - lo + 1;
        memset(seg, 0xFF, (seg_len / 8) + 1);

        /* mark 0 and 1 as not prime */
        if (lo == 0) {
            seg[0] &= ~3u;
        }

        /* sieve this segment */
        for (int i = 0; i < n_small_primes; i++) {
            uint64_t p = small_primes[i];
            uint64_t start = next[i];
            if (start > hi) continue;
            if (start < lo) {
                start = lo + ((p - (lo % p)) % p);
                if (start == lo && lo > p) start += p;
                /* ensure start >= p*p and start >= lo */
                if (start < p * p) start = p * p;
                if (start < lo) {
                    uint64_t rem = lo % p;
                    start = lo + (rem ? p - rem : 0);
                }
            }
            for (uint64_t j = start; j <= hi; j += p) {
                uint64_t off = j - lo;
                seg[off >> 3] &= ~(1 << (off & 7));
            }
            /* save next position for this prime */
            next[i] = hi + 1 + ((p - ((hi + 1) % p)) % p);
            /* simpler: just recompute next time */
        }

        /* count primes in this segment */
        for (uint64_t j = 0; j < seg_len; j++) {
            if (seg[j >> 3] & (1 << (j & 7)))
                count++;
        }
    }

    free(next);
    return count;
}

/* trial-division factorization of n */
static void print_factors(uint64_t n) {
    if (n <= 1) { printf("%lu", n); return; }
    uint64_t orig = n;
    int first = 1;
    for (uint64_t p = 2; p * p <= n; p++) {
        int e = 0;
        while (n % p == 0) { e++; n /= p; }
        if (e > 0) {
            if (!first) printf(" * ");
            if (e == 1) printf("%lu", p);
            else printf("%lu^%d", p, e);
            first = 0;
        }
    }
    if (n > 1) {
        if (!first) printf(" * ");
        printf("%lu", n);
    }
}

int main(int argc, char **argv) {
    if (argc < 2) {
        fprintf(stderr, "Usage: %s N  or  %s -x VALUE\n", argv[0], argv[0]);
        return 1;
    }

    uint64_t x;
    int N = 0;

    if (strcmp(argv[1], "-x") == 0 && argc >= 3) {
        x = strtoull(argv[2], NULL, 10);
    } else {
        N = atoi(argv[1]);
        /* compute 3^N */
        uint64_t pow3 = 1;
        for (int i = 0; i < N; i++) {
            if (pow3 > UINT64_MAX / 3) {
                fprintf(stderr, "N=%d too large for uint64\n", N);
                return 1;
            }
            pow3 *= 3;
        }
        x = (pow3 - 1) / 2;
        printf("N = %d\n", N);
        printf("x_N = (3^%d - 1)/2 = %lu\n", N, x);
    }

    printf("computing pi(%lu)...\n", x);
    fflush(stdout);

    uint64_t pi = count_primes(x);

    printf("pi(%lu) = %lu\n", x, pi);
    printf("factorization: ");
    print_factors(pi);
    printf("\n");

    /* also factor x itself for convenience */
    if (N > 0) {
        printf("x_%d factorization: ", N);
        print_factors(x);
        printf("\n");

        /* odd_part */
        uint64_t odd = x;
        int v2 = 0;
        while (odd % 2 == 0) { odd /= 2; v2++; }
        if (v2 > 0) {
            printf("odd_part(x_%d) = %lu (v_2 = %d)\n", N, odd, v2);
            printf("odd_part factorization: ");
            print_factors(odd);
            printf("\n");
        }
    }

    return 0;
}
