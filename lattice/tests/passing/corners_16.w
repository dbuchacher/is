; corners_16.w — the memory-unlock headline test.
;
; Loops 16 times, incrementing a counter in walk_scratch[0] each
; iteration and decrementing an iteration tracker in walk_scratch[4].
; When iter hits 0, loop_back exits and the walk returns the counter.
;
; Final counter value = number of iterations = 16 = |{−1,+1}⁴|
;                     = f-vector(4-cube)[k=0] = 4D hypercube vertices
;
; Framework meaning: 16 is the corner count of the 4D hypercube, i.e.
; the set of points where all four coordinates are in {−1, +1} (no
; zero). This test doesn't literally enumerate the 16 coord tuples —
; it counts 16 loop iterations, which is the same integer. When the
; full ternary enumeration test (shell1_80 = count {−1,0,+1}⁴ nonzero)
; lands, it'll use the same loop+scratch idiom with a filter inside.
;
; What this proves:
;   1. walk_scratch persists values across bond calls in one walk
;   2. loop_back control byte rewinds when pipeline != 0
;   3. Two independent values (counter + iter) can live in scratch
;      while the pipeline ferries temporaries between them
;   4. The `sread32 → modify → swrite32` idiom works via θρ¹ρ flags
;      (pipeline is the value, literal is the offset)
;
; State:
;   scratch[0] = counter (accumulates, final answer)
;   scratch[4] = iter (decrements, drives loop_back via pipeline)
;   pipeline   = temporary (ferries read → modify → write)

; ── init ─────────────────────────────────────────────
swrite32  θ¹¹ρ  0   0       ; scratch[0] = 0 (counter = 0)
swrite32  θ¹¹ρ  16  4       ; scratch[4] = 16 (iter = 16)

: loop

; ── increment counter: scratch[0]++ ─────────────────
sread32   θ¹ρρ  0           ; pipeline = counter
add       θρ¹ρ  1           ; pipeline = counter + 1
swrite32  θρ¹ρ  0           ; scratch[0] = pipeline (counter saved)

; ── decrement iter: scratch[4]--, leave in pipeline ─
sread32   θ¹ρρ  4           ; pipeline = iter
sub       θρ¹ρ  1           ; pipeline = iter - 1
swrite32  θρ¹ρ  4           ; scratch[4] = pipeline

; pipeline now holds iter-1. loop_back rewinds if nonzero.
loop_back loop

; ── return counter ──────────────────────────────────
sread32   θ¹ρρ  0           ; pipeline = scratch[0] = 16
