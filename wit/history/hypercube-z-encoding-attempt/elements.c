/*
 * elements on the lattice
 *
 * map atomic number Z to 4D balanced-ternary coords
 * look at the three walls (Be bottleneck, Fe peak, Bi limit)
 * look at the two holes (Tc=43, Pm=61)
 * look for patterns in stability
 */
#include <stdio.h>
#include <stdlib.h>

typedef struct { int a, b, c, d; } coord4;

/* balanced ternary: each digit in {-1, 0, +1} */
coord4 to_lattice(int n) {
    coord4 c;
    int v = n;
    int r;
    r = ((v % 3) + 3) % 3; if (r == 2) r = -1; c.d = r; v = (v - r) / 3;
    r = ((v % 3) + 3) % 3; if (r == 2) r = -1; c.c = r; v = (v - r) / 3;
    r = ((v % 3) + 3) % 3; if (r == 2) r = -1; c.b = r; v = (v - r) / 3;
    r = ((v % 3) + 3) % 3; if (r == 2) r = -1; c.a = r; v = (v - r) / 3;
    return c;
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

int l1_norm(coord4 c) {
    return abs(c.a) + abs(c.b) + abs(c.c) + abs(c.d);
}

/* element symbols */
const char *sym[] = {
    "??",
    "H","He","Li","Be","B","C","N","O","F","Ne",           /* 1-10 */
    "Na","Mg","Al","Si","P","S","Cl","Ar",                  /* 11-18 */
    "K","Ca","Sc","Ti","V","Cr","Mn","Fe","Co","Ni","Cu","Zn", /* 19-30 */
    "Ga","Ge","As","Se","Br","Kr",                          /* 31-36 */
    "Rb","Sr","Y","Zr","Nb","Mo","Tc","Rh",                 /* 37-44 */
    "Ru","Pd","Ag","Cd","In","Sn","Sb","Te","I","Xe",       /* 45-54 */
    "Cs","Ba","La","Ce","Pr","Nd","Pm","Sm","Eu","Gd",      /* 55-64 */
    "Tb","Dy","Ho","Er","Tm","Yb","Lu","Hf","Ta","W",       /* 65-74 */
    "Re","Os","Ir","Pt","Au","Hg","Tl","Pb","Bi",           /* 75-83 */
};
#define NUM_ELEM 83

/* unstable (no stable isotope): Tc=43, Pm=61 */
int is_unstable(int z) { return z == 43 || z == 61; }

/* walls */
int is_wall(int z) { return z == 4 || z == 26 || z == 83; }

int main(void) {
    printf("  Z  sym  coord             zeros  shell  L1  stratum     notes\n");
    printf("───  ───  ─────             ─────  ─────  ──  ───────     ─────\n");

    int strat_count[5] = {0};

    for (int z = 1; z <= NUM_ELEM; z++) {
        coord4 c = to_lattice(z);
        int z0 = zeros(c);
        int s = shell(c);
        int l1 = l1_norm(c);

        const char *strat = z0==4 ? "origin" : z0==3 ? "atom" :
                            z0==2 ? "dyad" : z0==1 ? "triad" : "corner";

        strat_count[z0]++;

        char notes[64] = "";
        if (is_unstable(z)) snprintf(notes, sizeof(notes), "UNSTABLE");
        if (is_wall(z)) snprintf(notes, sizeof(notes), "WALL");
        if (z == 1) snprintf(notes, sizeof(notes), "first element");
        if (z == 26) snprintf(notes, sizeof(notes), "WALL (iron peak)");
        if (z == 4) snprintf(notes, sizeof(notes), "WALL (Be bottleneck)");
        if (z == 83) snprintf(notes, sizeof(notes), "WALL (Bi limit)");

        printf("%3d  %-2s   (%+d,%+d,%+d,%+d)   %d      %d      %d   %-8s    %s\n",
               z, sym[z], c.a, c.b, c.c, c.d, z0, s, l1, strat, notes);
    }

    printf("\n── elements per stratum ──\n");
    const char *names[] = {"corner","triad","dyad","atom","origin"};
    for (int z0 = 4; z0 >= 0; z0--) {
        printf("  %s (zeros=%d): %d elements\n", names[z0], z0, strat_count[z0]);
    }

    /* check Tc and Pm coords */
    printf("\n── the two holes ──\n");
    coord4 tc = to_lattice(43);
    coord4 pm = to_lattice(61);
    printf("  Tc (Z=43): (%+d,%+d,%+d,%+d)  zeros=%d shell=%d L1=%d\n",
           tc.a, tc.b, tc.c, tc.d, zeros(tc), shell(tc), l1_norm(tc));
    printf("  Pm (Z=61): (%+d,%+d,%+d,%+d)  zeros=%d shell=%d L1=%d\n",
           pm.a, pm.b, pm.c, pm.d, zeros(pm), shell(pm), l1_norm(pm));

    /* check the three walls */
    printf("\n── the three walls ──\n");
    coord4 be = to_lattice(4);
    coord4 fe = to_lattice(26);
    coord4 bi = to_lattice(83);
    printf("  Be (Z=4):  (%+d,%+d,%+d,%+d)  zeros=%d shell=%d L1=%d\n",
           be.a, be.b, be.c, be.d, zeros(be), shell(be), l1_norm(be));
    printf("  Fe (Z=26): (%+d,%+d,%+d,%+d)  zeros=%d shell=%d L1=%d\n",
           fe.a, fe.b, fe.c, fe.d, zeros(fe), shell(fe), l1_norm(fe));
    printf("  Bi (Z=83): (%+d,%+d,%+d,%+d)  zeros=%d shell=%d L1=%d\n",
           bi.a, bi.b, bi.c, bi.d, zeros(bi), shell(bi), l1_norm(bi));

    /* parity patterns */
    printf("\n── sign patterns of stable vs unstable ──\n");
    printf("  looking at axis signs for Tc neighbors...\n");
    for (int z = 41; z <= 45; z++) {
        coord4 c = to_lattice(z);
        int pos = (c.a > 0) + (c.b > 0) + (c.c > 0) + (c.d > 0);
        int neg = (c.a < 0) + (c.b < 0) + (c.c < 0) + (c.d < 0);
        printf("    Z=%d %-2s (%+d,%+d,%+d,%+d) pos=%d neg=%d zero=%d %s\n",
               z, sym[z], c.a, c.b, c.c, c.d, pos, neg, zeros(c),
               is_unstable(z) ? "UNSTABLE" : "stable");
    }
    printf("  looking at axis signs for Pm neighbors...\n");
    for (int z = 59; z <= 63; z++) {
        coord4 c = to_lattice(z);
        int pos = (c.a > 0) + (c.b > 0) + (c.c > 0) + (c.d > 0);
        int neg = (c.a < 0) + (c.b < 0) + (c.c < 0) + (c.d < 0);
        printf("    Z=%d %-2s (%+d,%+d,%+d,%+d) pos=%d neg=%d zero=%d %s\n",
               z, sym[z], c.a, c.b, c.c, c.d, pos, neg, zeros(c),
               is_unstable(z) ? "UNSTABLE" : "stable");
    }

    return 0;
}
