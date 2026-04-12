; cd_mul_d16_norm_16.w — sedenion norm² = 16.
;
; q       = 1 + e1 + e2 + ... + e15  = (1, 1, ..., 1)   [16 ones]
; conj(q) = 1 − e1 − e2 − ... − e15  = (1, −1, ..., −1)
; q · conj(q) = (|q|², 0, 0, ..., 0) = (16, 0, ..., 0)
;
; Reads real part, expects 16.

; ── A = (1, 1, 1, ..., 1) ──
swrite64 θ¹¹ρ  1   0
swrite64 θ¹¹ρ  1   8
swrite64 θ¹¹ρ  1  16
swrite64 θ¹¹ρ  1  24
swrite64 θ¹¹ρ  1  32
swrite64 θ¹¹ρ  1  40
swrite64 θ¹¹ρ  1  48
swrite64 θ¹¹ρ  1  56
swrite64 θ¹¹ρ  1  64
swrite64 θ¹¹ρ  1  72
swrite64 θ¹¹ρ  1  80
swrite64 θ¹¹ρ  1  88
swrite64 θ¹¹ρ  1  96
swrite64 θ¹¹ρ  1 104
swrite64 θ¹¹ρ  1 112
swrite64 θ¹¹ρ  1 120

; ── B = conj(q) = (1, -1, -1, ..., -1) ──
swrite64 θ¹¹ρ  1 128

sub      θ¹¹ρ  0  1
swrite64 θρ¹ρ 136
sub      θ¹¹ρ  0  1
swrite64 θρ¹ρ 144
sub      θ¹¹ρ  0  1
swrite64 θρ¹ρ 152
sub      θ¹¹ρ  0  1
swrite64 θρ¹ρ 160
sub      θ¹¹ρ  0  1
swrite64 θρ¹ρ 168
sub      θ¹¹ρ  0  1
swrite64 θρ¹ρ 176
sub      θ¹¹ρ  0  1
swrite64 θρ¹ρ 184
sub      θ¹¹ρ  0  1
swrite64 θρ¹ρ 192
sub      θ¹¹ρ  0  1
swrite64 θρ¹ρ 200
sub      θ¹¹ρ  0  1
swrite64 θρ¹ρ 208
sub      θ¹¹ρ  0  1
swrite64 θρ¹ρ 216
sub      θ¹¹ρ  0  1
swrite64 θρ¹ρ 224
sub      θ¹¹ρ  0  1
swrite64 θρ¹ρ 232
sub      θ¹¹ρ  0  1
swrite64 θρ¹ρ 240
sub      θ¹¹ρ  0  1
swrite64 θρ¹ρ 248

; ── q · conj(q) → out ──
cd_mul_d16_c θ¹¹¹   0 128 256

; ── return out[0] = real = |q|² = 16 ──
sread64  θ¹ρρ 256
