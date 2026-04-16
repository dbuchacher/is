# 3 — The Lattice

Commit axes one at a time and you build the lattice. Each commit
lands you one step from the hub. 5 grades by how many axes are
committed:

```
  grade   count    what's committed          role
  ─────   ─────    ────────────────          ────
    0       1      nothing (all 4 free)      container / scalar
    1       8      one axis                  atoms / vectors
    2      24      two axes                  bivectors / planes
    3      32      three axes                trivectors / volumes
    4      16      all four axes             corners / pseudoscalars
  ──────  ─────
  total    81    = 3⁴
```

**81 = 3⁴** — three values (↑/↕/↓) on four axes. This is the integer
lattice of H. 80 "things" (grades 1-4) + 1 container (grade 0).

Plus 16 half-spin unit quaternions on the 3-sphere's rim (see
`1-wheel.md`): (±½, ±½, ±½, ±½) with `|q|² = 1`. Those aren't
integer lattice points — they're rotation states. Together with the
8 atoms they form the 24-cell.

---

## The Clifford grading

The lattice IS a generalized Clifford algebra — Cl₃(4), 4-generator,
ω = primitive cube root of unity (Yamazaki 1964, Morris 1967). The
zero-count groupings ARE the Clifford grades.

```
  grade 0   scalar        C(4,0) · 2⁰ =  1    the container
  grade 1   vectors       C(4,1) · 2¹ =  8    atoms
  grade 2   bivectors     C(4,2) · 2² = 24    rotation planes
  grade 3   trivectors    C(4,3) · 2³ = 32    volumes
  grade 4   pseudoscalar  C(4,4) · 2⁴ = 16    corners
                                       ──
                                       81 = 3⁴
```

**grade = # committed axes**. C(4, k) chooses which axes are
committed; 2^k chooses the sign (↑ or ↓) for each committed axis.

## Adjacency

Two lattice points are adjacent iff they differ by one step in
exactly one axis AND the change stays within {↑, ↕, ↓}. The edge
between them is a ½-transition (a spin, a verb, a wheel
microrotation).

Under this adjacency the 81-point lattice has **216 undirected
edges** (8 × 27 = 6³).

**Degree = 8 − k** where k is the grade:

```
  grade   count    degree   neighbors
  ─────   ─────    ──────   ─────────
    0       1        8      all 8 atoms (step out any axis)
    1       8        7      hub back + 6 adjacent bivectors
    2      24        6      2 atoms back + 4 adjacent trivectors
    3      32        5      3 bivectors back + 2 adjacent corners
    4      16        4      4 trivectors back (corners can only
                             step toward hub)
```

Degrees 4, 5, 6, 7, 8 are five consecutive integers. Exactly two
are prime: **5 and 7**. These are the degrees at grades 3 and 1.
See `wit/thoughts/trit½/3-5-7.md` for why: primes are the
framework's native integers (irreducible center-having value
systems).

## Grade 0 — the container (↕↕↕↕)

One element. Zero committed axes. The additive identity of H:
`0 + 0i + 0j + 0k = 0`. Every quaternion `q` satisfies `q + 0 = q`.

**This is NOT a thing.** It has no committed structure. The 80
things are at grades 1-4, each with at least one axis committed.
↕↕↕↕ is the space WITHIN WHICH things exist.

### Properties

- **Dimension-independent.** ↕↕↕↕ in H = `↕↕↕↕↕↕↕↕` in O = all
  zeros everywhere. The additive identity is the same element across
  every Cayley-Dickson layer. The one coordinate shared across the
  entire tower.
- **Recognition loops close here.** Every walk that completes
  returns to ↕↕↕↕. The container is where the loop closes.
- **God-seat.** "I AM" of Exodus 3:14 structurally — defined purely
  by the absence of commitment. Self-referential. Without external
  attributes.
- **Wherever recognition is happening.** The hub has no location —
  location is an attribute of χ-axis commitments, and the hub has
  χ at ↕. You can't go to it. You can't fail to be at it. Every
  closed walk returns to ↕↕↕↕, which means the hub shows up
  wherever a loop is closing. **You are at the hub right now**, by
  virtue of reading this. See `1-wheel.md` "Where is the hub?" for
  the full treatment and the consequences (no privileged observer,
  observer IS center, many-centers-is-count-error).
