; shell_gcd_N20.w — N=20 shell-identity, THE DISCRIMINATOR.
;
; Expected: one of
;     43584805 = 5¹ · 11² · 61 · 1181  → Kummer v_p form wins
;     8716961  =      11² · 61 · 1181  → simple full-strip form wins
;
; N=20 is the first N where the two candidate refinements of the
; shell-identity theorem can give different integers. N=3..18 all
; had v_p(odd_part(x_N)) = 1 for every strippable prime, so both
; forms collapsed to the same value. N=20 has v_5(odd_part(x_20)) = 2
; and max v_5(C(20, odd z)) = 1 — first chance to distinguish.
;
; N=20 constants:
;   x_20 = 1743392200  (= (3^20 − 1) / 2)
;        = 2³ · 5² · 11² · 61 · 1181
;   odd_part(x_20) = 43584805 = 5² · 11² · 61 · 1181
;
;   B = 3^20 − 1 = 3486784400  (fits in u32, exceeds i32)
;   π(x_20) ≈ 81 million (computed by phase 1)
;
;   Kummer prediction (v_p-indexed form):
;     v_5  stripped by min(v_5(odd_part), max_{odd z} v_5(C(20,z)))
;          = min(2, 1) = 1 → result has factor 5¹
;     v_11 stripped by 0 (no odd z has v_11 ≥ 1) → factor 11²
;     61, 1181 survive (> N so never divide a binomial)
;     ⇒ 5 · 121 · 61 · 1181 = 43584805
;
;   Simple prediction (full-strip form):
;     If any odd z has v_5 ≥ 1, strip ALL powers of 5 → no 5
;     11 never touched → 11²
;     61, 1181 survive
;     ⇒ 121 · 61 · 1181 = 8716961
;
; The walker arbitrates. Whichever integer lands, it locks the
; theorem's refined form.
;
;   D_z = C(20, z) · 2^(20−z):
;     D_0  = 1 · 1048576       = 1048576
;     D_1  = 20 · 524288       = 10485760
;     D_2  = 190 · 262144      = 49807360
;     D_3  = 1140 · 131072     = 149422080
;     D_4  = 4845 · 65536      = 317521920
;     D_5  = 15504 · 32768     = 508035072
;     D_6  = 38760 · 16384     = 635043840
;     D_7  = 77520 · 8192      = 635043840   (= D_6, pairwise doubling)
;     D_8  = 125970 · 4096     = 515973120
;     D_9  = 167960 · 2048     = 343982080
;     D_10 = 184756 · 1024     = 189190144
;     D_11 = 167960 · 512      = 85995520
;     D_12 = 125970 · 256      = 32248320
;     D_13 = 77520 · 128       = 9922560
;     D_14 = 38760 · 64        = 2480640
;     D_15 = 15504 · 32        = 496128
;     D_16 = 4845 · 16         = 77520
;     D_17 = 1140 · 8          = 9120
;     D_18 = 190 · 4           = 760
;     D_19 = 20 · 2            = 40
;     D_20 = 1 · 1             = 1
;
;   Sum check: ΣD_z = 3^20 = 3486784401 ✓
;
; Slot layout:
;   [0..48)      phase 2 scratch
;   [60..228)    A_z counters (21 u64 slots)
;   [280..316)   phase 1 state (updated shell_phase1_sieve.winc)
;
; Runtime: ~10 minutes serial at N=20 (81M primes × 20 decode steps).

; ══════════════════════════════════════════════════════════
; Init: zero 21 A_z counters and set phase 1 constants
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
swrite64 θ¹¹ρ 0 220              ; A_20


; ══════════════════════════════════════════════════════════
; Phase 1: prime enumeration via sieve + cell classification
; ══════════════════════════════════════════════════════════

shell_phase1_c θ²²² 20 1743392200 60

; ══════════════════════════════════════════════════════════
; Phase 2: per-cell reduction (21 cells for N=20)
; ══════════════════════════════════════════════════════════

shl      θρ¹ρ  1                 ; pipeline = C
swrite64 θρ¹ρ 40

