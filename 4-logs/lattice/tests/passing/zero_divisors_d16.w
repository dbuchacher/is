; zero_divisors_d16.w — enumerate zero-divisor pairs at d=16. Expected: 168.
;
; Counts pairs (A, B) where A·B = 0 with:
;   A = e_i + e_j           (i < j, both +1)
;   B = e_k + sign·e_l      (k < l, sign ∈ {+1, -1})
;   skip self-pair: i==k, j==l, sign==+1
;
; Scratch layout:
;   0:        count
;   8:        i
;   16:       j
;   24:       k
;   32:       l
;   40:       sign
;   48:       sign_count
;   56:       temp (B[l] offset)
;   64-191:   A vector (16 qwords)
;   192-319:  B vector (16 qwords)
;   320-447:  OUT vector (16 qwords)
;
; CD d16 temps at 2560+, d8 at 3072+. No collision with data at 0-447.

; ═══════════════════════════════════════════
; i = 1
swrite64 θ¹¹ρ  1  8

: i_loop

; ─── j = i + 1 ───
sread64  θ¹ρρ  8
inc      θρρρ
swrite64 θρ¹ρ  16

: j_loop

; ─── zero A (16 qwords at 64-184) ───
swrite64 θ¹¹ρ  0  64
swrite64 θ¹¹ρ  0  72
swrite64 θ¹¹ρ  0  80
swrite64 θ¹¹ρ  0  88
swrite64 θ¹¹ρ  0  96
swrite64 θ¹¹ρ  0  104
swrite64 θ¹¹ρ  0  112
swrite64 θ¹¹ρ  0  120
swrite64 θ¹¹ρ  0  128
swrite64 θ¹¹ρ  0  136
swrite64 θ¹¹ρ  0  144
swrite64 θ¹¹ρ  0  152
swrite64 θ¹¹ρ  0  160
swrite64 θ¹¹ρ  0  168
swrite64 θ¹¹ρ  0  176
swrite64 θ¹¹ρ  0  184

; ─── A[i] = 1: offset = 64 + i*8 ───
sread64  θ¹ρρ  8
mul      θρ¹ρ  8
add      θρ¹ρ  64
siadd64  θρ¹ρ  1

; ─── A[j] = 1: offset = 64 + j*8 ───
sread64  θ¹ρρ  16
mul      θρ¹ρ  8
add      θρ¹ρ  64
siadd64  θρ¹ρ  1

; ─── k = 1 ───
swrite64 θ¹¹ρ  1  24

: k_loop

; ─── l = k + 1 ───
sread64  θ¹ρρ  24
inc      θρρρ
swrite64 θρ¹ρ  32

: l_loop

; ─── sign_count = 2, sign = 1 ───
swrite64 θ¹¹ρ  2  48
swrite64 θ¹¹ρ  1  40

: sign_loop

; ═══ SELF-PAIR CHECK ═══
; skip if i==k AND j==l AND sign==1
sread64  θ¹ρρ  8
ssub64   θ¹ρρ  24
; pipeline = i - k. If nonzero → not self.
skip_nz  not_self
sread64  θ¹ρρ  16
ssub64   θ¹ρρ  32
; pipeline = j - l. If nonzero → not self.
skip_nz  not_self
sread64  θ¹ρρ  40
sub      θρ¹ρ  1
; pipeline = sign - 1. If zero → sign==1 → IS self → skip body.
skip_z   sign_continue
: not_self

; ═══ BUILD B ═══
; ─── zero B (16 qwords at 192-312) ───
; offsets 192-248: u8
swrite64 θ¹¹ρ  0  192
swrite64 θ¹¹ρ  0  200
swrite64 θ¹¹ρ  0  208
swrite64 θ¹¹ρ  0  216
swrite64 θ¹¹ρ  0  224
swrite64 θ¹¹ρ  0  232
swrite64 θ¹¹ρ  0  240
swrite64 θ¹¹ρ  0  248
; offsets 256-312: u32
swrite64 θ¹²ρ  0  256
swrite64 θ¹²ρ  0  264
swrite64 θ¹²ρ  0  272
swrite64 θ¹²ρ  0  280
swrite64 θ¹²ρ  0  288
swrite64 θ¹²ρ  0  296
swrite64 θ¹²ρ  0  304
swrite64 θ¹²ρ  0  312

