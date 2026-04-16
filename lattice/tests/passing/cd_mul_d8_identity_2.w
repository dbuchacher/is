; cd_mul_d8_identity_2.w — 1·(1+2e₁+0...) verify e₁=2
; A = (1,0,0,0,0,0,0,0) at offset 0
swrite64 θ¹¹ρ  1   0
swrite64 θ¹¹ρ  0   8
swrite64 θ¹¹ρ  0  16
swrite64 θ¹¹ρ  0  24
swrite64 θ¹¹ρ  0  32
swrite64 θ¹¹ρ  0  40
swrite64 θ¹¹ρ  0  48
swrite64 θ¹¹ρ  0  56
; B = (1,2,0,0,0,0,0,0) at offset 64
swrite64 θ¹¹ρ  1  64
swrite64 θ¹¹ρ  2  72
swrite64 θ¹¹ρ  0  80
swrite64 θ¹¹ρ  0  88
swrite64 θ¹¹ρ  0  96
swrite64 θ¹¹ρ  0  104
swrite64 θ¹¹ρ  0  112
swrite64 θ¹¹ρ  0  120
; out at offset 128
cd_mul_d8 θ¹¹¹  0  64  128
sread64  θ¹ρρ  136
