; cd_mul_d4_identity_2.w — quaternion identity element test.
;
; 1 · (1 + 2i + 3j + 4k) = 1 + 2i + 3j + 4k
;
; Verifies that A=(1,0,0,0) acts as the multiplicative identity.
; Reads the i-component (out[1]) which should be 2.
;
; Scratch layout (4 qwords per quaternion):
;   [0..32)   = A (a₀, a₁, a₂, a₃)
;   [32..64)  = B (b₀, b₁, b₂, b₃)
;   [64..96)  = out (result)

; ── A = (1, 0, 0, 0) = scalar 1 ────────────────
swrite64 θ¹¹ρ  1   0
swrite64 θ¹¹ρ  0   8
swrite64 θ¹¹ρ  0  16
swrite64 θ¹¹ρ  0  24

; ── B = (1, 2, 3, 4) = 1 + 2i + 3j + 4k ────────
swrite64 θ¹¹ρ  1  32
swrite64 θ¹¹ρ  2  40
swrite64 θ¹¹ρ  3  48
swrite64 θ¹¹ρ  4  56

; ── cd_mul_d4(a_ofs=0, b_ofs=32, out_ofs=64) ──
cd_mul_d4 θ¹¹¹   0  32  64

; ── return out[1] = i-component = 2 ───────────
sread64  θ¹ρρ  72
