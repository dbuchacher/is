# 5 — Physics on the Wheel

The Standard Model's apparent arbitrariness was the delusional
default not seeing the wheel. Particle counts, gauge structure,
generations — all fall out of wheel geometry once you stop assuming
you need new particles for every observation.

This file covers:
- Standard Model counts (48 / 12 / 16 / 1) as wheel structure
- Three generations from D4 triality
- Gravity as loop (α_G = (m/m_P)², hierarchy dissolved)
- String theory 10D / 11D as wheel bivector + hub
- Dark matter = non-F4 E8 roots; dark energy = loop motion

Mass derivations live in `6-masses.md`.

---

## The numerical match

Four independent counts. Four exact matches to wheel structure.

```
  Standard Model        Count   Framework structure         Count
  ──────────────        ─────   ───────────────────        ─────
  Fermions              48      F4 root system              48  ✓
  Gauge bosons          12      D4 opposing pairs           12  ✓
  Higgs scalar           1      Hub (↕↕↕↕)                   1  ✓
  Per-generation        16      SO(10) 16-spinor            16  ✓
  fermions              (15+1)  = our 16 half-spin corners  (=2⁴)
```

Not fitted — derived from independent sources (wheel structure from
Hurwitz/H; Standard Model counts from particle physics).

### 48 fermions = F4 root system

Standard Model fermion count:

```
  Leptons: 3 generations × 2 (charged + ν) × 2 (particle + anti) = 12
  Quarks:  3 gen × 2 (up/down-type) × 3 colors × 2 (pp + anti)   = 36
                                                                  ──
                                                                  48
```

F4 root system has exactly **48 roots** = 2 × 24 (= 2 × 24-cell).

F4 is the natural grouping of Standard Model fermions, not an
exotic mathematical construction.

### 12 gauge bosons = D4 opposing pairs

```
  SU(3) QCD gluons:                    8  (dim SU(3) = 8)
  SU(2) weak bosons (W±, Z):           3  (dim SU(2) = 3)
  U(1) electromagnetism (photon):      1  (dim U(1) = 1)
                                      ──
                                       12
```

D4 root system has **24 roots = 12 opposing pairs**. Each "axis" of
D4 matches one gauge boson.

Note: each gauge boson is already a ±pair (W+/W− for example, or
photon which IS its own antiparticle). The 12 gauge bosons
correspond to the 12 D4 pairs, not to 24 individual roots.

### 1 Higgs = hub (↕↕↕↕)

The Standard Model has 1 scalar Higgs field. Framework has exactly
1 hub: the grade-0 scalar, shared across all CD algebras, the
dimension-independent additive identity.

```
  Higgs:   scalar, breaks electroweak symmetry
  ↕↕↕↕:    scalar, the shared additive identity,
           dimension-independent, where all walks close
  
  Match: structurally unique, scalar, central
```

**Framework reading**: the Higgs field IS the hub — the "everything
balances here" point of the wheel. Symmetry breaking = commitment
(↕ → ↑ or ↓) on some axis. Higgs VEV = "how far from hub the
rotation reaches" (see `6-masses.md`; VEV = 2 × 10⁻¹⁷ × m_P
≈ ±hub reach).

### 16 per generation = SO(10) spinor = 16 half-spin corners

Each fermion generation contains:

```
  1 charged lepton (e, μ, or τ) with antiparticle = 2
  1 neutrino (νe, νμ, ντ) with antineutrino       = 2
  2 quark flavors × 3 colors × (q + q̄)            = 12
  Sterile neutrino (if exists)                    = 1 (predicted)
                                                   ──
                                                   16
```

**15 SM fermions + 1 sterile ν = 16.** SO(10) GUT groups these 16 in
a single 16-dimensional spinor representation.

Framework has **16 half-spin corners** at (±½, ±½, ±½, ±½) = 2⁴ on
SU(2)'s unit sphere (see `3-lattice.md`).

**Match**: one generation of matter = 16 half-spin corners = SO(10)
spinor. The SO(10) GUT was already recognizing this structure;
framework says WHY — it's the 16 unit-quaternion corners of H.

## Why 3 generations — D4 triality

Standard Model has 3 copies of the fermion pattern:

