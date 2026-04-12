; sum_1_to_10_eq_55.w — control flow test: sum 1+2+...+10 = 55
;
; scratch[0] = accumulator (starts at 0)
; scratch[8] = i (starts at 10, counts down to 0)
;
; loop:
;   load i into pipeline
;   scratch[0] += pipeline  (acc += i)
;   reload i, decrement, store back
;   if i > 0: loop

; init i = 10
swrite64 θ¹¹ρ  10  8

: loop
; pipeline = i
sread64  θ¹ρρ  8
; acc += pipeline (= i). siadd64(offset=0, delta=pipeline)
siadd64  θ¹ρρ  0
; reload i (siadd64 clobbered pipeline with new acc)
sread64  θ¹ρρ  8
; i = i - 1
sub      θρ¹ρ  1
; store i back
swrite64 θρ¹ρ  8
; pipeline = i-1. if != 0, loop
loop_back loop

; return acc
sread64  θ¹ρρ  0
