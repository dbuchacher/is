/*
 * cosmic_split.c — discrete-substrate cosmic split derivation
 *
 * No floats in the physics. No continuous formulas. No Michaelis-Menten.
 * No Q factor. No damped oscillator. Just integer counting.
 *
 * Model:
 *   Ring buffer with C_total integer slots.
 *   F slots are permanently occupied (proton stability / Post's 3 gates).
 *   P producers burst-write simultaneously every P/R ticks.
 *   R consumers each read 1 record per tick.
 *   Ring oscillates between empty and full in the transient region.
 *
 * At each tick, measure:
 *   visible     = records being read right now (= R, if available)
 *   dark_matter = filled slots NOT being read  (= total_fill - visible)
 *   dark_energy = empty slots                  (= C_total - total_fill)
 *
 * The time-averaged ratios over one complete burst-drain cycle
 * have a closed-form from pure integer arithmetic:
 *
 *   visible     = R / C
 *   dark_matter = (2F + P - R) / (2C)
 *   dark_energy = (2C - R - 2F - P) / (2C)
 *
 * Every input is an integer. The formula is exact rational arithmetic.
 * No approximation. No continuous limit. No calculus.
 *
 * We sweep structural candidates and find which integer triples
 * (C, P, F) with consumer count R land closest to Planck 2018
 * measurements (68.3% / 26.8% / 4.9%).
 */

#include <stdio.h>
#include <stdlib.h>
#include <math.h>

typedef struct {
    int C, P, R, F;
    double de, dm, vis, dist;
} Result;

int cmp(const void *a, const void *b) {
    double da = ((Result*)a)->dist;
    double db = ((Result*)b)->dist;
    return (da > db) - (da < db);
}

