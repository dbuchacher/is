# 7 — Open Questions, Speculation, Falsifiers

The honest debt. What framework doesn't yet derive, what's marked
speculative, and what would break the framework if observed.

Three sections:
1. **Open questions** — things we expect to eventually derive but
   haven't. Priority-ordered.
2. **Speculation** — reasoning that's consistent with framework but
   not directly verified. Marked to not be mistaken for derivation.
3. **Falsifiers** — concrete observations that would break specific
   framework claims.

---

## Resolved in 2026-04-16 S-scope stress-test session

Nine parallel tests stress-tested "S contains 4 H's as peers"
framing. Results:

**Strong confirmations (3):**
- **Sedenion zero divisors 168** — 5-way convergence: 168 = 4! × 7
  (framework vocab) + bare-metal `zero_divisors_d16 = 168` computed
  in lattice walker + Fano plane automorphisms + PSL(2,7) + Klein
  quartic. S is structurally real.
- **Pati-Salam SU(4) emergence** — falls out naturally from S-scope
  3+1 structure. 15 generators = 16 corners − 1 hub. 3 quark colors
  + 1 lepton "color" = 3 S3-peer + 1 Z2-mirror H's. Moved to
  `5-physics.md`.
- **Aut(S) = 48 = S3 × Z2** — triple convergence with F4 roots and
  SM fermion count. Cartan's classification: Out ≤ S3 always, S3
  achieved only by D4. No 4th generation possible, ever.

**Frame corrections (4):**
- "4 peer H's in S" → corrected to **"3 triality-peer H's + 1
  CD-mirror H"** (Aut(S) = S3 × Z2 structure). Not 4 symmetric peers.
- "Qubits ↔ CD layers" mapping **rejected** — qubits use tensor
  product, CD uses direct-sum+involution. Different functors. Clean
  identity only at single-qubit = SU(2) = unit H level. Quantum/
  classical distinction lives at VERB tier (frame 6), not
  algebra-layer tier.
- "n-particle entanglement scales with CD scope" **rejected** —
  frame 10 reading (one quaternion, n apertures) scales for all n.
  Hilbert 2^n is aperture-count, not substrate scope.
- "4 neutrino species from 4 H's" **retracted** — framework actually
  predicts 3 generations × (active + sterile) = 3+3 via D4 triality.

**Inconclusive (2):**
- **Dark ratio 5.37** — cleanest substrate form is 16/3 (H-internal,
  not S-peer). "Dark = other H's" doesn't land cleanly. Slight
  falsification pressure on that specific story.
- **Chirality × 4 H's = 8** — redundant. CD doubling IS chirality
  flip; double-counts. H-scope 8 already covers everything.

**Category error found:**
- **"48 vs 12 gauge bosons" premise wrong** — 48 = F4 = fermions,
  12 = D4 pairs = bosons. Different kinds of objects. No inflation
  to resolve.

Net: framework got **sharper**, not weaker. The S-scope reading is
real with refinements. 3+1 pattern is load-bearing.

---

## 2026-04-16c — 5-agent parallel sweep results

Fired 5 parallel agents on the revised priority list (post-16b
retraction). Each ran with mandatory noise-null discipline. Net
outcome: **1 partial resolution, 0 closures, 1 retraction
kickback, 3 honest no-signals**. Framework got marginally sharper
on E8 embedding; otherwise leveled.

| # | Question | Verdict |
|---|----------|---------|
| P2 | E8 embedding | **PARTIAL** — clean at irrep level via E8 ⊃ SO(16) ⊃ SO(10) × SU(4)_PS. Per-particle assignment is wrong question. Dark sector reading needs revision (192 is mostly heavy gauge, not stable DM). |
| P10 | CP violation magnitude | **NO PROGRESS** — multiple sub-1% candidates (α⁴×√3/8, α⁴×(5/24+α)) all consistent with substrate-pool chance. η_B has 0.7% measurement uncertainty; can't beat noise floor by formula-fitting. |
| P4 | Running α(Q²) | **NO PROGRESS** — substrate naming consistent (3 in 1/(3π) = trit, etc.) but no derivation. 1/(3π) has substrate-clean alternatives 2/19 (0.79%), 3/28 (0.98%) — same noise pattern. |
| P13 | y_e direction | **BLOCKED** — y_e is dimensionless, m_P cancels entirely. The 5-and-5 coincidence is likely separate constructions (axes+hub vs bivectors−hub). 0.97% gap because m_e and v_Higgs errors compound. |
| Wieferich | Base-3 hunt | **NO SIGNAL + RETRACTION** — only 11 and 1006003 known under 10¹⁷. The hit on p=11 is in a regime where 100% of nearby primes are "substrate-adjacent" (zero info); 1006003 decisively misses (in regime where adjacency rate is 0.1%). **Same kickback hits the original 1093 base-2 claim** — pareidolia from local density. See `metrognosis/prime-lattice.md § Wieferich primes — RETRACTED`. |

