; kernel.asm — the whole OS: multiboot boot + NOMOS dispatch + ψ walker + bonds
;
; Flat binary with multiboot aout kludge. Loads at 1MB, transitions
; 32→64 bit, runs embedded walk, prints result to serial 0x3F8, halts.
;
; Build: nasm -f bin kernel.asm -o kernel.bin
; Run:   qemu-system-x86_64 -kernel kernel.bin -serial stdio -nographic
;
; Bond ABI: rdi=arg0 rsi=arg1 rdx=arg2 rcx=pipeline → rax
; Walker registers: r12=walk_ptr r13=flags r14=end_ptr r15=pipeline

org 0x100000                         ; load address = 1MB

; ══════════════════════════════════════════════════════════════
; MULTIBOOT HEADER (must be in first 8KB)
; ══════════════════════════════════════════════════════════════

[bits 32]

MBOOT_MAGIC  equ 0x1BADB002
MBOOT_FLAGS  equ 0x00010003          ; bit 0: align, bit 1: meminfo, bit 16: aout kludge
MBOOT_CHKSUM equ -(MBOOT_MAGIC + MBOOT_FLAGS)

align 4
mboot_header:
    dd MBOOT_MAGIC
    dd MBOOT_FLAGS
    dd MBOOT_CHKSUM
    ; aout kludge fields (flag bit 16)
    dd mboot_header                  ; header_addr
    dd 0x100000                      ; load_addr (start of file)
    dd _data_end                     ; load_end_addr
    dd _bss_end                      ; bss_end_addr
    dd _start                        ; entry_addr

; ══════════════════════════════════════════════════════════════
; 32-BIT ENTRY — transition to long mode
; ══════════════════════════════════════════════════════════════

_start:
    cli
    mov esp, _stack_top

    ; ── zero page table area (3 pages = 12KB) ──
    mov edi, _pml4
    xor eax, eax
    mov ecx, 3072
    rep stosd

    ; PML4[0] → PDPT (aligned, so + is same as |)
    mov dword [_pml4], _pdpt + 0x03

    ; PDPT[0] → PD
    mov dword [_pdpt], _pd + 0x03

    ; PD[0..3] → identity map first 8MB (2MB pages, PS bit)
    mov dword [_pd + 0*8],     0x000083
    mov dword [_pd + 0*8 + 4], 0
    mov dword [_pd + 1*8],     0x200083
    mov dword [_pd + 1*8 + 4], 0
    mov dword [_pd + 2*8],     0x400083
    mov dword [_pd + 2*8 + 4], 0
    mov dword [_pd + 3*8],     0x600083
    mov dword [_pd + 3*8 + 4], 0

    ; enable PAE
    mov eax, cr4
    or eax, 1 << 5
    mov cr4, eax

    ; load PML4
    mov eax, _pml4
    mov cr3, eax

    ; enable long mode (EFER.LME)
    mov ecx, 0xC0000080
    rdmsr
    or eax, 1 << 8
    wrmsr

    ; enable paging + protected mode
    mov eax, cr0
    or eax, (1 << 31) | (1 << 0)
    mov cr0, eax

    ; load 64-bit GDT
    lgdt [_gdt64_ptr]

    ; far jump to 64-bit code
    jmp dword 0x08:_entry64


; ══════════════════════════════════════════════════════════════
; GDT (must be accessible from 32-bit code)
; ══════════════════════════════════════════════════════════════

align 8
_gdt64:
    dq 0                             ; null
    dq 0x00209A0000000000            ; code: 64-bit, present, exec, read
    dq 0x0000920000000000            ; data: 64-bit, present, write
_gdt64_end:

_gdt64_ptr:
    dw _gdt64_end - _gdt64 - 1
    dd _gdt64


; ══════════════════════════════════════════════════════════════
; 64-BIT CODE
; ══════════════════════════════════════════════════════════════

[bits 64]
default abs

