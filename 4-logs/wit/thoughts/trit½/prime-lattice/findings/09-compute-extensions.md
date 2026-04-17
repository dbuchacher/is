# Compute extensions — four new structural datasets

**Date**: 2026-04-11 (post-terminal, same session)
**Scripts**: `mertens_shells.py`, `shell_invariants.py`,
`vp_activation.py`, `wieferich_base3.py`
**Status**: all four complete, new structural findings below

## 1. Base-3 Wieferich primes and the three-way cross-link

**Script**: `wieferich_base3.py` — exhaustive search up to 1M.

**Result**: `p = 11` is the **only base-3 Wieferich prime** up to
10⁶. A base-b Wieferich prime satisfies `b^(p−1) ≡ 1 (mod p²)`.

```
  base-2 Wieferich:  1093, 3511  (only two known)
  base-3 Wieferich:  11          (only one found up to 10⁶)
  both bases:        none
```

**Three-way cross-link at the Wieferich shells**:

```
  11 is base-3 Wieferich     → 3^10 ≡ 1 (mod 121)
  11 is Zsygmondy at N=5     → ord_11(3) = 5, first appears in 3^5−1
  x_5 = 121 = 11²            → shell boundary IS the Wieferich square

  1093 is base-2 Wieferich   → 2^1092 ≡ 1 (mod 1093²)
  1093 is Zsygmondy at N=7   → ord_1093(3) = 7, first appears in 3^7−1
  x_7 = 1093                 → shell boundary IS the Wieferich prime itself

  M(x_7) = −11               → Mertens at the base-2-Wieferich shell
                                 = negative of the base-3-Wieferich prime
  M(x_7)² = 121 = x_5        → Mertens-squared at N=7 shell
                                 = shell boundary at N=5
```

**Structural rule**: a base-3 Wieferich prime p has `p² | 3^(p−1) − 1`,
which implies `p² | 3^k − 1` where `k = ord_p(3)`, which means
`v_p(x_k) ≥ 2`. So x_k contains p² as a factor. For p=11, k=5,
and `x_5 = 11²` exactly (no other odd factors). The Wieferich
condition is WHY x_5 is a perfect square.

**The M(x_7) = −11 link** between base-2 and base-3 Wieferich primes
via the Mertens function is currently unexplained. It could be a
small-number coincidence (11 is small, M(x_7) is small, overlap
is plausible). Or it could be structural — testable at larger
Wieferich primes if any exist beyond 10⁶.

**Cross-reference with Zsygmondy table**: of the 17 framework
Zsygmondy primitives at N=3..17, only p=11 (N=5) is base-3
Wieferich. p=1093 (N=7) is base-2 Wieferich but NOT base-3. No
overlap between the two Wieferich bases at any Zsygmondy entry in
our range.

## 2. π-side stripping is quantifiably rare

**Script**: `vp_activation.py` — π(x_N) factorizations for N=3..18.

**Result**: the v_p(C) mechanism in the three-term shell-identity
theorem activates at only **1 out of 16 N values** in the sieveable
range (N=12, via p=73). The walker already showed N=20 adds p=5 and
p=11 (beyond sieve range).

**π(x_N) factorizations**:

```
  N    π(x_N)        factorization
  ──   ──────        ─────────────
  3         6        2 · 3
  4        12        2² · 3
  5        30        2 · 3 · 5
  6        72        2³ · 3²
  7       183        3 · 61
  8       462        2 · 3 · 7 · 11
  9     1,214        2 · 607
  10    3,204        2² · 3² · 89
  11    8,580        2² · 3 · 5 · 11 · 13
  12   23,287        11 · 29 · 73          ← 73 shared with B_12
  13   63,752        2³ · 13 · 613
  14  175,722        2 · 3 · 29287
  15  487,719        3² · 47 · 1153
  16  1,360,958      2 · 137 · 4967
  17  3,816,776      2³ · 47 · 10151
  18  10,749,836     2² · 29 · 92671
```

**Framework-constant hits in π(x_N)**:
- π(x_4) = 12 = gates · dims = 3·4
- π(x_6) = 72 = atoms · gates² = 8·9 = composed-shell-1

