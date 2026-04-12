; pyth_fill_25.w — Pythagorean fill constant.
;
; Computes 3² + 4² = 25 = pyth_fill = gates² + dims².
;
;   4 · 4       = 16        (atom path, mul — 4² derived)
;   16 + 9      = 25        (bond path, add — 9 hardcoded as 3²)
;
; Framework meaning: 25 is the integer "fill" of the (3, 4, 5)
; Pythagorean triple that the framework uses for the 4D hypercube
; shell-1 geometry. The triple appears as (gates, dims, fill√) and
; drives the pyth_identity = 19200 locked in A7.
;
; Compromise note: without memory, we can't hold 3² AND 4² in
; separate slots for a clean double-derivation. One square is
; computed via atom (4² here) and the other is hardcoded as a
; literal (9 for 3²). When the scratch buffer lands, a `pyth_fill_25_v2`
; test can derive both squares independently.
;
; The 3 and 4 are framework primitives (gates and dims from Post 1941
; + Hurwitz 1898). The 25 is their integer Pythagorean sum.

mul  θ¹¹ρ  4  4       ; pipeline = 16 = 4² = dims²
add  θρ¹ρ  9          ; pipeline = 25 = 4² + 3² (9 hardcoded as gates²)