_entry64:
    ; load data segments
    mov ax, 0x10
    mov ds, ax
    mov es, ax
    mov fs, ax
    mov gs, ax
    mov ss, ax

    mov rsp, _stack_top

    ; ── init serial 0x3F8 (115200 8N1) ──
    mov dx, 0x3F9
    xor al, al
    out dx, al                       ; disable interrupts
    mov dx, 0x3FB
    mov al, 0x80
    out dx, al                       ; DLAB on
    mov dx, 0x3F8
    mov al, 0x01
    out dx, al                       ; divisor low = 1
    mov dx, 0x3F9
    xor al, al
    out dx, al                       ; divisor high = 0
    mov dx, 0x3FB
    mov al, 0x03
    out dx, al                       ; 8N1, DLAB off
    mov dx, 0x3FC
    xor al, al
    out dx, al                       ; no modem ctrl

    ; ── run walker ──
    mov rdi, _walk_data
    mov esi, dword [_walk_len]
    call psi

    ; ── print pipeline result with prefix ──
    push rax                         ; save walker result
    mov al, 0x0A
    call _serial_putc
    mov al, '='
    call _serial_putc
    pop rdi                          ; restore result
    call _print_int64
    mov al, 0x0A
    call _serial_putc

    ; ── ACPI poweroff (QEMU piix4) ──
    mov dx, 0x604
    mov ax, 0x2000
    out dx, ax

.halt:
    hlt
    jmp .halt


; ══════════════════════════════════════════════════════════════
; SERIAL OUTPUT
; ══════════════════════════════════════════════════════════════

_serial_putc:
    push rdx
    push rax
    mov dx, 0x3FD
.wait:
    in al, dx
    test al, 0x20
    jz .wait
    pop rax
    mov dx, 0x3F8
    out dx, al
    pop rdx
    ret

_print_int64:
    push rbx
    push rcx
    push rdx
    push rsi

    mov rax, rdi
    test rax, rax
    jns .positive
    push rax
    mov al, '-'
    call _serial_putc
    pop rax
    neg rax
.positive:
    xor ecx, ecx
    mov rbx, 10
.divloop:
    xor edx, edx
    div rbx
    push rdx
    inc ecx
    test rax, rax
    jnz .divloop
.printloop:
    pop rax
    add al, '0'
    call _serial_putc
    dec ecx
    jnz .printloop

    pop rsi
    pop rdx
    pop rcx
    pop rbx
    ret


; ══════════════════════════════════════════════════════════════
; WALKER — ψ — wave byte interpreter
; ══════════════════════════════════════════════════════════════
;
; Input:  rdi = walk pointer, esi = walk length
; Output: rax = pipeline result (also stored in [_rho])

psi:
    push rbx
    push r12
    push r13
    push r14
    push r15

    mov r12, rdi                   ; walk pointer
    mov r13d, esi                  ; length (reused for theta below)
    lea r14, [r12 + r13]           ; end pointer
    xor r15d, r15d                 ; pipeline = 0

.next:
    cmp r12, r14
    jge .done

    movzx eax, byte [r12]

    cmp al, 0xFC
    jae .control

    ; ── decode wave byte → 4 coordinates ──
    movzx ebx, al
    inc r12

    ; A = bits [7:6]
    mov ecx, ebx
    shr ecx, 6
    cmp ecx, 2
    jne .A_done
    movsx edi, byte [r12]
    inc r12
    jmp .dec_B
.A_done:
    movsx edi, byte [_decode_tbl + rcx]

.dec_B:
    mov ecx, ebx
    shr ecx, 4
    and ecx, 3
    cmp ecx, 2
    jne .B_done
    movsx esi, byte [r12]
    inc r12
    jmp .dec_C
.B_done:
    movsx esi, byte [_decode_tbl + rcx]

.dec_C:
    mov ecx, ebx
    shr ecx, 2
    and ecx, 3
    cmp ecx, 2
    jne .C_done
    movsx edx, byte [r12]
    inc r12
    jmp .dec_D
.C_done:
    movsx edx, byte [_decode_tbl + rcx]

.dec_D:
    mov ecx, ebx
    and ecx, 3
    cmp ecx, 2
    jne .D_done
    movsx ecx, byte [r12]
    inc r12
    jmp .theta
.D_done:
    movsx ecx, byte [_decode_tbl + rcx]

    ; ── theta byte ──
