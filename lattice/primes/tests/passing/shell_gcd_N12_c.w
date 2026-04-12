; shell_gcd_N12_c.w — N=12 full pipeline via parallel C phase 1.
;
; Expected: 91 (MUST match shell_gcd_N12.w's walker-phase-1 result)
;
; This is the parallel-C cross-validation of the celebrated N=12
; theorem-failure test. Phase 2+3 (the reduction = theorem under test)
; is identical to shell_gcd_N12.w. Only phase 1 (prime enumeration +
; cell classification) is replaced with the parallel C path.
;
; N=12 was the fast-battery bottleneck at ~820 ms in serial walker
; form. Parallel C path should drop it to ~10-20 ms — the fast
; battery as a whole should drop from ~900 ms to ~100 ms.
;
; N=12 constants (identical to shell_gcd_N12.w):
;   x_12 = 265720, B = 531440 = 3^12 − 1
;   D_z = C(12, z) · 2^(12−z)

; ══════════════════════════════════════════════════════════
; Init: zero 13 A_z counters
; ══════════════════════════════════════════════════════════

swrite64 θ¹¹ρ 0  60              ; A_0
swrite64 θ¹¹ρ 0  68              ; A_1
swrite64 θ¹¹ρ 0  76              ; A_2
swrite64 θ¹¹ρ 0  84              ; A_3
swrite64 θ¹¹ρ 0  92              ; A_4
swrite64 θ¹¹ρ 0 100              ; A_5
swrite64 θ¹¹ρ 0 108              ; A_6
swrite64 θ¹¹ρ 0 116              ; A_7
swrite64 θ¹¹ρ 0 124              ; A_8
swrite64 θ¹¹ρ 0 132              ; A_9
swrite64 θ¹¹ρ 0 140              ; A_10
swrite64 θ¹¹ρ 0 148              ; A_11
swrite64 θ¹¹ρ 0 156              ; A_12

; ══════════════════════════════════════════════════════════
; Phase 1: parallel C classification
; Args: N=12, x_N=265720, A_out_offset=60. Returns pi_count.
; ══════════════════════════════════════════════════════════

shell_phase1_c θ²²² 12 265720 60

; Save pi_count and compute C = 2·pi_count
shl      θρ¹ρ  1                 ; pipeline = 2·pi_count = C
swrite64 θρ¹ρ 192                ; C stored at [192..200]

; Init gcd_total = 0
swrite64 θ¹¹ρ 0 224

; ══════════════════════════════════════════════════════════
; Phase 2: per-cell reduction (13 cells for N=12)
; ══════════════════════════════════════════════════════════

; ── Cell z=0 (D_0 = 4096) ──
sread64  θ¹ρρ  60
mul      θρ²ρ 531440
swrite64 θρ¹ρ 200
sread64  θ¹ρρ 192
mul      θρ²ρ  4096
swrite64 θρ¹ρ 208
gcd64    θ¹¹ρ 200 208
swrite64 θρ¹ρ 216
sread64  θ¹ρρ 200
sdiv64   θ¹ρρ 216
swrite64 θρ¹ρ 208
gcd64    θ¹¹ρ 224 208
swrite64 θρ¹ρ 224

; ── Cell z=1 (D_1 = 24576) ──
sread64  θ¹ρρ  68
mul      θρ²ρ 531440
swrite64 θρ¹ρ 200
sread64  θ¹ρρ 192
mul      θρ²ρ 24576
swrite64 θρ¹ρ 208
gcd64    θ¹¹ρ 200 208
swrite64 θρ¹ρ 216
sread64  θ¹ρρ 200
sdiv64   θ¹ρρ 216
swrite64 θρ¹ρ 208
gcd64    θ¹¹ρ 224 208
swrite64 θρ¹ρ 224

; ── Cell z=2 (D_2 = 67584) ──
sread64  θ¹ρρ  76
mul      θρ²ρ 531440
swrite64 θρ¹ρ 200
sread64  θ¹ρρ 192
mul      θρ²ρ 67584
swrite64 θρ¹ρ 208
gcd64    θ¹¹ρ 200 208
swrite64 θρ¹ρ 216
sread64  θ¹ρρ 200
sdiv64   θ¹ρρ 216
swrite64 θρ¹ρ 208
gcd64    θ¹¹ρ 224 208
swrite64 θρ¹ρ 224

; ── Cell z=3 (D_3 = 112640) ──
sread64  θ¹ρρ  84
mul      θρ²ρ 531440
swrite64 θρ¹ρ 200
sread64  θ¹ρρ 192
mul      θρ²ρ 112640
swrite64 θρ¹ρ 208
gcd64    θ¹¹ρ 200 208
swrite64 θρ¹ρ 216
sread64  θ¹ρρ 200
sdiv64   θ¹ρρ 216
swrite64 θρ¹ρ 208
gcd64    θ¹¹ρ 224 208
swrite64 θρ¹ρ 224

; ── Cell z=4 (D_4 = 126720) ──
sread64  θ¹ρρ  92
mul      θρ²ρ 531440
swrite64 θρ¹ρ 200
sread64  θ¹ρρ 192
mul      θρ²ρ 126720
swrite64 θρ¹ρ 208
gcd64    θ¹¹ρ 200 208
swrite64 θρ¹ρ 216
sread64  θ¹ρρ 200
sdiv64   θ¹ρρ 216
swrite64 θρ¹ρ 208
gcd64    θ¹¹ρ 224 208
swrite64 θρ¹ρ 224

; ── Cell z=5 (D_5 = 101376) ──
sread64  θ¹ρρ 100
mul      θρ²ρ 531440
swrite64 θρ¹ρ 200
sread64  θ¹ρρ 192
mul      θρ²ρ 101376
swrite64 θρ¹ρ 208
gcd64    θ¹¹ρ 200 208
swrite64 θρ¹ρ 216
sread64  θ¹ρρ 200
sdiv64   θ¹ρρ 216
swrite64 θρ¹ρ 208
gcd64    θ¹¹ρ 224 208
swrite64 θρ¹ρ 224

; ── Cell z=6 (D_6 = 59136) ──
sread64  θ¹ρρ 108
mul      θρ²ρ 531440
swrite64 θρ¹ρ 200
sread64  θ¹ρρ 192
mul      θρ²ρ 59136
swrite64 θρ¹ρ 208
gcd64    θ¹¹ρ 200 208
swrite64 θρ¹ρ 216
sread64  θ¹ρρ 200
sdiv64   θ¹ρρ 216
swrite64 θρ¹ρ 208
gcd64    θ¹¹ρ 224 208
swrite64 θρ¹ρ 224

; ── Cell z=7 (D_7 = 25344) ──
sread64  θ¹ρρ 116
mul      θρ²ρ 531440
swrite64 θρ¹ρ 200
sread64  θ¹ρρ 192
mul      θρ²ρ 25344
swrite64 θρ¹ρ 208
gcd64    θ¹¹ρ 200 208
swrite64 θρ¹ρ 216
sread64  θ¹ρρ 200
sdiv64   θ¹ρρ 216
swrite64 θρ¹ρ 208
gcd64    θ¹¹ρ 224 208
swrite64 θρ¹ρ 224

; ── Cell z=8 (D_8 = 7920) ──
sread64  θ¹ρρ 124
mul      θρ²ρ 531440
swrite64 θρ¹ρ 200
sread64  θ¹ρρ 192
mul      θρ²ρ  7920
swrite64 θρ¹ρ 208
gcd64    θ¹¹ρ 200 208
swrite64 θρ¹ρ 216
sread64  θ¹ρρ 200
sdiv64   θ¹ρρ 216
swrite64 θρ¹ρ 208
gcd64    θ¹¹ρ 224 208
swrite64 θρ¹ρ 224

; ── Cell z=9 (D_9 = 1760) ──
sread64  θ¹ρρ 132
mul      θρ²ρ 531440
swrite64 θρ¹ρ 200
sread64  θ¹ρρ 192
mul      θρ²ρ  1760
swrite64 θρ¹ρ 208
gcd64    θ¹¹ρ 200 208
swrite64 θρ¹ρ 216
sread64  θ¹ρρ 200
sdiv64   θ¹ρρ 216
swrite64 θρ¹ρ 208
gcd64    θ¹¹ρ 224 208
swrite64 θρ¹ρ 224

; ── Cell z=10 (D_10 = 264) ──
sread64  θ¹ρρ 140
mul      θρ²ρ 531440
swrite64 θρ¹ρ 200
sread64  θ¹ρρ 192
mul      θρ¹ρ  264
swrite64 θρ¹ρ 208
gcd64    θ¹¹ρ 200 208
swrite64 θρ¹ρ 216
sread64  θ¹ρρ 200
sdiv64   θ¹ρρ 216
swrite64 θρ¹ρ 208
gcd64    θ¹¹ρ 224 208
swrite64 θρ¹ρ 224

; ── Cell z=11 (D_11 = 24) ──
sread64  θ¹ρρ 148
mul      θρ²ρ 531440
swrite64 θρ¹ρ 200
sread64  θ¹ρρ 192
mul      θρ¹ρ   24
swrite64 θρ¹ρ 208
gcd64    θ¹¹ρ 200 208
swrite64 θρ¹ρ 216
sread64  θ¹ρρ 200
sdiv64   θ¹ρρ 216
swrite64 θρ¹ρ 208
gcd64    θ¹¹ρ 224 208
swrite64 θρ¹ρ 224

; ── Cell z=12 (D_12 = 1) ──
sread64  θ¹ρρ 156
mul      θρ²ρ 531440
swrite64 θρ¹ρ 200
sread64  θ¹ρρ 192
mul      θρ¹ρ    1
swrite64 θρ¹ρ 208
gcd64    θ¹¹ρ 200 208
swrite64 θρ¹ρ 216
sread64  θ¹ρρ 200
sdiv64   θ¹ρρ 216
swrite64 θρ¹ρ 208
gcd64    θ¹¹ρ 224 208
swrite64 θρ¹ρ 224

; ══════════════════════════════════════════════════════════
; Phase 3: return gcd_total (expected 91)
; ══════════════════════════════════════════════════════════

sread64  θ¹ρρ 224
