; sadd32_test_15.w — sanity test for pipeline += scratch[offset].
;
; Sets scratch[0]=10, puts 5 in pipeline, runs sadd32 with offset 0.
; Expected result: pipeline = 5 + 10 = 15.
;
; Bond flow:
;   swrite32 θ¹¹ρ 10 0    ; scratch[0] = 10 (value=10, offset=0)
;   add      θ¹¹ρ  5 0    ; pipeline = 5 + 0 = 5
;   sadd32   θ¹ρρ  0      ; pipeline = pipeline + scratch[0] = 5 + 10 = 15
;
; Proves the new sadd32 primitive before the decoder skeleton depends
; on it for 81 iterations × 4 axes of summation.

swrite32  θ¹¹ρ  10  0
add       θ¹¹ρ   5  0
sadd32    θ¹ρρ   0
