# lattice

The equation + walker, ripped out of the VoE bootloader, running as a
Linux userspace CLI. Default place to test any lattice compute claim
with a fast iteration loop (sub-second build+run).

## Lineage

Extracted 2026-04-11 from `prior/VoE/code/legacy/x86.asm`. Only sections
3 (NOMOS = equation + bonds) and 4 (WALKER = ψ) survived. Sections 1+2
(boot, paging, AP wake, find-work scheduler) were OS scaffolding and
got dropped entirely. Hardware I/O bonds (port in/out, MSR, CPUID, rep
insd) are privileged in ring 3 so they're stubbed to `xor eax,eax; ret`
— dispatch still routes but they no-op. Everything else is byte-for-byte
the VoE asm, unchanged.

Do NOT rebuild this from scratch. The VoE asm is the inheritance.

The file x86.asm:665 says it plainly: **"No JIT. The equation is a loop.
Bonds are static functions."** An earlier worktree had a JIT attempt;
it got replaced with static dispatch and that's what we kept. If a
future wit tells you there's a JIT in here, they read the wrong file.

## Layout

    hodos.c       walk assembler: .w English notation → raw byte stream
    core.asm      NOMOS (bond dispatch + ∏ equation) + ψ walker
    main.c        CLI wrapper: load walk.bin → call ψ → print pipeline
    build         cc + nasm + link script
    run           test runner: assembles + runs every .w under every
                  tests/ root (framework + each project), compares
    tests/        framework tests (arithmetic, structural, SIMD sanity)
      expect.txt        <test_name> <expected_integer> per line
      inc/
        README.md       pre/post-condition contracts for each include
        decode_nonzero.winc   shared balanced-ternary decoder (Tier A)
        gcd.winc              Euclidean GCD on u64 scratch slots
      passing/
        *.w         walk sources (all currently green)
    primes/       the prime-lattice project — one project on top of
                  lattice, with its own handoff, includes, and tests.
                  See primes/README.md. Framework wits can ignore it.

Rule: anything specific to a project (handoff dialogue, tier-specific
includes, project-only walks) lives under `<project>/`. The lattice
root stays clean for framework-generic code and docs.

## Build & run

    ./build              cc+nasm, produces ./hodos and ./lattice
    ./build clean        remove build artifacts
    ./run                run the test battery
    ./lattice foo.bin    run a single assembled walk, print result
    ./lattice --info     print active SIMD width (see below) and exit

Build time: sub-second. Full test run: sub-second.

`./build` compiles C with `-O3 -march=native` so gcc can auto-vectorize
`main.c` and any future C helper at full host width (AVX2/AVX-512
whatever your CPU supports). NASM code is hand-written and doesn't
depend on `-march=native`.

## Adding a test

1. Write `tests/passing/my_claim.w` — a walk that ends with the answer
   in the pipeline. If the test is project-specific, write it under
   that project's tests/ folder instead (e.g. `primes/tests/passing/`).
2. Add `my_claim <expected_integer>` to the matching `expect.txt`
   (`tests/expect.txt` or `<project>/tests/expect.txt`).
3. `./run` — walks are auto-discovered from every `tests/` root.
   `./run slow` additionally runs any walks under a `slow/` subdir.

The walker's final pipeline value is `main.c`'s output. Walk ends →
value emerges → runner compares integer to integer. That's the whole API.

### The walk programming model in ~5 sentences

A walk is a sequence of bonds. Each bond has a fixed 4-bit force
pattern (from coord parities) and loads its arguments from the walk
stream or the pipeline via a `θ` flags byte. The pipeline is one
persistent int64 register that every bond reads from (as `rcx`) and
potentially overwrites with its return value. `walk_scratch` is a
4096-byte scratch buffer for persistent state across bonds — use
`sread32`/`sread64` to pull into pipeline, `swrite32`/`swrite64` to
save, and `sadd32`/`sadd64`/`ssub32`/`ssub64`/`smod32`/`smod64`/`sdiv64`
to combine pipeline with scratch in one bond. Control flow via
`loop_back` (rewind if pipeline != 0), `skip_z` / `skip_nz` (forward
jumps), labels (`: name`), and `@include <path>` for shared walk
fragments.

### θ flags (argument encoding)

