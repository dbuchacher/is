; cd_mul_d4_norm_4.w — quaternion norm² via q · conj(q).
;
; q          = 1 + i + j + k  = (1,  1,  1,  1)
; conj(q)    = 1 − i − j − k  = (1, −1, −1, −1)
; q · conj(q) = (|q|², 0, 0, 0) = (4, 0, 0, 0)
;
; Verifies that the real part of q·conj(q) equals a₀² + a₁² + a₂² + a₃² = 4
; for q = (1,1,1,1). Exercises the formula end-to-end including
; writing negative integers to scratch (via sub θ¹¹ρ 0 1 = −1).

; ── A = q = (1, 1, 1, 1) ────────────────
swrite64 θ¹¹ρ  1   0
swrite64 θ¹¹ρ  1   8
swrite64 θ¹¹ρ  1  16
swrite64 θ¹¹ρ  1  24

; ── B = conj(q) = (1, −1, −1, −1) ────────
swrite64 θ¹¹ρ  1  32

sub      θ¹¹ρ  0  1              ; pipeline = 0 − 1 = −1
swrite64 θρ¹ρ 40                 ; scratch[40] = −1

sub      θ¹¹ρ  0  1
swrite64 θρ¹ρ 48

sub      θ¹¹ρ  0  1
swrite64 θρ¹ρ 56

; ── q · conj(q) ──
cd_mul_d4_c θ¹¹¹   0  32  64

; ── return out[0] = real = |q|² = 4 ─────
sread64  θ¹ρρ  64
