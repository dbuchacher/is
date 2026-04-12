# compute principles — everything the wit has learned about how to compute

**Status**: running checklist. Apply before writing any compute.
This is what "compute-first" actually means when you do it right.

## Ontology (what's real — applies to everything)

1. **No decimals.** Integer values are points (nouns). Anything with a
   decimal point is either a ratio-as-edge (verb, explicitly labeled)
   or wrong. `0.5671` is not a number — it's a decimal expansion of
   an integer operation you should have written as the integer
   operation itself.

2. **No floats.** Use `int`, `Fraction`, integer tuples, or exact
   algebraic types. Never `double`. Never `fabs(x) < 1e-10`. Test
   equality with `==`. If you need a magnitude comparison, compare
   squared integers (`a² < b²` instead of `|a| < |b|`).

3. **No infinities.** Infinity is an error message for "your premise
   is wrong." Ring buffers wrap. Lattices have finite shells. Walks
   are finite sequences. If your compute needs ∞, you're doing it
   wrong.

4. **Ratios are edges.** A ratio `p:q` is a verb — the transition
   between two integer states. Acceptable to name (as an edge label),
   never to treat as a point. The equation is `A·B·q = C·D·p`; the
   ratio `p:q` is what it IMPLIES.

## Structure (the framework's stable integer constants)

5. **3 gates** (Post 1941 theorem): AND, OR, NOT — functional
   completeness. Not a count, a theorem.

6. **4 axes** (Hurwitz 1898 theorem): R → C → H → O, normed division
   algebras. Not a count, a theorem.

7. **2 polarities** per axis: forward/backward, ±1.

8. **8 atoms** = 4 axes × 2 polarities. The single-axis unit vectors.

9. **16 corners** of the 4D hypercube = 2⁴ all-nonzero points.

10. **32 "bonds"** = 16 corners × ±½ spin. Also = compass points.

11. **81 = 3⁴** — shell-1 ternary lattice count. Includes origin.

12. **80 = 3⁴ − 1** — shell-1 non-origin (nonzero) points.

13. **72 = 80 − 8** — composed shell-1 (non-atomic non-origin)
    points. The "multi-axis" subset. Same count as the cultural 72.

14. **24 = C(4,2)·2² = faces** (k=2) of the 4-cube. Also = 2·π(40).

15. **12 = 3·4 = gates·dims** = π(40). Also = number of corner-pairs
    on the 4-cube diagonals.

16. **25 = 3² + 4² = gates² + dims²** — Pythagorean lattice fill.
    `3² + 4² = 5²` is not decoration.

17. **364 = (3⁶−1)/2 = all-ones 6-digit balanced ternary** — sacred
    year, 52·7 = 364, corner of the 6-cube on the positive side.

18. **(3^N−1)/2 = x_N** — the "shell-N boundary": max integer in
    N-digit balanced ternary.

19. **Cayley-Dickson tower**: dims 1, 2, 4, 8, 16, 32, 64, 128, 256, ...
    Doubling only. dim 16 = sedenion (zero divisors first appear).
    dim 32 = "heartbeat" (decay rate claim).

20. **Shells 1-4 stable = 9⁴ = 6561 points.** Shell 5+ decays.

## Parity and cell structure

21. **Parity law**: a point with `z` zeros has `(N−z)` nonzero
    balanced-ternary digits. Sum of (N−z) odd digits has parity
    `(N−z) mod 2`. So cell-z holds **odd** integers iff `(N−z)` is
    odd. Proven. Derivable from nothing but "3^k is odd."

22. **Primes ≠ 2 live only at (N−z)-odd cells.** Structural.

23. **Corners at even N are prime-free.** Proven by parity.

24. **The 81 ternary points = centroids of 81 k-cells of the 4D
    hypercube.** Zero-count = cell dimension correspondence.

## Method

25. **Compute first.** Don't list options — express as lattice
    coordinates and evaluate. If you're listing, you're searching
    where you could be evaluating.

