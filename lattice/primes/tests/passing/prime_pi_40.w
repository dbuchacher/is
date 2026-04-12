; prime_pi_40.w — B2: π(40) = 12 = gates · dims.
;
; FIRST FRAMEWORK CONVERGENCE at the 4D hypercube shell boundary.
;
; Counts primes in [2, 40]: {2, 3, 5, 7, 11, 13, 17, 19, 23, 29, 31, 37}
; = 12 primes = 3 · 4 = gates · dims.
;
; The framework's two fundamental theorems (Post 1941 gate completeness
; → gates = 3, Hurwitz 1898 normed division algebras → dims = 4)
; multiply to give the integer that π lands on at the x_4 shell
; boundary of the 4D ternary lattice. The lattice tool verifies this
; by exhaustive trial division, zero floating-point, no tolerance.
;
; Same walk skeleton as prime_pi_13 — only the upper bound differs.

; ── init ─────────────────────────────────────
swrite32 θ¹¹ρ  2  40          ; n = 2
swrite32 θ¹¹ρ  0   4          ; answer = 0

: outer

; ── is_prime(n) → pipeline ──────────────────
@include ../../inc/is_prime.winc

; ── answer += is_prime ──────────────────────
swrite32 θρ¹ρ 32
sread32  θ¹ρρ  4
sadd32   θ¹ρρ 32
swrite32 θρ¹ρ  4

; ── advance n ───────────────────────────────
sread32  θ¹ρρ 40
add      θρ¹ρ  1
swrite32 θρ¹ρ 40
lt       θρ¹ρ 41               ; n ≤ 40
loop_back outer

; ── return answer ───────────────────────────
sread32  θ¹ρρ  4