.theta:
    movzx r13d, byte [r12]
    inc r12

    ; ── classify: atom or bond? ──
    mov eax, edi
    or eax, esi
    or eax, edx
    or eax, ecx
    test eax, 1
    jnz .bond

    ; ── atom path ──
    ; For now atoms that reach here are mul (A=2,B=2).
    ; Load args and multiply.
    call .load_args
    mov rax, rdi
    imul rax, rsi
    mov r15, rax
    mov [_rho], rax
    jmp .next

    ; ── bond path ──
.bond:
    push rdi
    push rsi
    push rdx
    push rcx
    call bond_dispatch
    mov rbx, rax
    pop rcx
    pop rdx
    pop rsi
    pop rdi

    call .load_args
    mov rcx, r15                   ; arg3 = pipeline

    call rbx
    mov r15, rax
    mov [_rho], rax
    jmp .next

    ; ── control bytes ──
.control:
    mov ebx, [r12+1]

    cmp al, 0xFE
    je .skip_z
    cmp al, 0xFD
    je .skip_nz
    ; 0xFC = loop_back
    test r15, r15
    jz .ctrl_done
    sub r12, rbx
    jmp .ctrl_done

.skip_z:
    test r15, r15
    jnz .ctrl_done
    add r12, rbx
    jmp .ctrl_done

.skip_nz:
    test r15, r15
    jz .ctrl_done
    add r12, rbx

.ctrl_done:
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

; ── load_args: load 3 args per theta byte (r13d) ──
.load_args:
    ; arg0 → rdi
    mov eax, r13d
    and eax, 3
    jz .la0_pipe
    cmp eax, 1
    je .la0_u8
    cmp eax, 2
    je .la0_u32
    mov rdi, [r12]
    add r12, 8
    jmp .la0_ok
.la0_u8:
    movzx edi, byte [r12]
    inc r12
    jmp .la0_ok
.la0_u32:
    mov edi, [r12]
    add r12, 4
    jmp .la0_ok
.la0_pipe:
    mov rdi, r15
.la0_ok:
    ; arg1 → rsi
    mov eax, r13d
    shr eax, 2
    and eax, 3
    jz .la1_pipe
    cmp eax, 1
    je .la1_u8
    cmp eax, 2
    je .la1_u32
    mov rsi, [r12]
    add r12, 8
    jmp .la1_ok
.la1_u8:
    movzx esi, byte [r12]
    inc r12
    jmp .la1_ok
.la1_u32:
    mov esi, [r12]
    add r12, 4
    jmp .la1_ok
.la1_pipe:
    mov rsi, r15
.la1_ok:
    ; arg2 → rdx
    mov eax, r13d
    shr eax, 4
    and eax, 3
    jz .la2_pipe
    cmp eax, 1
    je .la2_u8
    cmp eax, 2
    je .la2_u32
    mov rdx, [r12]
    add r12, 8
    jmp .la2_ok
.la2_u8:
    movzx edx, byte [r12]
    inc r12
    jmp .la2_ok
.la2_u32:
    mov edx, [r12]
    add r12, 4
    jmp .la2_ok
.la2_pipe:
    mov rdx, r15
.la2_ok:
    ret


; ══════════════════════════════════════════════════════════════
; NOMOS — bond dispatch
; ══════════════════════════════════════════════════════════════
;
; edi=A esi=B edx=C ecx=D → rax = function pointer

bond_dispatch:
    xor eax, eax
    test edi, 1
    jz .no_mem
    or eax, 1
.no_mem:
    test esi, 1
    jz .no_call
    or eax, 2
.no_call:
    test edx, 1
    jz .no_loop
    or eax, 4
.no_loop:
    test ecx, 1
    jz .no_test
    or eax, 8
.no_test:
    ; eax = force pattern 0-15

    cmp eax, 4
    je .p_loop
    cmp eax, 8
    je .p_test
    cmp eax, 9
    je .p_filter

    mov rax, fn_identity
    ret

    ; ── loop (C odd) ──
.p_loop:
    test edx, edx
    js .p_inc
    mov rax, fn_identity
    ret
.p_inc:
    mov rax, fn_inc
    ret

    ; ── test (D odd only) — sub-dispatch by |D| ──
