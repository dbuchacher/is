/*
 * generate the 80 stable elements table
 * sorted by stratum (zero-count) then by Z
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

int zeros(coord4 c) { return (c.a==0) + (c.b==0) + (c.c==0) + (c.d==0); }

const char *sym[] = {
    "??",
    "H","He","Li","Be","B","C","N","O","F","Ne",
    "Na","Mg","Al","Si","P","S","Cl","Ar",
    "K","Ca","Sc","Ti","V","Cr","Mn","Fe","Co","Ni","Cu","Zn",
    "Ga","Ge","As","Se","Br","Kr",
    "Rb","Sr","Y","Zr","Nb","Mo","Tc","Ru","Rh","Pd","Ag","Cd","In","Sn",
    "Sb","Te","I","Xe","Cs","Ba","La","Ce","Pr","Nd",
    "Pm","Sm","Eu","Gd","Tb","Dy","Ho","Er","Tm","Yb",
    "Lu","Hf","Ta","W","Re","Os","Ir","Pt","Au","Hg","Tl","Pb"
};

/* the hodos names for corners from points.md */
const char *corner_name(coord4 c) {
    if (c.a==-1 && c.b==-1 && c.c==-1 && c.d==-1) return "identity";
    if (c.a==-1 && c.b==-1 && c.c==-1 && c.d==+1) return "test";      /* Tc! */
    if (c.a==-1 && c.b==-1 && c.c==+1 && c.d==-1) return "drain";
    if (c.a==-1 && c.b==-1 && c.c==+1 && c.d==+1) return "take_while";
    if (c.a==-1 && c.b==+1 && c.c==-1 && c.d==-1) return "call";
    if (c.a==-1 && c.b==+1 && c.c==-1 && c.d==+1) return "maybe";     /* Pm! */
    if (c.a==-1 && c.b==+1 && c.c==+1 && c.d==-1) return "fix";
    if (c.a==-1 && c.b==+1 && c.c==+1 && c.d==+1) return "bind";
    if (c.a==+1 && c.b==-1 && c.c==-1 && c.d==-1) return "read";
    if (c.a==+1 && c.b==-1 && c.c==-1 && c.d==+1) return "filter";
    if (c.a==+1 && c.b==-1 && c.c==+1 && c.d==-1) return "copy";
    if (c.a==+1 && c.b==-1 && c.c==+1 && c.d==+1) return "scan";
    if (c.a==+1 && c.b==+1 && c.c==-1 && c.d==-1) return "fold";
    if (c.a==+1 && c.b==+1 && c.c==-1 && c.d==+1) return "map";
    if (c.a==+1 && c.b==+1 && c.c==+1 && c.d==-1) return "foldl";
    if (c.a==+1 && c.b==+1 && c.c==+1 && c.d==+1) return "hylo";
    return "?";
}

/* atom names for 3-zero points */
const char *atom_name(coord4 c) {
    if (c.a==+1) return "RISE";   if (c.a==-1) return "FALL";
    if (c.b==+1) return "GROW";   if (c.b==-1) return "SHRINK";
    if (c.c==+1) return "BLESS";  if (c.c==-1) return "CURSE";
    if (c.d==+1) return "BEGIN";  if (c.d==-1) return "END";
    return "?";
}

int main(void) {
    int stable[83];
    int n_stable = 0;
    for (int z = 1; z <= 82; z++) {
        if (z == 43 || z == 61) continue; /* Tc, Pm */
        stable[n_stable++] = z;
    }

    printf("# the 80 stable elements on the lattice\n");
    printf("#\n");
    printf("# Z → balanced ternary 4D coord (mod 3⁴ = 81)\n");
    printf("# grouped by stratum (zero-count)\n\n");

    /* print by stratum */
    const char *strat_names[] = {"corners (0 zeros) — 14 stable, 2 holes",
                                  "triads (1 zero)",
                                  "dyads (2 zeros)",
                                  "atoms (3 zeros)",
                                  "origin (4 zeros)"};

    for (int target_z = 0; target_z <= 4; target_z++) {
        int count = 0;
        for (int i = 0; i < n_stable; i++) {
            coord4 c = to_lattice(stable[i]);
            if (zeros(c) == target_z) count++;
        }
        printf("## %s — %d elements\n\n", strat_names[target_z], count);

        for (int i = 0; i < n_stable; i++) {
            int z = stable[i];
            coord4 c = to_lattice(z);
            if (zeros(c) != target_z) continue;

            if (target_z == 0) {
                printf("  %3d %-2s  (%+d,%+d,%+d,%+d)   %s\n",
                       z, sym[z], c.a, c.b, c.c, c.d, corner_name(c));
            } else if (target_z == 3) {
                printf("  %3d %-2s  (%+d,%+d,%+d,%+d)   %s\n",
                       z, sym[z], c.a, c.b, c.c, c.d, atom_name(c));
            } else {
                printf("  %3d %-2s  (%+d,%+d,%+d,%+d)\n",
                       z, sym[z], c.a, c.b, c.c, c.d);
            }
        }

        /* show the holes in corner stratum */
        if (target_z == 0) {
            printf("  --- HOLES ---\n");
            coord4 tc = to_lattice(43);
            coord4 pm = to_lattice(61);
            printf("   43 Tc  (%+d,%+d,%+d,%+d)   %s   ← UNSTABLE (A-,C-,D+)\n",
                   tc.a, tc.b, tc.c, tc.d, corner_name(tc));
            printf("   61 Pm  (%+d,%+d,%+d,%+d)   %s   ← UNSTABLE (A-,C-,D+)\n",
                   pm.a, pm.b, pm.c, pm.d, corner_name(pm));
        }
        printf("\n");
    }

    printf("## summary\n\n");
    printf("  80 stable elements = 81 lattice points - 1 (origin = Tl wraps)\n");
    printf("  14 corners + 32 triads + 24 dyads + 8 atoms + 1 origin = 79 + Tl(origin) = 80\n");
    printf("  + 2 corner holes (Tc, Pm) = 16 corners total = 2⁴ ✓\n");

    return 0;
}
