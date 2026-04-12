; core.asm — the lattice equation (∏) + wave walker (ψ)
;
; Extracted from prior/VoE/code/legacy/x86.asm sections 3+4.
; OS-level scaffolding stripped: no boot, no paging, no AP wake, no
; find-work scheduler. Hardware I/O bonds (port in/out, MSR, CPUID,
; rep insd) stubbed to xor eax,eax;ret so dispatch still routes but
; they no-op in userspace.
;
; C entry points (SysV x86-64 ABI):
;   extern uint64_t walk_run(const uint8_t *walk, int len);
;   extern uint64_t rho;    ; last result (pipeline snapshot)
;
; Internal bond ABI: rdi=arg0 rsi=arg1 rdx=arg2 rcx=pipeline → rax.
; Happens to match SysV for the first 4 integer args, so C ↔ asm is
; direct with no wrapper needed.
;
; Axis order (per wit/mind/3-force.md canonical naming):
;   first arg  = A = WHERE = POSITION = space   → force: memory  (bit 0)
;   second arg = B = WHAT  = SUBSTANCE = matter → force: call    (bit 1)
;   third arg  = C = WHICH = SIGNAL = signal    → force: loop    (bit 2)
;   fourth arg = D = WHEN  = TIME = time        → force: test    (bit 3)
;
; VoE called these τ χ μ φ (time / distance / mass / charge) — same
; bit positions, different labels. The bit→force assignments were
; already framework-correct; VoE just used physics-era axis names.
; Relabeled here to match the canonical 3-force.md order (space first,
; time last).
;
; Classification: all coords even → atom (∏: Aᵃ·Bᵇ·Cᶜ·Dᵈ)
;                 any coord odd   → bond (dispatch to fn_*)

[bits 64]
default rel

; ── C-side globals (main.c) used by fn_is_prime_bit ──
extern sieve_bits_ptr            ; uint8_t * (may be NULL before ensure_sieve)
extern sieve_max                 ; const uint64_t (SIEVE_MAX from main.c)

; ── C-side parallel phase 1 (main.c) called from fn_shell_phase1_c ──
extern shell_phase1_compute      ; void(uint32_t N, uint32_t x_N, uint64_t *A_out, uint64_t *pi_out)

; ══════════════════════════════════════════════════════════════
; DATA
; ══════════════════════════════════════════════════════════════

section .data
align 8

global rho
global ρ
rho:
ρ: dq 0

; ──────────────────────────────────────────────────────────────
; walk_scratch — 4KB zero-initialized buffer walks can read/write
; ──────────────────────────────────────────────────────────────
;
; Exposed via sread32 / swrite32 bonds. Walks address slots by u8 or
; u32 offset (0, 4, 8, ...). Aligned 64 (cache line). Not preserved
; across walk invocations — each test assumes it's the only user and
; initializes what it needs before reading.

section .bss
align 64
global walk_scratch
walk_scratch: resb 4096


; ══════════════════════════════════════════════════════════════
; NOMOS — bond dispatch
; ══════════════════════════════════════════════════════════════

section .text

; bond_dispatch — resolve bond coordinates to static function
;
; edi=A, esi=B, edx=C, ecx=D → rax = function pointer
; Only called for bonds (any coordinate odd).
;
; Axis→force mapping per wit/mind/3-force.md:
;   A (WHERE, space)  odd → memory force (bit 0)  (strong, MOV)
;   B (WHAT,  matter) odd → call   force (bit 1)  (EM)
;   C (WHICH, signal) odd → loop   force (bit 2)  (gravity/cycle)
;   D (WHEN,  time)   odd → test   force (bit 3)  (weak, CMP/Jcc)

bond_dispatch:
    xor eax, eax
    test edi, 1                            ; A odd → memory bit
    jz .no_mem
    or eax, 1
.no_mem:
    test esi, 1                            ; B odd → call bit
    jz .no_call
    or eax, 2
.no_call:
    test edx, 1                            ; C odd → loop bit
    jz .no_loop
    or eax, 4
.no_loop:
    test ecx, 1                            ; D odd → test bit
    jz .no_test
    or eax, 8
.no_test:
    ; eax = pattern (0-15)
    cmp eax, 1
    je .dispatch_read
    cmp eax, 5
    je .dispatch_copy
    cmp eax, 8
    je .dispatch_test
    cmp eax, 9
    je .dispatch_filter
    cmp eax, 13
    je .dispatch_scan
    cmp eax, 2
    je .dispatch_call
    cmp eax, 4
    je .dispatch_loop

    ; Table-lookup dispatch through the active width-table.
    ; main.c picks bond_fn_table_{scalar,xmm,ymm,zmm} at startup based on
    ; CPU capabilities. Sub-dispatched bonds (read/write/test/filter/
    ; scan/call/loop) still use direct `lea [fn_xyz]` below — they stay
    ; scalar until we refactor them out of sub-dispatch.
    mov rdx, [rel bond_fn_table_active]
    mov rax, [rdx + rax*8]
    ret

    ; ── ∘ call/curry variants ──
.dispatch_call:
    test esi, esi
    js .d_curry
    lea rax, [fn_call]
    ret
.d_curry:
    lea rax, [fn_curry]
    ret

    ; ── ∮ drain/increment variants ──
.dispatch_loop:
    test edx, edx
    js .d_inc
    lea rax, [fn_loop]
    ret
.d_inc:
    lea rax, [fn_inc]
    ret

    ; ── π read/write variants ──
.dispatch_read:
    test edi, edi
    js .d_write
    cmp edi, 3
    je .d_read_byte
    cmp edi, 5
    je .d_read_word
    cmp edi, 7
    je .d_read_dword
    lea rax, [fn_read_qword]
    ret
.d_read_byte:
    lea rax, [fn_read_byte]
    ret
.d_read_word:
    lea rax, [fn_read_word]
    ret
.d_read_dword:
    lea rax, [fn_read_dword]
    ret
.d_write:
    mov eax, edi
    neg eax
    cmp eax, 3
    je .d_write_byte
    cmp eax, 5
    je .d_write_word
    cmp eax, 7
    je .d_write_dword
    lea rax, [fn_write_qword]
    ret
.d_write_byte:
    lea rax, [fn_write_byte]
    ret
.d_write_word:
    lea rax, [fn_write_word]
    ret
.d_write_dword:
    lea rax, [fn_write_dword]
    ret

    ; ── π∮ copy/fill variants ──
.dispatch_copy:
    test edi, edi
    js .d_fill
    mov eax, edx
    test eax, eax
    jns .d_copy_fwd
    neg eax
.d_copy_fwd:
    cmp eax, 5
    jge .d_copy_q
    cmp eax, 3
    jge .d_copy_d
    lea rax, [fn_copy_byte]
    ret
.d_copy_d:
    lea rax, [fn_copy_dword]
    ret
.d_copy_q:
    lea rax, [fn_copy_qword]
    ret
.d_fill:
    mov eax, edx
    neg eax
    cmp eax, 5
    jge .d_fill_q
    cmp eax, 3
    jge .d_fill_d
    lea rax, [fn_fill_byte]
    ret
.d_fill_d:
    lea rax, [fn_fill_dword]
    ret
.d_fill_q:
    lea rax, [fn_fill_qword]
    ret

    ; ── test-gate family (D axis, |D| picks the variant) ──