int main(void) {
    /* Planck 2018 targets */
    double tgt_de = 68.3, tgt_dm = 26.8, tgt_vis = 4.9;

    static Result results[200000];
    int n = 0;

    for (int R = 1; R <= 6; R++) {
        /* visible = R/C ≈ 4.9%, so C ≈ R/0.049 ≈ R × 20.4 */
        /* allow vis within ±3% of target */
        int C_lo = (int)(100.0 * R / 7.9);  /* vis < 7.9% */
        int C_hi = (int)(100.0 * R / 1.9) + 1; /* vis > 1.9% */
        if (C_lo < R + 2) C_lo = R + 2;
        if (C_hi > 300) C_hi = 300;

        for (int C = C_lo; C <= C_hi; C++) {
            double vis = 100.0 * R / C;

            for (int P = R + 1; P <= C; P++) {
                if (P % R != 0) continue; /* period must be integer */

                for (int F = 0; F <= C - P; F++) {
                    int num = 2*F + P - R;
                    if (num < 0) continue;

                    double dm = 100.0 * num / (2.0 * C);
                    double de = 100.0 - vis - dm;
                    if (de < 0) continue;

                    double d = sqrt((de-tgt_de)*(de-tgt_de) +
                                    (dm-tgt_dm)*(dm-tgt_dm) +
                                    (vis-tgt_vis)*(vis-tgt_vis));

                    if (d < 2.0 && n < 200000) {
                        results[n++] = (Result){C, P, R, F, de, dm, vis, d};
                    }
                }
            }
        }
    }

    /* sort by distance */
    qsort(results, n, sizeof(Result), cmp);

    /* header */
    printf("Pure integer ring-buffer cosmic split\n");
    printf("Model: C slots, F permanent, P burst-producers, R consumers\n");
    printf("Formula: vis=R/C, dm=(2F+P-R)/(2C), de=1-vis-dm\n");
    printf("Target: Planck 2018 = 68.3%% / 26.8%% / 4.9%%\n\n");

    printf("rank  C    P   R   F  |  dark_e%%     dark_m%%     vis%%      | dist    | notes\n");
    printf("────  ───  ──  ──  ──  |  ────────    ────────    ───────   | ─────── | ─────\n");

    int show = n < 50 ? n : 50;
    for (int i = 0; i < show; i++) {
        Result r = results[i];

        /* flag structural constants */
        const char *note = "";
        if (r.C == 20 && r.F == 3) note = "C=C(6,3) F=gates";
        else if (r.C == 24 && r.P == 8 && r.F == 3) note = "C=4! P=atoms F=gates";
        else if (r.C == 24 && r.F == 3) note = "C=4! F=gates";
        else if (r.C == 20 && r.P == 6) note = "C=C(6,3) P=C(4,2)";
        else if (r.C == 80 && r.F == 3) note = "C=shell1 F=gates";
        else if (r.C == 81 && r.F == 3) note = "C=3^4 F=gates";
        else if (r.C == 16 && r.F == 3) note = "C=2^4 F=gates";
        else if (r.C == 32 && r.F == 3) note = "C=bonds F=gates";
        else if (r.P == 8) note = "P=atoms";
        else if (r.P == 6 && r.F == 3) note = "P=C(4,2) F=gates";
        else if (r.F == 3) note = "F=gates";
        else if (r.F == 4) note = "F=dims";

        printf("%3d   %3d  %2d  %2d  %2d  |  %7.3f%%    %7.3f%%    %5.3f%%   | %.4f  | %s\n",
               i+1, r.C, r.P, r.R, r.F, r.de, r.dm, r.vis, r.dist, note);
    }

    printf("\nTotal matches within 2 pp: %d\n", n);

    /* Now print ONLY results where ALL parameters are lattice structural constants */
    printf("\n\n=== STRUCTURAL HITS ONLY ===\n");
    printf("(C, P, F all anchored in lattice constants)\n\n");

    /* structural C values */
    int struct_C[] = {8,9,10,12,13,16,20,24,27,32,40,48,64,80,81,96};
    int nsc = 16;
    /* structural P values */
    int struct_P[] = {3,4,5,6,8,9,10,12,16};
    int nsp = 9;
    /* structural F values */
    int struct_F[] = {0,1,3,4,8};
    int nsf = 5;

    printf("rank  C    P   R   F  |  dark_e%%     dark_m%%     vis%%      | dist    | reading\n");
    printf("────  ───  ──  ──  ──  |  ────────    ────────    ───────   | ─────── | ───────\n");

    int rank = 0;
    for (int i = 0; i < n && rank < 30; i++) {
        Result r = results[i];
        int c_ok = 0, p_ok = 0, f_ok = 0;
        for (int j = 0; j < nsc; j++) if (r.C == struct_C[j]) c_ok = 1;
        for (int j = 0; j < nsp; j++) if (r.P == struct_P[j]) p_ok = 1;
        for (int j = 0; j < nsf; j++) if (r.F == struct_F[j]) f_ok = 1;

        if (c_ok && p_ok && f_ok) {
            const char *reading = "?";
            if (r.C==20 && r.P==6 && r.F==3) reading = "C(6,3) C(4,2) gates";
            else if (r.C==24 && r.P==8 && r.F==3) reading = "4! atoms gates";
            else if (r.C==24 && r.P==6 && r.F==3) reading = "4! C(4,2) gates";
            else if (r.C==20 && r.P==8 && r.F==3) reading = "C(6,3) atoms gates";
            else if (r.C==40 && r.P==12 && r.F==3) reading = "5*atoms C(4,3) gates";
            else if (r.C==80 && r.P==8) reading = "shell1 atoms";
            else if (r.C==81 && r.P==8) reading = "3^4 atoms";
            else if (r.C==48 && r.P==8 && r.F==3) reading = "2*4! atoms gates";
            else if (r.C==20 && r.P==4 && r.F==4) reading = "C(6,3) dims dims";
            else if (r.C==24 && r.P==10 && r.F==3) reading = "4! 10 gates";
            else if (r.C==24 && r.P==4 && r.F==3) reading = "4! dims gates";
            else if (r.C==32 && r.P==8 && r.F==3) reading = "bonds atoms gates";

            printf("%3d   %3d  %2d  %2d  %2d  |  %7.3f%%    %7.3f%%    %5.3f%%   | %.4f  | %s\n",
                   ++rank, r.C, r.P, r.R, r.F, r.de, r.dm, r.vis, r.dist, reading);
        }
    }

    return 0;
}
