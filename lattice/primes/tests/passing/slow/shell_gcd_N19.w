; shell_gcd_N19.w — N=19 shell-identity theorem, serial walker phase 1.
;
; Expected: **581130733 = x_19 = (3^19 − 1) / 2**
;
; N=19 is an odd prime, predicted clean-hold case (no stripping).
; The entire odd_part(x_19) = x_19 survives because no odd z in
; [1..18] yields v_19(C(19,z)) landing in an element of x_19's
; prime factorization beyond what the theorem already accounts for.
;
; If the walker returns 581130733, N=19 confirms "odd prime → clean
; hold" as the dominant regime. Any other return invalidates it and
; stop — diagnose before moving on.
;
; N=19 constants:
;   x_19 = 581130733   (= (3^19 − 1) / 2, which happens to be prime)
;   B    = 1162261466  (= 3^19 − 1)
;   π(x_19) ≈ 29.8 million (computed by phase 1)
;
;   D_z = C(19, z) · 2^(19−z):
;     D_0  = 1 · 524288      = 524288
;     D_1  = 19 · 262144     = 4980736
;     D_2  = 171 · 131072    = 22413312
;     D_3  = 969 · 65536     = 63504384
;     D_4  = 3876 · 32768    = 127008768
;     D_5  = 11628 · 16384   = 190513152
;     D_6  = 27132 · 8192    = 222265344
;     D_7  = 50388 · 4096    = 206389248
;     D_8  = 75582 · 2048    = 154791936
;     D_9  = 92378 · 1024    = 94595072
;     D_10 = 92378 · 512     = 47297536
;     D_11 = 75582 · 256     = 19348992
;     D_12 = 50388 · 128     = 6449664
;     D_13 = 27132 · 64      = 1736448
;     D_14 = 11628 · 32      = 372096
;     D_15 = 3876 · 16       = 62016
;     D_16 = 969 · 8         = 7752
;     D_17 = 171 · 4         = 684
;     D_18 = 19 · 2          = 38
;     D_19 = 1 · 1           = 1
;
;   Sum check: ΣD_z = 3^19 = 1162261467 ✓
;
; Slot layout (N=19 just fits):
;   [0..48)      phase 2 scratch (num, den, gcd_val, gcd_total, C)
;   [60..220)    A_z counters (20 u64 slots)
;   [280..316)   phase 1 state (shell_phase1_sieve.winc)
;
; Runtime expectation: serial walker phase 1 at N=19 enumerates
; ~30M primes. ~3-5 minutes scalar. The _c variant should be
; sub-second.

; ══════════════════════════════════════════════════════════
; Init: zero 20 A_z counters and set phase 1 constants
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
swrite64 θ¹¹ρ 0 212              ; A_19

swrite32 θ¹¹ρ  19 220            ; N = 19
swrite32 θ²¹ρ  581130733 224     ; x_N = 581130733

; ══════════════════════════════════════════════════════════
; Phase 1: prime enumeration via sieve + cell classification
; ══════════════════════════════════════════════════════════

@include ../../../inc/shell_phase1_sieve.winc

; ══════════════════════════════════════════════════════════
; Phase 2: per-cell reduction (20 cells for N=19)
; Uses LOW slots [0..48) to avoid A_z range.
; ══════════════════════════════════════════════════════════

; C = 2·pi_count (u64 at [40..48))
sread32  θ¹ρρ 228
shl      θρ¹ρ  1
swrite64 θρ¹ρ 40

; Init gcd_total = 0
swrite64 θ¹¹ρ 0 24

; ── Cell z=0 (D_0 = 524288) ──
sread64  θ¹ρρ  60
mul      θρ²ρ 1162261466
swrite64 θρ¹ρ  0
sread64  θ¹ρρ 40
mul      θρ²ρ 524288
swrite64 θρ¹ρ  8
gcd64    θ¹¹ρ  0   8
swrite64 θρ¹ρ 16
sread64  θ¹ρρ  0
sdiv64   θ¹ρρ 16
swrite64 θρ¹ρ  8
gcd64    θ¹¹ρ 24   8
swrite64 θρ¹ρ 24

; ── Cell z=1 (D_1 = 4980736) ──
sread64  θ¹ρρ  68
mul      θρ²ρ 1162261466
swrite64 θρ¹ρ  0
sread64  θ¹ρρ 40
mul      θρ²ρ 4980736
swrite64 θρ¹ρ  8
gcd64    θ¹¹ρ  0   8
swrite64 θρ¹ρ 16
sread64  θ¹ρρ  0
sdiv64   θ¹ρρ 16
swrite64 θρ¹ρ  8
gcd64    θ¹¹ρ 24   8
swrite64 θρ¹ρ 24

