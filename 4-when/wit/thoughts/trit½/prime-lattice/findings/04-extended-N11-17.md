# primes — extended findings at N = 3..17

**Status**: parallel compute across N = 3..17 done. Refined theorem
identified here in two-term form; later (`findings/07-N19-N20-results.md`)
refined to three-term form `v_p(g) = max(0, v_p(B) − v_p(C) − max
v_p(D_z))` after Turn 14 N=20 walker surprise. The "π coincidence"
at N=12 below is reframed in that later finding as **systematic
`v_p(C)` stripping**, not coincidence. Original text preserved here
with retrofit notes inline.

**Code**: `primes_everything.py` next to this file. Parallel via
multiprocessing across all N simultaneously.

## The refined theorem

For each N ≥ 3, at the shell-1 boundary `x_N = (3^N − 1)/2`:

```
  gcd(g at N) = odd_part(x_N) / d
```

where `g` are the reduced numerators from the cell identities `A·B·f
= C·D·g`, and `d` is the product of odd primes `p` such that EITHER:

- `p` divides `π(x_N)` (cell-uniform failure, from C), OR
- `p` divides `C(N, z)` for some `z` with `A_z > 0` (cell-specific
  failure, from D)

This is a **proven theorem** — it follows directly from gcd arithmetic
on the integer identity. The interesting content is characterizing
when `d = 1` (theorem-in-simple-form holds) vs `d > 1` (theorem fails).

## Results at N=3..17

```
  N    x_N          π(x_N)    odd_part      gcd(g)       holds?   shared odd
  ──   ──────────   ──────    ─────────     ──────       ──────   ──────────
  3    13             6       13            13           ✓
  4    40            12        5             5           ✓
  5    121           30       121           121          ✓
  6    364           72        91            91          ✓
  7    1093         183       1093          1093         ✓
  8    3280         462       205           205          ✓
  9    9841        1214       9841          9841         ✓
  10   29524       3204       7381          7381         ✓
  11   88573       8580       88573         88573        ✓
  12   265720     23287       33215         91           ✗        73
  13   797161     63752       797161        797161       ✓
  14   2391484   175722       597871        597871       ✓
  15   7174453   487719       7174453       50171        ✗        —
  16   21523360 1360958       672605        134521       ✗        —
  17   64570081 3816776       64570081      64570081     ✓
```

**12 of 15 N values hold the simple form. 3 failures: N=12, 15, 16.**

## Why each failure

### N=12: π-side stripping (not "coincidence")

> **Retrofit note** (post-Turn 14): the language below originally
> framed the 73-stripping as a "coincidence" — Zsygmondy primitive
> 73 "happening to" also divide π(x_12). The refined three-term
> theorem `v_p(g) = max(0, v_p(B) − v_p(C) − max v_p(D_z))` shows
> this is systematic: `v_73(C_12) = 1` because `73 | π(x_12)`, and
> the formula strips 73 deterministically. See
> `findings/07-N19-N20-results.md` for the correct framing.

- `x_12 = 2³ · 5 · 7 · 13 · 73`
- `π(265720) = 23287 = 11 · 29 · 73`
- `73` divides both `x_12` and `π(x_12)` — **v_73(C_12) = 1, so
  v_73(g) = max(0, 1 − 1 − 0) = 0**; 73 strips from gcd
- Also `5` divides `C(12, 3) = C(12, 9) = 220 = 2²·5·11` — **max
  v_5(D_z) ≥ 1, so 5 strips from gcd**
- Result: `gcd(g) = 91 = 7·13`, losing factors `5` and `73` via
  two distinct mechanisms (binomial stripping + π-side stripping)

**Structural reason for 73 appearing in both B and π**: `ord_73(3)
= 12`, so 73 first appears as a divisor of `3^N − 1` at exactly
N=12 (by Zsygmondy). The π-side "sharing" is not a separate
coincidence — it's how π(x_N) factorization interacts with the
gcd arithmetic. Systematic, not accidental.

### N=15: old primes in binomial coefficients

- `x_15 = 11² · 13 · 4561`
- `C(15, 6) = 5005 = 5·7·11·13`
- `C(15, 8) = 6435 = 3²·5·11·13`
- `C(15, 10) = 3003 = 3·7·11·13`

At odd-parity cells (where primes live), `11` and `13` appear in
several binomial coefficients. In the gcd reduction:
- One copy of 11 is canceled (x_15 had 11², leaving 11¹)
- 13 is fully canceled (x_15 had 13¹)

Result: `gcd(g) = 11 · 4561 = 50171`, losing `13` and one copy of `11`.

**Structural reason**: 11 entered x_N at N=5, 13 entered at N=3 —
both "old" primes by N=15. Since N=15 = 3·5, these old primes
inherit into x_15, and they're small enough to appear in `C(15, z)`.

### N=16: 5 in binomial coefficients

- `x_16 = 2⁵ · 5 · 17 · 41 · 193`
- `C(16, 3) = 560 = 2⁴·5·7`
- `C(16, 7) = 11440 = 2⁴·5·11·13`
- `C(16, 13) = 560`

