/*
 * alchemy — find element pairs that are geometrically close
 * but numerically far. these are "alchemy candidates" —
 * transitions cheap on the lattice but expensive in nuclear physics.
 *
 * lead → gold is the canonical case. how many others are there?
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

int is_unstable(int z) { return z == 43 || z == 61; }

int main(void) {
    /* find all pairs (z1, z2) where lattice distance = 1
       and atomic number distance > 1.
       these are "alchemy" pairs — adjacent on the lattice
       but separated by intervening protons. */

    printf("── alchemy pairs: lattice distance 1, |Z1-Z2| > 1 ──\n");
    printf("  pair                lattice  Z-diff  axis change\n");
    printf("  ────                ───────  ──────  ───────────\n");

    int count_d1 = 0;
    int max_z_diff = 0;
    int best_z1 = 0, best_z2 = 0;

    for (int z1 = 1; z1 <= 82; z1++) {
        if (is_unstable(z1)) continue;
        for (int z2 = z1 + 2; z2 <= 82; z2++) {
            if (is_unstable(z2)) continue;
            coord4 c1 = to_lattice(z1);
            coord4 c2 = to_lattice(z2);
            int d = delta(c1, c2);
            if (d == 1) {
                count_d1++;
                int zdiff = z2 - z1;
                if (zdiff > max_z_diff) {
                    max_z_diff = zdiff;
                    best_z1 = z1;
                    best_z2 = z2;
                }
                /* identify which axis changed */
                const char *axis = "?";
                if (c1.a != c2.a) axis = "A POSITION";
                if (c1.b != c2.b) axis = "B SUBSTANCE";
                if (c1.c != c2.c) axis = "C SIGNAL";
                if (c1.d != c2.d) axis = "D TIME";
                printf("  %2d %-2s ↔ %2d %-2s    1        %2d      %s\n",
                       z1, sym[z1], z2, sym[z2], zdiff, axis);
            }
        }
    }
    printf("\n  total alchemy pairs (lattice-distance 1): %d\n", count_d1);
    printf("  largest Z-jump for distance-1 pair: %d (Z=%d %s ↔ Z=%d %s)\n",
           max_z_diff, best_z1, sym[best_z1], best_z2, sym[best_z2]);

    /* check the famous one specifically */
    printf("\n── the canonical case: lead → gold ──\n");
    coord4 au = to_lattice(79);
    coord4 pb = to_lattice(82);
    coord4 hg = to_lattice(80);
    printf("  Au (Z=79) = (%+d,%+d,%+d,%+d)\n", au.a, au.b, au.c, au.d);
    printf("  Hg (Z=80) = (%+d,%+d,%+d,%+d)\n", hg.a, hg.b, hg.c, hg.d);
    printf("  Pb (Z=82) = (%+d,%+d,%+d,%+d)\n", pb.a, pb.b, pb.c, pb.d);
    printf("\n");
    printf("  lattice Pb→Au = %d edges\n", delta(pb, au));
    printf("  lattice Pb→Hg = %d edges\n", delta(pb, hg));
    printf("  lattice Hg→Au = %d edges\n", delta(hg, au));
    printf("\n");
    printf("  proton diff Pb→Au = 3\n");
    printf("  proton diff Pb→Hg = 2\n");
    printf("  proton diff Hg→Au = 1\n");

    return 0;
}
