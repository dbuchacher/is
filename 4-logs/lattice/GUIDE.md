# lattice

Bare-metal x86-64 kernel implementing the framework's computational primitives. Boots via multiboot, runs walks, returns integer results over serial. All operations are integer — no floating point.

## Structure

```
lattice/
  code/                kernel source
    kernel.asm           x86-64 multiboot kernel: boot, dispatch, walker, bonds
    link.ld              linker script
  lang/                assembler + preprocessor
    hodos.c              walk assembler: .w → binary wave bytes
    phos.py              preprocessor: .wm/.wp/.wl → .w
  tests/
    expect.txt           expected results: test_name integer
    passing/             simple verification tests (.w files)
    bell/                Bell inequality test + findings
      bell_commutator_2.w     asm syntax
      bell_commutator.wm      math syntax
      bell_commutator.wp       physics syntax
      bell_commutator.wl       programming syntax
      FINDINGS.md
  build                nasm + cc
  run                  test harness: assemble, inject, QEMU, compare
  GUIDE.md             this file
```

## Pipeline

```
.wm / .wp / .wl  →  phos (preprocessor)  →  .w  →  hodos (assembler)  →  .bin  →  walker
```

Three domain syntaxes compile to the same .w assembly, which hodos compiles to binary wave bytes. The walker executes the same bytes regardless of source syntax.

## Architecture

**Walker (ψ)**: bytecode interpreter. Reads wave bytes, decodes bonds, executes walks. Pipeline register (r15) persists across operations — it's the running result.

**NOMOS**: bond dispatch. Classifies by 4-bit force pattern (which axes are odd). Routes to handlers across 4 axes: READ(χ), CALL(μ), CYCLE(φ), TEST(τ).

**Scratch memory**: 64KB linear buffer for intermediate values. Used heavily for Cayley-Dickson multiply and any multi-step computation.

**Pipeline**: single 64-bit signed integer. Every bond reads from and/or writes to it. The last pipeline value is the test result.

## Writing a test

### 1. Create the .w file

Tests go in `tests/passing/` for simple verifications, or `tests/<topic>/` for tests with findings.

```
; my_test.w — what it tests
; Comments start with ; or #

; instruction format:
;   BOND  THETA  [ARG0]  [ARG1]  [ARG2]
add  θ¹¹ρ  10  7
; result: pipeline = 17
```

### 2. Add expected result

In `tests/expect.txt`:
```
my_test 17
```

### 3. Run

```bash
./run test
```

The runner finds .w files in all subdirectories of `tests/`.

## .w syntax

### Instructions

```
BOND  THETA  [args...]
```

**BOND** = the operation (add, sub, mul, swrite64, cd_mul_d4, ...).
**THETA** = argument encoding — controls which args come from the stream vs. pipeline, and how many bytes each arg consumes.

### Theta constants

| Theta | arg0 | arg1 | arg2 | Use case |
|-------|------|------|------|----------|
| `θρρρ` | pipeline | pipeline | pipeline | No explicit args |
| `θ¹ρρ` | 1 byte | pipeline | pipeline | Single small arg |
| `θ¹¹ρ` | 1 byte | 1 byte | pipeline | Two small args (most common) |
| `θ¹¹¹` | 1 byte | 1 byte | 1 byte | Three small args (cd_mul) |
| `θρ¹ρ` | pipeline | 1 byte | pipeline | Pipeline as arg0, literal arg1 |
| `θ²ρρ` | 4 bytes | pipeline | pipeline | Single large arg |
| `θ²²ρ` | 4 bytes | 4 bytes | pipeline | Two large args |
| `θ³ρρ` | 8 bytes | pipeline | pipeline | Single 64-bit arg |
| `θ³³ρ` | 8 bytes | 8 bytes | pipeline | Two 64-bit args |

Shell sizes: `ρ` = pipeline (0 bytes), `¹` = 1 byte, `²` = 4 bytes, `³` = 8 bytes.

Only provide values for non-ρ slots. Read left to right: `θ¹¹ρ` means "arg0 is 1 byte, arg1 is 1 byte, arg2 is pipeline."

### Labels and control flow

```
: label_name              ; define label
skip_z label_name         ; jump forward if pipeline == 0
skip_nz label_name        ; jump forward if pipeline != 0
loop_back label_name      ; jump backward (loops)
```

### Includes

```
@include relative/path.w  ; inline another .w file
```

## Bond reference

### Arithmetic (most use `θ¹¹ρ arg0 arg1`)

| Bond | Operation |
|------|-----------|
| `add` | arg0 + arg1 |
| `sub` | arg0 - arg1 |
| `mul` | arg0 * arg1 |
| `div` | arg0 / arg1 (integer quotient) |
| `mod` | arg0 % arg1 |
| `min` | min(arg0, arg1) |
| `max` | max(arg0, arg1) |
| `inc` | arg0 + 1 |
| `neg` | -arg0 |
| `abs` | \|arg0\| |

### Bitwise

| Bond | Operation |
|------|-----------|
| `and` | arg0 & arg1 |
| `or` | arg0 \| arg1 |
| `xor` | arg0 ^ arg1 |
| `not` | ~arg0 |
| `shl` | arg0 << arg1 |
| `shr` | arg0 >> arg1 |