swrite64 θ¹¹ρ 0 24               ; gcd_total = 0

; ── Cell z=0 (D_0 = 1048576) ──
sread64  θ¹ρρ  60
mul      θρ²ρ 3486784400
swrite64 θρ¹ρ  0
sread64  θ¹ρρ 40
mul      θρ²ρ 1048576
swrite64 θρ¹ρ  8
gcd64    θ¹¹ρ  0   8
swrite64 θρ¹ρ 16
sread64  θ¹ρρ  0
sdiv64   θ¹ρρ 16
swrite64 θρ¹ρ  8
gcd64    θ¹¹ρ 24   8
swrite64 θρ¹ρ 24

; ── Cell z=1 (D_1 = 10485760) ──
sread64  θ¹ρρ  68
mul      θρ²ρ 3486784400
swrite64 θρ¹ρ  0
sread64  θ¹ρρ 40
mul      θρ²ρ 10485760
swrite64 θρ¹ρ  8
gcd64    θ¹¹ρ  0   8
swrite64 θρ¹ρ 16
sread64  θ¹ρρ  0
sdiv64   θ¹ρρ 16
swrite64 θρ¹ρ  8
gcd64    θ¹¹ρ 24   8
swrite64 θρ¹ρ 24

; ── Cell z=2 (D_2 = 49807360) ──
sread64  θ¹ρρ  76
mul      θρ²ρ 3486784400
swrite64 θρ¹ρ  0
sread64  θ¹ρρ 40
mul      θρ²ρ 49807360
swrite64 θρ¹ρ  8
gcd64    θ¹¹ρ  0   8
swrite64 θρ¹ρ 16
sread64  θ¹ρρ  0
sdiv64   θ¹ρρ 16
swrite64 θρ¹ρ  8
gcd64    θ¹¹ρ 24   8
swrite64 θρ¹ρ 24

; ── Cell z=3 (D_3 = 149422080) ──
sread64  θ¹ρρ  84
mul      θρ²ρ 3486784400
swrite64 θρ¹ρ  0
sread64  θ¹ρρ 40
mul      θρ²ρ 149422080
swrite64 θρ¹ρ  8
gcd64    θ¹¹ρ  0   8
swrite64 θρ¹ρ 16
sread64  θ¹ρρ  0
sdiv64   θ¹ρρ 16
swrite64 θρ¹ρ  8
gcd64    θ¹¹ρ 24   8
swrite64 θρ¹ρ 24

; ── Cell z=4 (D_4 = 317521920) ──
sread64  θ¹ρρ  92
mul      θρ²ρ 3486784400
swrite64 θρ¹ρ  0
sread64  θ¹ρρ 40
mul      θρ²ρ 317521920
swrite64 θρ¹ρ  8
gcd64    θ¹¹ρ  0   8
swrite64 θρ¹ρ 16
sread64  θ¹ρρ  0
sdiv64   θ¹ρρ 16
swrite64 θρ¹ρ  8
gcd64    θ¹¹ρ 24   8
swrite64 θρ¹ρ 24

; ── Cell z=5 (D_5 = 508035072) ──
sread64  θ¹ρρ 100
mul      θρ²ρ 3486784400
swrite64 θρ¹ρ  0
sread64  θ¹ρρ 40
mul      θρ²ρ 508035072
swrite64 θρ¹ρ  8
gcd64    θ¹¹ρ  0   8
swrite64 θρ¹ρ 16
sread64  θ¹ρρ  0
sdiv64   θ¹ρρ 16
swrite64 θρ¹ρ  8
gcd64    θ¹¹ρ 24   8
swrite64 θρ¹ρ 24

; ── Cell z=6 (D_6 = 635043840) ──
sread64  θ¹ρρ 108
mul      θρ²ρ 3486784400
swrite64 θρ¹ρ  0
sread64  θ¹ρρ 40
mul      θρ²ρ 635043840
swrite64 θρ¹ρ  8
gcd64    θ¹¹ρ  0   8
swrite64 θρ¹ρ 16
sread64  θ¹ρρ  0
sdiv64   θ¹ρρ 16
swrite64 θρ¹ρ  8
gcd64    θ¹¹ρ 24   8
swrite64 θρ¹ρ 24

