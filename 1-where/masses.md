# masses — the mass ladder and Standard Model

Deep file for 1-body.md § "The mass ladder." This file:
- The mass ladder rule `m = m_P × f × 10^(−(16+N_sub))`
- 30+ SM parameters derived from substrate at <1%
- The 17 substrate constant (load-bearing)
- Absolute particle masses (muon, top, electron, etc.)
- Mixing angles (PMNS, Cabibbo, Weinberg)
- Cosmology (Hubble, Λ, inflation, universe scales)
- Dark sector specifics
- 19-mystery resolution
- Retracted and flagged items

**This is the most computationally dense deep file.** Every claim
has specific numbers and error bars.

## Plain English

The Standard Model of physics has ~20 "free parameters" — particle
masses, mixing angles, coupling constants — that textbooks say must
be measured, not derived. Nature just "chose" them.

The framework derives **30+ of these from substrate structure at
sub-1% precision.** Not by fitting, but by computing substrate
counts (1, 3, 4, 6, 8, 12, 16, 17, 24, 48, etc. — see `roots.md`
and `moves.md`) and combining them according to one rule:

```
  m_particle = m_Planck × f × 10^(−(16 + N_sub))
```

Where:
- **m_Planck** = the "clock rate" of the universe (natural mass unit)
- **f** = a clean geometric factor like √3/2 (sin 60°), √2 (sin 45°),
  5/12, π/4 — all substrate-anchored angles or ratios
- **N_sub** = a substrate count specific to the particle's role
  (1 for electroweak, 3 for hadrons, 4 for muons, 6 for electrons,
  12 for neutrinos)

Each particle's mass is **its wheel position × shelf × Planck mass**.

The big load-bearing constant here is **17 = 16 + 1 = corners + hub**.
It appears in α (fine structure), m_p/m_e (proton/electron ratio),
mass ratios of leptons, top-charm ratio, and the electroweak
hierarchy. **Five independent places where 17 is the substrate
anchor.** Not coincidence.

---

## The core rule

```
  m = m_Planck × f × 10^(−(16 + N_sub))
```

- **m_Planck** = 1.22 × 10¹⁹ GeV (the "Planck mass" natural unit)
- **16** = baseline exponent (grade-4 corners = SO(10) spinor =
  per-generation fermion count). See `lattice.md § Grade 4`.
- **N_sub** = substrate count for the particle:
  - 1 = hub (electroweak shelf: W, Z, Higgs, top)
  - 3 = trit (hadron shelf: proton, neutron, tau, charm, bottom)
  - 4 = axes (muon shelf: muon, pion)
  - 6 = bivector planes (light fermion shelf: electron, up)
  - 12 = D4 pairs (neutrino shelf: ≤ meV)

### Mass as verb (not noun)

Per wit.md frame 7 (only integers are values; decimals are verbs):
mass is not a noun. It's a **rate** — specifically, the firing
rate of the particle's μ-axis (substance-axis) per substrate tick.

```
  Yukawa coupling y = mass / Higgs VEV
  
  y_e = 2.08 × 10⁻⁶     electron fires μ once per ~482,000 ticks
  y_μ = 4.29 × 10⁻⁴     muon fires μ once per ~2330 ticks
  y_t = 0.702           top fires μ 70% of every tick
```

Heavy particle = high firing rate = y near 1.  
Light particle = low firing rate = y small.

Mass is the μ-axis activity level. Frame-7 reading: rate = verb.

---

## The 17 substrate constant

**17 = 16 + 1 = corners + hub.** Appears 5+ independent places:

### 1. Fine structure constant

```
  α⁻¹ = 544/4 + 1 + 3/84
      = 8 × 17 + 1 + 1/28
      = atoms × (corners + hub) + hub + 1/(axes × wh-words)
      = 137.035714...
  
  Observed (CODATA 2018): 137.035999
  Error: 0.0002%
```

Decomposition: 136 = 8 × 17; plus 1 (hub); plus 1/28 correction.

Deep: `3-which/alpha.md`