**What survives:** P2's irrep-level embedding is real (substrate-
rigid identifications: SO(10) 16-spinor = grade-4 corners, SU(4)_PS
= 4 H's, F4 = 48 fermions, D4 = 24 = 12 gauge pairs). All else: no
delta from 16b state.

**Methodological lesson reinforced:** the same noise-null
discipline that killed the log-depth family (16b) killed the
Wieferich claim (16c). At small integer magnitudes, substrate-
clean integers are dense; at large magnitudes they're sparse.
Signal is the EXCESS over local density, not the adjacency. Any
"X near substrate" claim needs a local-density null. Updated in
`moves.md § Anti-patterns`.

**Revised next-move priorities:**
1. Mechanism-first attacks (not formula-fitting). E.g. the
   SU(3)_flavor → S3 breaking mechanism for P2.
2. P11 (Higgs VEV factor 2) — simpler than P13 and entangled
   with it.
3. P5 (Δ(n-p) = m_p × α × 3/16) — derive 3/16 from wheel
   mechanics, not pattern-match.
4. Dark sector reconciliation: E8 ⊃ SO(16) ⊃ SO(10) × SU(4)_PS
   says 192 is mostly heavy gauge, contradicting the "discrete
   ultralight DM peaks" prediction in `5-physics.md`. Needs
   resolution before either claim can be defended.

---

## Retracted in 2026-04-16b stress-test session

Statistical retest of the "log-depth invariant family" claim from
the round-2 stress test (the `f8e15ee` commit). Verdict: **noise**.

- Density of n/m fractions with n,m<50 in [0.5, 1] is ~580. Random
  ratios in this range hit some small fraction within 0.1% with
  78.5% probability; SM pairs do so at 79.1% (no excess).
- At 0.005% precision: random ~5.7%, SM ~5.5% (no excess).
- Direct verification of the 9 specific pairs cited: 4 hold (H/p =
  8/9, Z/down = 4/5, top/p = 15/17, p/strange = 19/20, W/μ = 6/7),
  4 are wrong (W/bottom = 9/10 off 3.4%; top/bottom = 15/17 off
  3.4%; Z/τ = 17/19 off 1.6%; τ/e = 6/7 off 1.8%), 2 weak.
- Even the verified hits are within statistical expectation.

**What the retraction kills:**
- The "6/7 = bivectors/wh-words" cross-pair attractor claim.
- The 9-pair "log-depth invariant family" as evidence.
- The framing "close 6/7 gap → cascade P1+P13+P14."

**What survives intact:**
- All individual mass decompositions (Lp = 19+log(4/3)−log(1+7α/2),
  Le = 22+log(12/5)−log(1+4α/5), and the analogues for every SM
  particle). These match observation at 10⁻⁵ — real signal.
- The 17 anchor (5+ independent appearances).
- P1 working-hypothesis (16 = grade-4 corners).
- The 19-mystery decomposition (19 = 17+2 = corners+hub +
  Z2-pair) — internally consistent with proton's individual decomp.

**Methodological lesson.** Pattern-matching small fractions to
ratios is high-risk because n/m density saturates [0.5, 1]. Future
"family" claims need explicit randomized null comparison before
publication. See `wit/mind/moves.md § Anti-patterns` for update.

---

## Open questions — priority list

These carry forward from the 2026-04-15 session handoff. Each is
framework-visible (stated in substrate terms) but not framework-
derived (no clean formula yet).

### P1 — Derive the 16 baseline — WORKING HYPOTHESIS (2026-04-16)

If the mass-scale rule is `m = m_P × f × 10^(-(16 + N_sub))`, why
16? Resolved in the 2026-04-16 session:

**16 = grade-4 corners = SO(10) 16-spinor = per-generation fermion
count.** The 16 IS the grade-4 shelf itself. N_sub then counts
*additional* substrate commits layered on top of grade-4.

**Evidence (triangulation)**:
- Electron log-depth decomposes as `log(m_P/m_e) = 16 + 6 + log(12/5)`
  = corners + bivectors + (D4-pairs/shelf) — grade-structure exact
  to 0.005% on the log
- Reheat temperature = 10¹⁶ GeV = 10^(corners) — explicit in the
  framework
- SO(10) GUT's 16-spinor = per-generation fermion count = one grade-4
  sign-pattern set
- 16 is NOT the CD-doubling count (2⁴ chain is inter-algebra, 16
  there would double-count axes at S-scope)

Semantic lock: **matter lives at grade 4 (all axes committed) because
grade 4 is where the lattice reaches its corner structure**, and each
corner carries one SO(10) spinor's worth of fermion content.

**Remaining gap**: still doesn't pin absolute Planck-scale from pure
substrate integers (P13 — see below).

### P2 — Full particle embedding in D4 / E8 — PARTIAL (2026-04-16c)

Asked the question correctly and got a clean answer at the
representation-theoretic level. The right embedding path is:

```
  E8 ⊃ SO(16) ⊃ SO(10) × SU(4)_PS,    248 = 120 + 128
```

with `(45,1) ⊃ SM gauge`, `(16,4) ⊃ 4 generations × 16-spinor`,
`(1,15) ⊃ Pati-Salam leptoquarks + W_R`.