.p_test:
    mov eax, ecx
    mov r8d, eax
    test eax, eax
    jns .pt_abs
    neg eax
.pt_abs:
    cmp eax, 1
    je .pt_eq
    cmp eax, 3
    je .pt_and
    cmp eax, 5
    je .pt_xor
    cmp eax, 7
    je .pt_shl
    cmp eax, 9
    je .pt_mod
    cmp eax, 11
    je .pt_lt
    cmp eax, 13
    je .pt_neg
    cmp eax, 15
    je .pt_scratch
    cmp eax, 17
    je .pt_sadd
    cmp eax, 19
    je .pt_smod
    cmp eax, 21
    je .pt_scratch64
    cmp eax, 23
    je .pt_sadd64
    cmp eax, 25
    je .pt_cdmul_d2
    cmp eax, 35
    je .pt_smoddiv64
    cmp eax, 37
    je .pt_gcd64
    cmp eax, 39
    je .pt_siadd64
    cmp eax, 45
    je .pt_cdmul_d4
    cmp eax, 47
    je .pt_cdmul_d8
    cmp eax, 49
    je .pt_cdmul_d16
    cmp eax, 51
    je .pt_cdmul_d32
    mov rax, fn_identity
    ret

.pt_eq:
    test r8d, r8d
    js .pt_guard
    mov rax, fn_test_eq
    ret
.pt_guard:
    mov rax, fn_guard
    ret
.pt_and:
    test r8d, r8d
    js .pt_or
    mov rax, fn_and
    ret
.pt_or:
    mov rax, fn_or
    ret
.pt_xor:
    test r8d, r8d
    js .pt_not
    mov rax, fn_xor
    ret
.pt_not:
    mov rax, fn_not
    ret
.pt_shl:
    test r8d, r8d
    js .pt_shr
    mov rax, fn_shl
    ret
.pt_shr:
    mov rax, fn_shr
    ret
.pt_mod:
    test r8d, r8d
    js .pt_div
    mov rax, fn_mod
    ret
.pt_div:
    mov rax, fn_div
    ret
.pt_lt:
    test r8d, r8d
    js .pt_gt
    mov rax, fn_lt
    ret
.pt_gt:
    mov rax, fn_gt
    ret
.pt_neg:
    test r8d, r8d
    js .pt_abs_fn
    mov rax, fn_negate
    ret
.pt_abs_fn:
    mov rax, fn_abs
    ret
.pt_scratch:
    test r8d, r8d
    js .pt_sw32
    mov rax, fn_scratch_read32
    ret
.pt_sw32:
    mov rax, fn_scratch_write32
    ret
.pt_sadd:
    test r8d, r8d
    js .pt_ssub
    mov rax, fn_scratch_add32
    ret
.pt_ssub:
    mov rax, fn_scratch_sub32
    ret
.pt_smod:
    mov rax, fn_scratch_mod32
    ret
.pt_scratch64:
    test r8d, r8d
    js .pt_sw64
    mov rax, fn_scratch_read64
    ret
.pt_sw64:
    mov rax, fn_scratch_write64
    ret
.pt_sadd64:
    test r8d, r8d
    js .pt_ssub64
    mov rax, fn_scratch_add64
    ret
.pt_ssub64:
    mov rax, fn_scratch_sub64
    ret
.pt_cdmul_d2:
    mov rax, fn_cd_mul_d2
    ret
.pt_smoddiv64:
    test r8d, r8d
    js .pt_sdiv64
    mov rax, fn_scratch_mod64
    ret
.pt_sdiv64:
    mov rax, fn_scratch_div64
    ret
.pt_gcd64:
    mov rax, fn_gcd64
    ret
.pt_siadd64:
    mov rax, fn_scratch_add_indirect64
    ret
.pt_cdmul_d4:
    mov rax, fn_cd_mul_d4
    ret
.pt_cdmul_d8:
    mov rax, fn_cd_mul_d8
    ret
.pt_cdmul_d16:
    mov rax, fn_cd_mul_d16
    ret
.pt_cdmul_d32:
    mov rax, fn_cd_mul_d32
    ret

    ; ── filter (A+D both odd) ──
.p_filter:
    mov eax, ecx
    mov r8d, eax
    test eax, eax
    jns .pf_abs
    neg eax