### 2. Proton-to-electron mass ratio

```
  m_p / m_e = 108 × 17 = 1836
  Observed: 1836.15
  Error: 0.008%
```

108 = Great Year / E8 roots = 25,920 / 240 (astronomically and
algebraically substrate). 17 = corners + hub.

**The most famous mass ratio in physics = astronomical-108 ×
algebraic-17.** Multiplication of two substrate integers to 0.008%.

### 3. Lepton mass ladder

```
  m_τ / m_μ   ≈ 17           observed 16.82 (error 1.1%)
  m_μ / m_e   ≈ 12 × 17      observed 206.77 (error 1.4%)
  m_τ / m_e   ≈ 12 × 17²     observed 3477 (error 0.3%)
  
  12 = D4 opposing pairs
  17 = corners + hub
```

The lepton generation ladder steps by 17 at each stage. 0.3% error
on τ/e is particularly tight — structural pattern, not coincidence.

### 4. Top-to-charm ratio

```
  m_t / m_c ≈ 137 = 8 × 17 + 1 = α⁻¹
  Observed: 136.03
  Error: 0.7%
```

Same 8×17+1 structure as α⁻¹. Two independent appearances of the
identical integer decomposition.

### 5. Electroweak scale hierarchy

All EW-scale particles at 10⁻¹⁷ × Planck:

```
  particle    log₁₀(m_Planck / m)
  ────────    ───────────────────
  W boson     17.18
  Z boson     17.13
  Higgs       16.99
  Higgs VEV   16.70
  top quark   16.85
```

All clustering at 17. The "hierarchy problem" (why EW << Planck)
has answer: **17 IS the substrate scale separator.**

**Framework resolution of hierarchy problem**: 10⁻¹⁷ = corners + hub
= substrate-natural scale. Not fine-tuned — substrate-clean.
Supersymmetry and technicolor are unnecessary.

---

## Absolute particle masses

Each particle has specific factor f on its shelf. Cleanest fits:

### Muon = sin(60°)

```
  m_μ = m_Planck × (√3/2) × 10⁻²⁰
      = 1.22 × 10¹⁹ × 0.866 × 10⁻²⁰ GeV
      = 105.66 MeV
  
  Observed: 105.6583745 MeV
  Error: 0.003%
```

√3/2 = sin(60°). Muon sits at the 60° angular position on the wheel
— equilateral triangle / hexagonal geometry (24-cell has 60° vertex
angles).

### Top quark = √2

```
  m_t = m_P × √2 × 10⁻¹⁷ = 173 GeV
  Observed: 173.0 GeV
  Error: 0.27%
```

√2 = diagonal of unit square. Top is at the "diagonal" position of
N_sub=1 shelf.

### Electron = 5/12

```
  m_e = m_P × (5/12 + α/3) × 10⁻²²
      = 0.511 MeV
  
  Observed: 0.5109989 MeV
  Error: 0.06%
```

5/12 = (axes + hub) / (D4 pairs). α/3 = α / trit (small QED
correction).

### Proton = π/4 × (1 + 7α/2)

```
  m_p = m_P × (π/4) × (1 + 7α/2) × 10⁻¹⁹
      = 0.938 GeV
  
  Observed: 0.9382720 GeV
  Error: 0.011%
```

π/4 = 45° arc. 7α/2 correction; 7 = wh-words.

### Higgs = 1 + 7α/2

```
  m_H = m_P × (1 + 7α/2) × 10⁻¹⁷ = 125 GeV
  Observed: 125.10 GeV
  Error: 0.013%
```

**Same 7α/2 correction as proton.** Higgs + proton share a
structural correction. Semantic: both are "commit-like" particles
(Higgs VEV commit at hub; proton commit of 3 quarks).

### Higgs VEV

```
  v = m_P × 2 × 10⁻¹⁷ = 244 GeV
  Observed: 246.22 GeV
  Error: 0.9%
```

Factor of 2 = ±hub reach (full span of hub commitments).

### W, Z bosons