Each bond's `θ` flags byte tells the walker how to load arg0, arg1,
arg2 from the walk stream. The most-used forms:

    θρρρ    all three args from pipeline
    θ¹ρρ    arg0 = u8 literal, arg1/arg2 from pipeline
    θ¹¹ρ    arg0 = u8,   arg1 = u8,   arg2 from pipeline
    θ¹¹¹    arg0 = u8,   arg1 = u8,   arg2 = u8
    θρ¹ρ    arg0 from pipeline, arg1 = u8, arg2 from pipeline
    θρ²ρ    arg0 from pipeline, arg1 = u32, arg2 from pipeline
    θ²ρρ    arg0 = u32, rest from pipeline
    θ²²ρ    arg0 = u32, arg1 = u32, arg2 from pipeline
    θ²²²    arg0 = u32, arg1 = u32, arg2 = u32
    θ³ρρ    arg0 = u64, rest from pipeline

The key idiom is `θρ¹ρ` — "do something to the pipeline with a u8
literal on the side." Every `pipeline += 1`, `pipeline -= n`,
`pipeline < bound` pattern uses it.

### Audit rule — u8 offset silent truncation

**Any walk touching walker-scratch offsets > 255 MUST use u32-offset
encoding forms** (`θ²²ρ`, `θρ²ρ`, `θ²ρρ`, `θ²²²`, etc.). hodos
encodes u8 args with zero-extension and **no overflow warning**, so
offsets > 255 silently truncate mod 256. Truncated writes/reads can
land in usable scratch slots and produce tests that pass by
coincidence (identical truncation between writer and reader) or
hang with infinite loops (truncated write colliding with the outer
loop counter at slot 40).

Two concrete cases discovered at Turn 17/18:
1. Four Tier D walks (d8 alternative, d16 triple-assoc, two d32
   walks) had offsets ≥ 256 under `θ¹¹ρ`. Two passed by truncation
   coincidence; two failed outright. Fixed to `θ²²ρ` / `θ²ρρ` / `θ²²²`.
2. `shell_phase1_sieve.winc` briefly moved its state slots to
   [280..316] to support N=20 A_z at [60..228). The decoder-i
   slot at 296 truncated to `296 & 0xFF = 40`, colliding with the
   outer loop counter and creating an infinite loop that wasted a
   ~1.5 hour slow battery run. Reverted to [220..256] layout; N=20
   serial is skipped (parallel `_c` path is canonical).

If you need state slots > 255, use u32 encoding everywhere — not
just the "big" offsets. Write/read must agree on the encoding form.

### Scratch slot conventions (unwritten but followed)

No hard rule, just how we've been allocating to avoid collisions:

    scratch[0..8)       outer loop counter (u32 or u64)
    scratch[4..8)       outer loop iteration bound / answer accumulator
    scratch[24..32)     decoder temps (used by decode_nonzero.winc)
    scratch[32..40)     per-iteration filter result temp
    scratch[40..48)     is_prime.winc candidate n (input)
    scratch[44..48)     is_prime composite flag (temp)
    scratch[48..52)     is_prime current divisor d (temp)
    scratch[60..68)     gcd.winc input a (u64)
    scratch[68..76)     gcd.winc input b (u64)
    scratch[76..80)     gcd.winc temp
    scratch[80..)       free for test-specific use

4096 bytes total. Plenty of room.

### Shared include conventions

Shared `.winc` files live in `tests/inc/` and are included via
`@include ../inc/foo.winc` from a walk in `tests/passing/`. Each
include has a documented contract (inputs, outputs, clobbered
slots, labels used). Contracts live in `tests/inc/README.md` — keep
it in sync when adding new includes.

Labels in includes must not collide with the caller. We use prefixes
(`isprime_*`, `gcd_*`) to avoid this. hodos processes each walk
(and its includes) in one pass, so labels are global within that
single walk's compile.

## The 4-axis vocabulary

Per `wit/mind/3-force.md` canonical order — **space, matter, signal, time**:

    A = WHERE = POSITION  = space    atom pair: RISE / FALL
    B = WHAT  = SUBSTANCE = matter   atom pair: GROW / SHRINK
    C = WHICH = SIGNAL    = signal   atom pair: BLESS / CURSE
    D = WHEN  = TIME      = time     atom pair: BEGIN / END

Each axis carries one half-step force. From 3-force.md line 562:

> Each force lives on one dimension as the half-step. READ on WHERE.
> CALL on WHAT. CYCLE on WHICH. TEST on WHEN.