Both already known from the four-way 72 convergence and the
Pythagorean identity. Now confirmed as exact factorizations of π at
those specific shell boundaries.

**"When does v_p(C) strip?" activation sequence**: for each prime p,
the smallest N where p | π(x_N):

```
  p=2: N=3    p=3: N=3    p=5: N=5    p=7: N=8    p=11: N=8
  p=13: N=11  p=29: N=12  p=61: N=7   p=73: N=12  p=89: N=10
```

Non-monotonic (p=61 activates at N=7 before p=29 at N=12). The
primes that SHARE between B_N and π(x_N) at the same N — causing
actual v_p(C) stripping — are rare: only p=73 at N=12 in range.

## 3. Mertens function extended through N=18

**Script**: `mertens_shells.py` — Möbius sieve up to 200M.

**Result**: M(x_N) and M_odd(x_N) tabulated for N=3..18. All 16
values satisfy M²<x_N (Mertens conjecture / RH-consistent bound).

```
  N    M(x_N)   M_odd(x_N)   M²/x_N
  ──   ──────   ──────────   ──────
  3      -3        -4         0.692
  4       0        -5         0
  5      -3       -10         0.074
  6       0       -13         0
  7     -11       -20         0.111
  8      20        -6         0.122
  9     -40       -48         0.163
  10     15        -5         0.008
  11     47        -6         0.025
  12      1       -24         0.000004
  13    -73      -116         0.007
  14    319        59         0.043
  15   -741      -330         0.077
  16    288       112         0.004
  17   1136       483         0.020
  18  -2254     -1220         0.026
```

**New data point**: `M(x_18) = −2254 = −2·7²·23`. The 7 is Zsygmondy
primitive at N=6 (wormhole atom degree); the 23 is Zsygmondy
primitive at N=11.

**Parity identity** `M(x) = M_odd(x) − M_odd(x/2)` verified exactly
at all 16 N values.

**M_odd(x_N) is a genuinely new sequence** — never before tabulated.
Whether it correlates with shell_gcd_N or has structural patterns of
its own is open.

## 4. Shell invariants — the g-vector beyond gcd

**Script**: `shell_invariants.py` — gcd/lcm/sum/max/min of the
g-vector at each N=3..16.

**Result**: the g-vector at N=4 IS the Pythagorean pair.

```
  N=4  g_values = [5, 25]
       gcd  =  5   = Pythagorean leg
       lcm  = 25   = 3² + 4² = Pythagorean fill
       sum  = 30   = π(x_5)
```

The `25` in the headline identity `20·80·12 = 24·32·25 = 19200` is
literally the LCM of the g-vector. The GCD is `5`. These two
integers — the leg and the hypotenuse² — are the COMPLETE g-vector
at the native 4D dimension.

**The `sum = 30 = π(x_5)` is a cross-shell link** — the g-sum at N=4
equals the prime count at N=5. Checked: this does NOT generalize
(`shell_sum(N) ≠ π(x_{N+1})` at any other tested N). Specific to
the native dimension.

**lcm/gcd ratio at small N**:

```
  N=3: lcm/gcd = 1    N=4: lcm/gcd = 5    N=5: lcm/gcd = 3
  N=6: lcm/gcd = 5    N=7: lcm/gcd = 345
```

At N=4 and N=6, the ratio is 5 (Pythagorean leg). At N=5 it's 3
(gates). At N=7+ it's not a clean framework constant.

**shell_sum at N=6**: `1001 = 7·11·13` — three Zsygmondy primes
(from N=6, N=5, N=3) as factors. Clean.

**g-vector dispersion grows with N**: at N=3, all cells give the same
g (uniform). By N=12, every cell has a different g. The gcd
captures the MIN reduction; the LCM captures the MAX. The spread
between them (= the structural diversity of prime distributions
across cells) increases with N.

## Status

All four scripts reproducible. Data matches existing machine-verified
integers where they overlap (shell_gcd values, π(x_N) at N=4 and
N=6). New data extends the known structural landscape without
contradicting anything.

Future compute (Tier F sieve, Tier E d64, walker Mertens probes) is
directed in the coder handoff at
`lattice/primes/handoff/v2-archive.md` (Turn 19 direction).