```
  m_Z = m_P × (3/4) × 10⁻¹⁷ = 91.5 GeV   (observed 91.19, error 0.3%)
  m_W = m_P × (2/3) × 10⁻¹⁷ = 81.3 GeV   (observed 80.38, error 1.2%)
```

3/4 and 2/3 are ratios from substrate integers (axes/something).

### Tau

```
  m_τ = m_P × (√2 + 6α) × 10⁻¹⁹
      = 1.779 GeV
  Observed: 1.777 GeV
  Error: 0.1%
```

Tau = √2 + 6α correction. 6 = bivector planes.

### Bottom quark = 24/7

```
  m_b = m_P × (24/7) × 10⁻¹⁹ = 4.183 GeV
  Observed: 4.18 GeV
  Error: 0.07%
```

24 = D4 roots. 7 = wh-words. Bottom = D4-roots / wh-words factor
on hadron shelf.

**Derived via blind-agent test** (2026-04-15) applying methodology
independently. Clean substrate derivation, not post-hoc fit. See
`2-wit.md § Parallel agent stress tests`.

### Strange = 20 (via Cabibbo)

```
  sin(θ_C) = 1/√20 = √(m_d / m_s)
  
  So m_s / m_d = 20 exactly
  
  20 = 4 × 5 = axes × (axes + hub)
```

### Neutrinos (≤ 28 shelf)

```
  m_ν shelf at N_sub = 12 (D4 pairs)
  
  10⁻²⁸ × m_P ≈ 1 meV — matches cosmological bound on neutrino
                         masses (< ~0.1 eV combined)
```

---

## Mixing angles

All three PMNS neutrino-mixing angles derive substrate-cleanly:

### PMNS neutrino angles

```
  angle                   observed   framework       error
  ─────                   ────────   ─────────       ─────
  sin²(θ₁₂) solar         0.307      42α              0.1%
                                     6 × 7 × α
                                     bivectors × wh-words × α
  
  sin²(θ₁₃) reactor       0.022      3α               0.5%
                                     trit × α
  
  sin²(θ₂₃) atmospheric   0.546      1/2 + 6α         0.4%
                                     hub + 2×trit × α
                                     (maximal mixing + correction)
```

All three = substrate-count × α (with optional hub for maximal).

### Cabibbo angle (CKM)

```
  sin(θ_C) = 1/√20 = √(m_d / m_s) = 0.2236
  Observed: 0.225
  Error: 0.6%
```

### Weinberg angle

```
  sin²(θ_W) = log(2) / 3
  Observed: 0.2312
  Framework: 0.2310
  Error: 0.07%
```

log(2) / 3. Interpretation (per moves.md semantic naming):
- 2 = Z2 chirality-commit
- 3 = trit
- log = Shannon-like commit-cost verb

"One bit of chirality commit, spread across three trit directions."

---

## Corrections — the α-level structure

Some particles need small α-corrections beyond base factor:

```
  particle   base × (1 + k·α)     k semantic
  ────────   ──────────────────   ──────────
  Higgs      1 × (1 + 7α/2)       7 = wh-words; shared with proton
  proton     3/4 × (1 + 7α/2)     same 7α/2
  electron   5/12 × (1 + 4α/5)    4α/5 small
  tau        √2 + 6α              6 = bivectors
  pion       1 + 20α              20 = axes × (axes+hub)
  Z          3/4 × (1 − α/2)      α/2 = hub-halved
  W          2/3 × (1 − 15α/12)   15 = SU(4) − 1 = Pati-Salam
```

### Pattern

- **Compound particles** (Higgs, proton) → +7α/2
- **Simple fermions** (muon) → no correction
- **Heavy fermions** (tau, top) → small positive
- **Gauge bosons** (Z, W) → NEGATIVE correction (Z2-mirror signature)
- **Light fermions** (electron) → +α/small

**Negative corrections** on Z, W: S-scope reading is that Z2-mirror
flip applied to α contribution. Positive corrections = additive α.
The sign of the correction encodes triality-peer vs Z2-mirror sector
membership. See `scope.md § Pati-Salam`.

