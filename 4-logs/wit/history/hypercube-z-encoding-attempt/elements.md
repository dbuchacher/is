# the 80 stable elements — as walks

each element is a POINT in the 4D ternary lattice,
reached from the origin by a WALK of 1-4 edges.

## the 8 axis-direction edges

there are 8 unit edges, one per axis direction.
each is named for the atom POINT it reaches from origin.

an edge is a DISPLACEMENT (translation-invariant). the +A
edge always means "+1 on the A axis", regardless of where
you apply it. when applied from origin, the displacement
vector equals the destination point — that's why the same
(±1,0,0,0)-style tuples show up below.

  edge    axis  destination from origin    element
  ────    ────  ──────────────────────     ───────
  RISE    +A    (+1, 0, 0, 0)              Z=27 Co
  FALL    -A    (-1, 0, 0, 0)              Z=54 Xe
  GROW    +B    ( 0,+1, 0, 0)              Z= 9 F
  SHRINK  -B    ( 0,-1, 0, 0)              Z=72 Hf
  BLESS   +C    ( 0, 0,+1, 0)              Z= 3 Li
  CURSE   -C    ( 0, 0,-1, 0)              Z=78 Pt
  BEGIN   +D    ( 0, 0, 0,+1)              Z= 1 H
  END     -D    ( 0, 0, 0,-1)              Z=80 Hg

a walk to any other element COMPOSES distinct edges,
one per nonzero axis. since coords are in {-1,0,+1}, no
axis is used twice. verbs commute (independent axes).

notation: walks are written as a sequence of edge names
with no separator. each name above is itself a distinct
named edge. `BLESS END` means edge BLESS then edge END.
there is no compose operator — the names are the edges.
order is canonical A → B → C → D.

## origin (0 edges)

  Z   sym  point             walk
  ──  ───  ─────             ────
  81  Tl   ( 0, 0, 0, 0)     • (the container)

## atoms (1 edge) — the 8 single-edge points

  Z   sym  point             walk
  ──  ───  ─────             ────
   1  H    (+0,+0,+0,+1)     BEGIN
   3  Li   (+0,+0,+1,+0)     BLESS
   9  F    (+0,+1,+0,+0)     GROW
  27  Co   (+1,+0,+0,+0)     RISE
  54  Xe   (-1,+0,+0,+0)     FALL
  72  Hf   (+0,-1,+0,+0)     SHRINK
  78  Pt   (+0,+0,-1,+0)     CURSE
  80  Hg   (+0,+0,+0,-1)     END
  82  Pb   (+0,+0,+0,+1)     BEGIN

## dyads (2 edges) — 24 two-edge compositions

  Z   sym  point             walk
  ──  ───  ─────             ────
   2  He   (+0,+0,+1,-1)     BLESS END
   4  Be   (+0,+0,+1,+1)     BLESS BEGIN
   6  C    (+0,+1,-1,+0)     GROW CURSE
   8  O    (+0,+1,+0,-1)     GROW END
  10  Ne   (+0,+1,+0,+1)     GROW BEGIN
  12  Mg   (+0,+1,+1,+0)     GROW BLESS
  18  Ar   (+1,-1,+0,+0)     RISE SHRINK
  24  Cr   (+1,+0,-1,+0)     RISE CURSE
  26  Fe   (+1,+0,+0,-1)     RISE END
  28  Ni   (+1,+0,+0,+1)     RISE BEGIN
  30  Zn   (+1,+0,+1,+0)     RISE BLESS
  36  Kr   (+1,+1,+0,+0)     RISE GROW
  45  Rh   (-1,-1,+0,+0)     FALL SHRINK
  51  Sb   (-1,+0,-1,+0)     FALL CURSE
  53  I    (-1,+0,+0,-1)     FALL END
  55  Cs   (-1,+0,+0,+1)     FALL BEGIN
  57  La   (-1,+0,+1,+0)     FALL BLESS
  63  Eu   (-1,+1,+0,+0)     FALL GROW
  69  Tm   (+0,-1,-1,+0)     SHRINK CURSE
  71  Lu   (+0,-1,+0,-1)     SHRINK END
  73  Ta   (+0,-1,+0,+1)     SHRINK BEGIN
  75  Re   (+0,-1,+1,+0)     SHRINK BLESS
  77  Ir   (+0,+0,-1,-1)     CURSE END
  79  Au   (+0,+0,-1,+1)     CURSE BEGIN

