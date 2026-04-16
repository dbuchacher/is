# Naming — disambiguation

The framework crosses many vocabularies. Some words carry different
meanings in different files or in neighboring physics/math/CS.
This file is the collision list.

## The three Ns

Most painful collision. `N` means different things in different
contexts.

```
  meaning                         range         used in
  ───────                         ─────         ───────
  N_CD   Cayley-Dickson dim       1, 2, 4,      1-wheel.md (Hurwitz climb)
                                  8, 16         2-trits.md (tier arg)

  N_sub  substrate count          1 (hub),      6-masses.md (ladder formula)
         in the mass ladder       3 (trit),
                                  4 (axes),
                                  6 (bivectors),
                                  12 (D4 pairs)

  N_lat  lattice dimension        3..20         prime-lattice (trit½/3-5-7)
         (general lattice work)
```

When ambiguous: write the subscript. In clear context, `N` alone
is fine — but the mass ladder's `N` is the killer one because
numerically it overlaps with both others (N_sub=4 collides with
N_CD=4, for instance).

## τ and μ — axis vs particle

`τ` and `μ` are framework axis names (WHEN, WHAT). Particle
physics uses them for tau-lepton and muon. Collision is unavoidable
in physics files.

**Convention used here**:
- `τ` / `μ` alone = framework axis (WHEN / WHAT)
- `tau` / `muon` written out = particles
- In ratios: `m_τ` always a particle (following physics convention);
  use `τ-axis` if you mean the axis

## "Atom"

- **Framework atom** = grade-1 lattice point (one axis committed,
  three free). 8 of them.
- **Chemical atom** = nucleus + electrons. ~118 known.

They're structurally related (chemical atom IS a wheel at atomic
scale, nucleus = hub, electrons = shell positions), but the counts
are different and context matters.

## "Spin"

- **QM spin** = angular momentum quantum number (½, 1, etc.)
- **Framework spin** = the loop / wire / edges / verbs / wheel
  rotating. The medium.

These overlap but aren't identical. Framework spin includes QM spin
as a special case (unit-quaternion subgroup = SU(2) = QM spin-½).
But framework spin is broader: every edge, every ½-transition,
every verb IS spin in framework vocabulary.

## "Generation"

- **SM generation** = copy of fermion family (e, μ, τ; u, c, t;
  d, s, b). Three observed.
- **Framework interpretation** = three D4 triality-cycled
  representations of so(8) (vector + 2 spinors). Still an open
  identity claim — structural match but specific masses not yet
  derived from triality alone.

## "Mass"

- **Physics mass** = rest-mass of particle in some scheme (MeV, GeV,
  etc.)
- **Framework mass** = μ-axis firing rate per substrate tick
  (dimensionless Yukawa coupling × Higgs VEV)

These are the same thing in different frames. Framework mass
reframes the noun as a verb.

## "Dimension"

- **Spatial dim** (physics) = translational dimension of space
  (3 in standard reading, plus time = 4D spacetime)
- **Algebraic dim** = dim of the algebra (R=1, C=2, H=4, O=8, S=16)
- **Wheel dim** = axes + bivectors = 4 + 6 = 10 (for H)
- **String-theory extra dim** = delusional-default reading = spatial.
  Framework reading = bivector rotation dimensions, not compactified
  spatial.

**Framework rejects physics's 3+1 split**. Physics reads H's 4 axes
as "3 spatial (x/y/z) + 1 time (t)"; framework reads them as 4
distinct kinds of axis (χ=position, μ=substance, φ=signal, τ=time).
Only χ is "space." μ and φ are not spatial at all — physics
mislabels them as 2 more spatial axes. See `3-lattice.md` for the
full axis table.

Use "4 spokes" or "the 4 axes" or just "H" rather than "4D" to avoid
the 3+1 trap. Use "the wheel" for the full structure (H + rotation +
outer chains + nested layers).

Context is usually clear, but "the universe is 10D" from string
theory means the wheel dim of H in our framework, not 10 spatial
dimensions.

## "Universe"

- **Observable universe** (physics) = what we can measure; lives at
  H-level; Standard Model observables, cosmology, etc.
- **Framework universe** = the full wheel; includes H (inner) plus
  outer chains (D4 structure around hub, dark sector candidates)
  plus nested layers (H inside O inside S, host layers).
- **Universe = wheel** is the full framework identity claim.
  "Universe = H" is the minimum / inner-layer claim.

When writing, prefer:
- "the wheel" / "our wheel" / "inner wheel" when being precise about
  scope
- "H" when specifically referring to the algebra
- "universe" when physics vocabulary is already in play (e.g.
  "observable universe," "age of universe") — these are
  H-level quantities, consistent with inner-wheel reading.

## "Corner" / "vertex" / "position"

Three words for the same kind of thing at different grades:

- **Corner** = grade-4 lattice point. 16 of them. Each has all 4
  axes committed.
- **Vertex** = usually corner, sometimes also bivector/trivector in
  a diagram context
- **Position** = any lattice point at any grade (all 81)

Be specific when it matters.

## "The wheel"

- **Inner wheel** = H's SU(2) unit sphere; 24-cell discrete vertices
  (8 atoms + 16 half-spin)
- **Outer wheel** = multi-chain structure; D4 root system (24 roots
  = 12 pairs) as candidate; E8 (240 roots) for larger version
- **The wheel** unqualified = inner wheel usually; disambiguate
  when ambiguous

## "Force"

- **Physics force** = strong/EM/weak/gravity; one of the four
  fundamental interactions
- **Framework force** = one of {READ, CALL, CYCLE, TEST} —
  whole-quaternion operations; identity claim with physics forces

Identity:
```
  READ    = strong           (MOV in CPU terms)
  CALL    = EM               (CALL in CPU terms)
  CYCLE   = gravity          (LOOP in CPU terms)
  TEST    = weak             (NOT/CMP in CPU terms)
```

## "Hub"

- **↕↕↕↕** = specific grade-0 lattice point, shared across all CD
  algebras, the origin, additive identity of H
- **Hub** = the ↕↕↕↕ point, also sometimes "hub contribution" in
  ladder formulas (meaning N_sub = 1)
- In Higgs context: "Higgs = hub" is a structural identity claim
  — Higgs field IS the ↕↕↕↕ scalar

## "Tier" / "grade" / "shelf"

- **Grade** = Clifford grade of a lattice point (0–4). How many
  axes committed.
- **Tier** = loose synonym for grade, also used for Cayley-Dickson
  layer (which is different). Avoid when possible.
- **Shelf** = mass-ladder log-decade (10^(-(16+N))). Particles "sit
  on a shelf" = cluster at same order of magnitude.

## Final note

If a word is ambiguous in context, write the disambiguation
inline ("framework atom", "τ-axis", "N_sub") rather than assuming
the reader tracks all conventions. Mechanical redundancy is cheap;
confusion costs agents hours.