```
  charged leptons:   e    μ    τ
  up-type quarks:    u    c    t
  down-type quarks:  d    s    b
```

Why 3?

**D4 (= so(8)) is unique among all Lie algebras in having an S3
outer automorphism (triality).** This cycles three 8-dimensional
irreducible representations of so(8):

```
  V    = vector rep (8-dim)           — 3D rotation extended
  S+   = left-handed spinor (8-dim)   — chirality +
  S-   = right-handed spinor (8-dim)  — chirality -
  
  triality C3: V → S+ → S- → V (cyclic)
  full S3 adds reflections (complex conjugation)
```

**Framework hypothesis**: the 3 Standard Model fermion generations
correspond to these 3 triality-cycled representations.

### The 48 = 3 × 16 decomposition

Standard Model has 48 fermions = 3 generations × 16 per generation.

```
  Per generation: 16 fermions
    = SO(10) 16-dim spinor rep
    = 8_V + 8_S under D4 (vector + spinor decomposition)
  
  3 generations = 3 × (8_V + 8_S) = 48 fermions = F4 roots ✓
```

The three 16-plets (one per generation) correspond to the three
triality-cycled representations of D4.

### Status — structural claim, specific masses open

**Falsifiable prediction**: mass spectrum of fermion generations
should reflect D4 triality structure. Three charged leptons have
masses:

```
  m_e  =    0.511 MeV
  m_μ  =  105.66 MeV     m_μ/m_e   ≈ 206.8
  m_τ  = 1776.86 MeV     m_τ/m_μ   ≈ 16.8
```

Neither ratio is obviously triality-derivable. Triality EXPLAINS WHY
3 generations exist; doesn't yet explain specific masses. See
`6-masses.md` for the framework's mass-ladder treatment (which DOES
derive these ratios via other substrate counts: 17 = corners + hub,
12 = D4 pairs).

Triality + wheel geometry may eventually give absolute masses. Not
yet done. Open.

## E8 decomposition

E8 is the largest exceptional Lie algebra — 240 roots, rank 8, dim 248.

```
  E8 root breakdown:
    F4 subset:         48  (Standard Model fermions)
    Rest of E8:        192  (dark sector candidate)
                      ───
    Total:            240
```

**Framework reading**: if E8 is our outer wheel, 48 of its roots
correspond to Standard Model fermions (F4); the remaining 192 are
either higher-scale structure or currently unobserved dark matter.

E8 structure contains:

```
  E8 ⊃ E7 ⊃ E6 ⊃ D5 ⊃ D4
       126   72    45   24   (root counts)
       
  E8 ⊃ F4 (48 roots, Standard Model fermions)
  E8 ⊃ D4 × D4 (+ additional structure)
```

**Lisi 2007** (controversial E8 theory) tried to map Standard Model
particles to E8 roots. Framework gives the substrate explanation
Lisi was missing: E8 IS the outer wheel; D4 is the immediate outer
wheel (matches H); F4 is a subalgebra containing Standard Model
fermions; E8 − F4 is where non-SM structure lives.

## SU(5) GUT — right size, wrong embedding

```
  SU(5): dim = 5² - 1 = 24 gauge bosons
```

Georgi-Glashow 1974 proposed SU(5) as the first grand unified
theory. It was experimentally ruled out (predicts proton decay at
rates not observed). BUT the structural size (24 gauge bosons)
matches our 24-cell / D4 roots exactly.

**Framework take**: SU(5) was right about the size of the gauge
structure (24 = D4 roots = 24-cell). It was wrong about the specific
embedding (which forced too-fast proton decay). The correct embedding
is in a larger algebra (SO(10), E6, E8) that contains D4 structure
without the SU(5)-specific decay.

## SO(10) consistency check

```
  SO(10): dim = 10 × 9 / 2 = 45
```

SO(10) GUT has 45 gauge bosons. That's more than the 12 observed.
The extras would be heavy / unobserved gauge bosons at GUT scale.

`45 = 12 (SM observed) + 33 (GUT extras)`. 33 isn't substrate-clean.
Meaning: SO(10) has more structure than the wheel predicts at our
energy scale, but extras should be at Planck-ish energies,
consistent with particle physics' "desert" between EW and GUT
scales.