.dispatch_test:
    mov eax, ecx
    mov r8d, eax
    test eax, eax
    jns .d_test_abs
    neg eax
.d_test_abs:
    cmp eax, 1
    je .d_eq
    cmp eax, 3
    je .d_and
    cmp eax, 5
    je .d_xor
    cmp eax, 7
    je .d_shl
    cmp eax, 9
    je .d_mod
    cmp eax, 11
    je .d_lt
    cmp eax, 13
    je .d_neg
    cmp eax, 15
    je .d_scratch
    cmp eax, 17
    je .d_sadd
    cmp eax, 19
    je .d_smod
    cmp eax, 21
    je .d_scratch64
    cmp eax, 23
    je .d_sadd64
    cmp eax, 25
    je .d_cdmul_d2
    cmp eax, 35
    je .d_smoddiv64
    cmp eax, 37
    je .d_gcd64
    cmp eax, 39
    je .d_siadd64
    cmp eax, 41
    je .d_isprimebit
    cmp eax, 43
    je .d_shellp1c
    cmp eax, 45
    je .d_cdmul_d4
    lea rax, [fn_wave]
    ret
.d_eq:
    test r8d, r8d
    js .d_guard
    lea rax, [fn_test_eq]
    ret
.d_guard:
    lea rax, [fn_guard]
    ret
.d_and:
    test r8d, r8d
    js .d_or
    lea rax, [fn_and]
    ret
.d_or:
    lea rax, [fn_or]
    ret
.d_xor:
    test r8d, r8d
    js .d_not
    lea rax, [fn_xor]
    ret
.d_not:
    lea rax, [fn_not]
    ret
.d_shl:
    test r8d, r8d
    js .d_shr
    lea rax, [fn_shl]
    ret
.d_shr:
    lea rax, [fn_shr]
    ret
.d_lt:
    test r8d, r8d
    js .d_gt
    lea rax, [fn_lt]
    ret
.d_gt:
    lea rax, [fn_gt]
    ret
.d_neg:
    test r8d, r8d
    js .d_abs
    lea rax, [fn_negate]
    ret
.d_abs:
    lea rax, [fn_abs]
    ret
.d_mod:
    ; |D|=9: +D → mod (remainder, "what's left"), -D → div (quotient)
    test r8d, r8d
    js .d_div
    lea rax, [fn_mod]
    ret
.d_div:
    lea rax, [fn_div]
    ret
.d_scratch:
    ; |D|=15: +D → scratch read, -D → scratch write
    test r8d, r8d
    js .d_scratch_write
    lea rax, [fn_scratch_read32]
    ret
.d_scratch_write:
    lea rax, [fn_scratch_write32]
    ret
.d_sadd:
    ; |D|=17: +D → sadd32 (pipeline += scratch), -D → ssub32 (pipeline -= scratch)
    test r8d, r8d
    js .d_ssub
    lea rax, [fn_scratch_add32]
    ret
.d_ssub:
    lea rax, [fn_scratch_sub32]
    ret
.d_smod:
    ; |D|=19: smod32 (pipeline = pipeline mod scratch). Sign ignored.
    lea rax, [fn_scratch_mod32]
    ret
.d_scratch64:
    ; |D|=21: +D → sread64 (qword read), -D → swrite64 (qword write)
    test r8d, r8d
    js .d_swrite64
    lea rax, [fn_scratch_read64]
    ret
.d_swrite64:
    lea rax, [fn_scratch_write64]
    ret
.d_sadd64:
    ; |D|=23: +D → sadd64 (pipeline += scratch qword), -D → ssub64
    test r8d, r8d
    js .d_ssub64
    lea rax, [fn_scratch_add64]
    ret
.d_ssub64:
    lea rax, [fn_scratch_sub64]
    ret
.d_cdmul_d2:
    ; |D|=25: Cayley-Dickson base case (scalar complex multiply).
    ; Scratch-resident IO matching the d4/d8/d16/d32 recursion shape.
    lea rax, [fn_cd_mul_d2]
    ret
.d_smoddiv64:
    ; |D|=35: +D → smod64 (scratch mod), -D → sdiv64 (scratch div)
    ; 64-bit variants needed for Tier C gcd reduction where A·B
    ; exceeds u32 starting at N=12.
    test r8d, r8d
    js .d_sdiv64
    lea rax, [fn_scratch_mod64]
    ret
.d_sdiv64:
    lea rax, [fn_scratch_div64]
    ret
.d_gcd64:
    ; |D|=37: Euclidean GCD on two scratch qwords.
    ; Introduced as a primitive (rather than a reusable `gcd.winc`
    ; include) because hodos labels are global per-compile, so
    ; `@include gcd.winc` twice in one walk collides. Multi-cell
    ; Tier C walks need gcd 4-19 times per walk — impossible via
    ; include, trivial via bond.
    lea rax, [fn_gcd64]
    ret
.d_siadd64:
    ; |D|=39: scratch indirect add. scratch[rdi=pipeline_offset] += rsi=delta.
    ; Needed by shell_phase1.winc to increment per-cell counters
    ; where the cell index z is computed at runtime (from the
    ; balanced-ternary decoder output), not a compile-time constant.
    lea rax, [fn_scratch_add_indirect64]
    ret
.d_isprimebit:
    ; |D|=41: O(1) primality lookup against a precomputed bit sieve.
    ; C-side main.c builds the sieve at startup (~1s cold, ~ms from
    ; cache); the walker just reads bits. Replaces trial-division
    ; is_prime.winc for phase 1 at N≥17 where trial division is
    ; too slow (~200s at N=17, ~20-40 min at N=18).
    lea rax, [fn_is_prime_bit]
    ret
.d_shellp1c:
    ; |D|=43: full Tier C phase 1 in C (parallel OpenMP).
    ; Calls main.c's shell_phase1_compute, which enumerates primes
    ; in [2, x_N] via the sieve, decodes each to balanced-ternary,
    ; and accumulates per-cell A_z counters — all in parallel
    ; across CPU cores. Walker reads A_z from scratch for phase 2+3.
    ; Cuts N=18 from ~67s single-threaded to ~4s on 16 cores.
    lea rax, [fn_shell_phase1_c]
    ret
.d_cdmul_d4:
    ; |D|=45: walker-native quaternion multiply (Cayley-Dickson d4).
    ; Integer-exact signed 64-bit imul throughout, 16 muls + 12 adds.
    ; Same scratch-resident IO shape as fn_cd_mul_d2 (d2 base case).
    lea rax, [fn_cd_mul_d4]
    ret

    ; ── πδ filter/port/add variants ──
.dispatch_filter:
    mov eax, ecx
    mov r8d, eax
    test eax, eax
    jns .d_filt_abs
    neg eax
.d_filt_abs:
    test edi, edi
    js .d_filt_write
    test r8d, r8d
    js .d_port_read
    cmp eax, 3
    je .d_max
    lea rax, [fn_min]
    ret
.d_max:
    lea rax, [fn_max]
    ret
.d_port_read:
    cmp eax, 3
    je .d_msr_read
    cmp eax, 5
    je .d_cpuid
    cmp edi, 7
    jge .d_port_read_dword
    lea rax, [fn_port_read_byte]
    ret
.d_port_read_dword:
    lea rax, [fn_port_read_dword]
    ret
.d_msr_read:
    lea rax, [fn_msr_read]
    ret
