; cd_mul_d32_e1_squared_neg1.w — e1² = −1 in pathion basis.

; A = e1
swrite64 θ²²ρ  0    0
swrite64 θ²²ρ  1    8
swrite64 θ²²ρ  0    16
swrite64 θ²²ρ  0    24
swrite64 θ²²ρ  0    32
swrite64 θ²²ρ  0    40
swrite64 θ²²ρ  0    48
swrite64 θ²²ρ  0    56
swrite64 θ²²ρ  0    64
swrite64 θ²²ρ  0    72
swrite64 θ²²ρ  0    80
swrite64 θ²²ρ  0    88
swrite64 θ²²ρ  0    96
swrite64 θ²²ρ  0   104
swrite64 θ²²ρ  0   112
swrite64 θ²²ρ  0   120
swrite64 θ²²ρ  0   128
swrite64 θ²²ρ  0   136
swrite64 θ²²ρ  0   144
swrite64 θ²²ρ  0   152
swrite64 θ²²ρ  0   160
swrite64 θ²²ρ  0   168
swrite64 θ²²ρ  0   176
swrite64 θ²²ρ  0   184
swrite64 θ²²ρ  0   192
swrite64 θ²²ρ  0   200
swrite64 θ²²ρ  0   208
swrite64 θ²²ρ  0   216
swrite64 θ²²ρ  0   224
swrite64 θ²²ρ  0   232
swrite64 θ²²ρ  0   240
swrite64 θ²²ρ  0   248

; B = e1
swrite64 θ²²ρ  0  256
swrite64 θ²²ρ  1  264
swrite64 θ²²ρ  0   272
swrite64 θ²²ρ  0   280
swrite64 θ²²ρ  0   288
swrite64 θ²²ρ  0   296
swrite64 θ²²ρ  0   304
swrite64 θ²²ρ  0   312
swrite64 θ²²ρ  0   320
swrite64 θ²²ρ  0   328
swrite64 θ²²ρ  0   336
swrite64 θ²²ρ  0   344
swrite64 θ²²ρ  0   352
swrite64 θ²²ρ  0   360
swrite64 θ²²ρ  0   368
swrite64 θ²²ρ  0   376
swrite64 θ²²ρ  0   384
swrite64 θ²²ρ  0   392
swrite64 θ²²ρ  0   400
swrite64 θ²²ρ  0   408
swrite64 θ²²ρ  0   416
swrite64 θ²²ρ  0   424
swrite64 θ²²ρ  0   432
swrite64 θ²²ρ  0   440
swrite64 θ²²ρ  0   448
swrite64 θ²²ρ  0   456
swrite64 θ²²ρ  0   464
swrite64 θ²²ρ  0   472
swrite64 θ²²ρ  0   480
swrite64 θ²²ρ  0   488
swrite64 θ²²ρ  0   496
swrite64 θ²²ρ  0   504

cd_mul_d32_c θ²²²     0 256 512

; return out[0] = -1
sread64  θ²ρρ 512
