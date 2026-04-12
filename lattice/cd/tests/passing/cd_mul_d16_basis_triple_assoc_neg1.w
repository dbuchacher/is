; cd_mul_d16_basis_triple_assoc_neg1.w — associativity on a sedenion
; basis triple that spans a quaternion sub-algebra.
;
; {e1, e2, e3} at sedenion level still satisfies e1·e2 = e3 via the
; CD doubling (the first 8 sedenion basis elements form the octonion
; sub-algebra, and within that the first 4 form the quaternion
; sub-algebra containing e1, e2, e3).
;
; Verify (e1·e2)·e3 = e3·e3 = −1.
;
; Slot layout (3 sedenions used — 384 bytes of scratch):
;   [0..128)    = A (e1 first, reused)
;   [128..256)  = B (e2 first, then e3)
;   [256..384)  = tmp1 (= e1·e2 = e3)
;   [384..512)  = B2 (e3)
;   [512..640)  = tmp2 (= (e1·e2)·e3 = −1)

; ── A = e1 ──
swrite64 θ¹¹ρ  0   0
swrite64 θ¹¹ρ  1   8
swrite64 θ¹¹ρ  0  16
swrite64 θ¹¹ρ  0  24
swrite64 θ¹¹ρ  0  32
swrite64 θ¹¹ρ  0  40
swrite64 θ¹¹ρ  0  48
swrite64 θ¹¹ρ  0  56
swrite64 θ¹¹ρ  0  64
swrite64 θ¹¹ρ  0  72
swrite64 θ¹¹ρ  0  80
swrite64 θ¹¹ρ  0  88
swrite64 θ¹¹ρ  0  96
swrite64 θ¹¹ρ  0 104
swrite64 θ¹¹ρ  0 112
swrite64 θ¹¹ρ  0 120

; ── B = e2 ──
swrite64 θ¹¹ρ  0 128
swrite64 θ¹¹ρ  0 136
swrite64 θ¹¹ρ  1 144
swrite64 θ¹¹ρ  0 152
swrite64 θ¹¹ρ  0 160
swrite64 θ¹¹ρ  0 168
swrite64 θ¹¹ρ  0 176
swrite64 θ¹¹ρ  0 184
swrite64 θ¹¹ρ  0 192
swrite64 θ¹¹ρ  0 200
swrite64 θ¹¹ρ  0 208
swrite64 θ¹¹ρ  0 216
swrite64 θ¹¹ρ  0 224
swrite64 θ¹¹ρ  0 232
swrite64 θ¹¹ρ  0 240
swrite64 θ¹¹ρ  0 248

; ── e1 · e2 → [256..384) (should be e3) ──
cd_mul_d16_c θ²²² 0 128 256

; ── B2 = e3 at [384..512) ──
swrite64 θ²²ρ 0 384
swrite64 θ²²ρ 0 392
swrite64 θ²²ρ 0 400
swrite64 θ²²ρ 1 408
swrite64 θ²²ρ 0 416
swrite64 θ²²ρ 0 424
swrite64 θ²²ρ 0 432
swrite64 θ²²ρ 0 440
swrite64 θ²²ρ 0 448
swrite64 θ²²ρ 0 456
swrite64 θ²²ρ 0 464
swrite64 θ²²ρ 0 472
swrite64 θ²²ρ 0 480
swrite64 θ²²ρ 0 488
swrite64 θ²²ρ 0 496
swrite64 θ²²ρ 0 504

; ── (e1·e2) · e3 → [512..640) ──
cd_mul_d16_c θ²²² 256 384 512

; ── return real = −1 ──
sread64  θ²ρρ 512
