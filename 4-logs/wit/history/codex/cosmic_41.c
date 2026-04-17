/* What is 41? Check structural readings. */
#include <stdio.h>

int main(void) {
    printf("=== What is 41? ===\n\n");
    printf("41 = prime\n");
    printf("82 = 2 × 41 = atomic number of lead (Pb)\n");
    printf("82 = stability ceiling (heaviest stable element)\n");
    printf("82 = nuclear magic number (proton shell closure)\n");
    printf("80 = 3^4 - 1 = shell-1 lattice points = stable elements\n");
    printf("82 = 80 + 2 (Tc, Pm holes) = total elements up to Pb\n\n");

    printf("So 41 = 82/2 = stability ceiling / double cover\n");
    printf("(fermion 720° return: go around 41 slots, pick up -1 phase,\n");
    printf(" go around 41 more = 82, back to +1. SU(2) double cover.)\n\n");

    printf("R = 2: one reader per sheet of the double cover\n");
    printf("2F + P = 24 = 4! = uniliterals = atom alphabet\n\n");

    /* Now: what about C=81 = 3^4? */
    printf("=== C=81 alternative ===\n\n");

    int C = 81, R = 4, P = 8, F = 20;
    /* vis = R/C = 4/81 */
    /* dm = (2F+P-R)/(2C) = (40+8-4)/162 = 44/162 = 22/81 */
    /* de = 1 - 4/81 - 22/81 = 55/81 */
    printf("C=81=3^4  R=4=dims  P=8=atoms  F=20=C(6,3)=Riemann\n");
    printf("vis = 4/81 = %.3f%%\n", 100.0*4/81);
    printf("dm  = 22/81 = %.3f%%\n", 100.0*22/81);
    printf("de  = 55/81 = %.3f%%\n", 100.0*55/81);
    printf("In units of 81:  visible=4  dark=22  empty=55\n");
    printf("4 + 22 + 55 = %d\n", 4+22+55);
    printf("Euclidean from Planck: ");
    double d1 = 68.3 - 100.0*55/81;
    double d2 = 26.8 - 100.0*22/81;
    double d3 = 4.9 - 100.0*4/81;
    printf("%.3f pp\n\n", __builtin_sqrt(d1*d1+d2*d2+d3*d3));

    /* Both candidates side by side */
    printf("=== Comparison ===\n\n");
    printf("                        Planck 2018    C=41,R=2      C=81,R=4,P=8,F=20\n");
    printf("dark energy             68.300%%        68.293%%       67.901%%\n");
    printf("dark matter             26.800%%        26.829%%       27.160%%\n");
    printf("visible                  4.900%%         4.878%%        4.938%%\n");
    printf("distance                 —              0.037 pp      0.540 pp\n");
    printf("structural anchor       measured        82/2 + 4!     3^4 + dims + atoms + C(6,3)\n");
    printf("free parameters          —              0 (if 82/2)   0\n\n");

    /* The ratio as pure fractions */
    printf("=== As exact fractions ===\n\n");

    printf("C=41 model (with 2F+P=24):\n");
    printf("  vis = 2/41\n");
    printf("  dm  = 22/82 = 11/41\n");
    printf("  de  = 56/82 = 28/41\n");
    printf("  ratio = 28 : 11 : 2  (sum = 41)\n\n");

    printf("C=81 model:\n");
    printf("  vis = 4/81\n");
    printf("  dm  = 22/81\n");
    printf("  de  = 55/81\n");
    printf("  ratio = 55 : 22 : 4  (sum = 81)\n\n");

    /* verify the 41 fractions */
    printf("Verify C=41: 2/41 + 11/41 + 28/41 = %d/41\n", 2+11+28);
    printf("Verify C=81: 4/81 + 22/81 + 55/81 = %d/81\n", 4+22+55);

    return 0;
}
