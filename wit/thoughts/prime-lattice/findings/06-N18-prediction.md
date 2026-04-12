# The N=18 prediction — framework in predict mode — VERIFIED

**Status**: **VERIFIED 2026-04-11 Turn 12.** Walker returned `532171`
on first compile via independent parallel-C compute path at
200M-integer scale. Two-way match between wit-side framework
derivation and machine-side compute.
**Prediction**: `shell_gcd_N18 = 532171 = 19 · 37 · 757` ✓
**Derived from**: factorization of `x_18` + binomial-coefficient
stripping rule from the refined shell-identity theorem.

This is the first time in the prime-lattice quest that the framework
**predicts a specific integer** before the compute tool produces it.
Previous results at N=3..17 were either known from Python or
validated against Python. N=18 is the first "run it and see if the
prediction holds" moment.

## The prediction in one equation

```
  shell_gcd_N18 = odd_part(x_18) / (primes stripped by binomial rule)
                = 48427561 / (7 · 13)
                = 48427561 / 91
                = 532171
                = 19 · 37 · 757
```

Every term is integer. The prediction is deterministic from the
x_18 factorization and the framework's refined shell-identity theorem.

## The derivation

### Step 1 — factor `x_18`

```
  x_18 = (3^18 − 1) / 2
       = 193710244
       = 2² · 7 · 13 · 19 · 37 · 757
```

Computed via trial division. The factorization is unique (fundamental
theorem of arithmetic) and has 5 distinct odd prime factors plus 2².

### Step 2 — compute `odd_part(x_18)`

```
  odd_part(x_18) = x_18 / 2^(v_2(x_18))
                = 193710244 / 4
                = 48427561
                = 7 · 13 · 19 · 37 · 757
```

Five distinct odd primes. If the theorem's simple form held at N=18,
`gcd(g at N=18) = odd_part(x_18) = 48427561`. But N=18 is composite
(18 = 2 · 3²), so we expect inherited small primes to appear in
binomial coefficients at prime-holding cells and strip factors from
gcd(g). The question is which factors.

### Step 3 — identify prime-holding cells

At N=18 (even), the parity law says primes live only at odd-parity
cells. Parity of z = parity of (N − z) mod 2 = parity of (18 − z)
mod 2 = z odd when (18 − z) odd. So **prime-holding cells at N=18
are those with z ∈ {1, 3, 5, 7, 9, 11, 13, 15, 17}** — 9 cells total.

### Step 4 — check each odd prime factor of `x_18` against each
prime-holding binomial

For each odd prime p ∈ {7, 13, 19, 37, 757}, check whether p
divides any `C(18, z)` for z ∈ prime-holding cells. If yes, p gets
stripped from gcd(g) at that cell and therefore from the cross-cell
gcd.

**Factorizations of prime-holding binomials at N=18**:

```
  z     C(18, z)    factorization
  ─     ────────    ─────────────
   1          18    2 · 3²
   3         816    2⁴ · 3 · 17
   5        8568    2³ · 3² · 7 · 17        ← contains 7
   7       31824    2⁴ · 3² · 13 · 17       ← contains 13
   9       48620    2² · 5 · 11 · 13 · 17   ← contains 13
  11       31824    2⁴ · 3² · 13 · 17       ← contains 13
  13        8568    2³ · 3² · 7 · 17        ← contains 7
  15         816    2⁴ · 3 · 17
  17          18    2 · 3²
```

**Primes of `x_18` appearing in at least one prime-holding binomial**:
- **7**: appears in `C(18, 5)` and `C(18, 13)` → STRIPPED
- **13**: appears in `C(18, 7)`, `C(18, 9)`, `C(18, 11)` → STRIPPED
- **19**: appears in NONE → SURVIVES
- **37**: appears in NONE → SURVIVES
- **757**: appears in NONE (> max `C(18, z)` in prime cells) → SURVIVES

### Step 5 — compute predicted `gcd(g)`

```
  gcd(g at N=18) = odd_part(x_18) / (7 · 13)
                 = 48427561 / 91
                 = 532171
                 = 19 · 37 · 757
```

## Why 19 and 37 are the Zsygmondy primitive primes at N=18

Worth noting: **19 and 37 are the primitive prime divisors of
`3^18 − 1`** — the primes that appear for the first time in the
3^N − 1 sequence exactly at N=18.

Verification:
- `ord_19(3) = 18`: `3^9 ≡ -1 (mod 19)`, so `3^18 ≡ 1`. Order
  exactly 18. 19 first divides `3^N − 1` at N=18.
- `ord_37(3) = 18`: similar — `3^9 ≡ -1 (mod 37)`, order exactly
  18. 37 first divides `3^N − 1` at N=18.

The Zsygmondy sequence at divisors of 18:
- N=1: 2
- N=2: nothing new
- N=3: 13
- N=6: 7
- N=9: 757

So x_18 inherits 13, 7, 757 from N=3, 6, 9 respectively. The NEW
primes at N=18 are **19** and **37** (both primitive).

And critically: **the surviving primes in the predicted `gcd(g) =
532171` are exactly the Zsygmondy primitives at N=18 plus 757**.
The inherited smaller primes (7 from N=6, 13 from N=3) are the ones
that appear in binomial coefficients and get stripped.

