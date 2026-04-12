; and_8.w — logic gate test. 12 AND 10 = 8 (0b1100 & 0b1010 = 0b1000).
;
; The and bond fires when coord (A, B, C, D) = (0, 0, 0, +3). Only
; time axis odd, magnitude 3 → dispatch hits the δ-gate sub-dispatcher
; which picks fn_and based on |D|=3 with positive sign. Arguments load
; as two u8s (12 and 10) via θ¹¹ρ.

and  θ¹¹ρ  12  10
