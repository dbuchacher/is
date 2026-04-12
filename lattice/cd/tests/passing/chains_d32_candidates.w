; chains_d32_candidates.w — denominator of the Tier D chain ratio.
;
; Returns the total number of canonical chain-candidate triples
; enumerated at d=32 (all triples (A, B, C) with A·B=0 AND B·C=0,
; regardless of whether A·C=0). The chain count (chains_d32 = 3024)
; divided by this denominator is the exact integer chain ratio for
; Tier D.4.
;
; Runs the same enumeration as chains_d32 but increments the
; candidate counter instead of testing A·C for zero.

chains_d32_candidates θρρρ