## Pati-Salam (1974) — natural fallout of S-scope 3+1

**Pati-Salam is the S-scope 3+1 in physics vocabulary.** Pati &
Salam proposed unifying quarks and leptons via:

```
  SU(4) × SU(2)_L × SU(2)_R
  
  where SU(4) treats lepton as "the 4th color"
   (red, green, blue = 3 quark colors + 1 lepton "color")
```

Under the framework's S-scope reading (see `1-wheel.md`):

- **SU(4) emerges naturally** from S = 4 H's. Pick one C-subfield
  per H (same axis-privileging move used inside H → τ as scalar
  axis distinguished from χ/μ/φ imaginary), lift to S-scope →
  C⁴ → SU(4) acts.
- **15 SU(4) generators = 16 half-spin corners − 1 hub.** Or
  equivalently: 16 SO(10) spinor − 1 sterile ν. Substrate-clean.
- **3+1 color decomposition** = S3 peers + Z2 mirror:
  - 3 quark colors = 3 S3-peer H's in S
  - 1 lepton "color" = Z2-mirror H (leptons structurally in the
    mirror sector, quarks in the three peers)
- **SU(2)_L × SU(2)_R** = two copies of unit-H (SU(2) = unit
  quaternions, 1-wheel.md frame 1). One per paired H in
  O = H ⊕ H.

**Pati-Salam didn't need to be proposed — it's what S-scope
geometry gives.** The Pati-Salam framework predates the S-scope
write-up here but is exactly the particle-physics shape of what
S gives. Framework reading: Pati-Salam was correct about the
grouping structure; the substrate explanation is S-scope 3+1.

```
  Pati-Salam element          S-scope substrate source
  ──────────────────          ────────────────────────
  SU(4)                       4 H's in S, one C picked per H
  3 quark colors               3 S3-peer H's (triality orbit)
  1 lepton "color"             Z2-mirror H (flipped 4th)
  SU(2)_L (left-handed)        unit H of one O-half
  SU(2)_R (right-handed)       unit H of the other O-half
                               (chirality = CD doubling direction)
```

**Why Pati-Salam worked where SU(5) failed**: SU(5) forced a
specific proton-decay-inducing embedding. Pati-Salam respects
the 3+1 structure of the substrate (doesn't collapse to one SU(5)
but preserves the 4-H × 2-chirality split). So Pati-Salam avoids
the proton decay signature that kills SU(5).

Testable: Pati-Salam's right-handed currents should show at some
scale. If Pati-Salam-specific signatures are ruled out at
arbitrarily high scales, the S-scope reading needs revision. If
they're found, strong S-scope confirmation.

### Natural E8 path: SO(16) intermediate (2026-04-16c)

Pati-Salam isn't a separate hypothesis — it's the irrep structure
of the natural E8 embedding. The path is:

```
  E8  ⊃  SO(16)  ⊃  SO(10) × SU(4)_PS
  248 = 120 + 128         (adjoint + spinor of SO(16))
                          
  (45,  1) ⊃ Standard Model gauge
  (16,  4) ⊃ 4 generations × 16-spinor
            (3 S3-peer + 1 Z2-mirror under SU(3) ⊂ SU(4))
  (1,   15) ⊃ Pati-Salam leptoquarks + W_R
  (10,  6) ⊃ inter-generation gauge bosons
```

Substrate-rigid identifications forced by E8's subgroup lattice
(not chosen):
- SO(10) 16-spinor = grade-4 corners (16) — confirms P1 in
  `7-open.md`
- SU(4)_PS = 4 H's in 3+1 (the SU(4) → SU(3) × U(1) decomposition
  IS the S-scope 3+1)
- F4 ⊂ E8 = 48 SM fermions (sub-root-system identity)
- D4 ⊂ E8 = 24 = 12 gauge-boson pairs

**Open subquestion**: SU(3)_flavor → S3 breaking mechanism.
Continuous SU(3) gives gen-permutation; framework needs discrete
S3 ⊂ SU(3). Without explicit breaking, the embedding predicts
horizontal gauge bosons that aren't observed. Mechanism unstated.

See `7-open.md § P2` for the full status.

## Gravity — the loop, not a particle

Per `1-wheel.md` and `4-loop.md`: gravity IS the loop iterating. Not
a force mediated by a particle (no graviton). The substrate's own
motion.

