; cd_mul_d16_identity_2.w — sedenion identity element.
;
; A = 1 (scalar), B = (1, 2, 3, ..., 16), output should equal B.
; Read e1 coefficient (= 2).
;
; Slot layout (16 qwords per sedenion):
;   [0..128)   = A
;   [128..256) = B
;   [256..384) = out

; ── A = scalar 1 ──
swrite64 θ¹¹ρ  1   0
swrite64 θ¹¹ρ  0   8
swrite64 θ¹¹ρ  0  16
swrite64 θ¹¹ρ  0  24
swrite64 θ¹¹ρ  0  32
swrite64 θ¹¹ρ  0  40
swrite64 θ¹¹ρ  0  48
swrite64 θ¹¹ρ  0  56
swrite64 θ¹¹ρ  0  64
swrite64 θ¹¹ρ  0  72
swrite64 θ¹¹ρ  0  80
swrite64 θ¹¹ρ  0  88
swrite64 θ¹¹ρ  0  96
swrite64 θ¹¹ρ  0 104
swrite64 θ¹¹ρ  0 112
swrite64 θ¹¹ρ  0 120

; ── B = (1, 2, 3, ..., 16) ──
swrite64 θ¹¹ρ   1 128
swrite64 θ¹¹ρ   2 136
swrite64 θ¹¹ρ   3 144
swrite64 θ¹¹ρ   4 152
swrite64 θ¹¹ρ   5 160
swrite64 θ¹¹ρ   6 168
swrite64 θ¹¹ρ   7 176
swrite64 θ¹¹ρ   8 184
swrite64 θ¹¹ρ   9 192
swrite64 θ¹¹ρ  10 200
swrite64 θ¹¹ρ  11 208
swrite64 θ¹¹ρ  12 216
swrite64 θ¹¹ρ  13 224
swrite64 θ¹¹ρ  14 232
swrite64 θ¹¹ρ  15 240
swrite64 θ¹¹ρ  16 248

; ── 1 · B → out at [256..384) ──
cd_mul_d16_c θ¹¹¹   0 128 256

; ── return out[1] = e1 coefficient = 2 ──
sread64  θ¹ρρ 264
