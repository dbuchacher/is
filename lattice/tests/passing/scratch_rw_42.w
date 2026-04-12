; scratch_rw_42.w — walk_scratch memory round-trip sanity test.
;
; Writes 42 to walk_scratch[0], then reads it back. Pipeline should
; end at 42. Proves:
;   - swrite32 can write a u8 literal value at a u8 literal offset
;   - sread32 can read from a u8 literal offset into the pipeline
;   - the scratch buffer persists values across bond calls within
;     a single walk invocation
;
; Wave byte encoding:
;   swrite32: 0x02 0xF1 = D=-15 → fn_scratch_write32
;   sread32:  0x02 0x0F = D=+15 → fn_scratch_read32
;
; fn_scratch_write32 takes (value=arg0, offset=arg1). With θ¹¹ρ:
;   arg0 = u8(42) = value
;   arg1 = u8(0)  = offset
; Writes 42 to scratch[0]. Returns 42 (pipeline = 42 after call).
;
; fn_scratch_read32 takes (offset=arg0). With θ¹ρρ:
;   arg0 = u8(0)  = offset
; Returns scratch[0] = 42. Pipeline = 42.

swrite32  θ¹¹ρ  42  0
sread32   θ¹ρρ  0
