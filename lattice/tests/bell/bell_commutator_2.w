; bell_commutator_2.w — quaternion commutator [i,j] = ij - ji = 2k
;
; The algebraic witness for Bell inequality violation.
; In any commutative algebra: [A,B] = AB - BA = 0
; In H (quaternions):         [i,j] = ij - ji = k - (-k) = 2k
;
; Result: k-component of (ij - ji) = 1 - (-1) = 2
; If result were 0: algebra is commutative, Bell bound holds
; If result is 2: non-commutative, Bell violation possible
;
; bell.c (prior/ToE/) computes CHSH |S| = 2.674 > 2.0 using
; quaternion exponents. This test verifies the algebraic fact
; underneath: the commutator of basis quaternions is non-zero.
; No commutator → no Bell violation. The 2 here is structural.

; i = (0, 1, 0, 0) at scratch[0..31]
swrite64 θ¹¹ρ  0   0
swrite64 θ¹¹ρ  1   8
swrite64 θ¹¹ρ  0  16
swrite64 θ¹¹ρ  0  24

; j = (0, 0, 1, 0) at scratch[32..63]
swrite64 θ¹¹ρ  0  32
swrite64 θ¹¹ρ  0  40
swrite64 θ¹¹ρ  1  48
swrite64 θ¹¹ρ  0  56

; ij → scratch[64..95]
cd_mul_d4 θ¹¹¹  0  32  64

; ji → scratch[96..127]
cd_mul_d4 θ¹¹¹  32  0  96

; store ji.k (scratch[120]) for subtraction
sread64  θ¹ρρ  120
swrite64 θρ¹ρ  128

; load ij.k (scratch[88]) into pipeline
sread64  θ¹ρρ  88

; pipeline = ij.k - ji.k = 1 - (-1) = 2
ssub64   θ¹ρρ  128
