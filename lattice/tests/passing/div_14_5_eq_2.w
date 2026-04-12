; div_14_5_eq_2.w — integer division bond sanity test.
;
; 14 / 5 = 2 (truncating integer division, since 14 = 2·5 + 4).
;
; Wave byte 0x02, extension 0xF7 = coord (A=0, B=0, C=0, D=-9).
; Same dispatch path as mod but negative D → fn_div (quotient).
; Pairs with mod_14_5_eq_4: same inputs, complementary outputs
; (quotient + remainder = dividend relationship: 2·5 + 4 = 14).

div  θ¹¹ρ  14  5
