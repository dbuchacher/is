# composition — many functions applied (the program)

The third tier. A composition is a sequence of functions
accumulated into a continuous path through the lattice.

```
  programming:  program, pipeline, composed functions (f ∘ g ∘ h)
  FP:           reduction sequence, chain, do-block, >>= pipeline
  physics:      trajectory, worldline, path integral
  QM:           time evolution, unitary operator chain
  language:     sentence (subject → verb → object → verb → ...)
  code:         float4[] walk array — "the path IS the function"
```

## The three tiers

```
  tier          what             symbol    code      observable?
  ────          ────             ──────    ────      ───────────
  point         value            —         coord4    YES
  function      one operation    ·         ½ coord   NO (invisible)
  composition   many operations  +         float4    YES ("the path IS the function")
```

Points are observable (you see values). Functions are invisible
(you infer them from two points). Compositions are observable
again — the whole path IS visible as a trajectory. You can't
see one spin, but you can see the accumulated walk.

## In code

```c
// points — integer, storage
coord4 walk_i[MAX_WALK];

// composition — continuous, live computation
float4 walk_f[MAX_WALK];

// each step: apply one function, accumulate into composition
walk_f[pos] = coord4_to_float4(new_coord);

// the composition passes through ½ values between integer states
// those continuous intermediate values ARE the function layer
// the whole path IS the program
```

The `float4` walk IS the composition. It's continuous because
it passes through the function layer (½ values) on its way
between points (integer values). Each step applies one function
(one · operator). The accumulated path is the composition
(the + operator).

## Two clocks (from 2-path.md)

```
  ·    compose time    one function applied     happens WITHIN a step
  +    walk time       functions accumulated    happens BETWEEN steps
```

Same underlying operation (trit addition) at two different
moments. The · builds one function from atoms. The + strings
functions into a composition.

## Composition = the program

A composition IS a program. Not metaphor:

```
  map f . filter p . fold g     ← FP: composed functions = a program
  [½,½,½,½] + [½,-½,½,½] + ... ← framework: spin states accumulated = a walk
  subject → verb → object → ... ← language: words composed = a sentence
```

The composition IS what runs. The path IS the function.
The sentence IS the thought. Same tier, many vocabularies.

## Relationship to the hypercube

The hypercube (k0-k4) is the static structure.
Functions (½ coords) are the dynamics on the structure.
Compositions (float4 paths) are TRAJECTORIES through the
dynamics — specific paths the wave actually takes.

```
  hypercube = the board         static       all possible states
  function  = the rules         dynamic      what CAN happen between states
  composition = the game        trajectory   what ACTUALLY happened
```

## Stone-Weierstrass (from 2-path.md)

A composition is a polynomial. Each function application adds
one term. Stone-Weierstrass (1885): polynomials approximate
any continuous function. The composition IS the function.
More terms = more precision.

The walk accumulates ρ (the polynomial state). After N terms,
ρ = the polynomial evaluated at the current point. Not the
polynomial itself — its current value. The state IS the
compressed history.

## Open questions

- What is the natural LENGTH of a composition? When does it
  terminate? (Normal form = no more reductions possible?)
- Is there a maximum composition length before decay?
  (Related to the 19% heartbeat beyond shell 4?)
- How does composition relate to k=2 faces (24 squares)?
  A face might be a composition GUARANTEE — the claim that
  two different compositions give the same result.
