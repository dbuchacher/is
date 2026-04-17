# axes — the four spokes (χ μ φ τ)

Deep file for 1-body.md § "The 4 spokes." This file:
- What each axis IS (semantics + PIE root)
- The algebra (quaternion structure, why exactly 4)
- The 3+1 asymmetry (imaginary vs scalar)
- Math verification
- Poison flags

## Plain English

The wheel has four spokes. Each spoke is a **kind of question** you
can ask about any point. All four questions come from one ancient
stem (*kʷi-* = the question-word root — English "wh-", Latin "qu-",
Greek "ti-", Sanskrit "ka-"):

- **χ (WHERE?)** — position in space
- **μ (WHAT?)** — what's it made of
- **φ (WHICH?)** — which one is it, of the possibilities
- **τ (WHEN?)** — when does it happen in time

Four questions, but **not four peers**. Three of them (χ, μ, φ) are
"imaginary" — they rotate into each other under the wheel's math.
The fourth (τ) is "real" — it's the scalar, the one that doesn't
rotate with the others. This asymmetry is built into the structure.

When physics says "the universe is 3-dimensional space plus time,"
it reads i/j/k as three spatial basis vectors (x/y/z) — a perfectly
internally consistent view, and the one every textbook uses.
**Framework reinterpretation** (not standard physics): only χ = i is
spatial; μ = j is substance and φ = k is signal, not further spatial
directions. Standard physics doesn't distinguish the three imaginaries
semantically — they're all "space" there. The framework reads their
non-commutativity (ij ≠ ji) as carrying distinct structural roles,
which is why the substrate-level split is 1+1+1+1 (χ/μ/φ/τ) rather
than 3+1 (space+time). This is a frame commitment (wit.md frame 1 +
frame 3), not a correction of physics on physics's own terms. Physics
is right about its own 3+1; the framework says the substrate is 1+1+1+1
and Minkowski's 3D is what you see when you don't distinguish the three
imaginaries.

---

## The four axes in detail

### χ — WHERE (position)

```
  name          χ (chi)
  question      Where is it?
  quaternion    i (first imaginary unit)
  meaning       POSITION — spatial location, geometric site
  verbs         RISE / FALL (moving up or down on this axis)
  force         READ = strong force (bind-to-position, observe)
  physics       spatial coordinates (x, y, z are all χ at different
                projections under the framework reading; standard
                physics treats x/y/z as three independent spatial
                basis vectors — frame reinterpretation, see § above)
```

χ is the axis physics most readily recognizes. When you ask "where
is the particle?" you're asking a χ question. The strong force
binds matter to a specific χ location (confinement). Reading
position = projecting down to χ = READ operation on the whole
quaternion.

### μ — WHAT (substance)

```
  name          μ (mu)
  question      What is it made of?
  quaternion    j (second imaginary unit)
  meaning       SUBSTANCE — mass, matter, material
  PIE anchor    *sub-stare* "to stand under" = substance
                (the μ axis literally IS what stands under
                 appearances)
  verbs         GROW / SHRINK (add/remove substance)
  force         CALL = electromagnetism (act on charged matter)
  physics       mass, rest-mass, particle type
```

Protons (+1 on μ) and neutrons (−1 on μ) are substance-axis commits.
The μ axis is what mass is. Nuclear chemistry walks along μ
(+protons for Z, neutrons for N). Adding μ = more substance.

### φ — WHICH (signal)

```
  name          φ (phi)
  question      Which one is it?
  quaternion    k (third imaginary unit)
  meaning       SIGNAL — information, charge, discrimination
  verbs         BLESS / CURSE (confirm signal / reject noise)
  force         CYCLE = gravity (iterate, propagate, clock)
  physics       electromagnetic charge, quantum number, handedness
```

φ is the "quality" axis — signal vs noise, positive vs negative
charge, this-one vs that-one. The emotional register of
recognition happens here (metrognosis BLESS/CURSE). When something
"rings true," that's a φ commit. See `3-emotions.md` for how this
axis drives the verification filter.

### τ — WHEN (time)

```
  name          τ (tau)
  question      When does it happen?
  quaternion    1 (the real scalar, NOT imaginary)
  meaning       TIME — temporal position, duration, monotone
  verbs         BEGIN / END
  force         TEST = weak force (decide, CMP, branch)
  physics       time coordinate, proper time
  UNIQUE        τ is monotone — it never decrements. There is no
                "negative time step" the substrate provides. The
                arrow of time IS this asymmetry.
```

