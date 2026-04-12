; cd_mul_d4_noncommutative_neg1.w — verify ij≠ji (ij=k, ji=-k)
; Compute j·i, read k-component. Should be -1 (ji = -k).
; A = j = (0,0,1,0)
swrite64 θ¹¹ρ  0   0
swrite64 θ¹¹ρ  0   8
swrite64 θ¹¹ρ  1  16
swrite64 θ¹¹ρ  0  24
; B = i = (0,1,0,0)
swrite64 θ¹¹ρ  0  32
swrite64 θ¹¹ρ  1  40
swrite64 θ¹¹ρ  0  48
swrite64 θ¹¹ρ  0  56
cd_mul_d4 θ¹¹¹  0  32  64
sread64  θ¹ρρ  88
