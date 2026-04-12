; chains_d32.w — Tier D.4 chain count at d=32 — THE TARGET.
;
; This integer replaces the old "19% chain rate" float estimate from
; prior/ToE/wit/findings/c/chain.c that used fabs < 1e-10 and sampling.
; The walker computes it exhaustively in signed 64-bit integer
; arithmetic through integer Cayley-Dickson. No floats, no sampling,
; no epsilon — just the exact count.
;
; First walker-exclusive finding at Tier D. Locks the ground truth.
;
; Runtime: parallel C through cd_mul_d32 + exhaustive triple iteration.
; Estimated 1-2 min pegged CPU on the 3950X.

chains_d32 θρρρ
