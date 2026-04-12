; siadd64_test_17.w — sanity test for scratch_add_indirect64.
;
; Writes 10 at scratch[80], then uses pipeline=80 (dynamic offset)
; to increment it by 7 via siadd64. Expected: 10 + 7 = 17.
;
; This validates the "dynamic offset via pipeline, delta via literal"
; pattern that shell_phase1.winc needs for per-cell A[z] counter
; bumping where z is computed at runtime from the balanced-ternary
; decoder.

swrite64 θ¹¹ρ 10 80              ; scratch[80] = 10
add      θ¹¹ρ 80  0              ; pipeline = 80 (the offset, dynamic)
siadd64  θρ¹ρ  7                 ; scratch[80] += 7, pipeline = 17
