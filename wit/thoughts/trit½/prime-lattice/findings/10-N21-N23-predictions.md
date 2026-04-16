# N=21, N=22, N=23 predictions — three-term theorem in predict mode

**Date**: 2026-04-11
**Status**: predictions derived, awaiting walker verification (Tier F,
blocked on segmented sieve integration)
**Tool**: `code/pi_count.c` — standalone C segmented Eratosthenes,
compiled with `gcc -O3`, computes π(x_N) and factorizations in seconds
up to x ∼ 10^11.

## The factorizations

```
  N   x_N              factorization of x_N           π(x_N)         π factorization
  ──  ───              ────────────────────           ──────         ─────────────────
  21  5,230,176,601    13 · 1093 · 368089            245,251,126    2 · 19² · 131 · 2593
  22  15,690,529,804   2² · 23 · 67 · 661 · 3851    699,624,470    2 · 5 · 69962447
  23  47,071,589,413   47 · 1001523179               2,000,640,686  2 · 11 · 90938213
```

## The predictions

### N=21 — odd composite (3·7), 13 strips

Divisors of 21: 1, 3, 7, 21. Inherited Zsygmondy primes:
- **13** from N=3 (ord_13(3) = 3)
- **1093** from N=7 (ord_1093(3) = 7, base-2 Wieferich)
- **368089** = Φ_21(3), primitive at N=21

Apply three-term theorem `v_p(g) = max(0, v_p(B) − v_p(C) − max v_p(D_z))`:

```
  p        v_p(B)  v_p(C)  max v_p(D_z)   v_p(g)   status
  ──       ──────  ──────  ────────────   ──────   ──────
  13       1       0       1 (z=10,12)    0        STRIPS (binomial)
  1093     1       0       0 (> 21)       1        survives
  368089   1       0       0 (>> 21)      1        survives
```

Kummer check for 13 at N=21: `v_13(C(21,10))` — in base 13,
10 + 11 = "A" + "B" = 21 = 1·13 + 8 = "18", one carry → v_13 = 1.
Similarly `v_13(C(21,12))`: 12 + 9 = "C" + "9" = 21, one carry.

π-side check: 13 ∤ π(x_21) = 245251126 (verified: 245251126/13 ≈
18865471.2, not integer). So v_13(C) = 0 — all stripping is
binomial-side.

**Prediction**: `shell_gcd_N21 = 1093 · 368089 = 402321277`

### N=22 — even composite (2·11), CLEAN HOLD

Divisors of 22: 1, 2, 11, 22. Inherited Zsygmondy primes:
- **23** from N=11 (ord_23(3) = 11)
- **3851** from N=11 (ord_3851(3) = 11)
- **67** from N=22 (Φ_22(3) = 67 · 661)
- **661** from N=22

All four odd primes in x_22 are **> 22**. By Kummer on C(22, z)
with p > 22, every z and 22−z are single digits in base p and
their sum 22 < p never carries → max v_p(D_z) = 0 for all four.

π-side check: π(x_22) = 699624470 = 2 · 5 · 69962447. None of
{23, 67, 661, 3851} divide 69962447 (verified by trial division
in the C tool). So v_p(C) = 0 for all four.

**Three-term formula**: v_p(g) = max(0, 1 − 0 − 0) = 1 for each p.
All survive at full multiplicity.

**Prediction**: `shell_gcd_N22 = 23 · 67 · 661 · 3851 = 3922632451`
(= odd_part(x_22), simple form holds)

**Why this holds despite N=22 being composite**: the heuristic
"composite N with small divisors tends to fail" doesn't apply when
the inherited primes are large. 23 and 3851 come from N=11, and both
are > 22. A composite N fails via binomial stripping only when an
inherited prime p is small enough that p ≤ N (so it can appear in
C(N, z)). At N=22, the smallest inherited odd prime is 23 > 22.
Just barely above the threshold.

### N=23 — odd prime, clean hold

N=23 is prime. All factors of x_23 are Zsygmondy primitives at N=23
(ord_p(3) = 23), so every p ≡ 1 (mod 23), i.e., p ≥ 47.

```
  x_23 = 47 · 1001523179
  47 mod 23 = 1 ✓
  1001523179 mod 23 = 1 ✓
```

Binomial: all primes > 23, no stripping possible.
π-side: π(x_23) = 2 · 11 · 90938213. Neither 47 nor 1001523179
divides this.

**Prediction**: `shell_gcd_N23 = 47 · 1001523179 = 47071589413`
(= x_23, simple form holds, cleanest case)

## Summary

```
  N    prediction        form              stripping mechanism
  ──   ──────────        ────              ───────────────────
  21   402321277         theorem fails     13 via binomial at z=10, z=12
  22   3922632451        simple holds      none (all primes > 22)
  23   47071589413       simple holds      none (all primes > 23, prime N)
```

**The three-term theorem is now in predict mode for three new N
values.** All predictions derived from x_N factorization + π(x_N)
factorization + Kummer's theorem on binomials. Machine verification
awaits Tier F sieve integration in the lattice tool.

## Notes

- N=21's `1093 · 368089` product contains the Wieferich prime from
  the base-3/base-2 cross-link (finding 09). shell_gcd_N21 has 1093
  as a factor because it survives stripping — 1093 is too large for
  binomials and doesn't divide π(x_21).
- N=22's clean hold is a surprise prediction — the heuristic
  ("composite fails") would suggest otherwise. The key is that 23
  is JUST above the binomial threshold (23 > 22). At N=24 = 2³·3,
  the inherited prime 13 (from N=3) is below the threshold (13 < 24),
  so N=24 should fail via 13 stripping. Testable.
- N=23's x_23 = 47 · 1001523179 has only two prime factors. If
  1001523179 is prime (trial division up to √ ≈ 31647 found no
  factor), then x_23 is a semiprime like x_7 = 1093 (one factor).