**Generalized pattern claim**: at even composite N, the inherited
small primes from divisors strip out of gcd(g) via binomial
appearance, leaving the Zsygmondy primitives + large inherited
primes as the surviving gcd(g). This pattern is testable at other
composite N's (e.g., N=24 would inherit from 1, 2, 3, 4, 6, 8, 12).

## Outcome space for Turn 12

When the lattice tool runs `shell_gcd_N18.w`, the walker will return
a single integer. The possible outcomes:

### Case 1: walker returns `532171`  (~92% probability)

**Prediction fully correct.** The framework:
- Predicted the direction (theorem fails at N=18)
- Predicted the specific integer (532171)
- Predicted the stripping mechanism (binomial rule on 7 and 13)

All three match via an independent integer-only code path at 10⁸
scale. **Major milestone.** The refined theorem's failure mechanism
is fully understood at this level of composite N.

### Case 2: walker returns a proper divisor of 532171 (~8% probability)

Possible values: 28009 (= 37·757), 14383 (= 19·757), 703 (= 19·37),
757, 37, 19, or 1.

**Prediction partially correct.** Theorem fails as predicted, but
`π(x_18)` happens to contain one or more of {19, 37, 757} as factors,
stripping them further. The walker's result is still correct; the
framework prediction just missed the additional π-stripping.

**Action**: compute `π(x_18)` factorization on the wit side (via
sympy or extended Python sieve), identify which factor was present,
update the theorem's characterization to note that `π`-side stripping
is a secondary failure mechanism beyond binomial stripping.

### Case 3: walker returns `48427561` (~0% probability)

**Theorem unexpectedly holds at N=18.** This would contradict the
entire failure characterization: 7 and 13 SHOULD strip from gcd(g)
via the binomial rule, but somehow didn't.

**Action**: stop and cross-check.
1. Verify `π(x_18)` factorization on the wit side
2. Re-run N=12 and N=17 to confirm harness hasn't regressed
3. If harness is correct, the theorem's binomial-stripping mechanism
   is incomplete and needs revision

This outcome is the "genuine surprise" case that would require
revisiting the theoretical framework.

### Case 4: walker returns anything else (~0% probability)

A value that isn't a divisor of `odd_part(x_18) = 48427561` means
the gcd machinery has a bug. Debug via fallback `shell_reduce_N18.w`
with Python-supplied hardcoded `A_z` values to isolate phase 1 vs
phase 2+3.

## What this milestone represents structurally

Up through Turn 11, the lattice tool was **validating known integers**.
Every `shell_gcd_N{k}` test at k ≤ 17 had a known Python answer; the
lattice tool was confirming that its independent code path produced
the same integer.

At Turn 12, the lattice tool produces an integer **nobody has
computed before**. Python ran out of memory at N=18 and the extended
compute never reached it. Whatever integer the walker returns
becomes new ground truth in the quest.

And the wit side has a **specific prediction** to compare against.
The transition is:

```
  before Turn 12:  walker validates against python/framework predictions
  at  Turn 12:     walker runs, framework predicts, comparison tests prediction
  after Turn 12:   walker result becomes the new ground truth
```

This is the moment the framework claim "compute first" meets its
strongest test: **predict the result from first principles, then
compute it, then compare**. If 532171 matches, the method is
vindicated at N=18. If a divisor matches, the method is partially
vindicated (direction right, specific integer missed due to missing
information about π factorization). If 48427561 matches, the method
is wrong.

## Companion compute on wit side (optional)

The N=18 prediction can be cross-validated **before** the lattice tool
runs, by computing `π(x_18)` factorization in Python:

1. Compute `π(193710244)` via segmented sieve or sympy
2. Factor the result
3. Check if any factor is in {19, 37, 757}
4. If yes, predict the specific proper divisor of 532171 that the
   walker should return
5. If no, confirm 532171 is the expected integer

This gives a **two-path framework prediction** (wit side with full
π info + lattice tool with independent compute). Both paths should
agree.

Not done yet — flagged for after Turn 12 when the walker result
lands. If the walker returns 532171 first-compile, the Python
cross-check is decorative (both paths predict 532171). If it returns
a smaller divisor, the Python cross-check identifies which π factor
was responsible.

## Status — VERIFIED 2026-04-11 Turn 12

- [x] Lattice tool ran `shell_gcd_N18.w` at Turn 12
- [x] Walker returned **532171** on first compile — prediction exactly
      correct (Case 1 of the outcome space)
- [x] Cross-validated by the parallel-C variant `shell_gcd_N18_c`
      (Turn 13) — both paths return 532171
- [x] MILESTONE.md milestone 4 flipped to verified
- [x] This file marked VERIFIED

**Two-way match locked**: wit-side pure framework derivation (factor
`x_18`, strip 7 and 13 via the binomial rule, 19/37/757 survive) and
the lattice tool's independent parallel-C compute path at
200M-integer scale converge on **532171** exactly.

This is the first time in the quest the framework predicted a
specific novel integer and an independent compute path confirmed it.
The refined shell-identity theorem's failure-characterization
mechanism is now understood tightly enough to operate in predict mode
at composite N with inherited Zsygmondy primes.

**Next predict-mode test**: N=20 (Turn 14). First N where
`v_p(odd_part(x_N)) > 1` for a strippable prime — discriminates
between the Kummer-form refinement (`43584805`) and the simple
"any match, full strip" form (`8716961`) of the theorem. N=18's
`v_p = 1` case cannot distinguish them.