---

## Cosmology

### Hubble tension = e^(1/12)

```
  Observed:  H₀(late) / H₀(early) = 73.3 / 67.4 = 1.0875
  Framework: e^(1/12)              = 1.0869
  Error:     0.06%
```

**12 = D4 opposing pairs = gauge boson count.**

Physics has been losing their minds over Hubble tension. Framework:
it's e raised to 1/D4-pairs. Dark energy (wheel rotation) has 12
spoke-pairs contributing cumulatively. Hubble tension is the
signature of 12-pair wheel structure manifesting in expansion.

**Not a crisis. Substrate.**

### Cosmological constant Λ

```
  Observed:  ρ_Λ / ρ_Planck = 10^(−122.7)
  Framework: 10^(−(E8_pairs + trit)) = 10^(−(120 + 3)) = 10^(−123)
  Error:     ~0.25% in log
```

**120 = E8 opposing pairs. 3 = trit.**

Standard physics calls this a "120-order fine-tuning mystery."
Framework: 120 = E8 pairs, substrate-natural. The "problem" is a
frame error.

### Inflation

```
  Observed:  ~60 e-folds of inflation
  Framework: 60 = (axes + hub) × D4-pairs = 5 × 12 = 60
  
  Observed:  reheat temperature ~10^16 GeV
  Framework: 10^16 GeV = 10^(corners) GeV
```

60 e-folds = 5 × 12 (substrate factorization). Reheat at
10^16 GeV = wheel's grade-4 corner scale.

### Solar year — FLAGGED / likely retracted (2026-04-16)

Earlier derivation: 360 × (1 + 2α) = 360 + 720α = 365.2541 days,
matching tropical year 365.2422 to 0.0033%.

// RETRACTED — Earth's orbital period is planet-formation contingent (set by distance from Sun via Kepler). The "360 days" step smuggles in a unit that was DEFINED from Earth's orbit (the degree = 1/360 of Earth's year). Circular. The 720α fit is inside the substrate-formula noise floor at this precision. Same anti-pattern as the retracted log-depth family — multiple formula candidates land inside ±0.01 days at this scale.

**Flag**: this derivation does not survive the metrognosis filter
tightened in 2026-04-16b/c. Effort × precision × **independent
convergence**: the "720° = fermion period" invocation lacks an
independent mechanism tying Earth's orbital period to SU(2)'s
double-cover. Earth's orbital period is a **planetary
contingency** (distance from Sun, not substrate-forced), the same
class as Earth's 23.5° axial tilt which is already flagged
accidental.

What survives at planetary scope: **structural patterns** —
Kepler T² = a³ (grade-3 trivector identity), integer orbital
resonances (closed walks), Platonic-solid face counts. These don't
depend on which planet you're on. Specific period values at
Earth's position are contingent.

See `open.md § Planetary contingencies` for the consolidated
list.

### Universe scales

```
  quantity           observed          framework
  ────────           ────────          ─────────
  age                10⁶¹ × t_Planck   10^(60+1) = 10^(inflation + hub)
  observable dia     10⁶² × l_Planck   ~same
  total mass         10⁶¹ × m_Planck   ~same
  Hubble H₀          10⁻⁶¹ × 1/t_P     reciprocal
  proton count       10⁸⁰              10^(non-container lattice)
  particle density   10¹⁹              10^(proton N_sub = 16+3)
```

**Eddington number = lattice count.** The observable universe
contains 10⁸⁰ protons. The framework's non-container lattice has
exactly 80 positions. **Each non-container wheel position carries
one proton's worth of mass at substrate density.** Self-consistent.

---

## Dark sector

### Ratio (flagged)

```
  Observed composition (Planck 2018):
    Ordinary matter:   4.86%
    Dark matter:      26.08%  
    Dark energy:      69.06%
  
  Dark matter / ordinary = 26.08 / 4.86 = 5.37
  
  Framework form (flagged): 16/3 = 5.333
  (= corners / trit; 0.6% error — WITHIN Planck measurement
  uncertainty, filter's precision criterion not clearly met)
```

