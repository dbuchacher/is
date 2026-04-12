# Lattice Test Spec — What to Compute

**From the wit side, written for the coder.** Each test below has a
specific integer expected result, the framework reason it matters,
and what we need the lattice tool to prove. Tests are ordered by
difficulty (scalar walker → SIMD → new primitives).

**All results are exact integers. No decimals anywhere. The walker
already enforces this — so does the framework's compute-first rule.**

See `~/code/everything/wit/thoughts/compute_principles.md` for the
rule set, `~/code/everything/wit/thoughts/prime-lattice/MILESTONE.md`
for where the numbers came from, and
`~/code/everything/wit/thoughts/prime-lattice/findings/` for detailed
writeups of each finding referenced below.

---

## Framework constants worth testing (all integer, all derivable)

```
  name         value    derivation
  ─────        ─────    ──────────
  gates        3        Post 1941 — AND/OR/NOT functional completeness
  dims         4        Hurwitz 1898 — normed division algebras (R→C→H→O)
  atoms        8        dims · 2 polarities
  corners      16       2⁴ vertices of 4-cube
  bonds        32       16 · 2 polarities
  faces        24       C(4,2)·2² — 2-cells of 4-cube
  edges        32       C(4,1)·2³ — 1-cells of 4-cube
  shell1_full  81       3⁴
  shell1_nz    80       3⁴ − 1 (non-origin shell 1)
  composed     72       80 − 8 (non-atom non-origin shell 1)
  pyth_fill    25       3² + 4² (gates² + dims²)
  pyth_prod    12       3 · 4 (gates · dims)
  sacred_year  364      (3⁶ − 1)/2 = all-ones 6-digit balanced ternary
```

Each of these deserves a test walk. `expect.txt` just needs the integer
on the right.

---

## Tier A — Structural counts (scalar walker, quick wins)

These verify the lattice tool can enumerate the framework's basic
structural counts. All fast, all use scalar dispatch, all validate
the tool on claims that are already proven on paper.

### A1. `corners_16.w`
Enumerate `{−1, +1}⁴` (16 points), count, `expect 16`.

This verifies the 4D hypercube vertex count. It's the simplest
possible "nested loops + memory counter" test.

### A2. `atoms_8.w`
Enumerate single-axis shell-1 points — coordinates with exactly one
non-zero (8 such: `[±1,0,0,0]`, `[0,±1,0,0]`, `[0,0,±1,0]`, `[0,0,0,±1]`).
Count, `expect 8`.

### A3. `shell1_80.w`
Enumerate `{−1, 0, +1}⁴` excluding `[0,0,0,0]`. Count, `expect 80`.

### A4. `composed_72.w`
Enumerate `{−1, 0, +1}⁴` excluding origin AND excluding single-axis
atoms. Count, `expect 72`.

Framework meaning: 72 is the "composed" shell-1 subset — everything
that requires more than one axis to describe. This count appears in
cultural traditions (names of God, disciples, elders, etc.) and in
`π(364)` below. It's `80 − 8`, a pure framework derivation.

### A5. `faces_24.w`
Count 2-cells of the 4D hypercube. Formula: `C(4,2) · 2² = 24`.
`expect 24`.

Framework meaning: faces are the 2-zero points of the ternary lattice
(partition by zero-count gives the f-vector 16/32/24/8/1 = hypercube
structure).

### A6. `hypercube_81.w`
Full `3⁴` enumeration including origin. `expect 81`.

### A7. `pyth_identity_N4.w`
Compute `20 · 80 · 12` and `24 · 32 · 25` as integers, verify equal,
emit the common value. `expect 19200`.

Framework meaning: this is THE Pythagorean integer identity at the
4D hypercube shell 1. `20 = primes at edges`, `80 = shell-1 nonzero`,
`12 = gates·dims`, `24 = signed primes up to 40`, `32 = edge cells`,
`25 = gates² + dims²`. **Every factor is a framework constant, and
the two integer products are identical.** The walk just has to do
the two multiplications and a compare — doesn't even need primes.

---

## Tier B — Prime counting at shell boundaries

Each `π(x_N)` at the boundary `x_N = (3^N − 1)/2` is an exact integer.
These tests validate the walker can handle nested loops and a simple
trial-division primality test.

### B1. `prime_pi_13.w` — π(13) = 6
Trial divide 2..13, count primes. `expect 6`.

### B2. `prime_pi_40.w` — π(40) = 12
`expect 12`.

Framework meaning: **12 = gates · dims = 3 · 4**. The prime count at
the 4D hypercube shell boundary equals the product of the framework's
two fundamental theorems (Post and Hurwitz). This test is the
framework's most direct prediction touching prime counting at the
native dimension.

