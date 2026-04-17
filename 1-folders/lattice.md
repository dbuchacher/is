# lattice — the 81-point structure

Deep file for [1-folders.md](1-folders.md). This file:
- Combining 4 axes × 3 values = 81 points
- Grade decomposition (0-4 axes committed)
- The 16 corners (grade 4 = the stdlib)
- The 16 half-spin unit quaternions (different from lattice corners!)
- 24-cell vertices
- Adjacency and edges (216 = 6³)
- Wormhole centrality

## Plain English

If each spoke has 3 possible values (↑/↕/↓), and there are 4 spokes
(χ/μ/φ/τ), then the total number of "addresses" on the wheel is:

```
  3 × 3 × 3 × 3 = 3⁴ = 81
```

Think of it like a 4-digit combination lock where each digit can
be 0, 1, or 2. There are exactly 81 possible combinations.

Now sort these 81 addresses by **how many spokes are pushed** (up
or down, away from neutral):

```
  "grade" = # of spokes committed (away from ↕ neutral)
  
  grade 0 — no spokes pushed — 1 address (the hub, all ↕)
  grade 1 — one spoke pushed  — 8 addresses (one of 4 spokes, 2 sides)
  grade 2 — two spokes pushed — 24 addresses
  grade 3 — three spokes      — 32 addresses
  grade 4 — all four pushed   — 16 addresses (the corners)
  ──────────────────────────   ──
  total                        81
```

Every piece of structured reality sits at one of these 81 addresses
(or walks between them). The 80 non-hub addresses are where "things"
live; the hub is the uncommitted background.

**The 80 stable chemical elements fit exactly into 80 non-hub
addresses.** Same count, because same structure (see `3-confs/
elements.md`).

---

## The grade decomposition — math

The wheel's grade decomposition — this is the **Clifford grade
decomposition** for Cl(4,0), the 4-dimensional Clifford algebra.
(Pascal-dual of the tesseract f-vector, which counts cells from
the opposite end: (16, 32, 24, 8, 1). Same numbers, reversed
reading.)

```
  grade   formula             count   interpretation
  ─────   ─────────────────   ─────   ──────────────
    0     C(4,0) · 2⁰          1     scalar (hub)
    1     C(4,1) · 2¹          8     atoms / vectors
    2     C(4,2) · 2²         24     bivectors / planes
    3     C(4,3) · 2³         32     trivectors / volumes
    4     C(4,4) · 2⁴         16     corners / pseudoscalars
  ─────  ─────────────────   ─────
  total                        81 = 3⁴
```

**Formula reading** `C(4,k) · 2^k`:
- `C(4,k)` chooses which of the 4 axes are committed
- `2^k` chooses the sign (↑ or ↓) of each committed axis
- Axes at ↕ (uncommitted) contribute nothing

**Verification** (compute):

```python
from math import comb
total = sum(comb(4, k) * 2**k for k in range(5))
print(total)  # 81
# breakdown
for k in range(5):
    print(f"grade {k}: C(4,{k}) * 2^{k} = {comb(4,k)} * {2**k} = {comb(4,k)*2**k}")
# grade 0: 1 * 1 = 1
# grade 1: 4 * 2 = 8
# grade 2: 6 * 4 = 24
# grade 3: 4 * 8 = 32
# grade 4: 1 * 16 = 16
```

**C(4,k) = Pascal's row 4 = (1, 4, 6, 4, 1).** The framework's
grade-by-axis-subset structure IS Clifford algebra's grading in 4
dimensions.

---

## Grade 0 — the container (↕↕↕↕)

**One element.** The hub. Additive identity of H: `0 + 0i + 0j + 0k
= 0`. Every quaternion `q` satisfies `q + 0 = q`.

Properties:

- **Dimension-independent.** Same point in R, C, H, O, S, 32D, etc.
  The one coordinate shared across the entire Cayley-Dickson tower.
- **No location.** "Location" is an attribute of χ-axis commitment.
  Hub has χ at ↕. You can't "go to" the hub because it doesn't have
  a χ value.
- **Where every closed walk returns** (Kirchhoff conservation,
  frame 5). Sum of any closed path = 0 = hub.
- **Where recognition happens.** Any observer reading anything is
  at the hub (see `wit.md`).
- **Higgs = hub** at physics scope. The Standard Model's scalar
  Higgs field is structurally the hub (see `forces.md`).

