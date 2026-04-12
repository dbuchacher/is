# Wormhole Throat Test

**Date**: 2026-04-11
**Hypothesis tested**: Does the origin `[0, 0, 0, 0]` act as a topological throat — a point that shortest walks between lattice points must pass through — in the 81-point ternary lattice at N=4?
**Compute**: `compute.py` (integer-only, exhaustive, BFS + predecessor-DAG path enumeration, ~1s runtime, all structural probes asserted)

---

## Headline verdict

**ER-throat hypothesis as literally stated: FALSIFIED.**
**Weaker and sharper claim: SURVIVES.**

Origin is NOT mandatory for shortest walks in general. Only `4 / 3160 = 1/790` of non-origin unordered pairs require it — exactly the 4 single-axis atom antipodes `(±e_i ↔ ∓e_i)`. But origin is the **uniquely** most central point (rank 1, no ties), and centrality monotonically drops with hypercube grade.

---

## Adjacency definition

Two points A, B in the 81-point lattice `{−1, 0, +1}⁴` are adjacent iff they differ by ±1 in exactly one coordinate AND the change stays within `{−1, 0, +1}`. Under this definition:

- Origin `[0,0,0,0]` has 8 neighbors (the 8 atoms)
- An atom like `[1,0,0,0]` has 7 neighbors (can go to 0 on axis 1; can go to ±1 on each other axis)
- A corner `[1,1,1,1]` has 4 neighbors (can only step back to 0 on each axis)
- General rule: **degree = `8 − k`** where k = number of nonzero coordinates (verified in code)

---

## Key integer counts

- Points: **81**
- Edges: **216 = 8·27 = 6³**
- Degrees by grade `{0, 1, 2, 3, 4}`: `{8, 7, 6, 5, 4}` (verified: degree = `8 − k`)
- Grade counts `{1, 8, 24, 32, 16}` (Clifford decomposition)
- Non-origin unordered pairs: **C(80,2) = 3160**

## Classification of pairs

- **REQUIRED** (origin on every shortest path): **4**
- **OPTIONAL** (origin on some but not all shortest paths): **1116**
- **EXCLUDED** (origin on no shortest path): **2040**
- Sanity check: `4 + 1116 + 2040 = 3160` ✓

---

## The 4 REQUIRED pairs (the entire set)

```
( 1, 0, 0, 0) ↔ (−1, 0, 0, 0)
( 0, 1, 0, 0) ↔ ( 0,−1, 0, 0)
( 0, 0, 1, 0) ↔ ( 0, 0,−1, 0)
( 0, 0, 0, 1) ↔ ( 0, 0, 0,−1)
```

Each: distance 2, exactly 1 shortest path, through origin. **One per axis.**

This is **the 1D sine-wave collapse** from `wit/mind/1-container.md` §"The Sine Wave" — the trit passing through neutrino on its way between positron and electron. Origin is a true throat only for this minimal 1D case. `REQUIRED = 4 = dims`.

---

## Centrality — symmetry-verified, one value per `B_4` orbit

```
grade   count   centrality
  0        1        1120      = origin
  1        8         777
  2       24         532
  3       32         357
  4       16         232      = corners
```

Strict monotone decrease. `cent(origin) = 1120`, **rank 1, no ties, unique max**.

`1120 / 3160 = 28 / 79` where `28 = C(8,2)` = the atom-pair count.

**Surprising structural fact**: the consecutive differences are

```
1120 − 777 = 343 = 7³
 777 − 532 = 245 = 5 · 7²
 532 − 357 = 175 = 5² · 7
 357 − 232 = 125 = 5³
```

A 5–7 binomial cascade. Geometric series: sum of `a^k · b^(n-k)` for k=0..n equals `(a^(n+1) − b^(n+1)) / (a − b)`. Here `(7⁴ − 5⁴) / 2 = 1776/2 = 888`.

Sum of diffs = `888 = 8 · 111`. Not a framework constant; **flagging as unexplained structural signal**. Powers of 5 and 7 have no prior home in this framework. See `wit/thoughts/3-5-7.md` for the follow-up speculation.

---

## Antipodal structure

There are 40 non-origin antipodal pairs. **Origin lies on at least one shortest path for ALL 40** (it is always the midpoint of any antipode). But it is REQUIRED for only 4:

