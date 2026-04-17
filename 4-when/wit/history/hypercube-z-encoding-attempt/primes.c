/*
 * primes on the lattice
 *
 * map integers to 4D balanced-ternary coords
 * mark primes vs composites
 * look for geometric patterns
 */
#include <stdio.h>
#include <math.h>
#include <stdlib.h>

typedef struct { int a, b, c, d; } coord4;

/* balanced ternary: each digit in {-1, 0, +1} */
coord4 to_lattice(int n) {
    coord4 c;
    int v = n;
    /* decompose into 4 balanced ternary digits (base 3) */
    /* digit 0 (ones) */
    int r = ((v % 3) + 3) % 3;
    if (r == 2) r = -1;
    c.d = r;
    v = (v - r) / 3;
    /* digit 1 (threes) */
    r = ((v % 3) + 3) % 3;
    if (r == 2) r = -1;
    c.c = r;
    v = (v - r) / 3;
    /* digit 2 (nines) */
    r = ((v % 3) + 3) % 3;
    if (r == 2) r = -1;
    c.b = r;
    v = (v - r) / 3;
    /* digit 3 (twenty-sevens) */
    r = ((v % 3) + 3) % 3;
    if (r == 2) r = -1;
    c.a = r;
    return c;
}

int is_prime(int n) {
    if (n < 2) return 0;
    if (n < 4) return 1;
    if (n % 2 == 0 || n % 3 == 0) return 0;
    for (int i = 5; i * i <= n; i += 6)
        if (n % i == 0 || n % (i+2) == 0) return 0;
    return 1;
}

int zeros(coord4 c) {
    return (c.a==0) + (c.b==0) + (c.c==0) + (c.d==0);
}

int shell(coord4 c) {
    int m = 0;
    if (abs(c.a) > m) m = abs(c.a);
    if (abs(c.b) > m) m = abs(c.b);
    if (abs(c.c) > m) m = abs(c.c);
    if (abs(c.d) > m) m = abs(c.d);
    return m;
}

int main(void) {
    printf("  N  prime  coord           zeros  shell  stratum\n");
    printf("───  ─────  ─────           ─────  ─────  ───────\n");

    int prime_zeros[5] = {0};
    int comp_zeros[5] = {0};
    int total_primes = 0;

    for (int n = 1; n <= 81; n++) {
        coord4 c = to_lattice(n);
        int p = is_prime(n);
        int z = zeros(c);
        int s = shell(c);

        const char *strat = z==4 ? "origin" : z==3 ? "atom" :
                            z==2 ? "dyad" : z==1 ? "triad" : "corner";

        if (p) { prime_zeros[z]++; total_primes++; }
        else   { comp_zeros[z]++; }

        printf("%3d  %s     (%+d,%+d,%+d,%+d)  %d      %d      %s\n",
               n, p ? "PRIME" : "     ", c.a, c.b, c.c, c.d, z, s, strat);
    }

    printf("\n── distribution of primes by stratum (N=1..81) ──\n");
    const char *names[] = {"corner","triad","dyad","atom","origin"};
    for (int z = 0; z <= 4; z++) {
        int total = prime_zeros[z] + comp_zeros[z];
        if (total > 0)
            printf("  %s: %d primes / %d total (%.0f%%)\n",
                   names[z], prime_zeros[z], total,
                   100.0 * prime_zeros[z] / total);
    }
    printf("  total: %d primes in 1..81\n", total_primes);

    /* sum of 4 squares for first few primes */
    printf("\n── primes as sum of 4 squares (quaternion norm) ──\n");
    for (int n = 2; n <= 50; n++) {
        if (!is_prime(n)) continue;
        /* brute force search for a²+b²+c²+d² = n */
        int found = 0;
        for (int a = 0; !found && a*a <= n; a++)
        for (int b = 0; !found && a*a+b*b <= n; b++)
        for (int c = 0; !found && a*a+b*b+c*c <= n; c++) {
            int d2 = n - a*a - b*b - c*c;
            int d = (int)sqrt(d2);
            if (d*d == d2) {
                printf("  %2d = %d² + %d² + %d² + %d²   q=(%d+%di+%dj+%dk)\n",
                       n, a, b, c, d, a, b, c, d);
                found = 1;
            }
        }
    }

    return 0;
}