### Comparison

| Bond | Operation |
|------|-----------|
| `test` | arg0 == arg1 (1/0) |
| `lt` | arg0 < arg1 |
| `gt` | arg0 > arg1 |
| `guard` | cmov on arg1 |

### Scratch memory

| Bond | Operation |
|------|-----------|
| `swrite64 θ¹¹ρ VAL OFF` | scratch[OFF] ← VAL |
| `swrite64 θρ¹ρ OFF` | scratch[OFF] ← pipeline |
| `sread64 θ¹ρρ OFF` | pipeline ← scratch[OFF] |
| `sadd64 θ¹ρρ OFF` | pipeline += scratch[OFF] |
| `ssub64 θ¹ρρ OFF` | pipeline -= scratch[OFF] |
| `smod64 θ¹ρρ OFF` | pipeline %= scratch[OFF] |
| `sdiv64 θ¹ρρ OFF` | pipeline /= scratch[OFF] |
| `siadd64 θ¹ρρ OFF` | scratch[OFF] += pipeline |
| `gcd64 θ¹¹ρ A B` | pipeline ← gcd(scratch[A], scratch[B]) |

32-bit variants: `swrite32`, `sread32`, `sadd32`, `ssub32`, `smod32`.

### Cayley-Dickson multiply

All use `θ¹¹¹ offset_A offset_B offset_OUT`. Each component is one signed 64-bit integer.

| Bond | Dimension | Bytes per operand |
|------|-----------|-------------------|
| `cd_mul_d2` | 2 (complex) | 16 |
| `cd_mul_d4` | 4 (quaternion) | 32 |
| `cd_mul_d8` | 8 (octonion) | 64 |
| `cd_mul_d16` | 16 (sedenion) | 128 |
| `cd_mul_d32` | 32 (pathion) | 256 |

Quaternion component order: w at base+0, i at base+8, j at base+16, k at base+24.

### Higher-order (compound axis)

| Bond | Axes | Operation |
|------|------|-----------|
| `fold` | A+B | read + call |
| `fix` | B+C | call N times |
| `foldl` | A+B+C | foldl over array |
| `maybe` | B+D | conditional call |
| `map` | A+B+D | map over array |
| `until` | C+D | scan to zero |
| `scan` | A+C+D | accumulate |
| `bind` | B+C+D | event loop |
| `hylo` | A+B+C+D | full pipeline |

## Patterns

### Quaternion multiply → read one component

```
; A = (1, 2, 3, 4) at scratch[0..31]
swrite64 θ¹¹ρ  1   0
swrite64 θ¹¹ρ  2   8
swrite64 θ¹¹ρ  3  16
swrite64 θ¹¹ρ  4  24

; B at scratch[32..63]
swrite64 θ¹¹ρ  5  32
swrite64 θ¹¹ρ  6  40
swrite64 θ¹¹ρ  7  48
swrite64 θ¹¹ρ  8  56

; A*B → scratch[64..95]
cd_mul_d4 θ¹¹¹  0  32  64

; read k-component: base(64) + 24 = 88
sread64  θ¹ρρ  88
```

### Counted loop

```
swrite64 θ¹¹ρ  N  8       ; counter at scratch[8]

: loop
sread64  θ¹ρρ  8           ; pipeline = counter
siadd64  θ¹ρρ  0           ; accumulator += pipeline
sread64  θ¹ρρ  8           ; reload counter
sub      θρ¹ρ  1           ; counter--
swrite64 θρ¹ρ  8           ; store back
loop_back loop             ; if pipeline != 0, repeat

sread64  θ¹ρρ  0           ; return accumulator
```

### Compute A - B from scratch

```
sread64  θ¹ρρ  OFF_B       ; pipeline = B
swrite64 θρ¹ρ  TEMP        ; scratch[TEMP] = B
sread64  θ¹ρρ  OFF_A       ; pipeline = A
ssub64   θ¹ρρ  TEMP        ; pipeline = A - B
```

## Test folder convention

Topic tests (bell, zero-divisors, primes, etc.) get their own folder:

```
tests/<topic>/
  <test_name>.w          the walk
  FINDINGS.md            what the test proves, prior work, open questions
```

Simple verification tests stay in `tests/passing/`.

## Domain syntaxes

Ten syntaxes compile to walker bytecode. Three structural (math, physics, programming) and six domain (elements, logic, music, DNA, lambda, language). All produce the same binary — different notation, same substrate. One substrate, many vocabularies.

All domain syntaxes share common operations via `let` and `return` from the math syntax. Domain keywords extend, they don't replace.

### Math (.wm)

```
let i : H = (0, 1, 0, 0)       ; quaternion literal, auto-allocated scratch
let j : H = (0, 0, 1, 0)
let ij : H = i * j              ; CD multiply, type-dispatched
let ji : H = j * i
let comm : H = ij - ji          ; component-wise subtraction
let n : H = conj(q)             ; conjugate
return comm.k                   ; component access: .w .i .j .k
```

