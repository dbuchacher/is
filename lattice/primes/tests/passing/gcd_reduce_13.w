; gcd_reduce_13.w — single-cell gcd reduction pipeline validation.
;
; This test validates the Tier C "per-cell reduction" pattern that
; will be used inside shell_identity.winc (Turn 8):
;
;     g_z = (A_z · B) / gcd(A_z · B, C · D_z)
;
; Using cell z=0 of the N=3 shell-identity theorem as the example:
;   A_z · B = 8 · 26 = 208    (signed primes × 3^N − 1)
;   C · D_z = 12 · 8 = 96     (2·π(x_N) × cell point count)
;   gcd(208, 96) = 16
;   g_0 = 208 / 16 = 13
;
; This exercises gcd.winc (via @include) AND the sdiv64 primitive
; (added this turn) in a realistic reduction flow. When the full
; shell_identity.winc lands in Turn 8, it'll run this pattern per
; cell z, accumulating gcd of g_z across cells.

; ── load num = 208, den = 96 ──
add      θ¹¹ρ 208  0
swrite64 θρ¹ρ 60              ; a = num = 208
add      θ¹¹ρ  96  0
swrite64 θρ¹ρ 68              ; b = den = 96

; ── gcd(num, den) ──
@include ../../../tests/inc/gcd.winc       ; pipeline = 16

; ── save gcd_val, then compute g = num / gcd_val ──
swrite64 θρ¹ρ 76              ; scratch[76] = gcd_val = 16

add      θ¹¹ρ 208  0          ; pipeline = num = 208
sdiv64   θ¹ρρ 76              ; pipeline = 208 / 16 = 13