### α_G depends on mass scale

```
  α_G = G m² / (ℏc)   depends on mass used
  
  scale                    α_G                    interpretation
  ─────                    ────                   ──────────────
  Planck mass (m_P)         1                     unit-strength at substrate
  proton (m_p)              5.9 × 10⁻³⁹            proton is ~10¹⁹ below Planck
  electron (m_e)            1.75 × 10⁻⁴⁵           electron is ~10²² below Planck
```

**At Planck scale, α_G = 1.** Gravity is NOT weak at its natural
scale — it's weak at our observed scale because our particles are
far below Planck mass.

### The hierarchy as mass-ratio-squared

```
  α_G(m) / α_G(m_P) = (m/m_P)²
  
  For proton:
    (m_p / m_P) = 7.7 × 10⁻²⁰
    α_G(proton) = 1 × (7.7 × 10⁻²⁰)² = 5.9 × 10⁻³⁹  ✓
  
  log₁₀(α/α_G) ≈ 36.09
  2 × log₁₀(m_P/m_p) = 2 × 19.11 = 38.22
  log₁₀(α/α_G) = 2·log₁₀(m_P/m_p) − log₁₀(1/α) ≈ 36.09 ✓
```

**The ~36-order "hierarchy" is just 2 × (19-order mass ratio).**
Factor of 2 from α_G's m² dependence. **No mystery about gravity
itself.** The hierarchy is mass-scale, not force-scale.

### Hierarchy problem dissolved

Standard physics: "Why is gravity ~10³⁹ times weaker than EM?
Requires fine-tuning, supersymmetry, exotic explanations."

Framework: **not a problem**.

```
  Gravity = CYCLE = the ambient loop, medium of iteration
  EM      = CALL  = specific on-quaternion operation
  Strong  = READ  = specific on-quaternion observation
  Weak    = TEST  = specific on-quaternion decision
  
  Gravity being "weaker" is just:
    medium vs gate difference
    background loop vs active verb
    always-on vs fires-specifically
```

A medium doesn't compete with gates for strength — it's a different
category. Category error.

### The 19-mystery remains open

`log₁₀(m_P / m_proton) ≈ 19.11` — proton mass is ~10¹⁹ below Planck.
Why 19?

Candidates:
- 19 = prime (not obviously substrate-clean on its own)
- 19 = 16 + 3 = corners + trit
- 19 = lattice-18 + 1 (18 = electron shell n=3 count?)
- 19 = D4-roots-24 − atoms-5? (stretchy)

**None obviously substrate-clean.** Proton mass emerges from QCD
confinement (95% is gluon field binding, not quark rest mass).
Framework would need to derive QCD confinement scale to get this 19.
Currently incomplete.

Possible fix: if Planck scale itself is substrate-derivable (not
just defined from G/ℏ/c), then the 19 could emerge. See `7-open.md`.

### No quantum gravity needed

Gravity-as-verb is consistent: α_G = 1 at Planck (unit coupling at
natural scale), with (m/m_P)² scaling to observable scales. Matches
"gravity = loop iterating at t_P rate." **No graviton needed.** The
framework's CYCLE/loop interpretation of gravity removes the need
for a particle exchange. α_G behavior follows from loop-tick
mechanics alone.

## String theory — 10D and 11D on the wheel

String theory's 10 and 11 dimensional requirements look arbitrary in
textbooks. Framework reading: these are the wheel's native geometric
structure.

### 10D = 4 axes + 6 bivector planes

```
  framework dimensional accounting:
  
  H (4D):                      4 quaternion axes (χ/μ/φ/τ)
  + bivector planes:           C(4,2) = 6 rotation planes
                               (one per axis-pair: χμ, χφ, χτ, μφ, μτ, φτ)
  = 10 total structural dims   4 + 6 = 10
```

**6 rotation planes in H** (bivector dimensions, see `3-lattice.md`)
**plus 4 H-axes = exactly 10.** String theory's 10D might NOT be
"our 4D + 6D compactified" but rather **the full bivector+vector
structure of H itself.**

Under this reading:
- String theory's 10D = H's complete geometric structure (4 vectors
  + 6 bivectors)
