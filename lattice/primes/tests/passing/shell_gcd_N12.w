; shell_gcd_N12.w — FIRST MACHINE-VERIFIED THEOREM FAILURE.
;
; Expected: 91 (NOT 33215 = odd_part(x_12))
;
; N=12 is the first N where the simple form of the shell-identity
; theorem FAILS. Per wit/thoughts/prime-lattice/findings/04-extended-N11-17.md:
;
;   x_12 = 265720 = 2³ · 5 · 7 · 13 · 73
;   π(x_12) = 23287 = 11 · 29 · 73
;   odd_part(x_12) = 33215 = 5 · 7 · 13 · 73
;
;   73 divides BOTH x_12 AND π(x_12) (Zsygmondy coincidence at N=12:
;   ord_73(3) = 12, so 73 first appears as a divisor of 3^N − 1 at
;   exactly N=12, AND 73 happens to divide the prime count). The gcd
;   reduction strips the 73 factor from `g_z`, dropping it to 91.
;
;   Also: 5 divides C(12, 3) = 220 = 2²·5·11, so 5 strips too.
;
;   Result: gcd(g) = 91 = 7 · 13  (losing 5 and 73 from odd_part)
;
; This is the celebrated test. When it returns 91, the lattice tool
; has machine-verified the refined theorem's failure characterization
; for the first time — previously only Python had computed this.
;
; N=12 constants:
;   N = 12, x_N = 265720, B = 531440 = 3^12 − 1
;   π(x_12) = 23287 (computed by phase 1)
;   C = 2·π(x_12) = 46574
;
;   D_z = C(12, z) · 2^(12−z):
;     D_0  = 1 · 4096   = 4096
;     D_1  = 12 · 2048  = 24576
;     D_2  = 66 · 1024  = 67584
;     D_3  = 220 · 512  = 112640
;     D_4  = 495 · 256  = 126720
;     D_5  = 792 · 128  = 101376
;     D_6  = 924 · 64   = 59136
;     D_7  = 792 · 32   = 25344
;     D_8  = 495 · 16   = 7920
;     D_9  = 220 · 8    = 1760
;     D_10 = 66 · 4     = 264
;     D_11 = 12 · 2     = 24
;     D_12 = 1 · 1      = 1
;
; Runtime: ~3-4 seconds per test run. First N where trial division
; slows the iteration loop. Sieve-backed Turn 11 will speed it up.

; ══════════════════════════════════════════════════════════
; Init: zero 13 A_z counters and set phase 1 constants
; ══════════════════════════════════════════════════════════

swrite64 θ¹¹ρ 0  60              ; A_0
swrite64 θ¹¹ρ 0  68              ; A_1
swrite64 θ¹¹ρ 0  76              ; A_2
swrite64 θ¹¹ρ 0  84              ; A_3
swrite64 θ¹¹ρ 0  92              ; A_4
swrite64 θ¹¹ρ 0 100              ; A_5
swrite64 θ¹¹ρ 0 108              ; A_6
swrite64 θ¹¹ρ 0 116              ; A_7
swrite64 θ¹¹ρ 0 124              ; A_8
swrite64 θ¹¹ρ 0 132              ; A_9
swrite64 θ¹¹ρ 0 140              ; A_10
swrite64 θ¹¹ρ 0 148              ; A_11
swrite64 θ¹¹ρ 0 156              ; A_12

swrite32 θ¹¹ρ  12 164            ; N = 12
swrite32 θ²¹ρ  265720 168        ; x_N = 265720 (u32 literal)

; ══════════════════════════════════════════════════════════
; Phase 1: prime enumeration + cell classification
; ══════════════════════════════════════════════════════════

@include ../../inc/shell_phase1.winc

; After phase 1:
;   scratch[60..164]   = A_z counters (13 slots)
;   scratch[172]       = pi_count (expected 23287)

; ══════════════════════════════════════════════════════════
; Phase 2: per-cell reduction (13 cells for N=12)
; B = 531440 (u32 literal, needed via θρ²ρ for multiplications)
; ══════════════════════════════════════════════════════════

