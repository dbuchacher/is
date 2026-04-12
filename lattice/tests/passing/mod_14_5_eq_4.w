; mod_14_5_eq_4.w — modulo bond sanity test.
;
; 14 mod 5 = 4 (since 14 = 2·5 + 4).
;
; Wave byte 0x02, extension 0x09 = coord (A=0, B=0, C=0, D=+9).
; All coords except D are zero, D is odd → bond path, pattern 8
; (test/gate family). |D|=9 → dispatch to fn_mod (positive D = mod,
; negative would be div).
;
; fn_mod uses unsigned 64-bit div instruction (rdx:rax / rsi) and
; returns the remainder (rdx moved to rax). Division by zero would
; trap — walks must guard divisors against zero before calling.

mod  θ¹¹ρ  14  5