.d_cpuid:
    lea rax, [fn_cpuid_read]
    ret

.d_filt_write:
    test r8d, r8d
    js .d_add
    cmp eax, 3
    je .d_msr_write
    mov eax, edi
    neg eax
    cmp eax, 7
    jge .d_port_write_dword
    lea rax, [fn_port_write_byte]
    ret
.d_port_write_dword:
    lea rax, [fn_port_write_dword]
    ret
.d_msr_write:
    lea rax, [fn_msr_write]
    ret
.d_add:
    cmp eax, 3
    je .d_sub
    lea rax, [fn_add]
    ret
.d_sub:
    lea rax, [fn_sub]
    ret

    ; ── π∮δ scan vs port bulk ──
.dispatch_scan:
    test ecx, ecx
    js .d_port_bulk
    lea rax, [Σ]
    ret
.d_port_bulk:
    lea rax, [fn_port_bulk_read]
    ret


; ══════════════════════════════════════════════════════════════
; Static bond functions
; Each takes: rdi=arg0, rsi=arg1, rdx=arg2, rcx=pipeline → rax
; ══════════════════════════════════════════════════════════════

; ── ∅ identity ──
fn_wave:
    mov rax, rdi
    ret

; ── π read (by width) ──
fn_read_qword:
    mov rax, [rdi]
    ret
fn_read_byte:
    movzx eax, byte [rdi]
    ret
fn_read_word:
    movzx eax, word [rdi]
    ret
fn_read_dword:
    mov eax, [rdi]
    ret

; ── write (by width) ──
fn_write_qword:
    mov [rdi], rsi
    mov rax, rsi
    ret
fn_write_byte:
    mov [rdi], sil
    mov rax, rsi
    ret
fn_write_word:
    mov [rdi], si
    mov rax, rsi
    ret
fn_write_dword:
    mov [rdi], esi
    mov rax, rsi
    ret

; ── ∘ call / ∘̄ curry ──
fn_call:
    ; +C: recursive ψ invocation. rdi=walk_ptr, rsi=walk_len
    call ψ
    ret
fn_curry:
    mov rax, rdi
    ret

; ── ∮ drain / ∮̄ increment ──
fn_loop:
    ; stub: return 0 (OS-level loop queue not present in userspace)
    xor eax, eax
    ret
fn_inc:
    lea rax, [rdi+1]
    ret

; ── δ test (==) ──
fn_test_eq:
    xor eax, eax
    cmp rdi, rsi
    sete al
    ret

; ── δ̄ guard (cmov) ──
fn_guard:
    mov rax, rcx                           ; default = pipeline
    test rsi, rsi
    cmovnz rax, rdi                        ; if arg1 != 0, return arg0
    ret

; ── δ₃ AND ──
fn_and:
    mov rax, rdi
    and rax, rsi
    ret

; ── δ̄₃ OR ──
fn_or:
    mov rax, rdi
    or rax, rsi
    ret

; ── δ₅ XOR ──
fn_xor:
    mov rax, rdi
    xor rax, rsi
    ret

; ── δ̄₅ NOT ──
fn_not:
    mov rax, rdi
    not rax
    ret

; ── δ₇ SHL ──
fn_shl:
    mov rax, rdi
    mov ecx, esi
    shl rax, cl
    ret

; ── δ̄₇ SHR ──
fn_shr:
    mov rax, rdi
    mov ecx, esi
    shr rax, cl
    ret

; ── δ₁₁ less-than ──
fn_lt:
    xor eax, eax
    cmp rdi, rsi
    setl al
    ret

; ── δ̄₁₁ greater-than ──
fn_gt:
    xor eax, eax
    cmp rdi, rsi
    setg al
    ret

; ── δ₁₃ negate ──
fn_negate:
    mov rax, rdi
    neg rax
    ret

; ── δ̄₁₃ abs ──
fn_abs:
    mov rax, rdi
    neg rax
    cmovs rax, rdi
    ret

