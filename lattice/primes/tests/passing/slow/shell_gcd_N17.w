; shell_gcd_N17.w — full Tier C pipeline at N=17 using the sieve.
;
; Expected: 64570081 = odd_part(x_17) (theorem HOLDS at N=17)
;
; N=17 is a known-hold case: prime N with a single Zsygmondy-primitive
; divisor makes the theorem's simple form apply. From the known-answer
; table: gcd(g) = odd_part(x_17) = 64570081 = x_17 itself (since x_17
; is odd and prime — in fact x_17 IS 64570081 and IS prime).
;
; This is the first test at 10⁸ scale. Trial division at N=17 via
; is_prime.winc would take ~3-4 minutes. With the sieve bond it runs
; in ~10-30 seconds (the dominant cost is now the ~3.8M decoder
; iterations, not primality testing).
;
; N=17 constants:
;   x_17 = 64570081  (also happens to be prime, per the framework note)
;   B = 3^17 − 1 = 129140162
;   π(x_17) = 3816776 (computed by phase 1)
;   C = 2·π(x_17) = 7633552
;
;   D_z = C(17, z) · 2^(17−z):
;     D_0  = 1 · 131072      = 131072
;     D_1  = 17 · 65536      = 1114112
;     D_2  = 136 · 32768     = 4456448
;     D_3  = 680 · 16384     = 11141120
;     D_4  = 2380 · 8192     = 19496960
;     D_5  = 6188 · 4096     = 25346048
;     D_6  = 12376 · 2048    = 25346048
;     D_7  = 19448 · 1024    = 19914752
;     D_8  = 24310 · 512     = 12446720
;     D_9  = 24310 · 256     = 6223360
;     D_10 = 19448 · 128     = 2489344
;     D_11 = 12376 · 64      = 792064
;     D_12 = 6188 · 32       = 198016
;     D_13 = 2380 · 16       = 38080
;     D_14 = 680 · 8         = 5440
;     D_15 = 136 · 4         = 544
;     D_16 = 17 · 2          = 34
;     D_17 = 1 · 1           = 1
;
; Scratch layout:
;   [0..8)     phase 2 num temp
;   [8..16)    phase 2 den temp
;   [16..24)   phase 2 gcd_val temp
;   [24..32)   phase 2 gcd_total
;   [40..48)   phase 2 C (u64, reuses phase 1's n slot after phase 1 ends)
;   [60..204)  A_z counters (18 × 8 bytes for z = 0..17)
;   [220..256) phase 1 sieve state (N, x_N, pi_count, decoder)

; ══════════════════════════════════════════════════════════
; Init: zero 18 A_z counters and set phase 1 constants
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

swrite32 θ¹¹ρ  17 220            ; N = 17
swrite32 θ²¹ρ  64570081 224      ; x_N = 64570081

; ══════════════════════════════════════════════════════════
; Phase 1: prime enumeration via sieve + cell classification
; ══════════════════════════════════════════════════════════

@include ../../../inc/shell_phase1_sieve.winc

; After phase 1:
;   scratch[60..204] = A_z counters (18 slots)
;   scratch[228]     = pi_count (expected 3816776)

; ══════════════════════════════════════════════════════════
; Phase 2: per-cell reduction (18 cells for N=17)
; ══════════════════════════════════════════════════════════

; Read pi_count BEFORE overwriting phase 1 state slots
sread32  θ¹ρρ 228
shl      θρ¹ρ  1                 ; pipeline = 2·pi_count = C
swrite64 θρ¹ρ 40                 ; C at [40..48] (reuses phase 1 n slot)

; Init gcd_total = 0
swrite64 θ¹¹ρ 0 24

; ── Cell z=0 (D_0 = 131072) ──
sread64  θ¹ρρ  60
mul      θρ²ρ 129140162
swrite64 θρ¹ρ  0
sread64  θ¹ρρ 40
mul      θρ²ρ 131072
swrite64 θρ¹ρ  8
gcd64    θ¹¹ρ  0   8
swrite64 θρ¹ρ 16
sread64  θ¹ρρ  0
sdiv64   θ¹ρρ 16
swrite64 θρ¹ρ  8
gcd64    θ¹¹ρ 24   8
swrite64 θρ¹ρ 24

; ── Cell z=1 (D_1 = 1114112) ──
sread64  θ¹ρρ  68
mul      θρ²ρ 129140162
swrite64 θρ¹ρ  0
sread64  θ¹ρρ 40
mul      θρ²ρ 1114112
swrite64 θρ¹ρ  8
gcd64    θ¹¹ρ  0   8
swrite64 θρ¹ρ 16
sread64  θ¹ρρ  0
sdiv64   θ¹ρρ 16
swrite64 θρ¹ρ  8
gcd64    θ¹¹ρ 24   8
swrite64 θρ¹ρ 24

; ── Cell z=2 (D_2 = 4456448) ──
sread64  θ¹ρρ  76
mul      θρ²ρ 129140162
swrite64 θρ¹ρ  0
sread64  θ¹ρρ 40
mul      θρ²ρ 4456448
swrite64 θρ¹ρ  8
gcd64    θ¹¹ρ  0   8
swrite64 θρ¹ρ 16
sread64  θ¹ρρ  0
sdiv64   θ¹ρρ 16
swrite64 θρ¹ρ  8
gcd64    θ¹¹ρ 24   8
swrite64 θρ¹ρ 24

; ── Cell z=3 (D_3 = 11141120) ──
sread64  θ¹ρρ  84
mul      θρ²ρ 129140162
swrite64 θρ¹ρ  0
sread64  θ¹ρρ 40
mul      θρ²ρ 11141120
swrite64 θρ¹ρ  8
gcd64    θ¹¹ρ  0   8
swrite64 θρ¹ρ 16
sread64  θ¹ρρ  0
sdiv64   θ¹ρρ 16
swrite64 θρ¹ρ  8
gcd64    θ¹¹ρ 24   8
swrite64 θρ¹ρ 24

; ── Cell z=4 (D_4 = 19496960) ──
sread64  θ¹ρρ  92
mul      θρ²ρ 129140162
swrite64 θρ¹ρ  0
sread64  θ¹ρρ 40
mul      θρ²ρ 19496960
swrite64 θρ¹ρ  8
gcd64    θ¹¹ρ  0   8
swrite64 θρ¹ρ 16
sread64  θ¹ρρ  0
sdiv64   θ¹ρρ 16
swrite64 θρ¹ρ  8
gcd64    θ¹¹ρ 24   8
swrite64 θρ¹ρ 24

; ── Cell z=5 (D_5 = 25346048) ──
sread64  θ¹ρρ 100
mul      θρ²ρ 129140162
swrite64 θρ¹ρ  0
sread64  θ¹ρρ 40
mul      θρ²ρ 25346048
swrite64 θρ¹ρ  8
gcd64    θ¹¹ρ  0   8
swrite64 θρ¹ρ 16
sread64  θ¹ρρ  0
sdiv64   θ¹ρρ 16
swrite64 θρ¹ρ  8
gcd64    θ¹¹ρ 24   8
swrite64 θρ¹ρ 24

; ── Cell z=6 (D_6 = 25346048) ──
sread64  θ¹ρρ 108
mul      θρ²ρ 129140162
swrite64 θρ¹ρ  0
sread64  θ¹ρρ 40
mul      θρ²ρ 25346048
swrite64 θρ¹ρ  8
gcd64    θ¹¹ρ  0   8
swrite64 θρ¹ρ 16
sread64  θ¹ρρ  0
sdiv64   θ¹ρρ 16
swrite64 θρ¹ρ  8
gcd64    θ¹¹ρ 24   8
swrite64 θρ¹ρ 24

; ── Cell z=7 (D_7 = 19914752) ──
sread64  θ¹ρρ 116
mul      θρ²ρ 129140162
swrite64 θρ¹ρ  0
sread64  θ¹ρρ 40
mul      θρ²ρ 19914752
swrite64 θρ¹ρ  8
gcd64    θ¹¹ρ  0   8
swrite64 θρ¹ρ 16
sread64  θ¹ρρ  0
sdiv64   θ¹ρρ 16
swrite64 θρ¹ρ  8
gcd64    θ¹¹ρ 24   8
swrite64 θρ¹ρ 24

; ── Cell z=8 (D_8 = 12446720) ──
sread64  θ¹ρρ 124
mul      θρ²ρ 129140162
swrite64 θρ¹ρ  0
sread64  θ¹ρρ 40
mul      θρ²ρ 12446720
swrite64 θρ¹ρ  8
gcd64    θ¹¹ρ  0   8
swrite64 θρ¹ρ 16
sread64  θ¹ρρ  0
sdiv64   θ¹ρρ 16
swrite64 θρ¹ρ  8
gcd64    θ¹¹ρ 24   8
swrite64 θρ¹ρ 24

; ── Cell z=9 (D_9 = 6223360) ──
sread64  θ¹ρρ 132
mul      θρ²ρ 129140162
swrite64 θρ¹ρ  0
sread64  θ¹ρρ 40
mul      θρ²ρ 6223360
swrite64 θρ¹ρ  8
gcd64    θ¹¹ρ  0   8
swrite64 θρ¹ρ 16
sread64  θ¹ρρ  0
sdiv64   θ¹ρρ 16
swrite64 θρ¹ρ  8
gcd64    θ¹¹ρ 24   8
swrite64 θρ¹ρ 24

; ── Cell z=10 (D_10 = 2489344) ──
sread64  θ¹ρρ 140
mul      θρ²ρ 129140162
swrite64 θρ¹ρ  0
sread64  θ¹ρρ 40
mul      θρ²ρ 2489344
swrite64 θρ¹ρ  8
gcd64    θ¹¹ρ  0   8
swrite64 θρ¹ρ 16
sread64  θ¹ρρ  0
sdiv64   θ¹ρρ 16
swrite64 θρ¹ρ  8
gcd64    θ¹¹ρ 24   8
swrite64 θρ¹ρ 24

; ── Cell z=11 (D_11 = 792064) ──
sread64  θ¹ρρ 148
mul      θρ²ρ 129140162
swrite64 θρ¹ρ  0
sread64  θ¹ρρ 40
mul      θρ²ρ 792064
swrite64 θρ¹ρ  8
gcd64    θ¹¹ρ  0   8
swrite64 θρ¹ρ 16
sread64  θ¹ρρ  0
sdiv64   θ¹ρρ 16
swrite64 θρ¹ρ  8
gcd64    θ¹¹ρ 24   8
swrite64 θρ¹ρ 24

; ── Cell z=12 (D_12 = 198016) ──
sread64  θ¹ρρ 156
mul      θρ²ρ 129140162
swrite64 θρ¹ρ  0
sread64  θ¹ρρ 40
mul      θρ²ρ 198016
swrite64 θρ¹ρ  8
gcd64    θ¹¹ρ  0   8
swrite64 θρ¹ρ 16
sread64  θ¹ρρ  0
sdiv64   θ¹ρρ 16
swrite64 θρ¹ρ  8
gcd64    θ¹¹ρ 24   8
swrite64 θρ¹ρ 24

; ── Cell z=13 (D_13 = 38080) ──
sread64  θ¹ρρ 164
mul      θρ²ρ 129140162
swrite64 θρ¹ρ  0
sread64  θ¹ρρ 40
mul      θρ²ρ 38080
swrite64 θρ¹ρ  8
gcd64    θ¹¹ρ  0   8
swrite64 θρ¹ρ 16
sread64  θ¹ρρ  0
sdiv64   θ¹ρρ 16
swrite64 θρ¹ρ  8
gcd64    θ¹¹ρ 24   8
swrite64 θρ¹ρ 24

; ── Cell z=14 (D_14 = 5440) ──
sread64  θ¹ρρ 172
mul      θρ²ρ 129140162
swrite64 θρ¹ρ  0
sread64  θ¹ρρ 40
mul      θρ²ρ 5440
swrite64 θρ¹ρ  8
gcd64    θ¹¹ρ  0   8
swrite64 θρ¹ρ 16
sread64  θ¹ρρ  0
sdiv64   θ¹ρρ 16
swrite64 θρ¹ρ  8
gcd64    θ¹¹ρ 24   8
swrite64 θρ¹ρ 24

; ── Cell z=15 (D_15 = 544) ──
sread64  θ¹ρρ 180
mul      θρ²ρ 129140162
swrite64 θρ¹ρ  0
sread64  θ¹ρρ 40
mul      θρ²ρ 544
swrite64 θρ¹ρ  8
gcd64    θ¹¹ρ  0   8
swrite64 θρ¹ρ 16
sread64  θ¹ρρ  0
sdiv64   θ¹ρρ 16
swrite64 θρ¹ρ  8
gcd64    θ¹¹ρ 24   8
swrite64 θρ¹ρ 24

; ── Cell z=16 (D_16 = 34) ──
sread64  θ¹ρρ 188
mul      θρ²ρ 129140162
swrite64 θρ¹ρ  0
sread64  θ¹ρρ 40
mul      θρ¹ρ 34
swrite64 θρ¹ρ  8
gcd64    θ¹¹ρ  0   8
swrite64 θρ¹ρ 16
sread64  θ¹ρρ  0
sdiv64   θ¹ρρ 16
swrite64 θρ¹ρ  8
gcd64    θ¹¹ρ 24   8
swrite64 θρ¹ρ 24

; ── Cell z=17 (D_17 = 1) ──
sread64  θ¹ρρ 196
mul      θρ²ρ 129140162
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
; Phase 3: return gcd_total (expected 64570081)
; ══════════════════════════════════════════════════════════

sread64  θ¹ρρ 24
