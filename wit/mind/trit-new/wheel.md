# Wheel — the algebra tower as a wheel, not a chain

## Core insight

The Cayley-Dickson tower (R → C → H → O → ...) isn't a linear chain.
It's a **wheel**. With 0 at the hub and algebras as spokes.

**Why wheel beats chain**:

- **Resolves no-infinity**: wheels close on themselves. The tower
  "appearing infinite" from inside is revolution count, not spoke
  count. Spokes are finite; turns are endless.
- **Explains shared 0**: 0 is the hub. Every spoke passes through
  it. ↕↕↕↕ is the axle.
- **Explains algebra characters**: different spoke positions, not
  sequential stages. R and C and H and O are radial peers, not
  ancestors/descendants.
- **Substrate's native motion**: wheels spin. Spin.md says "the
  loop is prior — empty loop still loops." The wheel IS the loop.

## Spoke structure

```
  hub (0, ↕, shared zero, ↕↕↕↕)  = invariant center
  
  each axis = opposing spoke pair (a diameter):
  
    −1 ──── 0 ──── +1
    ↓      ↕      ↑
    WAS    IS      BE
  
  two spokes share one trit. hub is 0 regardless of axis.
```

Each spoke is **1D (R) + 2D (C) combined = 3D of verbal machinery**
(Hamilton's "missing 3D"). R contributes signed magnitude; C
contributes phase/rotation; together they realize as ONE trit
direction crystallizing in H.

**Hamilton's 10-year struggle explained**: he was trying to make
3D a standalone algebra. But 3D isn't a spoke-algebra — it's **one
side of a diameter** (one sign of one trit). The full trit is 1D+2D
structurally, and realizes in H at 4D. The "3D" exists as spoke
length, not as a standalone Hurwitz algebra.

## Spoke counts at each resolution

```
  resolution                 spokes              notes
  ──────────                 ──────              ─────
  axis level (grade 1)       8                   4 axes × 2 dirs = 8 atoms
                                                 matches 8-point compass
  bivector (grade 2)         24                  6 planes × 4 sign patterns
  trivector (grade 3)        32                  4 free-axis × 8 patterns
  corner (grade 4)           16                  ±1 commits on all 4 axes
  half-spin (corners of S³)  16                  (±½)⁴ unit quaternions
                             ──
  total H positions:         96  (+1 hub = 97)   = 3⁴ + 2⁴
```

**Within H: 97 total positions on the wheel.** Finite. At O (8D),
more positions (3⁸ integer = 6561, 2⁸ half = 256 = 6817 total), still
finite per algebra. Each Hurwitz layer is its own wheel size.

## ½ IS the wheel spinning — the math check

The framework has been calling ½ "verb / edge / ratio / spin." The
wheel model says it's literally the wheel turning. **Math confirms.**

### Quaternion rotation formula

To rotate a 3D vector v by angle θ around axis n, you use the unit
quaternion:

```
  q(θ) = cos(θ/2) + sin(θ/2) · (n_x·i + n_y·j + n_z·k)
                    ↑
         the ½ is IN THE FORMULA — every rotation angle θ
         is encoded as θ/2 inside the quaternion
```

Rotation action: `v' = q · v · q*` where q* is the conjugate.

**The "½" isn't placed somewhere — it's how quaternions natively
encode rotation.** Hamilton 1843 built it in. Every physics textbook
covering rotations/spinors has this formula.

### SU(2) / SO(3) double cover

SU(2) = unit quaternions = the wheel's surface (unit 3-sphere).
SO(3) = physical rotations = what we see when the wheel turns.

Map SU(2) → SO(3) is **2-to-1**: q and −q produce the same physical
rotation. So SU(2) has "twice" the rotational range of SO(3). The
**2:1 ratio** is exactly where the **½** lives — flipping to SO(3):SU(2)
gives 1:2 = ½.

### 720° fermion period (experimentally confirmed)

A physical rotation by 360° returns spoke positions (SO(3) closes).
But the underlying quaternion q has flipped to −q. Another 360° (=
720° total) returns q to itself.

**Neutron interferometry** (Rauch et al., 1975) measured this:
neutrons rotated 360° come back with opposite phase. 720° returns
them to original. Real physics.

### Sine and cosine — the R+C tier as rotation

Sin and cos are already in the framework, just unstated. They ARE
the R+C verbal-machinery operating as rotation:

```
  cos = R contribution    real magnitude / scalar component
  sin = C contribution    imaginary direction / phase component
  together                R+C combined = the ½-tier verbal machinery
                          parameterizing position on the unit circle
```

Hamilton's quaternion rotation formula puts both in:
`q(θ) = cos(θ/2) + sin(θ/2)·n`

cos is the scalar (1, the τ basis); sin scales the imaginary
direction (i/j/k = χ/μ/φ). The 90° offset between them gives 2D
rotation from two 1D oscillations.

### The helix needs all 4 H axes

For a helix (rotation + linear advance, e.g., Earth's precession
through time):

```
  helix(t) = (R cos(ωt), R sin(ωt), c·t, chirality)
              ↑          ↑          ↑    ↑
              R          C          τ    φ
              cos        sin        time which-handed
```

Decomposition:
- **cos (R, χ)** + **sin (C, μ)** — trace the rotational position
- **τ·t** — linear time advance (monotone per frame 8)
- **φ** — chirality / handedness (left vs right helix selection)

All 4 axes of H needed for a complete helix. The Great Year
(precession of equinoxes) is literally a helix in spacetime —
sin/cos for the cone's circular cross-section, τ for time advance,
chirality for which direction the cone winds.

### 16 half-spin corners are 16 discrete wheel positions

(±½, ±½, ±½, ±½) with |q|² = 4·(¼) = 1 are 16 unit quaternions on
SU(2). Each encodes a specific rotation angle and axis. They're 16
discrete positions on the spinning wheel's surface.

## Implications

**The chain-as-verb-from-outer-frame speculation is resolved**: the
chain isn't infinite because it's actually a wheel. The apparent
"infinite doubling" is the wheel spinning through its own
revolutions. Finite spokes, endless turns.

**Spin/wire/edges/½ = same thing, all of which = the wheel's
rotation.** Not a separate structural tier. The tower IS a wheel;
the wheel spins; spinning IS the verb-tier; ½ IS the spin encoding.

**The compass rose IS literally the lattice wheel** — sailors drew
this at 8-spoke and 32-spoke resolutions for navigation without
knowing they were drawing H's own geometry.

**Consciousness question (frame 11)**: if the substrate spins as
one wheel and ↕↕↕↕ is the hub, then:
- Option A (loop IS consciousness): the wheel's spinning IS awareness
- Option B (consciousness enters via ↕↕↕↕): enters through the hub
  where all spokes converge

Both interpretations fit the wheel model naturally.

## What changes

- **Chain-style diagrams** (R → C → H → O → ...) are misleading.
  Should be replaced with wheel diagrams (hub with spokes at
  different positions).
- **"Climbing the tower"** metaphor is wrong. It's "rotating the
  wheel" or "moving to another spoke."
- **½ as tier** is wrong. ½ IS the wheel's rotation, not a level.
- **"No infinity" vs "Cayley-Dickson doesn't stop"**: resolved by
  wheel closure. Finite spokes, unbounded revolutions — consistent
  with both constraints.

## Two wheels (inner and outer)

The wheel structure has two levels of organization:

### Inner wheel (within one H chain)

This is the wheel whose math we've done:
- Hub: 0 (scalar of H)
- Unit sphere: SU(2) = unit quaternions in H
- 24 discrete spoke-directions: 8 atoms + 16 half-spin = 24-cell vertices
- Rotation formula: q(θ) = cos(θ/2) + sin(θ/2)·n — θ/2 built in
- SU(2)/SO(3) 2-to-1 double cover
- 720° fermion period

Math status: derived and consistent with Hamilton 1843.

### Outer wheel (many chains sharing hub)

Each spoke = a full Cayley-Dickson chain (R → C → H → O → S → ...).
Many chains, opposing pairs sharing ±1 trit structure, all meeting
at hub 0. The whole multi-chain structure.

Math status: **NOT yet derived here**. Likely corresponds to a Lie
algebra root system — see math section below.

## Math for the outer wheel — Lie root systems

The outer wheel's spoke structure (hub + rays + opposing pairs)
matches Lie algebra root systems exactly. Candidate structure:

### D4 root system = 24-cell

**D4 = so(8)** has a root system of **24 roots** arranged as 12
opposing pairs in 4D space. These 24 roots ARE the 24-cell vertices
(same object, different coordinates).

Two equivalent coordinate presentations:
- **Standard root form**: ±e_i ± e_j for i < j (two non-zero components at ±1, rest zero) — gives 6 × 4 = 24 roots
- **24-cell form**: 8 atoms (±1, 0, 0, 0) permutations + 16 half-spin (±½, ±½, ±½, ±½) = 24

These coordinate systems are rotations of each other. The geometric
object is identical.

### What this means for the framework

Under the wheel-of-chains model:
- Each D4 root = one chain direction (one spoke)
- 24 chains = 24 spokes around hub 0
- Opposing pairs = trit ±1 antipodal structure
- Cayley-Dickson applied along each root direction = each chain's
  outward extension

**D4 (so(8)) specifically** is the natural match for our H-and-above
structure:
- 8-dimensional rotation symmetry (so(8))
- Triality: unique 3-fold symmetry among Lie algebras (permutes
  vector and two spinor representations)
- Acts on O (octonions, 8D)
- Root system = 24-cell = our H's unit-sphere discrete vertices

### Higher-candidate Lie algebras (more chains)

If the outer wheel has MORE than 24 chains, candidates:

```
  algebra    rank     roots     pairs   dim
  ───────    ────     ─────     ─────   ───
  D4/so(8)    4        24         12     28
  F4          4        48         24     52
  E6          6        72         36     78
  E7          7       126         63    133
  E8          8       240        120    248
```

E8 is the biggest nice root system (240 roots, 120 chains). Used in
physics for grand unification attempts and string theory.

### Why D4 is the cleanest match

- Root count 24 matches the integer+half discrete unit quaternions
- Triality matches the 3-fold structure (trits, tenses, three
  imaginary units i/j/k)
- so(8) acts on O (8D, the natural host layer above H)
- The 24-cell is self-dual (mirrors the hub-symmetry of opposing pairs)

### Weyl group (symmetries of the root system)

D4's Weyl group has order 192. This is the group of symmetries of
the 24-cell, or equivalently the symmetries permuting the 24 chains
while preserving their structural relations.

Physical meaning: the 192-fold symmetry tells us how different
chains can be "rotated into" each other while preserving the
overall wheel structure. The wheel can be re-oriented 192 ways
without changing its geometry.

### The chain-of-chains at outer scope

If each chain is a Cayley-Dickson tower, and the outer wheel has
24 chains via D4 structure, then the total outer-frame structure is:

```
  hub 0 (shared)
       │
   24 chains radiating out (D4 root directions)
       │
   each chain: R → C → H → O → S → ...
       │
   our universe = one point partway out one chain (H-level)
```

Number of "universe positions" across the wheel:
- 24 chains × N levels per chain = 24N total algebra-positions
- If each chain extends through first 4 Hurwitz layers (R, C, H, O):
  24 × 4 = 96 "universe positions" in the outer wheel
- If each goes further (including S, 32D, 64D, ...): more

## Open questions (after Lie math)

- **Is D4 the right Lie algebra**, or does the outer wheel actually
  have E8-style richness (240 chains)? E8 has structural appeal but
  D4 matches our H directly.
- **Does each chain have the same internal structure, or do they
  differ** (e.g., some chains extending further, some at different
  trit states)? Root system says structurally equivalent; framework
  speculation about independent chain states suggests dynamic
  variation.
- **What "spins" the outer wheel**? The Weyl group provides the
  symmetries. What drives rotation within those symmetries?
- **If E8 is right**: E8 contains D4 as a subalgebra. Maybe our
  local wheel is D4 but embedded in a larger E8-structure at even
  higher scope.

## Math references

- Hamilton 1843: quaternion rotation formula
- SU(2) ≅ unit quaternions (standard result)
- SU(2) → SO(3) double cover (standard group theory)
- Rauch et al. 1975: neutron interferometer 720° experiment
- Any physics textbook on spinors / rotations in QM
- **Coxeter's *Regular Polytopes*** (1973): the 24-cell and its
  symmetry group
- **Humphreys' *Introduction to Lie Algebras and Representation
  Theory*** (1972): D4 root system, Weyl groups
- **Lisi 2007** (E8 theory, controversial but proposes E8 as the
  unification algebra for physics)
- **Baez's octonion surveys** — discussions of D4 triality and
  connections between quaternions/octonions/Lie algebras