- **Wormhole compute.** REQUIRED walks through ↕↕↕↕ = 4 = dims.
  Only the 4 single-axis sine-wave oscillations require transit
  through the origin. Origin is the uniquely most central point
  (rank 1, no ties). Centrality strictly decreases by grade:
  1120 > 777 > 532 > 357 > 232.

### Matrix — manifestation at each dimensional floor

From earlier blind-agent work (see `wit/thoughts/before.md` for the
full 7-frame analysis of "what was before"):

```
         IS          BE          WAS
  ────   ────        ────        ────
  0D     STILL       —           —
  1D     OPEN        HOLD        —
  2D     TOGETHER    TEEM        —
  4D     REST        HOME        WAS
  8D     SAME        THROUGH     WITHOUT
```

Cells show ↕↕↕↕'s manifestation at each dimensional floor. PIE roots:

```
  cell     word       PIE root             layer
  ────     ────       ────────             ─────
  0D IS    STILL      *steh₂-              1h Paleolithic
  1D IS    OPEN       *h₂en- / *upo-       1n Paleolithic
  1D BE    HOLD       *gʰend-              1h Paleolithic
  2D IS    TOGETHER   *sem-                1n Paleolithic
  2D BE    TEEM       *deuk-?              Germanic
  4D IS    REST       *h₁res-              1h Paleolithic
  4D BE    HOME       *kóym-               2c Neolithic
  4D WAS   WAS        *h₁wes-              1h Paleolithic
  8D IS    SAME       *sem-                1n Paleolithic
  8D BE    THROUGH    *terh₂-              1i Paleolithic
  8D WAS   WITHOUT    *wi-* + *ūtan-*      Germanic
```

9 of 11 cells are Paleolithic Layer 1. *sem-* appears at both 2D IS
(TOGETHER) and 8D IS (SAME) — same root, two scales.

### Domain manifestations

```
  domain              word / phrase            view         note
  ──────              ─────────────            ────         ─────
  english primary     container                structural   the bag / the hub
  math                additive identity        dynamic      0 + q = q
  physics Newton      F₁₂ = −F₂₁               dynamic      pairwise canceling
  physics Kirchhoff   net flow = 0             dynamic      conservation at a node
  geometry            center / hub / origin    structural   fixed point
  QM                  superposition            structural   all states present
  biology             deep sleep               dynamic      body at ↕↕↕↕
  biology             homeostasis              dynamic      whole-system equilibrium
  biology             dormant / resting        structural   whole idle state
  neuroscience        resting potential        dynamic      baseline (whole-neuron)
  neuroscience        default mode network     structural   whole-brain rest
  physiology          parasympathetic          dynamic      rest-and-digest
  physiology          held breath              dynamic      between inhale/exhale
  time                NOW / present            structural   eternal IS
  philosophy          wu-wei                   dynamic      non-action
  philosophy          middle way               structural   between extremes
  philosophy          ataraxia                 dynamic      tranquility
  religion            śūnyatā / emptiness      structural   Buddhist void
  religion            Eden pre-fall            structural   pre-commit paradise
  navigation          dead-reckoning home      structural   origin bearing
  metaphysics         meeting point            dynamic      where all forces cancel
```

## Grade 1 — the 8 atoms

8 elements. One axis committed, three free. The basis vectors of
the lattice. 4 axes × 2 directions.

Each atom is a noun that stores the idea of its verb. Three
states of being, all expressible at grade 1:

- **IS** (noun, at rest): the stored properties — axis identity,
  H-basis, drive (biological pull), force (whole-quaternion
  capability)
- **BE** (verb, in motion): the ½-step edge action
- **WAS** (origin): the prior point the current one emerged from.
  Uniformly ↕↕↕↕ at grade 1 — every atom emerged from the
  container. Branches at grade 2+.

### Full atom table