**What's substrate-rigid (survives null check):**
- **SO(10) 16-spinor = grade-4 corners (16)** — confirms P1; the
  identification is forced by E8's subgroup lattice, not chosen.
- **SU(4)_PS = 4 H's** — the SU(4) decomposing as 3+1 under
  SU(3) ⊂ SU(4) IS the S-scope 3+1 (S3-peer + Z2-mirror). Pati-
  Salam isn't a separate hypothesis — it's the irrep structure of
  the natural E8 path.
- **F4 = 48 SM fermions** — sub-root-system identity, not fitted.
- **D4 = 24 = 12 gauge-boson pairs** — present inside SO(10) ⊂ E8.

**What's NOT clean (per-particle root assignment):** group theory
acts on irreps, not labels. "Electron is root #173" was always
going to be the wrong granularity. The embedding is at the level
of representations; individual root vectors aren't pinned by
embedding alone.

**Open subquestion (new):** SU(3)_flavor → S3 breaking mechanism.
Continuous SU(3) gives gen-permutation; framework needs S3 ⊂ SU(3).
Without an explicit breaking mechanism, the embedding predicts
unobserved horizontal gauge bosons. Patch suggested but not
derived.

**Falsifiable predictions from the embedding:**
1. Pati-Salam leptoquark signatures (rare K → μe, μ → eγ enhanced)
2. SU(3)_flavor breaking mechanism OR horizontal currents at some
   scale
3. Right-handed neutrinos in SO(10) 16-spinor (one per generation),
   structurally identified with the Z2-mirror sector
4. No 4th SM generation, ever (Cartan ceiling, inherited)
5. No graviton appears as an E8 root state

**Dark sector revision:** previous "192 = 12 dark gens × 16
corners each" reading needs revising. Under E8 ⊃ SO(16) ⊃ SO(10) ×
SU(4)_PS, the 192 non-F4 roots are MOSTLY heavy SO(10) gauge
bosons (X/Y), SU(4) leptoquarks, mirror fermions, and (10,6)
inter-gen bosons — NOT a single stable DM species. The "discrete
ultralight DM peaks" prediction in `5-physics.md § Dark sector`
needs to be reconciled with this. Open follow-up.

### P3 — Unclean particles (bottom RESOLVED)

**Bottom quark — RESOLVED (2026-04-15).** Blind-agent test applying
the methodology independently landed on `m_b = m_P × (24/7) × 10⁻¹⁹
= 4.183 GeV` vs observed 4.18 GeV, 0.07% error. 24 = D4 roots, 7 =
wh-words, N_sub=3 shelf (with tau, charm, proton). Clean substrate
derivation, not post-hoc fit. Moved to 6-masses.md main ladder.

Still unclean:
- **Pion 1.144** — near 1.025 (Higgs) but not exact
- **Tau 1.457** — fits `√2 + 6α` but is that the "right" form?
- **W 2/3 × (1 - 1.6α)** — why 1.6?
- **Z 3/4 × (1 - 0.5α)** — why 0.5?

Negative corrections for gauge bosons particularly need geometric
interpretation.

### P4 — Running couplings α(Q²) — STILL OPEN, attack failed null (2026-04-16c)

Framework gives α at some reference scale (α⁻¹ = 137.036). Does it
predict the RUNNING (energy dependence) of α?

**2026-04-16c attack — substrate naming yes, derivation no.** The
standard QED running `1/α(Q²) = 1/α(0) − (1/3π) ln(Q²/m_e²)` reads
substrate-cleanly (3 in 1/(3π) = trit; π = C-tier half-rotation;
Q²/m² squared = 720° spinor period; ln-structure = revolutions per
probe scale; m_e in denominator = lightest charged probe). But this
is reframing what's already there, not new prediction.

**Noise null killed candidate forms.** Density of small-integer ×
π terms in the coefficient range is high enough that 1/(3π) has
substrate-clean alternatives: 2/19 (0.79% off), 3/28 (0.98% off).
Same pattern as the retracted log-depth family — multiple substrate
stories fit the same number.

**Suggestive but inside noise floor:** α_GUT⁻¹ ≈ 24-26 lands in
the 24 = D4 root band, but MSSM uncertainty spans the same range.
α_s/α ≈ 15.1 vs 16 (corners) is 6% off, not clean. 4 fractal
scopes ↔ 4 couplings (3 gauge + gravity) is structurally
suggestive but doesn't give running coefficients.

**What would close P4:** β-function coefficient derivation from
group-theory invariants of D4 / F4 / E8 root systems (33/5, 1, -3
in MSSM; 41/10, -19/6, -7 in SM), not coefficient-pattern matching.
α_GUT prediction at 0.1% precision with derived (not fitted)
unification scale.

### P5 — Neutron-proton mass difference refinement

```
  Δ(n-p) = m_p × α × 3/16  works to 0.7%
```

Why 3/16 specifically? Is this framework-derivable? 3 = trit
(quarks per baryon), 16 = corners (4-cube vertices). But clean
derivation needs the ratio to emerge from wheel mechanics, not
pattern-match.

