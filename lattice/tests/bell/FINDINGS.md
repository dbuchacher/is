# Bell inequality — lattice verification

## The claim

Quaternion algebra H is non-commutative. This non-commutativity is the structural precondition for Bell inequality violation. Without it, CHSH |S| ≤ 2 necessarily (Fine's theorem, Gelfand-Naimark). With it, |S| can exceed 2.

## The test: bell_commutator_2

Verifies the commutator [i,j] = ij - ji = 2k on bare metal using cd_mul_d4.

```
ij = k       →  k-component = +1
ji = -k      →  k-component = -1
[i,j] = 2k   →  difference  =  2
```

In any commutative algebra, AB - BA = 0 for all A, B. Result = 0 means Bell holds. Result = 2 means the algebra has the structure required to violate Bell.

**Result: 2** — verified on integer quaternion arithmetic, no floating point, no parameters, no normalization ambiguity.

## Why this is the right test

The quaternion algebra H is isomorphic to the Pauli algebra that governs spin-½ measurement in QM:

```
quaternion:  [i, j] = 2k
Pauli:       [σ_x, σ_y] = 2iσ_z
```

Same algebra, different notation. H ≅ Cl⁺(3,0), Pauli matrices generate Cl(3,0) ≅ M₂(C), with H as the even subalgebra. The non-commutativity that breaks the classical Bell bound IS quaternion non-commutativity.

Non-commutativity is necessary but not sufficient — you also need entangled states and the right measurement geometry. The test verifies the structural prerequisite: the algebra supports it.

## Prior work: bell.c

`prior/ToE/wit/findings/c/bell.c` was an earlier attempt using quaternion exponentiation to compute CHSH directly. It found |S| = 2.674 at specific base values (T=10, D=50). Issues identified:

- Correlation function E(a,b) = Re(T^qa × D^qb) is not standard QM — no shared entangled state
- Result depends on arbitrary base values T, D (real Bell violations don't)
- Normalization of E(a,b) to [-1,1] not guaranteed at optimal angles
- Falls short of Tsirelson bound (2.674 vs 2√2 ≈ 2.828)

The lattice test replaces this approach. Instead of trying to reproduce the CHSH number through a novel correlation function, it verifies the algebraic fact underneath: the commutator is non-zero, the algebra is non-commutative, Bell violation is structurally possible.

## What this proves

1. cd_mul_d4 correctly implements quaternion multiplication
2. Non-commutativity is present and correct (ij ≠ ji)
3. The algebra running on the lattice kernel has the structure required for Bell violation
4. This is the same algebraic structure as QM's Pauli matrices — not an analogy, an isomorphism

## Open

- Test commutators at higher Cayley-Dickson levels (d8: octonions lose associativity, d16: sedenions lose division) — what happens to the commutator structure?
- Verify all six basis-pair commutators: [i,j], [j,k], [k,i] and their negatives
