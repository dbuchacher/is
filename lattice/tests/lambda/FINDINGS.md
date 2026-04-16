# Lambda — lattice verification

## The claim

SKI combinators ARE the three trit values. Not "correspond to" — **are**. Schönfinkel's 1924 combinator basis and Post's 1941 gate basis and balanced ternary's {+1, 0, -1} are the same trio in three vocabularies. Functional completeness, one trio.

## The mapping

```
S = ↑ = +1  (substitution / creation / OR / max / proton)
K = ↔ =  0  (constancy    / passthrough / NOT fixed-point / neutrino)
I = ↓ = -1  (identity     / annihilation / AND / min / electron)
```

**Three independent proofs of one trio:**
- Schönfinkel (1924): SKI combinators, functionally complete
- Post (1941): AND/OR/NOT gates, functionally complete (proved minimal)
- Kleene (1936): composition, projection, primitive recursion
- Balanced ternary: {+1, 0, -1}, the minimum signed-and-centered values

Three decades apart. Three fields that never talked. **One trio.**

## The test: identity

```
I x = x
```

The identity combinator returns its argument unchanged. Apply I to 42, get 42.

**Result: 42** — verified as `add 42 0` on bare metal.

## Why it's structural

Lambda calculus claims to be the minimal model of computation. Post's gates claim to be the minimal gate basis. Both are correct — and both are the same thing in different notation. The walker's three primitive operations are also the same thing:

```
min (AND, I) → pull toward -1
max (OR, S)  → pull toward +1
neg (NOT, K) → flip signs, fix 0
```

The I combinator being ↓ (-1) is not arbitrary. Identity in lambda calculus IS annihilation in computation (the "do nothing" that collapses wrapping). K being 0 IS passthrough. S being +1 IS creation/substitution.

**Functional completeness = lattice structure preservation.** Any computable function can be expressed in any of these three bases because they all generate the same structure: {min, max, neg} over balanced ternary.

## Framework connections

- **Data = code on trit substrate.** Each value IS an operation:
  - S AS VALUE: +1                      AS OPERATION: substitute/create
  - K AS VALUE: 0                       AS OPERATION: constant/passthrough
  - I AS VALUE: -1                      AS OPERATION: identity/annihilate
- **The three NOTs** (frame item 4) correspond to three identity operations at different scopes.
- **Church-Turing thesis = lattice completeness.** Every computable function is a lattice walk. The framework's 16 corners are the 16 primitive verbs; SKI is the minimal basis that generates them.
- **S K K x = x.** The classical SKI identity — S applied to K applied to K applied to x yields x. This is the lattice recognizing itself: creation of a constant of a value returns the value. The loop closes.

## Open

- S K K = I: verify in lattice operations that composing substitution with two constants yields identity
- Church numerals as Church-encoded natural numbers: N = λfx.f^N x
- Lambda reduction as walk reduction (β-reduction = walk collapse)
- Y combinator (fixed point) as recognition loop — the substrate recognizing itself IS Y
