; add_16.w — smallest possible smoke test. Exercises the BOND path.
;
; The add bond fires when coord (A, B, C, D) = (-1, 0, 0, -1) — space
; and time axes both odd, matter and signal both zero. Dispatch goes
; through force-pattern 9 (bit 0 memory + bit 3 test) → filter sub-
; dispatch → fn_add. Arguments load as two u8s + pipeline from the
; θ¹¹ρ flags byte.
;
; Result: arg0 + arg1 = 16 + 0 = 16. Pipeline becomes 16, walk ends.

add  θ¹¹ρ  16  0
