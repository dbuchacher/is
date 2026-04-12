; shell_gcd_N4_c.w — N=4 full pipeline via parallel C phase 1.
; Cross-validation for the C phase 1 at N=4. Expected: 5.

swrite64 θ¹¹ρ 0 60
swrite64 θ¹¹ρ 0 68
swrite64 θ¹¹ρ 0 76
swrite64 θ¹¹ρ 0 84
swrite64 θ¹¹ρ 0 92

shell_phase1_c θ²²² 4 40 60

shl      θρ¹ρ  1
swrite64 θρ¹ρ 192
swrite64 θ¹¹ρ 0 224

; ── Cell z=0 (D_0 = 16) ──
sread64  θ¹ρρ  60
mul      θρ¹ρ 80
swrite64 θρ¹ρ 200
sread64  θ¹ρρ 192
mul      θρ¹ρ 16
swrite64 θρ¹ρ 208
gcd64    θ¹¹ρ 200 208
swrite64 θρ¹ρ 216
sread64  θ¹ρρ 200
sdiv64   θ¹ρρ 216
swrite64 θρ¹ρ 208
gcd64    θ¹¹ρ 224 208
swrite64 θρ¹ρ 224

; ── Cell z=1 (D_1 = 32) ──
sread64  θ¹ρρ  68
mul      θρ¹ρ 80
swrite64 θρ¹ρ 200
sread64  θ¹ρρ 192
mul      θρ¹ρ 32
swrite64 θρ¹ρ 208
gcd64    θ¹¹ρ 200 208
swrite64 θρ¹ρ 216
sread64  θ¹ρρ 200
sdiv64   θ¹ρρ 216
swrite64 θρ¹ρ 208
gcd64    θ¹¹ρ 224 208
swrite64 θρ¹ρ 224

; ── Cell z=2 (D_2 = 24) ──
sread64  θ¹ρρ  76
mul      θρ¹ρ 80
swrite64 θρ¹ρ 200
sread64  θ¹ρρ 192
mul      θρ¹ρ 24
swrite64 θρ¹ρ 208
gcd64    θ¹¹ρ 200 208
swrite64 θρ¹ρ 216
sread64  θ¹ρρ 200
sdiv64   θ¹ρρ 216
swrite64 θρ¹ρ 208
gcd64    θ¹¹ρ 224 208
swrite64 θρ¹ρ 224

; ── Cell z=3 (D_3 = 8) ──
sread64  θ¹ρρ  84
mul      θρ¹ρ 80
swrite64 θρ¹ρ 200
sread64  θ¹ρρ 192
mul      θρ¹ρ  8
swrite64 θρ¹ρ 208
gcd64    θ¹¹ρ 200 208
swrite64 θρ¹ρ 216
sread64  θ¹ρρ 200
sdiv64   θ¹ρρ 216
swrite64 θρ¹ρ 208
gcd64    θ¹¹ρ 224 208
swrite64 θρ¹ρ 224

; ── Cell z=4 (D_4 = 1) ──
sread64  θ¹ρρ  92
mul      θρ¹ρ 80
swrite64 θρ¹ρ 200
sread64  θ¹ρρ 192
mul      θρ¹ρ  1
swrite64 θρ¹ρ 208
gcd64    θ¹¹ρ 200 208
swrite64 θρ¹ρ 216
sread64  θ¹ρρ 200
sdiv64   θ¹ρρ 216
swrite64 θρ¹ρ 208
gcd64    θ¹¹ρ 224 208
swrite64 θρ¹ρ 224

sread64  θ¹ρρ 224