; ── mod (|D|=9, +D) — rdi mod rsi (remainder) ──
;    rdi = dividend, rsi = divisor → rax = rdi % rsi
; Uses unsigned div (matches ∏'s division path in the atom). Div by
; zero traps (SIGFPE); walks must guard with a compare first.
fn_mod:
    xor edx, edx
    mov rax, rdi
    div rsi
    mov rax, rdx
    ret

; ── div (|D|=9, −D) — rdi / rsi (quotient) ──
;    rdi = dividend, rsi = divisor → rax = rdi / rsi (truncating)
fn_div:
    xor edx, edx
    mov rax, rdi
    div rsi
    ret

; ── scratch_read32 (|D|=15, +D) — read u32 from walk_scratch[offset] ──
;    rdi = offset → rax = *(u32*)(walk_scratch + offset), zero-extended
; Bounds unchecked — caller responsible for offset < 4096.
fn_scratch_read32:
    lea rax, [rel walk_scratch]
    add rax, rdi
    mov eax, [rax]
    ret

; ── scratch_write32 (|D|=15, −D) — write u32 to walk_scratch[offset] ──
;    rdi = value, rsi = offset → *(u32*)(walk_scratch + offset) = value
; Returns value written (rdi). Value-first/offset-second so the idiom
; `swrite32 θρ¹ρ <off>` writes the current pipeline to a fixed slot
; without needing to save pipeline elsewhere first.
fn_scratch_write32:
    lea rax, [rel walk_scratch]
    add rax, rsi
    mov [rax], edi
    mov rax, rdi
    ret

; ── scratch_add32 (|D|=17, +D) — pipeline += walk_scratch[offset] ──
;    rdi = offset, rcx = pipeline → rax = pipeline + *(u32*)(walk_scratch + offset)
; The one bond that was missing for A2-A5 enumerations: "add a memory
; slot to the current pipeline value." Without it, accumulating
; `answer += filter_result` across 81 iterations is impossible because
; the read destroys the pipeline and there's no way to merge memory
; back in. With it, the enum skeleton is clean.
fn_scratch_add32:
    lea rax, [rel walk_scratch]
    add rax, rdi
    mov eax, [rax]       ; rax = scratch[offset] (zero-extended u32 → u64)
    add rax, rcx         ; rax = pipeline + scratch[offset]
    ret

; ── scratch_sub32 (|D|=17, −D) — pipeline −= walk_scratch[offset] ──
;    rdi = offset, rcx = pipeline → rax = pipeline − *(u32*)(walk_scratch + offset)
; Used in Tier B trial division: after computing d*d into pipeline,
; subtract n (from scratch) and test the sign to get `d*d > n`. The
; subtraction preserves signed semantics in int64, so `lt 0` and
; `gt 0` on the result correctly detect which way the inequality ran.
fn_scratch_sub32:
    lea rax, [rel walk_scratch]
    add rax, rdi
    mov eax, [rax]       ; rax = scratch[offset]
    neg rax              ; rax = -scratch[offset]
    add rax, rcx         ; rax = pipeline + (-scratch[offset]) = pipeline - scratch[offset]
    ret

; ── scratch_mod32 (|D|=19) — pipeline = pipeline mod walk_scratch[offset] ──
;    rdi = offset, rcx = pipeline → rax = pipeline mod *(u32*)(walk_scratch + offset)
; Used in Tier B trial division: `n % d` where n is in pipeline and
; d is in a scratch slot. Pairs with smod's sister, scratch_sub32,
; for the inner divisor loop.
fn_scratch_mod32:
    lea rax, [rel walk_scratch]
    add rax, rdi
    mov esi, [rax]       ; rsi = scratch[offset] (divisor, zero-ext)
    xor edx, edx
    mov rax, rcx         ; rax = pipeline (dividend)
    div rsi              ; rax = pipeline/divisor, rdx = pipeline%divisor
    mov rax, rdx
    ret

; ══════════════════════════════════════════════════════════════
; 64-bit scratch family (|D|=21, 23) — qword read/write/add/sub
;
; Needed for Tier C where A·B and C·D intermediate products exceed
; u32 starting at N=12 (A·B ≈ 2.4·10¹⁰). Also used by CD multiply
; primitives which operate on int64 components of complex vectors.
; ══════════════════════════════════════════════════════════════

; ── scratch_read64 (|D|=21, +D) — read qword from walk_scratch[offset] ──
fn_scratch_read64:
    lea rax, [rel walk_scratch]
    add rax, rdi
    mov rax, [rax]       ; rax = *(u64*)(walk_scratch + offset)
    ret

; ── scratch_write64 (|D|=21, −D) — write qword to walk_scratch[offset] ──
;    rdi = value, rsi = offset → scratch[offset] = value, return value
fn_scratch_write64:
    lea rax, [rel walk_scratch]
    add rax, rsi
    mov [rax], rdi
    mov rax, rdi
    ret

; ── scratch_add64 (|D|=23, +D) — pipeline += walk_scratch[offset] (qword) ──
fn_scratch_add64:
    lea rax, [rel walk_scratch]
    add rax, rdi
    mov rax, [rax]       ; rax = scratch qword
    add rax, rcx         ; += pipeline
    ret

; ── scratch_sub64 (|D|=23, −D) — pipeline -= walk_scratch[offset] (qword) ──
fn_scratch_sub64:
    lea rax, [rel walk_scratch]
    add rax, rdi
    mov rax, [rax]       ; rax = scratch qword
    neg rax
    add rax, rcx         ; = pipeline - scratch
    ret

; ── scratch_mod64 (|D|=35, +D) — pipeline = pipeline mod walk_scratch[offset] (qword) ──
;    Uses the full 64-bit `div` instruction, not the 32-bit variant.
;    Needed for Tier C gcd reduction where A·B exceeds u32 at N ≥ 12.
fn_scratch_mod64:
    lea rax, [rel walk_scratch]
    add rax, rdi
    mov rsi, [rax]       ; rsi = divisor (qword)
    xor edx, edx
    mov rax, rcx         ; rax = pipeline (dividend)
    div rsi              ; rdx = pipeline % divisor
    mov rax, rdx
    ret

; ── scratch_div64 (|D|=35, −D) — pipeline = pipeline / walk_scratch[offset] (qword) ──
;    Truncating unsigned integer division. For the reduction step
;    g_z = (A_z·B) / gcd(A_z·B, C·D_z), which is exact because gcd
;    divides the numerator exactly. Sign-aware division not provided
;    — all framework values in this use case are non-negative.
fn_scratch_div64:
    lea rax, [rel walk_scratch]
    add rax, rdi
    mov rsi, [rax]       ; rsi = divisor
    xor edx, edx
    mov rax, rcx         ; rax = dividend
    div rsi              ; rax = dividend / divisor, rdx = remainder (discarded)
    ret

; ══════════════════════════════════════════════════════════════
; Euclidean GCD primitive: fn_gcd64 (|D|=37)
;
; rdi = offset_a, rsi = offset_b → rax = gcd(scratch[offset_a], scratch[offset_b])
;
; Classical Euclidean: while b != 0, (a, b) = (b, a mod b). Edge
; case `b==0` on entry handled by the initial test. Edge case `a==0`
; handled implicitly: first iteration sets a=b, b=0, loop exits
; returning the original b.
;
; Introduced because `gcd.winc` uses labels and hodos labels are
; global per-compile — including it more than once per walk causes
; forward-reference collisions. Tier C walks need gcd 4-19 times
; per walk (once per cell plus cross-cell accumulation), which is
; impossible via @include but trivial as a bond primitive.
; ══════════════════════════════════════════════════════════════

fn_gcd64:
    lea rax, [rel walk_scratch]
    lea rdx, [rax + rdi]
    mov rdi, [rdx]               ; rdi = a (from scratch[offset_a])
    lea rdx, [rax + rsi]
    mov rsi, [rdx]               ; rsi = b (from scratch[offset_b])

    test rsi, rsi
    jz .gcd64_done
.gcd64_loop:
    xor edx, edx
    mov rax, rdi
    div rsi                      ; rax = a/b, rdx = a%b
    mov rdi, rsi                 ; a = b
    mov rsi, rdx                 ; b = t
    test rsi, rsi
    jnz .gcd64_loop
.gcd64_done:
    mov rax, rdi                 ; return a
    ret

; ══════════════════════════════════════════════════════════════
; Scratch indirect add: fn_scratch_add_indirect64 (|D|=39)
;
; rdi = offset (from pipeline), rsi = delta → scratch[offset] += delta
; Returns new value in rax (walker sets pipeline = rax).
;
; The missing primitive for Phase 1 of shell_identity.winc: after
; the balanced-ternary decoder computes cell index z at runtime, we
; need to increment `A[z] += 2` where z is a dynamic value. Regular
; sadd64 takes the offset as a literal — this one takes the offset
; from the pipeline (which holds `A_base + 8·z` after a short
; arithmetic chain). The delta comes from arg1 (usually a u8 literal
; like 2 for the signed-counterpart doubling).
; ══════════════════════════════════════════════════════════════

fn_scratch_add_indirect64:
    lea rax, [rel walk_scratch]
    add rax, rdi                 ; rax = &scratch[offset]
    mov rdx, [rax]               ; rdx = current value
    add rdx, rsi                 ; += delta
    mov [rax], rdx               ; write back
    mov rax, rdx                 ; return new value
    ret

; ══════════════════════════════════════════════════════════════
; Primality bit-sieve lookup: fn_is_prime_bit (|D|=41)
;
; rdi = candidate n → rax = 0 (composite) or 1 (prime)
;
; Reads from the bit array that main.c's ensure_sieve() built at
; startup. Returns 0 safely if the sieve isn't loaded (sieve_bits_ptr
; is NULL) or if n is out of range (n >= sieve_max).
;
; O(1) per call — single memory load + shift + mask. ~2-3 ns at
; modern CPU speeds, vs ~1-5 μs per candidate for trial division
; via is_prime.winc. Makes N≥17 tractable.
; ══════════════════════════════════════════════════════════════

fn_is_prime_bit:
    mov rax, [rel sieve_bits_ptr]   ; rax = sieve pointer (from main.c)
    test rax, rax
    jz .not_ready                   ; sieve not built → return 0

    mov rdx, [rel sieve_max]        ; rdx = SIEVE_MAX
    cmp rdi, rdx
    jae .out_of_range               ; n >= max → return 0

    mov rcx, rdi
    shr rcx, 3                      ; byte index = n >> 3
    movzx rax, byte [rax + rcx]     ; load byte
    mov rcx, rdi
    and ecx, 7                      ; bit index = n & 7
    shr rax, cl
    and eax, 1                      ; isolate the target bit
    ret

