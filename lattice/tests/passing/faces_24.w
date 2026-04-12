; faces_24.w — A5: 2-faces of the 4D hypercube = 24.
;
; Enumerates {−1, 0, +1}⁴ (81 points), counts those with EXACTLY TWO
; nonzero coords — the 2-cells (square faces) of the 4-cube.
;
; Framework derivation: faces = C(4,2) · 2² = 6 · 4 = 24.
;   C(4,2) = 6: choose which 2 of 4 axes are active
;   2² = 4:     each active axis gets ±1 (the other 2 are 0)
;   Total:      6 · 4 = 24
;
; These are the square faces of the 4-cube. In framework terms:
; points where exactly 2 axes have force-value applied (±) and 2 are
; zero. Part of the f-vector [16, 32, 24, 8, 1] for the 4D hypercube.
;
; Filter: `nonzero_count == 2` — single `test` bond.

; ── init ─────────────────────────────────────
swrite32 θ¹¹ρ  0  0           ; counter = 0
swrite32 θ¹¹ρ  0  4           ; answer  = 0

: loop

; ── decode: leaves nonzero_count in pipeline ─
@include ../inc/decode_nonzero.winc

; ── filter: nonzero_count == 2 ──────────────
test θρ¹ρ  2

; ── accumulate: answer += filter_result ─────
swrite32 θρ¹ρ  32
sread32  θ¹ρρ  4
sadd32   θ¹ρρ  32
swrite32 θρ¹ρ  4

; ── increment counter, check loop cond ──────
sread32  θ¹ρρ  0
add      θρ¹ρ  1
swrite32 θρ¹ρ  0
lt       θρ¹ρ  81
loop_back loop

; ── return answer ───────────────────────────
sread32  θ¹ρρ  4