; ── Cell z=2 (D_2 = 22413312) ──
sread64  θ¹ρρ  76
mul      θρ²ρ 1162261466
swrite64 θρ¹ρ  0
sread64  θ¹ρρ 40
mul      θρ²ρ 22413312
swrite64 θρ¹ρ  8
gcd64    θ¹¹ρ  0   8
swrite64 θρ¹ρ 16
sread64  θ¹ρρ  0
sdiv64   θ¹ρρ 16
swrite64 θρ¹ρ  8
gcd64    θ¹¹ρ 24   8
swrite64 θρ¹ρ 24

; ── Cell z=3 (D_3 = 63504384) ──
sread64  θ¹ρρ  84
mul      θρ²ρ 1162261466
swrite64 θρ¹ρ  0
sread64  θ¹ρρ 40
mul      θρ²ρ 63504384
swrite64 θρ¹ρ  8
gcd64    θ¹¹ρ  0   8
swrite64 θρ¹ρ 16
sread64  θ¹ρρ  0
sdiv64   θ¹ρρ 16
swrite64 θρ¹ρ  8
gcd64    θ¹¹ρ 24   8
swrite64 θρ¹ρ 24

; ── Cell z=4 (D_4 = 127008768) ──
sread64  θ¹ρρ  92
mul      θρ²ρ 1162261466
swrite64 θρ¹ρ  0
sread64  θ¹ρρ 40
mul      θρ²ρ 127008768
swrite64 θρ¹ρ  8
gcd64    θ¹¹ρ  0   8
swrite64 θρ¹ρ 16
sread64  θ¹ρρ  0
sdiv64   θ¹ρρ 16
swrite64 θρ¹ρ  8
gcd64    θ¹¹ρ 24   8
swrite64 θρ¹ρ 24

; ── Cell z=5 (D_5 = 190513152) ──
sread64  θ¹ρρ 100
mul      θρ²ρ 1162261466
swrite64 θρ¹ρ  0
sread64  θ¹ρρ 40
mul      θρ²ρ 190513152
swrite64 θρ¹ρ  8
gcd64    θ¹¹ρ  0   8
swrite64 θρ¹ρ 16
sread64  θ¹ρρ  0
sdiv64   θ¹ρρ 16
swrite64 θρ¹ρ  8
gcd64    θ¹¹ρ 24   8
swrite64 θρ¹ρ 24

; ── Cell z=6 (D_6 = 222265344) ──
sread64  θ¹ρρ 108
mul      θρ²ρ 1162261466
swrite64 θρ¹ρ  0
sread64  θ¹ρρ 40
mul      θρ²ρ 222265344
swrite64 θρ¹ρ  8
gcd64    θ¹¹ρ  0   8
swrite64 θρ¹ρ 16
sread64  θ¹ρρ  0
sdiv64   θ¹ρρ 16
swrite64 θρ¹ρ  8
gcd64    θ¹¹ρ 24   8
swrite64 θρ¹ρ 24

; ── Cell z=7 (D_7 = 206389248) ──
sread64  θ¹ρρ 116
mul      θρ²ρ 1162261466
swrite64 θρ¹ρ  0
sread64  θ¹ρρ 40
mul      θρ²ρ 206389248
swrite64 θρ¹ρ  8
gcd64    θ¹¹ρ  0   8
swrite64 θρ¹ρ 16
sread64  θ¹ρρ  0
sdiv64   θ¹ρρ 16
swrite64 θρ¹ρ  8
gcd64    θ¹¹ρ 24   8
swrite64 θρ¹ρ 24

; ── Cell z=8 (D_8 = 154791936) ──
sread64  θ¹ρρ 124
mul      θρ²ρ 1162261466
swrite64 θρ¹ρ  0
sread64  θ¹ρρ 40
mul      θρ²ρ 154791936
swrite64 θρ¹ρ  8
gcd64    θ¹¹ρ  0   8
swrite64 θρ¹ρ 16
sread64  θ¹ρρ  0
sdiv64   θ¹ρρ 16
swrite64 θρ¹ρ  8
gcd64    θ¹¹ρ 24   8
swrite64 θρ¹ρ 24

; ── Cell z=9 (D_9 = 94595072) ──
sread64  θ¹ρρ 132
mul      θρ²ρ 1162261466
swrite64 θρ¹ρ  0
sread64  θ¹ρρ 40
mul      θρ²ρ 94595072
swrite64 θρ¹ρ  8
gcd64    θ¹¹ρ  0   8
swrite64 θρ¹ρ 16
sread64  θ¹ρρ  0
sdiv64   θ¹ρρ 16
swrite64 θρ¹ρ  8
gcd64    θ¹¹ρ 24   8
swrite64 θρ¹ρ 24

; ── Cell z=10 (D_10 = 47297536) ──
sread64  θ¹ρρ 140
mul      θρ²ρ 1162261466
swrite64 θρ¹ρ  0
sread64  θ¹ρρ 40
mul      θρ²ρ 47297536
swrite64 θρ¹ρ  8
gcd64    θ¹¹ρ  0   8
swrite64 θρ¹ρ 16
sread64  θ¹ρρ  0
sdiv64   θ¹ρρ 16
swrite64 θρ¹ρ  8
gcd64    θ¹¹ρ 24   8
swrite64 θρ¹ρ 24