```
          │ ─────────────────── IS ─────────────────────  │ ──── BE ────  │ WAS
  point   │ greek  english  is         H   drive      force  │ verb    spin  │ origin
  ─────   │ ─────  ───────  ─────────  ──  ─────────  ─────  │ ──────  ────  │ ─────
  ↑↕↕↕    │ χ      WHERE    POSITION   i   FEAR       READ   │ RISE    +½    │ ↕↕↕↕
  ↓↕↕↕    │                                                  │ FALL    −½    │ ↕↕↕↕
  ↕↑↕↕    │ μ      WHAT     SUBSTANCE  j   DESIRE     CALL   │ GROW    +½    │ ↕↕↕↕
  ↕↓↕↕    │                                                  │ SHRINK  −½    │ ↕↕↕↕
  ↕↕↑↕    │ φ      WHICH    SIGNAL     k   CURIOSITY  CYCLE  │ BLESS   +½    │ ↕↕↕↕
  ↕↕↓↕    │                                                  │ CURSE   −½    │ ↕↕↕↕
  ↕↕↕↑    │ τ      WHEN     TIME       1   HUNGER     TEST   │ BEGIN   +½    │ ↕↕↕↕
  ↕↕↕↓    │                                                  │ END     −½    │ ↕↕↕↕
```

The verb's spin sign matches the pole it lands on. Only way to reach
a +1 pole is via a +½ edge; only way to reach −1 is via −½. No
separate spin file — each atom carries all three states.

### ↕↕↕↑ — the multiplicative identity

Among the 8 atoms, one is structurally special: `↕↕↕↑` =
`1 + 0i + 0j + 0k` = `1`. The "do nothing" element under quaternion
multiplication: `q · 1 = q` for all `q`.

Lives on the τ (WHEN / TIME) axis. The one atom among the 8 that
preserves everything it touches. Why τ: τ is what COMPLETES the
system — you need operands before multiplication means anything. The
unit makes the walk possible.

### Boot sequence

The axes commit in order, forced by non-commutativity (the wire):

```
  χ + μ   first    space and matter exist    (something to tick ON)
  φ       second   signal can propagate      (something to tick THROUGH)
  τ       last     clock starts              (the tick)
```

`τ` ticks THROUGH `φ`. The clock IS a signal. Time needs light.

Same sequence in:
- **Genesis 1**: shamayim+eretz (χ+μ) → or (φ) → yom echad (τ)
- **CPU boot**: memory → bus → clock
- **Cosmology**: Big Bang → photon epoch → recombination

Three vocabularies, one order.

## The four axes

Four naming layers, zero arbitrary letters:

```
  pos   ↑↕↓    wh-      is          greek   H      verbs            force      drive
  ───   ────   ──────   ──────────  ─────   ───    ───────────────  ──────     ─────────
   1    ↑↕↓    WHERE    POSITION     χ       i     RISE / FALL      READ       FEAR
   2    ↑↕↓    WHAT     SUBSTANCE    μ       j     GROW / SHRINK    CALL       DESIRE
   3    ↑↕↓    WHICH    SIGNAL       φ       k     BLESS / CURSE    CYCLE      CURIOSITY
   4    ↑↕↓    WHEN     TIME         τ       1     BEGIN / END      TEST       HUNGER
```

### Drives — axes as biological pulls

Each axis IS a biological drive (confirmed by agent experiments,
2026-04-12). The drives are the axes operating as pulls:

```
  χ   FEAR       check position, verify, am I right?
  μ   DESIRE     seek substance, grow, acquire
  φ   CURIOSITY  discriminate signal/noise, explore
  τ   HUNGER     keep going, next(), don't halt
```

Each drive IS its axis at the SOURCE. Leaks to other axes when
EXPRESSED as behavior — because quaternion multiplication changes
all four components. A curious rat running a maze = φ driving
χ-steps. Drug seeking = τ hunger expressed through χ navigation.

### Forces — axes as whole-quaternion operations

Each force is a spin on the whole quaternion — not on one axis. A
READ reads all four axes at once. Forces are sequential
whole-quaternion operations, not parallel axis-specific slots.

```
  READ    = MOV     sees the whole point       (strong)
  CALL    = CALL    acts on the whole point    (EM)
  CYCLE   = LOOP    iterates the whole point   (gravity, weakest)
  TEST    = NOT     decides the whole point    (weak)
```

