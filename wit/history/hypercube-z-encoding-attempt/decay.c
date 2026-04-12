/*
 * decay — predict the four axis decays for stable nuclei
 *
 * the lattice says each axis has a characteristic cluster:
 *   D (place 1)  → beta decay (single nucleon)
 *   C (place 3)  → Li-7 cluster
 *   B (place 9)  → F-19 cluster
 *   A (place 27) → Co-59 cluster
 *
 * compute Q values via the semi-empirical mass formula.
 * Q > 0 means energetically allowed.
 */
#include <stdio.h>
#include <stdlib.h>
#include <math.h>

/* SEMF coefficients (MeV) — Wapstra values */
#define A_VOL  15.8
#define A_SURF 18.3
#define A_COUL 0.714
#define A_ASYM 23.2
#define A_PAIR 12.0

/* binding energy of a nucleus with mass A, charge Z */
double semf(int A, int Z) {
    if (A <= 0 || Z <= 0 || Z > A) return 0;
    double dA = (double)A;
    double dZ = (double)Z;

    double vol  = A_VOL * dA;
    double surf = A_SURF * pow(dA, 2.0/3.0);
    double coul = A_COUL * dZ * (dZ - 1) / pow(dA, 1.0/3.0);
    double asym = A_ASYM * pow(dA - 2*dZ, 2) / dA;

    /* pairing term */
    double pair = 0;
    int N = A - Z;
    if (Z % 2 == 0 && N % 2 == 0) pair = +A_PAIR / sqrt(dA); /* even-even */
    else if (Z % 2 == 1 && N % 2 == 1) pair = -A_PAIR / sqrt(dA); /* odd-odd */
    /* else (odd A) pair = 0 */

    return vol - surf - coul - asym + pair;
}

/* Q value for cluster emission: parent → daughter + cluster */
double q_cluster(int Ap, int Zp, int Ac, int Zc) {
    int Ad = Ap - Ac;
    int Zd = Zp - Zc;
    if (Ad <= 0 || Zd <= 0) return -999;
    return semf(Ad, Zd) + semf(Ac, Zc) - semf(Ap, Zp);
}