.not_ready:
.out_of_range:
    xor eax, eax                    ; safe fallback: "not prime"
    ret

; ══════════════════════════════════════════════════════════════
; Parallel Phase 1 C call: fn_shell_phase1_c (|D|=43)
;
; rdi = N (u32), rsi = x_N (u32), rdx = A_out scratch offset
; → rax = pi_count (unsigned prime count)
;
; Marshals walker args to SysV calling convention and invokes
; main.c's shell_phase1_compute(N, x_N, &walk_scratch[A_ofs], &pi_local).
;
; Stack layout: walker's `call rbx` leaves rsp mod 16 == 8.
; `push rbx` → rsp mod 16 == 0.
; `sub rsp, 16` → rsp mod 16 == 0 (aligned for the C call).
; The 16-byte stack slot holds the u64 pi_count output.
;
; Walker's r15 (pipeline storage) is callee-saved in SysV, so the
; C function can't clobber it. Good.
; ══════════════════════════════════════════════════════════════

fn_shell_phase1_c:
    push rbx                     ; callee-saved; alignment to 16

    ; rdi = N (already in place for C call)
    ; rsi = x_N (already in place)
    ; rdx = A_out offset → convert to absolute pointer
    lea rax, [rel walk_scratch]
    add rdx, rax                 ; rdx = &walk_scratch[A_out_offset]

    ; rcx needs to be &pi_out_local on the stack
    sub rsp, 16
    mov rcx, rsp                 ; rcx = &pi_out_local

    call shell_phase1_compute wrt ..plt

    mov rax, [rsp]               ; rax = pi_count
    add rsp, 16

    pop rbx
    ret

; ══════════════════════════════════════════════════════════════
; Cayley-Dickson base case: fn_cd_mul_d2 (|D|=25)
;
; Scratch-resident IO per the d2 → d32 recursion design.
; Interface (same shape at every dimension):
;   rdi = a_ofs   (scratch offset of complex A, 2 qwords)
;   rsi = b_ofs   (scratch offset of complex B, 2 qwords)
;   rdx = out_ofs (scratch offset for result, 2 qwords)
;   rax = 0       (return unused; result lives in scratch[out_ofs])
;
; Memory layout (2 qwords per d2 complex):
;   scratch[a_ofs    .. a_ofs+8]  = a_real (int64)
;   scratch[a_ofs+8  .. a_ofs+16] = a_imag (int64)
;
; Math: (a_real + a_imag·i)(b_real + b_imag·i) =
;       (a_real·b_real − a_imag·b_imag) + (a_real·b_imag + a_imag·b_real)·i
;
; Signed imul throughout. Pipeline (rcx) is not preserved inside the
; body — we clobber it freely. Walker restores its own r15 pipeline
; state after the call, so rcx clobber is fine.
; ══════════════════════════════════════════════════════════════

fn_cd_mul_d2:
    push rdx                     ; save out_ofs (imul below clobbers rdx)

    lea r8, [rel walk_scratch]
    mov r9,  [r8 + rdi]          ; r9  = a_real
    mov r10, [r8 + rdi + 8]      ; r10 = a_imag
    mov r11, [r8 + rsi]          ; r11 = b_real
    mov rcx, [r8 + rsi + 8]      ; rcx = b_imag (pipeline clobbered, fine)

    ; out_real = a_real·b_real − a_imag·b_imag
    mov rax, r9
    imul rax, r11                ; rax = a_real·b_real
    mov rdi, r10                 ; rdi now holds a_imag (a_ofs no longer needed)
    imul rdi, rcx                ; rdi = a_imag·b_imag
    sub rax, rdi                 ; rax = out_real

    pop rdx                      ; restore out_ofs
    mov [r8 + rdx], rax          ; scratch[out_ofs] = out_real

    ; out_imag = a_real·b_imag + a_imag·b_real
    mov rax, r9
    imul rax, rcx                ; rax = a_real·b_imag
    mov rdi, r10
    imul rdi, r11                ; rdi = a_imag·b_real
    add rax, rdi                 ; rax = out_imag

    mov [r8 + rdx + 8], rax      ; scratch[out_ofs+8] = out_imag

    xor eax, eax                 ; return 0 (convention: CD multiplies return 0)
    ret

; ══════════════════════════════════════════════════════════════
; Cayley-Dickson d4 (quaternion): fn_cd_mul_d4 (|D|=45)
;
; Hamilton quaternion multiplication with integer-exact 64-bit
; signed arithmetic. Uses the CD recursion unrolled into explicit
; 16 imuls + 12 add/subs (no recursion, no function calls).
;
; Interface (same shape as fn_cd_mul_d2, 4 qwords per quaternion):
;   rdi = a_ofs   (scratch offset of quaternion A, 4 qwords)
;   rsi = b_ofs   (scratch offset of quaternion B, 4 qwords)
;   rdx = out_ofs (scratch offset for result, 4 qwords)
;   rax = 0       (return unused; result lives in scratch[out_ofs])
;
; Memory layout (4 qwords per d4 quaternion, little-endian words):
;   scratch[a_ofs     .. +8]  = a_real  (1-component)
;   scratch[a_ofs+8   .. +16] = a_i     (i-component)
;   scratch[a_ofs+16  .. +24] = a_j     (j-component)
;   scratch[a_ofs+24  .. +32] = a_k     (k-component)
;
; Hamilton's rules:
;   i² = j² = k² = ijk = −1
;   ij = k,  jk = i,  ki = j   (and ji = −k, kj = −i, ik = −j)
;
; Per-component formulas (a = a0 + a1·i + a2·j + a3·k etc.):
;   out[0] = a0·b0 − a1·b1 − a2·b2 − a3·b3
;   out[1] = a0·b1 + a1·b0 + a2·b3 − a3·b2
;   out[2] = a0·b2 − a1·b3 + a2·b0 + a3·b1
;   out[3] = a0·b3 + a1·b2 − a2·b1 + a3·b0
;
; Register plan: r9..r11/rcx hold a0..a3, r12..r14/rdi hold b0..b3
; (rdi is free after a_ofs loaded). rbx = scratch temp (pushed,
; aligns stack). rax = accumulator. r8 = &walk_scratch. rdx = out_ofs.
; r15 is walker pipeline, left untouched.
; ══════════════════════════════════════════════════════════════

