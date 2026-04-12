; cd_mul_d32_identity_2.w — pathion identity (A=1, B=1+2e1+...+32e31)
; Read out[1] = e1 coef = 2.

; A = scalar 1
swrite64 θ²²ρ  1    0
swrite64 θ²²ρ  0     8
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

; B = (1, 2, ..., 32)
swrite64 θ²²ρ   1   256
swrite64 θ²²ρ   2   264
swrite64 θ²²ρ   3   272
swrite64 θ²²ρ   4   280
swrite64 θ²²ρ   5   288
swrite64 θ²²ρ   6   296
swrite64 θ²²ρ   7   304
swrite64 θ²²ρ   8   312
swrite64 θ²²ρ   9   320
swrite64 θ²²ρ  10   328
swrite64 θ²²ρ  11   336
swrite64 θ²²ρ  12   344
swrite64 θ²²ρ  13   352
swrite64 θ²²ρ  14   360
swrite64 θ²²ρ  15   368
swrite64 θ²²ρ  16   376
swrite64 θ²²ρ  17   384
swrite64 θ²²ρ  18   392
swrite64 θ²²ρ  19   400
swrite64 θ²²ρ  20   408
swrite64 θ²²ρ  21   416
swrite64 θ²²ρ  22   424
swrite64 θ²²ρ  23   432
swrite64 θ²²ρ  24   440
swrite64 θ²²ρ  25   448
swrite64 θ²²ρ  26   456
swrite64 θ²²ρ  27   464
swrite64 θ²²ρ  28   472
swrite64 θ²²ρ  29   480
swrite64 θ²²ρ  30   488
swrite64 θ²²ρ  31   496
swrite64 θ²²ρ  32   504

cd_mul_d32_c θ²²²     0 256 512

; return out[1] = 2
sread64  θ²ρρ 520