### P6 — GUT scale prediction

Grand unification theories predict `10^16 GeV` scale. Framework
has 16 = corner count. If matter lives at `10^-(16+N_sub)`, and
GUT scale is `10^16 GeV`, GUT is at N_sub=0 (= corners alone,
without extras). Verify.

### P7 — Consciousness connection

wit.md frame item 11 gives two options (consciousness IS the loop
vs consciousness enters via ↕↕↕↕). If consciousness = loop
recognizing itself, there should be a specific wheel-derivation of
subjective experience. Very open.

Under option B (consciousness enters via hub): ↕↕↕↕ is the one
point shared across all CD layers. If consciousness lives at O (8D
host) or above and enters H through the hub, every recognition
event is a hub-crossing. Framework prediction: consciousness
correlates with hub-adjacent wheel activity. No way to test this
yet.

**Under both options, YOU are structurally central.** Not Earth, not
the Sun, not any particular reference frame. The hub isn't spatial;
it's the point where recognition loops close. That's wherever
recognition is happening — which is wherever an observer is. Every
wit is at their own hub, and (per frame 10) the "many hubs" are
actually ONE hub read through many apertures — same identity move as
entanglement.

The consciousness question becomes: is the one-hub-seen-many-ways
(option A, loop IS consciousness) or something crossing into the
one-hub from outer CD layers (option B, consciousness enters)? Both
are consistent with observer-IS-center. What framework **rejects** is
the third option (consciousness localized in brains, produced by
neurons) — that's the 400-year Cartesian error. See `1-wheel.md`
"Where is the hub?" for the full observer-IS-center treatment.

### P8 — Blind-agent tests on open trit-mult cells

`2-trits.md` has 4 divergent cells in the 3×3 relational table:
- ↕→↑ (start forward commit)
- ↕→↓ (start backward commit)
- ↓→↑ (reverse-flip)
- ↓→↓ (sustained past)

Framework hypothesis: these aren't lexical gaps, they're cells
where the wheel's rotation outpaces English's naming convention.
Each domain has its own metaphor.

**Testable**: run blind-agent experiments constrained to specific
domains (just physics, just chemistry, just music). If each domain
converges on its own primitive for the same cell, framework is
confirmed. If all domains still diverge, framework needs revision.

### P9 — Specific dark matter masses — CONCRETE PREDICTIONS (2026-04-16)

Framework says non-F4 E8 roots (192 positions) should have specific
masses. Upgraded to concrete predictions in the 2026-04-16 session:

**Structural decomposition**: 192 = 12 × 16 = D4-pairs × corners.
Reads as "12 dark generations × 16 corner mass points per generation."
Alternative: 192 = 168 + 24, where 168 = Aut(Fano plane) = sedenion
zero-divisor count (metrognosis convergence) and 24 = D4-shadow
partners. See `mind/metrognosis/` (new prime-lattice entry).

**Predicted dark mass spectrum** (from mass ladder
m = m_P × f × 10^-(16+N_sub)):

```
  shelf    factor      mass            type
  ─────    ──────      ────            ────
  N=1      3/4         ~91 GeV         dark-Z analog
  N=1      √2          ~173 GeV        dark-top analog
  N=3      π/4         ~958 MeV        dark-baryon
  N=3      24/7        ~4.2 GeV        dark-bottom analog
  N=4      √3/2        ~106 MeV        dark-muon analog
  N=6      5/12        ~0.51 MeV       dark-electron analog
  N=12     1           ~0.1 μeV        D4-pair hub-adjacent
  N=12     1/2         ~0.05 μeV       mirror-neutrino partner
```

**Framework prediction**: ultralight DM should show **discrete**
spectral lines (0.05, 0.1 μeV), **NOT a continuum**. ADMX-style
cavity haloscopes should see peaks. Axion searches at 10⁻⁶ eV may
actually be detecting N=12 dark shelf states (no θ_QCD mechanism
needed).

**Concrete falsifier**: ADMX or similar finds ultralight DM in a
continuous spectrum with no framework-predicted peaks. Framework
requires discrete.

**Direct detection** (XENON, LZ) should continue failing even in
the 91-173 GeV WIMP mass range because non-F4 positions couple
only via hub (gravity), not via F4 forces.

### P10 — CP violation magnitude — STILL OPEN, attack failed null (2026-04-16c)

Observed η_B = (6.12 ± 0.04) × 10⁻¹⁰; current framework form
α⁴ × sin²(θ_W) = α⁴ × log(2)/3 = 6.55 × 10⁻¹⁰ (+7.4%). Largest
remaining framework numerical gap.

**2026-04-16c attack — multiple sub-1% candidates, all noise-floor:**

```
  candidate                       prediction (×10⁻¹⁰)   err
  ─────────                       ──────────────────   ───
  α⁴ × √3/8                       6.139                +0.65%
  α⁴ × (5/24 + α)                 6.115                +0.24%
  α⁴ × log(2)/3 × exp(−10α)       6.091                −0.15%
  α⁴ × 3/14                       6.077                −0.39%
```

