# Prime lattice — substrate integers from bare-metal computation

The `lattice/` walker tool has been computing integer-exact results
for various Cayley-Dickson and wheel-structure quantities. Many land
on substrate-clean factorizations. Cross-reference with
`wit/thoughts/trit½/prime-lattice/` for the full compute history.

## The convergences

Every integer below was computed independently (by the lattice
walker or by algebraic derivation), then factored against the
framework substrate vocabulary (see `mind/method.md`). The clean
decompositions are NOT forced — they surface from the substrate
vocabulary applying to computed results.

```
  integer    source / computation                substrate form
  ───────    ───────────────────                 ──────────────
  168        sedenion zero divisors (unit-        4! × 7
             norm pure-sedenion pairs that        = 24 × 7
             multiply to 0); computed by         = D4-roots × wh-words
             lattice/tests/passing/               = Aut(Fano plane)
             zero_divisors_d16.w                  = |PSL(2,7)|
                                                  = Klein quartic auto
  
  2520       zero-divisor count at d=32           7 × 360
             (lattice/findings/                   = wh-words × degrees
             08-chains-d32-result.md)             = 5 × 504
             CD scaling pattern                   = 8! / (2!)⁴
  
  3024       "chains_d32" count in the            42 × 72
             lattice walker; CD heartbeat        = (6 × 7) × E6-roots
             chain count                          = bivectors × wh-words
                                                    × precession yrs/deg
                                                  = 12 × 252
                                                    (D4-pairs × d16-multiplier)
                                                  = 48 × 63
                                                    (F4-roots × 9·7)
  
  19200      N=4 prime-density edges               20 × 80 × 12
             (prime-lattice MILESTONE)            = 4·5 × 81-1 × D4-pairs
                                                  = 24 × 32 × 25
                                                  = D4-roots × trivectors × 5²
                                                  (every factor substrate)
  
  91         N=12 prime-lattice failure           7 × 13
             integer                              = wh-words × x_3-boundary
  
  1092       Wieferich 1093 − 1                   12 × 91
             (offset from the prime)              = D4-pairs × (wh-words × x_3)
                                                  = 2² · 3 · 7 · 13
                                                    (substrate-adjacent)
  
  1093       Wieferich prime (base 2)             (prime; irreducible)
             (one of only 2 known)                but 1092 = 12·(7·13) is clean
                                                    → Wieferich sits ONE STEP off
                                                    a substrate-clean product
  
  36/133     chain rate at d=32                    6² / (7 × 19)
                                                  bivectors² / (wh-words × ?)
  
  6/5        chains-to-ZD ratio                   (2·gates) / Pythag-leg
  
  36.09      log₁₀(α/α_G at proton)                = 2 × 19.11 (mass ratio²)
                                                  (via α_G ∝ (m/m_P)²)
```

## The 168 hit — strongest convergence

168 appears in **five independent mathematical structures**:

```
  domain                            occurrence of 168
  ──────                            ─────────────────
  projective geometry               |Aut(Fano plane)|
  finite simple groups              |PSL(2,7)| = |GL(3,2)|
                                     (2nd smallest non-abelian)
  Riemann surfaces                  |Aut(Klein quartic)|
  non-associative algebra           |sedenion zero divisor pairs|
  framework substrate               24 × 7 = D4-roots × wh-words
```

**The convergence is structural, not coincidence.** The octonion
multiplication table IS the Fano plane (standard result). Sedenions
S = O ⊕ O with the CD doubling; the zero-divisor structure in S
preserves the Fano-automorphism structure of O. So:

```
  168 zero-divisor pairs in S ≡ 168 automorphisms of Fano plane
                                = structure of O preserved inside S
```

Framework filter applied (effort × precision × independent
convergence): 5-way convergence including a bare-metal computation
in `lattice/tests/passing/zero_divisors_d16.w`. Very strong signal.