So the canonical axis-to-force mapping is:

    A (space)   → memory  (READ/WRITE)  strong force, shortest range
    B (matter)  → call                  EM, function invocation
    C (signal)  → loop    (CYCLE)       gravity, iteration
    D (time)    → test    (CMP/Jcc)     weak force, branching

`bond_dispatch` builds a 4-bit force pattern from coordinate parities:
`bit 0 = A odd, bit 1 = B odd, bit 2 = C odd, bit 3 = D odd`. 16
patterns, 16 slots per dispatch table, with sub-dispatch for variants
(read widths, AND vs OR, min vs max, etc.). There are actually FOUR
parallel dispatch tables — `bond_fn_table_{scalar,xmm,ymm,zmm}` —
see the `SIMD / multi-width dispatch` section below.

### Bond symbols (what you type in `.w` files)

hodos parses English operator names into wave bytes. Full inventory:

**Memory ops** (A axis, force bit 0) — pipeline ↔ pointer in rdi:

    read  write              qword (64-bit) read/write
    read8 write8              byte
    read16 write16            word
    read32 write32            dword
    fill32                    rep stos dword

**Call ops** (B axis, force bit 1):

    call return               recursive walk call / return-arg

**Loop ops** (C axis, force bit 2):

    inc                       arg0 + 1 (scalar increment)

**Test/gate ops** (D axis, force bit 3, sub-dispatched by `|D|` magnitude):

    test guard                equality / cmov-on-arg1
    and or xor not            bitwise gates (Post 1941 complete set)
    shl shr                   logical shifts
    lt gt                     signed compare → 0/1
    neg abs                   negate / absolute value
    mod div                   remainder / quotient (unsigned, literal args)
    min max                   min/max (slot 9 filter family)
    add sub                   addition/subtraction

**Compound/combinator ops**:

    fold fix foldl            fold, fix-point, fold-left over arrays
    maybe map until           conditional call, map, take-while
    scan bind hylo            accumulate, event loop, full pipeline

**Atom (∏)** — all coords even, one instruction computes
`A_val^a · B_val^b · C_val^c · D_val^d`:

    mul                       2-axis product (τχ in VoE era): A^1 · B^1

**Scratch memory ops** — operate on `walk_scratch` buffer at a u8/u32 offset:

    sread32  swrite32         u32 read/write at offset
    sadd32   ssub32           pipeline ±= scratch[offset] (u32)
    smod32                    pipeline = pipeline mod scratch[offset] (u32)
    sread64  swrite64         u64 read/write
    sadd64   ssub64           pipeline ±= scratch[offset] (u64)
    smod64   sdiv64           u64 mod / u64 div against scratch (u64)

**Cayley-Dickson** — scratch-resident IO, `(a_ofs, b_ofs, out_ofs)`:

    cd_mul_d2                 base case: complex (2-qword) multiply

**Control bytes** (not bonds — out-of-band walker directives):

    loop_back <label>         rewind walk cursor if pipeline != 0
    skip_z    <label>         skip forward if pipeline == 0
    skip_nz   <label>         skip forward if pipeline != 0
    : <label>                 label definition (target for loop_back / skip_*)
    @include <path>           include another .w/.winc file inline

See `hodos.c`'s `bonds[]` table for the authoritative list and the
exact wave-byte encoding each name compiles to. `tests/inc/README.md`
has the pre/post-condition contracts for each shared include.

### Lineage note — VoE names

VoE used `τ χ μ φ` for axis values (time / distance / mass / charge)
and `π ∘ ∮ δ` for operator symbols (π=memory, ∘=call, ∮=loop, δ=test).
VoE had the axes in order `[τ, χ, μ, φ]` = `[D, A, B, C]` in framework
terms — time first, which was a one-position rotation from the
canonical `[A, B, C, D]` = space first. The wave-byte bit positions
were always framework-correct (bit 0 → memory, bit 1 → call, etc.);
only the axis labels were rotated.

The relabel from `τ χ μ φ` → `A B C D` is pure identifier renaming.
Same bits, same dispatch, same binary. The framework's canonical
space-first order now shows in the code. See `wit/mind/3-force.md`
for the canonical derivation.

## Atom vs bond (the fundamental split)