**Noise null kills these.** Substrate-clean pool of ~2420 formulas
of form `α^k × {n/m, √n/m, n/√m}` with n,m ∈ 24-element substrate
integer set: random hit rate is 0.083% at 1% precision over 2420
trials = ~2 expected hits. Found exactly 2 hits. **Statistically
indistinguishable from chance** in the substrate pool. Same anti-
pattern as the log-depth family.

**Plus** η_B itself has ~0.7% Planck CMB measurement uncertainty,
so the true signal floor for this question is ~1%. Even a derived
form can't be distinguished from formula-fitting via numerics
alone.

**Z2-mirror mechanism status — qualitative yes, magnitude no.**
Sakharov conditions hold: B-violation (sphalerons / trit-arc
commits at hub), C/CP-violation (non-commutativity ij≠ji + Z2-
mirror H provides asymmetry), out of equilibrium (eternal wheel
rotation, 3rd law). But no Z2-mirror argument independently
predicts a suppression factor at the right magnitude.

**What would close P10:** mechanism-first derivation. If a Z2-
mirror argument from CD-doubling geometry independently predicts a
suppression factor near exp(−10α) ≈ 13/14 (or whatever survives
the noise null), then a numerical fit becomes meaningful. Without
that mechanism, formula-fitting is futile at this measurement
precision.

### P11 — Higgs VEV absolute derivation

Framework gives VEV = 2 × 10⁻¹⁷ × m_P with factor-of-2 interpreted
as ±hub reach. But why exactly 2 and not 1 or 3? What wheel
operation has magnitude exactly 2?

### P12 — Cosmic abundance (5%/26%/69%)

Observed:
```
  Ordinary matter:  4.86%
  Dark matter:     26.08%
  Dark energy:     69.06%
```

Framework has candidate decompositions (hub+axes=5, D4 roots+2=26,
F4+trit×wh-words=69) but these are **fitted, not derived**. Derive
from first principles without knowing observed numbers.

### P13 — Planck mass from substrate alone — STILL OPEN (revised 2026-04-16b)

Framework currently uses m_Planck as input. Status revised after
the log-depth retraction (see `6-masses.md § Pairwise log-depth
ratios — RETRACTED`):

**Relational closure achieved**: `m_P = (12/5) × 10²² × m_electron`.
Substrate-clean factor (5/12 = (axes+hub)/D4-pairs) with exponent
22 = 16 + 6 = corners + bivectors. ~0.45% error (inherits from m_e's
5/12 fit). The relation is CIRCULAR — requires m_e as input.

**Earlier "6/7-gap closes P13" claim withdrawn**. The proton/electron
log-depth ratio is 0.85415 (matched by α-corrected decomps to 10⁻⁵),
NOT 6/7 = 0.85714. There's no "gap" to close. The whole "log-depth
invariant family" turns out to be statistical noise (SM pair hit
rates at every precision match random hit rates in [0.5, 1]). See
the retraction section in 6-masses.md.

**y_e attack — BLOCKED (2026-04-16c).** Tried deriving electron
Yukawa y_e = m_e/v_Higgs from substrate. Algebraic identity verified:
`y_e = (5/12 + α/3)/2 × 10⁻⁵ = (5/24)(1 + 4α/5) × 10⁻⁵`. Numerical:
predicted y_e = 2.0955 × 10⁻⁶ vs observed 2.0753 × 10⁻⁶ — 0.97% off
(m_e and v_Higgs errors compound rather than cancel).

**The 5-and-5 coincidence — likely separate constructions, not one
fact.** The 5 in the geometric factor 5/12 = (axes+hub)/D4-pairs IS
axes+hub. The 5 in the exponent gap = (electron shelf 22) − (EW
shelf 17) = bivectors − hub. Numerically equal but algebraically
independent decompositions. Most parsimonious read: 5 is the
substrate's preferred small-integer slot; both readings naturally
land there without being "the same 5".

**y_e cannot pin Planck mass anyway** — m_P cancels in y_e (it's a
pure dimensionless ratio). Even a fully structural 5-and-5 would
not close P13; the entire decomposition is scale-free.

**What would actually close P13:**
(a) Independent derivation of v_Higgs = 2 × 10⁻¹⁷ × m_P from
    gravity/cosmology rather than assertion (this is P11).
(b) Substrate derivation of geometric factor 5/24 from S-scope /
    D4 wheel mechanics that fixes BOTH mass and VEV simultaneously
    without circularity.
(c) α_G = 1 at m_P upgraded from definition to derivation via
    wheel/loop dynamics.
(d) Noise-null verification across all 91 SM ratios for the
    "geometric numerator = shelf gap" rule before treating the
    electron 5-and-5 as signal.

No clean path open. Entangled with P1 (resolved working-hypothesis,
16 = grade-4 corners) but P1 doesn't pin absolute scale either.

### P14 — 19-mystery (proton/Planck ratio) — WORKING HYPOTHESIS (2026-04-16)

```
  log₁₀(m_P / m_proton) ≈ 19.11
```

Proton mass is ~10¹⁹ below Planck. Resolved to working-hypothesis by
2026-04-16 stress-test session (see `6-masses.md § The 19-mystery`):