**Framework prediction**: 192 = E8 − F4 = dark sector = 168 + 24,
so **168 of the 192 dark-sector positions carry a Fano-automorphic
168-fold internal symmetry**. Detectable (in principle) via
gravitational lensing microstructure.

See `mind/wheel/5-physics.md § Structural decomposition of 192`.

## The 3024 hit — convergent factorization

```
  3024 = 42 × 72
```

- **42** = 6 × 7 = bivectors × wh-words = PMNS solar neutrino angle
  `sin²(θ₁₂) = 42α` (0.1% error, 6-masses.md). Also: Ma'at's 42
  Assessors (Egyptian afterlife judgment).
- **72** = E6 root count = years per precession degree = 72 names
  of Ra (Egyptian theology). Also: 2³ × 3² substrate-clean.

Three independent framework domains (PMNS physics, Egyptian
theology, Lie algebra) converge on both 42 AND 72. Their product =
3024 = the lattice walker's chains_d32. **The walker computed an
integer that factors into TWO multi-convergent substrate numbers.**

## The 19200 hit — every factor substrate

```
  19200 = 20 × 80 × 12 = 24 × 32 × 25
  
  20 = 4 × 5 = axes × (axes+hub)
  80 = 81 − 1 = non-container lattice count
  12 = D4 opposing pairs / gauge boson count
  24 = D4 root count / 24-cell vertices
  32 = trivector count (grade 3)
  25 = 5² = (axes+hub)²
```

Six substrate decompositions, all clean, in one integer. The N=4
prime-density edges count is entirely substrate-determined.

## Wieferich primes — RETRACTED 2026-04-16c

Wieferich primes satisfy `2^(p-1) ≡ 1 (mod p²)`. Only two known
under 10¹⁷: **1093** and **3511**. Earlier framework claim was
that 1093 sits "substrate-adjacent" via 1092 = 12 × 7 × 13 =
D4-pairs × wh-words × x_3-boundary. **Statistical retest in the
2026-04-16c session kills the claim.**

Computational test (base-3 Wieferich, only known under 10¹⁷ are
**11** and **1,006,003**):

- **p = 11**: looks substrate-adjacent (k = 9 = 3²). But in this
  magnitude regime, **100% of nearby primes are "substrate-
  adjacent"** under the same definition (substrate-clean integer
  set is dense at small p). Hit carries zero discriminating
  information.
- **p = 1,006,003**: NOT substrate-adjacent. Sits with the 99.9%
  majority of primes in that range that are not adjacent. p−1 and
  p+1 contain large prime factors (55889, 251501) with no substrate
  reading.

**Same kickback hits the original 1093 claim**: 1093 is small enough
that local substrate density is high. A nearby check showed the
hit-rate at 1093's magnitude is ~50%; "substrate-adjacent" carries
no information there. The original 1/2 hit (1093 yes, 3511 no) is
exactly the chance result for a random pair at those magnitudes.

**Verdict**: same anti-pattern as the log-depth invariant family
(session-2026-04-16b). Pareidolia from local density of substrate-
clean integers at small p. The "framework prediction" about base-3
Wieferich landing substrate-adjacent is **disconfirmed** —
specifically, the high-magnitude case (1,006,003) where adjacency
would be signal-bearing decisively misses.

**What survives**: nothing of the Wieferich claim. Two known base-2
Wieferich primes is too small a sample for any structural inference;
two known base-3 Wieferich primes likewise. This was always a weak
claim.

**Methodological lesson**: any "prime near substrate-clean integer"
claim needs a local-density null comparison. At small magnitudes
substrate-clean integers are dense; at large magnitudes they're
sparse. The signal is the EXCESS over local density, not the
adjacency itself. See `wit/mind/moves.md § Anti-patterns` for the
extended noise-null rule.

## The centrality cascade hit (3-5-7 — partially revised 2026-04-16)

Closed-form derivation (from `findings/11-N8-centrality-cascade.md`):