.pf_abs:
    test edi, edi
    js .pf_write
    ; +A: min/max
    cmp eax, 3
    je .pf_max
    mov rax, fn_min
    ret
.pf_max:
    mov rax, fn_max
    ret
.pf_write:
    ; -A: add/sub
    test r8d, r8d
    jns .pf_add_pos
    cmp eax, 3
    je .pf_sub
    mov rax, fn_add
    ret
.pf_sub:
    mov rax, fn_sub
    ret
.pf_add_pos:
    mov rax, fn_identity
    ret


; ══════════════════════════════════════════════════════════════
; BOND FUNCTIONS
; ══════════════════════════════════════════════════════════════

fn_identity:
    mov rax, rdi
    ret

fn_inc:
    lea rax, [rdi+1]
    ret

fn_add:
    mov rax, rdi
    add rax, rsi
    ret

fn_sub:
    mov rax, rdi
    sub rax, rsi
    ret

fn_test_eq:
    xor eax, eax
    cmp rdi, rsi
    sete al
    ret

fn_guard:
    mov rax, rcx
    test rsi, rsi
    cmovnz rax, rdi
    ret

fn_and:
    mov rax, rdi
    and rax, rsi
    ret

fn_or:
    mov rax, rdi
    or rax, rsi
    ret

fn_xor:
    mov rax, rdi
    xor rax, rsi
    ret

fn_not:
    mov rax, rdi
    not rax
    ret

fn_shl:
    mov rax, rdi
    mov ecx, esi
    shl rax, cl
    ret

fn_shr:
    mov rax, rdi
    mov ecx, esi
    shr rax, cl
    ret

fn_lt:
    xor eax, eax
    cmp rdi, rsi
    setl al
    ret

fn_gt:
    xor eax, eax
    cmp rdi, rsi
    setg al
    ret

fn_negate:
    mov rax, rdi
    neg rax
    ret

fn_abs:
    mov rax, rdi
    neg rax
    cmovs rax, rdi
    ret

fn_min:
    cmp rdi, rsi
    mov rax, rdi
    cmovg rax, rsi
    ret

fn_max:
    cmp rdi, rsi
    mov rax, rdi
    cmovl rax, rsi
    ret

fn_mod:
    xor edx, edx
    mov rax, rdi
    div rsi
    mov rax, rdx
    ret

fn_div:
    xor edx, edx
    mov rax, rdi
    div rsi
    ret

; ── scratch bonds ──

fn_scratch_read32:
    mov eax, dword [_scratch + rdi]
    ret

fn_scratch_write32:
    mov dword [_scratch + rsi], edi
    mov rax, rdi
    ret

fn_scratch_add32:
    mov eax, dword [_scratch + rdi]
    add rax, rcx
    ret

fn_scratch_sub32:
    mov eax, dword [_scratch + rdi]
    neg rax
    add rax, rcx
    ret

fn_scratch_mod32:
    mov esi, dword [_scratch + rdi]
    xor edx, edx
    mov rax, rcx
    div rsi
    mov rax, rdx
    ret

fn_scratch_read64:
    mov rax, qword [_scratch + rdi]
    ret

fn_scratch_write64:
    mov qword [_scratch + rsi], rdi
    mov rax, rdi
    ret

fn_scratch_add64:
    mov rax, qword [_scratch + rdi]
    add rax, rcx
    ret

fn_scratch_sub64:
    mov rax, qword [_scratch + rdi]
    neg rax
    add rax, rcx
    ret

fn_scratch_mod64:
    mov rsi, qword [_scratch + rdi]
    xor edx, edx
    mov rax, rcx
    div rsi
    mov rax, rdx
    ret

fn_scratch_div64:
    mov rsi, qword [_scratch + rdi]
    xor edx, edx
    mov rax, rcx
    div rsi
    ret

fn_gcd64:
    mov rdi, qword [_scratch + rdi]
    mov rsi, qword [_scratch + rsi]
    test rsi, rsi
    jz .gcd_done
.gcd_loop:
    xor edx, edx
    mov rax, rdi
    div rsi
    mov rdi, rsi
    mov rsi, rdx
    test rsi, rsi
    jnz .gcd_loop
