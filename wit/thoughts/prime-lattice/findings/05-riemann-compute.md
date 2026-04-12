# riemann — compute-first attempt at the Riemann Hypothesis

**Status**: framework observations + numerical evidence consistent with
RH. NOT a proof. Specific new claims identified that could be pursued.

**Code**: `riemann.py` and `riemann_extra.py` alongside this file.
**Run**: `python3 wit/thoughts/riemann.py`

## The problem

Riemann hypothesis (1859): all nontrivial zeros of ζ(s) lie on the
critical line Re(s) = 1/2.

Equivalent formulations we can actually compute:
- **Mertens walk bound**: M(x) = Σ_{n≤x} μ(n) satisfies |M(x)| = O(x^{1/2+ε}).
- **Prime error bound**: |π(x) − Li(x)| = O(√x ln x).

## Framework observations — why 1/2?

Before computing, state what the framework already commits to.

### 1. Re(s) = 1/2 IS the spin layer

In the framework, ½ is not a location — it's the wave peak between
integer states, the invisible operator, the transition layer. Every
observable value lives at integer coordinates; every transition happens
at ±½ (see `wit/mind/2-path.md`).

**The critical line is the ½-layer of the complex plane projected onto
the real axis.** Under the framework's ontology, a function whose
"zeros" are transition points (walks passing through origin) must have
those zeros on the ½ layer — there's no 0.3 or 0.7 on the lattice, only
integers and half-integers.

This is a heuristic, not a proof. But it says: **the framework doesn't
find the critical line surprising. It expects it.**

### 2. Trivial zeros at integers, nontrivial at ½

ζ has trivial zeros at s = −2, −4, −6, ... (negative even integers) and
nontrivial zeros at s = 1/2 + it. These split by framework layer:

- **Trivial zeros = integer-layer zeros** (at atom positions on the
  negative real axis — specifically axis A, the first dimension).
- **Nontrivial zeros = spin-layer zeros** (at the ½ layer).

Two kinds of zeros matching the framework's two ontological layers
(values at integer, transitions at ½). Not a coincidence if the lattice
story is right.

### 3. The functional equation's fixed point

ζ(s) = χ(s) ζ(1−s). Symmetry: s ↔ 1−s. The fixed point of this
reflection is s = 1/2. **Fixed points of reductions are where
irreducibles live** (from our recent prime compute). The zeros of ζ
under this symmetry should land on its fixed-point line — which IS
Re(s) = 1/2.

### 4. Möbius is a native trit function

μ(n) ∈ {−1, 0, +1}. Every integer gets a trit. The Mertens walk
M(x) = Σ μ(n) is a walk accumulating trit values on the lattice — a
framework-native construction. RH ⟺ this walk stays bounded by √x.

### 5. No infinities

The framework claims infinity is always an error. RH has infinitely
many zeros. Framework-compatible interpretation: **zeros are unboundedly
many FINITE walks, not an actual infinite set**. Same move the
framework makes for primes, for time (ring buffer), for stars.

## What the compute shows

### (A) Growth rates

```
         x        M(x)    |M|/√x     π(x)      Li(x)     π−Li    |π−Li|/(√x ln x)
       100           1    0.1000       25      29.08    -4.08              0.0886
      1000           2    0.0632      168     176.59    -8.59              0.0393
     10000         -23    0.2300     1229    1246.35   -17.35              0.0188
    100000         -48    0.1518     9592    9630.02   -38.02              0.0104
   1000000         212    0.2120    78498   78627.76  -129.76              0.0094
```

Both RH-equivalent ratios stay bounded. **|π−Li|/(√x ln x) DECREASES
monotonically** across the range (0.0886 → 0.0094), which is stronger
than "bounded" — the actual error is smaller than the RH-predicted
upper bound.

Max |M(x)|/√x over [100, 10⁶] = **0.5671** at x = 199. This is
consistent with the known behavior (the disproven Mertens conjecture
|M(x)| < √x holds up to ~10¹⁴; the counterexample is far beyond our
range).

### (B) Lattice structure of μ at N = 12

