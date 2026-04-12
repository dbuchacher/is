; cd_mul_d8_norm_8.w — octonion norm² via q · conj(q).
;
;   q       = 1 + e1 + e2 + ... + e7  = (1, 1, 1, 1, 1, 1, 1, 1)
;   conj(q) = 1 − e1 − e2 − ... − e7  = (1,−1,−1,−1,−1,−1,−1,−1)
;   q · conj(q) = (|q|², 0, 0, 0, 0, 0, 0, 0) = (8, 0, 0, 0, 0, 0, 0, 0)
;
; Each octonion has 8 components; |q|² = sum of squares = 8.
; Use sub θ¹¹ρ 0 1 idiom for −1 literals.

; ── A = q = (1, 1, 1, 1, 1, 1, 1, 1) ──
swrite64 θ¹¹ρ  1   0
swrite64 θ¹¹ρ  1   8
swrite64 θ¹¹ρ  1  16
swrite64 θ¹¹ρ  1  24
swrite64 θ¹¹ρ  1  32
swrite64 θ¹¹ρ  1  40
swrite64 θ¹¹ρ  1  48
swrite64 θ¹¹ρ  1  56

; ── B = conj(q) = (1, −1, −1, −1, −1, −1, −1, −1) ──
swrite64 θ¹¹ρ  1  64

sub      θ¹¹ρ  0  1
swrite64 θρ¹ρ 72
sub      θ¹¹ρ  0  1
swrite64 θρ¹ρ 80
sub      θ¹¹ρ  0  1
swrite64 θρ¹ρ 88
sub      θ¹¹ρ  0  1
swrite64 θρ¹ρ 96
sub      θ¹¹ρ  0  1
swrite64 θρ¹ρ 104
sub      θ¹¹ρ  0  1
swrite64 θρ¹ρ 112
sub      θ¹¹ρ  0  1
swrite64 θρ¹ρ 120

; ── q · conj(q) → out ──
cd_mul_d8_c θ¹¹¹   0  64 128

; ── return out[0] = real = |q|² = 8 ──
sread64  θ¹ρρ 128
