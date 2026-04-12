; shell_gcd_N18.w — THE FIRST NEW FINDING.
;
; Expected: **532171 = 19 · 37 · 757**  (framework prediction)
;
; Alternatively: a proper divisor of 532171 if π(x_18) also happens to
; contain 19, 37, or 757 as factors. The wit-side prediction puts
; ~92% probability on exactly 532171, ~8% on a smaller divisor.
;
; If the walker returns 48427561 (full odd_part(x_18)), the refined
; theorem's characterization is wrong at N=18 — STOP and cross-check.
;
; Framework derivation of the prediction:
;
;   x_18 = 193710244 = 2² · 7 · 13 · 19 · 37 · 757
;   odd_part(x_18) = 48427561 = 7 · 13 · 19 · 37 · 757
;
;   For each odd prime factor p of x_18, check if p divides any
;   C(18, z) at prime-holding (odd) z:
;
;     p=7    divides C(18, 5), C(18, 13)    → STRIPPED
;     p=13   divides C(18, 7), (9), (11)    → STRIPPED
;     p=19   divides none                   → SURVIVES
;     p=37   divides none                   → SURVIVES
;     p=757  divides none                   → SURVIVES
;
;   Predicted gcd(g) = 19 · 37 · 757 = 532171
;
; N=18 constants:
;   x_18 = 193710244
;   B = 3^18 − 1 = 387420488
;   π(x_18) = ??? (computed by phase 1)
;   C = 2·π(x_18)
;
;   D_z = C(18, z) · 2^(18−z):
;     D_0  = 1 · 262144      = 262144
;     D_1  = 18 · 131072     = 2359296
;     D_2  = 153 · 65536     = 10027008
;     D_3  = 816 · 32768     = 26738688
;     D_4  = 3060 · 16384    = 50135040
;     D_5  = 8568 · 8192     = 70189056
;     D_6  = 18564 · 4096    = 76038144
;     D_7  = 31824 · 2048    = 65175552
;     D_8  = 43758 · 1024    = 44808192
;     D_9  = 48620 · 512     = 24893440
;     D_10 = 43758 · 256     = 11202048
;     D_11 = 31824 · 128     = 4073472
;     D_12 = 18564 · 64      = 1188096
;     D_13 = 8568 · 32       = 274176
;     D_14 = 3060 · 16       = 48960
;     D_15 = 816 · 8         = 6528
;     D_16 = 153 · 4         = 612
;     D_17 = 18 · 2          = 36
;     D_18 = 1 · 1           = 1
;
; Runtime expectation: ~60-90 seconds per test run.

; ══════════════════════════════════════════════════════════
; Init: zero 19 A_z counters and set phase 1 constants
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
swrite64 θ¹¹ρ 0 164              ; A_13
swrite64 θ¹¹ρ 0 172              ; A_14
swrite64 θ¹¹ρ 0 180              ; A_15
swrite64 θ¹¹ρ 0 188              ; A_16
swrite64 θ¹¹ρ 0 196              ; A_17
swrite64 θ¹¹ρ 0 204              ; A_18

swrite32 θ¹¹ρ  18 220            ; N = 18
swrite32 θ²¹ρ  193710244 224     ; x_N = 193710244

; ══════════════════════════════════════════════════════════
; Phase 1: prime enumeration via sieve + cell classification
; ══════════════════════════════════════════════════════════

@include ../../../inc/shell_phase1_sieve.winc

; After phase 1:
;   scratch[60..212]  = A_z counters (19 slots)
;   scratch[228]      = pi_count (computed during enumeration)

; ══════════════════════════════════════════════════════════
; Phase 2: per-cell reduction (19 cells for N=18)
; ══════════════════════════════════════════════════════════

; Compute C = 2·pi_count, store as u64 at [40..48]
sread32  θ¹ρρ 228
shl      θρ¹ρ  1
swrite64 θρ¹ρ 40

; Init gcd_total = 0
swrite64 θ¹¹ρ 0 24

; ── Cell z=0 (D_0 = 262144) ──
sread64  θ¹ρρ  60
mul      θρ²ρ 387420488
swrite64 θρ¹ρ  0
sread64  θ¹ρρ 40
mul      θρ²ρ 262144
swrite64 θρ¹ρ  8
gcd64    θ¹¹ρ  0   8
swrite64 θρ¹ρ 16
sread64  θ¹ρρ  0
sdiv64   θ¹ρρ 16
swrite64 θρ¹ρ  8
gcd64    θ¹¹ρ 24   8
swrite64 θρ¹ρ 24

; ── Cell z=1 (D_1 = 2359296) ──
sread64  θ¹ρρ  68
mul      θρ²ρ 387420488
swrite64 θρ¹ρ  0
sread64  θ¹ρρ 40
mul      θρ²ρ 2359296
swrite64 θρ¹ρ  8
gcd64    θ¹¹ρ  0   8
swrite64 θρ¹ρ 16
sread64  θ¹ρρ  0
sdiv64   θ¹ρρ 16
swrite64 θρ¹ρ  8
gcd64    θ¹¹ρ 24   8
swrite64 θρ¹ρ 24

