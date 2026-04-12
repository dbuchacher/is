; scratch64_roundtrip_42.w — swrite64 → sread64 round trip sanity.
;
; Writes 42 as a qword to scratch[0], reads it back as a qword.
; Proves both sides of the 64-bit scratch family dispatch and load
; the full qword (not a truncated u32).
;
; For large-value testing, the Tier C walks that overflow u32 are
; the real proof — this test just verifies the bonds exist and
; dispatch correctly.

add       θ¹¹ρ  42  0       ; pipeline = 42
swrite64  θρ¹ρ  0            ; scratch[0] = 42 (qword)
sread64   θ¹ρρ  0            ; pipeline = scratch[0] = 42