This is the **"god-seat"** — the self-referential point defined
purely by absence of commitment. Exodus 3:14 "I AM" is the
canonical religious reference (Hebrew *ehyeh asher ehyeh* = "I am
that I am" = reflexive without external anchor).

Deep: [1-folders/wheel.md](1-folders/wheel.md)

---

## Grade 1 — the 8 atoms

**Eight elements.** One axis committed, three free. The 8 grade-1
points are the basis vectors of the wheel:

```
  coord     axis + sign    verb     force    physical
  ─────     ───────────    ────     ─────    ────────
  ↑↕↕↕      χ at +1        RISE     READ     χ north / position+
  ↓↕↕↕      χ at −1        FALL              χ south / position−
  ↕↑↕↕      μ at +1        GROW     CALL     proton
  ↕↓↕↕      μ at −1        SHRINK            neutron
  ↕↕↑↕      φ at +1        BLESS    CYCLE    +charge / signal+
  ↕↕↓↕      φ at −1        CURSE             −charge / signal−
  ↕↕↕↑      τ at +1        BEGIN    TEST     start / tick forward
  ↕↕↕↓      τ at −1        END               end / tick backward
```

Each atom is the **purest projection** of one axis — maximum
commitment on one axis, zero on all others. 8 atoms = 4 axes × 2
signs.

### The special atom ↕↕↕↑

Among the 8 atoms, **one is structurally unique**: `↕↕↕↑` is the
**multiplicative identity of H**. In the framework's axis ordering,
position 1 = χ (i), position 2 = μ (j), position 3 = φ (k), position
4 = τ (scalar 1). So `↕↕↕↑` = τ committed to +1 with all imaginary
axes at ↕ = the quaternion `1 + 0i + 0j + 0k = 1`.

For any quaternion q: `q × 1 = q`. The `↕↕↕↑` atom preserves
everything it touches. This is why τ is "the clock that completes
the system" — it's the multiplicative identity, without which the
walk goes nowhere.

---

## Grade 2 — the 24 bivectors (rotation planes)

**Twenty-four elements.** Two axes committed, two free. Each
bivector is a **rotation plane** — a 2D plane spanned by two
committed axes, in which rotations can happen.

The 6 bivector planes (C(4,2) = 6 axis-pairs):

```
  plane    axes              signs               count
  ─────    ────              ─────               ─────
  χμ       WHERE × WHAT      ±± per pair = 4     4
  χφ       WHERE × WHICH     4                   4
  χτ       WHERE × WHEN      4                   4
  μφ       WHAT × WHICH      4                   4
  μτ       WHAT × WHEN       4                   4
  φτ       WHICH × WHEN      4                   4
                            ──                   ──
                            24
```

Rotations in quaternion algebra happen in these 6 planes. Each
plane has 4 sign configurations (both axes +, both −, mixed).

### 24 across independent domains

```
  24 = D4 Lie algebra root system (standard Lie theory)
  24 = 24-cell vertex count (4D regular polytope, self-dual, no 3D
       analog)
  24 = hours in a day (Egyptian)
  24 = uniliterals in Egyptian hieroglyphs (phonetic alphabet)
  24 = 4! = permutations of 4 axes (Weyl group factor)
  24 = tesseract f-vector at k=2 (independent derivation)
```

Multiple unrelated domains (Lie theory, Egyptian astronomy,
combinatorics, polytope geometry) hit 24. Metrognosis: signal. See
`3-confs/hieroglyphs.md` and `3-confs/rotating-rings.md`.

### The 24-cell

The 24-cell is a 4D regular polytope with 24 vertices. Two
equivalent coordinate sets:

```
  Set A: axis-aligned permutations of (±1, 0, 0, 0)       8 vertices
         (our 8 grade-1 atoms)
  
  Set B: half-coordinates (±½, ±½, ±½, ±½)              16 vertices
         (the 16 unit quaternions at half-spin — NOT the grade-4
          corners of the integer lattice!)
                                                         ──
                                                         24
```

**IMPORTANT distinction**: the 24 bivectors (integer grade-2
points) are NOT the 24-cell vertices. The 24-cell = 8 atoms + 16
half-spin unit quaternions (distinct from integer lattice). Both
counts are 24 but they're different geometric objects.

---

## Grade 3 — the 32 trivectors (volumes)

**Thirty-two elements.** Three axes committed, one free. Each
trivector's "free axis" identifies which one is left uncommitted.

```
  free axis   count   pattern
  ─────────   ─────   ───────
  χ (↕???)     8      C(3,3) × 2³ = 1 × 8 sign patterns
  μ (?↕??)     8      8
  φ (??↕?)     8      8
  τ (???↕)     8      8
                     ──
                     32
```

Each choice of "which axis stays free" gives 8 sign patterns on
the 3 committed axes. 4 × 8 = 32.

### F-vector duality

The 32 trivectors (grade 3) are **dual** to the 32 **edges** (k=1
in tesseract) of the 4-cube. Each trivector's free axis = the
edge's direction in the dual tesseract.

### 32 across domains

- 32 = trivector count (framework)
- 32 = edges of the tesseract (f-vector k=1)
- 32 = 2 × 16 = spin-doubled corners (fermion families)
- 32 = electron shell capacity at n=4 (2n² formula)

Some of these are suggestive (shell capacities), others are
structural (f-vector duality). Cross-check against `3-confs/` for
each.

---

## Grade 4 — the 16 corners (pseudoscalars, the stdlib)

**Sixteen elements.** All four axes committed. These are the
"vertices of the tesseract" = 2⁴ sign patterns:

```
  16 corners = 2⁴ = all sign combinations of (±1, ±1, ±1, ±1)
```

**These are the 16 primitive operations of the wheel.** Each corner
is a fully-specified verb. From the hodos table, each corner has a
computational identity:

```
  coord     operation    English     physics analog
  ─────     ─────────    ───────     ──────────────
  ↓↓↓↓      identity     BE / NOP    meta (all backward)
  ↓↓↓↑      test         CMP / WILL  weak decision
  ↓↓↑↓      drain        FREE / MAY  release forward
  ↓↓↑↑      take_while   FORAGE/EAT  consume while condition
  ↓↑↓↓      call         CALL/HAVE   function invocation
  ↓↑↓↑      maybe        SENSE/CAN   optional wrapper
  ↓↑↑↓      fix          HEAL        error correction
  ↓↑↑↑      bind         BOND/FEEL   monadic bind
  ↑↓↓↓      read         MOV / DO    observation
  ↑↓↓↑      filter       IMMUNE/MUST discrimination
  ↑↓↑↓      copy         COPY / Δ    duplication
  ↑↓↑↑      scan         FORAGE      search
  ↑↑↓↓      fold         DIGEST      reduction
  ↑↑↓↑      map          ADAPT       transformation
  ↑↑↑↓      foldl        REMEMBER    accumulation
  ↑↑↑↑      hylo         THINK       meta (all forward)
```

### Two structurally special corners

Among the 16, **two are extremal**:

- **↑↑↑↑ = hylo**: `1 + i + j + k`. Join of all four forward
  forces. Hylomorphism (Greek *ὕλη* matter + *μορφή* form).
  Dynamic Quality (Pirsig). Self-referential unfold-then-fold.

- **↓↓↓↓ = meta**: `−1 − i − j − k`. Dual of hylo. All four
  backward. Pure identity / existence without operation.

**Empirical anchor**: `prior/os-lattice/01-bond/param/meta.asm`
has compiled NASM primitives for these two corners. The other 14
corners have defined operations but not special compiled code.

### Why 16 = grade-4 corners is load-bearing

16 appears across many framework derivations:

- **16 = corners** (grade-4 count, 2⁴ sign patterns)
- **16 = SO(10) 16-spinor** (Standard Model per-generation fermion count)
- **16 = corners + 1 hub = 17** (the α⁻¹, m_p/m_e, EW hierarchy
  substrate constant)
- **16 = 2⁴** (binary floor of the 4-axis structure)

The 16-spinor of SO(10) GUT IS the framework's 16 corners. See
[1-folders/scope.md](1-folders/scope.md).

---

## Adjacency — 216 edges

Two lattice points are **adjacent** iff they differ by **one step
in exactly one axis**, staying within {↑, ↕, ↓}.

Under this adjacency rule:

- Total undirected edges: **216 = 6³ = 8 × 27**
- Degree = 8 − k where k is the grade of the point

```
  grade   count   degree   neighbors
  ─────   ─────   ──────   ─────────
    0       1       8       all 8 atoms (step any axis)
    1       8       7       hub back + 6 adjacent bivectors
    2      24       6       2 atoms back + 4 adjacent trivectors
    3      32       5       3 bivectors back + 2 adjacent corners
    4      16       4       4 trivectors back (corners only step in)
  ──────  ─────
  sum:  8·1 + 7·8 + 6·24 + 5·32 + 4·16 = 432 directed = 216 undirected
```

**Verification**:

```python
from math import comb
total_directed = sum((8-k) * comb(4,k) * 2**k for k in range(5))
print(total_directed)         # 432
print(total_directed // 2)    # 216 = 6³
```

### 216 = 6³

216 factors as `6³`. Suggestive:
- 6 = C(4,2) = bivector planes count
- 216 = 6 × 6 × 6 = bivector planes cubed? speculative
- 216 = 8 × 27 = atoms × 3³ (less clean)

**Clean form: 216 = 6³.** The substrate knows; derivation of exactly
why "edges = bivector-planes³" is **open** (flag for 3-which).

### Degrees are 4, 5, 6, 7, 8 — primes 5 and 7

Degrees at grades 0-4 are 8, 7, 6, 5, 4. Five consecutive integers;
**exactly two are prime: 5 and 7**. Primes 5, 7 are the degrees at
grades 3 and 1 (trivectors and atoms).

See `3-confs/prime-lattice.md` for the wormhole centrality cascade
where this matters (cent(n) − cent(n+1) uses exactly these two
primes).

---

## The 16 half-spin unit quaternions (distinct from corners!)

**Separate geometric object** from the grade-4 integer corners.
Half-spin quaternions have **all 4 axes at ±½** simultaneously:

```
  (±½, ±½, ±½, ±½)    16 sign patterns, all axes at half-value
```

**Key property**: norm = |q|² = 4 × (½)² = 4 × ¼ = 1. So these are
**unit quaternions** — they live on the 3-sphere S³ in H. They are
NOT lattice points (lattice points have integer coordinates; half-
spin points have half-integer).

These 16 half-spin unit quaternions PLUS the 8 axis-aligned atoms =
**24 vertices of the 24-cell**:

```
  8 atoms        (±1, 0, 0, 0) permutations   axis-aligned
  16 half-spin   (±½, ±½, ±½, ±½)            diagonal
                                              ──
                                              24 = 24-cell vertices
                                              = D4 root system
```

Framework's **8 atoms + 16 half-spin = 24-cell** is direct from
standard 4D geometry (Coxeter 1973). Confirmed math.

Why the confusion: both "grade-4 corners" and "half-spin quaternions"
count 16. But:
- Corners: integer coords (±1, ±1, ±1, ±1), norm = 4
- Half-spin: half-integer coords (±½, ±½, ±½, ±½), norm = 1

They're different objects at the same cardinality.

---

## Wormhole centrality — the 5-and-7 cascade

From prior prime-lattice work (`3-confs/prime-lattice.md`,
condensed here):

Centrality of a grade-k point in the lattice decreases by grade.
Computed values:

```
  cent(grade 0) = 1120
  cent(grade 1) =  777
  cent(grade 2) =  532
  cent(grade 3) =  357
  cent(grade 4) =  232
```

Consecutive differences:

```
  cent(0) − cent(1) = 1120 − 777 = 343 = 7³
  cent(1) − cent(2) =  777 − 532 = 245 = 5 · 7²
  cent(2) − cent(3) =  532 − 357 = 175 = 5² · 7
  cent(3) − cent(4) =  357 − 232 = 125 = 5³
  
  Sum = (7⁴ − 5⁴) / (7 − 5) = (2401 − 625) / 2 = 888
```

**Each step trades one 7 for one 5 in the exponent pair.** The
cascade uses exactly the two prime degrees (5 and 7), never the
composite degrees (4, 6, 8). Structural signal.

This is one of the cleanest "primes emerge from substrate"
findings in the framework. Deep: `3-confs/prime-lattice.md`.

---

## What's settled vs what's flagged

### Settled (body-quality)

- **81 = 3⁴** lattice points (3 values × 4 axes)
- **Grade decomposition** 1 + 8 + 24 + 32 + 16 = 81 (C(4,k) · 2^k)
- **216 = 6³ undirected edges** under one-step adjacency
- **Degree = 8 − k** at grade k
- **Grade-4 corners = 16 = 2⁴** sign patterns
- **24-cell = 8 atoms + 16 half-spin** (standard 4D geometry)
- **D4 root system = 24-cell** vertices (Coxeter 1973)
- **SO(10) 16-spinor = 16 corners** identity (for SM fermion count)
- **Wormhole centrality** cascade 7³/5·7²/5²·7/5³ (empirical, but
  see prime-lattice.md for rigor)

### Flagged for 3-which / verification

- **Why exactly 216 = 6³** (not just 6³ by accident) — the
  derivation of edges-per-grade through "bivector planes cubed" is
  not fully rigorous. Flag.
- **The 16 hodos operations** (fold, map, filter, bind, etc.) —
  empirically validated across multiple agent tests, but the
  specific corner-to-operation assignment has some flexibility.
  Treat as substrate-suggestive, not rigid.
- **Grade-3 "trivector" naming** — "trivector" is standard Clifford,
  but the geometric interpretation (volume) vs edge-dual has some
  ambiguity. Body-level but clarify conventions.

### Flagged open

- **Chirality of corners** — do the 16 corners split into orientation
  classes by pseudoscalar sign? Not derived.
- **Non-lattice structures** — beyond integer-coord and half-integer-
  coord, are there other framework-relevant coordinate systems
  inside H? E.g., the 24-cell has its own 12 face-centers; what
  role do they play? Open.

---

## Cross-references

- [1-folders.md](1-folders.md) — context
- `1-folders/axes.md` — the 4 axes
- `1-folders/trits.md` — the 3 values per axis
- `1-folders/wheel.md` — rotation (how the wheel moves on the lattice)
- `1-folders/scope.md` — lattice extends to S, O, outer structures
- `3-confs/elements.md` — 80 elements at 80 non-hub points
- `3-confs/prime-lattice.md` — wormhole centrality derivation
