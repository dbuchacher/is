; shell_gcd_N4.w — full Tier C pipeline at N=4. Expected: 5.
;
; Structurally identical to shell_gcd_N3, with different N-specific
; constants: 5 cells instead of 4, B=80, D=[16, 32, 24, 8, 1].
;
; N=4 is the first N where `odd_part(x_N) ≠ x_N`:
;   x_4 = 40 = 8·5,  odd_part(40) = 5
; Expected gcd(g) = 5 per the known-answer table.
;
; Expected A_z from phase 1: [0, 20, 2, 2, 0]
; Expected g_z:               [0, 25, 5, 5, 0]
; Expected gcd_total:         gcd(0, 25, 5, 5, 0) = 5

; ══════════════════════════════════════════════════════════
; Init: zero A_z counters and set phase 1 constants
; ══════════════════════════════════════════════════════════

swrite64 θ¹¹ρ 0 60               ; A_0 = 0
swrite64 θ¹¹ρ 0 68               ; A_1 = 0
swrite64 θ¹¹ρ 0 76               ; A_2 = 0
swrite64 θ¹¹ρ 0 84               ; A_3 = 0
swrite64 θ¹¹ρ 0 92               ; A_4 = 0

swrite32 θ¹¹ρ  4 164             ; N = 4
swrite32 θ¹¹ρ 40 168             ; x_N = 40

; ══════════════════════════════════════════════════════════
; Phase 1: prime enumeration + cell classification
; ══════════════════════════════════════════════════════════

@include ../../inc/shell_phase1.winc

; After phase 1:
;   scratch[60..100]  = A_z counters (expected [0, 20, 2, 2, 0])
;   scratch[172]      = pi_count (expected 12)

; ══════════════════════════════════════════════════════════
; Phase 2: per-cell reduction (5 cells for N=4)
; ══════════════════════════════════════════════════════════

; Compute C = 2·pi_count = 24
sread32  θ¹ρρ 172
shl      θρ¹ρ  1
swrite64 θρ¹ρ 192                ; store C (u64)

; Init gcd_total = 0
swrite64 θ¹¹ρ 0 224

; ── Cell z=0 (D_0 = 16) ──
sread64  θ¹ρρ 60                 ; A_0 = 0
mul      θρ¹ρ 80                 ; num_0 = 0·80 = 0
swrite64 θρ¹ρ 200

sread64  θ¹ρρ 192                ; C = 24
mul      θρ¹ρ 16                 ; den_0 = 24·16 = 384
swrite64 θρ¹ρ 208

gcd64    θ¹¹ρ 200 208            ; gcd(0, 384) = 384
swrite64 θρ¹ρ 216

sread64  θ¹ρρ 200                ; pipeline = 0
sdiv64   θ¹ρρ 216                ; 0/384 = 0
swrite64 θρ¹ρ 208                ; g_0 = 0

gcd64    θ¹¹ρ 224 208            ; gcd(0, 0) = 0
swrite64 θρ¹ρ 224                ; gcd_total = 0

; ── Cell z=1 (D_1 = 32) ──
sread64  θ¹ρρ 68                 ; A_1 = 20
mul      θρ¹ρ 80                 ; num_1 = 20·80 = 1600
swrite64 θρ¹ρ 200

sread64  θ¹ρρ 192
mul      θρ¹ρ 32                 ; den_1 = 24·32 = 768
swrite64 θρ¹ρ 208

gcd64    θ¹¹ρ 200 208            ; gcd(1600, 768) = 64
swrite64 θρ¹ρ 216

sread64  θ¹ρρ 200
sdiv64   θ¹ρρ 216                ; 1600/64 = 25
swrite64 θρ¹ρ 208                ; g_1 = 25

gcd64    θ¹¹ρ 224 208            ; gcd(0, 25) = 25
swrite64 θρ¹ρ 224

; ── Cell z=2 (D_2 = 24) ──
sread64  θ¹ρρ 76                 ; A_2 = 2
mul      θρ¹ρ 80                 ; num_2 = 160
swrite64 θρ¹ρ 200

sread64  θ¹ρρ 192
mul      θρ¹ρ 24                 ; den_2 = 576
swrite64 θρ¹ρ 208

gcd64    θ¹¹ρ 200 208            ; gcd(160, 576) = 32
swrite64 θρ¹ρ 216

sread64  θ¹ρρ 200
sdiv64   θ¹ρρ 216                ; 160/32 = 5
swrite64 θρ¹ρ 208                ; g_2 = 5

gcd64    θ¹¹ρ 224 208            ; gcd(25, 5) = 5
swrite64 θρ¹ρ 224

; ── Cell z=3 (D_3 = 8) ──
sread64  θ¹ρρ 84                 ; A_3 = 2
mul      θρ¹ρ 80                 ; num_3 = 160
swrite64 θρ¹ρ 200

sread64  θ¹ρρ 192
mul      θρ¹ρ  8                 ; den_3 = 192
swrite64 θρ¹ρ 208

gcd64    θ¹¹ρ 200 208            ; gcd(160, 192) = 32
swrite64 θρ¹ρ 216

sread64  θ¹ρρ 200
sdiv64   θ¹ρρ 216                ; 160/32 = 5
swrite64 θρ¹ρ 208                ; g_3 = 5

gcd64    θ¹¹ρ 224 208            ; gcd(5, 5) = 5
swrite64 θρ¹ρ 224

; ── Cell z=4 (D_4 = 1) ──
sread64  θ¹ρρ 92                 ; A_4 = 0
mul      θρ¹ρ 80                 ; num_4 = 0
swrite64 θρ¹ρ 200

sread64  θ¹ρρ 192
mul      θρ¹ρ  1                 ; den_4 = 24
swrite64 θρ¹ρ 208

gcd64    θ¹¹ρ 200 208            ; gcd(0, 24) = 24
swrite64 θρ¹ρ 216

sread64  θ¹ρρ 200
sdiv64   θ¹ρρ 216                ; 0/24 = 0
swrite64 θρ¹ρ 208                ; g_4 = 0

gcd64    θ¹¹ρ 224 208            ; gcd(5, 0) = 5
swrite64 θρ¹ρ 224

; ══════════════════════════════════════════════════════════
; Phase 3: return gcd_total
; ══════════════════════════════════════════════════════════

sread64  θ¹ρρ 224                ; pipeline = gcd_total = expected 5