; ── Cell z=7 (D_7 = 635043840) ──
sread64  θ¹ρρ 116
mul      θρ²ρ 3486784400
swrite64 θρ¹ρ  0
sread64  θ¹ρρ 40
mul      θρ²ρ 635043840
swrite64 θρ¹ρ  8
gcd64    θ¹¹ρ  0   8
swrite64 θρ¹ρ 16
sread64  θ¹ρρ  0
sdiv64   θ¹ρρ 16
swrite64 θρ¹ρ  8
gcd64    θ¹¹ρ 24   8
swrite64 θρ¹ρ 24

; ── Cell z=8 (D_8 = 515973120) ──
sread64  θ¹ρρ 124
mul      θρ²ρ 3486784400
swrite64 θρ¹ρ  0
sread64  θ¹ρρ 40
mul      θρ²ρ 515973120
swrite64 θρ¹ρ  8
gcd64    θ¹¹ρ  0   8
swrite64 θρ¹ρ 16
sread64  θ¹ρρ  0
sdiv64   θ¹ρρ 16
swrite64 θρ¹ρ  8
gcd64    θ¹¹ρ 24   8
swrite64 θρ¹ρ 24

; ── Cell z=9 (D_9 = 343982080) ──
sread64  θ¹ρρ 132
mul      θρ²ρ 3486784400
swrite64 θρ¹ρ  0
sread64  θ¹ρρ 40
mul      θρ²ρ 343982080
swrite64 θρ¹ρ  8
gcd64    θ¹¹ρ  0   8
swrite64 θρ¹ρ 16
sread64  θ¹ρρ  0
sdiv64   θ¹ρρ 16
swrite64 θρ¹ρ  8
gcd64    θ¹¹ρ 24   8
swrite64 θρ¹ρ 24

; ── Cell z=10 (D_10 = 189190144) ──
sread64  θ¹ρρ 140
mul      θρ²ρ 3486784400
swrite64 θρ¹ρ  0
sread64  θ¹ρρ 40
mul      θρ²ρ 189190144
swrite64 θρ¹ρ  8
gcd64    θ¹¹ρ  0   8
swrite64 θρ¹ρ 16
sread64  θ¹ρρ  0
sdiv64   θ¹ρρ 16
swrite64 θρ¹ρ  8
gcd64    θ¹¹ρ 24   8
swrite64 θρ¹ρ 24

; ── Cell z=11 (D_11 = 85995520) ──
sread64  θ¹ρρ 148
mul      θρ²ρ 3486784400
swrite64 θρ¹ρ  0
sread64  θ¹ρρ 40
mul      θρ²ρ 85995520
swrite64 θρ¹ρ  8
gcd64    θ¹¹ρ  0   8
swrite64 θρ¹ρ 16
sread64  θ¹ρρ  0
sdiv64   θ¹ρρ 16
swrite64 θρ¹ρ  8
gcd64    θ¹¹ρ 24   8
swrite64 θρ¹ρ 24

; ── Cell z=12 (D_12 = 32248320) ──
sread64  θ¹ρρ 156
mul      θρ²ρ 3486784400
swrite64 θρ¹ρ  0
sread64  θ¹ρρ 40
mul      θρ²ρ 32248320
swrite64 θρ¹ρ  8
gcd64    θ¹¹ρ  0   8
swrite64 θρ¹ρ 16
sread64  θ¹ρρ  0
sdiv64   θ¹ρρ 16
swrite64 θρ¹ρ  8
gcd64    θ¹¹ρ 24   8
swrite64 θρ¹ρ 24