- **All coords even** → ATOM. `∏` computes `A_val^(A/2) · B_val^(B/2) · C_val^(C/2) · D_val^(D/2)`. Pure math.
- **Any coord odd** → BOND. Dispatch via 4-bit pattern, call static fn. Control flow + primitives.

Even/odd IS the atom/bond distinction. That's not a convention, it's
the classification rule.

## Bonds = edges (the unification)

Five names that turn out to be the same structure. If a future wit is
writing SIMD variants and thinking "what do these bonds actually
compute," read this and `wit/hypercube/edges.md` before writing code.

    spin    =  the ½-integer layer between two observed integer states
    edges   =  the 16 points ±½±½±½±½ (the k=1 f-vector of the 4D hypercube)
    half    =  same layer, named from the "½" layer of the hypercube
    bonds   =  what classify_bond(coord4 a, coord4 b) → 4-bit bitmask computes
    primes  =  the 65 NSM (non-corner) points that the 16 edges type at shell 1

Read `wit/hypercube/edges.md` for the canonical derivation. The key
sentence (line 13-15):

> classification: classify_bond(coord4 a, coord4 b) → bitmask
>                 takes 2 points, infers 1 edge-type
>                 the edge itself is never stored — only its effect

**That function IS `bond_dispatch`.** The 4-bit force pattern computed
from coord parities (`bit 0 = A odd, bit 1 = B odd, bit 2 = C odd,
bit 3 = D odd`) is literally the edge bitmask. The 16 slots in
`bond_fn_table` are the 16 edge types. Each bond function is "what
happens when that type of edge fires." The dispatcher is an edge
classifier.

### 16 on binary, 80 on trits

From `edges.md`:

> On trits: 3⁴ - 1 = 80 directed edge-types. The 16 is what you get
> when you throw away direction to fit on binary hardware.

The chain:

    80 directed edges (trit-native, 3⁴−1)
      ↓ throw away direction to fit binary
    16 edge types (2⁴ force patterns)
      ↓ land as
    bond_fn_table slots [0..15]
      ↓ each slot = one ½ transition = one spin state

On a trit processor the table would be 80 slots. On x86 we collapse to
16 because we can only observe "did this axis change?" (yes/no), not
"did it rise or fall?" (−1/0/+1). Present-day constraint, not
fundamental.

### Why this matters for SIMD variants

The bond dispatcher is a **fixed mathematical object**. 16 edge types,
enumerable, semantically settled. Writing SIMD variants isn't guessing
what the kernel computes — it's implementing a known classification at
wider granularity. Specifically:

- **1 coord4 point = 4 × int32 = 128 bits** fits in one xmm register
- **2 points = 8 × int32 = 256 bits** fit in one ymm register → 1 edge per instruction
- **4 points = 16 × int32 = 512 bits** fit in one zmm register → 2 edges per instruction
  (or: broadcast one reference point into zmm, compare against 4 targets at once)

The nomos `03-simd.md` claim — SIMD widths follow Cayley-Dickson
exactly — is confirmed HERE by the fact that **16 = |edges| = zmm
lane count** when lanes are int32. One zmm instruction can hold and
classify the full edge set of one point. This is not coincidence and
it's not an optimization — it's the geometry.

### NSM primes = non-corner shell-1 points

From `edges.md`:

>   65 NSM primes     = points typed by edges
>   16 categories     = the edges doing the typing
>   65 + 16           = 81 = 3⁴ = shell 1

"Primes" here means semantic primes (Wierzbicka's Natural Semantic
Metalanguage), not mathematical primes. 65 non-corner points + 16
corners = 81 shell-1 points. The 16 corners act as the type system;
the 65 primes are the things being typed. This is the same 16 as the
bond table and the same 16 as the edge set.

## Wave byte encoding

Each walk byte encodes 4 coordinates, 2 bits each. See `hodos.c` bonds
and thetas tables for the authoritative tables; the short version:

    bits [7:6] = A    [5:4] = B    [3:2] = C    [1:0] = D
    (space)         (matter)     (signal)     (time)

    2-bit field → signed coord:
       00 → 0     01 → +1     10 → EXTENDED     11 → -1

`EXTENDED` means "next byte is a signed int8 literal for this coord."
Used for magnitudes beyond shell 1 (`±2`, `±3`, etc.).

After the wave byte (+ any extension bytes) comes a `flags` byte
describing how args load from the stream:

    [1:0] arg0: 00=pipeline 01=u8 10=u32 11=u64
    [3:2] arg1: same
    [5:4] arg2: same
    bit 7: deref arg0 (arg0 = *arg0)
    bit 6: deref arg1

