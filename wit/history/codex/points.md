# points — integer lattice values (where things ARE)

Points are coordinates on the integer lattice {-1, 0, +1}⁴.
They are VALUES. Data. States. The observable positions.

In code: `coord4` = four `int8_t`. Storage, bins, field lookup.

## Shell 1 — 81 = 3⁴ points

Organized by zero-count (how many axes are at 0):

```
  zeros   count   stratum        what it is
  ─────   ─────   ───────        ──────────
   4        1     origin         [0,0,0,0] — the container, the self, the observer
   3        8     atoms          one axis ±1, others 0 — unit basis vectors (atoms.md)
   2       24     dyads          two axes ±1, two 0 — unnamed
   1       32     triads         three axes ±1, one 0
   0       16     corners        all four ±1 — where combinators are classified (corners.md)
                  ──
                  81 = 3⁴
```

## The 5 strata

### Origin (1 point)

```
  [0, 0, 0, 0]    the container — the viewpoint from which the lattice is read
```

No axis engaged. The observer. The self. Verbs of subjectivity
(THINK, KNOW, BE, FEEL, SEE, HEAR) collapse here because they
happen INSIDE the observer, not on any axis.

### Atoms (8 points)

One axis at ±1, others at 0. The 8 unit basis vectors.
See `atoms.md` for full detail.

```
  [+1,  0,  0,  0]  RISE      [-1,  0,  0,  0]  FALL
  [ 0, +1,  0,  0]  GROW      [ 0, -1,  0,  0]  SHRINK
  [ 0,  0, +1,  0]  BLESS     [ 0,  0, -1,  0]  CURSE
  [ 0,  0,  0, +1]  BEGIN     [ 0,  0,  0, -1]  END
```

### Dyads (24 points)

Two axes at ±1, two at 0. C(4,2) = 6 axis-pairs × 2² = 4
sign patterns each = 24.

```
  axis pair    count    example
  ─────────    ─────    ───────
  AB           4        [+1, +1, 0, 0]  [+1, -1, 0, 0]  [-1, +1, 0, 0]  [-1, -1, 0, 0]
  AC           4        [+1, 0, +1, 0]  ...
  AD           4        [+1, 0, 0, +1]  ...
  BC           4        [0, +1, +1, 0]  ...
  BD           4        [0, +1, 0, +1]  ...
  CD           4        [0, 0, +1, +1]  ...
```

Unnamed stratum. These are two-force-engaged states: e.g.,
[+1, +1, 0, 0] = POSITION forward + SUBSTANCE forward, with
SIGNAL and TIME at zero (unengaged / in wave).

### Triads (32 points)

Three axes at ±1, one at 0. C(4,1) = 4 zero-axis choices × 2³ = 8
sign patterns each = 32.

```
  zero axis    count    examples
  ─────────    ─────    ────────
  A = 0        8        [0, +1, +1, +1]  [0, +1, +1, -1]  ...
  B = 0        8        [+1, 0, +1, +1]  [+1, 0, +1, -1]  ...
  C = 0        8        [+1, +1, 0, +1]  [+1, +1, 0, -1]  ...
  D = 0        8        [+1, +1, +1, 0]  [+1, +1, -1, 0]  ...
```

Three forces engaged, one in wave/null. These correspond to the
compass-bearing notation in bonds.md (prior framing): a triad
with A=0 is what bonds.md wrote as `flip_A(B±, C±, D±)`.

### Corners (16 points)

All four axes at ±1. 2⁴ = 16.
See `corners.md` for full detail.

## Higher shells

Shell 1 (above) has 81 points with values in {-1, 0, +1}.
Higher shells extend the range:

```
  shell    values              total points    new points
  ─────    ──────              ────────────    ──────────
  1        {-1, 0, +1}         3⁴ =    81           81
  2        {-2, ..., +2}       5⁴ =   625          544
  3        {-3, ..., +3}       7⁴ = 2,401        1,776
  4        {-4, ..., +4}       9⁴ = 6,561        4,160
```

Shell 4 is the stability ceiling (Cayley-Dickson, see 3-force.md).
6,561 stable points total. Beyond shell 4: 19% heartbeat decay.

## Relationship to other layers

Points are the FIRST tier. The observable. The values.

```
  tier          what           code type    observable?
  ────          ────           ─────────    ───────────
  points        values         coord4       YES — you see states
  edges         combinators    bitmask      NO — you infer from 2 points
  walks         programs       float4       YES — "the path IS the function"
```

You never see an edge (combinator) directly. You see two points
and infer what happened between them. The edge is invisible.
See `edges.md`.
