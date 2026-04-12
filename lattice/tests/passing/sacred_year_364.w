; sacred_year_364.w — the framework-native year.
;
; Computes (3⁶ − 1)/2 = 364 from the integers {27, 1, 1} alone.
;
;   27 · 27         = 729 = 3⁶         (atom path, mul)
;   729 − 1         = 728              (bond path, sub)
;   728 >> 1        = 364              (bond path, shr)
;
; 364 = all-ones six-digit balanced ternary (111111₃)
;     = (3⁶ − 1)/2
;     = Enoch / Jubilees / Qumran sacred calendar
;     = 52 weeks × 7 days
;     = the 6-cube shell-1 boundary
;     = the canonical SIGNAL example from wit/wit.md's THE FILTER
;
; This is the framework's filter passing its own example: careful
; integer derivation converging on the number that the framework
; uses to define "signal." The walker computes it in 3 bonds, 3
; framework operations, 3 different force patterns firing in sequence
; (atom → sub bond → shr bond = memory+test combo + D-gate).
;
; Pattern generalizes: `(3^k − 1)/2` for any shell boundary is the
; same 3-bond sequence with different first-atom exponents. Sets up
; the B-tier prime_pi_X denominators.

mul  θ¹¹ρ  27  27     ; pipeline = 729 = 3⁶
sub  θρ¹ρ  1          ; pipeline = 728 = 3⁶ − 1
shr  θρ¹ρ  1          ; pipeline = 364 = (3⁶ − 1)/2