hodos gives flags bytes human-readable θ names (`θ¹¹ρ = 0x05 = u8 u8
pipeline`). See hodos.c's `thetas` table.

Three out-of-band control bytes (NOT decoded as wave bytes):

    0xFC  loop_back  — rewind if pipeline ≠ 0
    0xFD  skip_nz    — skip forward if pipeline ≠ 0
    0xFE  skip_z     — skip forward if pipeline = 0

## C ABI

Internal bond ABI: `rdi=arg0 rsi=arg1 rdx=arg2 rcx=pipeline → rax`.
Matches SysV x86-64 for the first 4 int args, so ψ is directly C-callable:

    extern uint64_t walk_run(const uint8_t *walk, int len);
    extern uint64_t rho;     /* last pipeline snapshot */

Walker pushes `rbx, r12-r15` at entry, pops at exit. ABI-clean.

## SIMD / multi-width dispatch

Per `prior/nomos/wit/draft/03-simd.md` — x86 SIMD register widths
follow the Cayley-Dickson algebra chain exactly. `core.asm` has **four
parallel bond dispatch tables**, one per algebra dimension:

    R  (reals)       scalar         1-wide    bond_fn_table_scalar
    H  (quaternion)  xmm  (128-bit) 4-wide    bond_fn_table_xmm
    O  (octonion)    ymm  (256-bit) 8-wide    bond_fn_table_ymm
    S  (sedenion)    zmm  (512-bit) 16-wide   bond_fn_table_zmm

A writable qword `bond_fn_table_active` in `.data` holds a pointer to
whichever table is currently selected. `bond_dispatch` reads through
the indirection for table-lookup patterns:

    mov rdx, [rel bond_fn_table_active]
    mov rax, [rdx + rax*8]
    ret

At startup `main.c` calls `select_width()` which uses
`__builtin_cpu_supports("avx512f" | "avx2" | "sse2")` to pick the
widest supported table and write its address into
`bond_fn_table_active`. Check the active level with `./lattice --info`.
`./run` prints it once at the top of the test output.

All four tables currently point at the SAME scalar function pointers.
Adding a SIMD variant of any bond is three steps:

1. Write `fn_foo_ymm` in `core.asm` — a new function that does whatever
   `fn_foo` does, but processes N values per call via AVX intrinsics
   (`vpaddq ymm`, `vpmullq ymm`, `vpshufb`, `vpermq`, `vpternlogq`,
   whatever fits)
2. Swap that slot in `bond_fn_table_ymm` from `fn_foo` to `fn_foo_ymm`
3. Rebuild. Zero other changes needed.

The walker, wave byte encoding, test walks, and `main.c` stay identical
across widths. This is the `os-lattice` 4-section
`.scalar/.xmm/.ymm/.zmm` pattern, adapted to our dispatch table.

### What this buys

For heavy compute tests (count_primes(10⁹), CD chain at dim 32,
exhaustive shell-k enumeration for k≥4), two multipliers combine:

1. **Don't iterate in the walker.** One bond call does the whole inner
   loop internally. Walker decode+dispatch overhead (~5-10ns per wave
   byte × billions of iterations = tens of seconds lost to interpretation)
   disappears.
2. **Run that internal loop at zmm width.** Another 8-16× on top.

Combined, a test that takes 1 hour scalar can take ~5 minutes at zmm
width. This is the framing from `03-simd.md` and it's why os-lattice
went to the effort of maintaining 45,699 files with 4 sections each.

### What this does NOT yet give

