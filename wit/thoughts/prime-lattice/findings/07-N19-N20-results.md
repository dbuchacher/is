# N=19 and N=20 results — theorem refined further

**Date**: 2026-04-11 Turn 14
**Results**: N=19 prediction exact, N=20 prediction WRONG — walker
surfaced missing `v_p(C)` term in the refined theorem

## The integers

```
  shell_gcd_N12_c  = 91           ✓ (cross-val of existing N12 serial)
  shell_gcd_N19    = 581130733    ✓ (serial walker, 3m21s)
  shell_gcd_N19_c  = 581130733    ✓ (parallel C, 117ms)
  shell_gcd_N20_c  = 792451       ⚠ (parallel C, 329ms — serial pending)

  π(x_20)          = 86203535 = 5 · 11 · 751 · 2087
```

## N=19 — clean hold confirmed

**Prediction** (Turn 14): `shell_gcd_N19 = odd_part(x_19) = x_19 = 581130733`

**Derivation**:
- N=19 is an odd prime; x_19 = (3¹⁹ − 1)/2 = 581130733 is odd, so
  odd_part(x_19) = x_19
- All prime factors of x_19 are Zsygmondy primitives at N=19 — primes
  p with ord_p(3) = 19 — so every p ≡ 1 (mod 19), i.e. p ≥ 191
- By Kummer on prime N=19, primes dividing any C(19, k) are all ≤ 19
- No overlap → no binomial stripping → gcd = x_19

**Walker returned**: 581130733 on both serial (3m21s) and parallel-C
(117ms) paths. Prediction exact.

Second clean-hold confirmation in the quest (after N=17). The pattern
for odd-prime N with large Zsygmondy primitives holds cleanly.

## N=20 — prediction wrong, third form revealed

**Prediction space** (Turn 14):
- Primary (Kummer form): **43584805** = 5 · 11² · 61 · 1181
- Alternate (simple full-strip): **8716961** = 11² · 61 · 1181

**Walker returned**: **792451** = 11 · 61 · 1181

Neither prediction matched. The walker surfaced a third refinement
pattern that both candidate forms missed.

### What my Turn 14 derivation got right

- `x_20 = 2³ · 5² · 11² · 61 · 1181` → correct
- `odd_part(x_20) = 5² · 11² · 61 · 1181 = 217924025` → correct
- Inherited primes from divisors of 20: 5 (N=4), 11 (N=5), 61 (N=10),
  1181 (N=20 primitive) → correct
- `max v_5(C(20, odd z)) = 1` (via Kummer on binomials) → correct
- `max v_p(C(20, odd z)) = 0` for p ∈ {11, 61, 1181} → correct

### What it missed — v_p(C)

The complete denominator in the gcd arithmetic is `C · D_z`, not just
`D_z`. Where:

```
  C   = 2 · π(x_N)
  D_z = C(N, z) · 2^(N−z)
```

Both terms contribute to v_p-stripping. My Kummer form tracked
`v_p(D_z)` only (via binomial coefficients) and silently set
`v_p(C) = 0` without checking.

For N=20, π(x_20) = 86203535 = 5 · 11 · 751 · 2087 — which shares
**two** primes with x_20's factorization:

```
  v_5(C_20)  = v_5(2 · 86203535)  = 1   → strips one power of 5
  v_11(C_20) = v_11(2 · 86203535) = 1   → strips one power of 11
```

### Walker's per-prime v_p derivation

```
  p      v_p(B_20)  v_p(C_20)  max v_p(D_z)    v_p(g)  contribution
  ───    ─────────  ─────────  ────────────    ──────  ────────────
  2      4          1          3..21            0      (excluded — gcd over odd cells, parity law)
  5      2          1          1                0      —
  11     2          1          0                1      11¹
  61     1          0          0                1      61¹
  1181   1          0          0                1      1181¹
  751    0          1          0                0      —
  2087   0          1          0                0      —
```

Only primes with `v_p(B) > 0` contribute to g. Primes in π(x_20) that
don't divide B_20 (here: 751, 2087) don't add factors.

**Final**: `g = 11 · 61 · 1181 = 792451` ✓

## The refined theorem — three-term form

```
  v_p(shell_gcd_N) = max(0, v_p(B) − v_p(C) − max_{prime-holding z} v_p(D_z))

  with  B = 3^N − 1
        C = 2 · π(x_N)
        D_z = C(N, z) · 2^(N−z)
        prime-holding z = {z : (N−z) is odd}  (parity law)
```