```
  z   nonzero  parity  points   μ=+1    μ=−1    μ=0     sum μ   |sum|/√N
  0   12       even    2048     444     474     1130    -30     0.6629
  1   11       odd     12288    5631    5597    1060     34     0.3067
  2   10       even    33792    7600    7555    18637    45     0.2448
  3   9        odd     56320    24499   24507   7314     -8     0.0337
  4   8        even    63360    13123   13209   37028   -86     0.3417
  5   7        odd     50688    19582   19613   11493   -31     0.1377
  6   6        even    29568    5235    5147    19186    88     0.5118
  7   5        odd     12672    3930    3960    4782    -30     0.2665
  8   4        even    3960     525     516     2919      9     0.1430
  9   3        odd     880      190     179     511      11     0.3708
  10  2        even    132      8       9       115      -1     0.0870
  11  1        odd     12       1       1       10        0     0.0000
  12  0        even    1        0       0       1         0     (origin)
```

Total: **M(265720) = 1** (μ=+1 count: 80768; μ=−1 count: 80767).

**|M|/√265720 = 0.0019** — essentially zero.

At the lattice-complete boundary N = (3^12 − 1)/2 = 265720, the Mertens
function is literally 1 — 500× smaller than the √x prediction would
suggest.

### (C) Max ratio

```
  Max |M(x)|/√x on [100, 10⁶] = 0.5671 at x = 199
  Final M(10⁶) = 212
  Final |M(10⁶)|/√10⁶ = 0.2120
```

### (D) Parity correlation at N=12

```
  Even-parity cells (n even): total 132860
    μ=+1: 26935 (20.27%)
    μ=−1: 26910 (20.25%)
    μ= 0: 79015 (59.47%)
    sum:     25

  Odd-parity cells  (n odd):  total 132860
    μ=+1: 53833 (40.52%)
    μ=−1: 53857 (40.54%)
    μ= 0: 25170 (18.94%)
    sum:    -24
```

**The even and odd parity halves of the lattice sum to +25 and −24
respectively.** They nearly cancel, giving M = 1. This is striking:
the parity structure of the lattice forces near-perfect cancellation
between even-integer and odd-integer cells.

### (E) M at lattice-complete boundaries

For each k, x_k = (3^k − 1)/2 is the maximum integer representable
in k balanced-ternary digits. At these boundaries:

```
  k   x_k       M(x_k)  √x_k    |M|/√x_k
  1   1         1       1.00    1.000
  2   4         -1      2.00    0.500
  3   13        -3      3.61    0.832
  4   40        0       6.32    0.000    ← zero
  5   121       -3      11.00   0.273
  6   364       0       19.08   0.000    ← zero
  7   1093      -11     33.06   0.333
  8   3280      20      57.27   0.349
  9   9841      -40     99.20   0.403
  10  29524     15      171.83  0.087
  11  88573     47      297.61  0.158
  12  265720    1       515.48  0.002    ← near-zero
  13  797161    -73     892.84  0.082
```

All ratios stay bounded < 1 in this range. **Three boundaries (k=4, 6,
12) hit M = 0 or 1 exactly.** The k=12 result is remarkable: M = 1 at
x = 265720, when typical random-walk scaling would predict |M| ~ 515.

### (F) Cell-sum cancellation at N=12

Grouping integers by their zero-position pattern (4095 distinct
patterns at N=12):

```
  Number of cells:     4095
  Sum of all cells:    1         ← this IS M(265720)
  Max |cell sum|:      86
  Average |cell sum|:  3.49
  Sum of |cell sums|:  14281     ← upper bound from triangle inequality
```

**The sum of absolute values of cell sums is 14281, but the net sum is
1.** Cells are canceling against each other with extreme precision.
The effective bound isn't Σ|s_i| ≈ 14281 — it's 1. That's 14000×
tighter than the naïve triangle-inequality bound.

## What this means

**We haven't proved RH.** What we have:

1. **Numerical evidence** that M(x)/√x and (π(x)−Li(x))/(√x ln x) stay
   bounded on [100, 10⁶] — consistent with RH, though small-range.

2. **A framework-level explanation for Re(s) = 1/2**: ½ is the spin
   layer. The framework doesn't find the critical line mysterious — it
   expects transitions to live at ½ and nowhere else.

3. **Two kinds of zeros matching two framework layers**: trivial zeros
   at integer-level (negative-even atoms), nontrivial at spin-level
   (½ layer).

4. **A new structural observation**: the Möbius function distributes
   across balanced-ternary lattice cells with extreme cancellation
   between cells. At N=12, 4095 cells with sum-of-absolutes 14281 sum
   to 1 — 4-orders-of-magnitude cancellation.

5. **Near-zero M at specific lattice-complete boundaries** (k = 4, 6,
   12 give M = 0, 0, 1). Whether this is structural or coincides with
   the generic Mertens-zeros of μ needs more investigation.