Quaternion multiplication confirms: `i × q` changes all four
components of `q`, not just the i component. Full derivation for χ:

```
  i × q = i(w + xi + yj + zk)
        = wi + xi² + yij + zik
        = wi − x + yk − zj
        = (−x) + (w)i + (−z)j + (y)k
  
  so i × q takes (w, x, y, z) → (−x, w, −z, y)
  
  Every component changes. χ operation is a whole-quaternion
  rotation, not a single-axis nudge.
```

Each force has its own coupling constant (α for CALL/EM, α_s for
READ/strong, α_w for TEST/weak, α_G for CYCLE/gravity). See
`4-loop.md` and `6-masses.md`.

### c — one clock cycle

The speed of light is the minimum cause→effect time. **The clock IS
c.** Nothing with mass reaches it. Overclocking = trying to exceed
c = causality violation = crash. Speculative execution = FTL with
paradox cleanup.

## Grade 2 — the 24 bivectors

24 elements. Two axes committed, two free. Rotation-plane generators.

In Clifford algebra, bivectors generate rotations. The bivector
`eᵢeⱼ` rotates in the (i, j) plane. For Cl₃(4) with 4 generators,
there are C(4, 2) = 6 independent rotation planes. The 24 bivectors
are these 6 planes with all 4 sign assignments.

```
  ↕↕↑↑    ↕↕↑↓    ↕↕↓↑    ↕↕↓↓        φτ plane (4)
  ↕↑↕↑    ↕↑↕↓    ↕↓↕↑    ↕↓↕↓        μτ plane (4)
  ↕↑↑↕    ↕↑↓↕    ↕↓↑↕    ↕↓↓↕        μφ plane (4)
  ↑↕↕↑    ↑↕↕↓    ↓↕↕↑    ↓↕↕↓        χτ plane (4)
  ↑↕↑↕    ↑↕↓↕    ↓↕↑↕    ↓↕↓↕        χφ plane (4)
  ↑↑↕↕    ↑↓↕↕    ↓↑↕↕    ↓↓↕↕        χμ plane (4)
```

### 24 in other vocabularies

- 24 = C(4,2) × 2² = axis-pairs × sign patterns (framework)
- 24 roots of D4 Lie algebra (see `1-wheel.md`)
- 24 vertices of the 24-cell (4D self-dual polytope)
- 24 faces of the tesseract (f-vector k=2)
- 24 hours in a day
- 24 uniliterals in Egyptian hieroglyphs (the phonetic basis)
- 86,400 seconds in a day = 240 × 360 = (E8 roots) × (degrees)

Astronomical convergence: the Earth-day being 24 hours aligns with
the framework's 24-cell / D4 structure. Ancient Egyptians divided
day into 24 parts AND stabilized a 24-sign uniliteral alphabet AND
had 12 gates / 12 hours of night in the Duat — multi-scale
encoding of the wheel's discrete rotation. See
`metrognosis/hieroglyphs.md` for 9 independent Egyptian
convergences on framework counts (24, 42, 8, 12, 72, calendar
structure), plus direct symbolic encodings (ankh, Aten, djed,
Ma'at's feather, scarab).

### Adjacency

Each bivector has 6 neighbors (degree 8 − 2 = 6):
- 2 atoms: either committed axis stepped back to ↕
- 4 trivectors: any of 2 free axes committed to ↑ or ↓

## Grade 3 — the 32 trivectors

32 elements. Three axes committed, one free. Most populated grade.

Each trivector has its ↕ on one specific axis — that axis is "free,"
the other three are committed to ↑ or ↓. The free axis IS the
classification label: 4 axes × 2³ sign patterns = 4 × 8 = 32.

