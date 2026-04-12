; prime_pi_13.w — B1: π(13) = 6.
;
; Counts primes in [2, 13]: {2, 3, 5, 7, 11, 13} = 6 primes.
;
; First Tier B test. Exercises the full trial-division stack:
;   outer loop over candidates n = 2..13
;   for each n, call inc/is_prime.winc (inner divisor loop)
;   accumulate primes into scratch[4]
;   return the count
;
; Scratch layout:
;   [0..4]  reserved (not used here, but kept free for decoder include)
;   [4]     answer = prime count so far
;   [32]    per-iter temp (filter result, for sadd32)
;   [40]    candidate n (is_prime.winc reads from here)
;   [44]    is_prime composite flag (clobbered by include)
;   [48]    is_prime current divisor d (clobbered by include)

; ── init ─────────────────────────────────────
swrite32 θ¹¹ρ  2  40          ; n = 2 (first candidate)
swrite32 θ¹¹ρ  0   4          ; answer = 0

: outer

; ── is_prime(n) → pipeline ──────────────────
@include ../../inc/is_prime.winc

; ── answer += is_prime ──────────────────────
swrite32 θρ¹ρ 32               ; scratch[32] = is_prime result
sread32  θ¹ρρ  4               ; pipeline = answer
sadd32   θ¹ρρ 32               ; pipeline += is_prime
swrite32 θρ¹ρ  4               ; scratch[4] = new answer

; ── advance n ───────────────────────────────
sread32  θ¹ρρ 40               ; pipeline = n
add      θρ¹ρ  1               ; pipeline = n + 1
swrite32 θρ¹ρ 40               ; scratch[40] = new n
lt       θρ¹ρ 14               ; continue while (n+1 < 14), i.e., n ≤ 13
loop_back outer

; ── return answer ───────────────────────────
sread32  θ¹ρρ  4
