; ssub32_test_neg2.w — sanity for pipeline -= scratch[offset].
;
; Sets scratch[0]=7, puts 5 in pipeline, runs ssub32 with offset 0.
; Expected: pipeline = 5 - 7 = -2 (signed int64).
;
; main.c prints signed decimal so "-2" comes out directly.

swrite32  θ¹¹ρ   7  0
add       θ¹¹ρ   5  0
ssub32    θ¹ρρ   0
