; smod32_test_3.w — sanity for pipeline = pipeline mod scratch[offset].
;
; Sets scratch[0]=5, puts 13 in pipeline, runs smod32 with offset 0.
; Expected: pipeline = 13 mod 5 = 3.
;
; This validates the "pipeline mod memory" primitive before
; is_prime.winc depends on it to check `n % d` where n is the
; candidate in pipeline and d is the current divisor in scratch.

swrite32  θ¹¹ρ   5  0
add       θ¹¹ρ  13  0
smod32    θ¹ρρ   0
