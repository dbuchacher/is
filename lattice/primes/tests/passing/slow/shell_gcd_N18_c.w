; shell_gcd_N18_c.w — parallel C phase 1 variant of shell_gcd_N18.
;
; Expected: 532171 (matches shell_gcd_N18.w)
;
; Runtime: N=18 was ~67s serial → expected ~50ms at 16 cores.

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
swrite64 θ¹¹ρ 0 204

shell_phase1_c θ²²² 18 193710244 60

shl      θρ¹ρ  1
swrite64 θρ¹ρ 40
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

sread64  θ¹ρρ 24
