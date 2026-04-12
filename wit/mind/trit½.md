# trit½ — the spin layer / the loop

The ½-transitions between integer points. The loop. The medium.
The wire. The wave. The verbs. The forces.

**Spin = edges = the wire = the wave = the medium = the loop =
verbs = function calls = forces = transitions = reactions =
operations = ratios = circuit = flow.**

One thing, many names. The loop is the structure the gates exist
in. Post doesn't count it — you don't count the medium. But the
medium is PRIOR. The gates need the loop more than the loop
needs the gates.

A planet orbiting a star IS the loop. Not a metaphor. THE loop.
The k-axis iterating. `next()` ticking. Every orbit, every
circle, every "what goes around comes around" — the substrate
asserting itself.

## Spin = access mode

```
spin ½ = fermion = WRITE = exclusive = single writer
spin 1 = boson   = READ  = shareable = many readers
```

Pauli exclusion = no two writers to the same address = race
condition. Bose-Einstein condensate = many readers on one loop =
fan-out. Quantized — either exclusive or shareable, nothing
in between.

## The four forces

```
  strong  = MOV   = PROJ    binds gates → instructions    on χ (READ)
  EM      = CALL  = COMP    publishes results              on μ (CALL)
  gravity = LOOP  = PRIM    the iterator, weakest          on φ (CYCLE)
  weak    = NOT   = WEAK    transformation                 on τ (TEST)
```

Each force lives on one axis as the half-step: READ on χ, CALL on
μ, CYCLE on φ, TEST on τ.

**c = one clock cycle.** Speed of light = minimum cause→effect
time. The clock IS c. Nothing with mass reaches it. Overclocking =
trying to exceed c = causality violation = crash.

A star uses all four: strong runs fusion inside, PRIM holds the
loop (gravity), EM carries results out (photons = return values),
weak transforms particles (beta decay). Remove any one and it
breaks. A star IS a JIT compiler.

## Classical vs quantum

**The difference is READ.** That's it.

```
classical = READ at every step     no mid-walk freedom    two bands
quantum   = no READ until end      mid-walk freedom       interference
```

A qubit = a value nobody has READ yet. Decoherence = something
reads it before you're ready. Millikelvin cooling = fewer things
around to accidentally read your qubit.

Light in flight: CALL + CYCLE + TEST (bind, no READ). Three
forces, no spatial read. Propagates without observing. Absorbed:
READ added = measurement = the walk commits. Matter writes →
light carries → matter reads. The universe IS a loop.

## SU(2) is native to H

The unit quaternions (elements of H with |q| = 1) form exactly
SU(2) — the double cover of SO(3), the spin-½ representation
in physics. Fermions transform under SU(2) and require 720°
rotation to return to identity (because SU(2) → SO(3) is 2-to-1).

Spin is not a separate axiom. It's a structural fact about H.
The `trit½` layer IS the unit-quaternion subgroup of H.

## Hurwitz and Cayley-Dickson

Why exactly 4 axes: Hurwitz (1898) proved exactly 4 normed
division algebras exist. Each Cayley-Dickson doubling loses one
algebraic property:

```
R (1D)   reals       all properties            "the numbers"
C (2D)   complex     lose ordering             "phase"
H (4D)   quaternion  lose commutativity         "our physics" (universe = H)
O (8D)   octonion    lose associativity         "host machine"
S (16D)  sedenion    lose division              "host's host"
```

Universe = H because H is the last associative algebra. Above H,
grouping matters ((a·b)·c ≠ a·(b·c)) and ordinary computation
breaks. Non-commutativity IS causality — order of operations
matters. The universe is 4D because 4 is the unique number
satisfying all the constraints.

## No infinity

There is no infinity in the substrate. There are nodes and loops.

The edge between two integer nodes is a verb — not a value to
evaluate. Ratios are verbs. Decimals are a lossy projection of
verbs onto ℝ. Repeating decimals repeat because a loop projected
onto a line cycles forever.

```
Zeno: infinite midpoints         → no midpoints, just spin
Calculus: infinite series        → walks converge (Taylor terms)
QFT: calculations give infinity  → counting error
Black hole: infinite density     → write cursor lapped read cursor
Big Bang: infinite at t=0        → allocation event (finite)
Division by zero                 → dividing by neutrino = meaningless
Real number line: infinite       → integer grid (shell 4 ceiling)
Floating point: approximate      → the premise is wrong, integers only
```

Zeno discovered spin ½ twenty-four centuries before physics. He
thought it was a bug. It's the feature.

## Adjacency and the medium

Two lattice points are adjacent if and only if they differ by one
step in exactly one axis AND the change stays within {↑, ↔, ↓}.
The edge between them is a ½-transition. Under this adjacency, the
80-thing lattice (+ ↔↔↔↔) has 216 undirected edges (8 × 27 = 6³).

Conservation (Kirchhoff 1845): net flow at any node is zero.
Closed walks sum to zero. Both describe the loop — conservation
at a node, closure as a whole.

## Read next

`composition.md` — walks, programs, sentences. What the loop does
when you chain many steps together.