; ── Cell z=2 (D_2 = 10027008) ──
sread64  θ¹ρρ  76
mul      θρ²ρ 387420488
swrite64 θρ¹ρ  0
sread64  θ¹ρρ 40
mul      θρ²ρ 10027008
swrite64 θρ¹ρ  8
gcd64    θ¹¹ρ  0   8
swrite64 θρ¹ρ 16
sread64  θ¹ρρ  0
sdiv64   θ¹ρρ 16
swrite64 θρ¹ρ  8
gcd64    θ¹¹ρ 24   8
swrite64 θρ¹ρ 24

; ── Cell z=3 (D_3 = 26738688) ──
sread64  θ¹ρρ  84
mul      θρ²ρ 387420488
swrite64 θρ¹ρ  0
sread64  θ¹ρρ 40
mul      θρ²ρ 26738688
swrite64 θρ¹ρ  8
gcd64    θ¹¹ρ  0   8
swrite64 θρ¹ρ 16
sread64  θ¹ρρ  0
sdiv64   θ¹ρρ 16
swrite64 θρ¹ρ  8
gcd64    θ¹¹ρ 24   8
swrite64 θρ¹ρ 24

; ── Cell z=4 (D_4 = 50135040) ──
sread64  θ¹ρρ  92
mul      θρ²ρ 387420488
swrite64 θρ¹ρ  0
sread64  θ¹ρρ 40
mul      θρ²ρ 50135040
swrite64 θρ¹ρ  8
gcd64    θ¹¹ρ  0   8
swrite64 θρ¹ρ 16
sread64  θ¹ρρ  0
sdiv64   θ¹ρρ 16
swrite64 θρ¹ρ  8
gcd64    θ¹¹ρ 24   8
swrite64 θρ¹ρ 24

; ── Cell z=5 (D_5 = 70189056) ──
sread64  θ¹ρρ 100
mul      θρ²ρ 387420488
swrite64 θρ¹ρ  0
sread64  θ¹ρρ 40
mul      θρ²ρ 70189056
swrite64 θρ¹ρ  8
gcd64    θ¹¹ρ  0   8
swrite64 θρ¹ρ 16
sread64  θ¹ρρ  0
sdiv64   θ¹ρρ 16
swrite64 θρ¹ρ  8
gcd64    θ¹¹ρ 24   8
swrite64 θρ¹ρ 24

; ── Cell z=6 (D_6 = 76038144) ──
sread64  θ¹ρρ 108
mul      θρ²ρ 387420488
swrite64 θρ¹ρ  0
sread64  θ¹ρρ 40
mul      θρ²ρ 76038144
swrite64 θρ¹ρ  8
gcd64    θ¹¹ρ  0   8
swrite64 θρ¹ρ 16
sread64  θ¹ρρ  0
sdiv64   θ¹ρρ 16
swrite64 θρ¹ρ  8
gcd64    θ¹¹ρ 24   8
swrite64 θρ¹ρ 24

; ── Cell z=7 (D_7 = 65175552) ──
sread64  θ¹ρρ 116
mul      θρ²ρ 387420488
swrite64 θρ¹ρ  0
sread64  θ¹ρρ 40
mul      θρ²ρ 65175552
swrite64 θρ¹ρ  8
gcd64    θ¹¹ρ  0   8
swrite64 θρ¹ρ 16
sread64  θ¹ρρ  0
sdiv64   θ¹ρρ 16
swrite64 θρ¹ρ  8
gcd64    θ¹¹ρ 24   8
swrite64 θρ¹ρ 24

; ── Cell z=8 (D_8 = 44808192) ──
sread64  θ¹ρρ 124
mul      θρ²ρ 387420488
swrite64 θρ¹ρ  0
sread64  θ¹ρρ 40
mul      θρ²ρ 44808192
swrite64 θρ¹ρ  8
gcd64    θ¹¹ρ  0   8
swrite64 θρ¹ρ 16
sread64  θ¹ρρ  0
sdiv64   θ¹ρρ 16
swrite64 θρ¹ρ  8
gcd64    θ¹¹ρ 24   8
swrite64 θρ¹ρ 24

; ── Cell z=9 (D_9 = 24893440) ──
sread64  θ¹ρρ 132
mul      θρ²ρ 387420488
swrite64 θρ¹ρ  0
sread64  θ¹ρρ 40
mul      θρ²ρ 24893440
swrite64 θρ¹ρ  8
gcd64    θ¹¹ρ  0   8
swrite64 θρ¹ρ 16
sread64  θ¹ρρ  0
sdiv64   θ¹ρρ 16
swrite64 θρ¹ρ  8
gcd64    θ¹¹ρ 24   8
swrite64 θρ¹ρ 24

; ── Cell z=10 (D_10 = 11202048) ──
sread64  θ¹ρρ 140
mul      θρ²ρ 387420488
swrite64 θρ¹ρ  0
sread64  θ¹ρρ 40
mul      θρ²ρ 11202048
swrite64 θρ¹ρ  8
gcd64    θ¹¹ρ  0   8
swrite64 θρ¹ρ 16
sread64  θ¹ρρ  0
sdiv64   θ¹ρρ 16
swrite64 θρ¹ρ  8
gcd64    θ¹¹ρ 24   8
swrite64 θρ¹ρ 24

