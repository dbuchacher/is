; cd_mul_d4_norm_4.w — |q|² for q=(1,1,1,1): q·conj(q) real part = 4
; A = (1,1,1,1)
swrite64 θ¹¹ρ  1   0
swrite64 θ¹¹ρ  1   8
swrite64 θ¹¹ρ  1  16
swrite64 θ¹¹ρ  1  24
; B = conj(A) = (1,-1,-1,-1)
swrite64 θ¹¹ρ  1  32
neg      θ¹ρρ  1
swrite64 θρ¹ρ  40
neg      θ¹ρρ  1
swrite64 θρ¹ρ  48
neg      θ¹ρρ  1
swrite64 θρ¹ρ  56
cd_mul_d4 θ¹¹¹  0  32  64
sread64  θ¹ρρ  64
