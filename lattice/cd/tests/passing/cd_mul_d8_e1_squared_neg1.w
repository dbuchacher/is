; cd_mul_d8_e1_squared_neg1.w — octonion basis element e1² = −1.
;
; In the Cayley-Dickson doubling from quaternions, e1 is the "i"
; of the first quaternion half: (0, 1, 0, 0, 0, 0, 0, 0).
; e1² should give -1 in the real component.

; ── A = e1 = (0, 1, 0, 0, 0, 0, 0, 0) ───
swrite64 θ¹¹ρ  0   0
swrite64 θ¹¹ρ  1   8
swrite64 θ¹¹ρ  0  16
swrite64 θ¹¹ρ  0  24
swrite64 θ¹¹ρ  0  32
swrite64 θ¹¹ρ  0  40
swrite64 θ¹¹ρ  0  48
swrite64 θ¹¹ρ  0  56

; ── B = e1 = (0, 1, 0, 0, 0, 0, 0, 0) ───
swrite64 θ¹¹ρ  0  64
swrite64 θ¹¹ρ  1  72
swrite64 θ¹¹ρ  0  80
swrite64 θ¹¹ρ  0  88
swrite64 θ¹¹ρ  0  96
swrite64 θ¹¹ρ  0 104
swrite64 θ¹¹ρ  0 112
swrite64 θ¹¹ρ  0 120

; ── e1 · e1 → out ──
cd_mul_d8_c θ¹¹¹   0  64 128

; ── return out[0] = real = -1 ──
sread64  θ¹ρρ 128