### B3. `prime_pi_121.w` — π(121) = 30
`expect 30`.

### B4. `prime_pi_364.w` — π(364) = 72
`expect 72`.

Framework meaning: **THE BIG ONE**. The sacred year (`364 = (3⁶−1)/2`
= all-ones six-digit balanced ternary = Enoch/Jubilees/Qumran sacred
calendar = 52 · 7 weeks · days) has prime count exactly 72, which
equals:
- `atoms · gates² = 8 · 9`
- `80 − 8 = composed shell-1` (same integer as A4 above)
- Cultural 72 across 9+ unrelated traditions (names of God, elders,
  disciples, etc.)

**Three independent framework derivations and a mathematical fact,
all converging on one integer.** This test proves the convergence
with a single integer count.

Same test, three assertions:
```
  π(364) == 72
  72 == 80 − 8
  72 == 8 · 9
```

The walk should emit `72` as the pipeline value.

### B5. `prime_pi_1093.w` — π(1093) = 183
`expect 183`.

Side note: `1093` is itself prime AND it's one of only two known
Wieferich primes (`2^(p−1) ≡ 1 mod p²`). Not a framework claim, just
a coincidence flag.

### B6. `prime_pi_3280.w` — π(3280) = 462
`expect 462`. (N=8 shell boundary.)

### B7. `prime_pi_9841.w` — π(9841) = 1214
`expect 1214`. (N=9 boundary.)

### B8. `prime_pi_29524.w` — π(29524) = 3204
`expect 3204`. (N=10 boundary.)

---

## Tier C — Prime-lattice theorem verification

**This is the real prize.** These tests verify the prime-cell
distribution identity we worked out in the wit/prime-lattice quest,
including the theorem failures at N=12, 15, 16.

Background (short version): at each N, the shell-1 prime distribution
satisfies `A · B · f = C · D · g` as an exact integer equation, where:
- `A` = signed primes at cell z
- `D` = cell point count = `C(N, z) · 2^(N−z)`
- `C` = `2 · π(x_N)` (signed total primes)
- `B` = `3^N − 1` (shell-1 nonzero)
- `(f, g)` = reduced integer pair

The conjecture: `gcd(g across cells at N) = odd_part(x_N)`. Holds at
N=3..11, 13, 14, 17. Fails at N=12, 15, 16. See
`wit/thoughts/prime-lattice/findings/04-extended-N11-17.md` for the
failure analysis.

### C1. `prime_cells_N4.w` — parity law at N=4

At N=4, enumerate primes 2..40, for each compute the 4-digit balanced
ternary, count the zeros, tally by zero-count. Expected distribution
(signed primes):

```
  z=0 corners     0 primes
  z=1 edges      20 primes   ← (5,7,11,13,17,19,23,29,31,37 × ±1)
  z=2 faces       2 primes   ← (±2)
  z=3 atoms       2 primes   ← (±3)
  z=4 origin      0 primes
```

The walker emits the 5-tuple as a packed integer OR runs 5 separate
tests (easier). If packed: pick an encoding and let the runner check
it. If separate, 5 walks, 5 expect lines.

Easier version — just emit the count at `z=1` (edges): `expect 20`.

### C2. `pyth_identity_integer.w`

Already listed as A7 but moved here because it validates the
theorem's integer form directly.

Compute `20 · 80 · 12` and `24 · 32 · 25`. Confirm equal and emit
`19200`.

### C3. `shell_gcd_N12_fails.w`

At N=12, verify `gcd(g) = 91`, NOT `odd_part(x_12) = 33215`. This is
the first theorem failure point.

Walker needs to:
- Compute prime count at each cell z for N=12 (using 12-digit
  balanced ternary to classify each prime up to `x_12 = 265720`)
- Compute `A · B / (C · D)` reduced to `g / f` at each cell
- Compute `gcd(g)` across all prime-holding cells
- Emit `gcd(g)`
- `expect 91`

The failure is structural: `ord₇₃(3) = 12` means 73 first divides
`3^N − 1` at N=12, AND 73 happens to divide `π(265720) = 23287`.
Gcd arithmetic kills the 73 factor in the reduction.

**This is the test that validates the refined theorem** (gcd =
odd_part / d, where d captures coincidences) rather than the simple
form.

### C4. `shell_gcd_N18_unknown.w`

At N=18, `x_18 = (3¹⁸ − 1)/2 = 193710244`. Computing this requires
sieving primes up to ~194 million. **Python ran out of memory.** The
lattice walker with scalar dispatch can handle this — maybe slowly,
but it can do it.

