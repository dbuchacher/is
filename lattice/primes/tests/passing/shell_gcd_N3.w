; shell_gcd_N3.w — full Tier C pipeline at N=3. Expected: 13.
;
; Subsumes shell_reduce_N3.w (which used hardcoded A_z values) by
; computing the A_z counters dynamically from prime enumeration.
;
; Phase 1: outer walk pre-fills constants, @includes shell_phase1.winc
;          which enumerates primes in [2, x_N], decodes each to
;          N-digit balanced ternary, counts zeros → cell index z,
;          increments A[z] by 2 (signed counterpart).
;
; Phase 2: per-cell reduction (inline here, since it's per-N and
;          differs in B / C / D / cell count across tests).
;          For each z in [0, N]:
;            num = A_z · B
;            den = C · D_z
;            gcd_val = gcd(num, den)
;            g_z = num / gcd_val
;            gcd_total = gcd(gcd_total, g_z)
;
; Phase 3: return gcd_total.
;
; N=3 hardcoded constants:
;   N = 3, x_N = 13, B = 26, D = [8, 12, 6, 1]
;   C is computed as 2·π(x_N) by phase 1.
;
; Expected A_z from enumeration:  [8, 2, 2, 0]  (signed)
; Expected per-cell g_z:            [13, 13, 13, 0]
; Expected gcd_total:                13
;
; Scratch layout (compatible with is_prime, shell_phase1, and this walk):
;   [40..52)   is_prime state
;   [60..92)   A_z counters (u64) — 4 slots for N=3 at offsets 60,68,76,84
;   [164..168) N (u32) — caller fills
;   [168..172) x_N (u32) — caller fills
;   [172..176) pi_count (u32) — phase 1 output
;   [176..200) phase 1 decoder state (u32 × 6)
;   [192..200) phase 2 C storage (u64)
;   [200..208) phase 2 num temp (u64)
;   [208..216) phase 2 den / g temp (u64)
;   [216..224) phase 2 gcd_val temp (u64)
;   [224..232) gcd_total (u64)
;
; Note: [192..200) is reused between phase 1 (decoder adjust) and
; phase 2 (C storage). Phase 1 is done before phase 2 writes C, so
; no conflict.

; ══════════════════════════════════════════════════════════
; Init: zero A_z counters and set phase 1 constants
; ══════════════════════════════════════════════════════════

swrite64 θ¹¹ρ 0 60               ; A_0 = 0
swrite64 θ¹¹ρ 0 68               ; A_1 = 0
swrite64 θ¹¹ρ 0 76               ; A_2 = 0
swrite64 θ¹¹ρ 0 84               ; A_3 = 0

swrite32 θ¹¹ρ  3 164             ; N = 3
swrite32 θ¹¹ρ 13 168             ; x_N = 13

; ══════════════════════════════════════════════════════════
; Phase 1: prime enumeration + cell classification
; ══════════════════════════════════════════════════════════

@include ../../inc/shell_phase1.winc

; After phase 1:
;   scratch[60..92] = A_z counters (expected [8, 2, 2, 0])
;   scratch[172]    = pi_count (expected 6 for N=3)

; ══════════════════════════════════════════════════════════
; Phase 2: per-cell reduction (inline, 4 cells for N=3)
; ══════════════════════════════════════════════════════════

; Compute C = 2 · pi_count, store as u64
sread32  θ¹ρρ 172                ; pipeline = pi_count = 6
shl      θρ¹ρ  1                 ; pipeline = 12 = C
swrite64 θρ¹ρ 192                ; store C at scratch[192] (u64)

; Init gcd_total = 0
swrite64 θ¹¹ρ 0 224

; ── Cell z=0 (D_0 = 8) ──
sread64  θ¹ρρ 60                 ; pipeline = A_0
mul      θρ¹ρ 26                 ; pipeline = A_0 · 26 = num_0
swrite64 θρ¹ρ 200                ; scratch[200] = num_0

sread64  θ¹ρρ 192                ; pipeline = C
mul      θρ¹ρ  8                 ; pipeline = C · 8 = den_0
swrite64 θρ¹ρ 208                ; scratch[208] = den_0

gcd64    θ¹¹ρ 200 208            ; pipeline = gcd(num_0, den_0)
swrite64 θρ¹ρ 216                ; scratch[216] = gcd_val

sread64  θ¹ρρ 200                ; pipeline = num_0
sdiv64   θ¹ρρ 216                ; pipeline = num_0 / gcd_val = g_0
swrite64 θρ¹ρ 208                ; reuse [208] for g_0 (den slot is dead)

gcd64    θ¹¹ρ 224 208            ; pipeline = gcd(gcd_total, g_0)
swrite64 θρ¹ρ 224                ; gcd_total = new value

; ── Cell z=1 (D_1 = 12) ──
sread64  θ¹ρρ 68                 ; pipeline = A_1
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
sread64  θ¹ρρ 76                 ; pipeline = A_2
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
sread64  θ¹ρρ 84                 ; pipeline = A_3 (= 0)
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

; ══════════════════════════════════════════════════════════
; Phase 3: return gcd_total
; ══════════════════════════════════════════════════════════

sread64  θ¹ρρ 224                ; pipeline = gcd_total = expected 13
