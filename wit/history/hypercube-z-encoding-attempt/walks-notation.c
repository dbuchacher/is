/*
 * walks-notation — write each element as a verb composition
 *
 * each element's coord has an L1 length. each nonzero axis
 * contributes one atom verb. canonical order A → B → C → D.
 */
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

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

int zeros(coord4 c) { return (c.a==0)+(c.b==0)+(c.c==0)+(c.d==0); }
int l1(coord4 c) { return abs(c.a)+abs(c.b)+abs(c.c)+abs(c.d); }

void write_walk(coord4 c, char *out) {
    out[0] = 0;
    int first = 1;
    const char *sep = " ";
    if (c.a == +1) { sprintf(out + strlen(out), "%s%s", first?"":sep, "RISE");   first = 0; }
    if (c.a == -1) { sprintf(out + strlen(out), "%s%s", first?"":sep, "FALL");   first = 0; }
    if (c.b == +1) { sprintf(out + strlen(out), "%s%s", first?"":sep, "GROW");   first = 0; }
    if (c.b == -1) { sprintf(out + strlen(out), "%s%s", first?"":sep, "SHRINK"); first = 0; }
    if (c.c == +1) { sprintf(out + strlen(out), "%s%s", first?"":sep, "BLESS");  first = 0; }
    if (c.c == -1) { sprintf(out + strlen(out), "%s%s", first?"":sep, "CURSE");  first = 0; }
    if (c.d == +1) { sprintf(out + strlen(out), "%s%s", first?"":sep, "BEGIN");  first = 0; }
    if (c.d == -1) { sprintf(out + strlen(out), "%s%s", first?"":sep, "END");    first = 0; }
    if (first) sprintf(out, "•");
}

