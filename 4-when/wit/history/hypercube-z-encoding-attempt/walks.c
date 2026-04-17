/*
 * walks — measure path lengths on the lattice
 *
 * for each element:
 *   - L1 from origin (geometric shortest walk)
 *   - delta from previous element (BBN step length)
 *
 * sum the BBN walk total. compare to ideal.
 */
#include <stdio.h>
#include <stdlib.h>

typedef struct { int a, b, c, d; } coord4;

coord4 to_lattice(int n) {
    coord4 c;
    int v = n, r;
    r = ((v % 3) + 3) % 3; if (r == 2) r = -1; c.d = r; v = (v - r) / 3;
    r = ((v % 3) + 3) % 3; if (r == 2) r = -1; c.c = r; v = (v - r) / 3;
    r = ((v % 3) + 3) % 3; if (r == 2) r = -1; c.b = r; v = (v - r) / 3;
    r = ((v % 3) + 3) % 3; if (r == 2) r = -1; c.a = r; v = (v - r) / 3;
    return c;
}

int l1(coord4 c) { return abs(c.a) + abs(c.b) + abs(c.c) + abs(c.d); }

int delta(coord4 a, coord4 b) {
    return abs(a.a - b.a) + abs(a.b - b.b) + abs(a.c - b.c) + abs(a.d - b.d);
}

const char *sym[] = {
    "??","H","He","Li","Be","B","C","N","O","F","Ne",
    "Na","Mg","Al","Si","P","S","Cl","Ar",
    "K","Ca","Sc","Ti","V","Cr","Mn","Fe","Co","Ni","Cu","Zn",
    "Ga","Ge","As","Se","Br","Kr",
    "Rb","Sr","Y","Zr","Nb","Mo","Tc","Ru","Rh","Pd","Ag","Cd","In","Sn",
    "Sb","Te","I","Xe","Cs","Ba","La","Ce","Pr","Nd",
    "Pm","Sm","Eu","Gd","Tb","Dy","Ho","Er","Tm","Yb",
    "Lu","Hf","Ta","W","Re","Os","Ir","Pt","Au","Hg","Tl","Pb"
};

int main(void) {
    /* part 1: each element's L1 from origin */
    printf("── L1 distance from origin for each element ──\n");
    printf("  Z  sym  coord            L1   Z mismatch?\n");
    int max_l1 = 0;
    int total_l1 = 0;
    for (int z = 1; z <= 82; z++) {
        coord4 c = to_lattice(z);
        int d = l1(c);
        if (d > max_l1) max_l1 = d;
        total_l1 += d;
        if (z <= 12 || z == 26 || z == 43 || z == 61 || z == 81 || z == 82) {
            printf("  %2d %-2s   (%+d,%+d,%+d,%+d)   %d    %s\n",
                   z, sym[z], c.a, c.b, c.c, c.d, d,
                   d == z ? "MATCH" : "");
        }
    }
    printf("  ...\n  max L1 across all elements: %d\n", max_l1);
    printf("  sum of all L1 from origin: %d\n", total_l1);
    printf("  average: %.2f\n\n", total_l1 / 82.0);

    /* part 2: BBN walk — sum of deltas between consecutive elements */
    printf("── BBN walk: sum of L1 deltas Z → Z+1 ──\n");
    printf("  Z → Z+1  delta  notes\n");
    int total_delta = 0;
    int max_delta = 0;
    int max_at = 0;
    coord4 prev = {0, 0, 0, 0}; /* start at origin */
    for (int z = 1; z <= 82; z++) {
        coord4 c = to_lattice(z);
        int d = delta(prev, c);
        total_delta += d;
        if (d > max_delta) { max_delta = d; max_at = z; }
        if (d >= 4 || z <= 6) {
            printf("  %2d %-2s → %2d %-2s   %d %s\n",
                   z-1, z>1?sym[z-1]:"--", z, sym[z], d,
                   d >= 4 ? "← big jump" : "");
        }
        prev = c;
    }
    printf("  ...\n  total BBN walk length (origin → Pb): %d edges\n", total_delta);
    printf("  max single jump: %d (at Z=%d %s)\n", max_delta, max_at, sym[max_at]);
    printf("  average step: %.2f edges\n\n", total_delta / 82.0);

    /* part 3: ideal walk — all 81 coords once via Hamiltonian path */
    /* lower bound: a Hamiltonian path on the 4D hypercube/lattice
       with min step = 1 would have length 80. so 80 is the minimum
       possible for 81 points. */
    printf("── comparison ──\n");
    printf("  ideal min walk through 81 points: 80 (each step = 1)\n");
    printf("  actual BBN walk:                   %d\n", total_delta);
    printf("  efficiency: %.1f%% (ideal/actual)\n",
           100.0 * 80 / total_delta);
    printf("  excess steps: %d\n\n", total_delta - 80);

    /* part 4: count steps of each size */
    printf("── distribution of step sizes ──\n");
    int hist[10] = {0};
    prev = (coord4){0,0,0,0};
    for (int z = 1; z <= 82; z++) {
        coord4 c = to_lattice(z);
        int d = delta(prev, c);
        if (d < 10) hist[d]++;
        prev = c;
    }
    for (int i = 0; i < 10; i++) {
        if (hist[i] > 0) {
            printf("  step size %d: %d times\n", i, hist[i]);
        }
    }

    return 0;
}
