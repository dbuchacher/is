; zero_divisors_d32.w — Tier D.3 at d=32.
;
; Same canonical form as d16 but at pathion dimension. Total
; candidate pairs = C(31,2)² · 2 − C(31,2) = 465² · 2 − 465 = 431985.
; Expected count: **2520** (Python projection; first walker-exclusive
; verify since d=32 is beyond Python's comfortable exhaust).
;
; If the walker returns 2520 AND zero_divisors_d16 = 168, the CD
; doubling from d16 → d32 is trusted and the chain probe at d32
; can be fired.

zero_divisors_d32 θρρρ
