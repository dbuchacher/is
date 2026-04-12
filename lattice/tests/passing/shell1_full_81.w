; shell1_full_81.w — full shell-1 point count.
;
; Computes 3⁴ = 81 from the integer 3 alone.
;
;   3 · 3             = 9     (atom path, mul — gates²)
;   pipeline · pipeline = 81   (atom path, mul with θρρρ — all args pipeline)
;
; Framework meaning: 81 = 3⁴ is the full shell-1 point count of the
; 4D ternary lattice — every combination of {−1, 0, +1} across 4
; axes (WHERE × WHAT × WHICH × WHEN = space × matter × signal × time).
;
;   81 = 1 origin + 8 atoms + 24 faces + 32 edges + 16 corners
;      = f-vector of the 4D hypercube
;      = Euler characteristic + 1 per shell
;
; Derivation is pure framework: only the integer 3 (gates = Post 1941
; complete set size) is used as input. The walker computes 3² = 9,
; then squares that to get 9² = 81, which equals 3⁴ by the associativity
; of integer multiplication. Zero hardcoded constants beyond the
; primitive 3.
;
; The `mul θρρρ` form reuses the pipeline as both arguments — flags
; byte 0x00 makes arg0 AND arg1 read from the pipeline, so the atom
; computes pipeline² without a second literal argument. Clean.

mul  θ¹¹ρ  3  3       ; pipeline = 9 = 3²
mul  θρρρ             ; pipeline = 9² = 81 = 3⁴