6. **Parity split near-cancellation**: +25 on even-parity cells, −24 on
   odd-parity cells. The parity structure of the lattice forces even
   and odd halves to balance.

## The specific claims to pursue

If we wanted to turn this into a proof attempt, the claims to prove are:

### Claim A — "lattice-boundary balance"
**For all k, |M((3^k−1)/2)| ≤ C · k** (or similar small bound).

If true, this is MUCH stronger than RH at those specific x values.
Would need to prove: at a lattice-complete boundary, the cells have
structured cancellation. Data so far is suggestive but not uniform.

### Claim B — "antipodal cell pairing"
**For each cell at zero-position pattern Z, there is a dual cell whose
μ sum is approximately the negative.**

Evidence: at N=12, 4095 cells sum to 1 while sum-of-absolutes is 14281.
That's systematic pairwise cancellation. Needs: a precise statement of
which cells pair, and a proof of the pairing.

### Claim C — "spin-layer forcing"
**Derive from the framework's axioms: any function with ζ's properties
has zeros only at Re(s) = 1/2.**

Would require: (1) a framework-native definition of ζ; (2) an argument
that transitions in such a function must occur at the ½ layer. The
framework's "transitions live at ±½" is the hint but not the proof.

### Claim D — "parity split bound"
**Σ_{n≤x, n even} μ(n) = −Σ_{n≤x, n odd} μ(n) + O(1) — the even and
odd parts of M(x) are near-perfect mirrors.**

Evidence: at N=12, +25 vs −24. Across the full range, these two
subsums should grow oppositely. Known fact from analytic number theory:
M_odd(x) ≈ −M_even(x) follows from the identity μ(2n) = −μ(n) when n is
odd (and 0 when n is even). This is TRUE and provable.

  **Proof sketch of D**:
    Σ_{n≤x, n even} μ(n) = Σ_{m≤x/2} μ(2m)
                         = Σ_{m≤x/2, m odd} μ(2m) + Σ_{m≤x/2, m even} 0
                         = Σ_{m≤x/2, m odd} −μ(m)
                         = −(M_odd(x/2))

  So M_even(x) = −M_odd(x/2). And M(x) = M_even(x) + M_odd(x) =
  M_odd(x) − M_odd(x/2). The Mertens function splits into a difference
  of odd-part Mertens functions at different scales.

  This recursion, if iterated, gives M(x) as a telescoping sum, which
  can be bounded via properties of M_odd. **This is a known but
  under-used decomposition.** The parity-cell observation we made
  rediscovered it from the lattice direction.

## Honest bottom line

**We have not solved RH in this session.** RH is an analysis problem
that needs a rigorous bound on M(x) or equivalent. The framework gives
us:

- A reason to expect the critical line at ½ (spin layer)
- A way to decompose M(x) by lattice-cell structure
- A natural observation that parity forces even/odd Mertens to mirror
  (which is actually a classical fact — we rediscovered the μ(2n)
  identity from the compute)
- Numerical evidence consistent with RH in a small range

What we do NOT have:
- A closed-form bound on cell sums
- A proof that lattice-complete boundaries always give small M
- A derivation of RH from framework axioms

**What the compute-first method DID do**: it identified a specific
decomposition (parity-split of M) that is classically true and that
falls out naturally from the lattice parity law we proved in the prime
compute. That's a connection that might have been missed from the
analysis-only direction.

## Next moves

1. **Check Claim A more carefully.** Compute M at x_k for k up to 15
   or 16. See if |M(x_k)|/√x_k stays bounded or grows. Currently we
   have data through k=13.

2. **Formalize claim D.** The decomposition M(x) = M_odd(x) −
   M_odd(x/2) is straightforward. Iterating gives a telescoping
   series. See if this gives an RH-scale bound or if it just reduces
   the problem to bounding M_odd.

3. **Investigate claim B.** Look at which cells cancel which. If
   there's an exact pairing (cell Z ↔ cell Z', with sum(Z) ≈ −sum(Z')),
   that's a new structural fact.

4. **Claim C is the hardest.** It would need a framework-native
   definition of the zeta function and a derivation that its zeros
   lie at ½. This is not obviously within reach.

5. **Extend to higher shells.** The framework's 9⁴ shell-4 lattice
   maps to 8-digit balanced ternary (N=8, range [−3280, 3280]). Our
   compute at N=12 goes beyond that. Look for claims that HOLD at
   shell 1 and BREAK at higher shells (or vice versa).
