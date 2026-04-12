; siadd64_test_17.w — scratch[8] starts at 0, add 10 then add 7 = 17
; siadd64: scratch[pipeline_offset] += delta
; pipeline = 8 (offset), delta (arg1) = 10
add        θ¹¹ρ  8  0
siadd64    θρ¹ρ  10
; pipeline = 8, delta = 7
add        θ¹¹ρ  8  0
siadd64    θρ¹ρ  7
; read back
sread64    θ¹ρρ  8