; C = 2·pi_count (store as u64)
sread32  θ¹ρρ 172
shl      θρ¹ρ  1
swrite64 θρ¹ρ 192                ; C = 46574

; Init gcd_total = 0
swrite64 θ¹¹ρ 0 224

; ── Cell z=0 (D_0 = 4096) ──
sread64  θ¹ρρ  60                ; A_0
mul      θρ²ρ 531440             ; num_0 = A_0 · B (u32 literal for B)
swrite64 θρ¹ρ 200

sread64  θ¹ρρ 192                ; C
mul      θρ²ρ  4096              ; den_0 = C · D_0
swrite64 θρ¹ρ 208

gcd64    θ¹¹ρ 200 208
swrite64 θρ¹ρ 216

sread64  θ¹ρρ 200
sdiv64   θ¹ρρ 216
swrite64 θρ¹ρ 208

gcd64    θ¹¹ρ 224 208
swrite64 θρ¹ρ 224

; ── Cell z=1 (D_1 = 24576) ──
sread64  θ¹ρρ  68                ; A_1
mul      θρ²ρ 531440
swrite64 θρ¹ρ 200

sread64  θ¹ρρ 192
mul      θρ²ρ 24576
swrite64 θρ¹ρ 208

gcd64    θ¹¹ρ 200 208
swrite64 θρ¹ρ 216

sread64  θ¹ρρ 200
sdiv64   θ¹ρρ 216
swrite64 θρ¹ρ 208

gcd64    θ¹¹ρ 224 208
swrite64 θρ¹ρ 224

; ── Cell z=2 (D_2 = 67584) ──
sread64  θ¹ρρ  76
mul      θρ²ρ 531440
swrite64 θρ¹ρ 200

sread64  θ¹ρρ 192
mul      θρ²ρ 67584
swrite64 θρ¹ρ 208

gcd64    θ¹¹ρ 200 208
swrite64 θρ¹ρ 216

sread64  θ¹ρρ 200
sdiv64   θ¹ρρ 216
swrite64 θρ¹ρ 208

gcd64    θ¹¹ρ 224 208
swrite64 θρ¹ρ 224

; ── Cell z=3 (D_3 = 112640) ──
sread64  θ¹ρρ  84
mul      θρ²ρ 531440
swrite64 θρ¹ρ 200

sread64  θ¹ρρ 192
mul      θρ²ρ 112640
swrite64 θρ¹ρ 208

gcd64    θ¹¹ρ 200 208
swrite64 θρ¹ρ 216

sread64  θ¹ρρ 200
sdiv64   θ¹ρρ 216
swrite64 θρ¹ρ 208

gcd64    θ¹¹ρ 224 208
swrite64 θρ¹ρ 224

; ── Cell z=4 (D_4 = 126720) ──
sread64  θ¹ρρ  92
mul      θρ²ρ 531440
swrite64 θρ¹ρ 200

sread64  θ¹ρρ 192
mul      θρ²ρ 126720
swrite64 θρ¹ρ 208

gcd64    θ¹¹ρ 200 208
swrite64 θρ¹ρ 216

sread64  θ¹ρρ 200
sdiv64   θ¹ρρ 216
swrite64 θρ¹ρ 208

gcd64    θ¹¹ρ 224 208
swrite64 θρ¹ρ 224

; ── Cell z=5 (D_5 = 101376) ──
sread64  θ¹ρρ 100
mul      θρ²ρ 531440
swrite64 θρ¹ρ 200

sread64  θ¹ρρ 192
mul      θρ²ρ 101376
swrite64 θρ¹ρ 208

gcd64    θ¹¹ρ 200 208
swrite64 θρ¹ρ 216

sread64  θ¹ρρ 200
sdiv64   θ¹ρρ 216
swrite64 θρ¹ρ 208

gcd64    θ¹¹ρ 224 208
swrite64 θρ¹ρ 224

; ── Cell z=6 (D_6 = 59136) ──
sread64  θ¹ρρ 108
mul      θρ²ρ 531440
swrite64 θρ¹ρ 200

