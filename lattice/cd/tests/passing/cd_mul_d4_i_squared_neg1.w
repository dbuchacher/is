; cd_mul_d4_i_squared_neg1.w — Hamilton rule i² = −1.
;
; i · i = (0,1,0,0) · (0,1,0,0) = (−1,0,0,0)
;
; Reads the real component (out[0]) which should be −1.
; Confirms the −a₁·b₁ term in the formula for out[0].

; ── A = i = (0, 1, 0, 0) ────────────────
swrite64 θ¹¹ρ  0   0
swrite64 θ¹¹ρ  1   8
swrite64 θ¹¹ρ  0  16
swrite64 θ¹¹ρ  0  24

; ── B = i = (0, 1, 0, 0) ────────────────
swrite64 θ¹¹ρ  0  32
swrite64 θ¹¹ρ  1  40
swrite64 θ¹¹ρ  0  48
swrite64 θ¹¹ρ  0  56

; ── i · i ──
cd_mul_d4 θ¹¹¹   0  32  64

; ── return out[0] = real = −1 ───────────
sread64  θ¹ρρ  64
