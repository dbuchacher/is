; pyth_rhs_19200.w — RHS of the Pythagorean integer identity at N=4.
;
; Computes 24 · 32 · 25 = 19200.
;
;   24 = 2-faces of the 4-cube = C(4,2)·2²
;   32 = bonds = 16·2 polarities (also edges = 32)
;   25 = pyth_fill = 3² + 4² = gates² + dims²
;
; The product equals the LHS (20·80·12, see pyth_lhs_19200.w). Both
; sides lock on 19200. The Pythagorean identity at the 4-cube:
;
;     signed_primes · shell1_nz · (gates·dims)   =   faces · bonds · (gates² + dims²)
;            20      ·    80     ·        12     =    24   ·   32  ·          25
;                                19200           =            19200
;
; Every factor on both sides is a pure framework constant, and the
; two distinct integer decompositions produce the same integer. Pure
; cross-multiplication — no division, no float, no tolerance.

mul  θ¹¹ρ  24  32
mul  θρ¹ρ  25
