; cd_mul_d2_real_neg7.w — Cayley-Dickson base case, real part.
;
; Same multiplication as cd_mul_d2_imag_22.w but reads the real
; component of the product.
;
; (2 + 3i)(4 + 5i) = -7 + 22i
;                    ^^^^
;                    this test verifies this integer
;
; main.c prints signed decimal so "-7" comes out cleanly from the
; i64 pipeline. Proves the imul signed semantics and the
; a_real·b_real − a_imag·b_imag subtraction path.

; ── load a = 2 + 3i ───────────────────────────
add       θ¹¹ρ   2  0
swrite64  θρ¹ρ   0
add       θ¹¹ρ   3  0
swrite64  θρ¹ρ   8

; ── load b = 4 + 5i ───────────────────────────
add       θ¹¹ρ   4  0
swrite64  θρ¹ρ  16
add       θ¹¹ρ   5  0
swrite64  θρ¹ρ  24

; ── cd_mul_d2(a_ofs=0, b_ofs=16, out_ofs=32) ──
cd_mul_d2 θ¹¹¹   0  16  32

; ── return real part ────────────────────────
sread64   θ¹ρρ  32            ; pipeline = scratch[32] = out_real = -7
