# lattice-v2 — build brief for fresh agent

You're building a bare-metal math VM that runs in QEMU. One purpose:
execute lattice walks (programs written as sequences of bonds in a
4D balanced-ternary coordinate space) and output integer results via
serial port. No OS, no C runtime, no libc. The walker IS the machine.

## Why this exists

The lattice is a 4D balanced-ternary coordinate space. Each point has
4 coordinates [A, B, C, D] with values in {-1, 0, +1}. This gives
3⁴ = 81 points at shell 1 — the full ternary lattice.

The four axes aren't arbitrary encoding. They ARE the four forces:

```
  axis  name       force     operation   range
  ────  ────       ─────     ─────────   ─────
  A     POSITION   strong    READ/WRITE  shortest
  B     SUBSTANCE  EM        CALL/RETURN infinite
  C     SIGNAL     gravity   CYCLE       weakest
  D     TIME       weak      TEST/GATE   transformation
```

When a bond has coordinate D=+9, D is odd → the TIME axis fires →
the TEST force is active. |D|=9 means modulo. The sign picks the
variant (+D=mod, -D=div). The coordinate IS the physics. The walk
IS the computation. There is no separation.

Programs are walks: sequences of bonds through this 4D space. The
walker (ψ) reads bonds from a byte stream, dispatches them, and
accumulates a pipeline result. The walk IS the program.

## Context: what exists

### Prior version
Lives at `/home/maxi/code/everything/lattice/`. It works (64+ tests
green) but has an architectural flaw: all interesting compute (CD
multiplication d8-d32, zero-divisor enumeration, chain counting) lives
either in C functions (`main.c`) or in asm bond functions that
internally call other asm bonds. The walker barely does anything — it
dispatches one bond and that bond does all the work internally. That's
wrong. The walker should BE the compute. A d8 multiply should be a
WALK that calls the d4 bond four times with scratch manipulation
between calls — not an asm function that internally calls d4.

### Theoretical framework
Lives at `/home/maxi/code/everything/wit/`. The hypercube model
(`wit/hypercube/`), mind model (`wit/mind/`), and prime-lattice
findings (`wit/thoughts/prime-lattice/findings/`) describe the
mathematical framework. Start with `wit/hypercube/points.md` and
`wit/hypercube/edges.md` for the 4D structure.