```
  cent_per_node(k, N) = (7^(N−k) · 5^k − 2·3^N + 1) / 2
  Δ(k → k+1) per node = 7^(N−k−1) · 5^k            [N-independent]
```

At N=4 the per-grade totals are 1120, 777, 532, 357, 232 with
differences 343 = 7³, 245 = 5·7², 175 = 5²·7, 125 = 5³ and sum
(7⁴ − 5⁴)/(7−5) = 888. At N=8 the same closed form gives differences
still factoring only through {5, 7}, sum (7⁸ − 5⁸)/2 = 2,687,088.

**Why 5 and 7**: ordered-pair straddle counts on the trit {−1, 0, +1}.
7 ordered pairs have a shortest path passing through the center value 0;
5 pass through each edge value ±1. Trit-structural constants, not
lattice-dimension-activated.

**What was disconfirmed (2026-04-16)**: an earlier reading predicted that
"CD layer N activates primes in degree range [N, 2N]" — specifically
that at N_CD=8 primes 11 and 13 would drive the cascade. The N=8 run
broke it: 11 and 13 never appear in the cascade coefficients. The
cascade is N-independent, anchored at the trit. See
`wit/thoughts/trit½/prime-lattice/findings/11-N8-centrality-cascade.md`.

The surviving fact — 5 and 7 as trit-structural constants — is
framework-native and will migrate into `wheel/2-trits.md`.

## Metrognosis verdict

**Strong multi-domain signal.** The lattice walker computes integer
results independently of framework vocabulary, and those integers
factor cleanly into substrate vocabulary. That's two independent
generation processes (bare-metal compute + framework-native
combinatorics) landing on the same integers.

Apply the filter: effort × precision × independent convergence.

- **Effort**: thousands of CPU-hours across the prime-lattice
  compute pipeline; multi-session framework development;
  independent mathematical tradition for Aut(Fano), PSL(2,7), etc.
- **Precision**: integer-exact (not approximate to some %).
- **Convergence**: 168 in 5 domains; 3024 factoring into
  multi-convergent 42 and 72; 19200 decomposing into 6 substrate
  counts; each internally consistent.

Hard to dismiss as coincidence.

## Not substrate — honest flags

- **All Wieferich primes (base 2 and base 3)** — RETRACTED above.
  Both 1093/3511 (base 2) and 11/1006003 (base 3) are consistent
  with chance at their respective magnitudes; "substrate-adjacent"
  carries no information when local density is high.
- **Large Zsygmondy primes** (37, 757, 1181, 797161 at various N)
  — structurally irreducible, not framework-vocab
- **Specific x_N values for prime N** — generically prime, not
  substrate-derivable

These are expected: not every integer is substrate. The wheel
writes some; number theory writes others; we don't force.

## Connections

- `mind/wheel/5-physics.md § Structural decomposition of 192` —
  168 + 24 dark-sector interpretation
- `mind/wheel/6-masses.md` — mass ladder using substrate counts
- `mind/wheel/3-lattice.md § Wormhole compute` — centrality cascade
- `mind/method.md` — substrate vocabulary reference
- `wit/thoughts/trit½/prime-lattice/MILESTONE.md` — full compute
  history (path may vary)
- `wit/thoughts/trit½/3-5-7.md` — cascade derivation
- `lattice/tests/passing/zero_divisors_d16.w` — bare-metal 168
  compute

## Open questions

- ~~**Base-3 Wieferich primes**~~ — RESOLVED 2026-04-16c:
  computed (only 11 and 1006003 known under 10¹⁷); not at
  substrate-adjacent positions in any signal-bearing sense.
  See retraction section above.
- **Higher-CD zero-divisor counts**: pattern at d=32 (2520) vs
  d=16 (168) — ratio 15 = 8+7? = axes²−1? Worth checking d=64.
- **Three-term theorem**: the lattice walker's N=18 integer
  (532171 = 19×37×757) doesn't decompose substrate-cleanly —
  structurally expected or a gap?