/* the 16 named edges from origin to corners (from edges.md) */
const char *corner_edge(coord4 c) {
    if (c.a==-1 && c.b==-1 && c.c==-1 && c.d==-1) return "identity";
    if (c.a==-1 && c.b==-1 && c.c==-1 && c.d==+1) return "test";
    if (c.a==-1 && c.b==-1 && c.c==+1 && c.d==-1) return "drain";
    if (c.a==-1 && c.b==-1 && c.c==+1 && c.d==+1) return "take_while";
    if (c.a==-1 && c.b==+1 && c.c==-1 && c.d==-1) return "call";
    if (c.a==-1 && c.b==+1 && c.c==-1 && c.d==+1) return "maybe";
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

const char *sym[] = {
    "??","H","He","Li","Be","B","C","N","O","F","Ne",
    "Na","Mg","Al","Si","P","S","Cl","Ar",
    "K","Ca","Sc","Ti","V","Cr","Mn","Fe","Co","Ni","Cu","Zn",
    "Ga","Ge","As","Se","Br","Kr",
    "Rb","Sr","Y","Zr","Nb","Mo","Tc","Ru","Rh","Pd","Ag","Cd","In","Sn",
    "Sb","Te","I","Xe","Cs","Ba","La","Ce","Pr","Nd",
    "Pm","Sm","Eu","Gd","Tb","Dy","Ho","Er","Tm","Yb",
    "Lu","Hf","Ta","W","Re","Os","Ir","Pt","Au","Hg","Tl","Pb","Bi"
};

int is_unstable(int z) { return z == 43 || z == 61; }

int main(void) {
    char buf[128];

    printf("# the 80 stable elements — as walks\n\n");
    printf("each element is a POINT in the 4D ternary lattice,\n");
    printf("reached from the origin by a WALK of 1-4 edges.\n\n");

    printf("## the 8 axis-direction edges\n\n");
    printf("there are 8 unit edges, one per axis direction.\n");
    printf("each is named for the atom POINT it reaches from origin.\n\n");
    printf("an edge is a DISPLACEMENT (translation-invariant). the +A\n");
    printf("edge always means \"+1 on the A axis\", regardless of where\n");
    printf("you apply it. when applied from origin, the displacement\n");
    printf("vector equals the destination point — that's why the same\n");
    printf("(±1,0,0,0)-style tuples show up below.\n\n");
    printf("  edge    axis  destination from origin    element\n");
    printf("  ────    ────  ──────────────────────     ───────\n");
    printf("  RISE    +A    (+1, 0, 0, 0)              Z=27 Co\n");
    printf("  FALL    -A    (-1, 0, 0, 0)              Z=54 Xe\n");
    printf("  GROW    +B    ( 0,+1, 0, 0)              Z= 9 F\n");
    printf("  SHRINK  -B    ( 0,-1, 0, 0)              Z=72 Hf\n");
    printf("  BLESS   +C    ( 0, 0,+1, 0)              Z= 3 Li\n");
    printf("  CURSE   -C    ( 0, 0,-1, 0)              Z=78 Pt\n");
    printf("  BEGIN   +D    ( 0, 0, 0,+1)              Z= 1 H\n");
    printf("  END     -D    ( 0, 0, 0,-1)              Z=80 Hg\n\n");

    printf("a walk to any other element COMPOSES distinct edges,\n");
    printf("one per nonzero axis. since coords are in {-1,0,+1}, no\n");
    printf("axis is used twice. verbs commute (independent axes).\n\n");

    printf("notation: walks are written as a sequence of edge names\n");
    printf("with no separator. each name above is itself a distinct\n");
    printf("named edge. `BLESS END` means edge BLESS then edge END.\n");
    printf("there is no compose operator — the names are the edges.\n");
    printf("order is canonical A → B → C → D.\n\n");

    /* origin */
    printf("## origin (0 edges)\n\n");
    printf("  Z   sym  point             walk\n");
    printf("  ──  ───  ─────             ────\n");
    coord4 zero = {0,0,0,0};
    printf("  81  Tl   ( 0, 0, 0, 0)     • (the container)\n\n");

    /* atoms */
    printf("## atoms (1 edge) — the 8 single-edge points\n\n");
    printf("  Z   sym  point             walk\n");
    printf("  ──  ───  ─────             ────\n");
    for (int z = 1; z <= 82; z++) {
        if (is_unstable(z)) continue;
        coord4 c = to_lattice(z);
        if (l1(c) != 1) continue;
        write_walk(c, buf);
        printf("  %2d  %-2s   (%+2d,%+2d,%+2d,%+2d)     %s\n",
               z, sym[z], c.a, c.b, c.c, c.d, buf);
    }
    printf("\n");

    /* dyads */
    printf("## dyads (2 edges) — 24 two-edge compositions\n\n");
    printf("  Z   sym  point             walk\n");
    printf("  ──  ───  ─────             ────\n");
    for (int z = 1; z <= 82; z++) {
        if (is_unstable(z)) continue;
        coord4 c = to_lattice(z);
        if (l1(c) != 2) continue;
        write_walk(c, buf);
        printf("  %2d  %-2s   (%+2d,%+2d,%+2d,%+2d)     %s\n",
               z, sym[z], c.a, c.b, c.c, c.d, buf);
    }
    printf("\n");

    /* triads */
    printf("## triads (3 edges) — 32 three-edge compositions\n\n");
    printf("  Z   sym  point             walk\n");
    printf("  ──  ───  ─────             ────\n");
    for (int z = 1; z <= 82; z++) {
        if (is_unstable(z)) continue;
        coord4 c = to_lattice(z);
        if (l1(c) != 3) continue;
        write_walk(c, buf);
        printf("  %2d  %-2s   (%+2d,%+2d,%+2d,%+2d)     %s\n",
               z, sym[z], c.a, c.b, c.c, c.d, buf);
    }
    printf("\n");

    /* corners */
    printf("## corners (4 edges) — 14 four-edge compositions\n\n");
    printf("each corner has TWO names: the FP edge name (single word,\n");
    printf("from edges.md) and the verb composition (4 atom verbs).\n");
    printf("the FP name names the EDGE from origin → corner directly.\n\n");
    printf("  Z   sym  point             FP edge       verb composition\n");
    printf("  ──  ───  ─────             ───────       ────────────────\n");
    for (int z = 1; z <= 82; z++) {
        if (is_unstable(z)) continue;
        coord4 c = to_lattice(z);
        if (l1(c) != 4) continue;
        write_walk(c, buf);
        printf("  %2d  %-2s   (%+2d,%+2d,%+2d,%+2d)     %-12s  %s\n",
               z, sym[z], c.a, c.b, c.c, c.d, corner_edge(c), buf);
    }
    printf("\n");

    /* the alchemy pair */
    printf("## the alchemy pair\n\n");
    coord4 au = to_lattice(79);
    coord4 pb = to_lattice(82);
    char buf_au[128], buf_pb[128];
    write_walk(au, buf_au);
    write_walk(pb, buf_pb);
    printf("  79 Au   %s\n", buf_au);
    printf("  82 Pb   %s    (wraps to H coord, shell 1)\n\n", buf_pb);
    printf("  Pb → Au = apply CURSE\n\n");

    /* the two holes */
    printf("## the two holes — both named uncertainty operators\n\n");
    coord4 tc = to_lattice(43);
    coord4 pm = to_lattice(61);
    char buf_tc[128], buf_pm[128];
    write_walk(tc, buf_tc);
    write_walk(pm, buf_pm);
    printf("  43 Tc   FP edge: %-10s   verb walk: %s\n", corner_edge(tc), buf_tc);
    printf("  61 Pm   FP edge: %-10s   verb walk: %s\n\n", corner_edge(pm), buf_pm);
    printf("  the two elements with NO stable isotopes have FP edge\n");
    printf("  names that are the two FP combinators expressing\n");
    printf("  UNCERTAINTY: test (verify, may fail) and maybe (optional,\n");
    printf("  may not exist). the lattice literally calls them\n");
    printf("  by names that mean \"uncertain\" or \"conditional\".\n\n");
    printf("  shared verb signature: FALL + CURSE + BEGIN.\n");
    printf("  only the substance verb differs (SHRINK vs GROW).\n\n");

    /* the walls */
    printf("## the three walls\n\n");
    int walls[] = {4, 26, 83};
    const char *wall_labels[] = {"Be bottleneck","Fe peak","Bi limit"};
    for (int i = 0; i < 3; i++) {
        coord4 c = to_lattice(walls[i]);
        write_walk(c, buf);
        printf("  %3d %-2s  %-30s  %s\n", walls[i], sym[walls[i]], buf, wall_labels[i]);
    }
    printf("\n");

    /* the 4 atom pairs */
    printf("## the 4 atom pairs (lattice antipodes)\n\n");
    int atom_pairs[8][2] = {{1,80},{3,78},{9,72},{27,54}};
    for (int i = 0; i < 4; i++) {
        coord4 c1 = to_lattice(atom_pairs[i][0]);
        coord4 c2 = to_lattice(atom_pairs[i][1]);
        char b1[32], b2[32];
        write_walk(c1, b1);
        write_walk(c2, b2);
        printf("  %2d %-2s  %-6s  ↔  %2d %-2s  %s\n",
               atom_pairs[i][0], sym[atom_pairs[i][0]], b1,
               atom_pairs[i][1], sym[atom_pairs[i][1]], b2);
    }

    return 0;
}
