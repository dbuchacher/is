# edges — combinators (the invisible operators)

An edge is the transition between two points. You never see it
directly. You see two integer states and infer what happened
between them. The edge IS the combinator — the operator that
combined the before-state with a change to produce the after-state.

```
  point A ──── edge ──── point B
  (value)    (combinator)  (value)
  coord4     invisible      coord4
  observable  inferred      observable
```

In code: `classify_bond(coord4 a, coord4 b) → bitmask`.
Takes 2 values, produces 1 edge-type. That's what a combinator
does: combines 2 inputs into 1 result.

## Three tiers

```
  tier          what           code type     example
  ────          ────           ─────────     ───────
  values        points         coord4        [+1, 0, -1, +1]
  combinators   edges          bitmask       BOND_P | BOND_W = "filter"
  programs      walks          float4        continuous path through lattice
```

Points are values (data, states, nouns).
Edges are combinators (operators, the ·, invisible).
Walks are programs ("the path IS the function").

## Why edges are invisible

You never observe a force. You observe two states and infer the
force from the difference. You never observe spin (½). You
observe integer states and infer the transition between them.

Same in code: the bitmask isn't stored. It's computed ON DEMAND
from two coord4 values. The edge has no independent storage —
it exists only as the relationship between its endpoints.

Same in physics: a force has no independent existence. It's the
name for what happened between two states. Remove the states
and the force has nothing to act on.

Same in FP: a combinator like `map` doesn't exist as a value.
It exists as a type signature — a description of what happens
between input and output. `map :: (a -> b) -> [a] -> [b]` talks
entirely about VALUES (a, b, [a], [b]). The combinator itself
is invisible in the type.

## Arity = 2

An edge has 2 endpoints. A combinator combines 2 things.
This is structural: edges ARE binary operators because they
connect exactly 2 vertices. The arity of combination is 2
because graph edges have 2 endpoints. Not chosen — forced.

```c
classify_bond(coord4 a, coord4 b)    // 2 inputs → 1 classification
//                  ↑         ↑
//               before     after
//                  └────┬────┘
//                   1 edge connecting them
```

## Edge classification (binary, x86)

On binary hardware, edges are classified by a 4-bit bitmask:
"which axes changed?" 2⁴ = 16 undirected edge-types.

```
  bits   forces   name          what changed
  ────   ──────   ────          ────────────
  0000   (none)   identity      nothing
  0001   P        read          position only
  0010   C        call          substance only
  0011   PC       fold          position + substance
  0100   R        drain         signal only
  0101   PR       copy          position + signal
  0110   CR       fix           substance + signal
  0111   PCR      foldl         position + substance + signal
  1000   W        test          time only
  1001   PW       filter        position + time
  1010   CW       maybe         substance + time
  1011   PCW      map           position + substance + time
  1100   RW       take_while    signal + time
  1101   PRW      scan          position + signal + time
  1110   CRW      bind          substance + signal + time
  1111   PCRW     hylo          all four
```

The names are FP combinator names because the edges ARE
combinators. These names belong to the EDGE, not to the corner
— but the classification is done by observing corners (values).

## Edge classification (ternary, native)

On a trit processor, each axis carries direction natively:

```
  trit:  bond.t = b.t - a.t    // -1 (backward), 0 (unchanged), +1 (forward)
```

3⁴ - 1 = 80 directed edge-types. The 16 binary patterns are
the direction-stripped shadow of 80 trit patterns.

## Spin-layer representation

Edges live at the spin layer — half-integer coordinates between
integer states. A bond has all 4 axes at ±½ (shell 1) or
±3/2 (shell 2). See `bonds.md` for the full 32 spin coords.

```
  spin shell 1 (±½):    16 edges — wave between origin and shell 1
  spin shell 2 (±3/2):  16 edges — wave between shells 1 and 2
                         ──
                         32 edges (stable working set)
```

The sign pattern (±) of a spin coord corresponds to the 16
binary edge-types. Same 16 patterns at every shell. The shell
number doubles 16 → 32.

## Relationship to walks

Walks are sequences of edges — programs built from combinators.
The walk layer uses `float4` (continuous coordinates) because
walks pass through half-integer values on their way between
integer states. "The path IS the function."

```
  values:       [+1, 0, -1, +1] ──→ [+1, +1, -1, +1]
  combinator:              (substance changed: CALL)
  walk coord:         [+1, 0.3, -1, +1]  [+1, 0.7, -1, +1]  ...
                      continuous, passes through ½
```

The walk IS the function. Edges are the alphabet.
Points are the data. See `points.md` and `corners.md`.

## The key insight

```
  you see:     [+1, 0, -1, +1]    and    [+1, +1, -1, +1]
  you infer:   "substance changed" → CALL combinator → edge type 2
  you DON'T see: the ½ transition between them
```

The combinator is always invisible. You reconstruct it from its
before-and-after. Physics, computing, and language all work this
way: observe states, infer operators.
