; cd_mul_d32_norm_32.w — |1 + e1 + e2 + ... + e31|² = 32.

; A = all ones
swrite64 θ²²ρ  1     0
swrite64 θ²²ρ  1     8
swrite64 θ²²ρ  1    16
swrite64 θ²²ρ  1    24
swrite64 θ²²ρ  1    32
swrite64 θ²²ρ  1    40
swrite64 θ²²ρ  1    48
swrite64 θ²²ρ  1    56
swrite64 θ²²ρ  1    64
swrite64 θ²²ρ  1    72
swrite64 θ²²ρ  1    80
swrite64 θ²²ρ  1    88
swrite64 θ²²ρ  1    96
swrite64 θ²²ρ  1   104
swrite64 θ²²ρ  1   112
swrite64 θ²²ρ  1   120
swrite64 θ²²ρ  1   128
swrite64 θ²²ρ  1   136
swrite64 θ²²ρ  1   144
swrite64 θ²²ρ  1   152
swrite64 θ²²ρ  1   160
swrite64 θ²²ρ  1   168
swrite64 θ²²ρ  1   176
swrite64 θ²²ρ  1   184
swrite64 θ²²ρ  1   192
swrite64 θ²²ρ  1   200
swrite64 θ²²ρ  1   208
swrite64 θ²²ρ  1   216
swrite64 θ²²ρ  1   224
swrite64 θ²²ρ  1   232
swrite64 θ²²ρ  1   240
swrite64 θ²²ρ  1   248

; B = conj(A) = (1, -1, -1, ..., -1)
swrite64 θ²²ρ  1  256
sub      θ¹¹ρ  0  1
swrite64 θρ²ρ  264
sub      θ¹¹ρ  0  1
swrite64 θρ²ρ  272
sub      θ¹¹ρ  0  1
swrite64 θρ²ρ  280
sub      θ¹¹ρ  0  1
swrite64 θρ²ρ  288
sub      θ¹¹ρ  0  1
swrite64 θρ²ρ  296
sub      θ¹¹ρ  0  1
swrite64 θρ²ρ  304
sub      θ¹¹ρ  0  1
swrite64 θρ²ρ  312
sub      θ¹¹ρ  0  1
swrite64 θρ²ρ  320
sub      θ¹¹ρ  0  1
swrite64 θρ²ρ  328
sub      θ¹¹ρ  0  1
swrite64 θρ²ρ  336
sub      θ¹¹ρ  0  1
swrite64 θρ²ρ  344
sub      θ¹¹ρ  0  1
swrite64 θρ²ρ  352
sub      θ¹¹ρ  0  1
swrite64 θρ²ρ  360
sub      θ¹¹ρ  0  1
swrite64 θρ²ρ  368
sub      θ¹¹ρ  0  1
swrite64 θρ²ρ  376
sub      θ¹¹ρ  0  1
swrite64 θρ²ρ  384
sub      θ¹¹ρ  0  1
swrite64 θρ²ρ  392
sub      θ¹¹ρ  0  1
swrite64 θρ²ρ  400
sub      θ¹¹ρ  0  1
swrite64 θρ²ρ  408
sub      θ¹¹ρ  0  1
swrite64 θρ²ρ  416
sub      θ¹¹ρ  0  1
swrite64 θρ²ρ  424
sub      θ¹¹ρ  0  1
swrite64 θρ²ρ  432
sub      θ¹¹ρ  0  1
swrite64 θρ²ρ  440
sub      θ¹¹ρ  0  1
swrite64 θρ²ρ  448
sub      θ¹¹ρ  0  1
swrite64 θρ²ρ  456
sub      θ¹¹ρ  0  1
swrite64 θρ²ρ  464
sub      θ¹¹ρ  0  1
swrite64 θρ²ρ  472
sub      θ¹¹ρ  0  1
swrite64 θρ²ρ  480
sub      θ¹¹ρ  0  1
swrite64 θρ²ρ  488
sub      θ¹¹ρ  0  1
swrite64 θρ²ρ  496
sub      θ¹¹ρ  0  1
swrite64 θρ²ρ  504

cd_mul_d32_c θ²²²     0 256 512

; return real = 32
sread64  θ²ρρ 512
