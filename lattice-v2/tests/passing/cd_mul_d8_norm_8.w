; cd_mul_d8_norm_8.w — |q|² for all-ones octonion: real=8
; A = (1,1,1,1,1,1,1,1) at offset 0
swrite64 θ¹¹ρ  1   0
swrite64 θ¹¹ρ  1   8
swrite64 θ¹¹ρ  1  16
swrite64 θ¹¹ρ  1  24
swrite64 θ¹¹ρ  1  32
swrite64 θ¹¹ρ  1  40
swrite64 θ¹¹ρ  1  48
swrite64 θ¹¹ρ  1  56
; B = conj(A) = (1,-1,-1,-1,-1,-1,-1,-1) at offset 64
swrite64 θ¹¹ρ  1  64
neg      θ¹ρρ  1
swrite64 θρ¹ρ  72
neg      θ¹ρρ  1
swrite64 θρ¹ρ  80
neg      θ¹ρρ  1
swrite64 θρ¹ρ  88
neg      θ¹ρρ  1
swrite64 θρ¹ρ  96
neg      θ¹ρρ  1
swrite64 θρ¹ρ  104
neg      θ¹ρρ  1
swrite64 θρ¹ρ  112
neg      θ¹ρρ  1
swrite64 θρ¹ρ  120
; out at offset 128
cd_mul_d8 θ¹¹¹  0  64  128
sread64  θ¹ρρ  128
