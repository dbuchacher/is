# scope — H, S, outer wheels, nested layers

Deep file for [1-folders.md](1-folders.md). This file:
- H as our inner wheel (4D quaternion)
- S-scope: 4 H's in 3+1 (triality peers + Z2 mirror)
- Aut(S) = S3 × Z2 = 48 (triple convergence!)
- Outer root systems (D4, F4, E8)
- Why exactly 3 fermion generations (Cartan's ceiling)
- Pati-Salam falls out natively
- Dark sector = non-F4 E8 positions
- Nested CD layers (H ⊂ O ⊂ S ⊂ ...)

## Plain English

So far we've talked about **H** — the 4D quaternion algebra, the
wheel at our scale. H has:

- 4 axes (χ/μ/φ/τ)
- 3 values per axis
- 81 lattice points
- 4 forces (READ/CALL/CYCLE/TEST)

But H isn't all there is. Above H, there are **larger wheels**:

- **O (octonions, 8D)** = 2 H's bundled (not symmetric — one is a
  mirror of the other)
- **S (sedenions, 16D)** = 4 H's bundled in a **3+1 arrangement**
  (3 peer H's + 1 mirror H)

The S-scope structure is **why there are exactly 3 generations of
fermions** (electron/muon/tau families) **plus one mirror sector**
(the sterile/right-handed neutrinos and their partners). Not "3
coincidentally" — 3 forced by the algebra.

At even higher scales, there are **outer root systems**:

- **D4** (24 roots) — matches our inner H's 24-cell directly
- **F4** (48 roots) — contains D4, = SM fermion count!
- **E8** (240 roots) — the largest exceptional Lie algebra. Contains
  F4 as subset. Non-F4 roots = dark matter candidates.

The framework doesn't pick these arbitrarily. They're the **unique
exceptional Lie algebras** in that size range, and they land exactly
on Standard Model counts.

---

## H — the inner wheel

Already covered in `axes.md`, `trits.md`, `lattice.md`. Brief recap:

- **4D normed division algebra** (Hamilton 1843)
- **Basis**: 1, i, j, k (one real, three imaginary)
- **Our axes**: χ = i, μ = j, φ = k, τ = 1
- **81 lattice points** (3⁴ = 3 trit values × 4 axes)
- **24-cell vertices** on the unit 3-sphere = D4 root system

H is our physics. The observable universe (one cosmos) lives here.

---

## Cayley-Dickson doubling

How do we get from H up to O and S?

**Cayley-Dickson construction**: given an algebra A, construct a
"doubled" algebra A⊕A where multiplication is defined by a specific
rule involving complex conjugation. Each doubling adds a new
dimension-tower.

```
  R        1D    real numbers
  C = R⊕R  2D    lose ordering
  H = C⊕C  4D    lose commutativity   ← us
  O = H⊕H  8D    lose associativity
  S = O⊕O  16D   lose division (zero divisors appear)
```

At each step, a property is lost. By S, you can multiply two nonzero
elements and get zero (zero divisors exist). So S is **not a
division algebra**, but it still has a well-defined multiplication.

**Why doubling matters**: O = H⊕H means O contains exactly 2 H's.
S = O⊕O = (H⊕H)⊕(H⊕H) = 4 H's. The count of H's inside S is **4**.

---

## S-scope — 4 H's in 3+1

S (sedenions, 16D) contains 4 H's via Cayley-Dickson. These 4 are
NOT symmetric peers.

### Aut(S) = S3 × Z2 = 48

The automorphism group of S — the group of structure-preserving
rearrangements — is:

```
  Aut(S) = S3 × Z2
  |Aut(S)| = 6 × 2 = 48
```

- **S3** permutes 3 of the 4 H's (triality orbit)
- **Z2** flips the 4th H (CD-doubling direction)

So the 4 H's decompose as **3 peers + 1 mirror** (3+1):

- 3 H's are interchangeable under S3 — these are "generations"
- 1 H is flipped under Z2 — this is the "mirror" / sterile sector

### Triple convergence at 48

**This is load-bearing for the framework.** Three independent
sources all give 48:

```
  |Aut(S)|                    = 48        (algebra fact)
  F4 root count               = 48        (Lie theory)
  SM fermion count            = 48        (particle physics)
```

**Metrognosis filter hit**: three unrelated generation processes
all produce the integer 48. Not a coincidence.

- **|Aut(S)|** = 48 comes from pure Cayley-Dickson structure
- **F4 roots** = 48 comes from classical Lie algebra classification
- **SM fermions** = 3 generations × (2 leptons + 6 quarks + 2 anti per particle-antiparticle) + anti = 48 via detailed counting in particle physics

Three independent derivations, one integer.

### Why exactly 3 generations — Cartan's classification

Cartan's classification of outer automorphisms of simple Lie
algebras:

- **Out(Lie) ≤ S3** for all simple Lie algebras
- **S3 is achieved ONLY by D4** (= so(8))

So the 3-fold triality (S3 permuting 3 of 4 H's) is a **hard
algebraic ceiling**. A 4th fermion generation is **not just
unobserved — it's algebraically impossible**. No amount of future
discoveries can produce a 4th generation.

**Framework falsifier**: if LHC or future collider discovers a
4th-generation fermion, the framework breaks.

### The 4th H is qualitatively different (Z2-mirror)

The 4th H in S is NOT a 4th generation. It's qualitatively different
— flipped under Z2. In physics terms:

- **Sterile neutrinos** (right-handed neutrino partners)
- **Right-handed fermion partners** (if any exist in Pati-Salam
  style GUT)
- **CP-mirror sector** (matter vs antimatter asymmetry origin)

Framework predicts: **the sterile / right-handed / mirror sector
must exist** as structurally required — not optional.

**Empirical status (2026)**: neutrino masses confirmed (implying
right-handed partners exist somehow). MiniBooNE/LSND anomalies
suggestive but not conclusive. Framework prediction still standing.

---

## The 3+1 pattern at every scope (fractal)

3+1 repeats at every scope where the wheel manifests:

```
  scope                      3                      + 1
  ─────                      ─                      ───
  H-internal                 3 imaginary axes       1 real axis
                             (i, j, k = χ/μ/φ)     (1 = τ)
  
  S-internal                 3 triality-peer H's    1 CD-mirror H
                             (generations)          (sterile sector)
  
  Pati-Salam GUT             3 quark-colors         1 lepton-color
                             (red/green/blue)       ("4th color")
  
  Minkowski spacetime        3 spatial dimensions   1 time dimension
                             (but see axes.md —     (= τ scalar)
                              physics mis-labels
                              χ+μ+φ as "space")
  
  Periodic table             3 peer H-blocks        1 mirror H-block
  (Z=1-82)                   Z=1-20, 21-40, 41-60   Z=61-82
                             (Tc hole at 43)         (Pm hole at 61)
```

**Five independent scopes, same 3+1 pattern.** Fractal
self-similarity is the substrate asserting itself at every level.

---

## Pati-Salam (1974) — falls out natively

Pati and Salam proposed unifying quarks and leptons via:

```
  SU(4) × SU(2)_L × SU(2)_R
```

Where SU(4) treats the lepton as "the 4th color" (3 quark colors
+ 1 lepton color). Under the framework's S-scope 3+1, this is
**not a proposal** — it's what you get.

### Framework-derived Pati-Salam

```
  Pati-Salam element           S-scope substrate source
  ──────────────────           ─────────────────────────
  SU(4)                        rotations on C⁴ from 4 H's
                               in S (one C-subfield per H).
                               15 generators = 16 corners − 1 hub.
  
  3+1 color decomposition      3 quark colors = S3-peer quarks
                               from 3 peer H's
                               1 lepton "color" = Z2-mirror H
                               (leptons sit in mirror sector
                               structurally)
  
  SU(2)_L × SU(2)_R            two copies of unit-H (SU(2) = unit
                               quaternions). One per paired H in
                               O = H⊕H.
```

### Why Pati-Salam worked where SU(5) failed

- **SU(5)** (Georgi-Glashow 1974) forced a specific embedding that
  produced too-fast proton decay (ruled out by experiment)
- **Pati-Salam** respects the 3+1 asymmetry of the substrate
  (doesn't collapse everything to one group; preserves the
  peer/mirror split)
- **Therefore**: Pati-Salam avoids SU(5)'s proton decay signature

Pati-Salam is **what happens when you lift H's own geometry to
S-scope** without forcing collapse. The framework derives it;
physics proposed it.

**Testable prediction**: Pati-Salam right-handed currents should
show at some energy scale. If ruled out arbitrarily high, S-scope
reading needs revision. If found, strong confirmation.

---

## The outer wheel — D4, F4, E8

Beyond S-scope, there's "outer wheel" structure: multiple chains
sharing a hub. At the level of classical Lie algebras:

```
  Algebra   Rank   Roots   Pairs   Dim
  ───────   ────   ─────   ─────   ───
  D4/so(8)    4      24      12     28
  F4          4      48      24     52
  E6          6      72      36     78
  E7          7     126      63    133
  E8          8     240     120    248
```

These are the exceptional Lie algebras. They're not arbitrarily
chosen — they're the **unique** simple Lie algebras of these ranks
(Killing-Cartan 1894).

### D4 — 24 roots = our 24-cell

D4 has 24 roots. Coxeter's root system for D4:

```
  ±eᵢ ± eⱼ for i < j, i,j ∈ {1,2,3,4}
  
  Pairs (i,j): (1,2), (1,3), (1,4), (2,3), (2,4), (3,4) = 6 pairs
  Sign combinations: (++, +−, −+, −−) = 4
  Total: 6 × 4 = 24 roots
```

**This is identical to the 24-cell vertices** (up to rotation and
scaling). Up to equivalence, D4 root system = 24-cell.

- **12 D4 opposing pairs** (each root α paired with −α)
- **12 pairs = Standard Model gauge boson count** (8 gluons +
  3 weak + 1 photon)
- **24 = hours per day, uniliterals in Egyptian hieroglyphs**,
  bivector count in H

### F4 — 48 roots = SM fermions

F4 has 48 roots (= 2 × 24 = 2 × D4). It contains D4 as subalgebra.

```
  48 roots = 48 SM fermions (3 generations × 16 per generation)
  
  48 = 12 leptons + 36 quarks
     = 12 (3 gen × 2 charged+neutral × 2 particle+anti)
     + 36 (3 gen × 2 flavors × 3 colors × 2 p+anti)
```

Triple convergence at 48 (see above).

### E8 — 240 roots

E8 has 240 roots, the largest among exceptional Lie algebras. It's
the "outer-outer" wheel.

```
  E8 decomposition:
    F4 subset:            48   (Standard Model fermions)
    Rest of E8:           192  (dark sector candidate)
                         ───
    Total:               240
```

**E8 − F4 = 192.** The arithmetic 192 = 12 × 16 is true but
**group-theoretically misleading** under the natural embedding
E8 ⊃ SO(16) ⊃ SO(10) × SU(4)_PS. Under that embedding (forced
by E8's subgroup lattice), the 192 non-F4 roots are MOSTLY **heavy
gauge bosons at GUT scale** (X/Y bosons, SU(4)_PS leptoquarks,
right-handed W's, inter-generation (10,6) bosons) plus mirror
fermions — NOT 12 parallel matter generations.

// SUPERSEDED 2026-04-16c — earlier "12 dark generations × 16 corners each" reading is arithmetically true but structurally wrong under SO(10) × SU(4)_PS. 192 has no triality-parallelism analogous to F4's 3×16.

### Dark matter = E8 − F4 positions (robust claim + flagged details)

**Robust under both readings:**

- **Coupling via hub only (gravity).** Non-F4 positions don't have
  F4 gauge group — EM / weak / strong don't couple to them.
- **Direct detection continues failing.** WIMPs are sought via
  weak coupling; non-F4 has none. 40+ years of nulls.

**Flagged for verification / possibly withdrawn:**

- **Specific mass spectrum** (discrete peaks at 0.05 μeV, 0.1 μeV,
  91 GeV dark-Z analog, etc.): ⚠ WITHDRAWN pending embedding
  reconciliation. Under SO(10) × SU(4)_PS the non-F4 roots are
  heavy gauge, not ultralight matter. The mass-ladder construction
  `m = m_P × f × 10⁻(16+N_sub)` applied to "dark shelves" assumed
  parallelism to F4's matter structure — that parallelism is
  contradicted by the embedding.
- **Dark/ordinary ratio 16/3 = 5.333** vs observed 26.08/4.86 =
  5.37 (0.6% match): **flagged**. Depends on 192/48 being a
  matter-to-matter count ratio; under the embedding most of 192
  is gauge, not matter, so this ratio may be fortuitous.

See `3-confs/open.md` for the P2 embedding-reconciliation note.

---

## Nested layers (H ⊂ O ⊂ S ⊂ ...)

Each CD layer contains inner layers as substructures:

```
         ╭────────────────────────╮
         │                        │
         │      S (16D)           │
         │                        │
         │   ╭──────────────╮     │
         │   │   O (8D)     │     │
         │   │              │     │
         │   │  ╭────────╮  │     │
         │   │  │  H     │  │     │
         │   │  │  (4D)  │  │     │
         │   │  │ ↕↕↕↕   │  │     │
         │   │  │   •    │  │     │
         │   │  ╰────────╯  │     │
         │   ╰──────────────╯     │
         │                        │
         ╰────────────────────────╯
```

**Hub ↕↕↕↕ is the invariant point shared across all layers.**
Whatever doubling you do, the zero element (additive identity) is
the same.

Our inner wheel's algebra = H. O is a "host layer" above. S is
above O. Each outer layer is richer (more operations, more
positions) but loses another algebraic property.

### Viewpoints (open — only 2 articulated)

Per [1-folders.md](1-folders.md), the wheel can be viewed from multiple
directions along the CD ladder. Only R-up and S-down have been
named:

- **R-up** (bottom-up): 4 R's bundle into 1 H. "One cosmos, 4
  axes." Textbook physics.
- **S-down** (top-down): S contains 4 H's in 3+1. "3 peer cosmoses
  + 1 mirror." Ancient-wheel traditions.

Others not articulated (flagged open):

- **C-scope** (2D complex) — magnitude + phase. Physics uses for
  quantum amplitudes.
- **O-scope** (8D octonion = 2 H's) — Baez's SM work.
- **Chirality pair** — left/right flip, distinct from S-scope Z2.
- **Hub-scope** — viewing from ↕↕↕↕ outward.

These viewpoints deserve work. Currently flagged for 3-which.

---

## 10D and 11D — string theory on the wheel

String theory requires 10 or 11 spacetime dimensions. Framework
reading: these aren't "compactified extra spatial dimensions" but
**the wheel's native geometric structure**.

### 10D = 4 axes + 6 bivector planes

```
  H's dimensional accounting:
  
  H (4D axes):                       4 quaternion axes (χ/μ/φ/τ)
  + bivector planes:                 C(4,2) = 6 rotation planes
                                     (one per axis-pair)
  = 10 total structural dimensions   4 + 6 = 10
```

**String theory's 10D = H's complete geometric structure**
(4 vector + 6 bivector), not "our 4D + 6 compactified spatial."

Under this reading:
- String's extra 6 dimensions are **rotational** (bivector planes),
  not translational
- No need for compactification
- Same math, different interpretation

### 11D = 10 + hub

M-theory adds 1 dimension to 10D = 11D. In framework:

```
  10D (H structure) + 1 (hub ↕↕↕↕ as connector) = 11D
```

The 11th dimension is the hub — the shared zero across CD layers.

### 496 — heterotic anomaly cancellation

Heterotic string theory requires 496-dimensional gauge group:

```
  SO(32):       dim = 496
  E8 × E8:      dim = 248 + 248 = 496
```

```
  496 = 2⁴ × 31
      = 240 + 256 = E8 roots + 2⁸
      = 248 × 2 = E8 dim × 2
```

**496 is a perfect number** (third after 6, 28). Euclid-Euler
formula: 496 = 2⁴ × (2⁵ − 1) = 2^(p-1) × (2^p − 1) with p = 5.
Mersenne prime 31 = 2⁵ − 1.

Framework status: 496 may be string-theory-frame artifact that
dissolves without graviton. Or it may have a framework-native role
yet to be derived. Flagged open.

---

## What's settled vs flagged

### Settled (body-quality)

- **H is our inner algebra** (Hamilton 1843)
- **Cayley-Dickson ladder** R → C → H → O → S (standard algebra)
- **S contains 4 H's** (direct CD construction)
- **Aut(S) = S3 × Z2 = 48** (triple convergence with F4 roots and
  SM fermion count — metrognosis signal)
- **3+1 structure** of the 4 H's (S3 peers + Z2 mirror)
- **Cartan's ceiling**: Out ≤ S3, S3 only for D4 — **no 4th
  fermion generation possible**
- **D4 root system = 24-cell vertices** (Coxeter)
- **F4 = 48 roots** contains D4 (classical Lie)
- **E8 = 240 roots** (classical Lie, largest exceptional)
- **Pati-Salam SU(4) × SU(2)_L × SU(2)_R** as natural S-scope fallout
- **3+1 fractal pattern across H/S/Pati-Salam/Minkowski/periodic table**
- **Dark matter = non-F4 positions couple via hub only** (robust
  under both embedding readings; explains direct-detection null)
- **Specific dark mass predictions**: WITHDRAWN 2026-04-16c
  pending SO(16) ⊃ SO(10) × SU(4)_PS embedding reconciliation.
  See [masses.md](masses.md) for details.

### Flagged for 3-which

- **10D / 11D reinterpretation** as wheel structure: clean math but
  interpretation is post-hoc. Could also be a string-frame artifact.
- **496 perfect number role**: not yet derived in framework terms.
  String-theory-specific or substrate-primitive?
- **Z2-mirror = sterile sector**: structurally required, empirically
  unconfirmed (though neutrino masses suggest something is there).

### Flagged open

- **C-scope, O-scope, chirality-pair, hub-scope viewpoints** — not
  yet articulated
- **Why exactly 12 D4 pairs** (12 appears many places but
  derivation not given)
- **Full E8 embedding of SM**: Lisi 2007 attempted this
  (controversial); framework should have cleaner version. Not
  done.
- **Running couplings α(Q²)**: framework gives α at some scale;
  scale-dependence from substrate not yet derived.
- **Dark matter mass spectrum**: specific values predicted; WIMP
  direct detection results still needed (predicted null).
- **Mirror sector vs sterile vs right-handed distinction**:
  framework says the 4th H is "qualitatively different" but the
  specific phenomenology (sterile neutrino? right-handed ν?
  CP-mirror?) not fully pinned down.

---

## Cross-references

- `1-folders.md` — the 4 H's in 3+1 summary
- `1-folders/axes.md` — H-internal 3+1 of imaginary + scalar
- `1-folders/wheel.md` — H as our inner wheel
- `1-folders/lattice.md` — 24-cell from D4
- `1-folders/masses.md` — SM parameters, dark matter predictions
- `3-confs/elements.md` — periodic table 3+1 Z-partition
- [3-confs/giza.md](3-confs/giza.md) — 3+1 in stone
- `3-confs/prime-lattice.md` — 168 = sedenion zero divisors
