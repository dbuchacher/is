; shell_gcd_N3_c.w — N=3 full pipeline via PARALLEL C phase 1.
;
; **Cross-validation walk for the C-side parallel phase 1 bond.**
;
; Expected: 13 (MUST match shell_gcd_N3.w's walker-phase-1 result)
;
; If this returns 13, the C-side balanced-ternary decoder + cell
; classification matches the walker-side version exactly, and the
; parallel phase 1 is safe to use at N=17 and N=18.
;
; If this returns anything other than 13, the C code has a bug and
; parallel Tier C is NOT safe — fall back to walker-side phase 1
; until the bug is fixed.
;
; Same phase 2+3 reduction as shell_gcd_N3.w. Only phase 1 differs.

; ── Init A_z counters (C phase 1 writes them but we zero first) ──
swrite64 θ¹¹ρ 0 60
swrite64 θ¹¹ρ 0 68
swrite64 θ¹¹ρ 0 76
swrite64 θ¹¹ρ 0 84

; ── Phase 1: parallel C classification ────────────
; Args: N=3, x_N=13, A_out_offset=60. Returns pi_count in pipeline.
shell_phase1_c θ²²² 3 13 60

; Save pi_count and compute C = 2·pi_count
shl      θρ¹ρ  1                 ; pipeline = 2·pi_count = C
swrite64 θρ¹ρ 192                ; C stored at [192..200]

; Init gcd_total = 0
swrite64 θ¹¹ρ 0 224

; ══════════════════════════════════════════════════════════
; Phase 2: per-cell reduction (identical to shell_gcd_N3.w)
; ══════════════════════════════════════════════════════════

; ── Cell z=0 (D_0 = 8) ──
sread64  θ¹ρρ  60
mul      θρ¹ρ 26
swrite64 θρ¹ρ 200
sread64  θ¹ρρ 192
mul      θρ¹ρ  8
swrite64 θρ¹ρ 208
gcd64    θ¹¹ρ 200 208
swrite64 θρ¹ρ 216
sread64  θ¹ρρ 200
sdiv64   θ¹ρρ 216
swrite64 θρ¹ρ 208
gcd64    θ¹¹ρ 224 208
swrite64 θρ¹ρ 224

; ── Cell z=1 (D_1 = 12) ──
sread64  θ¹ρρ  68
mul      θρ¹ρ 26
swrite64 θρ¹ρ 200
sread64  θ¹ρρ 192
mul      θρ¹ρ 12
swrite64 θρ¹ρ 208
gcd64    θ¹¹ρ 200 208
swrite64 θρ¹ρ 216
sread64  θ¹ρρ 200
sdiv64   θ¹ρρ 216
swrite64 θρ¹ρ 208
gcd64    θ¹¹ρ 224 208
swrite64 θρ¹ρ 224

; ── Cell z=2 (D_2 = 6) ──
sread64  θ¹ρρ  76
mul      θρ¹ρ 26
swrite64 θρ¹ρ 200
sread64  θ¹ρρ 192
mul      θρ¹ρ  6
swrite64 θρ¹ρ 208
gcd64    θ¹¹ρ 200 208
swrite64 θρ¹ρ 216
sread64  θ¹ρρ 200
sdiv64   θ¹ρρ 216
swrite64 θρ¹ρ 208
gcd64    θ¹¹ρ 224 208
swrite64 θρ¹ρ 224

; ── Cell z=3 (D_3 = 1) ──
sread64  θ¹ρρ  84
mul      θρ¹ρ 26
swrite64 θρ¹ρ 200
sread64  θ¹ρρ 192
mul      θρ¹ρ  1
swrite64 θρ¹ρ 208
gcd64    θ¹¹ρ 200 208
swrite64 θρ¹ρ 216
sread64  θ¹ρρ 200
sdiv64   θ¹ρρ 216
swrite64 θρ¹ρ 208
gcd64    θ¹¹ρ 224 208
swrite64 θρ¹ρ 224

; ── Return gcd_total ─────────────────────────
sread64  θ¹ρρ 224
