; shell1_80.w — A3: shell-1 nonzero count = 3⁴ − 1 = 80.
;
; Enumerates all 81 points in {−1, 0, +1}⁴, counts those where at
; least one coord is nonzero (= all 81 minus the origin [0,0,0,0]).
; Framework derivation: 80 = shell1_nz = 3⁴ − 1.
;
; Filter: `nonzero_count > 0` (equivalently `>= 1`) — single `gt` bond.
;
; Scratch layout:
;   [0]  outer loop counter (0..80)
;   [4]  answer (final = 80)
;   [24] decoder's internal accumulator (clobbered)
;   [28] decoder's per-axis temp (clobbered)
;   [32] per-iter filter result temp
;
; Skeleton shared with atoms_8 / composed_72 / faces_24 — only the
; filter predicate differs.

; ── init ─────────────────────────────────────
swrite32 θ¹¹ρ  0  0           ; counter = 0
swrite32 θ¹¹ρ  0  4           ; answer  = 0

: loop

; ── decode: leaves nonzero_count in pipeline ─
@include ../inc/decode_nonzero.winc

; ── filter: nonzero_count > 0 → 1 or 0 ──────
gt  θρ¹ρ  0

; ── accumulate: answer += filter_result ─────
swrite32 θρ¹ρ  32              ; scratch[32] = filter_result
sread32  θ¹ρρ  4               ; pipeline = answer
sadd32   θ¹ρρ  32              ; pipeline += filter_result
swrite32 θρ¹ρ  4               ; scratch[4] = new answer

; ── increment counter, check loop cond ──────
sread32  θ¹ρρ  0               ; pipeline = counter
add      θρ¹ρ  1               ; pipeline = counter + 1
swrite32 θρ¹ρ  0               ; scratch[0] = new counter
lt       θρ¹ρ  81              ; pipeline = (counter+1 < 81) ? 1 : 0
loop_back loop                  ; rewind if pipeline != 0

; ── return answer ───────────────────────────
sread32  θ¹ρρ  4
