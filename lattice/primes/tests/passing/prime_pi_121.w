; prime_pi_121.w — B3: π(121) = 30.
;
; Counts primes in [2, 121]: exactly 30 primes up to 11² = 121.
;
; Shell boundary at N=5: x_5 = (3⁵−1)/2 = 121 = 11².
; First test where the shell boundary is a perfect square (not a
; framework claim in itself, just a feature of this particular N).
;
; Same skeleton as prime_pi_13 / prime_pi_40 — only the upper bound
; differs. Runtime: ~120 outer × ~5 inner ≈ 600 is_prime bodies,
; each ~30 bonds = ~18000 bond dispatches. Sub-second.

; ── init ─────────────────────────────────────
swrite32 θ¹¹ρ  2  40
swrite32 θ¹¹ρ  0   4

: outer

@include ../../inc/is_prime.winc

swrite32 θρ¹ρ 32
sread32  θ¹ρρ  4
sadd32   θ¹ρρ 32
swrite32 θρ¹ρ  4

sread32  θ¹ρρ 40
add      θρ¹ρ  1
swrite32 θρ¹ρ 40
lt       θρ¹ρ 122              ; n ≤ 121
loop_back outer

sread32  θ¹ρρ  4
