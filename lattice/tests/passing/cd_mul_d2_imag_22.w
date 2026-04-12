; cd_mul_d2_imag_22.w — Cayley-Dickson base case, imag part.
;
; Verifies (2 + 3i)(4 + 5i) = -7 + 22i by reading the imaginary part.
;
;   out_real = 2·4 − 3·5 = 8 − 15 = -7
;   out_imag = 2·5 + 3·4 = 10 + 12 = 22
;
; Scratch-resident IO layout (qword per component, matches d4/d8/d16/d32
; interface per the wit's design direction):
;
;   scratch[0..8]   = a_real = 2
;   scratch[8..16]  = a_imag = 3
;   scratch[16..24] = b_real = 4
;   scratch[24..32] = b_imag = 5
;   scratch[32..40] = out_real (set by cd_mul_d2)
;   scratch[40..48] = out_imag (set by cd_mul_d2)
;
; This test reads the imag part (offset 40). The real part is verified
; in cd_mul_d2_real_neg7.w via the same setup.

; ── load a = 2 + 3i ───────────────────────────
add       θ¹¹ρ   2  0
swrite64  θρ¹ρ   0            ; scratch[0] = a_real = 2
add       θ¹¹ρ   3  0
swrite64  θρ¹ρ   8            ; scratch[8] = a_imag = 3

; ── load b = 4 + 5i ───────────────────────────
add       θ¹¹ρ   4  0
swrite64  θρ¹ρ  16            ; scratch[16] = b_real = 4
add       θ¹¹ρ   5  0
swrite64  θρ¹ρ  24            ; scratch[24] = b_imag = 5

; ── cd_mul_d2(a_ofs=0, b_ofs=16, out_ofs=32) ──
cd_mul_d2 θ¹¹¹   0  16  32

; ── return imag part ─────────────────────────
sread64   θ¹ρρ  40            ; pipeline = scratch[40] = out_imag = 22
