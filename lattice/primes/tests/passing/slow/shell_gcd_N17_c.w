; shell_gcd_N17_c.w — parallel C phase 1 variant of shell_gcd_N17.
;
; Identical compute to shell_gcd_N17.w (expected 64570081) except
; phase 1 runs in parallel C via OpenMP instead of serial walker
; trial division / sieve enumeration.
;
; Runtime expectation: N=17 was ~23s serial → should be ~2-3s at
; 16 cores (3950X).

swrite64 θ¹¹ρ 0  60
swrite64 θ¹¹ρ 0  68
swrite64 θ¹¹ρ 0  76
swrite64 θ¹¹ρ 0  84
swrite64 θ¹¹ρ 0  92
swrite64 θ¹¹ρ 0 100
swrite64 θ¹¹ρ 0 108
swrite64 θ¹¹ρ 0 116
swrite64 θ¹¹ρ 0 124
swrite64 θ¹¹ρ 0 132
swrite64 θ¹¹ρ 0 140
swrite64 θ¹¹ρ 0 148
swrite64 θ¹¹ρ 0 156
swrite64 θ¹¹ρ 0 164
swrite64 θ¹¹ρ 0 172
swrite64 θ¹¹ρ 0 180
swrite64 θ¹¹ρ 0 188
swrite64 θ¹¹ρ 0 196

shell_phase1_c θ²²² 17 64570081 60

shl      θρ¹ρ  1
swrite64 θρ¹ρ 40
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

sread64  θ¹ρρ 24
