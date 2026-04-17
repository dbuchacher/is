# N=8 centrality cascade — prediction BROKEN

```
status:  VERIFIED (compute)
grade:   trit½
date:    2026-04-16
code:    wit/thoughts/trit½/prime-lattice/code/centrality_cascade.py
```

## Prediction under test

At N=4 the centrality-cascade differences factor through the prime
degrees `{5, 7}`. Prediction: at N=8 (degree range `[8,16]`, primes
`{11, 13}`) the cascade differences factor exclusively through
`{11, 13}`.

## Centrality definition

Back-derived by calibrating to the canonical N=4 per-node values
1120, 777, 532, 357, 232:

    cent(v) = # unordered pairs {s, t}, s ≠ v, t ≠ v, such that v lies
              on at least one shortest path from s to t.

Adjacency: `{−1,0,+1}^N`, neighbors differ by ±1 on one axis. Graph
distance = L1 distance (BFS-verified).

### Closed form (derived, BFS cross-checked)

L1 factors across axes, so "v on shortest s–t path" ⇔ for every axis
i, `v_i ∈ [min(s_i,t_i), max(s_i,t_i)]`. Per-axis ordered `(s_i,t_i)`
counts with `v_i` between: `v_i=0` → **7** of 9; `v_i=±1` → **5** of 9.

For v of grade k, inclusion-exclusion on s=v, t=v gives

    cent_per_node(k, N) = ( 7^(N−k) · 5^k  −  2·3^N  +  1 ) / 2
    Δ(k → k+1)          =   7^(N−k−1) · 5^k.

**Δ is independent of N.** Per-axis counts 7, 5 are trit-local.

### Verification

- N=4: closed form reproduces 1120, 777, 532, 357, 232 and the diffs
  7³, 5·7², 5²·7, 5³ exactly.
- N=8: closed form matches full numpy enumeration at one
  representative per grade, all 9 grades, integer equality.
- Grade counts at N=8: `1, 16, 112, 448, 1120, 1792, 1792, 1024, 256`,
  sum = 6561 = 3⁸ ✓.

## Results — N=8

| k | count | cent per node | grade total    |
|---|-------|---------------|----------------|
| 0 | 1     | 2 875 840     | 2 875 840      |
| 1 | 16    | 2 052 297     | 32 836 752     |
| 2 | 112   | 1 464 052     | 163 973 824    |
| 3 | 448   | 1 043 877     | 467 656 896    |
| 4 | 1120  |   743 752     | 833 002 240    |
| 5 | 1792  |   529 377     | 948 643 584    |
| 6 | 1792  |   376 252     | 674 243 584    |
| 7 | 1024  |   266 877     | 273 282 048    |
| 8 | 256   |   188 752     |  48 320 512    |

### Per-node cascade (N=4-analog quantity)

```
  Δ(0→1) = 823 543 = 7^7
  Δ(1→2) = 588 245 = 5 · 7^6
  Δ(2→3) = 420 175 = 5^2 · 7^5
  Δ(3→4) = 300 125 = 5^3 · 7^4
  Δ(4→5) = 214 375 = 5^4 · 7^3
  Δ(5→6) = 153 125 = 5^5 · 7^2
  Δ(6→7) = 109 375 = 5^6 · 7
  Δ(7→8) =  78 125 = 5^7
  sum = (7^8 − 5^8)/2 = 2 687 088
```

All eight factor **only through {5, 7}**. 11, 13 never appear.

### Per-grade-total cascade (secondary)

```
  Δ(0→1) = −2^4·1 872 557
  Δ(1→2) = −2^4·11·29·25 693
  Δ(2→3) = −2^9·7·11·7 703
  Δ(3→4) = −2^6·7·13·62 731
  Δ(4→5) = −2^10·7·13·17·73
  Δ(5→6) =  2^8·5^5·7^3
  Δ(6→7) =  2^12·53·1 847
  Δ(7→8) =  2^10·219 689
```

11, 13 appear but are joined by 2, 5, 7, 17, 29, 53, 73, and large
composite cofactors. Not a {11, 13}-cascade.

## VERDICT — BROKEN

- Per-node cascade at N=8 is a pure `{5, 7}` geometric series.
- Per-grade-total cascade carries primes far outside `{11, 13}`.

## Why

The N=4 `{5, 7}` cascade is not caused by "prime degrees of grade-1
and grade-3 cells." It is caused by **per-axis arithmetic on the
trit**. At N=4 two facts coincide: (1) per-axis straddle counts are
7 (over `v_i=0`) and 5 (over `v_i=±1`); (2) the prime degrees in
`[N, 2N]` are `{5, 7}`. At N=8 the degree range shifts to `[8, 16]`
but per-axis counts stay 7, 5, so the cascade stays on 5, 7. The
cascade is controlled by (1); the N=4 match was coincidence.

## Replacement — dimension-independent closed form

    cent_per_node(k, N) = ( 7^(N−k) · 5^k − 2·3^N + 1 ) / 2
    Δ(k → k+1)          =   7^(N−k−1) · 5^k
    Σ Δ                 = ( 7^N − 5^N ) / 2

At every Cayley-Dickson layer the cascade uses 5, 7. Meaning:

- **7** = # ordered trit pairs straddling 0
- **5** = # ordered trit pairs straddling ±1
- **7 − 5 = 2** = trit span
- `3^N` in the offset = lattice size

## Impact

- `trit½/3-5-7.md` — N=4 correlation confirmed; causal gloss
  ("prime degree drives cascade") disconfirmed. 5, 7 are trit
  constants, not dimension-activated.
- `wheel/3-lattice.md:501-521` — numbers correct, causal framing
  needs amending.
- `trit⁰/origin-bridge.md:235` — origin stays rank-1 central at N=8
  (cent 2 875 840, strictly highest); no 5,7 → 11,13 shift.

The degree-range fact `[N, 2N] at O contains {11, 13}` remains true,
but centrality-cascade coefficients do not realize those primes. The
cascade is a trit-level structural constant.