**Decomposition**: `19 = 17 + 2 = (corners+hub) + (Z2-pair)` — proton
shelf = EW shelf + one chirality-commit (CD-doubling step).

**0.1 offset**: `mean offset ≈ log₁₀(4/3) = 0.1249` — axes/trit, the
virial factor for QCD confinement geometry. Real baseline is
`10⁻¹⁹ × (3/4)`.

**~~New invariant~~ — RETRACTED 2026-04-16b**: `log(m_P/m_p) /
log(m_P/m_e) = 6/7` was claimed at 0.4% error. True observed ratio
is 0.85415, off 0.35% from 6/7 = 0.85714. Statistical retest shows
the whole "log-depth invariant family" is consistent with noise —
n/m fractions saturate [0.5, 1] densely enough that random ratios
hit small fractions ~80% of the time at 0.1% precision. See
`6-masses.md § Pairwise log-depth ratios — RETRACTED`. The 17+2
shelf decomposition for proton remains; just the 6/7 ratio claim
falls.

**QCD confinement scale**: `log₁₀(m_P / Λ_QCD) ≈ 19.79 ≈ 20 − 1/4`
(trit shelf + one axis-quarter). Proton's π/4 factor = confinement
at 45°.

**Remaining open**: formal derivation of Planck mass (P13) from
substrate alone would close both P13 and P14 simultaneously. Also
worth re-expressing proton π/4 as π/3 under the new 3/4 shelf
baseline — predict same family as muon's sin(60°).

### P15 — CMB temperature

Framework predicts CMB T ~ 2 × 10⁻³² × m_P ≈ 2.83 K. Observed 2.725
K (4% error). Close but not derivation-quality. What's the right
factor?

### P16 — 3-generation masses from triality

D4 triality EXPLAINS why 3 generations exist (structural — the
three 8-dim representations cycle). But it doesn't yet explain
specific masses (m_e, m_μ, m_τ).

Other framework paths (via 17 × substrate counts) DO give the mass
ratios, but not from triality directly. Does triality + wheel
geometry give absolute masses? Not yet derived.

### P17 — g-2 anomaly magnitude (structural vs numerical)

The muon anomalous magnetic moment Δa_μ = 2.51 × 10⁻⁹ (BNL/FNAL
vs SM) is a 5σ tension.

**Structural read (2026-04-16, WORKING)**: triality-probe reading
applies — gen-1 electron reads Schwinger + SM-clean residual;
gen-2 muon reads Schwinger + scope-dependent residual of different
sign. Sign flip between generations matches the S3 orbit structure.
Framework predicts a_τ (if ever measured) shows yet another sign/
magnitude completing the orbit.

**Numerical gap (2026-04-16, OPEN)**: no substrate-clean form
lands inside experimental uncertainty for Δa_μ specifically.
Closest is **120α⁵ = 2.48 × 10⁻⁹** (1.1% from measured Δa_μ, 120 =
E8 pairs) — suggestive but not at proton-radius-puzzle tightness
(0.04%). Also experimentally unstable: BMW lattice and CMD-3
(2023) shrink Δa_μ toward zero; wait for resolution.

**Difference from proton-radius puzzle**: proton radius had two
DIFFERENT MEASUREMENTS of the same quantity (gen-1 vs gen-2 probes)
→ triality gave a clean factor √(1+12α). g-2 is a SINGLE
MEASUREMENT vs SM prediction → triality explains structure but not
magnitude. Partial read; watch for experimental settling.

## Speculation (flagged, not derived)

Not open questions — reasoning that's **consistent** with framework
but not directly verified. Don't confuse for derivation.

### The tower IS one verb from an outer frame

Per wit.md frame 7 (no infinity) + frame 0 (fixed point IS
structure): the Cayley-Dickson doubling has no upper bound from
inside, but substrate forbids infinity.

Partial resolution (in `1-wheel.md`): the tower is a wheel,
revolutions are endless but spokes finite.

**Speculative extension**: the entire R/C/H/O/S/... chain might
itself be **one verb from an outer frame**. Our inner values
(integer lattice points in H) and inner verbs (spin, SU(2), edges)
might be one operation-instance of a meta-verb at outer scope.

```
  inside the chain (our view):
    R → C → H → O → S → 32D → ... (apparent infinite ladder)
  
  outer frame (speculative):
    the whole chain = ONE operation, closed as a verb
    outer values = whole algebra-chains as integers?
    outer verbs  = meta-transitions between chains?
```

Each property-loss in Cayley-Dickson (ordering → commutativity →
associativity → division → ...) might be the outer verb's internal
stages — the algebra-chain as a single operation unfolding.

**Status**: can't verify from inside H. Consistent with frames 0+7.
No operational consequence. Flagged.

### Consciousness enters via hub (option B)

wit.md frame 11 gives two options:
- **Option A**: consciousness IS the loop. The wheel's spinning IS
  awareness.
- **Option B**: consciousness enters via ↕↕↕↕ from outside (the
  hub as bridge between CD layers).