- No need for compactified extra spatial dimensions
- The 6 "extra" dimensions are rotational, not translational

**Same math, different interpretation.** Framework explains what
the extra dimensions ARE (host-wheel rotational structure) rather
than just what they do (compactified).

### 11D = 10 + hub

M-theory adds 1 dimension to 10D = 11D. In framework:

```
  10D (4 vector + 6 bivector) + 1 = 11D
  
  The extra +1 is the hub ↕↕↕↕ as outer-scope connector
  across algebras
```

Most likely reading: the hub as separate "layer" beyond H's 4+6
structure. `10D (H structure) + 1D (hub) = 11D`.

### Strings ARE the loop

String theory's fundamental move: replace 0D particles with 1D
vibrating strings. Vibration modes = particles.

Framework already says **the loop is prior** (wit.md frame 5).
The string IS the loop. Different vibration modes ≈ different
rotational states of the wheel. String theorists got the math right
but the interpretation delusional-default (compactified spatial
dimensions); framework reads the same math as wheel structure.

### 496 — anomaly cancellation

Heterotic strings require a 496-dimensional gauge group for quantum
consistency:

```
  SO(32):       dim = 496
  E8 × E8:      dim = 248 + 248 = 496
```

**Both options involve E8 or its close relatives.** Both land on
496. Why?

496 factorization:

```
  496 = 2⁴ × 31
  496 = 240 + 256 = E8 roots + 2⁸
  496 = 248 × 2 = E8-dim × 2
  496 = 16 × 31
```

**496 is a perfect number** (= 1+2+4+8+16+31+62+124+248, sum of
proper divisors). First four perfect numbers: 6, 28, 496, 8128.
Substrate-interesting.

Euclid showed Mersenne primes (`2ᵖ − 1`) generate perfect numbers
via `2^(p-1) × (2ᵖ − 1)`. `31 = 2⁵ − 1` is a Mersenne prime.

```
  496 = 2⁴ × (2⁵ − 1) = 2⁴ × 31    (3rd perfect number)
```

String theory lands on a perfect number for anomaly cancellation.
Not obvious coincidence.

### 496 status — speculative

Framework-native view: without a graviton, gauge-group anomaly
cancellation via 496 may not apply. **496 might be a string-theory-
frame artifact that dissolves in our framework**, similar to how
Bell's theorem dissolves when we reject separability.

But 496 as a perfect number is substrate-primitive (related to
Mersenne primes and divisor summation). It may still appear in the
framework with a different role — not yet derived. Flagged open.

## Dark sector — non-F4 roots + loop motion

Observed cosmic composition (Planck 2018):

```
  Ordinary matter:  4.86%  (baryons + leptons)
  Dark matter:     26.08%  (interacts gravitationally, not EM)
  Dark energy:     69.06%  (drives accelerating expansion)
                  ──────
                 100.00%
```

### Dark energy IS the loop

Per `1-wheel.md` (why-it-moves) + wit.md frame 6 (gravity = CYCLE
= loop): dark energy is **the wheel's own eternal motion**, not a
new substance.

- Not matter "on" the wheel
- The wheel's own perpetual rotation
- Constant density (matches observed Λ being constant in time)
- Drives expansion because the wheel can't stop spinning

**Framework prediction**: dark energy density is constant (doesn't
evolve with redshift). **Observed**: constant Λ matches this.

Derivation-level: framework says dark energy SHOULD be constant,
and it is.

### Dark matter = E8 − F4 (192 positions) — TENSION FLAGGED 2026-04-16c

Standard Model fermions = 48 = F4 root system. If outer wheel is E8
(240 roots), then 192 E8 roots are NOT Standard Model particles.

```
  E8 root breakdown:
    F4 subset:         48  (Standard Model fermions)
    Rest of E8:        192  (dark sector)
                      ───
    Total:            240
```

