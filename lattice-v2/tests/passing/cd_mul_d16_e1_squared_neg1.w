; cd_mul_d16_e1_squared_neg1.w — e₁² = -1
; A = e₁ = (0,1,0...) at offset 0
swrite64 θ¹¹ρ  0   0
swrite64 θ¹¹ρ  1   8
swrite64 θ¹¹ρ  0  16
swrite64 θ¹¹ρ  0  24
swrite64 θ¹¹ρ  0  32
swrite64 θ¹¹ρ  0  40
swrite64 θ¹¹ρ  0  48
swrite64 θ¹¹ρ  0  56
swrite64 θ¹¹ρ  0  64
swrite64 θ¹¹ρ  0  72
swrite64 θ¹¹ρ  0  80
swrite64 θ¹¹ρ  0  88
swrite64 θ¹¹ρ  0  96
swrite64 θ¹¹ρ  0  104
swrite64 θ¹¹ρ  0  112
swrite64 θ¹¹ρ  0  120
; B = e₁ at offset 128 (same as A)
swrite64 θ¹¹ρ  0  128
swrite64 θ¹¹ρ  1  136
swrite64 θ¹¹ρ  0  144
swrite64 θ¹¹ρ  0  152
swrite64 θ¹¹ρ  0  160
swrite64 θ¹¹ρ  0  168
swrite64 θ¹¹ρ  0  176
swrite64 θ¹¹ρ  0  184
swrite64 θ¹¹ρ  0  192
swrite64 θ¹¹ρ  0  200
swrite64 θ¹¹ρ  0  208
swrite64 θ¹¹ρ  0  216
swrite64 θ¹¹ρ  0  224
swrite64 θ¹¹ρ  0  232
swrite64 θ¹¹ρ  0  240
swrite64 θ¹¹ρ  0  248
; out at offset 256, read real part = -1
cd_mul_d16 θ²²²  0  128  256
sread64  θ²ρρ  256