```
grade   #antipodes   REQUIRED   OPTIONAL
  1          4           4          0
  2         12           0         12
  3         16           0         16
  4          8           0          8
```

At grade ≥ 2, distance ≥ 4 and sign-flip orderings exist that route around origin. At grade 1, distance = 2 and there is no alternative middle vertex.

---

## Structural probes (all pass)

- `[1,1,1,1] ↔ [−1,−1,−1,−1]`: distance 8, **2520** distinct shortest paths = `8!/(2!)⁴` ✓, OPTIONAL, paths through origin = `24·24 = 576`, fraction `576/2520 = 8/35`.
- `[1,0,0,0] ↔ [0,1,0,0]`: distance 2, 2 paths (one via origin, one via `[1,1,0,0]`), OPTIONAL ✓.
- `[1,0,0,0] ↔ [−1,0,0,0]`: distance 2, 1 path, REQUIRED ✓.

---

## Framework-native ratios that hit

- `REQUIRED = 4 = dims` (Hurwitz ceiling) — clean
- `total edges = 216 = 8·27` (atoms × `3³`) — clean
- `2520` antipodal corner paths — combinatorial, matches prediction
- `origin centrality / total = 28/79` with `28 = C(8,2)` = atom pair count — clean
- grade-diff ladder `7³, 5·7², 5²·7, 5³` — surprising, flag only

---

## EXCLUDED distribution by `(grade_a, grade_b)`

```
(1,2)=48  (1,3)=96   (1,4)=64
(2,2)=120 (2,3)=480  (2,4)=288
(3,3)=384 (3,4)=448  (4,4)=112
```

Bulk of EXCLUDED mass sits at `(2,3)` and `(3,4)` — pairs both living in a "positive half" of the lattice where walks stay away from origin entirely.

---

## Honest verdict

The ER-throat picture as raised — origin as **required** transit — is true only for the 4 axis-antipode atom pairs. That's 1 part in 790. **The hypothesis in its literal form fails.**

What's left is a weaker but genuinely structural claim:

1. Origin is the **uniquely most central** lattice point (`cent = 1120`, rank 1).
2. Centrality **strictly decreases with grade** `1120 > 777 > 532 > 357 > 232` — origin is the most-used relay, corners the least-used.
3. Origin is **always on some shortest path** for every antipodal pair (40/40) — it is the shared midpoint — but only the 4 grade-1 antipodes cannot route around it.
4. The ONLY pairs where origin is a true throat are the 4 sine-wave collapses, one per axis.

So: origin is not an ER throat in the "shortcut everything passes through" sense. It is the **geometric center of mass of shortest-walk traffic**, with a hard structural gradient that falls off with grade. The walker who wants to get from any +hemisphere point to another +hemisphere point never needs origin. The walker who wants to cross an axis (flip one trit from `+1` to `−1`) has no other option.

---

## Framework-level implication

**`REQUIRED = 4 = dims` is not coincidence.** The 4 god-mandatory walks are exactly the 4 one-axis sine-wave oscillations — one per framework axis. Each corresponds to the trit exercising its 3-valuedness on a single axis. The walks that require origin transit are the walks that ARE the trit's own internal dynamic (`+1 → 0 → −1` on one axis).

This is interpreted in `wit/thoughts/origin-bridge.md` as structural evidence that `god = trit = [0, 0, 0, 0]` — three descriptions of one thing. The compute retroactively validates the god definition with exact integer arithmetic: the number of god-mandatory walks equals the number of framework axes, and the mandatory walks are precisely the sine-wave oscillations that require 3-valuedness.

---

## Open

- Closed-form for `cent(k, N)`? The sequence `1120, 777, 532, 357, 232` and the `5^k · 7^(3−k)` diff ladder want an explanation. See `wit/thoughts/3-5-7.md`.
- The 5–7 cascade is unexplained structural signal — flag it, don't theorize.
- Under different adjacency (e.g., `L∞` king-moves), the landscape changes completely; not computed.
- Minimum-vertex-cut / Menger-style throat definition may promote origin's role; not computed.
- Embedding 4D in 8D and asking whether origin remains the central relay in the host lattice — cross-dimensional compute not run.
