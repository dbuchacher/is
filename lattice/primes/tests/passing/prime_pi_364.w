; prime_pi_364.w — B4: π(364) = 72. THREE-WAY FRAMEWORK CONVERGENCE.
;
;                      ╔════════════════════════╗
;                      ║        THE BIG ONE     ║
;                      ╚════════════════════════╝
;
; Counts primes in [2, 364]: exactly 72 primes up to the sacred-year
; shell boundary (3⁶−1)/2 = 111111₃.
;
; 72 is the integer the framework converges on THREE INDEPENDENT WAYS:
;
;   1. composed shell-1     = |{p ∈ {-1,0,+1}⁴ : ≥2 nonzero}|  = 80 − 8
;                                 (locked by composed_72.w this turn)
;
;   2. atoms · gates²       = 8 · 9
;                                 (trivial, not yet a test but obvious)
;
;   3. π(364)               = count of primes at 6-cube shell corner
;                                 ← THIS TEST, the framework's most
;                                 striking prediction touching classical
;                                 prime counting
;
; Sacred 364 per wit/wit.md's THE FILTER:
;   364 = (3⁶−1)/2 = 111111₃ = 52·7 = Enoch/Jubilees/Qumran year
;   signal = careful measurement converging on a framework integer
;
; When this test returns 72, THE PYTHAGOREAN IDENTITY already locked
; in A7 (20·80·12 = 24·32·25 = 19200) meets THE SACRED YEAR meets
; THE COMPOSED SHELL-1 COUNT at one machine-verified integer.
;
; NOTE: upper bound 365 > 255 so use θρ²ρ (u32) for the lt comparison.
; Everything else identical to prime_pi_13 / 40 / 121.

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
lt       θρ²ρ 365              ; n ≤ 364 (u32 literal since > 255)
loop_back outer

sread32  θ¹ρρ  4