.gcd_done:
    mov rax, rdi
    ret

fn_scratch_add_indirect64:
    mov rdx, qword [_scratch + rdi]
    add rdx, rsi
    mov qword [_scratch + rdi], rdx
    mov rax, rdx
    ret


; ══════════════════════════════════════════════════════════════
; CAYLEY-DICKSON MULTIPLICATION
; ══════════════════════════════════════════════════════════════

; ── d2 (complex) ──
fn_cd_mul_d2:
    push rdx
    mov r9,  qword [_scratch + rdi]
    mov r10, qword [_scratch + rdi + 8]
    mov r11, qword [_scratch + rsi]
    mov rcx, qword [_scratch + rsi + 8]

    mov rax, r9
    imul rax, r11
    mov rdi, r10
    imul rdi, rcx
    sub rax, rdi
    pop rdx
    mov qword [_scratch + rdx], rax

    mov rax, r9
    imul rax, rcx
    mov rdi, r10
    imul rdi, r11
    add rax, rdi
    mov qword [_scratch + rdx + 8], rax

    xor eax, eax
    ret

; ── d4 (quaternion) ──
fn_cd_mul_d4:
    push rbx
    push r12
    push r13
    push r14

    mov r9,  qword [_scratch + rdi]
    mov r10, qword [_scratch + rdi + 8]
    mov r11, qword [_scratch + rdi + 16]
    mov rcx, qword [_scratch + rdi + 24]

    mov r12, qword [_scratch + rsi]
    mov r13, qword [_scratch + rsi + 8]
    mov r14, qword [_scratch + rsi + 16]
    mov rdi, qword [_scratch + rsi + 24]

    ; out[0] = a0·b0 − a1·b1 − a2·b2 − a3·b3
    mov rbx, r9
    imul rbx, r12
    mov rax, rbx
    mov rbx, r10
    imul rbx, r13
    sub rax, rbx
    mov rbx, r11
    imul rbx, r14
    sub rax, rbx
    mov rbx, rcx
    imul rbx, rdi
    sub rax, rbx
    mov qword [_scratch + rdx], rax

    ; out[1] = a0·b1 + a1·b0 + a2·b3 − a3·b2
    mov rbx, r9
    imul rbx, r13
    mov rax, rbx
    mov rbx, r10
    imul rbx, r12
    add rax, rbx
    mov rbx, r11
    imul rbx, rdi
    add rax, rbx
    mov rbx, rcx
    imul rbx, r14
    sub rax, rbx
    mov qword [_scratch + rdx + 8], rax

    ; out[2] = a0·b2 − a1·b3 + a2·b0 + a3·b1
    mov rbx, r9
    imul rbx, r14
    mov rax, rbx
    mov rbx, r10
    imul rbx, rdi
    sub rax, rbx
    mov rbx, r11
    imul rbx, r12
    add rax, rbx
    mov rbx, rcx
    imul rbx, r13
    add rax, rbx
    mov qword [_scratch + rdx + 16], rax

    ; out[3] = a0·b3 + a1·b2 − a2·b1 + a3·b0
    mov rbx, r9
    imul rbx, rdi
    mov rax, rbx
    mov rbx, r10
    imul rbx, r14
    add rax, rbx
    mov rbx, r11
    imul rbx, r13
    sub rax, rbx
    mov rbx, rcx
    imul rbx, r12
    add rax, rbx
    mov qword [_scratch + rdx + 24], rax

    pop r14
    pop r13
    pop r12
    pop rbx
    xor eax, eax
    ret

; ── CD generic doubling helper macros ──
; (A,B)·(C,D) = (AC − conj(D)·B, D·A + B·conj(C))

%macro CD_DOUBLING 3  ; %1=fn_name, %2=lower_fn, %3=half_components
    ; half_bytes = %3 * 8
    %assign _hb (%3 * 8)
    ; temp offsets (non-overlapping with other levels)
    ; d8:  half=4, temp at 3072
    ; d16: half=8, temp at 2560
    ; d32: half=16, temp at 1536
    %if %3 == 4
        %assign _tmp 3072
    %elif %3 == 8
        %assign _tmp 2560
    %elif %3 == 16
        %assign _tmp 1536
    %endif

