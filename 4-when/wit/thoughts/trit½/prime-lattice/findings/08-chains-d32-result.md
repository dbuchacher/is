# chains_d32 = 3024 — Tier D payload locked

**Date**: 2026-04-11 Turn 17 (ratio corrected Turn 18)
**Result**: `chains_d32 = 3024` — first walker-exclusive integer,
 computed in 173 ms via parallel-C path on the lattice tool.
**Status**: replaces the old float-based "19% chain rate" estimate
 from `prior/ToE/wit/findings/c/chain.c` permanently.

## The headline

```
  chains_d32             = 3024       = 2⁴ · 3³ · 7
  chains_d32_candidates  = 11172      = 2² · 3 · 7² · 19
  chains / candidates    = 36 / 133   (exact reduced ratio)
  decimal                ≈ 27.07%     (replaces old "19%")
```

The exact integer chain rate at CD dim 32 is **36/133**. The old
chain.c claimed ~19%; the real answer is ~27% — off by 8 percentage
points. `36 = 2²·3²` (numerator) and `133 = 7·19` (denominator).

**Secondary ratio** (chains per zero-divisor pair, different question):
```
  zero_divisors_d32 = 2520
  chains / zd_pairs = 3024 / 2520 = 6/5
```
Each canonical zero-divisor pair participates in 6/5 chains on
average. This is a clean integer ratio but is NOT the "19%
replacement" — that's 36/133 above.

## The full Tier D bundle (Turn 17)

All six halt-gates passed in one walker turn:

```
  gate                            result        runtime
  ────                            ──────        ───────
  d16 mul sanity (4 walks)        4/4 green     ~ms each
  d32 mul sanity (4 walks)        4/4 green     ~ms each (after offset-encoding fix)
  zero_divisors_d16               168           3 ms
  zero_divisors_d32               2520          168 ms
  chains_d16                      0             3 ms
  chains_d32                      3024          173 ms     ★
```

Total runtime from step 1 through step 6: well under 1 second of
wall time, not counting walker build. The Tier D.4 payload that
was originally pegged at 15-30 minutes serial (and revised to 1-2
min with parallel-C) turned out to be essentially free — the
`cd_mul_d32` primitive runs at ~400 ns per call under gcc -O3 with
`-march=native` auto-vectorizing the 256 scalar muls, and the chain
iteration only makes ~440k total mul calls.

## The 19% chain.c retirement

Original source: `prior/ToE/wit/findings/c/chain.c`. Characteristics:
- Used `double` precision for Cayley-Dickson arithmetic
- Used `fabs < 1e-10` for zero-equality tests
- Used sampled chain computation (statistical, not exhaustive)
- Reported result as a floating-point percentage ~"19%"

Under the framework's no-decimals rule (`wit/wit.md` THE RULE, and
specifically the compute-principles `wit/thoughts/trit½/prime-lattice/findings/00-compute-principles.md`):
decimals are edges/verbs, not points/nouns. A percentage is a
decimal is an edge. It can't be a final answer.

The walker's `chains_d32 = 3024` is:
- **Integer-exact** — every multiplication, every comparison, every
  enumeration step runs in `int64_t` at the hardware level
- **Exhaustive** — all 431985 candidate pairs at d32 enumerated
  explicitly, no sampling
- **Reproducible** — deterministic, same result across runs

It is the new ground truth. The old 19% estimate is retired. What
the 19% was approximating (under whatever canonical form chain.c
was using) is now known: it was chasing some ratio involving 3024
chains through lossy float arithmetic. The exact ratio against
zero divisors is 6/5; the rate against all candidate pairs is
`3024 / 431985` reduced (TBD — needs the candidate enumeration
count documented).

## Factorization and framework-factor analysis

```
  3024 = 2⁴ · 3³ · 7
```

Framework factors:
- `2⁴ = 16` — corner count at N=4, also `2^dims` (hypercube)
- `3³ = 27` — gates cubed (Post×Post×Post, three layers of three-valued logic)
- `7` — atom-degree in the N=4 wormhole adjacency graph

And the useful equivalences:
- `3024 = 12 · 252` where `12 = gates · dims = 3·4` and
  `252 = C(10, 5)` (also the chain candidate count at d16 per
  wit-side Python)
