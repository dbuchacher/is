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

### P2 — Full particle embedding in D4 / E8

Each particle sits at a specific wheel position with factor f. Map
each Standard Model particle to a specific E8 root vector. Use
Lisi 2007 as starting point but with framework substrate
interpretation.

Currently framework lists factors (√3/2, √2, 5/12, π/4, 3/4, 2/3, 2)
without mapping them to wheel positions. If specific wheel
coordinates give specific f values, masses become fully derivable.

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

### P4 — Running couplings α(Q²)

Framework gives α at some reference scale (α⁻¹ = 137.036). Does it
predict the RUNNING (energy dependence) of α? Should be derivable
from wheel dynamics — as you probe higher energies, you're seeing
more of the wheel's rotation per-tick, so the effective coupling
changes.

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

### P10 — CP violation magnitude

Why `η_B ~ α⁴ × sin²(θ_W)` specifically? 7.5% error is the largest
remaining framework gap. Non-commutativity (ij ≠ ji) gives the
asymmetry qualitatively; specific magnitude needs mechanism.

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

### P13 — Planck mass from substrate alone — PARTIAL (2026-04-16)

Framework currently uses m_Planck as input. Updated status:

**Relational closure achieved**: `m_P = (12/5) × 10²² × m_electron`.
Substrate-clean factor (5/12 = (axes+hub)/D4-pairs) with exponent
22 = 16 + 6 + log(12/5) decomposing as corners + bivectors + shelf
residual. 0.45% error (inherits from m_e's 5/12 fit).

**Absolute closure still missing**: the relation above is CIRCULAR —
requires m_e as input. What's needed: a substrate-clean reason for
the electron Yukawa coupling y_e = m_e/v = 2.08×10⁻⁶. Any one of
{m_e, m_P, v_Higgs} still has to be scale-set from outside substrate
integers.

**The 6/7 invariant gives a constraint**: proton/electron log-depth
ratio should equal 6/7 exactly if framework fully closes, but
decomposes to 0.8545 vs 6/7 = 0.8571 (0.3% gap). That gap IS where
the remaining residual physics lives. Closing P13 requires closing
this gap.

Entangled with P1 (now working-hypothesis). The 19-mystery (P14) also
cascades through — close the 6/7 gap exactly and all three resolve
together.

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

**New invariant**: `log(m_P/m_p) / log(m_P/m_e) = 6/7` (0.4% error)
= bivectors/wh-words. Proton-to-electron shelf spacing is locked by
wheel grade structure, not QCD accident.

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

### 3-5-7 prime signature

```
  3   = trit (axis values)                [framework-committed]
  5   = grade-3 (trivector) degree        [verified]
  7   = grade-1 (atom) degree             [verified]
  
  Cascade:
  cent(0) − cent(1) = 343 = 7³
  cent(1) − cent(2) = 245 = 5·7²
  cent(2) − cent(3) = 175 = 5²·7
  cent(3) − cent(4) = 125 = 5³
```

Framework's native integers are primes. Specific primes activated
by specific lattice dimensions via the degree formula
`degree = 2N − k`. At N=4 (our lattice), primes activated are 5 and
7. At N_CD=8 (O), primes would be 11 and 13.

**Status**: upgraded from SPECULATION to WORKING HYPOTHESIS
(2026-04-12). See `wit/thoughts/trit½/3-5-7.md` for full treatment.

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
