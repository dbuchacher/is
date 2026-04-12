; cd_mul_d8_e1_squared_neg1.w — e₁² = -1
; A = e₁ = (0,1,0,...) at offset 0
swrite64 θ¹¹ρ  0   0
swrite64 θ¹¹ρ  1   8
swrite64 θ¹¹ρ  0  16
swrite64 θ¹¹ρ  0  24
swrite64 θ¹¹ρ  0  32
swrite64 θ¹¹ρ  0  40
swrite64 θ¹¹ρ  0  48
swrite64 θ¹¹ρ  0  56
; B = e₁ at offset 64
swrite64 θ¹¹ρ  0  64
swrite64 θ¹¹ρ  1  72
swrite64 θ¹¹ρ  0  80
swrite64 θ¹¹ρ  0  88
swrite64 θ¹¹ρ  0  96
swrite64 θ¹¹ρ  0  104
swrite64 θ¹¹ρ  0  112
swrite64 θ¹¹ρ  0  120
; out at offset 128
cd_mul_d8 θ¹¹¹  0  64  128
sread64  θ¹ρρ  128
