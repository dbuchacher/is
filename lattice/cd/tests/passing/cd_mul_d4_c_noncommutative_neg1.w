; cd_mul_d4_noncommutative_neg1.w — quaternion noncommutativity.
;
; j · i = −k  (not k = i · j)
;
;   A = j = (0, 0, 1, 0)
;   B = i = (0, 1, 0, 0)
;   out = j·i = (0, 0, 0, −1)
;
; Reads the k-component (out[3]) which should be −1, proving ji = −k.
; The companion identity ij = k (out[3] = +1) would need a separate
; walk; this one catches the sign.

; ── A = j = (0, 0, 1, 0) ────────────────
swrite64 θ¹¹ρ  0   0
swrite64 θ¹¹ρ  0   8
swrite64 θ¹¹ρ  1  16
swrite64 θ¹¹ρ  0  24

; ── B = i = (0, 1, 0, 0) ────────────────
swrite64 θ¹¹ρ  0  32
swrite64 θ¹¹ρ  1  40
swrite64 θ¹¹ρ  0  48
swrite64 θ¹¹ρ  0  56

; ── j · i ──
cd_mul_d4_c θ¹¹¹   0  32  64

; ── return out[3] = k = −1 ──────────────
sread64  θ¹ρρ  88