> **⚠ Open tension (2026-04-16c).** The natural E8 embedding of the
> SM is `E8 ⊃ SO(16) ⊃ SO(10) × SU(4)_PS` (P2, partially resolved).
> Under that embedding, the 192 non-F4 roots decompose as MOSTLY
> heavy gauge bosons (X/Y from SO(10) at GUT scale, leptoquarks
> from SU(4)_PS, inter-generation gauge bosons from (10,6)) and
> mirror fermions — **not a single stable dark-matter species**.
> The "192 = 12 dark generations × 16 corners each" reading is
> incompatible with this embedding. The "discrete ultralight DM
> peaks" predictions below need to be reconciled with — or
> retracted in favor of — the E8-embedding reading. Currently both
> claims sit in the docs unreconciled. See `7-open.md § P2` and
> the 16c agent report. Pick one or derive how they're compatible.

**Dark matter candidates** (legacy reading, pending tension
resolution): the 192 non-F4 E8 positions. These:
- Couple via the hub (↕↕↕↕) = gravity ✓ (why we detect them only
  gravitationally)
- NOT via F4-specific forces (EM, strong, weak) ✓ (why direct
  detection fails)
- Have specific masses determined by wheel position ✓ (discrete
  mass spectrum, not continuous)

**Count ratio**: 192 / 48 = 4.0
**Observed dark matter / ordinary matter ratio**: 26.08 / 4.86 = 5.37

Current cleanest framework form for the observed ratio: **16/3 =
5.333** (corners/trit, 0.6% error, within Planck measurement noise).
S-scope reading: 3 = S3-peer generation count. See `mind/wheel/6-
masses.md § Dark sector` and stress-test session notes.

### Structural decomposition of 192

```
  192 = 12 × 16  = D4-pairs × corners
       = 168 + 24 = Aut(Fano plane) + D4-shadow partners
       = 3 × 64   = generations × 2⁶
       = 48 × 4   = F4 × axes
```

**Strongest reading**: 192 = 12 × 16 = "12 dark-matter generations,
16 corner-positions each" — direct analog of the SM's 3 generations
× 16-spinor per generation, but with 12 D4-pair generations (the
dark sector has richer generation structure because there's no
triality compression).

**Metrognosis convergence**: 192 = 168 + 24, where 168 = Aut(Fano
plane) = PSL(2,7) = Klein quartic automorphism group = sedenion
zero-divisor count. The Fano plane IS octonion multiplication; the
168 zero-divisor pairs in S preserve Fano automorphisms. So 168 of
the 192 dark-sector positions carry a **Fano-automorphic 168-fold
internal symmetry** — potentially detectable via gravitational
lensing microstructure (hub-coupling only).

### Predicted dark matter mass spectrum

Applying the mass ladder `m = m_P × f × 10⁻(16+N_sub)` to dark
shelves:

```
  shelf    factor      mass            type
  ─────    ──────      ────            ────
  N=1      3/4         ~91 GeV         dark-Z analog
  N=1      √2          ~173 GeV        dark-top analog
  N=3      π/4         ~958 MeV        dark-baryon
  N=3      24/7        ~4.2 GeV        dark-bottom analog
  N=4      √3/2        ~106 MeV        dark-muon analog
  N=6      5/12        ~0.51 MeV       dark-electron analog
  N=12     1           ~0.1 μeV        hub-adjacent
  N=12     1/2         ~0.05 μeV       mirror-neutrino partner
```

**Specific predictions**:
1. **Ultralight DM: discrete lines at 0.05 and 0.1 μeV, not
   continuum.** ADMX cavity haloscopes should see peaks, not broad
   spectrum.
2. **Potential axion reinterpretation**: 10⁻⁶ eV axion searches may
   be detecting N=12 dark shelf states. No θ_QCD mechanism needed.
3. **91 GeV gamma-ray lines** from dark-Z analog gravitational
   decay signatures in galactic halos.
4. **12 distinct lineshapes per shelf** (one per D4-pair), visible
   via gravitational lensing microstructure.
5. **Zero WIMP direct detection ever**, despite mass-ladder hitting
   the 100 GeV WIMP target range.

### Framework prediction: direct-detection will continue failing

**Strong falsifiable claim:**

Direct-detection experiments (XENON, LUX, LZ, PandaX, DAMIC, etc.)
look for WIMPs via elastic scattering with ordinary matter. They
assume dark matter couples weakly to Standard Model particles.

**Framework says this is wrong**: non-F4 wheel positions couple via
hub (gravity) only, not via F4-specific weak force. So direct
detection experiments WILL NOT find dark matter.

