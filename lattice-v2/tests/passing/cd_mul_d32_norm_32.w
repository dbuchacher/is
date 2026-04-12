; cd_mul_d32_norm_32.w — |q|² for all-ones pathion: real=32
; A = (1,1,...,1) at offset 0 (32 qwords = 256 bytes)
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
swrite64 θ¹¹ρ  1  128
swrite64 θ¹¹ρ  1  136
swrite64 θ¹¹ρ  1  144
swrite64 θ¹¹ρ  1  152
swrite64 θ¹¹ρ  1  160
swrite64 θ¹¹ρ  1  168
swrite64 θ¹¹ρ  1  176
swrite64 θ¹¹ρ  1  184
swrite64 θ¹¹ρ  1  192
swrite64 θ¹¹ρ  1  200
swrite64 θ¹¹ρ  1  208
swrite64 θ¹¹ρ  1  216
swrite64 θ¹¹ρ  1  224
swrite64 θ¹¹ρ  1  232
swrite64 θ¹¹ρ  1  240
swrite64 θ¹¹ρ  1  248
; B = conj(A) = (1,-1,-1,...,-1) at offset 256
; real component = 1
swrite64 θ¹²ρ  1  256
; imaginary components = -1 (use sub 0 1 = -1, then write)
sub      θ¹¹ρ  0  1
swrite64 θρ²ρ  264
swrite64 θρ²ρ  272
swrite64 θρ²ρ  280
swrite64 θρ²ρ  288
swrite64 θρ²ρ  296
swrite64 θρ²ρ  304
swrite64 θρ²ρ  312
swrite64 θρ²ρ  320
swrite64 θρ²ρ  328
swrite64 θρ²ρ  336
swrite64 θρ²ρ  344
swrite64 θρ²ρ  352
swrite64 θρ²ρ  360
swrite64 θρ²ρ  368
swrite64 θρ²ρ  376
swrite64 θρ²ρ  384
swrite64 θρ²ρ  392
swrite64 θρ²ρ  400
swrite64 θρ²ρ  408
swrite64 θρ²ρ  416
swrite64 θρ²ρ  424
swrite64 θρ²ρ  432
swrite64 θρ²ρ  440
swrite64 θρ²ρ  448
swrite64 θρ²ρ  456
swrite64 θρ²ρ  464
swrite64 θρ²ρ  472
swrite64 θρ²ρ  480
swrite64 θρ²ρ  488
swrite64 θρ²ρ  496
swrite64 θρ²ρ  504
; out at offset 512
cd_mul_d32 θ²²²  0  256  512
; read real part = 32
sread64  θ²ρρ  512
