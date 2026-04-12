; shell_gcd_N19_c.w — parallel C phase 1 variant of shell_gcd_N19.
;
; Expected: 581130733 (must match serial shell_gcd_N19).

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
swrite64 θ¹¹ρ 0 212

shell_phase1_c θ²²² 19 581130733 60

shl      θρ¹ρ  1
swrite64 θρ¹ρ 40
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

sread64  θ¹ρρ 24