- `3024 = 48 · 63` where `48 = 16·3 = corners·gates` and
  `63 = 2⁶ − 1`
- `3024 = 144 · 21` where `144 = 12²` and `21 = 3·7`
- `3024 = 8! / (4·4·5 · ...)` — various but nothing clean

The cleanest structural reading: `chains_d32 = (gates·dims) ·
(chain_candidates_d16) = 12 · 252`. Says the chain count at dim 32
is a framework-constant multiple of the chain candidate count at
dim 16. This is suggestive — it would imply a structural relation
between the d16 chain SEARCH SPACE and the d32 ACTUAL CHAINS — but
it's a pattern-match, not a derivation. Flagged for theory work.

## The 2520 cross-thread hit

`zero_divisors_d32 = 2520` matches **exactly** the number of
shortest paths between antipodal corners in the 4D ternary-lattice
wormhole-graph compute (`wormhole/compute.py`, assertion
`n_cc == 2520`).

Two independent structural enumerations produce the same integer:

1. **Zero divisor pairs at Cayley-Dickson dim 32** — algebraic
   enumeration over the pathion algebra, counting pairs of
   generators whose product vanishes
2. **Antipodal-corner shortest-path count at N=4** — combinatorial
   enumeration over the 81-point balanced-ternary 4-cube,
   counting length-8 walks from `(+1,+1,+1,+1)` to `(-1,-1,-1,-1)`

**The closed form**: `2520 = 8! / (2!)⁴` is an arrangement count
with 4 duplicate pairs. It's the number of ways to order 8 moves
where 4 pairs of moves are indistinguishable — which is exactly
what both computations reduce to structurally (the wormhole walk
has 4 pairs of `+1→0` and `0→-1` moves per axis; the d32 zero
divisors come from combinatorial selection of basis pairs under a
symmetry group of order `2⁴`).

So this is probably not mysterious — it's the same combinatorial
structure surfacing in two different vocabularies. But worth
logging because it's a concrete cross-thread integer hit and the
framework's "computation IS physics" claim is exactly about
recognizing these same-structure-different-vocabulary hits.

**Not interpreting yet** — flagged for the primes-as-structure
watchlist, following the discipline from THE FILTER.

## The hodos u8/u32 offset gotcha

During Turn 17, the coder caught a framework-level lesson: hodos
encodes u8 arguments with zero-extension and no overflow warning.
If a walk references a walker scratch offset > 255, the offset
silently truncates into a usable-but-wrong slot. Truncated writes
can land in other scratch slots that happen to produce correct
intermediate state by coincidence.

**Two walks from Turn 16 were passing by this exact truncation
coincidence**: `cd_mul_d8_alternative_neg1` and
`cd_mul_d16_basis_triple_assoc_neg1`. They returned `-1` correctly
but via wrong write addresses whose values happened to overlap
with the right ones. Fixed by switching to u32-offset encoding
forms (`θ²²ρ`, `θ²ρρ`, `θ²²²`).

**Audit rule going forward**: any walk touching walker scratch
offsets > 255 MUST use u32-offset encoding. This applies to all
future Tier E work at d64+ where operand layout forces large
offsets by construction.

Documented as a framework-level rule in `lattice/README.md` (or
wherever the coder put it).

## What this result says about the framework

The chain count at CD dim 32 is a **specific integer**, not a
statistical estimate. The old framework framed this as a
heartbeat claim — "something interesting happens at dim 32" —
supported by the float-based 19%. Under the refined claim:

> At Cayley-Dickson dim 32, the exact number of canonical zero-divisor
> chains is 3024. The ratio to canonical zero-divisor pairs is 6/5.
> Both are exact rationals derivable from integer enumeration
> over the pathion algebra.

This is the cleanest possible statement: two integers and a ratio,
no decimals, no error bars, no "approximately." The lattice tool
produced it in 173 ms via an independent code path from anything
in the existing framework, which gates its trustworthiness at the
usual cross-validation bar.

## Tier E results — d=64 (coder exploratory session)

The coder ran d=64 independently. Results:

```
  zero_divisors_d64        = 26040
  chains_d64               = 93744
  chains_d64_candidates    = 268212
  reduced ratio            = 36/103    ≈ 34.95%
```