fn_cd_mul_d4:
    push rbx                     ; callee-saved, aligns stack

    lea r8, [rel walk_scratch]

    ; load a0..a3 into r9, r10, r11, rcx
    mov r9,  [r8 + rdi]          ; a0
    mov r10, [r8 + rdi + 8]      ; a1
    mov r11, [r8 + rdi + 16]     ; a2
    mov rcx, [r8 + rdi + 24]     ; a3 (pipeline clobber ok)

    ; load b0..b3 into r12, r13, r14, rdi (rdi no longer needed)
    mov r12, [r8 + rsi]          ; b0
    mov r13, [r8 + rsi + 8]      ; b1
    mov r14, [r8 + rsi + 16]     ; b2
    mov rdi, [r8 + rsi + 24]     ; b3

    ; ── out[0] = a0·b0 − a1·b1 − a2·b2 − a3·b3 ─────
    mov rbx, r9
    imul rbx, r12                ; rbx = a0·b0
    mov rax, rbx
    mov rbx, r10
    imul rbx, r13                ; rbx = a1·b1
    sub rax, rbx
    mov rbx, r11
    imul rbx, r14                ; rbx = a2·b2
    sub rax, rbx
    mov rbx, rcx
    imul rbx, rdi                ; rbx = a3·b3
    sub rax, rbx
    mov [r8 + rdx], rax

    ; ── out[1] = a0·b1 + a1·b0 + a2·b3 − a3·b2 ─────
    mov rbx, r9
    imul rbx, r13                ; rbx = a0·b1
    mov rax, rbx
    mov rbx, r10
    imul rbx, r12                ; rbx = a1·b0
    add rax, rbx
    mov rbx, r11
    imul rbx, rdi                ; rbx = a2·b3
    add rax, rbx
    mov rbx, rcx
    imul rbx, r14                ; rbx = a3·b2
    sub rax, rbx
    mov [r8 + rdx + 8], rax

    ; ── out[2] = a0·b2 − a1·b3 + a2·b0 + a3·b1 ─────
    mov rbx, r9
    imul rbx, r14                ; rbx = a0·b2
    mov rax, rbx
    mov rbx, r10
    imul rbx, rdi                ; rbx = a1·b3
    sub rax, rbx
    mov rbx, r11
    imul rbx, r12                ; rbx = a2·b0
    add rax, rbx
    mov rbx, rcx
    imul rbx, r13                ; rbx = a3·b1
    add rax, rbx
    mov [r8 + rdx + 16], rax

    ; ── out[3] = a0·b3 + a1·b2 − a2·b1 + a3·b0 ─────
    mov rbx, r9
    imul rbx, rdi                ; rbx = a0·b3
    mov rax, rbx
    mov rbx, r10
    imul rbx, r14                ; rbx = a1·b2
    add rax, rbx
    mov rbx, r11
    imul rbx, r13                ; rbx = a2·b1
    sub rax, rbx
    mov rbx, rcx
    imul rbx, r12                ; rbx = a3·b0
    add rax, rbx
    mov [r8 + rdx + 24], rax

    pop rbx
    xor eax, eax                 ; convention: CD multiplies return 0
    ret

; ── πδ min ──
fn_min:
    mov rax, rdi
    cmp rdi, rsi
    cmovg rax, rsi
    ret

; ── πδ₃ max ──
fn_max:
    mov rax, rdi
    cmp rdi, rsi
    cmovl rax, rsi
    ret

; ── HARDWARE I/O STUBS ──
; These were port I/O / MSR / CPUID / REP INS in the OS build.
; Privileged in userspace, so they're stubbed to return 0.
; Dispatch still routes to them — they just no-op.

fn_port_read_byte:
fn_port_read_dword:
fn_msr_read:
fn_cpuid_read:
fn_port_write_byte:
fn_port_write_dword:
fn_msr_write:
fn_port_bulk_read:
    xor eax, eax
    ret

; ── add (memory+test, negative polarity) ──
fn_add:
    lea rax, [rdi+rsi]
    ret

; ── sub (memory+test, -A -D magnitude 3) ──
fn_sub:
    mov rax, rdi
    sub rax, rsi
    ret

; ── π∮ copy byte (rep movsb) ──
fn_copy_byte:
    mov ecx, edx
    cld
    rep movsb
    xor eax, eax
    ret

; ── π∮ copy dword (rep movsd) ──
fn_copy_dword:
    mov ecx, edx
    cld
    rep movsd
    xor eax, eax
    ret

; ── π∮ copy qword (rep movsq) ──
fn_copy_qword:
    mov ecx, edx
    cld
    rep movsq
    xor eax, eax
    ret

; ── fill byte (memory+loop negative, rep stosb) ──
fn_fill_byte:
    mov al, sil
    mov ecx, edx
    cld
    rep stosb
    xor eax, eax
    ret

; ── fill dword (rep stosd) ──
fn_fill_dword:
    mov eax, esi
    mov ecx, edx
    cld
    rep stosd
    xor eax, eax
    ret

; ── fill qword (rep stosq) ──
fn_fill_qword:
    mov rax, rsi
    mov ecx, edx
    cld
    rep stosq
    xor eax, eax
    ret

; ── ∘δ maybe (conditional call) ──
fn_maybe:
    test rsi, rsi
    jz .skip
    push rbx
    mov ebx, edx
    mov esi, ebx
    call ψ
    pop rbx
    ret
.skip:
    xor eax, eax
    ret


; ══════════════════════════════════════════════════════════════
; Complex bond functions — recursive walkers
; ══════════════════════════════════════════════════════════════

; ── fold (memory + call: read then dispatch) ──
λ:
    push rbx
    push r12
    mov rbx, rsi
    mov r12d, edx
    mov rax, [rdi]
    mov [ρ], rax
    mov rdi, rbx
    mov esi, r12d
    call ψ
    pop r12
    pop rbx
    ret

; ── fix (call + loop: call N times) ──
ν:
    push rbx
    push r12
    push r13
    mov rbx, rdi
    mov r12d, esi
    mov r13d, edx
    xor eax, eax
    test r13d, r13d
    jz .done
.loop:
    mov rdi, rbx
    mov esi, r12d
    call ψ
    dec r13d
    jnz .loop
.done:
    pop r13
    pop r12
    pop rbx
    ret

; ── foldl (memory + call + loop: fold over array) ──
Φ:
    push rbx
    push r12
    push r13
    push r14
    mov r13, rdi
    mov rbx, rsi
    mov r12d, edx
    mov r14d, ecx
    xor eax, eax
    test r14d, r14d
    jz .done
.loop:
    mov rax, [r13]
    mov [ρ], rax
    add r13, 8
    mov rdi, rbx
    mov esi, r12d
    call ψ
    dec r14d
    jnz .loop
.done:
    pop r14
    pop r13
    pop r12
    pop rbx
    ret

; ── map (memory + call + test: apply to each) ──
σ:
    push rbx
    push r12
    push r13
    push r14
    mov r13, rdi
    mov rbx, rsi
    mov r12d, edx
    mov r14d, ecx
    xor eax, eax
    test r14d, r14d
    jz .done
.loop:
    mov rax, [r13]
    test rax, rax
    jz .next
    mov [ρ], rax
    mov rdi, rbx
    mov esi, r12d
    call ψ
.next:
    add r13, 8
    dec r14d
    jnz .loop
.done:
    pop r14
    pop r13
    pop r12
    pop rbx
    ret

; ── ∮δ until (scan to zero) ──
ω:
    xor eax, eax
.loop:
    cmp byte [rdi + rax], 0
    jz .done
    inc rax
    jmp .loop
.done:
    ret

; ── π∮δ scan (accumulate) ──
Σ:
    xor eax, eax
    test esi, esi
    jz .done
    mov ecx, esi
.loop:
    add rax, [rdi]
    add rdi, 8
    dec ecx
    jnz .loop
.done:
    ret

; ── bind (call + loop + test: the event loop) ──
β:
    push rbx
    push r12
    mov rbx, rdi
    mov r12d, esi
.loop:
    mov rdi, rbx
    mov esi, r12d
    call ψ
    test rax, rax
    jnz .loop
    pop r12
    pop rbx
    ret

; ── hylo (all 4 forces: full pipeline) ──
η:
    push rbx
    push r12
    push r13
    mov r13, rdi
    mov rbx, rsi
    mov r12d, edx
