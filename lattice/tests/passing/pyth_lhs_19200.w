; pyth_lhs_19200.w — LHS of the Pythagorean integer identity at N=4.
;
; Computes 20 · 80 · 12 = 19200.
;
;   20 = signed primes at edges (2·10)
;   80 = shell1 nonzero points (3⁴ − 1)
;   12 = gates · dims = 3 · 4
;
; The product equals the RHS (24·32·25, see pyth_rhs_19200.w). Both
; sides lock on 19200 = 2⁶·3·5² — the framework's most important
; integer equation at the 4D hypercube.
;
; Walk structure: atom → atom, chained via pipeline.
;
;   mul θ¹¹ρ 20 80   → pipeline = 20·80 = 1600
;   mul θρ¹ρ 12      → pipeline = 1600·12 = 19200
;
; The second mul uses θρ¹ρ (flags 0x04 = arg0 from pipeline, arg1 u8,
; arg2 pipeline). First-arg-from-pipeline is how multi-step arithmetic
; chains through the walker without touching memory.

mul  θ¹¹ρ  20  80
mul  θρ¹ρ  12