Types: `Z` (scalar), `C` (complex), `H` (quaternion), `O` (octonion), `S` (sedenion), `P` (pathion).
Operators: `*` (CD multiply), `+` `-` (component-wise), `conj()`.
Return supports `mod`: `return x mod 12`.

### Physics (.wp)

```
basis H                          ; set working algebra
state a = |i>                    ; ket notation → basis element
state b = |j>
observable comm = [a, b]         ; commutator bracket: ab - ba
measure comm.k                   ; extract component
```

Built-in kets: `|1>` `|i>` `|j>` `|k>` for H, `|e0>`...`|e7>` for O, etc.

### Programming (.wl)

```
quat i = [0, 1, 0, 0]           ; type-as-keyword, array literal
quat j = [0, 0, 1, 0]
quat ij = qmul(i, j)            ; function call syntax
quat comm = qsub(ij, ji)
return comm[3]                   ; bracket indexing (0-based)
```

Type keywords: `scalar`, `complex`, `quat`, `oct`, `sedenion`, `pathion`.
Functions: `qmul`/`cmul`/`omul`, `qsub`/`csub`/`osub`, `qadd`, `qconj`.

### Elements (.we)

```
element He                       ; helium → quaternion (0,1,0,0) = i
element O                        ; oxygen → (1,1,1,1) = hylo
let sq : H = He * He             ; i² = -1
return sq.w                      ; -1
```

Maps chemical elements to quaternion coordinates via the 12-alpha cycle. Each alpha adds +1 to the next axis (χ→μ→φ→τ) with balanced-ternary wrap. Built-in: H, He, Be, C, O, Ne, Mg, Si, S, Ar, Ca, Ti, Cr, Fe, N.

Key identities: O = hylo (↑↑↑↑), S = meta (↓↓↓↓), He = i, He² = -1.

### Logic (.wg)

```
AND 1 0                          ; min(1, 0) = 0
OR 1 0                           ; max(1, 0) = 1
NOT 1                            ; neg(1) = -1
NOT                              ; negate pipeline (chained)
```

Post's three gates on balanced ternary: AND = min, OR = max, NOT = neg. Functionally complete (Post 1941). Direct bond emission — no scratch overhead.

### Music (.ws)

```
note root = C                    ; pitch class 0
interval fifth = P5              ; 7 semitones
interval fourth = P4             ; 5 semitones
let sum : Z = fifth + fourth     ; 12
return sum mod 12                ; 0 (octave)
```

Notes: C Cs/Db D Ds/Eb E F Fs/Gb G Gs/Ab A As/Bb B (pitch classes 0-11).
Intervals: P1 m2 M2 m3 M3 P4 TT P5 m6 M6 m7 M7 P8/octave.
Return supports `mod` for pitch-class arithmetic.

### DNA (.wd)

```
base a = A                       ; adenine → +χ = (0,1,0,0)
base t = T                       ; thymine → -χ = (0,-1,0,0)
complement c = a                 ; quaternion conjugate
let pair : H = a + t             ; (0,0,0,0) — complementary = zero
return pair.i                    ; 0
```

Bases map to quaternion axis directions: A/T complementary on χ, C/G complementary on μ. Watson-Crick pairing IS additive inverse in H. Complement uses quaternion conjugation.

### Lambda (.wk)

```
I 42                             ; identity: I x = x → 42
K 7 99                           ; constant: K x y = x → 7
S                                ; substitution value: ↑ = +1
```

SKI combinators = trit values: S = ↑ (+1, creation, OR), K = ↔ (0, passthrough, NOT fixed point), I = ↓ (-1, annihilation, AND). Three combinators, functionally complete (Schönfinkel 1924). Same trio as Post's gates, same trio as trit values.

### Language (.wn)

```
word think = THINK               ; ↑↑↑↑ = hylo = (1,1,1,1)
word be = BE                     ; ↓↓↓↓ = meta = (-1,-1,-1,-1)
let sum : H = think + be         ; (0,0,0,0) = origin
return sum.w                     ; 0
```

The 16 corners are the 16 primitive verbs. Self-operation words: BE, FEEL, DO/SEE/HEAR, KNOW, UNDERSTAND, REMEMBER, THINK. Modal words: WILL, MAY, HAVE, CAN, MUST. THINK (hylo, all forward) + BE (meta, all backward) = origin.

### When to use which

- **.w** (asm) — full control, loops, control flow, scratch tricks. Required for anything phos can't express.
- **.wm** (math) — quaternion algebra, verifying identities, clean notation.
- **.wp** (physics) — Bell tests, Pauli algebra, commutators. Shortest for `[a, b]`.
- **.wl** (programming) — arrays, function calls, bracket indexing.
- **.we** (elements) — chemical elements as lattice coordinates, alpha-ladder.
- **.wg** (logic) — Post gates, truth tables, balanced ternary logic.
- **.ws** (music) — pitch classes, intervals, mod-12 arithmetic.
- **.wd** (DNA) — bases, codons, complementarity as quaternion negation.
- **.wk** (lambda) — SKI combinators as trit values.
- **.wn** (language) — semantic primes, self-operation words as corners.