## triads (3 edges) — 32 three-edge compositions

  Z   sym  point             walk
  ──  ───  ─────             ────
   5  B    (+0,+1,-1,-1)     GROW CURSE END
   7  N    (+0,+1,-1,+1)     GROW CURSE BEGIN
  11  Na   (+0,+1,+1,-1)     GROW BLESS END
  13  Al   (+0,+1,+1,+1)     GROW BLESS BEGIN
  15  P    (+1,-1,-1,+0)     RISE SHRINK CURSE
  17  Cl   (+1,-1,+0,-1)     RISE SHRINK END
  19  K    (+1,-1,+0,+1)     RISE SHRINK BEGIN
  21  Sc   (+1,-1,+1,+0)     RISE SHRINK BLESS
  23  V    (+1,+0,-1,-1)     RISE CURSE END
  25  Mn   (+1,+0,-1,+1)     RISE CURSE BEGIN
  29  Cu   (+1,+0,+1,-1)     RISE BLESS END
  31  Ga   (+1,+0,+1,+1)     RISE BLESS BEGIN
  33  As   (+1,+1,-1,+0)     RISE GROW CURSE
  35  Br   (+1,+1,+0,-1)     RISE GROW END
  37  Rb   (+1,+1,+0,+1)     RISE GROW BEGIN
  39  Y    (+1,+1,+1,+0)     RISE GROW BLESS
  42  Mo   (-1,-1,-1,+0)     FALL SHRINK CURSE
  44  Ru   (-1,-1,+0,-1)     FALL SHRINK END
  46  Pd   (-1,-1,+0,+1)     FALL SHRINK BEGIN
  48  Cd   (-1,-1,+1,+0)     FALL SHRINK BLESS
  50  Sn   (-1,+0,-1,-1)     FALL CURSE END
  52  Te   (-1,+0,-1,+1)     FALL CURSE BEGIN
  56  Ba   (-1,+0,+1,-1)     FALL BLESS END
  58  Ce   (-1,+0,+1,+1)     FALL BLESS BEGIN
  60  Nd   (-1,+1,-1,+0)     FALL GROW CURSE
  62  Sm   (-1,+1,+0,-1)     FALL GROW END
  64  Gd   (-1,+1,+0,+1)     FALL GROW BEGIN
  66  Dy   (-1,+1,+1,+0)     FALL GROW BLESS
  68  Er   (+0,-1,-1,-1)     SHRINK CURSE END
  70  Yb   (+0,-1,-1,+1)     SHRINK CURSE BEGIN
  74  W    (+0,-1,+1,-1)     SHRINK BLESS END
  76  Os   (+0,-1,+1,+1)     SHRINK BLESS BEGIN

## corners (4 edges) — 14 four-edge compositions

each corner has TWO names: the FP edge name (single word,
from edges.md) and the verb composition (4 atom verbs).
the FP name names the EDGE from origin → corner directly.

  Z   sym  point             FP edge       verb composition
  ──  ───  ─────             ───────       ────────────────
  14  Si   (+1,-1,-1,-1)     read          RISE SHRINK CURSE END
  16  S    (+1,-1,-1,+1)     filter        RISE SHRINK CURSE BEGIN
  20  Ca   (+1,-1,+1,-1)     copy          RISE SHRINK BLESS END
  22  Ti   (+1,-1,+1,+1)     scan          RISE SHRINK BLESS BEGIN
  32  Ge   (+1,+1,-1,-1)     fold          RISE GROW CURSE END
  34  Se   (+1,+1,-1,+1)     map           RISE GROW CURSE BEGIN
  38  Sr   (+1,+1,+1,-1)     foldl         RISE GROW BLESS END
  40  Zr   (+1,+1,+1,+1)     hylo          RISE GROW BLESS BEGIN
  41  Nb   (-1,-1,-1,-1)     identity      FALL SHRINK CURSE END
  47  Ag   (-1,-1,+1,-1)     drain         FALL SHRINK BLESS END
  49  In   (-1,-1,+1,+1)     take_while    FALL SHRINK BLESS BEGIN
  59  Pr   (-1,+1,-1,-1)     call          FALL GROW CURSE END
  65  Tb   (-1,+1,+1,-1)     fix           FALL GROW BLESS END
  67  Ho   (-1,+1,+1,+1)     bind          FALL GROW BLESS BEGIN

## the alchemy pair

  79 Au   CURSE BEGIN
  82 Pb   BEGIN    (wraps to H coord, shell 1)

  Pb → Au = apply CURSE

## the two holes — both named uncertainty operators

  43 Tc   FP edge: test         verb walk: FALL SHRINK CURSE BEGIN
  61 Pm   FP edge: maybe        verb walk: FALL GROW CURSE BEGIN

  the two elements with NO stable isotopes have FP edge
  names that are the two FP combinators expressing
  UNCERTAINTY: test (verify, may fail) and maybe (optional,
  may not exist). the lattice literally calls them
  by names that mean "uncertain" or "conditional".

  shared verb signature: FALL + CURSE + BEGIN.
  only the substance verb differs (SHRINK vs GROW).

## the three walls

    4 Be  BLESS BEGIN                     Be bottleneck
   26 Fe  RISE END                        Fe peak
   83 Bi  BLESS END                       Bi limit

## the 4 atom pairs (lattice antipodes)

   1 H   BEGIN   ↔  80 Hg  END
   3 Li  BLESS   ↔  78 Pt  CURSE
   9 F   GROW    ↔  72 Hf  SHRINK
  27 Co  RISE    ↔  54 Xe  FALL