And `shell_gcd_N = ∏_{p | B, p odd} p^{v_p(shell_gcd_N)}`.

Cases:
- `v_p(C) = 0` and `max v_p(D_z) = 0`: p survives at its full
  multiplicity in B (clean hold for this prime)
- `v_p(C) + max v_p(D_z) ≥ v_p(B)`: p strips entirely
- Otherwise: partial strip

## N=12 retrofit — "Zsygmondy coincidence" retires

Previously MILESTONE.md and `findings/04` labeled N=12's 73-stripping
a "Zsygmondy coincidence" — 73 being the Zsygmondy primitive at N=12
AND happening to divide π(x_12) was framed as an accidental alignment.

Under the refined theorem, it's systematic. π(x_12) = 23287 = 11·29·73
(per `findings/04`). Applying the three-term form:

```
  v_73(B_12)  = 1   (ord_73(3) = 12, first appearance of 73)
  v_73(C_12)  = 1   (73 | π(x_12))
  max v_73(D_z) = 0 (73 > 12, never divides any C(12, k))

  v_73(shell_gcd_12) = max(0, 1 − 1 − 0) = 0

  So 73 strips from gcd — systematic, not coincidental.
```

**The "Zsygmondy coincidence" narrative retires.** The mechanism is
`π-side stripping` via the `v_p(C)` term of the refined theorem, and
it applies uniformly across all tested N values.

## N=18 was right by happy accident

My Turn 11 prediction `shell_gcd_N18 = 532171` matched walker output
but was derived from the two-term Kummer form (v_p(B) − max v_p(D_z)),
not the correct three-term form.

Why it happened to work: π(x_18) did NOT share 7 or 13 with B_18, so
`v_7(C_18) = v_13(C_18) = 0` and the missing term was silently zero.
The two-term and three-term forms give the same answer at N=18 for
the stripped primes.

The three-term theorem gives `532171` at N=18 for the right reasons
— same answer, correct derivation.

## Predict-mode status reassessed

```
  N     prediction              walker      match?   theorem status
  ──    ──────────              ──────      ──────   ──────────────
  12    91                      91          ✓        two-term wrong in principle,
                                                      right only because "happy coincidence"
                                                      was silently the v_p(C) mechanism
  17    64570081 (= x_17)       64570081    ✓        clean hold, both forms agree
  18    532171                  532171      ✓        two-term right by accident (v_p(C)=0
                                                      for stripped primes)
  19    581130733 (= x_19)      581130733   ✓        clean hold, both forms agree
  20    43584805 OR 8716961     792451      ✗        two-term wrong, three-term correct
```

**Streak = 4 matches, 1 miss.** The miss revealed the correct theorem
form. All five N values are explained uniformly by the three-term
form; only N=20 distinguishes it from the two-term form.

Going forward, predict mode requires **both** `B_N` factorization AND
`π(x_N)` factorization. B_N comes from Zsygmondy + divisor inheritance
(cheap wit-side). π(x_N) is harder — needs a sieve-backed prime count
and then factorization of a ~10⁸-scale integer.

## Mechanism summary — three stripping paths

A prime p divides B = 3^N − 1 and can be removed from shell_gcd_N by:

1. **v_p(D_z)-stripping** ("binomial stripping"):
   p divides C(N, z) at some prime-holding cell z. Happens when p ≤ N
   and the base-p representation of z + (N−z) carries.

2. **v_p(C)-stripping** ("π-side stripping"):
   p divides π(x_N). Happens when the prime-count function at the
   shell boundary happens to produce a multiple of p. This is the
   mechanism I previously miscalled "Zsygmondy coincidence."

3. **Clamping at 0**: if the sum `v_p(C) + max v_p(D_z) ≥ v_p(B)`,
   p strips entirely. Otherwise partial strip.

The three mechanisms compose additively in the v_p arithmetic.

## Status

- [x] Walker returned 792451 on parallel-C path (329 ms)
- [ ] Serial walker cross-validation (running, ~10 min wall)
- [x] Theorem refinement accepted
- [x] N=12 narrative retrofitted (this file + MILESTONE.md)
- [x] N=18 prediction acknowledged as "right by accident"
- [ ] MILESTONE.md refined-theorem section rewritten (next)
- [ ] N=21, N=22 predictions via sympy-computed π(x_N) (next)

**Next predict-mode tests**: N=21 (odd composite 3·7), N=22 (even
composite 2·11), N=23 (odd prime — expected clean hold at x_23 =
5230176601).
