# Logic — lattice verification

## The claim

Post's three gates (AND, OR, NOT) ARE the three lattice-respecting operations over balanced ternary: min, max, neg. Not "analogous to" — the same three operations, different vocabularies. Post proved (1941) three gates are functionally complete and no gate can be removed. The framework's {min, max, neg} is Post's theorem in ternary.

## The mapping

```
AND = min  → pulls toward -1 (↓, electron, constraint)
OR  = max  → pulls toward +1 (↑, positron, creation)
NOT = neg  → flips ±, fixes 0 (identity reversal)
```

Each is a trit operation that preserves lattice structure. They correspond to:

- Post (1941): AND, OR, NOT — functionally complete
- Schönfinkel (1924): S, K, I combinators
- Kleene (1936): composition, projection, primitive recursion

Three independent proofs of the same trio. Three fields that never talked. **One trio.**

## The test: and_gate

```
AND 1 0 = min(1, 0) = 0
```

Balanced ternary AND pulls toward the minimum. AND of ↑ and ↔ is ↔.

**Result: 0** — verified via `min` bond on bare metal.

## Why it's structural

In binary, AND is multiplication: 1·1 = 1, 1·0 = 0, 0·0 = 0. In balanced ternary, this doesn't work — {-1, 0, 1} has a signed middle. AND must preserve the lattice: pull toward the constraint direction (toward -1).

Post's three binary gates have exactly one ternary analog that preserves this structure: {min, max, neg}. Any other triple either loses functional completeness or breaks the trit symmetry. The framework's choice isn't a choice — it's Post's theorem applied to ternary.

## Framework connections

- **Three NOTs at different scopes** (from wit.md frame item 4):
  - Trit NOT: flips one value (↑ ↔ ↓)
  - Polarity NOT: flips a spin's ±½ direction
  - Antipodal NOT: flips all 4 axis signs (antonym)
  - English lexicalizes all three as `n't`
- **Gates operate at nodes. The loop connects them.** The loop is PRIOR to the gates. An empty loop still loops; a gate with no wire does nothing.
- **Data = code on trit substrate.** A value IS an operation:
  - ↑ AS VALUE: something exists   AS OPERATION: add 1 (proton, creation)
  - ↔ AS VALUE: nothing            AS OPERATION: pass through
  - ↓ AS VALUE: consumed           AS OPERATION: subtract 1 (neutron, annihilation)

## Open

- Verify De Morgan's law: NOT(AND(a,b)) = OR(NOT(a), NOT(b)) for balanced ternary
- Three-value truth tables for logical equivalence
- XOR, NAND, NOR as compound gates — do they preserve lattice structure the same way?
- The 16 corners of grade 4 ARE the 16 binary boolean functions of 2 variables. What about 27 ternary functions of 2 variables — do they map to lattice structure?