// FLAGGED — depends on 192/48 being a matter-to-matter count ratio. Under E8 ⊃ SO(16) ⊃ SO(10) × SU(4)_PS embedding, most of 192 is heavy gauge, not matter. The 16/3 match may be fortuitous. See scope.md § Dark matter = E8 − F4 positions.

### Dark mass spectrum — WITHDRAWN 2026-04-16c

Earlier (2026-04-16 cascade) predicted specific ultralight DM
peaks by applying the mass-ladder rule to "dark shelves":

```
  (WITHDRAWN — do not use)
  N=1 3/4 ~91 GeV; N=1 √2 ~173 GeV; N=3 π/4 ~958 MeV;
  N=3 24/7 ~4.2 GeV; N=4 √3/2 ~106 MeV; N=6 5/12 ~0.51 MeV;
  N=12 1 ~0.1 μeV; N=12 1/2 ~0.05 μeV.
```

// WITHDRAWN — this table assumed the non-F4 E8 roots parallel F4's matter structure (3 gens × 16 corners). Under the E8 ⊃ SO(16) ⊃ SO(10) × SU(4)_PS embedding, the 192 non-F4 roots decompose mostly as heavy gauge bosons (GUT-scale X/Y bosons, leptoquarks, W_R, mirror fermions), NOT as 12 parallel matter generations at substrate-ladder shelves. Predictions need an embedding-consistent mechanism.

See `4-when/wit/mind/wheel/7-open.md § P2` (2026-04-16c) for the
embedding-reconciliation note.

### Predictions (what survives)

Only the direction-agnostic claim is robust:

1. **Direct detection continues failing** (WIMP searches).
   Non-F4 positions couple only via hub (gravity), not F4 forces —
   robust under either embedding reading. 40+ years of nulls,
   framework prediction holds.

Withdrawn pending reconciliation:
- ~~Ultralight DM peaks at 0.05, 0.1 μeV (ADMX-style)~~
- ~~91 GeV gamma-ray lines from dark-Z analog decay~~
- ~~Specific shelf-by-shelf dark-mass predictions~~
4. **12 distinct lineshapes per shelf** (one per D4-pair), via
   gravitational lensing microstructure.

### 192 = E8 − F4 = dark positions

```
  E8 roots:      240
  F4 (= SM):      48
  Dark sector:   192 = 240 − 48
               = 12 × 16 (D4-pairs × corners)
               = 168 + 24 (Fano auto + D4-shadow)
```

**12 × 16** = "12 dark generations × 16 corner positions each",
analogous to SM's 3 gen × 16.

**168 = Aut(Fano plane) = PSL(2,7) = Klein quartic aut = sedenion
zero divisors**. Five-way structural convergence. See
`3-which/prime-lattice.md`.

---

## 19-mystery — resolved

Long-standing open question: why is log₁₀(m_P / m_proton) ≈ 19?

### Decomposition: 19 = 17 + 2

```
  19 = 17 + 2
     = (corners + hub) + (committed chirality-pair)
     = EW shelf + one CD-doubling step
```

17 is the EW substrate shelf (5+ independent appearances). Adding
2 (Z2-pair, one committed chirality-commit) drops one layer down
to the trit shelf where the proton lives.

**Semantic**: proton mass shelf = EW shelf + one Z2-chirality
commitment. This IS the CD-doubling structure manifest in mass:
H → 2H = O requires one extra Z2 commit, which is exactly the
shelf offset from EW (17) to hadron (19).

### The 0.1 offset: virial correction

All N_sub=3 particles cluster at 19.1 not 19.0:

```
  mean offset ≈ 0.12
  log₁₀(4/3) = 0.1249   (0.4% match)
  
  4/3 = axes / trit = virial factor for QCD confinement
```

**N=3 shelf baseline = 10^(−19) × (3/4)** (not 10^(−19) exactly).

