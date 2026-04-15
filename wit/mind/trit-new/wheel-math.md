# Wheel math — D4 root system verification

Working out the claim that the outer multi-chain wheel corresponds to
the D4 Lie algebra root system.

## D4 root system enumeration (standard form)

D4 roots in 4D root-space: **±e_i ± e_j for i < j**.

Pick i, j from {1, 2, 3, 4} with i < j. Each pair gives 4 sign
combinations (++, +−, −+, −−).

Pairs (i, j): (1,2), (1,3), (1,4), (2,3), (2,4), (3,4) → 6 pairs.

Roots per pair: 4 sign combinations.

**Total: 6 × 4 = 24 roots.**

Enumerating explicitly:

```
  (1,2) pair: ±e₁ ± e₂    →  (+,+,0,0), (+,−,0,0), (−,+,0,0), (−,−,0,0)
  (1,3) pair: ±e₁ ± e₃    →  (+,0,+,0), (+,0,−,0), (−,0,+,0), (−,0,−,0)
  (1,4) pair: ±e₁ ± e₄    →  (+,0,0,+), (+,0,0,−), (−,0,0,+), (−,0,0,−)
  (2,3) pair: ±e₂ ± e₃    →  (0,+,+,0), (0,+,−,0), (0,−,+,0), (0,−,−,0)
  (2,4) pair: ±e₂ ± e₄    →  (0,+,0,+), (0,+,0,−), (0,−,0,+), (0,−,0,−)
  (3,4) pair: ±e₃ ± e₄    →  (0,0,+,+), (0,0,+,−), (0,0,−,+), (0,0,−,−)
```

24 roots. Each has two non-zero components, each ±1. Norm of each:
√(1² + 1²) = √2. So they live on a sphere of radius √2, not unit
sphere directly — but their structure is still the "24 discrete
positions."

## Converting to 24-cell vertex coordinates

The 24-cell's vertices (in unit-sphere coordinates) are:
- **8 axis-aligned**: permutations of (±1, 0, 0, 0)
- **16 diagonal**: (±½, ±½, ±½, ±½)

Total: 24.

**The D4 roots and 24-cell vertices describe the same geometric
object** up to coordinate rotation/scaling. This is a standard
result in Coxeter group theory.

Specifically: applying an appropriate rotation + scaling takes the
24 roots (each ±e_i ± e_j at √2 distance) to the 24-cell vertices
(at unit distance).

## Opposing pairs

Each root α has an antipodal partner −α in the D4 system. So:
- 24 roots = 12 opposing pairs
- Each pair = one "axis" of D4

**This matches our framework's opposing-spoke-pairs-share-a-trit
insight**. 12 pairs means 12 distinct axis-directions in D4's 4D
root space, which is more than the 4 Hurwitz axes of H.

Interpretation:
- 4 of the 12 pairs correspond to H's native axes (χ, μ, φ, τ):
  the 8 axis-aligned vertices → 4 pairs along e₁, e₂, e₃, e₄
- 8 of the 12 pairs correspond to diagonal directions (the 16
  half-spin vertices paired antipodally)

So: **4 native axes + 8 diagonal directions = 12 total chain-pairs**.

## Weyl group

The Weyl group of D4 is the group of symmetries permuting the 24
roots while preserving inner products (and thus the root system's
structure).

**|W(D4)| = 192.**

Structure:
- 4! = 24 permutations of the 4 coordinate axes
- 2³ = 8 sign changes (sign of each coordinate, with constraint that
  even number of signs change for D_n Weyl group — but D4's full
  symmetry group includes the triality extension)
- 24 × 8 = 192

192 = 24 · 8. Both factors matter: 24 axis-permutations, 8 sign-
flips.

### Triality (D4-specific)

D4 has a unique 3-fold outer automorphism (triality) permuting the
three 8-dimensional representations of so(8): vector, left-handed
spinor, right-handed spinor. All three are 8D and get cycled by
triality.

Framework parallel: the 3 trits (↑/↕/↓) ≈ the 3 representations
cycled by triality? Speculative but suggestive.

## Cartan matrix (the algebra's "shape")

D4's Cartan matrix (standard Dynkin diagram form):

```
         2  -1   0   0
        -1   2  -1  -1
         0  -1   2   0
         0  -1   0   2
```

Interpreted: the algebra has 4 simple roots (indexed 1-4). Root 2 is
connected to roots 1, 3, and 4 (all three others). Roots 1, 3, 4 are
not connected to each other.

Dynkin diagram:
```
            α₁
            │
     α₃ ── α₂ ── α₄
```

Three "outer" roots (α₁, α₃, α₄) all connect to one "central" root
(α₂). This Y-shape is distinctive of D4.

**Framework parallel**: one central node with 3 branches. Matches:
- 1 scalar axis (τ) + 3 imaginary axes (χ, μ, φ)?
- 1 IS-tense + 3 other positions?
- The hub (0) + 3 symmetric outgoing directions?

D4's Y-shape encodes this asymmetry.

## What the math does NOT yet establish

- **Whether each D4-root "spoke" actually supports a full
  Cayley-Dickson chain outward**. The D4 root system gives
  directions; Cayley-Dickson construction applies to algebras, not
  root directions. Need to clarify the mapping.
- **Whether the 12 axis-pairs are all equivalent** or if 4 are
  "native" (the Hurwitz 4) and 8 are "derived/diagonal." The Weyl
  group says they're all equivalent under symmetry.
- **The precise relationship between H's unit sphere and D4's
  root system**. The 24-cell appears in both, but H is a 4D
  algebra while D4 is a Lie algebra acting on 8D — they're at
  different levels.

## Next-step math

1. Verify: is there a canonical map from D4 roots to Cayley-Dickson
   chains starting at each root direction?
2. Explore E8 as the "outer-outer" wheel if D4 is too small. E8
   contains D4 as a subalgebra; maybe our local H is D4-level
   within a bigger E8 structure.
3. Check: does the 12-pair structure of D4 match any physical
   observations? (e.g., 12 fermion generations-and-colors in the
   Standard Model? 3 generations × 4 lepton+quark pairs = 12? Some
   might converge.)
4. Triality's role: if the 3 trit values ≈ the 3 D4 representations
   cycled by triality, that's a new structural identity to verify.

## Summary

- **Inner wheel math is clean**: Hamilton 1843 gives θ/2 formula;
  SU(2) = H's unit sphere = 24-cell = D4 root system; 720° fermion
  period experimentally confirmed.
- **Outer wheel math starts here**: D4 root system is the natural
  candidate for the multi-chain wheel structure. 24 roots = 12
  opposing pairs = 12 chain-directions. Weyl group of order 192
  gives the symmetry structure.
- **Triality** is a D4-specific feature worth exploring — might
  explain the trit structure naturally.
- **E8** is the alternative for larger outer-outer wheels. E8 has
  240 roots and is used in physics for grand unification.