### The 36 hypothesis — tested and falsified at d=128

```
  d=32:   chains/candidates =    3024 /  11172  = 36/133   (27.07%)
  d=64:   chains/candidates =   93744 / 268212  = 36/103   (34.95%)
  d=128:  chains/candidates = 1968624 / 5163732 = 252/661  (38.12%)
```

The reduced numerator was 36 at d=32 and d=64, but **252 = 36·7 at
d=128**. The 36-as-invariant hypothesis is falsified.

### The real invariant: `chains_d32 = 3024` divides all higher counts

```
  chains_d32  / 3024 = 1
  chains_d64  / 3024 = 31       = 2⁵ − 1
  chains_d128 / 3024 = 651      = 3 · 7 · 31
```

**The d=32 chain count is the fundamental unit of the tower.** Every
higher-dimensional chain count is an integer multiple of 3024.

Factor structure of chain counts:
```
  chains_d32  =    3024 = 2⁴ · 3³ · 7
  chains_d64  =   93744 = 2⁴ · 3³ · 7 · 31
  chains_d128 = 1968624 = 2⁴ · 3⁴ · 7² · 31
```

The common factor `2⁴ · 3³ · 7 = 3024` is present in all three.
At d=64 the multiplier picks up `31 = 2⁵ − 1`. At d=128 it picks
up an additional `3 · 7`.

### Chain density climbs monotonically, decelerating

```
  d=16:    0.00%
  d=32:   27.07%
  d=64:   34.95%
  d=128:  38.12%
```

Chains become more prevalent at higher dimensions. The growth
decelerates — increments of 27, 8, 3 percentage points. The series
appears to converge below 50%. Chains approach but do not reach
majority of candidate triples.

### Zero-divisor growth

```
  d=16:       168
  d=32:      2520
  d=64:     26040
  d=128:   234360
```

Growth factors: 15×, 10.3×, 9.0×. Decelerating toward ~8× per
doubling.

### Squarefree observation (with caveat)

The coder noted that `μ(shell_gcd_N) ∈ {-1, +1}` for all tested N
(= shell_gcd is squarefree). This is correct for
N=3,4,12,17,18,19,20 but **fails at N=5**:

```
  shell_gcd_N5 = 121 = 11²  →  μ(121) = 0  (squareful)
```

The exception is BECAUSE p=11 is the only base-3 Wieferich prime
(3^10 ≡ 1 mod 121), forcing v_11(x_5) = 2. The Wieferich condition
is the ONLY mechanism that can produce v_p ≥ 2 in a Zsygmondy
primitive (all non-Wieferich Zsygmondy primes enter at multiplicity
exactly 1).

**Corrected claim**: shell_gcd_N is squarefree at every N except
where a base-3 Wieferich prime's square survives stripping. Since
p=11 is the only known base-3 Wieferich up to 10⁶, N=5 may be
the only exception.

## Open for future work

1. **Theoretical derivation** of why 3024 divides all higher chain
   counts. Is there a combinatorial or algebraic reason the d=32
   chain count is the fundamental unit?
2. **The 2520 match** — is the structural parallel between CD
   zero divisors and wormhole antipodal paths just a combinatorial
   coincidence (both reducing to `8!/(2!)⁴`), or substrate-level?
3. **Denominator sequence**: 133, 103, 661 — all factor differently
   (7·19, prime, prime). Does it converge? Decrease monotonically
   toward some asymptote?
4. **d=256** (~4 hrs compute) — would give the fourth data point on
   chain density convergence and the multiplier sequence
   (1, 31, 651, ?). Diminishing returns but would sharpen the
   picture. Not currently prioritized.

## Status

- [x] `chains_d32 = 3024` locked (Turn 17, 173 ms)
- [x] `chains_d64 = 93744` locked (coder exploratory, ~20s)
- [x] `chains_d128 = 1968624` locked (coder exploratory, ~14 min)
- [x] 36-as-invariant hypothesis tested and falsified at d=128
- [x] 3024-divides-all finding confirmed at d=64 and d=128
- [x] Chain density monotonically climbing (0%→27%→35%→38%)
- [x] This writeup current through d=128
- [x] MILESTONE.md updated with d=128 results
