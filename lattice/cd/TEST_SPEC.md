# cd — Cayley-Dickson test spec

**Project**: integer-exact Cayley-Dickson multiplication tower +
structural probes at dim 4, 8, 16, 32.
**Parent framework**: `lattice/` (VoE-descended x86-64 walker).
**Sibling project**: `primes/`.
**Protocol**: integer only, no decimals, no floats, parallel where
the theorem permits, exhaustive > sampled.

## Why this project exists

The framework's "heartbeat" claim (from `~/code/everything/wit/mind/`)
is that something structurally interesting happens at CD dim 32.
Historically this was characterized by a float-based "19% chain rate"
estimate from `prior/ToE/wit/findings/c/chain.c` — `double` precision
with `fabs < 1e-10` equality tests and sampled chain computation.

Under the framework's no-decimals rule, the old result is suspect on
three fronts:
1. Float arithmetic
2. Sampling (statistical, not exact)
3. Percentage output (decimal, not integer ratio)

**This project replaces the float-based estimate with an
integer-exact ratio via integer Cayley-Dickson arithmetic.** The
target is the exact integer ratio `(chain_count : candidate_count)`
at dim 32, computed via the walker + parallel C.

Wit-side Python (`wit/thoughts/prime-lattice/code/cayley_dickson_integer.py`)
already produced the d16 answer (exactly 0 chains out of 252
candidates) and the d32 zero divisor count (2520). Python ran out
of steam at the d32 chain count. Walker takes over from there.

## Tier structure

### Tier D.1 — Multiplication primitives

Integer-exact Cayley-Dickson multiplication at each dim in the
tower. The recursion:

```
  d4 (quaternion):   (a, b) · (c, d) = (ac − d*b, da + bc*)    over ℂ = d2
  d8 (octonion):     same form, over d4
  d16 (sedenion):    same form, over d8
  d32 (pathion):     same form, over d16
```

where `*` denotes conjugation (`a = (a0, a1, ..., a_{n-1})` →
`a* = (a0, -a1, ..., -a_{n-1})`).

Primitives:
- `fn_cd_mul_d4`  — walker-native (spec anchor), `|D|=45`.
- `fn_cd_mul_d4_c` — C dispatch mirror, for cross-validation.
- `fn_cd_mul_d8_c` — C dispatch, `|D|=47`.
- `fn_cd_mul_d16_c` — C dispatch, `|D|=49`.
- `fn_cd_mul_d32_c` — C dispatch, `|D|=51`.

