; gcd64_bond_6.w — sanity test for fn_gcd64 primitive.
;
; gcd(12, 18) = 6, verified via the new bond (not the @include gcd.winc).
; Pairs with gcd_12_18_eq_6.w (Turn 7) which uses the include — same
; mathematical result, different implementation path.
;
; The bond path is required for multi-cell Tier C walks where gcd
; is called 4+ times per walk. The include path (gcd.winc) still
; works for single-use cases and stays in tests/inc/ as reference
; material.

swrite64 θ¹¹ρ  12  100           ; scratch[100] = 12
swrite64 θ¹¹ρ  18  108           ; scratch[108] = 18
gcd64    θ¹¹ρ 100  108           ; pipeline = gcd(12, 18) = 6