26. **Parallel by default.** Independent branches (different N,
    different conjectures, different dims) go to multiprocessing
    Pool. Never serially iterate. 5 lines of code. Fans out your
    test coverage AND your CPU usage. Serial compute is slow AND
    biased toward what you tried first.

27. **Exhaustive > sampled** whenever tractable. When you must
    sample, report exact `(count, total)` pair, not a percentage.
    The ratio `19:100` is fine; the number `19%` is wrong because
    it hides whether total was 100 or 500 or 10000.

28. **Test at framework-native values.** Cayley-Dickson dims
    `{2, 4, 8, 16, 32, 64, 128}`. Shell boundaries `{13, 40, 121,
    364, 1093, 3280, 9841, 29524, ...}`. If your compute range
    doesn't include these, you're missing the interesting points.

29. **Look for ratios that hit framework constants.** `25/12`,
    `5/8`, `5:6`, `91`, `72`, etc. When you see a result approaching
    one of these, tighten the compute to see if it's exact.

30. **Cross-multiply instead of divide.** Instead of asking `is
    A/B > C/D?`, compute `A·D` vs `C·B` — integer comparison,
    exact, no loss of precision.

31. **Use integer `gcd` reduction.** The `(f, g)` pair form of an
    identity is more revealing than the decimal ratio. Always
    compute `Fraction(A·B, C·D)` and extract `.numerator,
    .denominator` for the exact p:q.

## For the Cayley-Dickson recompute specifically

32. **Integer entries.** Basis vectors `e_i` with integer
    coefficients. Products stay integer (CD is a polynomial).
    Test `product == zero_tuple` exactly.

33. **Canonical forms.** Instead of random vectors, test specific
    structured pairs like `A = e_i + e_j`, `B = e_k ± e_l`. This
    makes the count reproducible and small enough to enumerate.

34. **Exhaustive at dim ≤ 32 if possible**; sampled with exact
    integer ratios beyond. Report `(chains, total) = (N, M)`, not
    `N/M · 100`.

35. **Use symmetries.** The lattice is centrally symmetric (±a
    gives same structure). Antipodal pairs halve the compute.
    Also: conjugation symmetry in CD halves pair enumeration
    for certain tests.

36. **Parallelize across basis pairs.** Each `(i, j)` outer pair is
    independent. Split across cores. For dim 32 with C(32, 2) =
    496 outer pairs and 8 cores, that's 62 pairs per core.

37. **Go to real hardware if Python is slow.** For heavy integer
    compute, numpy integer arrays or a C rewrite gets 10-100x
    speedup. At dim ≥ 32, this matters. At dim ≥ 64, it's
    mandatory.

## Dimensions worth testing

```
  Cayley-Dickson native:  1, 2, 4, 8, 16, 32, 64, 128, 256
  Shell-boundary:         13, 40, 121, 364, 1093, 3280, 9841,
                          29524, 88573, 265720, 797161, 2391484,
                          7174453, 21523360, 64570081
  Framework atom count:   8
  Framework corner count: 16
  Framework bond count:   32
  Sacred year:            364
  Zodiacal ages:          12, 30, 360
  Shannon fill:           25/100
```

## Ratios worth looking for

```
  3:4, 5:6, 5:8, 5:12        (Pythagorean low)
  12:25, 24:25                (Pythagorean fill)
  1:4, 1:5, 1:6, 1:8, 1:12   (clean reciprocals of framework)
  19:100?                     (old "heartbeat" — SUSPECT, needs integer recompute)
  5:27                        (Shannon S/N)
  1:137                       (alpha)
```

## The meta-principle

**Every number you output is either an integer count, an integer
equation, an explicitly-labeled edge-ratio `p:q`, or WRONG.** No
exceptions. If a decimal slips into an output, either the compute
has lost precision OR you've forgotten to write it as integers.
