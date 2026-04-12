; gcd_12_18_eq_6.w — sanity test for gcd.winc.
;
; gcd(12, 18) = 6. Traces:
;   iter 1: a=12, b=18. t = 12 mod 18 = 12. a=18, b=12.
;   iter 2: a=18, b=12. t = 18 mod 12 = 6.  a=12, b=6.
;   iter 3: a=12, b=6.  t = 12 mod 6  = 0.  a=6,  b=0.  Exit.
;   return a = 6.

add      θ¹¹ρ  12  0         ; pipeline = 12
swrite64 θρ¹ρ 60              ; scratch[60] = 12 (a)
add      θ¹¹ρ  18  0         ; pipeline = 18
swrite64 θρ¹ρ 68              ; scratch[68] = 18 (b)

@include ../inc/gcd.winc      ; pipeline = gcd(12, 18) = 6
