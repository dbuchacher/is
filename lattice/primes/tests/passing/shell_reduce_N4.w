; shell_reduce_N4.w — Tier C multi-cell reduction at N=4 with hardcoded cell data.
;
; N=4 is where the known-answer table first diverges from `x_N` —
; `odd_part(x_4) = 5 ≠ x_4 = 40`. The theorem holds at N=4, expected
; `gcd(g) = 5`.
;
; N=4 constants:
;   x_4 = 40
;   B = 3^4 − 1 = 80
;   π(40) = 12 primes: 2, 3, 5, 7, 11, 13, 17, 19, 23, 29, 31, 37
;   C = 2·π(40) = 24
;
;   Cell classification (4-digit balanced ternary, zero count = z):
;     z=0: no 4-digit primes with all-nonzero digits (verified)
;     z=1: 5, 7, 11, 13, 17, 19, 23, 29, 31, 37  → 10 unsigned / 20 signed
;     z=2: 2                                      → 1 / 2 signed
;     z=3: 3                                      → 1 / 2 signed
;     z=4: none (origin)                          → 0
;
;   A = [0, 20, 2, 2, 0]             (signed counts per cell)
;   D = [C(4,0)·16, C(4,1)·8, C(4,2)·4, C(4,3)·2, C(4,4)·1] = [16, 32, 24, 8, 1]
;
; Per-cell reduction:
;   z=0: num=0·80=0,    den=24·16=384, gcd=384, g_0 = 0
;   z=1: num=20·80=1600, den=24·32=768, gcd=64,  g_1 = 1600/64 = 25
;   z=2: num=2·80=160,  den=24·24=576, gcd=32,  g_2 = 160/32 = 5
;   z=3: num=2·80=160,  den=24·8=192,  gcd=32,  g_3 = 160/32 = 5
;   z=4: num=0·80=0,    den=24·1=24,   gcd=24,  g_4 = 0
;
; Cross-cell: gcd(0, 25, 5, 5, 0)
;   = gcd(gcd(gcd(gcd(0, 25), 5), 5), 0)
;   = gcd(gcd(gcd(25, 5), 5), 0)
;   = gcd(gcd(5, 5), 0)
;   = gcd(5, 0)
;   = 5
;
; Expected: 5 (matches N=4 known-answer from
; wit/thoughts/prime-lattice/findings/04-extended-N11-17.md)
;
; Scratch slot layout:
;   [100..108) per-iter num
;   [108..116) per-iter den
;   [116..124) per-iter gcd_val
;   [128..136) g_0
;   [136..144) g_1
;   [144..152) g_2
;   [152..160) g_3
;   [160..168) g_4
;   [168..176) gcd_total

; ══════════════════════════════════════════════════════════
; Phase 2: per-cell reduction
; ══════════════════════════════════════════════════════════

; ── Cell z=0: A=0, D=16 ──
add      θ¹¹ρ  0   0                 ; pipeline = 0 (num_0 = 0·80)
swrite64 θρ¹ρ 100
mul      θ¹¹ρ 24  16                 ; pipeline = 384 (den_0 = C·D)
swrite64 θρ¹ρ 108
gcd64    θ¹¹ρ 100 108                ; pipeline = gcd(0, 384) = 384
swrite64 θρ¹ρ 116
sread64  θ¹ρρ 100                    ; pipeline = 0
sdiv64   θ¹ρρ 116                    ; 0/384 = 0
swrite64 θρ¹ρ 128                    ; g_0 = 0

; ── Cell z=1: A=20, D=32 ──
mul      θ¹¹ρ 20  80                 ; num_1 = 1600
swrite64 θρ¹ρ 100
mul      θ¹¹ρ 24  32                 ; den_1 = 768
swrite64 θρ¹ρ 108
gcd64    θ¹¹ρ 100 108                ; gcd(1600, 768) = 64
swrite64 θρ¹ρ 116
sread64  θ¹ρρ 100
sdiv64   θ¹ρρ 116                    ; 1600/64 = 25
swrite64 θρ¹ρ 136                    ; g_1 = 25

; ── Cell z=2: A=2, D=24 ──
mul      θ¹¹ρ  2  80                 ; num_2 = 160
swrite64 θρ¹ρ 100
mul      θ¹¹ρ 24  24                 ; den_2 = 576
swrite64 θρ¹ρ 108
gcd64    θ¹¹ρ 100 108                ; gcd(160, 576) = 32
swrite64 θρ¹ρ 116
sread64  θ¹ρρ 100
sdiv64   θ¹ρρ 116                    ; 160/32 = 5
swrite64 θρ¹ρ 144                    ; g_2 = 5

; ── Cell z=3: A=2, D=8 ──
mul      θ¹¹ρ  2  80                 ; num_3 = 160
swrite64 θρ¹ρ 100
mul      θ¹¹ρ 24   8                 ; den_3 = 192
swrite64 θρ¹ρ 108
gcd64    θ¹¹ρ 100 108                ; gcd(160, 192) = 32
swrite64 θρ¹ρ 116
sread64  θ¹ρρ 100
sdiv64   θ¹ρρ 116                    ; 160/32 = 5
swrite64 θρ¹ρ 152                    ; g_3 = 5

; ── Cell z=4: A=0, D=1 ──
add      θ¹¹ρ  0   0                 ; pipeline = 0 (num_4)
swrite64 θρ¹ρ 100
mul      θ¹¹ρ 24   1                 ; den_4 = 24
swrite64 θρ¹ρ 108
gcd64    θ¹¹ρ 100 108                ; gcd(0, 24) = 24
swrite64 θρ¹ρ 116
sread64  θ¹ρρ 100                    ; pipeline = 0
sdiv64   θ¹ρρ 116                    ; 0/24 = 0
swrite64 θρ¹ρ 160                    ; g_4 = 0

; ══════════════════════════════════════════════════════════
; Phase 3: cross-cell gcd accumulation for 5 cells
; gcd_total = gcd(gcd(gcd(gcd(g_0, g_1), g_2), g_3), g_4)
; ══════════════════════════════════════════════════════════

gcd64    θ¹¹ρ 128 136                ; pipeline = gcd(0, 25) = 25
swrite64 θρ¹ρ 168

gcd64    θ¹¹ρ 168 144                ; pipeline = gcd(25, 5) = 5
swrite64 θρ¹ρ 168

gcd64    θ¹¹ρ 168 152                ; pipeline = gcd(5, 5) = 5
swrite64 θρ¹ρ 168

gcd64    θ¹¹ρ 168 160                ; pipeline = gcd(5, 0) = 5
; walk ends with pipeline = 5
