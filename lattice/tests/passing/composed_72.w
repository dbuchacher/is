; composed_72.w — A4: composed shell-1 count = 72.
;
; Enumerates {−1, 0, +1}⁴ (81 points), counts those with AT LEAST TWO
; nonzero coords — the "compositional" subset that needs more than one
; axis to describe. Framework derivation: 72 = 80 − 8 = shell1_nz minus
; single-axis atoms.
;
; This is the integer that π(364) lands on in Tier B4 — three
; independent framework derivations all converge on 72:
;   80 − 8    (shell-1 minus atoms, this test)
;   8 · 9     (atoms · gates²)
;   π(364)    (prime count at 6-cube shell boundary)
;
; Filter: `nonzero_count > 1` (equivalently `>= 2`) — single `gt` bond.
;
; Filter definition per wit Q1: use interpretation (a), "at least 2
; nonzero coords" — the framework-canonical definition per
; wit/thoughts/prime-lattice/findings/03-shell-identity-theorem.md.
; Interpretation (b) "faces + edges + corners partition" gives the
; same integer by arithmetic but tests a different semantic.

; ── init ─────────────────────────────────────
swrite32 θ¹¹ρ  0  0           ; counter = 0
swrite32 θ¹¹ρ  0  4           ; answer  = 0

: loop

; ── decode: leaves nonzero_count in pipeline ─
@include ../inc/decode_nonzero.winc

; ── filter: nonzero_count > 1 ──────────────
gt  θρ¹ρ  1

; ── accumulate: answer += filter_result ─────
swrite32 θρ¹ρ  32
sread32  θ¹ρρ  4
sadd32   θ¹ρρ  32
swrite32 θρ¹ρ  4

; ── increment counter, check loop cond ──────
sread32  θ¹ρρ  0
add      θρ¹ρ  1
swrite32 θρ¹ρ  0
lt       θρ¹ρ  81
loop_back loop

; ── return answer ───────────────────────────
sread32  θ¹ρρ  4
