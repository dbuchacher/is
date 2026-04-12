; atoms_8.w — A2: shell-1 atom count = 8.
;
; Enumerates {−1, 0, +1}⁴ (81 points), counts those with exactly ONE
; nonzero coord. Framework: atoms = dims · 2 polarities = 4 · 2 = 8.
; These are the 8 single-axis shell-1 points: [±1,0,0,0], [0,±1,0,0],
; [0,0,±1,0], [0,0,0,±1] — the "atoms" of the lattice (one force
; active per point, one axis at a time).
;
; Filter: `nonzero_count == 1` — single `test` bond.
;
; Same skeleton as shell1_80 / composed_72 / faces_24, only the
; filter predicate differs. See _decode_nonzero.winc for the decoder.

; ── init ─────────────────────────────────────
swrite32 θ¹¹ρ  0  0           ; counter = 0
swrite32 θ¹¹ρ  0  4           ; answer  = 0

: loop

; ── decode: leaves nonzero_count in pipeline ─
@include ../inc/decode_nonzero.winc

; ── filter: nonzero_count == 1 ──────────────
test θρ¹ρ  1

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