; ── Cell z=11 (D_11 = 4073472) ──
sread64  θ¹ρρ 148
mul      θρ²ρ 387420488
swrite64 θρ¹ρ  0
sread64  θ¹ρρ 40
mul      θρ²ρ 4073472
swrite64 θρ¹ρ  8
gcd64    θ¹¹ρ  0   8
swrite64 θρ¹ρ 16
sread64  θ¹ρρ  0
sdiv64   θ¹ρρ 16
swrite64 θρ¹ρ  8
gcd64    θ¹¹ρ 24   8
swrite64 θρ¹ρ 24

; ── Cell z=12 (D_12 = 1188096) ──
sread64  θ¹ρρ 156
mul      θρ²ρ 387420488
swrite64 θρ¹ρ  0
sread64  θ¹ρρ 40
mul      θρ²ρ 1188096
swrite64 θρ¹ρ  8
gcd64    θ¹¹ρ  0   8
swrite64 θρ¹ρ 16
sread64  θ¹ρρ  0
sdiv64   θ¹ρρ 16
swrite64 θρ¹ρ  8
gcd64    θ¹¹ρ 24   8
swrite64 θρ¹ρ 24

; ── Cell z=13 (D_13 = 274176) ──
sread64  θ¹ρρ 164
mul      θρ²ρ 387420488
swrite64 θρ¹ρ  0
sread64  θ¹ρρ 40
mul      θρ²ρ 274176
swrite64 θρ¹ρ  8
gcd64    θ¹¹ρ  0   8
swrite64 θρ¹ρ 16
sread64  θ¹ρρ  0
sdiv64   θ¹ρρ 16
swrite64 θρ¹ρ  8
gcd64    θ¹¹ρ 24   8
swrite64 θρ¹ρ 24

; ── Cell z=14 (D_14 = 48960) ──
sread64  θ¹ρρ 172
mul      θρ²ρ 387420488
swrite64 θρ¹ρ  0
sread64  θ¹ρρ 40
mul      θρ²ρ 48960
swrite64 θρ¹ρ  8
gcd64    θ¹¹ρ  0   8
swrite64 θρ¹ρ 16
sread64  θ¹ρρ  0
sdiv64   θ¹ρρ 16
swrite64 θρ¹ρ  8
gcd64    θ¹¹ρ 24   8
swrite64 θρ¹ρ 24

; ── Cell z=15 (D_15 = 6528) ──
sread64  θ¹ρρ 180
mul      θρ²ρ 387420488
swrite64 θρ¹ρ  0
sread64  θ¹ρρ 40
mul      θρ²ρ 6528
swrite64 θρ¹ρ  8
gcd64    θ¹¹ρ  0   8
swrite64 θρ¹ρ 16
sread64  θ¹ρρ  0
sdiv64   θ¹ρρ 16
swrite64 θρ¹ρ  8
gcd64    θ¹¹ρ 24   8
swrite64 θρ¹ρ 24

; ── Cell z=16 (D_16 = 612) ──
sread64  θ¹ρρ 188
mul      θρ²ρ 387420488
swrite64 θρ¹ρ  0
sread64  θ¹ρρ 40
mul      θρ²ρ 612
swrite64 θρ¹ρ  8
gcd64    θ¹¹ρ  0   8
swrite64 θρ¹ρ 16
sread64  θ¹ρρ  0
sdiv64   θ¹ρρ 16
swrite64 θρ¹ρ  8
gcd64    θ¹¹ρ 24   8
swrite64 θρ¹ρ 24

; ── Cell z=17 (D_17 = 36) ──
sread64  θ¹ρρ 196
mul      θρ²ρ 387420488
swrite64 θρ¹ρ  0
sread64  θ¹ρρ 40
mul      θρ¹ρ 36
swrite64 θρ¹ρ  8
gcd64    θ¹¹ρ  0   8
swrite64 θρ¹ρ 16
sread64  θ¹ρρ  0
sdiv64   θ¹ρρ 16
swrite64 θρ¹ρ  8
gcd64    θ¹¹ρ 24   8
swrite64 θρ¹ρ 24

; ── Cell z=18 (D_18 = 1) ──
sread64  θ¹ρρ 204
mul      θρ²ρ 387420488
swrite64 θρ¹ρ  0
sread64  θ¹ρρ 40
mul      θρ¹ρ  1
swrite64 θρ¹ρ  8
gcd64    θ¹¹ρ  0   8
swrite64 θρ¹ρ 16
sread64  θ¹ρρ  0
sdiv64   θ¹ρρ 16
swrite64 θρ¹ρ  8
gcd64    θ¹¹ρ 24   8
swrite64 θρ¹ρ 24

; ══════════════════════════════════════════════════════════
; Phase 3: return gcd_total
; ══════════════════════════════════════════════════════════

sread64  θ¹ρρ 24