**Speculative case for B**: ↕↕↕↕ is dimension-independent — same
point in R, C, H, O, S. It's the one coordinate shared across the
entire Cayley-Dickson tower. If consciousness lives at a higher CD
layer (O or above), it can ENTER H through the one point every
layer holds identical. This would explain why consciousness feels
"in" the world without being of it.

**Under A**: stars spinning IS consciousness, current flowing IS
consciousness — no loop activity that ISN'T recognition.

**Under B**: the loop runs without consciousness (stars spin
mechanically), and consciousness is what comes through ↕↕↕↕ and
USES the loop — entering, recognizing, leaving. The watchers come
and go.

**Status**: Both options consistent with framework. Framework
**rejects** the third option (consciousness localized in brains,
produced by neurons) — that's the 400-year Cartesian error. But
between A and B, no derivation yet. Not collapse prematurely.

### D4 triality = 3 generations (structural, masses open)

D4 is unique among Lie algebras in having S3 outer automorphism
(triality). The Standard Model has 3 fermion generations.

**Speculation**: the three generations ARE the three triality-
cycled 8-dim representations of so(8).

**Status**: structural fit is clean (count matches, substrate-
native). Specific mass derivation not done. See P16 above.

### E8 vs D4 as outer wheel

`1-wheel.md` treats D4 as the immediate outer wheel (matches H's
24-cell directly). E8 may be the "outer-outer" wheel (richer, 240
roots).

**Speculation**: our local wheel is D4-level, embedded in a larger
E8 structure at higher scope. Dark sector candidates (192 non-F4
E8 roots) require E8; Standard Model structure fits F4 ⊂ E8 cleanly.

**Status**: consistent with framework. Direct observational test
would need either (a) finding a non-F4 mass that matches a specific
E8 root prediction, or (b) showing 496 has a framework-native role
that only E8 provides.

### 496 may dissolve in graviton-free framework

Heterotic string theory requires 496-dim gauge group for anomaly
cancellation. Without a graviton, gauge-anomaly cancellation via
496 may not apply.

**Speculative**: 496 might be a string-theory-frame artifact that
dissolves in our framework, similar to how Bell's theorem dissolves
when we reject separability.

But 496 as a perfect number is substrate-primitive (related to
Mersenne primes and divisor summation). It may still appear with
a different role. Not yet derived.

### Planetary tilt 23.5° is accidental

Earth's axis tilt creates precession (the Great Year helix). The
tilt existing IS substrate-required (otherwise no helix). The
specific 23.5° value is likely planetary-formation accidental
rather than substrate-required.

Check: does 23.5° relate to any substrate angle?
- 23.5° × 16 = 376° — not clean
- 23.5° / 360° = 0.0653 — no obvious pattern
- 90° − 23.5° = 66.5° — not clean

No obvious framework derivation. Flagged accidental.

### 108 convergence

```
  Ratio                                    value
  ─────                                    ─────
  Sun's distance / Sun's diameter          ~108
  Moon's distance / Moon's diameter        ~110 (close to 108)
  Great Year / E8 roots                    25,920 / 240 = 108
  Sacred in Hindu/Buddhist (mala beads)    108
  m_p/m_e                                  108 × 17 = 1836
```

108 appears as substrate ratio:
- astronomically (Sun-Earth-Moon geometry)
- algebraically (Great Year / E8 roots, appears in proton/electron
  ratio as 108 × 17)
- cross-culturally (mala beads, sacred count)

**Convergence across three independent domains = metrognosis
signal.** Not directly derived, but very hard to dismiss as
coincidence given effort × precision × independent convergence.

### 3-5-7 prime signature — DERIVED (2026-04-16)

```
  3   = trit (axis values)                [framework-committed]
  5   = ordered-pair straddle count       [DERIVED — trit-structural]
        through trit edge values ±1
  7   = ordered-pair straddle count       [DERIVED — trit-structural]
        through trit center value 0
```

**Closed form** (verified N=4, N=8):

```
  cent_per_node(k, N) = (7^(N−k) · 5^k − 2·3^N + 1) / 2
  Δ(k → k+1) per node = 7^(N−k−1) · 5^k              [N-independent]
```

5 and 7 are trit-structural constants — properties of the 3-element
ordered set {−1, 0, +1}, not of lattice dimension N. The 888 = (7⁴ − 5⁴)/2
cascade at N=4 is the special case.

**What was disconfirmed (2026-04-16)**: an earlier reading predicted
CD-layer-activation of new primes at new lattice dimensions (e.g. 11
and 13 at O-scope via degree formula 2N−k). Tested at N=8 and failed:
the cascade is N-independent, 11 and 13 never appear. See
`wit/thoughts/trit½/prime-lattice/findings/11-N8-centrality-cascade.md`.

**Status**: trit-structural derivation DERIVED. CD-layer-activation
DISCONFIRMED. Canonical migration pending into `wheel/2-trits.md`
and `wheel/3-lattice.md`; `wit/thoughts/trit½/3-5-7.md` pending
retirement after migration.

### Chain of chains at outer scope