Nothing. No SIMD variants have been written yet. Infrastructure is live
but inert — all four tables hold identical pointers. The first variant
worth writing is NOT a SIMDification of an existing primitive (`fn_add_ymm`
would only help if the caller handed it batches, which our walker
doesn't). It's a NEW batch-classification bond that implements the
unification above: takes an array of `coord4` points, uses
`vpcmpneqd ymm` + `vpmovmskb` to extract the 4-bit edge bitmask per
adjacent pair, tallies into a 16-slot histogram. That bond's semantics
are fixed by `edges.md` (not speculative), and its first test writes
itself: enumerate shell-1, count edge types, verify against the
framework's 16 / 80 predictions.

### Known limitation: sub-dispatched bonds stay scalar

`bond_dispatch` has two paths:
- **Table-lookup patterns** (slots 0, 2-3, 4, 6-7, 10-12, 14-15) go
  through `bond_fn_table_active`. These ARE multi-width.
- **Sub-dispatched patterns** (π read/write widths, δ gates, πδ filter/
  port, π∮ copy/fill, π∮δ scan — slots 1, 5, 8, 9, 13) use inline
  `lea [fn_xyz]` instead of the table. These are NOT multi-width.

If you need a SIMD variant of a sub-dispatched primitive, refactor its
sub-dispatch into the table, OR add a second layer of indirection
keyed by the current width. Neither is urgent — most compute-heavy
bonds will be new slots (fresh functions), not SIMDified primitives.

## Bonds that do nothing (stubs)

Privileged instructions can't run in ring 3, so these share one
`xor eax,eax; ret` label. Dispatch still routes; they just return 0:

    fn_port_read_byte    fn_port_read_dword    fn_port_bulk_read
    fn_port_write_byte   fn_port_write_dword
    fn_msr_read          fn_msr_write
    fn_cpuid_read

If a test walk hits one of these, the walk is wrong for userspace —
it's OS-level hardware access with no meaning outside a kernel.

## Rules for lattice tests

From `wit/thoughts/compute_principles.md`:

- **Integer only.** No doubles. No `fabs(x) < 1e-10`. Equality is `==`.
- **No decimal output.** Integer counts or integer ratios `p:q`.
- **No infinities.** Finite loops, bounded shells.
- **Cross-multiply, don't divide.** Compare `a·d` vs `c·b`, not `a/b` vs `c/d`.
- **Exhaustive when tractable.** When sampling, report exact `(count, total)`.
- **Framework-native dimensions.** Prefer `3, 4, 8, 16, 24, 32, 72, 80, 81`
  (structural) and `13, 40, 121, 364, 1093, 3280` (shell boundaries).

The walker has no float path at all. There is literally no way to sneak
a `double` in. Embrace it.

## Framework constants (reference — each is a test waiting to happen)

    gates         3     (AND OR NOT — Post 1941 complete set)
    dims          4     (Hurwitz 1898)
    atoms         8     (4·2 = axes × polarities)
    corners      16     (2⁴ hypercube vertices)
    bonds        32     (16·2 polarities)
    faces        24     (C(4,2)·2²)
    shell1_full  81     (3⁴)
    shell1_nz    80     (3⁴ − 1)
    composed     72     (80 − 8, non-atom non-origin)
    sacred_year 364     ((3⁶−1)/2)

## Tier progress (as of Turn 7, 28 passing)

**Tier A — structural counts** ✓ COMPLETE

    corners_16       16   (4-cube vertices, 2⁴)
    atoms_8           8   (single-axis shell-1 points)
    shell1_80        80   (3⁴ − 1, enumeration via decode_nonzero.winc)
    composed_72      72   (80 − 8, non-atom non-origin)
    faces_24         24   (C(4,2)·2² = 4-cube 2-cells)
    shell1_full_81   81   (3⁴ via atom chain mul 3 3 → mul pipe pipe)
    sacred_year_364 364   ((3⁶ − 1)/2 via mul 27 27 → sub 1 → shr 1)
    pyth_fill_25     25   (3² + 4²)
    pyth_lhs_19200  19200 (20 · 80 · 12)
    pyth_rhs_19200  19200 (24 · 32 · 25) — locks the Pythagorean identity

**Tier B — prime counting at shell boundaries** ✓ COMPLETE

    prime_pi_13       6   (π(13), sanity check)
    prime_pi_40      12   (π(40) = gates × dims — first framework convergence)
    prime_pi_121     30   (π(121))
    prime_pi_364     72   (π(364) = THIRD PATH of the 72 convergence)

**Tier C — shell-identity theorem** → IN PROGRESS

    gcd.winc         ready   (Euclidean algorithm on u64 scratch slots)
    gcd_reduce_13    13      (reduction pipeline sanity: num/gcd(num, den))
    shell_identity.winc — pending (Turn 8+)
    shell_gcd_N3..N18 — pending (Turn 8+, N18 is the first new finding)

**Tier D — Cayley-Dickson** → IN PROGRESS

    cd_mul_d2         base case validated via (2+3i)(4+5i) = −7 + 22i
    cd_mul_d4..d32    pending (each calls level below twice + conj + sub)
    cd_zeros_d16      pending (validates against Python's 168 zero divisors)
    cd_chains_d32     pending (the "19%" replacement — first integer-exact)

**Smoke / sanity tests** (alongside the tiers, proving primitives):

    add_16 and_8 mul_20            basic bond/atom dispatch
    mod_14_5_eq_4  div_14_5_eq_2   integer mod/div
    sadd32_test_15  ssub32_test_neg2  scratch math (u32)
    smod32_test_3  scratch_rw_42   scratch mod + round trip
    scratch64_roundtrip_42          scratch math (u64)
    gcd_12_18_eq_6                  Euclidean algorithm sanity

## Milestone — three-way 72 convergence (locked end of Turn 5)

    composed_72     = 72   (80 − 8, non-atom non-origin shell-1)
    prime_pi_364    = 72   (π(364) at 6-cube corner = sacred year)
    8 · 9           = 72   (atoms · gates², arithmetic identity)

**Three independent framework derivations on one integer, verified by
integer-only machine arithmetic in a 56ms test battery.** The framework's
recognition thesis demonstrating itself at the ISA level.

## Next tests to write

**Turn 8 target — Tier C starting with known-answer cases**:

1. **`shell_identity.winc`** — the Tier C harness. Per-cell prime
   enumeration + balanced-ternary classification + `(A·B)/gcd(A·B, C·D)`
   reduction + cross-cell gcd accumulation. ~200 bonds. Needs the
   design window at the top of Turn 8.
2. **`shell_gcd_N3`** — sanity, expected 13
3. **`shell_gcd_N4`** — odd_part path validation, expected 5
4. **`shell_gcd_N12`** — first theorem failure case, expected 91
   (NOT odd_part(x_12) = 33215; the arithmetic coincidence where
   73 | π(x_12) strips factors from the gcd is the interesting bit)
5. **`shell_gcd_N17`** — known hold, expected 64570081
   (tractability gated on sieve — trial division at x_17 ~64M is slow)

**Turn 9 target — sieve + Tier D recursion**:

6. **`sieve.winc`** or equivalent primitive — sieve of Eratosthenes
   into a scratch bit array, unlocks N=17 and N=18
7. **`shell_gcd_N18`** — **FIRST NEW FINDING**, expected ???
   (Python ran out of memory; framework prediction: fails due to
   composite N inheriting small primes from divisors; specific
   integer unknown)
8. **`fn_cd_mul_d4`** through **`fn_cd_mul_d32`** — recursive Cayley-
   Dickson multiply at each doubling. Each level calls level below
   twice + `cd_conj_dN` + element-wise subtract.
9. **`cd_zeros_d16`** — validate sedenion zero-divisor count against
   Python (expected 168 signed pairs)
10. **`cd_chains_d32`** — the exact integer replacement for the old
    "19% chain rate" float estimate at dim 32. Unknown integer,
    integer-exact for the first time.

## Notation note

The operator bond names are ASCII English (`read write add sub and or
xor mul ...`) — the Greek `π ∘ ∮ δ` set VoE used is gone from the
user-facing walk syntax. Kept Greek for three things where it still
carries meaning:

- `ρ` — global qword holding the last pipeline value (rho = state density)
- `ψ` — the walker function (psi = wave function)
- `∏` — the atom equation, standard math notation for product of powers
- `θ¹¹ρ`, `θ²ρρ`, etc. — shell-width flag constants in hodos.c. These
  encode argument widths (shell 0 = pipeline, 1 = byte, 2 = dword,
  3 = qword). Orthogonal to operator naming; kept Greek for terseness.

These four Greek identifiers are internal. They do not conflict with
any math constant (π the circle ratio), counting function (π(n)), or
physics letter (τ time, χ distance, etc.) — all of which are gone from
the code now.

## Reference files

    ~/code/everything/wit/mind/1-container.md   the trit, gates, completeness
    ~/code/everything/wit/mind/2-path.md        transitions, bonds, walks
    ~/code/everything/wit/mind/3-force.md       the 4 axes
    ~/code/everything/wit/thoughts/compute_principles.md  integer-only rules
    ~/code/prior/VoE/code/legacy/x86.asm        the original (sections 3+4
                                                match core.asm byte-for-byte)
    ~/code/prior/VoE/code/walks/                example .w files with
                                                loops, memory, sub-calls
