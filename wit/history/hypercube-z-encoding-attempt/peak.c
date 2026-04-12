/*
 * peak — does the iron peak sit at 3³?
 *
 * compute SEMF B/A for every stable Z along its stable A.
 * find the maximum. check values at place values (1, 3, 9, 27, 81).
 * look for features at walls (4, 26, 83) and holes (43, 61).
 */
#include <stdio.h>
#include <stdlib.h>
#include <math.h>

#define A_VOL  15.8
#define A_SURF 18.3
#define A_COUL 0.714
#define A_ASYM 23.2
#define A_PAIR 12.0

double semf(int A, int Z) {
    if (A <= 0 || Z <= 0 || Z > A) return 0;
    double dA = (double)A, dZ = (double)Z;
    double vol  = A_VOL * dA;
    double surf = A_SURF * pow(dA, 2.0/3.0);
    double coul = A_COUL * dZ * (dZ - 1) / pow(dA, 1.0/3.0);
    double asym = A_ASYM * pow(dA - 2*dZ, 2) / dA;
    double pair = 0;
    int N = A - Z;
    if (Z % 2 == 0 && N % 2 == 0) pair = +A_PAIR / sqrt(dA);
    else if (Z % 2 == 1 && N % 2 == 1) pair = -A_PAIR / sqrt(dA);
    return vol - surf - coul - asym + pair;
}

/* find the A that maximizes B/A for given Z (the "stable" isotope) */
int best_A(int Z) {
    int best = 0;
    double best_ba = -1e9;
    for (int A = Z; A <= 3 * Z + 10; A++) {
        double ba = semf(A, Z) / A;
        if (ba > best_ba) { best_ba = ba; best = A; }
    }
    return best;
}

int stable_A[83] = {
    0, 1,4,7,9,11,12,14,16,19,20,
    23,24,27,28,31,32,35,40,
    39,40,45,48,51,52,55,56,59,58,63,64,
    69,74,75,80,79,84,
    85,88,89,90,93,96,98,102,103,106,107,114,115,120,
    121,130,127,132,133,138,139,140,141,142,
    145,152,153,158,159,164,165,166,169,174,
    175,180,181,184,187,192,193,195,197,202,205,208
};

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
    /* scan all elements, record B/A */
    double ba[83];
    for (int z = 1; z <= 82; z++) {
        int A = stable_A[z];
        ba[z] = semf(A, z) / A;
    }

    /* find the peak */
    int peak_z = 0;
    double peak_ba = -1e9;
    for (int z = 1; z <= 82; z++) {
        if (z == 43 || z == 61) continue;
        if (ba[z] > peak_ba) { peak_ba = ba[z]; peak_z = z; }
    }
    printf("── the SEMF binding-energy peak ──\n");
    printf("  max B/A = %.4f MeV at Z=%d %s\n\n", peak_ba, peak_z, sym[peak_z]);

    /* top 5 */
    printf("  top 5 B/A:\n");
    for (int i = 0; i < 5; i++) {
        int best = 0;
        double best_ba = -1e9;
        for (int z = 1; z <= 82; z++) {
            if (z == 43 || z == 61) continue;
            int taken = 0;
            for (int j = 0; j < i; j++) if (z == 0) { taken = 1; break; }
            if (ba[z] > best_ba) { best_ba = ba[z]; best = z; }
        }
        printf("    %2d %-2s  B/A = %.4f\n", best, sym[best], best_ba);
        ba[best] = -1e9; /* remove */
    }

    /* recompute (we stomped on ba) */
    for (int z = 1; z <= 82; z++) ba[z] = semf(stable_A[z], z) / stable_A[z];

    printf("\n── B/A at balanced-ternary place values ──\n");
    int places[] = {1, 3, 9, 27, 81};
    const char *place_names[] = {"D axis", "C axis", "B axis", "A axis", "4-digit limit"};
    for (int i = 0; i < 5; i++) {
        int z = places[i];
        if (z > 82) continue;
        printf("  Z=%-2d %s (%2s): B/A = %.4f MeV   %s\n",
               z, sym[z], sym[z], ba[z], place_names[i]);
    }

    printf("\n── B/A around the iron peak ──\n");
    for (int z = 20; z <= 32; z++) {
        printf("  Z=%-2d %-2s  B/A = %.4f %s\n",
               z, sym[z], ba[z],
               z == 26 ? "← Fe (empirical max)" :
               z == 27 ? "← Co (lattice A-axis)" :
               z == 28 ? "← Ni" : "");
    }

    printf("\n── B/A at the three walls ──\n");
    int walls[] = {4, 26, 83};
    const char *wall_names[] = {"Be bottleneck", "Fe peak", "Bi limit"};
    for (int i = 0; i < 3; i++) {
        int z = walls[i];
        if (z > 82) continue;
        printf("  Z=%-2d %-2s  B/A = %.4f   %s\n",
               z, sym[z], ba[z], wall_names[i]);
    }

    printf("\n── B/A at the two holes ──\n");
    int holes[] = {43, 61};
    for (int i = 0; i < 2; i++) {
        int z = holes[i];
        int A = stable_A[z];
        double tc_ba = semf(A, z) / A;
        printf("  Z=%-2d %-2s  B/A = %.4f   (unstable)\n",
               z, sym[z], tc_ba);
    }

    /* discrete derivative: look for features */
    printf("\n── discrete derivative d(B/A)/dZ — where does binding change fastest? ──\n");
    for (int z = 2; z <= 82; z++) ba[z] = semf(stable_A[z], z) / stable_A[z];
    printf("  (only showing |diff| > 0.05 MeV)\n");
    for (int z = 2; z <= 82; z++) {
        double diff = ba[z] - ba[z-1];
        if (fabs(diff) > 0.05) {
            printf("  Z=%-2d %-2s → Z=%-2d %-2s  Δ = %+.4f\n",
                   z-1, sym[z-1], z, sym[z], diff);
        }
    }

    /* the sharpest test: is Z=27 a local max, local min, or nothing? */
    printf("\n── Z=27 (Co) local analysis ──\n");
    printf("  B/A(Z=25 Mn)  = %.4f\n", semf(stable_A[25], 25) / stable_A[25]);
    printf("  B/A(Z=26 Fe)  = %.4f   ← neighbor\n", semf(stable_A[26], 26) / stable_A[26]);
    printf("  B/A(Z=27 Co)  = %.4f   ← 3³\n", semf(stable_A[27], 27) / stable_A[27]);
    printf("  B/A(Z=28 Ni)  = %.4f   ← neighbor\n", semf(stable_A[28], 28) / stable_A[28]);
    printf("  B/A(Z=29 Cu)  = %.4f\n", semf(stable_A[29], 29) / stable_A[29]);

    /* is B/A at Z=27 local max? */
    double b25 = semf(stable_A[25], 25) / stable_A[25];
    double b26 = semf(stable_A[26], 26) / stable_A[26];
    double b27 = semf(stable_A[27], 27) / stable_A[27];
    double b28 = semf(stable_A[28], 28) / stable_A[28];
    double b29 = semf(stable_A[29], 29) / stable_A[29];

    printf("\n  Co is %s its immediate neighbors\n",
           (b27 > b26 && b27 > b28) ? "a LOCAL MAXIMUM among" :
           (b27 < b26 && b27 < b28) ? "a LOCAL MINIMUM among" : "NOT a local extremum among");

    printf("\n  distance from SEMF peak (Z=%d) to A-axis quantum (Z=27): %d\n",
           peak_z, abs(peak_z - 27));

    return 0;
}