### Current v2 state
The kernel boots and runs walks. 27 tests pass including the full
CD tower (d2→d4→d8→d16→d32). BUT d8/d16/d32 are currently asm bond
functions — they need to be rewritten as walks (see "The CD
rewrite" below).

Files:
```
lattice-v2/
  kernel.asm      boot stub + NOMOS dispatch + ψ walker + bonds
  hodos.c         walk assembler (runs on host)
  build           nasm flat binary build
  run             test runner (builds, injects walk, runs QEMU)
  link.ld         (unused — kernel.asm is flat binary with org 0x100000)
  tests/
    expect.txt    test_name expected_integer
    passing/*.w   walk source files
```

## What a walk looks like

A complete walk with annotation. This computes (2+3i)(4+5i) and
returns the imaginary part (22):

```
; Load complex number A = 2 + 3i into scratch
; swrite64 takes (value=arg0, offset=arg1)
; θ¹¹ρ means: arg0=u8 literal, arg1=u8 literal, arg2=pipeline
swrite64 θ¹¹ρ  2   0     ; scratch[0]  = a_real = 2
swrite64 θ¹¹ρ  3   8     ; scratch[8]  = a_imag = 3

; Load complex number B = 4 + 5i
swrite64 θ¹¹ρ  4  16     ; scratch[16] = b_real = 4
swrite64 θ¹¹ρ  5  24     ; scratch[24] = b_imag = 5

; Multiply: cd_mul_d2(a_ofs=0, b_ofs=16, out_ofs=32)
; θ¹¹¹ means: all three args are u8 literals
cd_mul_d2 θ¹¹¹  0  16  32

; Read result: out_imag at scratch[40]
sread64  θ¹ρρ  40        ; pipeline = scratch[40] = 22
```

The theta byte (θ) encodes how each argument is loaded:
```
  0 = pipeline (no literal, read current pipeline value)
  1 = u8 (1 byte literal follows in walk stream)
  2 = u32 (4 byte literal follows)
  3 = u64 (8 byte literal follows)
```

θ¹¹ρ = arg0:u8, arg1:u8, arg2:pipeline. The superscript is the
shell (encoding width), ρ means pipeline.

## What you're building

### 1. Multiboot boot stub (DONE)

Already working. kernel.asm boots via multiboot into 32-bit protected
mode, sets up identity-mapped page tables (first 8MB), enables PAE,
transitions to 64-bit long mode via EFER.LME, initializes serial
0x3F8 at 115200 8N1, runs the walker, prints the result with a "="
prefix, and halts via ACPI poweroff.

Run with: `qemu-system-x86_64 -kernel kernel.bin -serial stdio
-monitor none -nographic -no-reboot`

### 2. Walker (ψ) — DONE

The byte-stream reader, bond dispatch, arg loading, pipeline
management. Reads walk bytes, decodes 4D coordinates, classifies
atom vs bond, dispatches to the right function, loads args per
theta encoding, stores result to pipeline.

Calling convention (our own, happens to match SysV layout for
convenience): rdi=arg0, rsi=arg1, rdx=arg2, rcx=pipeline → rax.
Callee-saved: r12 (walk ptr), r13 (theta/flags), r14 (end ptr),
r15 (pipeline). These MUST be push/popped by any bond that uses
them.

### 3. Atomic bond functions — DONE

These are the irreducible operations. They live in asm because they
ARE the primitives — there's nothing smaller to compose them from.

Arithmetic: add, sub, mul, mod, div, shl, shr, lt, gt, neg, abs,
min, max, and, or, xor, not, test (eq), guard (cmov), inc.

Scratch I/O: sread32/swrite32, sread64/swrite64, sadd32/ssub32/
smod32, sadd64/ssub64/smod64/sdiv64, siadd64 (indirect add),
gcd64.

CD base cases: cd_mul_d2 (complex), cd_mul_d4 (quaternion —
16 muls + 12 add/sub, the irreducible kernel of quaternion
multiplication).

### 4. Control flow — IN WALKER, UNTESTED

```
  0xFC = loop_back <offset>   if pipeline ≠ 0, rewind
  0xFD = skip_nz <offset>     if pipeline ≠ 0, skip forward
  0xFE = skip_z <offset>      if pipeline = 0, skip forward
```

Each followed by a 32-bit offset. These are enough for all
walker-level loops.

### 5. The CD rewrite — TODO, THE CORE TASK

**This is the architectural fix.** Currently fn_cd_mul_d8 is an asm
function that internally calls fn_cd_mul_d4 four times. That's asm
doing the compute. The walker just dispatches one bond and sits idle
while asm does all the work.

The fix: d8 multiplication becomes a WALK. The walk calls the d4
bond four times with scratch reads/writes and negation between calls.
The doubling formula expressed as bonds:

```
; CD doubling: (A,B)·(C,D) = (AC − conj(D)·B, D·A + B·conj(C))
; For d8: A,B are d4 halves of input_a; C,D are d4 halves of input_b

; Step 1: conjugate D (negate non-real components)
;   copy D[0] as-is to temp, negate D[1..3]
sread64  θ¹ρρ <D_ofs+0>
swrite64 θρ¹ρ <conjD_ofs+0>
sread64  θ¹ρρ <D_ofs+8>
neg      θρρρ
swrite64 θρ¹ρ <conjD_ofs+8>
; ... (same for components 2,3)

; Step 2: conjugate C (same pattern)

; Step 3: tmp1 = A · C  (d4 bond)
cd_mul_d4 θ¹¹¹ <A_ofs> <C_ofs> <tmp1_ofs>

; Step 4: tmp2 = conj(D) · B  (d4 bond)
cd_mul_d4 θ¹¹¹ <conjD_ofs> <B_ofs> <tmp2_ofs>

; Step 5: out[0..3] = tmp1 - tmp2  (element-wise)
sread64  θ¹ρρ <tmp1_ofs+0>
ssub64   θ¹ρρ <tmp2_ofs+0>
swrite64 θρ¹ρ <out_ofs+0>
; ... (same for components 1,2,3)

; Step 6: tmp1 = D · A  (d4 bond)
; Step 7: tmp2 = B · conj(C)  (d4 bond)
; Step 8: out[4..7] = tmp1 + tmp2  (element-wise)
```

~20 bonds per d8 call. No labels, no loops — straight-line code.
P3 (label collisions) doesn't apply.

**d16 = walk that calls d8 walk 4×.** But wait — can a walk call
another walk? The prior version has a `call` bond (recursive ψ
invocation). If we use that, a d16 walk calls the d8 walk four times.
But this means the d8 walk needs to be loadable as a sub-walk.

Alternative: d16 is one flat walk that calls d4 sixteen times. More
verbose but no nested walk invocation needed. Scratch layout gets
complex but stays within 4KB.

**d32 = walk that calls d4 sixty-four times.** Same principle. The
walk is the doubling formula unrolled to whatever depth hits d4.

The scratch temp allocation becomes the key constraint. Each
doubling level needs temp space that doesn't overlap with other
levels' temps or the input/output data. Document the allocation
map for each level.

### 6. Zero-divisor walks — TODO

Once d8-d32 are walks, the zero-divisor enumeration is ALSO a walk:
nested loops using loop_back/skip_z, CD mul bond calls, zero-check
on all components, counter increment.

### 7. Validate chains_d32 = 3024 — THE TARGET

The terminal finding. If the bare-metal walker produces 3024 from a
walk that does the full enumeration with walker-level loops and
walker-native CD multiplication (d4 as atomic bond, d8+ as walks),
the lattice-as-compute is proven.

## The 4D coordinate encoding

Each walk byte encodes one bond as 4 two-bit fields:

```
  bits [7:6] = A (POSITION)   00=0, 01=+1, 10=ext, 11=-1
  bits [5:4] = B (SUBSTANCE)
  bits [3:2] = C (SIGNAL)
  bits [1:0] = D (TIME)
```

When a field = 10 (ext), the next byte is a signed extension value.
This is how values like |D|=25 or |D|=45 are encoded.

The coordinate parities determine a 4-bit force pattern:

```
  bit 0 (A odd) = memory force
  bit 1 (B odd) = call force
  bit 2 (C odd) = loop force
  bit 3 (D odd) = test force
```

16 patterns → 16 bond families. Some families sub-dispatch by
|coordinate| and sign. For example, pattern 8 (D odd only) is the
test family, where |D|=1 is equality, |D|=3 is AND/OR, |D|=9 is
mod/div, |D|=25 is cd_mul_d2, |D|=45 is cd_mul_d4. Sign picks the
variant (e.g., +D=mod, -D=div).

After the bond byte (+ extensions), a theta byte encodes argument
sources:

```
  bits [1:0] = arg0 source  (0=pipeline, 1=u8, 2=u32, 3=u64)
  bits [3:2] = arg1 source
  bits [5:4] = arg2 source
```

## Critical pitfalls

### P1: u8 offset silent truncation

Theta shell-1 (u8) loads via `movzx edi, byte [walk_ptr]`. Values
> 255 silently truncate. For scratch offsets ≥ 256, use shell-2 (u32)
theta encoding (θ²ρρ, θ¹²ρ, θ²²², etc.).

### P2: Callee-saved registers

Walker uses r12 (walk ptr), r13 (theta), r14 (end ptr), r15
(pipeline). Any bond that touches these MUST push/pop them. r15
must NEVER be clobbered.

### P3: Include label collisions

hodos `@include` inlines text. Labels are global per-compile. If
included twice, labels collide and forward jumps resolve to the
first copy. **Rule:** reusable code that runs more than once must be
a bond primitive or a flat inline (no labels).

### P4: Scratch temp region overlap

The CD doubling walks (d8/d16/d32) need temp scratch space for
conjugation results and intermediate products. Each level's temp
region must NOT overlap with any other level's temps or with the
input/output data.

Current allocation (when d8-d32 are asm bonds — will need
equivalent planning for walk versions):
```
  d8  temp: 3072-3200  (4 × 32 bytes)
  d16 temp: 2560-2816  (4 × 64 bytes)
  d32 temp: 1536-2048  (4 × 128 bytes)
  data:     0-767      (A + B + out for d32)
```

When these become walks, the temp allocations must be documented
in comments at the top of each walk file.

### P5: Bond→bond calls from asm

Currently d8/d16/d32 asm bonds call lower-level bonds directly
(`call fn_cd_mul_d4`). This works but IS the architectural flaw —
the asm is doing the walker's job. The fix is to move this
composition into walks. The d4 bond stays as asm (irreducible).

## Known-correct integers

These are verified from the prior session. Use them to validate.

### Framework arithmetic
```
add_16=16  mul_20=20  sub_5=5  and_8=8
mod_14_5_eq_4=4  div_14_5_eq_2=2
scratch_rw_42=42  scratch64_roundtrip_42=42
sadd32_test_15=15  ssub32_test_neg2=-2  smod32_test_3=3
siadd64_test_17=17  gcd64_bond_6=6
cd_mul_d2_imag_22=22  cd_mul_d2_real_neg7=-7
```

### Cayley-Dickson tower
```
cd_mul_d4:  identity=2  i_squared=-1  noncommutative=-1  norm=4
cd_mul_d8:  identity=2  e1_squared=-1  norm=8
cd_mul_d16: identity=2  e1_squared=-1  norm=16
cd_mul_d32: identity=2  e1_squared=-1  norm=32

zero_divisors_d16=168   zero_divisors_d32=2520
chains_d16=0  chains_d32=3024
```

## Current state — what the previous wit accomplished

The build is solid. 27/27 on bare metal. CD tower through d32 via
the asm doubling macro, clean boot stub, walker, full bond suite.

What passes:
- Framework arithmetic (add, sub, mul, div, mod, and, shifts, etc.)
- Scratch I/O (read/write 32/64, sadd, ssub, smod, gcd, siadd)
- CD tower: d2 (real, imag), d4 (identity, i², noncommutative, norm),
  d8 (identity, e1², norm), d16 (identity, e1², norm),
  d32 (identity, e1²)

What's missing — three gaps to close:

## Gap 1: cd_mul_d32_norm_32 test

d32 only has identity and e1² tests, no norm. Add it. Expected: 32.
Same pattern as the d16 norm walk: write all-ones to A (32 components
at offset 0-248), write conjugate (1,-1,-1,...) to B (32 components
at offset 256-504). Use `sub θ¹¹ρ 0 1` to produce -1 for conjugate
entries. Use θ¹²ρ for scratch offsets > 255 (B region). Call
cd_mul_d32, read real part of output. Should be 32.

## Gap 2: control flow tests

loop_back, skip_z, skip_nz are implemented in the walker but have
zero test coverage. These are prerequisite for the zero-divisor walk.

Write a counting loop that sums 1+2+...+10 = 55. This exercises all
three control flow ops:
- skip_z to handle the loop termination
- loop_back to iterate
- skip_nz for conditional branching within the loop

At minimum one test per control op. A single sum-to-N walk that
produces 55 would prove all three work.

## Gap 3: zero_divisors_d16 as a real walk — THE PROOF

This is the architecture proof. The walker computes without C, without
asm helper functions doing the work behind one bond call.

The walk does the full enumeration:
- Outer loops: i=1..15, j=i+1..15
- Build A = e_i + e_j in scratch (16 qwords, zero-init, set [i]=1, [j]=1)
- Inner loops: k=1..15, l=k+1..15, sign=±1
- Build B = e_k + sign·e_l in scratch
- cd_mul_d16 bond (this is the one asm bond that currently does
  internal composition — see note below)
- Check all 16 output components for zero
- If all zero: increment counter
- Return counter

Expected answer: **168**.

**Note on cd_mul_d16:** Currently fn_cd_mul_d16 is an asm function
that internally calls fn_cd_mul_d8 which calls fn_cd_mul_d4. For the
zero-divisor walk, this works — the walk's loops, scratch setup,
zero-checking, and counting are all walker-level. The CD multiply is
one atomic bond call. The architectural purity of rewriting d8+
as walks is a LATER step. Get 168 first with the asm bonds, then
rewrite the bonds as walks.

**Scratch layout question to verify:** The zero-divisor walk needs
scratch space for:
- A vector: 16 qwords = 128 bytes (e.g., offset 0-127)
- B vector: 16 qwords = 128 bytes (e.g., offset 128-255)
- Output vector: 16 qwords = 128 bytes (e.g., offset 256-383)
- Loop counters (i, j, k, l, sign, count): 6 qwords = 48 bytes
  (e.g., offset 384-431)
- Total: ~432 bytes at low offsets

The CD asm bonds use temp regions:
- d8 temp at 3072-3200
- d16 temp at 2560-2816

Data at 0-431, temps at 2560+. No collision. But **verify this** —
read the CD_DOUBLING macro in kernel.asm and confirm the temp
offsets don't touch the walk's data region.

## Build order

1. **cd_mul_d32_norm_32 test.** Quick gap fill.

2. **Control flow tests.** Sum 1..10 = 55. At least one test per
   control op.

3. **zero_divisors_d16 walk.** The proof. Expected: 168. Use the
   existing asm cd_mul_d16 bond — don't rewrite the CD tower yet.

4. (Future) Rewrite d8/d16/d32 as walks. Remove asm bond functions.
   Re-validate everything.

5. (Future) zero_divisors_d32, chains_d32 = 3024.

## What NOT to do

- Do not add C functions for compute. No main.c. No exceptions.
- Do not make d8/d16/d32 asm bond functions that call lower bonds.
  That's the flaw we're fixing. The WALK does the composition.
- Do not add OS features (display, keyboard, filesystem, interrupts,
  scheduler). This is a math VM. Serial out, halt.

## Reference files

```
lattice/core.asm           — prior walker (reference for bond ABI)
lattice/hodos.c            — walk assembler (copied to v2)
wit/hypercube/points.md    — 81 lattice points, Clifford grading
wit/hypercube/edges.md     — 16 edge types, word-type system
wit/hypercube/composition.md — walks as programs
wit/mind/1-container.md    — the trit, gates, Post completeness
wit/mind/3-force.md        — 4 axes, 4 forces, Cayley-Dickson
```