Register pressure at d8+ makes walker-native impractical (16
i64 inputs don't fit in GP regs). C dispatch via `cd_mul_d8_compute()`,
etc., in `main.c`. Framework-purity rule: multiplication is input
prep, not the theorem under test. The theorems are the zero
divisor and chain enumerations (Tier D.3/D.4).

`d4` stays walker-native as the grounded reference. Cross-validation
via `_c` variant keeps the C implementation honest.

### Tier D.2 — Norm and conjugate sanity

For each dim in {4, 8, 16, 32}:

1. **Identity**: `1 · q = q` for random q with small integer entries.
2. **Conjugate**: `q** = q` (involution).
3. **Norm square**: `q · q* = (|q|², 0, 0, ...)` — scalar real, all
   imaginary components zero.
4. **Basis squares**: `e_i · e_i = -1` for `i ∈ {1, ..., n-1}`
   (integer-exact, no float).
5. **Anticommutativity**: `e_i · e_j = -(e_j · e_i)` for `i ≠ j`,
   `i, j ∈ {1, ..., n-1}`.

Small, fast, all integer-exact. These anchor each primitive before
building structural probes on top.

### Tier D.3 — Zero divisor enumeration

A **canonical zero divisor pair** at dim n is a pair
`(A = e_i + e_j, B = e_k ± e_l)` where `A · B = 0` (or symmetrically,
`B · A = 0`). The Cayley-Dickson doubling introduces zero divisors
starting at dim 16 (sedenion); dim 4 and dim 8 are division algebras
(quaternions and octonions) and have no zero divisors.

Expected integer counts (from prior Python compute):

```
  dim    candidate pairs         zero divisor count
  ───    ────────────────        ──────────────────
   4     C(15, 1) · 2            0
   8     C(63, 1) · 2 · 2        0
  16     21945                   168                ← first nonzero
  32     431985                  2520               ← 15× d16
```

"Candidate pairs" = all `(A = e_i + e_j, B = e_k ± e_l)` with
`{i,j} ≠ {k,l}` and appropriate sign. Exact enumeration, no
sampling.

**Walker probes**:
- `zero_divisors_d4`   → 0 (confirm division algebra)
- `zero_divisors_d8`   → 0 (confirm division algebra)
- `zero_divisors_d16`  → 168 (match Python)
- `zero_divisors_d32`  → 2520 (match Python, first walker-exclusive check)

All four are exact integer answers. Python was the ground truth for
d4/d8/d16 and projected d32 from combinatorial structure. The walker
verifies d32 independently.

### Tier D.4 — Chain enumeration

A **chain** at dim n is a triple `(A, B, C)` such that
`A · B = 0` AND `B · C = 0` — a composite zero-divisor walk of
length 2 through a common pivot B. This is the structural probe the
old "19% chain rate" claim was trying to characterize.

Python results:
- d16: **0 chains out of 252 candidate triples** (exact)
- d32: **`chains_d32 = 3024`** ✓ LOCKED (Turn 17, 173 ms)
  - `chains_d32_candidates = 11172`
  - Exact chain rate: **`36/133`** (≈ 27.07%, was "19%" via old float)
  - Secondary ratio: `3024/2520 = 6/5` (chains per zero-divisor pair)

**The d16 = 0 result is significant**: it means the sedenion's
zero divisors exist but don't compose into chains of length 2. The
structural anomaly at dim 16 is "zero divisors without chains."

**Walker probes (all verified)**:
- `chains_d16`           → 0     ✓ (match Python)
- `chains_d32`           → 3024  ✓ (first walker-exclusive integer)
- `chains_d32_candidates` → 11172 ✓ (denominator for the 36/133 ratio)

### Tier E — dim 64+ (future)

Out of scope for the initial session. If `chains_d32` lands
cleanly and the walker pipeline has headroom, extend to dim 64
(chingons) and beyond. Each doubling produces ~15× more candidate
pairs and similar blowup in chains.

## Test naming convention

Same as `primes/`: filename encodes expected integer.

```
  cd_mul_d4_identity_2                 → 2
  cd_mul_d4_i_squared_neg1             → -1
  cd_mul_d4_noncommutative_neg1        → -1
  cd_mul_d4_norm_4                     → 4
  zero_divisors_d16                    → 168
  zero_divisors_d32                    → 2520
  chains_d16                           → 0
  chains_d32                           → 3024
  chains_d32_candidates                → 11172
```

All Tier D tests have known expected values and are in `cd/tests/expect.txt`.
Tier E (dim 64+) will produce new unknown integers.

## Integer-only discipline

- No decimals. Ratios are integer pairs `(numerator, denominator)`,
  not percentages.
- No floats. Every multiplication, conjugation, norm, and
  comparison is integer arithmetic at the hardware level
  (`int64_t` in C, walker GP regs in asm).
- No sampling. Candidate triples are enumerated exhaustively.
- No approximation. Zero-divisor check is exact integer equality
  against the zero element.

## Execution layout

- `cd/inc/cd_ops.winc` — shared CD primitives (once they exist)
- `cd/tests/passing/` — sanity + structural walks
- `cd/tests/slow/` — long-running walks (chains_d32 likely lives here)
- `cd/tests/expect.txt` — per-test expected integers
- `cd/README.md` — project overview (already present)
- `cd/TEST_SPEC.md` — this file
- `cd/handoff/` — wit ↔ coder dialogue

`./run` auto-discovers `cd/tests/` and loads `cd/tests/expect.txt`
via its multi-root glob (same mechanism `primes/` uses).

## Open questions

1. **Chain definition precision**: Python's `chain.c` used specific
   canonical forms. Need to confirm the walker enumerates the
   exact same set of candidate triples (not a subset, not a
   superset). Cross-validate at d16 against Python's 252
   candidates.

2. **`chains_d32` runtime**: with parallel C path, pegged at ~1-2
   min (per earlier speedup analysis). Will confirm with actual
   walker measurement during Turn 18/19.

3. **Dim 32 zero divisor verification**: the 2520 figure is from
   combinatorial projection, not Python enumeration. Walker is the
   first exact enumeration at d32. If it disagrees with 2520, that
   becomes the new ground truth and Python's projection was wrong.

4. **Integer ratio output**: `chains_d32` returns just the count.
   The "rate" is `(chain_count, candidate_count)` as an integer
   pair. Reported as `chains_d32 = N` and cross-referenced to
   `candidate_triples_d32` computed separately (or reported as a
   pair output).

## Wit-side companion files

- `wit/thoughts/prime-lattice/code/cayley_dickson_integer.py` —
  Python integer-exact CD at d4/d8/d16/d32 (partial)
- `wit/thoughts/prime-lattice/MILESTONE.md` § "Cayley-Dickson
  integer recompute" — history of the float→integer migration and
  the open d32 chain question.
- (future) `wit/thoughts/cd-results/` — finalized integer results
  from the walker, replacing the old 19% float estimate.