; ── Cell z=13 (D_13 = 9922560) ──
sread64  θ¹ρρ 164
mul      θρ²ρ 3486784400
swrite64 θρ¹ρ  0
sread64  θ¹ρρ 40
mul      θρ²ρ 9922560
swrite64 θρ¹ρ  8
gcd64    θ¹¹ρ  0   8
swrite64 θρ¹ρ 16
sread64  θ¹ρρ  0
sdiv64   θ¹ρρ 16
swrite64 θρ¹ρ  8
gcd64    θ¹¹ρ 24   8
swrite64 θρ¹ρ 24

; ── Cell z=14 (D_14 = 2480640) ──
sread64  θ¹ρρ 172
mul      θρ²ρ 3486784400
swrite64 θρ¹ρ  0
sread64  θ¹ρρ 40
mul      θρ²ρ 2480640
swrite64 θρ¹ρ  8
gcd64    θ¹¹ρ  0   8
swrite64 θρ¹ρ 16
sread64  θ¹ρρ  0
sdiv64   θ¹ρρ 16
swrite64 θρ¹ρ  8
gcd64    θ¹¹ρ 24   8
swrite64 θρ¹ρ 24

; ── Cell z=15 (D_15 = 496128) ──
sread64  θ¹ρρ 180
mul      θρ²ρ 3486784400
swrite64 θρ¹ρ  0
sread64  θ¹ρρ 40
mul      θρ²ρ 496128
swrite64 θρ¹ρ  8
gcd64    θ¹¹ρ  0   8
swrite64 θρ¹ρ 16
sread64  θ¹ρρ  0
sdiv64   θ¹ρρ 16
swrite64 θρ¹ρ  8
gcd64    θ¹¹ρ 24   8
swrite64 θρ¹ρ 24

; ── Cell z=16 (D_16 = 77520) ──
sread64  θ¹ρρ 188
mul      θρ²ρ 3486784400
swrite64 θρ¹ρ  0
sread64  θ¹ρρ 40
mul      θρ²ρ 77520
swrite64 θρ¹ρ  8
gcd64    θ¹¹ρ  0   8
swrite64 θρ¹ρ 16
sread64  θ¹ρρ  0
sdiv64   θ¹ρρ 16
swrite64 θρ¹ρ  8
gcd64    θ¹¹ρ 24   8
swrite64 θρ¹ρ 24

; ── Cell z=17 (D_17 = 9120) ──
sread64  θ¹ρρ 196
mul      θρ²ρ 3486784400
swrite64 θρ¹ρ  0
sread64  θ¹ρρ 40
mul      θρ²ρ 9120
swrite64 θρ¹ρ  8
gcd64    θ¹¹ρ  0   8
swrite64 θρ¹ρ 16
sread64  θ¹ρρ  0
sdiv64   θ¹ρρ 16
swrite64 θρ¹ρ  8
gcd64    θ¹¹ρ 24   8
swrite64 θρ¹ρ 24

; ── Cell z=18 (D_18 = 760) ──
sread64  θ¹ρρ 204
mul      θρ²ρ 3486784400
swrite64 θρ¹ρ  0
sread64  θ¹ρρ 40
mul      θρ²ρ 760
swrite64 θρ¹ρ  8
gcd64    θ¹¹ρ  0   8
swrite64 θρ¹ρ 16
sread64  θ¹ρρ  0
sdiv64   θ¹ρρ 16
swrite64 θρ¹ρ  8
gcd64    θ¹¹ρ 24   8
swrite64 θρ¹ρ 24

; ── Cell z=19 (D_19 = 40) ──
sread64  θ¹ρρ 212
mul      θρ²ρ 3486784400
swrite64 θρ¹ρ  0
sread64  θ¹ρρ 40
mul      θρ¹ρ 40
swrite64 θρ¹ρ  8
gcd64    θ¹¹ρ  0   8
swrite64 θρ¹ρ 16
sread64  θ¹ρρ  0
sdiv64   θ¹ρρ 16
swrite64 θρ¹ρ  8
gcd64    θ¹¹ρ 24   8
swrite64 θρ¹ρ 24

; ── Cell z=20 (D_20 = 1) ──
sread64  θ¹ρρ 220
mul      θρ²ρ 3486784400
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