sread64  θ¹ρρ 192
mul      θρ²ρ 59136
swrite64 θρ¹ρ 208

gcd64    θ¹¹ρ 200 208
swrite64 θρ¹ρ 216

sread64  θ¹ρρ 200
sdiv64   θ¹ρρ 216
swrite64 θρ¹ρ 208

gcd64    θ¹¹ρ 224 208
swrite64 θρ¹ρ 224

; ── Cell z=7 (D_7 = 25344) ──
sread64  θ¹ρρ 116
mul      θρ²ρ 531440
swrite64 θρ¹ρ 200

sread64  θ¹ρρ 192
mul      θρ²ρ 25344
swrite64 θρ¹ρ 208

gcd64    θ¹¹ρ 200 208
swrite64 θρ¹ρ 216

sread64  θ¹ρρ 200
sdiv64   θ¹ρρ 216
swrite64 θρ¹ρ 208

gcd64    θ¹¹ρ 224 208
swrite64 θρ¹ρ 224

; ── Cell z=8 (D_8 = 7920) ──
sread64  θ¹ρρ 124
mul      θρ²ρ 531440
swrite64 θρ¹ρ 200

sread64  θ¹ρρ 192
mul      θρ²ρ 7920
swrite64 θρ¹ρ 208

gcd64    θ¹¹ρ 200 208
swrite64 θρ¹ρ 216

sread64  θ¹ρρ 200
sdiv64   θ¹ρρ 216
swrite64 θρ¹ρ 208

gcd64    θ¹¹ρ 224 208
swrite64 θρ¹ρ 224

; ── Cell z=9 (D_9 = 1760) ──
sread64  θ¹ρρ 132
mul      θρ²ρ 531440
swrite64 θρ¹ρ 200

sread64  θ¹ρρ 192
mul      θρ²ρ 1760
swrite64 θρ¹ρ 208

gcd64    θ¹¹ρ 200 208
swrite64 θρ¹ρ 216

sread64  θ¹ρρ 200
sdiv64   θ¹ρρ 216
swrite64 θρ¹ρ 208

gcd64    θ¹¹ρ 224 208
swrite64 θρ¹ρ 224

; ── Cell z=10 (D_10 = 264) ──
sread64  θ¹ρρ 140
mul      θρ²ρ 531440
swrite64 θρ¹ρ 200

sread64  θ¹ρρ 192
mul      θρ²ρ 264
swrite64 θρ¹ρ 208

gcd64    θ¹¹ρ 200 208
swrite64 θρ¹ρ 216

sread64  θ¹ρρ 200
sdiv64   θ¹ρρ 216
swrite64 θρ¹ρ 208

gcd64    θ¹¹ρ 224 208
swrite64 θρ¹ρ 224

; ── Cell z=11 (D_11 = 24) ──
sread64  θ¹ρρ 148
mul      θρ²ρ 531440
swrite64 θρ¹ρ 200

sread64  θ¹ρρ 192
mul      θρ¹ρ  24
swrite64 θρ¹ρ 208

gcd64    θ¹¹ρ 200 208
swrite64 θρ¹ρ 216

sread64  θ¹ρρ 200
sdiv64   θ¹ρρ 216
swrite64 θρ¹ρ 208

gcd64    θ¹¹ρ 224 208
swrite64 θρ¹ρ 224

; ── Cell z=12 (D_12 = 1) ──
sread64  θ¹ρρ 156
mul      θρ²ρ 531440
swrite64 θρ¹ρ 200

sread64  θ¹ρρ 192
mul      θρ¹ρ   1
swrite64 θρ¹ρ 208

gcd64    θ¹¹ρ 200 208
swrite64 θρ¹ρ 216

sread64  θ¹ρρ 200
sdiv64   θ¹ρρ 216
swrite64 θρ¹ρ 208

gcd64    θ¹¹ρ 224 208
swrite64 θρ¹ρ 224

; ══════════════════════════════════════════════════════════
; Phase 3: return gcd_total (expected 91)
; ══════════════════════════════════════════════════════════

sread64  θ¹ρρ 224