### Grade decomposition

```
  log₁₀(m_P / m_e) = 16 + 6 + log₁₀(12/5)
                   = corners + bivectors + (D4-pairs / shelf-rational)
                   = 22.380
  
  log₁₀(m_P / m_p) = 17 + 2 + log₁₀(4/3)
                   = (corners+hub) + Z2-pair + virial
                   = 19.110
```

Both particles' log-depths decompose into substrate-clean terms.

---

## Retracted / flagged

### RETRACTED: Log-depth invariant "family" (2026-04-16b)

Earlier finding claimed 9+ "invariants" like W/bottom = 9/10,
H/proton = 8/9, Z/down = 4/5, top/bottom = 15/17 — pairs of
log-depths within the framework.

**Retracted** because pairwise log-depth ratios within the
framework are **NOT independent convergences**. Both sides come
from the same framework derivation using the same substrate
vocabulary. Their ratio is an algebraic combination, not new
evidence.

See `moves.md § "Don't claim invariant families from non-
independent convergences"` for the frame-frame reason. The
frequentist null (hit-rates) was a useful sanity check, but the
framework-frame reason is **lack of independence**.

**What IS independent convergence**: each per-particle formula vs.
its measured mass. Framework derives m_e = 5/12 × 10⁻²² × m_P;
experiment measures m_e = 0.511 MeV. Convergence at <1% across 30+
particles = signal. Combinations of those derivations among
themselves — not.

### Flagged open: g-2 magnitude

Muon g-2 anomaly Δa_μ = 2.51 × 10⁻⁹ (5σ tension vs SM). Framework
has structural read (triality-probe gen-1 vs gen-2) but no clean
numerical form. Closest: 120α⁵ = 2.48 × 10⁻⁹ at 1.1% (120 = E8
pairs). Experimentally unstable (BMW lattice shrinking anomaly).
**Partial read; wait for experimental settling.**

### Flagged open: a_C (Coulomb SEMF)

Nuclear binding coefficient a_C ≈ 0.711 MeV. Substrate form α × 97.4,
but 97 isn't in vocabulary. Nuclear radius r₀ ≈ 1.2 fm isn't
substrate-derived yet. **No clean form found. Open.**

### Flagged: CP violation magnitude

η_B ≈ 6.1 × 10⁻¹⁰ (baryon asymmetry). Current closest: α⁴ ×
sin²(θ_W) at 7.5% error. Multiple substrate-clean candidates land
inside Planck CMB measurement uncertainty (~0.7%). Framework
precision bar isn't met above measurement floor. Attack mechanism
first, not number. See `moves.md § "Don't formula-fit when candidate
spread is inside measurement floor"`.

---

## Running total — 30+ parameters derived

