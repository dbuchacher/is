; cd_mul_d8_identity_2.w — octonion identity element test.
;
; 1 · (1 + e1 + 2·e2 + ... ) acts as identity.
; Use A = 1 = (1,0,0,0,0,0,0,0), B = (1,2,3,4,5,6,7,8).
; Expected: out[1] (the e1 coefficient) = 2.
;
; Scratch layout (8 qwords per octonion):
;   [0..64)    = A
;   [64..128)  = B
;   [128..192) = out

; ── A = 1 = (1, 0, 0, 0, 0, 0, 0, 0) ───
swrite64 θ¹¹ρ  1   0
swrite64 θ¹¹ρ  0   8
swrite64 θ¹¹ρ  0  16
swrite64 θ¹¹ρ  0  24
swrite64 θ¹¹ρ  0  32
swrite64 θ¹¹ρ  0  40
swrite64 θ¹¹ρ  0  48
swrite64 θ¹¹ρ  0  56

; ── B = (1, 2, 3, 4, 5, 6, 7, 8) ────────
swrite64 θ¹¹ρ  1  64
swrite64 θ¹¹ρ  2  72
swrite64 θ¹¹ρ  3  80
swrite64 θ¹¹ρ  4  88
swrite64 θ¹¹ρ  5  96
swrite64 θ¹¹ρ  6 104
swrite64 θ¹¹ρ  7 112
swrite64 θ¹¹ρ  8 120

; ── 1 · B → out ──
cd_mul_d8_c θ¹¹¹   0  64 128

; ── return out[1] = e1 coefficient = 2 ──
sread64  θ¹ρρ  136