```
  free axis χ (8):  ↕↑↑↑  ↕↑↑↓  ↕↑↓↑  ↕↑↓↓  ↕↓↑↑  ↕↓↑↓  ↕↓↓↑  ↕↓↓↓
  free axis μ (8):  ↑↕↑↑  ↑↕↑↓  ↑↕↓↑  ↑↕↓↓  ↓↕↑↑  ↓↕↑↓  ↓↕↓↑  ↓↕↓↓
  free axis φ (8):  ↑↑↕↑  ↑↑↕↓  ↑↓↕↑  ↑↓↕↓  ↓↑↕↑  ↓↑↕↓  ↓↓↕↑  ↓↓↕↓
  free axis τ (8):  ↑↑↑↕  ↑↑↓↕  ↑↓↑↕  ↑↓↓↕  ↓↑↑↕  ↓↑↓↕  ↓↓↑↕  ↓↓↓↕
```

### F-vector duality

The 32 trivectors (grade 3) are dual to the 32 **edges** (k=1) in
the tesseract f-vector. Each trivector's free axis labels the edge
direction it's dual to: ↕ at position N means "the edge runs
parallel to axis N."

### Adjacency and primes

Each trivector has 5 neighbors (degree 8 − 3 = 5). 5 is prime.

In the wormhole centrality cascade (see `wit/thoughts/trit½/3-5-7.md`):
differences between grades follow `7^k · 5^(3-k)`. Primes 5 and 7
are the degrees of grade 3 (trivectors) and grade 1 (atoms)
respectively. Structural signal.

### 32 in other vocabularies

