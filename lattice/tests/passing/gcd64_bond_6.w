; gcd64_bond_6.w — gcd(12, 18) = 6
; Write 12 to scratch[0], 18 to scratch[8]
swrite64   θ¹¹ρ  12  0
swrite64   θ¹¹ρ  18  8
; gcd64 takes offset_a=arg0, offset_b=arg1
gcd64      θ¹¹ρ  0  8
