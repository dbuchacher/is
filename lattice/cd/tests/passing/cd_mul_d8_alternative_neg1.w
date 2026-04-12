; cd_mul_d8_alternative_neg1.w — associativity on the {e1,e2,e3}
; sub-algebra (octonions associate on triples that lie in a
; quaternion sub-algebra; {e1, e2, e3} is such a triple via Fano).
;
; Verify (e1 · e2) · e3 = e1 · (e2 · e3) by computing the LHS
; explicitly via two cd_mul_d8_c calls. Both should equal −1
; (= e3 · e3 = e1 · e1).
;
; This walk computes (e1 · e2) · e3 and reads the real part,
; expecting −1. A companion walk could compute e1 · (e2 · e3)
; and confirm it also yields −1.
;
; Scratch layout:
;   [0..64)    = A input (e1, then reused)
;   [64..128)  = B input (e2, then e3)
;   [128..192) = first product (e1·e2 = e3)
;   [192..256) = e3 (for second mul input)
;   [256..320) = final product ((e1·e2)·e3)

; ── A = e1 = (0, 1, 0, 0, 0, 0, 0, 0) ───
swrite64 θ¹¹ρ  0   0
swrite64 θ¹¹ρ  1   8
swrite64 θ¹¹ρ  0  16
swrite64 θ¹¹ρ  0  24
swrite64 θ¹¹ρ  0  32
swrite64 θ¹¹ρ  0  40
swrite64 θ¹¹ρ  0  48
swrite64 θ¹¹ρ  0  56

; ── B = e2 = (0, 0, 1, 0, 0, 0, 0, 0) ───
swrite64 θ¹¹ρ  0  64
swrite64 θ¹¹ρ  0  72
swrite64 θ¹¹ρ  1  80
swrite64 θ¹¹ρ  0  88
swrite64 θ¹¹ρ  0  96
swrite64 θ¹¹ρ  0 104
swrite64 θ¹¹ρ  0 112
swrite64 θ¹¹ρ  0 120

; ── e1 · e2 → [128..192) (should be e3) ──
cd_mul_d8_c θ¹¹¹   0  64 128

; ── load e3 = (0, 0, 0, 1, 0, 0, 0, 0) at [192..256) ──
swrite64 θ¹¹ρ  0 192
swrite64 θ¹¹ρ  0 200
swrite64 θ¹¹ρ  0 208
swrite64 θ¹¹ρ  1 216
swrite64 θ¹¹ρ  0 224
swrite64 θ¹¹ρ  0 232
swrite64 θ¹¹ρ  0 240
swrite64 θ¹¹ρ  0 248

; ── (e1·e2) · e3 → [256..320) (should be −1 in real) ──
cd_mul_d8_c θ²²² 128 192 256

; ── return out[0] = real = −1 ──
sread64  θ²ρρ 256