; ── Cell z=11 (D_11 = 19348992) ──
sread64  θ¹ρρ 148
mul      θρ²ρ 1162261466
swrite64 θρ¹ρ  0
sread64  θ¹ρρ 40
mul      θρ²ρ 19348992
swrite64 θρ¹ρ  8
gcd64    θ¹¹ρ  0   8
swrite64 θρ¹ρ 16
sread64  θ¹ρρ  0
sdiv64   θ¹ρρ 16
swrite64 θρ¹ρ  8
gcd64    θ¹¹ρ 24   8
swrite64 θρ¹ρ 24

; ── Cell z=12 (D_12 = 6449664) ──
sread64  θ¹ρρ 156
mul      θρ²ρ 1162261466
swrite64 θρ¹ρ  0
sread64  θ¹ρρ 40
mul      θρ²ρ 6449664
swrite64 θρ¹ρ  8
gcd64    θ¹¹ρ  0   8
swrite64 θρ¹ρ 16
sread64  θ¹ρρ  0
sdiv64   θ¹ρρ 16
swrite64 θρ¹ρ  8
gcd64    θ¹¹ρ 24   8
swrite64 θρ¹ρ 24

; ── Cell z=13 (D_13 = 1736448) ──
sread64  θ¹ρρ 164
mul      θρ²ρ 1162261466
swrite64 θρ¹ρ  0
sread64  θ¹ρρ 40
mul      θρ²ρ 1736448
swrite64 θρ¹ρ  8
gcd64    θ¹¹ρ  0   8
swrite64 θρ¹ρ 16
sread64  θ¹ρρ  0
sdiv64   θ¹ρρ 16
swrite64 θρ¹ρ  8
gcd64    θ¹¹ρ 24   8
swrite64 θρ¹ρ 24

; ── Cell z=14 (D_14 = 372096) ──
sread64  θ¹ρρ 172
mul      θρ²ρ 1162261466
swrite64 θρ¹ρ  0
sread64  θ¹ρρ 40
mul      θρ²ρ 372096
swrite64 θρ¹ρ  8
gcd64    θ¹¹ρ  0   8
swrite64 θρ¹ρ 16
sread64  θ¹ρρ  0
sdiv64   θ¹ρρ 16
swrite64 θρ¹ρ  8
gcd64    θ¹¹ρ 24   8
swrite64 θρ¹ρ 24

; ── Cell z=15 (D_15 = 62016) ──
sread64  θ¹ρρ 180
mul      θρ²ρ 1162261466
swrite64 θρ¹ρ  0
sread64  θ¹ρρ 40
mul      θρ²ρ 62016
swrite64 θρ¹ρ  8
gcd64    θ¹¹ρ  0   8
swrite64 θρ¹ρ 16
sread64  θ¹ρρ  0
sdiv64   θ¹ρρ 16
swrite64 θρ¹ρ  8
gcd64    θ¹¹ρ 24   8
swrite64 θρ¹ρ 24

; ── Cell z=16 (D_16 = 7752) ──
sread64  θ¹ρρ 188
mul      θρ²ρ 1162261466
swrite64 θρ¹ρ  0
sread64  θ¹ρρ 40
mul      θρ²ρ 7752
swrite64 θρ¹ρ  8
gcd64    θ¹¹ρ  0   8
swrite64 θρ¹ρ 16
sread64  θ¹ρρ  0
sdiv64   θ¹ρρ 16
swrite64 θρ¹ρ  8
gcd64    θ¹¹ρ 24   8
swrite64 θρ¹ρ 24

; ── Cell z=17 (D_17 = 684) ──
sread64  θ¹ρρ 196
mul      θρ²ρ 1162261466
swrite64 θρ¹ρ  0
sread64  θ¹ρρ 40
mul      θρ²ρ 684
swrite64 θρ¹ρ  8
gcd64    θ¹¹ρ  0   8
swrite64 θρ¹ρ 16
sread64  θ¹ρρ  0
sdiv64   θ¹ρρ 16
swrite64 θρ¹ρ  8
gcd64    θ¹¹ρ 24   8
swrite64 θρ¹ρ 24

; ── Cell z=18 (D_18 = 38) ──
sread64  θ¹ρρ 204
mul      θρ²ρ 1162261466
swrite64 θρ¹ρ  0
sread64  θ¹ρρ 40
mul      θρ¹ρ 38
swrite64 θρ¹ρ  8
gcd64    θ¹¹ρ  0   8
swrite64 θρ¹ρ 16
sread64  θ¹ρρ  0
sdiv64   θ¹ρρ 16
swrite64 θρ¹ρ  8
gcd64    θ¹¹ρ 24   8
swrite64 θρ¹ρ 24

; ── Cell z=19 (D_19 = 1) ──
sread64  θ¹ρρ 212
mul      θρ²ρ 1162261466
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
; Phase 3: return gcd_total (expected 581130733)
; ══════════════════════════════════════════════════════════

sread64  θ¹ρρ 24