**Current experimental status** (as of 2026): no confirmed direct
detection despite decades of increasingly sensitive experiments.
Framework prediction verified so far.

The delusional default keeps predicting "we'll find WIMPs soon" —
framework predicts "you won't, because the physics you're assuming
is wrong about how dark matter couples."

### Abundance decomposition — suggestive but fitted

```
  observed     candidate framework decomposition
  ────────     ─────────────────────────────────
  5%           hub (1) + axes (4) = 5
  26%          D4 roots (24) + 2 = 26
  69%          F4 (48) + trit × wh-words (21) = 69
              ────
              100 exactly
```

**Caveat**: these decompositions are found AFTER seeing the observed
numbers. **Fitted, not derived**. Might be coincidence.

Alternative:
```
  72 (E6 roots) / 240 (E8 roots) = 30%
  Observed matter fraction (ordinary + dark): 31%
```

Close: 30% vs 31% — within measurement uncertainty. If this is
substrate-clean: matter fraction of universe ≈ E6/E8. Dark energy =
70% = rest. Speculative.

### Dark sector summary

**Strong framework positions**:
- Dark energy = loop motion (derivation-level, matches constant Λ)
- Dark matter ≠ standard WIMPs (predicts direct-detection failure,
  currently verified)
- Standard Model fermion count = F4 root count

**Suggestive but fitted**:
- 5/26/69 decomposition using substrate counts
- 30% vs 31% matter fraction from E6/E8

**Open / speculative**:
- Specific dark matter masses from wheel positions
- CMB fluctuation magnitude
- Cosmic abundance exact derivation

## Why "dark" is poorly named in framework

Standard physics uses "dark" because we can't see these components.
Framework says:
- **"Dark matter"**: not-dark, just not in F4 subset. Other wheel
  positions. Visible to gravity (hub coupling). Invisible to F4
  forces. Better name: "non-F4 wheel positions" or "outer sector."
- **"Dark energy"**: not-dark, not even a substance. It's the
  wheel's own motion. Better name: "loop motion" or "substrate
  rotation."

Neither is actually dark — they're visible IF you look with the
right instrument (gravity) or at the right scale (cosmological
expansion). The "dark" label reflects our default frame's
limitations, not a substrate fact.

## Summary — the wheel predicts the Standard Model's structure

```
  particle category       count      wheel structure         match
  ─────────────────       ─────      ───────────────        ─────
  Total fermions          48         F4 roots                ✓
  Per-generation fermions 16         SO(10) spinor /         ✓
                                      16 half-spin corners
  Gauge bosons            12         D4 opposing pairs       ✓
  Higgs scalar            1          Hub ↕↕↕↕                ✓
  3 generations           3          D4 triality             structural
  Dark matter positions  (192)       E8 − F4                 (count ratio
                                                              4 vs 5.4)
  Dark energy             —          loop motion             derivation
```

Four independent counts match exactly. Three generations have
structural explanation via triality. Dark sector has framework-
native interpretation that makes a falsifiable prediction
(direct-detection failure) currently verified.

**This suggests the wheel isn't just a metaphor — it's the
substrate the Standard Model lives on.**

Beyond-Standard-Model physics (SUSY, supergravity, extra spatial
dimensions) may be **unnecessary** — the wheel provides all the
structure needed without supersymmetric partners or compactified
dimensions.

### Status of specific-prediction work

What framework DOES provide:
- Clean explanation of WHY dark sector exists (more wheel positions
  than F4)
- Clean explanation of WHY direct-detection fails (non-F4 positions
  don't couple to F4 forces)
- Clean explanation of WHY 3 generations (D4 triality)
- Clean explanation of WHY time flows (τ monotone, wit.md frame 8)
- Clean explanation of WHY hierarchy (mass-scale-squared, not
  force-scale)
- Specific mass/coupling predictions at sub-1% precision
  (see `6-masses.md`)

What framework DOESN'T YET provide:
- Specific numerical predictions for all particle masses (some fit,
  some don't — see `7-open.md`)
- Full derivation of cosmic abundance ratios from first principles
- Absolute Planck mass from substrate alone
- 19-mystery (why proton is 10¹⁹ below Planck)
- Specific dark matter mass spectrum

See `7-open.md` for the honest debt.