.loop:
    mov rax, [r13]
    test rax, rax
    jz .done
    mov [ρ], rax
    add r13, 8
    mov rdi, rbx
    mov esi, r12d
    call ψ
    jmp .loop
.done:
    xor eax, eax
    pop r13
    pop r12
    pop rbx
    ret


; ══════════════════════════════════════════════════════════════
; bond_fn_table_{scalar,xmm,ymm,zmm} — per-width dispatch tables
;
; Per 03-simd.md: SIMD register widths follow the Cayley-Dickson chain.
;   scalar = R (reals),     1×int64
;   xmm    = H (quaternion), 4×int32 / 2×int64
;   ymm    = O (octonion),   8×int32 / 4×int64
;   zmm    = S (sedenion),  16×int32 / 8×int64
;
; Four parallel tables exist so the dispatcher can select the widest
; variant the host CPU supports at startup. main.c probes CPU via
; __builtin_cpu_supports() and writes the chosen table address into
; bond_fn_table_active.
;
; Currently all four tables point at the SAME scalar functions. When a
; specific bond gets a SIMD variant (e.g. fn_wave_ymm), swap its entry
; in the corresponding width table — no other changes needed. The
; walker, dispatch logic, and walk encoding stay identical across
; widths. This is the os-lattice 4-section pattern, adapted.
; ══════════════════════════════════════════════════════════════

section .rodata

align 8
global bond_fn_table_scalar
bond_fn_table_scalar:
    ; slot = 4-bit force pattern: bit0=A bit1=B bit2=C bit3=D  (all odd)
    dq fn_wave                             ;  0  (0000) identity (no axes odd — atom path instead)
    dq fn_read_qword                       ;  1  (A) memory, sub-dispatched by width
    dq fn_call                             ;  2  (B) call / return
    dq λ                                   ;  3  (AB) fold — read then call
    dq fn_loop                             ;  4  (C) loop / increment
    dq fn_copy_byte                        ;  5  (AC) copy/fill, sub-dispatched by width
    dq ν                                   ;  6  (BC) fix — call N times
    dq Φ                                   ;  7  (ABC) foldl — fold over array
    dq fn_test_eq                          ;  8  (D) test, sub-dispatched by gate variant
    dq fn_min                              ;  9  (AD) memory+test: min/max/add/sub, sub-dispatched
    dq fn_maybe                            ; 10  (BD) maybe — conditional call
    dq σ                                   ; 11  (ABD) map — apply to each
    dq ω                                   ; 12  (CD) until — scan to zero
    dq Σ                                   ; 13  (ACD) scan / port bulk, sub-dispatched
    dq β                                   ; 14  (BCD) bind — event loop
    dq η                                   ; 15  (ABCD) hylo — full pipeline

align 8
global bond_fn_table_xmm
bond_fn_table_xmm:
    dq fn_wave, fn_read_qword, fn_call, λ
    dq fn_loop, fn_copy_byte,  ν,       Φ
    dq fn_test_eq, fn_min,     fn_maybe, σ
    dq ω,       Σ,             β,       η

align 8
global bond_fn_table_ymm
bond_fn_table_ymm:
    dq fn_wave, fn_read_qword, fn_call, λ
    dq fn_loop, fn_copy_byte,  ν,       Φ
    dq fn_test_eq, fn_min,     fn_maybe, σ
    dq ω,       Σ,             β,       η

align 8
global bond_fn_table_zmm
bond_fn_table_zmm:
    dq fn_wave, fn_read_qword, fn_call, λ
    dq fn_loop, fn_copy_byte,  ν,       Φ
    dq fn_test_eq, fn_min,     fn_maybe, σ
    dq ω,       Σ,             β,       η

; bond_fn_table_active — writable pointer to the currently-selected
; width table. Set by main.c at startup. The dispatcher loads this to
; find the table base for slot lookups.
section .data
align 8
global bond_fn_table_active
bond_fn_table_active: dq bond_fn_table_scalar

section .text


; ══════════════════════════════════════════════════════════════
; ∏ — the equation: Aᵃ · Bᵇ · Cᶜ · Dᵈ
;
; Called directly by the walker for atoms (all even coordinates).
; rdi=A_val, rsi=B_val, rdx=C_val, rcx=D_val
; r8d=A_exp, r9d=B_exp, r10d=C_exp, r11d=D_exp → rax
; ══════════════════════════════════════════════════════════════

∏:
    push rbx
    push r12
    push r13
    push r14
    push r15

    mov r12, rdi
    mov r13, rsi
    mov r14, rdx
    mov r15, rcx

    mov rax, 1

    ; ── A dimension (WHERE / space) ──
    test r8d, r8d
    jz .B_start
    jns .A_mul_init
    neg r8d
    mov ebx, r8d
.A_div:
    xor edx, edx
    div r12
    dec ebx
    jnz .A_div
    jmp .B_start
.A_mul_init:
    mov ebx, r8d
.A_mul:
    imul rax, r12
    dec ebx
    jnz .A_mul

.B_start:
    ; ── B dimension (WHAT / matter) ──
    test r9d, r9d
    jz .C_start
    jns .B_mul_init
    neg r9d
    mov ebx, r9d
.B_div:
    xor edx, edx
    div r13
    dec ebx
    jnz .B_div
    jmp .C_start
.B_mul_init:
    mov ebx, r9d
.B_mul:
    imul rax, r13
    dec ebx
    jnz .B_mul

.C_start:
    ; ── C dimension (WHICH / signal) ──
    test r10d, r10d
    jz .D_start
    jns .C_mul_init
    neg r10d
    mov ebx, r10d
.C_div:
    xor edx, edx
    div r14
    dec ebx
    jnz .C_div
    jmp .D_start
.C_mul_init:
    mov ebx, r10d
.C_mul:
    imul rax, r14
    dec ebx
    jnz .C_mul

.D_start:
    ; ── D dimension (WHEN / time) ──
    test r11d, r11d
    jz .done
    jns .D_mul_init
    neg r11d
    mov ebx, r11d
.D_div:
    xor edx, edx
    div r15
    dec ebx
    jnz .D_div
    jmp .done
.D_mul_init:
    mov ebx, r11d
.D_mul:
    imul rax, r15
    dec ebx
    jnz .D_mul

.done:
    pop r15
    pop r14
    pop r13
    pop r12
    pop rbx
    ret


; ══════════════════════════════════════════════════════════════
; WALKER — ψ — wave byte interpreter
; ══════════════════════════════════════════════════════════════
;
; Input:  rdi = walk pointer, esi = walk length
; Output: rax = last result (also stored in ρ)

global walk_run
global ψ
walk_run:
ψ:
    push rbx
    push r12
    push r13
    push r14
    push r15

    mov r12, rdi                   ; walk pointer
    mov r13d, esi                  ; walk length
    lea r14, [r12 + r13]           ; end
    xor r15d, r15d                 ; pipeline = 0

.next:
    cmp r12, r14
    jge .done

    movzx eax, byte [r12]

    cmp al, 0xFC                   ; control bytes (skip, loop)
    jae .control

    ; ── decode wave byte → 4 coordinates ──
    ; bit layout:  [7:6]=A  [5:4]=B  [3:2]=C  [1:0]=D
    ; (space, matter, signal, time — 3-force.md canonical order)
    movzx ebx, al
    inc r12

    lea rax, [decode_table]

    ; A = bits [7:6]  (WHERE / space)
    mov ecx, ebx
    shr ecx, 6
    cmp ecx, 2
    jne .A
    movsx edi, byte [r12]
    inc r12
    jmp .dec_B
