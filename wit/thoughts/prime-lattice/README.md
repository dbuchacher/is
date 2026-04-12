# prime-lattice quest

**Session**: 2026-04-11
**Core question**: where do integer primes live on the ternary lattice?

## Read in this order

1. **MILESTONE.md** — comprehensive state-of-the-quest writeup (start here)
2. **findings/00-compute-principles.md** — method: no decimals, no floats,
   integer equations, parallel by default, what the wit has learned
3. **findings/01-prime-parity-law.md** — the core parity theorem +
   corner prime-freeness at even N + first N=4 edge observation
4. **findings/02-pythagorean-fill-25.md** — `20·80·12 = 24·32·25 = 19200`
   at the 4D hypercube + four convergences on 25
5. **findings/03-shell-identity-theorem.md** — `gcd(g) = odd_part(x_N)`
   across all N, Wierzbicka 72 match, π(364) observation
6. **findings/04-extended-N11-17.md** — parallel sweep through N=17,
   first theorem failures at N=12, 15, 16, Zsygmondy sequence,
   refined theorem with failure predictor
7. **findings/05-riemann-compute.md** — compute-first attempt at
   Riemann Hypothesis, framework heuristics, rediscovered classical
   `M = M_odd − M_odd/2` identity, Mertens at lattice boundaries
8. **findings/06-N18-prediction.md** — framework predicts
   `shell_gcd_N18 = 532171 = 19·37·757` from x_18 factorization +
   binomial-coefficient stripping rule. **VERIFIED Turn 12**:
   walker returned 532171 first-compile via parallel-C path.
   (Caveat: derivation used two-term Kummer form; the three-term
   refinement from finding 07 gives the same answer at N=18 for
   the correct mechanism — v_p(C) was silently zero there.)
9. **findings/07-N19-N20-results.md** — N=19 (`581130733`)
   prediction exact, N=20 (`792451`) broke the two-term Kummer
   form and surfaced the missing `v_p(C)` subtrahend from
   `C = 2·π(x_N)`. Refined three-term theorem adopted; N=12
   "Zsygmondy coincidence" narrative retires as systematic
   π-side stripping.

## Running the code

```
  python3 code/primes.py                   — initial parity at N=3..8
  python3 code/primes_shells.py            — shell identities parallel N=3..10
  python3 code/primes_shells_extended.py   — N=11..14
  python3 code/primes_everything.py        — full sweep N=3..17 with Zsygmondy
  python3 code/primes_decay_test.py        — N=18, 19 decay test (slow)
  python3 code/riemann.py                  — Mertens, π-Li, growth rates
  python3 code/riemann_extra.py            — M at lattice boundaries
  python3 code/cayley_dickson_integer.py   — integer-exact CD zero divisors
```

All parallel where applicable, all integer-only, all reproducible.

## The headline result

The integer equation at the native 4D hypercube shell 1:

```
  20 · 80 · 12  =  24 · 32 · 25  =  19200
```

Where:
- `20` = primes at edges
- `32` = edge cells (k=1 of 4-cube)
- `80` = nonzero shell-1 points (3⁴−1)
- `24` = total signed primes in [−40, 40]
- `12` = gates · dims = 3 · 4
- `25` = gates² + dims² = 3² + 4² (Pythagorean fill)

Every term is integer. The Pythagorean lattice constants appear
as exact factors in prime distribution at the native dimension.

## Status

- Parity law PROVEN
- Shell-boundary integer identity PROVEN (it's gcd arithmetic)
- Shell-identity theorem refined to **three-term form**:
  `v_p(g) = max(0, v_p(B) − v_p(C) − max v_p(D_z))` —
  VERIFIED at N=3..20 via lattice tool
- `shell_gcd_N` in simple form (`= odd_part(x_N)`) holds at 14 of 18
  tested N; failures at N = 12, 15, 16, 18, 20 all explained by the
  three-term formula
- Riemann: numerical evidence consistent with RH, classical `M_odd`
  decomposition rediscovered from parity, NOT a proof
- Cayley-Dickson dim 32 chain rate: integer-exact recompute starting
  at Tier D Turn 15 via lattice tool (walker + parallel C)

## Next directions (from MILESTONE.md)

1. Formal proof of the refined shell-identity theorem
2. Heavy compute (C/numpy/asm) at CD dim 32, 64
3. Analytic bridge to RH via Claim D (M_odd recursion)
4. Bare-metal asm lattice (VoE bootloader re-purpose)