; ─── B[k] = 1: offset = 192 + k*8 ───
sread64  θ¹ρρ  24
mul      θρ¹ρ  8
add      θρ¹ρ  192
siadd64  θρ¹ρ  1

; ─── B[l] = sign: offset = 192 + l*8 ───
sread64  θ¹ρρ  32
mul      θρ¹ρ  8
add      θρ¹ρ  192
; save B[l] offset
swrite64 θρ¹ρ  56
; branch on sign
sread64  θ¹ρρ  40
gt       θρ¹ρ  0
skip_z   bl_neg
; sign > 0: B[l] += 1
sread64  θ¹ρρ  56
siadd64  θρ¹ρ  1
skip_nz  bl_done
: bl_neg
; sign <= 0: B[l] += -1
sread64  θ¹ρρ  56
siadd64  θρ³ρ  -1
: bl_done

; ═══ MULTIPLY: cd_mul_d16(A=64, B=192, OUT=320) ═══
cd_mul_d16 θ²²²  64  192  320

; ═══ ZERO CHECK: if all 16 OUT components == 0, increment count ═══
sread64  θ²ρρ  320
skip_nz  not_zero
sread64  θ²ρρ  328
skip_nz  not_zero
sread64  θ²ρρ  336
skip_nz  not_zero
sread64  θ²ρρ  344
skip_nz  not_zero
sread64  θ²ρρ  352
skip_nz  not_zero
sread64  θ²ρρ  360
skip_nz  not_zero
sread64  θ²ρρ  368
skip_nz  not_zero
sread64  θ²ρρ  376
skip_nz  not_zero
sread64  θ²ρρ  384
skip_nz  not_zero
sread64  θ²ρρ  392
skip_nz  not_zero
sread64  θ²ρρ  400
skip_nz  not_zero
sread64  θ²ρρ  408
skip_nz  not_zero
sread64  θ²ρρ  416
skip_nz  not_zero
sread64  θ²ρρ  424
skip_nz  not_zero
sread64  θ²ρρ  432
skip_nz  not_zero
sread64  θ²ρρ  440
skip_nz  not_zero

; ─── ALL ZERO → count++ ───
sread64  θ¹ρρ  0
inc      θρρρ
swrite64 θρ¹ρ  0

: not_zero
: sign_continue

; ═══ SIGN LOOP: flip sign, decrement count, loop ═══
sread64  θ¹ρρ  40
neg      θρρρ
swrite64 θρ¹ρ  40
sread64  θ¹ρρ  48
sub      θρ¹ρ  1
swrite64 θρ¹ρ  48
loop_back sign_loop

; ═══ L LOOP: l++, if l < 16 loop ═══
sread64  θ¹ρρ  32
inc      θρρρ
swrite64 θρ¹ρ  32
sub      θρ¹ρ  16
loop_back l_loop

; ═══ K LOOP: k++, if k < 15 loop ═══
sread64  θ¹ρρ  24
inc      θρρρ
swrite64 θρ¹ρ  24
sub      θρ¹ρ  15
loop_back k_loop

; ═══ J LOOP: j++, if j < 16 loop ═══
sread64  θ¹ρρ  16
inc      θρρρ
swrite64 θρ¹ρ  16
sub      θρ¹ρ  16
loop_back j_loop

; ═══ I LOOP: i++, if i < 15 loop ═══
sread64  θ¹ρρ  8
inc      θρρρ
swrite64 θρ¹ρ  8
sub      θρ¹ρ  15
loop_back i_loop

; ═══ RETURN COUNT ═══
sread64  θ¹ρρ  0