.A:
    movsx edi, byte [rax + rcx]

.dec_B:
    ; B = bits [5:4]  (WHAT / matter)
    mov ecx, ebx
    shr ecx, 4
    and ecx, 3
    cmp ecx, 2
    jne .B
    movsx esi, byte [r12]
    inc r12
    jmp .dec_C
.B:
    movsx esi, byte [rax + rcx]

.dec_C:
    ; C = bits [3:2]  (WHICH / signal)
    mov ecx, ebx
    shr ecx, 2
    and ecx, 3
    cmp ecx, 2
    jne .C
    movsx edx, byte [r12]
    inc r12
    jmp .dec_D
.C:
    movsx edx, byte [rax + rcx]

.dec_D:
    ; D = bits [1:0]  (WHEN / time)
    mov ecx, ebx
    and ecx, 3
    cmp ecx, 2
    jne .D
    movsx ecx, byte [r12]
    inc r12
    jmp .flags
.D:
    movsx ecx, byte [rax + rcx]

    ; ── flags: how arguments are encoded ──
.flags:
    movzx r13d, byte [r12]
    inc r12

    ; ── classify: atom or bond? ──
    mov eax, edi
    or eax, esi
    or eax, edx
    or eax, ecx
    test eax, 1
    jnz .bond

    ; ── atom path: call ∏ directly ──
    mov r8d, edi
    sar r8d, 1                     ; A exponent (WHERE)
    mov r9d, esi
    sar r9d, 1                     ; B exponent (WHAT)
    mov r10d, edx
    sar r10d, 1                    ; C exponent (WHICH)
    mov r11d, ecx
    sar r11d, 1                    ; D exponent (WHEN)

    ; arg0 → rdi (A_val = space)
    mov eax, r13d
    and eax, 3
    jz .a0_pipe
    cmp eax, 1
    je .a0_u8
    cmp eax, 2
    je .a0_u32
    mov rdi, [r12]
    add r12, 8
    jmp .a0_ok
.a0_u8:
    movzx edi, byte [r12]
    inc r12
    jmp .a0_ok
.a0_u32:
    mov edi, [r12]
    add r12, 4
    jmp .a0_ok
.a0_pipe:
    mov rdi, r15
.a0_ok:
    test r13d, 0x80
    jz .a0_deref
    mov rdi, [rdi]
.a0_deref:
    ; arg1 → rsi (B_val = matter)
    mov eax, r13d
    shr eax, 2
    and eax, 3
    jz .a1_pipe
    cmp eax, 1
    je .a1_u8
    cmp eax, 2
    je .a1_u32
    mov rsi, [r12]
    add r12, 8
    jmp .a1_ok
.a1_u8:
    movzx esi, byte [r12]
    inc r12
    jmp .a1_ok
.a1_u32:
    mov esi, [r12]
    add r12, 4
    jmp .a1_ok
.a1_pipe:
    mov rsi, r15
.a1_ok:
    test r13d, 0x40
    jz .a1_deref
    mov rsi, [rsi]
.a1_deref:
    ; arg2 → rdx (C_val = signal)
    mov eax, r13d
    shr eax, 4
    and eax, 3
    jz .a2_pipe
    cmp eax, 1
    je .a2_u8
    cmp eax, 2
    je .a2_u32
    mov rdx, [r12]
    add r12, 8
    jmp .a2_ok
.a2_u8:
    movzx edx, byte [r12]
    inc r12
    jmp .a2_ok
.a2_u32:
    mov edx, [r12]
    add r12, 4
    jmp .a2_ok
.a2_pipe:
    mov rdx, r15
.a2_ok:
    mov rcx, r15                   ; arg3 = pipeline (D_val = time)

    call ∏
    mov r15, rax
    mov [ρ], rax
    jmp .next

    ; ── bond path: dispatch to static function ──
.bond:
    push rdi
    push rsi
    push rdx
    push rcx
    call bond_dispatch             ; → rax = function pointer
    mov rbx, rax
    pop rcx
    pop rdx
    pop rsi
    pop rdi

    ; arg0 → rdi
    mov eax, r13d
    and eax, 3
    jz .arg0_pipe
    cmp eax, 1
    je .arg0_u8
    cmp eax, 2
    je .arg0_u32
    mov rdi, [r12]
    add r12, 8
    jmp .arg0_ok
.arg0_u8:
    movzx edi, byte [r12]
    inc r12
    jmp .arg0_ok
.arg0_u32:
    mov edi, [r12]
    add r12, 4
    jmp .arg0_ok
.arg0_pipe:
    mov rdi, r15
.arg0_ok:
    test r13d, 0x80
    jz .arg0_deref
    mov rdi, [rdi]
.arg0_deref:
    ; arg1 → rsi
    mov eax, r13d
    shr eax, 2
    and eax, 3
    jz .arg1_pipe
    cmp eax, 1
    je .arg1_u8
    cmp eax, 2
    je .arg1_u32
    mov rsi, [r12]
    add r12, 8
    jmp .arg1_ok
.arg1_u8:
    movzx esi, byte [r12]
    inc r12
    jmp .arg1_ok
.arg1_u32:
    mov esi, [r12]
    add r12, 4
    jmp .arg1_ok
.arg1_pipe:
    mov rsi, r15
.arg1_ok:
    test r13d, 0x40
    jz .arg1_deref
    mov rsi, [rsi]
.arg1_deref:
    ; arg2 → rdx
    mov eax, r13d
    shr eax, 4
    and eax, 3
    jz .arg2_pipe
    cmp eax, 1
    je .arg2_u8
    cmp eax, 2
    je .arg2_u32
    mov rdx, [r12]
    add r12, 8
    jmp .arg2_ok
.arg2_u8:
    movzx edx, byte [r12]
    inc r12
    jmp .arg2_ok
.arg2_u32:
    mov edx, [r12]
    add r12, 4
    jmp .arg2_ok
.arg2_pipe:
    mov rdx, r15
.arg2_ok:
    mov rcx, r15                   ; arg3 = pipeline (always)

    ; ── execute bond ──
    call rbx
    mov r15, rax
    mov [ρ], rax
    jmp .next

    ; ── walker control ──
.control:
    mov ebx, [r12+1]

    cmp al, 0xFE
    je .skip_z
    cmp al, 0xFD
    je .skip_nz
    ; loop_back: rewind if pipeline ≠ 0
    test r15, r15
    jz .skip_done
    sub r12, rbx
    jmp .skip_done

.skip_z:                              ; skip if pipeline = 0
    test r15, r15
    jnz .skip_done
    add r12, rbx
    jmp .skip_done

.skip_nz:                              ; skip if pipeline ≠ 0
    test r15, r15
    jz .skip_done
    add r12, rbx

.skip_done:
    add r12, 5
    jmp .next

.done:
    mov rax, r15
    pop r15
    pop r14
    pop r13
    pop r12
    pop rbx
    ret


; ── decode table ──
;   2-bit field → signed coordinate
;   00 → 0    01 → +1    10 → extended    11 → -1

section .rodata

decode_table:
    db  0
    db  1
    db  0
    db -1

; ── mark stack as non-executable (Linux) ──
section .note.GNU-stack noalloc noexec nowrite progbits