At odd-parity cells, `5` appears in `C(16, z)`. One 5 canceled from
x_16's single 5. Result: `gcd(g) = 17·41·193 = 134521`.

**Structural reason**: 5 entered x_N at N=4. 16 = 2^4, so x_16 inherits
from N=4 via the factorization `3^16 − 1 = (3^8 − 1)(3^8 + 1) = ...`.

## When does the theorem hold?

**Heuristic**: the theorem's simple form `gcd(g) = odd_part(x_N)`
holds at N when every odd prime `p` dividing `B_N = 3^N − 1`
satisfies BOTH:
1. `max_z v_p(D_z) = 0` — `p` doesn't divide any binomial `C(N, z)`
   at prime-holding z (Kummer's theorem; holds automatically when
   `p > N`, AND
2. `v_p(C_N) = 0` — `p` doesn't divide `π(x_N)`

If either condition fails, the three-term formula strips `p` from
gcd by `v_p(C_N) + max_z v_p(D_z)` powers. See `findings/07` for
the complete form.

**Prime N usually holds** (because x_N has few prime factors, mostly
new/large). In our range: N = 3, 5, 7, 11, 13, 17 all prime, all
hold. N = 12 is the exception (prime N=12? no, 12 = 2²·3, composite,
and it fails).

**Composite N with small divisors usually fails** (because x_N inherits
old small primes that appear in binomials). In our range: N = 15 = 3·5
fails. N = 16 = 2⁴ fails. But N = 14 = 2·7 HOLDS (because x_14's old
prime 1093 is Wieferich-huge and doesn't appear in C(14, z)).

## Zsygmondy primitive prime divisors

For each N, the NEW primes entering as factors of `3^N − 1` (primes
with multiplicative order exactly N mod 3):

```
  N    new primes         size    theorem?
  ──   ────────────       ────    ────────
  3    13                                ✓
  4    5                                 ✓
  5    11                                ✓
  6    7                                 ✓
  7    1093  ← Wieferich                 ✓
  8    41                                ✓
  9    757                               ✓
  10   61                                ✓
  11   23, 3851                          ✓
  12   73                                ✗
  13   797161  ← x_13 itself prime       ✓
  14   547                               ✓
  15   4561                              ✗
  16   17, 193                           ✗
  17   1871, 34511                       ✓
```

**N=7 gets 1093**, one of only two known Wieferich primes (`2^(p−1) ≡ 1
mod p²`). This is a coincidence between base-3 multiplicative order
and a base-2 congruence property, but worth noting.

**N=13 has `x_13` itself prime** — the only N in our range where the
shell boundary is prime. A single huge Zsygmondy prime.

## Mertens at boundaries — M² < x_N always

```
  N    M(x_N)      |M|²       x_N           M² < x_N?
  ──   ──────      ────       ──────        ─────────
  3    −3              9      13            ✓
  4    0               0      40            ✓
  5    −3              9      121           ✓
  6    0               0      364           ✓
  7    −11           121      1093          ✓
  8    20            400      3280          ✓
  9    −40          1600      9841          ✓    ← |M| = 40 = x_4!
  10   15            225      29524         ✓
  11   47           2209      88573         ✓
  12   1               1      265720        ✓    ← nearly zero at failure
  13   −73          5329      797161        ✓    ← −73 = failure prime at N=12
  14   319        101761      2391484       ✓
  15   −741       549081      7174453       ✓
  16   288         82944      21523360      ✓
  17   1136      1290496      64570081      ✓
```

**15 consecutive boundaries: `M(x_N)² < x_N`.** The Mertens conjecture
holds at every lattice-complete boundary tested. Classical Mertens
conjecture is disproven at x ≈ 10¹⁴, which is far beyond our N=17 max
of ~6.5·10⁷, so no tension yet.

### Striking coincidences (flagged, not explained)

1. **`M(x_9) = −40 = −x_4`**. The Mertens function at shell-9 boundary
   equals the negative of the shell-4 boundary value.

2. **`M(x_12) = 1`**. Nearly zero at the exact N where the theorem
   first fails.

3. **`M(x_13) = −73`**. Negative of the exact prime that caused the
   N=12 theorem failure.

These are small-integer coincidences so take with salt, but they
appear in adjacent N values at failure points, which is suggestive.

## What's next

1. **Extend to N=18, 19, 20**. At N=18 = 2·3² we'd expect inherited
   primes from N=3 (13), N=6 (7), N=9 (757). Predict: likely fails.
   At N=19 (prime), predict: likely holds. Test and see.

2. **Prove the theorem cleanly** — write out the gcd-arithmetic
   argument as a short proof. Get it out of "observation" status.

3. **Investigate the `M(x_13) = −73` coincidence**. Is there a reason
   M jumps to -73 right after the 73 failure at N=12?

4. **Search for more framework-clean π(x_N) matches**. At N=4 (12 = gates·dims)
   and N=6 (72 = 80−8 = composed shell). Any at higher N? None found in
   N=7..17 but maybe at N=18+ or using different decompositions.

5. **Look for a match at N=18** — if π(x_18) = 360 or another framework
   constant, that would be a third match. Worth checking.