/* most stable A for each Z (typical isotope) */
int stable_A[83] = {
    0,
    1,4,7,9,11,12,14,16,19,20,         /* H..Ne */
    23,24,27,28,31,32,35,40,            /* Na..Ar */
    39,40,45,48,51,52,55,56,59,58,63,64, /* K..Zn */
    69,74,75,80,79,84,                  /* Ga..Kr */
    85,88,89,90,93,96,98,102,103,106,107,114,115,120, /* Rb..Sn */
    121,130,127,132,133,138,139,140,141,142, /* Sb..Nd */
    145,152,153,158,159,164,165,166,169,174, /* Pm..Yb */
    175,180,181,184,187,192,193,195,197,202,205,208 /* Lu..Pb */
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
    /* sanity check: known binding energies */
    printf("── sanity check: SEMF vs experimental B/A ──\n");
    int test_z[] = {2, 6, 8, 26, 50, 82};
    int test_a[] = {4, 12, 16, 56, 120, 208};
    double exp_ba[] = {7.07, 7.68, 7.98, 8.79, 8.51, 7.87}; /* MeV per nucleon */
    for (int i = 0; i < 6; i++) {
        double b = semf(test_a[i], test_z[i]);
        double ba = b / test_a[i];
        printf("  %3s-%d  SEMF: %.2f MeV/A   exp: %.2f   diff: %+.2f\n",
               sym[test_z[i]], test_a[i], ba, exp_ba[i], ba - exp_ba[i]);
    }

    /* the four axis decays */
    int cluster_A[4] = {1,  7,  19, 59};  /* n/p, Li-7, F-19, Co-59 */
    int cluster_Z[4] = {0,  3,  9,  27};
    const char *cluster_name[4] = {"beta", "Li-7", "F-19", "Co-59"};
    const char *axis_name[4]    = {"D",    "C",    "B",    "A"};

    printf("\n── Q values for the four axis decays ──\n");
    printf("(positive = energetically allowed)\n\n");
    printf("  parent       D:beta    C:Li-7    B:F-19    A:Co-59\n");
    printf("  ──────       ──────    ──────    ──────    ───────\n");

    /* sample stable elements across the periodic table */
    int sample[] = {6, 16, 26, 50, 56, 74, 79, 82};
    int n_sample = sizeof(sample)/sizeof(sample[0]);

    for (int i = 0; i < n_sample; i++) {
        int z = sample[i];
        int a = stable_A[z];
        printf("  %-2s-%-3d", sym[z], a);
        for (int k = 0; k < 4; k++) {
            /* for beta, just compute mass-difference, not cluster */
            double q;
            if (k == 0) {
                /* beta-: n → p + e + ν, Z+1 same A */
                /* approximate: Q = B(A,Z+1) - B(A,Z) - 0.78 */
                q = semf(a, z+1) - semf(a, z) - 0.78;
            } else {
                q = q_cluster(a, z, cluster_A[k], cluster_Z[k]);
            }
            printf("  %+7.2f", q);
        }
        printf("\n");
    }

    /* now scan all stable elements for positive C-axis Q (Li-7 emission) */
    printf("\n── all stable nuclei: which allow C-axis (Li-7) decay? ──\n");
    int c_allowed = 0, b_allowed = 0, a_allowed = 0;
    int first_c = 0, first_b = 0, first_a = 0;
    for (int z = 7; z <= 82; z++) { /* need at least Li-cluster room */
        if (z == 43 || z == 61) continue;
        int a = stable_A[z];
        double qc = q_cluster(a, z, 7, 3);
        double qb = q_cluster(a, z, 19, 9);
        double qa = q_cluster(a, z, 59, 27);
        if (qc > 0) { c_allowed++; if (!first_c) first_c = z; }
        if (qb > 0) { b_allowed++; if (!first_b) first_b = z; }
        if (qa > 0) { a_allowed++; if (!first_a) first_a = z; }
    }
    printf("  C-axis (Li-7) allowed: %d nuclei, first at Z=%d %s\n",
           c_allowed, first_c, first_c ? sym[first_c] : "—");
    printf("  B-axis (F-19) allowed: %d nuclei, first at Z=%d %s\n",
           b_allowed, first_b, first_b ? sym[first_b] : "—");
    printf("  A-axis (Co-59) allowed: %d nuclei, first at Z=%d %s\n",
           a_allowed, first_a, first_a ? sym[first_a] : "—");

    /* the canonical case: Pb-208 → Au-201 + Li-7 */
    printf("\n── the canonical alchemy reaction ──\n");
    printf("  Pb-208 → Au-201 + Li-7  (C-axis edge: Pb → Au)\n");
    double q_pb_au = q_cluster(208, 82, 7, 3);
    printf("  Q = %.2f MeV   %s\n", q_pb_au,
           q_pb_au > 0 ? "ENERGETICALLY ALLOWED" : "forbidden");
    printf("\n  for comparison:\n");
    printf("  Pb-208 → Hg-204 + alpha (Z-2, sequential)\n");
    double q_alpha = q_cluster(208, 82, 4, 2);
    printf("  Q = %.2f MeV   %s\n", q_alpha,
           q_alpha > 0 ? "allowed" : "forbidden");

    /* B-axis case for heavy nucleus */
    printf("\n  Pb-208 → Ta-189 + F-19  (B-axis edge: Pb → Ta)\n");
    double q_pb_ta = q_cluster(208, 82, 19, 9);
    printf("  Q = %.2f MeV   %s\n", q_pb_ta,
           q_pb_ta > 0 ? "ENERGETICALLY ALLOWED" : "forbidden");

    printf("\n  Pb-208 → Cs-149 + Co-59  (A-axis edge: Pb → Cs)\n");
    double q_pb_cs = q_cluster(208, 82, 59, 27);
    printf("  Q = %.2f MeV   %s\n", q_pb_cs,
           q_pb_cs > 0 ? "ENERGETICALLY ALLOWED" : "forbidden");

    return 0;
}