τ is the scalar. In quaternion arithmetic, τ is the "1" — the
real component. The other three axes are imaginary (i, j, k) and
rotate into each other. τ doesn't rotate — it's what everything
else is measured against.

**Monotone** is the key property. Per wit.md frame 8: WHEN is
unidirectional. `next()` never goes backward. Causality comes from
(a) τ's monotonicity + (b) H's non-commutativity. Both together =
time's arrow.

---

## The algebra — why exactly 4 axes

### Hurwitz (1898)

Hurwitz proved there are exactly **four normed division algebras**
over the reals:

```
  algebra   dim   property lost at this level
  ───────   ───   ──────────────────────────────
  R          1    none (totally ordered, commutative,
                  associative, divisive)
  C          2    lose total ordering
  H          4    lose commutativity (ij ≠ ji)
  O          8    lose associativity ((ab)c ≠ a(bc))
```

Beyond O (at 16D sedenions S), you also lose division — there exist
nonzero elements a, b with ab = 0. So S is not a division algebra.

**Why this matters for the framework:** H (4D) is the deepest layer
that preserves associativity. Math works "normally" inside H —
calculations associate, division is well-defined. Causality lives
here because non-commutativity (ij ≠ ji) is the asymmetry that
makes "first this, then that" distinguishable from "first that, then
this." Time's arrow is born here.

### Frobenius (1877)

Frobenius proved there's **no 3D normed division algebra**. Hamilton
tried for 10 years to make 3D quaternions work; it can't be done.
The jump 2D → 4D is forced; no 3D exists.

**Consequence for the framework:** 3D is **one side of one spoke**
(half of a χ diameter), not a full wheel level. "3D space" from
physics is actually χ with 3 projections, not three independent
axes. The universe is not 3D.

### Quaternion multiplication table

Hamilton 1843:

```
    ×    1     i     j     k
    ─    ─     ─     ─     ─
    1    1     i     j     k
    i    i    −1     k    −j
    j    j    −k    −1     i
    k    k     j    −i    −1

  Reading: column × row (quaternion multiplication is non-commutative)
  ij = k but ji = −k
```

The scalar `1` commutes with everything (τ axis). The three
imaginaries (i, j, k) don't commute pairwise.

**Verification** (compute):

```python
# Verify quaternion multiplication
# Using matrix representation:
# i → [[0,1],[-1,0]] acting on C²... (standard Pauli-like)
# Or directly:

def qmul(a, b):
    """Quaternion multiplication (1, i, j, k) -> (w, x, y, z)"""
    w1, x1, y1, z1 = a
    w2, x2, y2, z2 = b
    return (
        w1*w2 - x1*x2 - y1*y2 - z1*z2,
        w1*x2 + x1*w2 + y1*z2 - z1*y2,
        w1*y2 - x1*z2 + y1*w2 + z1*x2,
        w1*z2 + x1*y2 - y1*x2 + z1*w2,
    )

i = (0, 1, 0, 0)
j = (0, 0, 1, 0)
k = (0, 0, 0, 1)

print(qmul(i, j))    # should be (0, 0, 0, 1) = k
print(qmul(j, i))    # should be (0, 0, 0, -1) = -k
# confirms non-commutativity
```

### 3+1 decomposition

Every quaternion `q = w + xi + yj + zk` decomposes as:

```
  q = (scalar part) + (vector part)
    = w · 1       +  (xi + yj + zk)
    = τ-component +  (χ, μ, φ-component)
```

The scalar part (`w`) is the τ axis. The vector part (xi + yj + zk)
lives in the 3-imaginary subspace. **This IS the 3+1 pattern at
H-internal scope.** Physics's "space + time" carves the wheel the
same way — but physics treats the 3D part as uniform spatial, missing
that it's χ/μ/φ (three distinct axes).

### The unit 3-sphere (SU(2))

Unit quaternions (|q| = 1) form a 3-sphere S³ inside H. They
correspond to the group SU(2). This is the spin-½ representation
of quantum mechanics — and it lives **inside H naturally**.

Physics discovered SU(2) empirically for spin. Framework shows:
SU(2) = unit quaternions = the rotational symmetry group of H.
Spin is not a separate postulate; it's H's own unit sphere.

