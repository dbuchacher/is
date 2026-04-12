; shell_reduce_N3.w — Tier C multi-cell reduction at N=3 with hardcoded cell data.
;
; Validates the Phase 2 + Phase 3 reduction pipeline of the shell-
; identity theorem at N=3. The A_z values (signed prime counts per
; cell) are hardcoded for this walk; Phase 1 (prime enumeration +
; balanced ternary classification) is deferred to Turn 9 where the
; full shell_identity.winc harness gets its own design window.
;
; N=3 constants:
;   x_3 = 13
;   B = 3^3 − 1 = 26
;   π(13) = 6 primes: 2, 3, 5, 7, 11, 13
;   C = 2·π(13) = 12
;
;   Cell classification (balanced ternary N=3 digits, zero count = z):
;     z=0 (no zeros): 5, 7, 11, 13 → 4 unsigned / 8 signed primes
;     z=1 (1 zero):   2            → 1 unsigned / 2 signed primes
;     z=2 (2 zeros):  3            → 1 unsigned / 2 signed primes
;     z=3 (3 zeros):  none         → 0 primes (origin has no primes)
;
;   A = [8, 2, 2, 0]                 (signed counts per cell)
;   D = [C(3,0)·8, C(3,1)·4, C(3,2)·2, C(3,3)·1] = [8, 12, 6, 1]
;
; Per-cell reduction: g_z = (A_z · B) / gcd(A_z · B, C · D_z)
;
;   z=0: num=208, den=96,  gcd=16, g_0 = 208/16 = 13
;   z=1: num=52,  den=144, gcd=4,  g_1 = 52/4  = 13
;   z=2: num=52,  den=72,  gcd=4,  g_2 = 52/4  = 13
;   z=3: num=0,   den=12,  gcd=12, g_3 = 0/12  = 0
;
; Cross-cell: gcd_total = gcd(g_0, g_1, g_2, g_3) = gcd(13, 13, 13, 0) = 13
;
; Expected: 13 (matches the N=3 known-answer from
; wit/thoughts/prime-lattice/findings/04-extended-N11-17.md)
;
; Scratch slot layout:
;   [100]  per-iter num  (u64 temp)
;   [108]  per-iter den  (u64 temp)
;   [116]  per-iter gcd_val (u64 temp)
;   [128]  g_0 (u64)
;   [136]  g_1
;   [144]  g_2
;   [152]  g_3
;   [160]  gcd_total (u64, running across cells)

; ══════════════════════════════════════════════════════════
; Phase 2: per-cell reduction
; ══════════════════════════════════════════════════════════

; ── Cell z=0: A=8, D=8 ──
mul      θ¹¹ρ  8  26                 ; pipeline = 208 (num_0 = A·B)
swrite64 θρ¹ρ 100
mul      θ¹¹ρ 12   8                 ; pipeline = 96  (den_0 = C·D)
swrite64 θρ¹ρ 108
gcd64    θ¹¹ρ 100 108                ; pipeline = gcd(208, 96) = 16
swrite64 θρ¹ρ 116                    ; gcd_val = 16
sread64  θ¹ρρ 100                    ; pipeline = num_0 = 208
sdiv64   θ¹ρρ 116                    ; pipeline = 208/16 = 13
swrite64 θρ¹ρ 128                    ; g_0 = 13

; ── Cell z=1: A=2, D=12 ──
mul      θ¹¹ρ  2  26                 ; num_1 = 52
swrite64 θρ¹ρ 100
mul      θ¹¹ρ 12  12                 ; den_1 = 144
swrite64 θρ¹ρ 108
gcd64    θ¹¹ρ 100 108                ; gcd(52, 144) = 4
swrite64 θρ¹ρ 116
sread64  θ¹ρρ 100
sdiv64   θ¹ρρ 116                    ; 52/4 = 13
swrite64 θρ¹ρ 136                    ; g_1 = 13

; ── Cell z=2: A=2, D=6 ──
mul      θ¹¹ρ  2  26                 ; num_2 = 52
swrite64 θρ¹ρ 100
mul      θ¹¹ρ 12   6                 ; den_2 = 72
swrite64 θρ¹ρ 108
gcd64    θ¹¹ρ 100 108                ; gcd(52, 72) = 4
swrite64 θρ¹ρ 116
sread64  θ¹ρρ 100
sdiv64   θ¹ρρ 116                    ; 52/4 = 13
swrite64 θρ¹ρ 144                    ; g_2 = 13

; ── Cell z=3: A=0, D=1 ──
add      θ¹¹ρ  0   0                 ; pipeline = 0 (num_3 = 0·B)
swrite64 θρ¹ρ 100
mul      θ¹¹ρ 12   1                 ; den_3 = 12
swrite64 θρ¹ρ 108
gcd64    θ¹¹ρ 100 108                ; gcd(0, 12) = 12
swrite64 θρ¹ρ 116
sread64  θ¹ρρ 100                    ; pipeline = 0
sdiv64   θ¹ρρ 116                    ; 0/12 = 0
swrite64 θρ¹ρ 152                    ; g_3 = 0

; ══════════════════════════════════════════════════════════
; Phase 3: cross-cell gcd accumulation
; gcd_total = gcd(gcd(gcd(g_0, g_1), g_2), g_3)
; ══════════════════════════════════════════════════════════

gcd64    θ¹¹ρ 128 136                ; pipeline = gcd(13, 13) = 13
swrite64 θρ¹ρ 160                    ; gcd_total = 13

gcd64    θ¹¹ρ 160 144                ; pipeline = gcd(13, 13) = 13
swrite64 θρ¹ρ 160

gcd64    θ¹¹ρ 160 152                ; pipeline = gcd(13, 0) = 13
; walk ends with pipeline = 13