- Compute `π(x_18)` (unknown to us)
- Compute cell counts and gcd(g)
- Emit `gcd(g)`
- `expect ?` — **this is new territory.** We don't have the answer.
  The theorem prediction: `N=18 = 2·3²` inherits old primes from
  divisors 1, 2, 3, 6, 9. Candidates: 13 (from N=3), 7 (from N=6),
  757 (from N=9). Some of these likely appear in binomial
  coefficients `C(18, z)` at prime-holding z. Predict: **fails** —
  simple form doesn't hold.

### C5. `shell_gcd_N19_prime.w`

N=19 is prime. Prediction: **holds** — the only primes in `x_19`
are the Zsygmondy-primitive one at N=19 (probably large), and they
won't appear in small binomial coefficients.

- Compute `π(x_19)` (unknown)
- Compute gcd(g)
- Emit `gcd(g) == odd_part(x_19)` as a 0/1 boolean
- `expect 1`

### C6. `shell_gcd_N20_composite.w`

N=20 = 2²·5. Inherits primes from N=1, 2, 4, 5, 10 — specifically 5
(from N=4), 11 (from N=5), 61 (from N=10), etc. Prediction: **fails**
(small primes likely in binomials).

- Compute gcd(g)
- Emit boolean
- `expect 0`

---

## Tier D — Cayley-Dickson at dim 16 and 32

**This is the computation Python couldn't do.** The old C version
(`~/code/prior/ToE/wit/findings/c/chain.c`) used `double` + `fabs <
1e-10` + sampling and reported `19%` chain rate at dim 32 as a float.
We want the exact integer `(chains : candidates)` at dim 32 under
integer-only arithmetic.

### D1. `cd_zeros_d16.w` — sedenion zero divisor count

Enumerate canonical basis pairs `(A = e_i + e_j, B = e_k ± e_l)` at
dim 16. For each, compute the CD product using integer-only sedenion
multiplication. Count pairs where the product is the zero vector.

- Canonical form (same as Python `cayley_dickson_integer.py`):
  - `i, j ∈ {1..15}`, `i < j` (exclude the real axis at index 0)
  - `k, l ∈ {1..15}`, `k < l`
  - sign ∈ `{−1, +1}` on `e_l`
- Expected count: **168 signed pairs** (or **84 unsigned**, matching
  the classical Moreno 1998 number).
- `expect 168` (signed)

### D2. `cd_chains_d16.w` — sedenion chain count

For each zero-divisor pair `(A, B)`, find all `C` such that `B·C = 0`
(another zero-divisor). Test if `A·C = 0`. Count.

- Expected: **0 chains out of 252 candidates**
- Emit chain count
- `expect 0`

### D3. `cd_mul_d32_primitive.w` — test CD multiply at dim 32

Build a dim-32 CD multiplication primitive in core.asm (recursive,
calls the dim-16 version twice per multiply). Verify with a known
non-zero product at dim 32.

No specific expected value — this is infrastructure. Write it as a
self-check walk: multiply `e_1 · e_2` at dim 32, verify the result
matches the framework's sedenion doubled recurrence. Emit a 0/1
boolean.

### D4. `cd_zeros_d32.w` — dim 32 zero divisor count

Same canonical form as D1, but at dim 32. Python got **2520** for
this (in about 10 seconds). The lattice tool should match.

- `expect 2520`

### D5. `cd_chains_d32.w` — **THE BIG ONE**

Same chain enumeration as D2, but at dim 32. This is what Python
couldn't compute (6+ billion integer operations). Expected runtime
on scalar dispatch: ~30 minutes to a few hours. Expected runtime
with SIMD chain-check primitive: ~1-10 minutes.

- Expected: **unknown**. This is the integer-exact replacement for
  the old "19%" float estimate.
- The old test claimed 19.0% which would be `chains/total ≈ 0.19`.
  If total is ~10000, chains should be ~1900. We want the EXACT
  `(chains, total)` integer pair.
- Emit both `chains` and `total` as separate outputs, OR emit their
  ratio reduced to lowest terms.

**This is the headline test of the entire quest.** When this produces
an exact integer ratio, the framework has its first rigorous
verification of the "heartbeat" claim at dim 32+.

---

## Tier E — Beyond dim 32 (if hardware allows)

### E1. `cd_zeros_d64.w` — octonion-doubled zero divisor count

Extend to dim 64. Exhaustive enumeration at this dim requires CD
multiply at dim 64, which calls the dim-32 version twice. No prior
compute has done this integer-exact, period.

- Expected: **unknown, fresh territory.**
- Runtime: heavy. Might need SIMD to be tractable.

### E2. `cd_chains_d64.w` — extend chain count to dim 64

Same concept. Unknown integer ratio. If the "heartbeat" claim is real
and `dim 32 chain rate ≈ 19%`, then dim 64 should be higher still —
framework predicts "decay cascade past sedenion."

