# tests/inc — shared walk includes

`.winc` files that test walks pull in via `@include ../inc/<name>.winc`.
Each include is a self-contained fragment with explicit pre/post
conditions on scratch slots and pipeline state. Callers share the
contract so tests differ only in the filter / outer loop / expected
answer.

The runner's `*.w` glob does not match `.winc`, so files here are
never assembled on their own.

These are the **framework-generic** includes only. Project-specific
includes live alongside their project (e.g. `primes/inc/is_prime.winc`
for the prime-lattice project).

## decode_nonzero.winc

Decodes a base-3 counter (0..80) to the 4 coord parities of a
balanced-ternary point in `{−1, 0, +1}⁴`, counts how many are
nonzero, and leaves that count in the pipeline. Used by all 4 Tier A
enumeration tests (`atoms_8`, `shell1_80`, `composed_72`, `faces_24`).

    input   scratch[0]   outer loop counter, 0..80
    output  pipeline     nonzero_count ∈ {0, 1, 2, 3, 4}
    temp    scratch[24]  internal running accumulator (clobbered)
    temp    scratch[28]  per-axis temporary (clobbered)

Each test supplies its own predicate on `nonzero_count` — one bond.

## gcd.winc

Euclidean GCD on two u64 scratch slots. Caller writes `a` to slot 60
and `b` to slot 68, then `@include`s. Pipeline exits holding gcd(a,b).

**Single-use only.** For any walk that needs multiple gcd calls,
use the `gcd64` bond primitive at `|D|=+37` — see "includes vs bond
primitives" below.

## conventions

- **Scratch slot ranges** reserved per include, documented above.
  Callers must avoid those slots for their own state.
- **Labels** in each include are prefixed (`isprime_*`, `phase1_*`)
  to avoid collisions with caller walks. hodos labels are global
  per-compile; all label names within a single walk (including
  inline includes) must be unique.
- **Pipeline contract**: each include documents what the pipeline
  holds on exit. Callers read it directly or save it to a slot.
- **No new `.winc` without a contract section above.** When adding
  `cd_mul.winc`, etc., update this file with pre/post.

## CRITICAL — includes vs bond primitives

**Any include that needs to run more than once per walk becomes a
bond primitive, not an include.** Discovered at the start of Turn 8:
`@include gcd.winc` twice in one walk silently produces wrong code
because the second copy's forward `skip_nz gcd_done` resolves to
the FIRST copy's `gcd_done` label (since `find_label` returns the
first match), giving a negative offset that rewinds instead of
skipping.

Fix: promote to a bond primitive with no labels at all. `gcd.winc`
still exists for single-use cases (and its sanity tests still
pass), but multi-cell Tier C walks use `fn_gcd64` at `|D|=+37` —
one bond call per gcd, no collisions, trivial to chain.

Rule going forward: if a shared include would be called more than
once per walk, make it a bond first, reach for `@include` only for
single-use shared code.