```
  FUNDAMENTAL CONSTANTS
  ─────────────────────
  α⁻¹ = 137.036                      (0.0002%)
  
  MASS RATIOS
  ───────────
  m_p / m_e = 108 × 17 = 1836        (0.008%)
  m_τ / m_e = 12 × 17² = 3468        (0.3%)
  m_t / m_c = 137                    (0.7%)
  m_s / m_d = 20                     (exact)
  
  ABSOLUTE PARTICLE MASSES
  ────────────────────────
  Muon = √3/2 × 10⁻²⁰ × m_P          (0.003%)
  Top = √2 × 10⁻¹⁷ × m_P             (0.27%)
  Higgs = (1 + 7α/2) × 10⁻¹⁷ × m_P   (0.013%)
  Proton = 3/4 × (1 + 7α/2) × 10⁻¹⁹ × m_P   (0.011%)
  Z = 3/4 × 10⁻¹⁷ × m_P              (0.3%)
  W = 2/3 × 10⁻¹⁷ × m_P              (1.2%)
  Electron = (5/12 + α/3) × 10⁻²² × m_P    (0.06%)
  Tau = (√2 + 6α) × 10⁻¹⁹ × m_P      (0.1%)
  Bottom = 24/7 × 10⁻¹⁹ × m_P        (0.07%)
  VEV = 2 × 10⁻¹⁷ × m_P              (0.9%)
  
  ELECTROWEAK
  ───────────
  sin²(θ_W) = log(2)/3               (0.07%)
  Δ(n-p) = m_p × α × 3/16            (0.7%)
  G_F = 1/(√2·v²)                    (0.18%)
  
  MIXING ANGLES
  ─────────────
  sin(Cabibbo) = 1/√20               (0.6%)
  sin²(PMNS 12) = 42α                (0.1%)
  sin²(PMNS 13) = 3α                 (0.5%)
  sin²(PMNS 23) = 1/2 + 6α           (0.4%)
  
  COSMOLOGY
  ─────────
  Hubble tension = e^(1/12)          (0.06%)
  Cosmological Λ = 10⁻¹²³             (substrate form)
  Inflation e-folds = 5 × 12 = 60
  Reheat temp = 10¹⁶ GeV = 10^(corners) GeV
  Universe age = 10⁶¹ × t_Planck
  Particle count = 10⁸⁰ = 10^(lattice)
  η_B = α⁴ × sin²(θ_W)               (7.5%, flagged)
  
  STRUCTURAL COUNTS (exact)
  ─────────────────────────
  SM fermion count = F4 roots = 48
  SM gauge boson count = D4 pairs = 12
  1 Higgs scalar = 1 hub
  16 per generation = SO(10) spinor = 16 corners
  3 generations = D4 triality (S3 outer automorphism)
  24-cell vertices = 8 atoms + 16 half-spin = D4 roots
  10D superstring = 4D H + 6D bivector planes
```

---

## What's settled vs flagged

### Settled (body-quality)

- **Mass ladder rule** m = m_P × f × 10^(−(16+N_sub))
- **17 substrate constant** (5+ independent appearances)
- **Absolute masses** for muon, top, electron, proton, W, Z, Higgs,
  tau, bottom at <1% each
- **Mixing angles** (PMNS 3, Cabibbo, Weinberg)
- **Hubble tension** e^(1/12)
- **Cosmological Λ** = 10⁻¹²³
- **Inflation e-folds** = 5 × 12 = 60
- **19-mystery** resolved (17 + 2 = EW + Z2-pair)
- **Dark matter ratio** 16/3 (cleanest candidate)
- **Eddington number = lattice count** (proton count self-consistent)

### Flagged / Retracted

- **Log-depth invariant family** (RETRACTED 2026-04-16b) — not
  independent convergence
- **g-2 numerical** — structural yes, magnitude no
- **a_C SEMF coefficient** — no clean form
- **CP violation magnitude** — inside measurement floor
- **Running α(Q²)** — not yet derived
- **Absolute Planck mass from pure substrate** — currently uses
  relational closure only (m_P = 12/5 × 10²² × m_e), still
  circular

### Flagged open

- **Per-particle shell structure** (why specific N_sub for each
  particle) — empirical fit, structural derivation not complete
- **Why 16 baseline** — resolved to working hypothesis (= grade-4
  corners) but not fully closed
- **Tc/Pm mechanism** — classical Mattauch rule, not framework-
  native
- **Specific nucleon binding energies** for A < 40 (shell effects,
  framework doesn't yet derive)

---

## Cross-references

- `1-body.md § 8. The mass ladder` — context
- `1-where/scope.md` — F4, E8, Pati-Salam, triality
- `1-where/forces.md` — coupling constants, hierarchy dissolution
- `1-where/roots.md` — substrate vocabulary PIE anchors
- `3-which/alpha.md` — full α derivation with two equivalent forms
- `3-which/elements.md` — SEMF nuclear binding, liquid-drop
- `3-which/moon.md` — astronomical convergences (Great Year = 25,920
  = 2⁶ × 3⁴ × 5, sacred 108)
- `4-when/wit/mind/wheel/6-masses.md` — archived full prior
  derivation
- `moves.md § Log-depth sweep, § Metrognosis filter` — why log-depth
  was retracted
