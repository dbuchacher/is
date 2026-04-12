; zero_divisors_d16.w — Tier D.3 structural probe.
;
; Enumerates all canonical zero-divisor candidate pairs (A, B) at
; sedenion dimension 16 and counts those where A · B = 0 exactly
; (all 16 integer components of the product are zero).
;
; Canonical form:
;   A = e_i + e_j            (1 ≤ i < j ≤ 15)
;   B = e_k + sign · e_l     (1 ≤ k < l ≤ 15, sign ∈ {−1, +1})
;   skip the single case (i,j)==(k,l) with sign = +1 (A == B)
;
; Total candidates = C(15,2)² · 2 − C(15,2) = 21945.
; Expected zero-divisor count = **168**  (from wit-side Python compute:
; wit/thoughts/prime-lattice/code/cayley_dickson_integer.py)
;
; If the walker returns 168, the d=16 zero-divisor count is machine-
; verified against Python's independent exact integer arithmetic.
;
; Implementation: fn_zero_divisors_d16 is a walker bond that calls
; a C function in main.c. Pipeline receives the integer count.

zero_divisors_d16 θρρρ
