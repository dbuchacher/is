; cd_mul_d4_i_squared_neg1.w — i·i = -1, verify real=-1
; A = (0,1,0,0) = i
swrite64 θ¹¹ρ  0   0
swrite64 θ¹¹ρ  1   8
swrite64 θ¹¹ρ  0  16
swrite64 θ¹¹ρ  0  24
; B = (0,1,0,0) = i
swrite64 θ¹¹ρ  0  32
swrite64 θ¹¹ρ  1  40
swrite64 θ¹¹ρ  0  48
swrite64 θ¹¹ρ  0  56
cd_mul_d4 θ¹¹¹  0  32  64
sread64  θ¹ρρ  64