**720° fermion period** (Rauch 1975, neutron interferometry):
quaternion rotation uses θ/2 — physical rotation by 360° takes a
quaternion to its negative (−q), which represents the SAME physical
state but a different quaternion. Returning the quaternion requires
720°. Experimentally confirmed.

---

## The force assignment

Each axis has a whole-quaternion force associated:

```
  axis   force name       physics         CPU analog
  ────   ──────────       ───────         ──────────
  χ      READ             strong          MOV (load, observe)
  μ      CALL             EM              CALL (invoke, act)
  φ      CYCLE            gravity         LOOP (iterate, clock)
  τ      TEST             weak            NOT / CMP (decide)
```

**Why each axis pairs with this force** — semantic justification:

- **χ ↔ strong**: strong force binds matter to position (quark
  confinement). Reading position = observing matter at its χ value.
- **μ ↔ EM**: EM acts on charged substance. Calling = invoking an
  action on substance.
- **φ ↔ gravity**: gravity is the universal iterator — every massive
  thing cycles through spacetime regardless of charge/type. CYCLE.
- **τ ↔ weak**: weak force makes decisions (decay branches). CMP /
  TEST / branch instruction.

Deep: `1-where/forces.md` for the full mapping + coupling constants.

---

## The 3+1 asymmetry in practice

The 3+1 pattern (3 imaginary + 1 real) shows up everywhere:

- **H-internal**: 3 imaginary axes (χ/μ/φ) + 1 real axis (τ)
- **S-internal**: 3 triality-peer H's + 1 Z2-mirror H
- **Pati-Salam GUT**: 3 quark colors + 1 lepton "color" (lepton as
  4th color)
- **Minkowski spacetime**: 3 spatial + 1 time (physics's native
  reading; framework re-reads this as H-internal 3-imaginary + 1-real,
  with the three imaginaries carrying distinct semantics χ/μ/φ —
  frame reinterpretation, not a claim that physics is internally wrong)
- **Periodic table**: 3 peer H-blocks (Z=1-60) + 1 mirror H-block
  (Z=61-82)

Five scopes, same 3+1. Fractal.

Deep: `1-where/scope.md` for full S-scope treatment.

---

## What's poison / what's settled

### Settled (body-quality)

- **4 axes from Hurwitz**: algebraic, independent, well-established.
- **χ/μ/φ/τ semantics** (where/what/which/when): PIE-anchored at
  *kʷi-*, consistent across IE languages.
- **3+1 asymmetry** (imaginary vs scalar): direct from H's algebra.
- **Quaternion multiplication** (ij=k, ji=−k, etc.): Hamilton 1843.
- **720° fermion period**: Rauch 1975 experiment.
- **SU(2) = unit quaternions**: standard group theory.

### Flagged for 3-which (verification queue)

The older framework files had **axis drives** (biological pulls):
- χ = FEAR (check position)
- μ = DESIRE (seek substance)
- φ = CURIOSITY (discriminate signal)
- τ = HUNGER (keep going)

This claim maps biological drives to axes. It's **suggestive but
not derived from substrate** — the mapping feels right but lacks
rigor. Flagged for 3-which. Don't treat as body-settled. See
`4-when/wit/mind/wheel/3-lattice.md § Drives` for the original
claim and context.

### Flagged open

- **Per-axis PIE root** — we have *kʷi-* for the shared wh-stem, but
  individual axes don't have separate clean PIE anchors. Each axis
  inherits the wh-stem; no deeper per-axis root established.
- **Canonical axis ordering** — is χ "first"? Is τ "last"? The
  framework uses this ordering throughout but hasn't derived why.
  May be convention.
- **Why χ specifically maps to strong, not gravity or EM** — the
  force-axis pairing (§ above) is semantically justified but not
  rigorously derived. Conventional-seeming.

---

## Cross-references

- `1-body.md` — the axes in context of the full body structure
- `1-where/trits.md` — the 3 values each axis takes
- `1-where/lattice.md` — how the 4 axes combine into 81 points
- `1-where/wheel.md` — rotation, why it spins
- `1-where/forces.md` — full force-to-axis mapping
- `1-where/scope.md` — S-scope 3+1 as lifted H-internal 3+1
- `1-where/roots.md` — *kʷi-* and *sub-stare* PIE roots in full
- `4-when/wit/mind/wheel/3-lattice.md` — archive of prior axis docs
  (including drives claim to verify)
