; cd_mul_d16_norm_16.w — |q|² for all-ones sedenion: real=16
; A = (1,1,...,1) at offset 0
swrite64 θ¹¹ρ  1   0
swrite64 θ¹¹ρ  1   8
swrite64 θ¹¹ρ  1  16
swrite64 θ¹¹ρ  1  24
swrite64 θ¹¹ρ  1  32
swrite64 θ¹¹ρ  1  40
swrite64 θ¹¹ρ  1  48
swrite64 θ¹¹ρ  1  56
swrite64 θ¹¹ρ  1  64
swrite64 θ¹¹ρ  1  72
swrite64 θ¹¹ρ  1  80
swrite64 θ¹¹ρ  1  88
swrite64 θ¹¹ρ  1  96
swrite64 θ¹¹ρ  1  104
swrite64 θ¹¹ρ  1  112
swrite64 θ¹¹ρ  1  120
; B = conj(A) = (1,-1,...,-1) at offset 128
swrite64 θ¹¹ρ  1  128
neg      θ¹ρρ  1
swrite64 θρ¹ρ  136
neg      θ¹ρρ  1
swrite64 θρ¹ρ  144
neg      θ¹ρρ  1
swrite64 θρ¹ρ  152
neg      θ¹ρρ  1
swrite64 θρ¹ρ  160
neg      θ¹ρρ  1
swrite64 θρ¹ρ  168
neg      θ¹ρρ  1
swrite64 θρ¹ρ  176
neg      θ¹ρρ  1
swrite64 θρ¹ρ  184
neg      θ¹ρρ  1
swrite64 θρ¹ρ  192
neg      θ¹ρρ  1
swrite64 θρ¹ρ  200
neg      θ¹ρρ  1
swrite64 θρ¹ρ  208
neg      θ¹ρρ  1
swrite64 θρ¹ρ  216
neg      θ¹ρρ  1
swrite64 θρ¹ρ  224
neg      θ¹ρρ  1
swrite64 θρ¹ρ  232
neg      θ¹ρρ  1
swrite64 θρ¹ρ  240
neg      θ¹ρρ  1
swrite64 θρ¹ρ  248
; out at offset 256
cd_mul_d16 θ²²²  0  128  256
sread64  θ²ρρ  256