---

## Tier F — Mertens function at scale

Classical number theory territory. Python computed `M(x)` to
`x = 10⁶` with results consistent with RH. The lattice tool can go
further without memory explosion (no Python dict overhead).

### F1. `mertens_10_7.w` — M(10⁷)

Compute the Mertens function `M(x) = Σ μ(n)` up to `x = 10⁷`.
Expected: a specific integer (look up or compute reference).

Use this to verify no float drift at scale.

### F2. `mertens_10_8.w`

Extend to `10⁸`. Expect a specific integer.

### F3. `mertens_x_18.w` — M at lattice-boundary N=18

Compute `M(x_18) = M(193710244)` — the lattice-complete boundary at
N=18. Python couldn't. Emit exact integer `M(x_18)`.

**Unknown to us.** From our existing data:

```
  N    x_N         M(x_N)
  12   265720      1        ← nearly zero at theorem-failure point
  13   797161     −73       ← negative of the prime that killed N=12
  14   2391484    319
  15   7174453   −741
  16   21523360   288
  17   64570081  1136
```

N=18 is next. Does the pattern hold `|M(x_N)| < √x_N`? (Mertens
conjecture, known false at ~10¹⁴, unknown at our range yet.)

---

## Priority order

If you can only do a few, do these first (in order):

1. **A7 `pyth_identity_N4`** — 5 minutes to write. Validates the
   framework's most important integer equation. Low-hanging fruit.
2. **A1-A5 `corners_16` through `faces_24`** — tool warmup.
   Validates basic structural counts and gives you confidence the
   walker handles loops + memory.
3. **B4 `prime_pi_364 = 72`** — validates the biggest framework
   convergence at N=6. Sacred year meets prime counting.
4. **C1 `prime_cells_N4`** — validates our parity law at N=4 and
   produces the `20` count directly.
5. **C3 `shell_gcd_N12_fails`** — validates the known theorem failure.
   Hits the first case where simple form breaks.
6. **C4 `shell_gcd_N18_unknown`** — first genuinely new result.
7. **D1-D2 `cd_zeros_d16`, `cd_chains_d16`** — validates your CD
   multiply primitive against known Python results before extending.
8. **D4 `cd_zeros_d32` → D5 `cd_chains_d32`** — the headline compute.

Everything else is bonus.

---

## What "pass" means

For each test, the walker emits ONE integer at walk end (pipeline
value). The runner compares integer to integer. No float tolerance.
Match exactly or fail.

Where a test has an unknown expected result (C4, D5, E1, E2, F3), the
runner just prints the result. **That's the finding** — we didn't know
it before the test, now we do.

Where a test has a known expected result from our Python compute,
getting the same integer confirms the asm path is correct. Where
the result matches a framework prediction (π(40)=12, π(364)=72,
pyth_identity=19200), that's framework validation.

---

## Framework principles (non-negotiable, from compute_principles.md)

1. **Integer only.** No float anywhere. Equality is `==`.
2. **No decimal output.** Results as integer counts, integer ratios
   `p:q`, or integer equations. Never percentages.
3. **Cross-multiply, don't divide.** Test `a·d` vs `c·b`, not `a/b`.
4. **Exhaustive where tractable**, exact `(count, total)` pair when
   sampling.
5. **Framework-native dimensions** when in doubt: 3, 4, 8, 16, 24,
   32, 72, 80, 81 structural; 13, 40, 121, 364, 1093, 3280 shell
   boundaries.

The walker already enforces these at the type level. Just don't
sneak them in from main.c or hodos.c output formatting.

---

## Questions / open notes

- **The CD multiply primitive (Tier D)** needs careful design in
  core.asm. Recursive implementation, each dim level calls the one
  below it twice. Integer int64 throughout. Check for overflow at
  dim 32 — with basis-element inputs (`{−1, 0, +1}` coefficients)
  the intermediate products stay small, should fit int64 easily.
- **SIMD for chain enumeration at dim 32** is the obvious
  performance win. Not mandatory — scalar will work, just slow.
  The agent's own proposal (README line 397+) for
  `shell1_edges_80` using `vpcmpneqd ymm + vpmovmskb` generalizes
  to CD chain counting at dim ≤ zmm lane width.
- **Result reporting**: for tests that emit multiple integers (like
  C1 giving per-z counts), pick the format that's easiest to verify.
  Running 5 walks and comparing 5 expect lines is fine.

---

**From the wit side: this is the full ask.** Pick any slice that
matches your current momentum. Everything here has either a known
expected integer (validation) or is brand-new territory Python
couldn't reach. Either way, every passing test is a framework
verification the wit quest couldn't do alone.

Ping back with results (or blocking questions) when you've got
something ready.