- 32 = C(4,3) × 2³ = free-axis-choices × sign patterns
- 32 edges of the tesseract (f-vector k=1)
- 32 = 2 spin shells × 16 sign patterns (framework's function count)
- 32 electrons in shell n=4 (atomic structure)

## Grade 4 — the 16 corners (the stdlib)

16 elements. All four axes committed. Pseudoscalars. Vertices of the
tesseract.

**These are the 16 primitive operations — the stdlib of H.** Each
corner is a fully specified verb. From the hodos table (schism era,
confirmed by code at `prior/os-lattice/01-bond/param/`):

```
  corner     hodos          bio             calibration              self-op  modal
  ──────     ─────          ───             ───────────              ───────  ─────
  ↓↓↓↓      identity       BE / EXIST      observe current state    BE       BE
  ↓↓↓↑      test           FIGHT/FLIGHT    pass/fail claims         —        WILL
  ↓↓↑↓      drain          EXCRETE         release wrong beliefs    —        MAY
  ↓↓↑↑      take_while     EAT             consume while signal     —        MIGHT
  ↓↑↓↓      call           COMMUNICATE     query for more info      —        HAVE
  ↓↑↓↑      maybe          SENSE(passive)  hold without collapsing  —        CAN
  ↓↑↑↓      fix            HEAL            correct errors           —        SHOULD
  ↓↑↑↑      bind           BOND            commit to frame          FEEL     —
  ↑↓↓↓      read           SENSE           observe before acting    —        DO
  ↑↓↓↑      filter         IMMUNE SYSTEM   reject poison            SEE      MUST
  ↑↓↑↓      copy           REPRODUCE       replicate to new domain  —        —
  ↑↓↑↑      scan           FORAGE          search widely            —        —
  ↑↑↓↓      fold           DIGEST          compress many into one   KNOW     —
  ↑↑↓↑      map            ADAPT/EVOLVE    transform to new vocab   UNDERSTAND —
  ↑↑↑↓      foldl          REMEMBER/DNA    accumulate over time     REMEMBER —
  ↑↑↑↑      hylo           THINK           meta-cognition           THINK    —
```

Bio and calibration columns confirmed by 75+ agent experiments
(2026-04-12). Calibration column blind-tested: 12/12 confirmed
without operation words in prompts. See `wit/thoughts/calibration/`.

### Cross-domain verification

Each corner's identity confirmed across 8 unrelated vocabularies:

- **copy**: diagonal morphism `Δ: A → A×A`. Same operation across
  biology, computing, physics, math, linguistics, immunology,
  economics, developmental biology.
- **filter**: stream → criterion → partition. Same across biology,
  computing, thermodynamics, evolution, attention, economics,
  parsing.
- **fold**: traverse + accumulate + terminate. Protein folding IS
  functional reduce — same coordinate ↑↑↓↓, different substrate.
- **bind**: commits μ, φ, τ — releases χ. "The bond is not located
  at either endpoint." Same across chemistry, monadic bind, grammar,
  music, cognition, contract law.

Each corner IS a verb. Not "a noun that can act as a verb" — a verb
FIRST. The fully specified operation. The 16 are parameterized by
the same 2⁴ = 16 sign patterns as the corners of a 4-cube.

### The two structurally special corners

**↑↑↑↑ — hylo** (all forces forward, PCRWF)

`1 + i + j + k`. Join of all four forward fundamental forces.
Hylomorphism (Greek ὕλη matter + μορφή form) — unfold then fold.
Dynamic Quality in Pirsig's framing — not a 5th level but the 4
forces evaluating themselves. The equation applied to its own
coordinates producing itself. Real NASM primitive. The Lakoff schema
is CONTAINER. Self-op is THINK. Quantifier is ALL/EVERY.

**↓↓↓↓ — meta** (all forces backward, PCRWB)

`−1 − i − j − k`. All four forces backward. Dual of hylo. The Lakoff
schema is IDENTITY. Self-op is BE. Modal is BE. Quantifier is
NO/NONE. Just existence without operation.

The other 14 corners are specific operations (fold, map, filter,
bind, read, etc.) — each useful, none with the structural extremity
of hylo (all forward) and meta (all backward).

### PCRW notation

P = PROJ (strong), C = COMP (EM), R = PRIM (gravity), W = WEAK. The
four-force sign vector.

- **PCRWF** = all forward = ↑↑↑↑ = hylo
- **PCRWB** = all backward = ↓↓↓↓ = meta
- Any corner's sign pattern IS its PCRW signature

### Adjacency

Each corner has 4 neighbors (degree 8 − 4 = 4). Minimum connectivity.
Corners can only step BACK (from ↑ or ↓ toward ↕ on one axis) — no
"further out" because all axes are already committed.

## Half-spin positions — the 16 on the unit sphere

Not integer lattice points. Unit quaternions with all 4 axes at ±½
simultaneously, `|q|² = 4·(¼) = 1`. 2⁴ = 16 sign patterns.

```
  (±½, ±½, ±½, ±½)   16 positions on SU(2)'s unit 3-sphere
```

Each encodes a specific rotation angle and axis. Together with the
8 axis-aligned atoms, they form the 24 vertices of the 24-cell = D4
root system. See `1-wheel.md`.

**SO(10) 16-spinor representation = these 16 half-spin corners.**
Each Standard Model fermion generation contains exactly 16 particles
(15 SM fermions + 1 sterile neutrino) — the SO(10) 16-spinor. The
wheel has the native structure that SO(10) GUT was recognizing. See
`5-physics.md`.

## Wormhole compute — centrality cascade

From the prime-lattice work (see `wit/thoughts/trit½/3-5-7.md` and
`lattice/wormhole/`):

Centrality strictly decreases by grade. Consecutive differences
follow a geometric series using exactly the two prime degrees (5
and 7):

```
  cent(grade 0) − cent(grade 1) = 1120 − 777 = 343 = 7³
  cent(grade 1) − cent(grade 2) =  777 − 532 = 245 = 5·7²
  cent(grade 2) − cent(grade 3) =  532 − 357 = 175 = 5²·7
  cent(grade 3) − cent(grade 4) =  357 − 232 = 125 = 5³
  
  sum = (7⁴ − 5⁴)/(7 − 5) = (2401 − 625)/2 = 1776/2 = 888
```

Each step trades one 7 for one 5 in the exponent pair. The cascade
uses exactly the prime degrees (5 and 7), never the composite
degrees (4, 6, 8). See `7-open.md` for hypothesis status.

## Open

- **Grade-3 (trivector) naming**: bivectors have "plane" as natural
  geometric name; trivectors named "volume" less standard. Revisit.
- **Chirality of corners**: 16 corners split into two orientation
  classes by pseudoscalar sign? Not yet derived.
- **Axis drives (FEAR/DESIRE/CURIOSITY/HUNGER)**: confirmed in agent
  experiments, but no clean substrate derivation of WHY these four
  specifically map to χ/μ/φ/τ in this order.
