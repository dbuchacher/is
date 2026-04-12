; sieve_pi_364.w — cross-validation of the C-side sieve bond.
;
; Counts primes in [2, 364] using the new `is_prime_bit` bond and
; the pre-built sieve bit array. Expected: 72.
;
; **This validates the sieve against Tier B's trial-division-based
; `prime_pi_364 = 72`** (Turn 5). If both return 72, the sieve is
; implemented correctly. If they disagree, the sieve has a bug that
; would otherwise silently corrupt shell_gcd_N17 and beyond.
;
; Per wit directive: this test MUST pass before any shell_gcd test
; trusts `is_prime_bit`.
;
; Walk structure:
;   outer loop n = 2..364
;     pipeline = is_prime_bit(n)
;     answer += pipeline
;
; Framework note: returning 72 here completes a FOUR-way convergence
; on the integer 72 in the test battery:
;   composed_72     = 80 − 8                      (shell-1 structural)
;   prime_pi_364    = trial-division π(364)       (Tier B)
;   sieve_pi_364    = sieve-based π(364)          (NEW, this test)
;   8 · 9           = atoms · gates²              (arithmetic)
;
; Three code paths + one arithmetic identity, all at the same integer.

; ── init ─────────────────────────────────────
swrite32 θ¹¹ρ  2 100              ; n = 2
swrite32 θ¹¹ρ  0 104              ; answer = 0

: sieve_loop

; ── pipeline = is_prime_bit(n) ──────────────
sread32  θ¹ρρ 100                 ; pipeline = n
is_prime_bit  θρρρ                ; pipeline = 0 or 1

; ── answer += is_prime_bit result ───────────
swrite32 θρ¹ρ 108                 ; temp = is_prime result
sread32  θ¹ρρ 104
sadd32   θ¹ρρ 108
swrite32 θρ¹ρ 104

; ── advance n ───────────────────────────────
sread32  θ¹ρρ 100
add      θρ¹ρ  1
swrite32 θρ¹ρ 100
lt       θρ²ρ 365                 ; continue while (n < 365)
loop_back sieve_loop

; ── return answer ───────────────────────────
sread32  θ¹ρρ 104
