# corners — the 16 all-nonzero points

The corners are the 16 points where every axis has a definite
sign (±1). No zeros. All four forces committed to a direction.

These are a stratum of the integer lattice (see `points.md`).
They are VALUES, not combinators. But they are where combinators
are CLASSIFIED — because you identify an edge by looking at its
two endpoint corners.

## The 16 corners

```
   #   (A,  B,  C,  D)     subset (which are +)    hodos name
  ──   ─────────────────   ─────────────────────    ──────────
   1   (-1, -1, -1, -1)    { }                      identity / wave
   2   (+1, -1, -1, -1)    {A}                      read
   3   (-1, +1, -1, -1)    {B}                      call
   4   (-1, -1, +1, -1)    {C}                      drain / advance
   5   (-1, -1, -1, +1)    {D}                      test
   6   (+1, +1, -1, -1)    {A,B}                    fold
   7   (+1, -1, +1, -1)    {A,C}                    copy / slurp
   8   (+1, -1, -1, +1)    {A,D}                    filter
   9   (-1, +1, +1, -1)    {B,C}                    fix
  10   (-1, +1, -1, +1)    {B,D}                    maybe
  11   (-1, -1, +1, +1)    {C,D}                    take_while
  12   (+1, +1, +1, -1)    {A,B,C}                  foldl
  13   (+1, +1, -1, +1)    {A,B,D}                  map
  14   (+1, -1, +1, +1)    {A,C,D}                  scan
  15   (-1, +1, +1, +1)    {B,C,D}                  bind
  16   (+1, +1, +1, +1)    {A,B,C,D}                hylo
```

## Why hodos names appear here

The hodos.c names (read, fold, map, bind, hylo) are COMBINATOR
names — they name edge-types, not points. But they appear next
to corners because of how classification works in the code:

```c
static inline BondType classify_bond(coord4 a, coord4 b) {
    int mask = 0;
    if (a.t != b.t) mask |= BOND_P;   // 1
    if (a.x != b.x) mask |= BOND_C;   // 2
    if (a.m != b.m) mask |= BOND_R;   // 4
    if (a.q != b.q) mask |= BOND_W;   // 8
    return (BondType)mask;
}
```

The bitmask asks "which axes CHANGED between two corners?" That
produces a 4-bit pattern = one of 16 types. The pattern tells
you WHAT KIND of edge connected the two corners.

So the hodos name belongs to the EDGE (the combinator), but the
classification is done by observing the CORNERS (the values).
Same 2⁴ = 16 count because there are 16 possible subsets of
4 axes. Numerically identical, categorically different:

```
  the 16 corners  = 16 possible states (all forces committed)
  the 16 hodos    = 16 possible edge-types (which axes changed)
  same count (2⁴) = both enumerate subsets of {A,B,C,D}
  different kind  = state vs transition-type
```

## Binary shadow

The 16-pattern classification is a BINARY artifact. Each axis
gets one bit: changed (1) or didn't (0). On a trit processor,
each axis would carry its direction natively:

```
  binary (x86):   if (a.t != b.t) mask |= 1;     // 1 bit: yes/no
  trit (native):  bond.t = b.t - a.t;              // 1 trit: -1/0/+1
```

On trits: 3⁴ - 1 = 80 directed edge-types (minus identity).
The 16 is what you get when you throw away direction to fit on
binary hardware. The Setun (1958) would have given 80 natively.

## Axis key

```
  A = POSITION    (strong / READ)     hodos: P (bit 0)
  B = SUBSTANCE   (EM / CALL)         hodos: C (bit 1)  *name clash
  C = SIGNAL      (gravity / CYCLE)   hodos: R (bit 2)
  D = TIME        (weak / TEST)       hodos: W (bit 3)
```

## Relationship to edges and walks

Corners are ENDPOINTS. Edges connect them. You observe corners
(values) and infer edges (combinators) from the difference.

```
  corner A ──── edge ──── corner B
  (before)    (combinator)  (after)
  observable   invisible    observable
```

A combinator combines 2 things because an edge has 2 endpoints.
The arity of combination is 2. Structural, not a design choice.

See `edges.md` for the combinators themselves.
See `points.md` for the full integer lattice including corners.