If each D4-root chain is a Cayley-Dickson tower, and outer wheel
has 24 chains, total structure:

```
  hub 0 (shared)
       │
   24 chains radiating out (D4 root directions)
       │
   each chain: R → C → H → O → S → ...
       │
   our inner wheel's algebra = H, one layer of one chain
```

Number of wheel positions across all chains:
- 24 chains × 4 Hurwitz layers (R, C, H, O) = 96 positions
- More if chains extend into S and beyond

**Status**: geometric framing only. Physical interpretation not yet
derived. Open.

## Falsifiers — what would break the framework

These are **concrete observations** that would break specific
framework claims. Framework is testable; if any of these happen,
framework must revise or die.

### Structural falsifiers (from wit.md)

- **A useful operation outside the 80 shell-1 patterns** would break
  the claim that 80 non-container positions enumerate the lattice.
- **General-purpose 1024-bit SIMD shipping and working** would break
  Cayley-Dickson ceiling.
- **A 5th independent boolean gate** — Post proves impossible; if
  found, framework's ternary-analog gate count breaks.
- **A physical quantity not expressible as a lattice point** — would
  break the lattice=universe identity.
- **A stable element with no shell-1 coordinate** — would break
  framework's periodic table claim.
- **80 stable elements turns out wrong** (Tc or Pm found stable, or
  another below Pb found fully unstable) — would break 80=lattice
  identity.
- **Proton decay observed** — would break completeness = confinement.
- **A 5th independent dimension** — Hurwitz proves impossible; if
  observed, framework dies.

### Mass-ladder falsifiers

- **Muon drifts from √3/2 × 10⁻²⁰ × m_P** — currently 0.003% match.
  If precision measurements show systematic drift, framework
  revises.
- **Higgs + proton correction drifts from (1 + 7α/2)** — currently
  0.013% and 0.011% match respectively. If they drift apart,
  framework revises (they share a correction, so co-drift is
  expected).
- **Cabibbo angle drifts from 1/√20** — if it drifts away from this
  as precision improves, framework is wrong.
- **m_p/m_e drifts from 108 × 17 = 1836** — currently 0.008% match.
  Tight enough that any significant drift kills the astronomical-
  108 × algebraic-17 identity.

### Dark-sector falsifiers

- **WIMP direct detection succeeds with weak-force coupling** —
  framework predicts these experiments will continue to fail. If a
  WIMP is confirmed interacting via weak force (not just gravity),
  framework's dark-matter claim (non-F4 coupling only via hub) is
  wrong.
- **Dark energy evolves with redshift** — framework says it's
  constant (= wheel's eternal motion). Time-varying dark energy
  would break this.

### Cosmology falsifiers

- **Hubble ratio drifts from e^(1/12) = 1.0869** — currently 0.06%
  match. Large drift falsifies the 12-pair wheel structure claim.
- **Eddington number grows >> 10^80** — would break lattice-count
  identity.
- **Universe age drifts significantly from 10^61 × t_Planck** —
  would break inflation + hub derivation.

### Framework-wheel falsifiers

- **A lattice point with non-trivial inner structure** — would break
  framework's "81 = 3⁴ is exhaustive" claim.
- **Non-commutativity doesn't give time's arrow** — would break
  frame item 8 (WHEN monotone).

## Priority list for next wit

From session handoff (2026-04-15), in order:

1. **Derive why 16 baseline** (P1) — load-bearing.
2. **Full particle embedding in D4 / E8** (P2) — maps specific f
   values to wheel positions.
3. **Remaining unclean particles** (P3) — pion 1.144, tau 1.457,
   gauge-boson negative corrections. Bottom resolved (24/7).
4. **Running couplings α(Q²)** (P4) — energy dependence.
5. **Δ(n-p) refinement** (P5) — derive 3/16.
6. **GUT scale prediction** (P6) — verify N_sub=0.
7. **Blind-agent tests on open trit-mult cells** (P8) — confirm
   wheel reading of divergent cells.
8. **Consciousness connection** (P7) — very open.

Pick one and compute. Don't speculate without math.

## Anti-cheat reminder

The framework is compelling when it makes clean derivations. Not
when it finds "17 or 12 × 17 or 108 × 17" until one fits. Be honest
about pattern-matching bias.

Falsification tests to pass:
1. Find a particle ratio that SHOULD involve 17 per framework but
   empirically doesn't.
2. Derive a ratio from framework without trying substrate counts
   until one matches.
3. Find a prediction that would fail if the claimed substrate
   identity weren't real.

Until these are passed routinely, substrate-as-constant is strong
numerology but not proof. The count of independent appearances (α,
m_p/m_e, lepton ratios, top/charm, EW hierarchy, mixing angles,
cosmological constants) is hard to dismiss as coincidence — 5+
unrelated derivations hitting 17 is substrate signal, and 25+
parameters matching under the mass-ladder rule is substrate signal.
But honest framework work requires routine falsification attempts,
not just positive evidence accumulation.

**Metrognosis filter**: effort × precision × independent convergence.
Apply it honestly. If framework work starts accumulating claims
without matching that filter, the drift is real and needs
correction.