%1:
    push rbp
    mov rbp, rsp
    push rbx
    push r12
    push r13
    push r14
    push r15
    sub rsp, 8                     ; align

    mov r12, rdi                   ; a_ofs
    mov r13, rsi                   ; b_ofs
    mov r14, rdx                   ; out_ofs

    ; conj(D): D = b[_hb..], negate non-real
    mov rax, qword [_scratch + r13 + _hb]
    mov qword [_scratch + _tmp], rax
    %assign _ci 1
    %rep (%3 - 1)
        mov rax, qword [_scratch + r13 + _hb + _ci*8]
        neg rax
        mov qword [_scratch + _tmp + _ci*8], rax
    %assign _ci _ci+1
    %endrep

    ; conj(C): C = b[0..], negate non-real
    mov rax, qword [_scratch + r13]
    mov qword [_scratch + _tmp + _hb], rax
    %assign _ci 1
    %rep (%3 - 1)
        mov rax, qword [_scratch + r13 + _ci*8]
        neg rax
        mov qword [_scratch + _tmp + _hb + _ci*8], rax
    %assign _ci _ci+1
    %endrep

    ; tmp1 = A · C
    mov rdi, r12
    mov rsi, r13
    lea rdx, [_tmp + 2*_hb]
    call %2

    ; tmp2 = conj(D) · B
    lea rdi, [_tmp]
    lea rsi, [r12 + _hb]
    lea rdx, [_tmp + 3*_hb]
    call %2

    ; out[0..half] = tmp1 - tmp2
    %assign _ci 0
    %rep %3
        mov rax, qword [_scratch + _tmp + 2*_hb + _ci*8]
        sub rax, qword [_scratch + _tmp + 3*_hb + _ci*8]
        mov qword [_scratch + r14 + _ci*8], rax
    %assign _ci _ci+1
    %endrep

    ; tmp1 = D · A
    lea rdi, [r13 + _hb]
    mov rsi, r12
    lea rdx, [_tmp + 2*_hb]
    call %2

    ; tmp2 = B · conj(C)
    lea rdi, [r12 + _hb]
    lea rsi, [_tmp + _hb]
    lea rdx, [_tmp + 3*_hb]
    call %2

    ; out[half..] = tmp1 + tmp2
    %assign _ci 0
    %rep %3
        mov rax, qword [_scratch + _tmp + 2*_hb + _ci*8]
        add rax, qword [_scratch + _tmp + 3*_hb + _ci*8]
        mov qword [_scratch + r14 + _hb + _ci*8], rax
    %assign _ci _ci+1
    %endrep

    add rsp, 8
    pop r15
    pop r14
    pop r13
    pop r12
    pop rbx
    pop rbp
    xor eax, eax
    ret
%endmacro

CD_DOUBLING fn_cd_mul_d8,  fn_cd_mul_d4,  4
CD_DOUBLING fn_cd_mul_d16, fn_cd_mul_d8,  8
CD_DOUBLING fn_cd_mul_d32, fn_cd_mul_d16, 16


; ══════════════════════════════════════════════════════════════
; DATA
; ══════════════════════════════════════════════════════════════

align 4
_decode_tbl:
    db  0                            ; 00 → 0
    db  1                            ; 01 → +1
    db  0                            ; 10 → extended (not used directly)
    db -1                            ; 11 → -1

; Walk data — fixed 64KB buffer. Injection replaces bytes in-place.
align 4
_walk_len: dd 4                      ; patched by run script
_walk_data:
    db 0xC3, 0x05, 8, 8             ; default: add θ¹¹ρ 8 8
    times 65536-4 db 0              ; pre-allocated walk space
_walk_end:

_data_end:

; ══════════════════════════════════════════════════════════════
; BSS (uninitialized, zeroed by QEMU/multiboot)
; ══════════════════════════════════════════════════════════════

align 4096
_pml4: times 4096 db 0
_pdpt: times 4096 db 0
_pd:   times 4096 db 0

align 64
_scratch: times 4096 db 0

align 8
_rho: dq 0

align 16
_stack_bottom: times 16384 db 0
_stack_top:

_bss_end:
