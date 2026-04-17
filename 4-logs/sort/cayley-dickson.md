# Cayley-Dickson chain

A construction that **doubles** an algebra by pairing it with
itself: given algebra A, form ordered pairs (a, b) with a, b ∈ A
and define multiplication via conjugation. Each doubling produces
a new algebra of twice the dimension, losing one algebraic
property per step.

Named for Arthur Cayley (who constructed the octonions, 1845) and
Leonard Dickson (who generalized the doubling process, 1919).

## The five reachable algebras

```
  name             symbol   dim   built as      property lost
  ────             ──────   ───   ────────      ─────────────
  reals             R        1    —             —
  complex           C        2    C = R ⊕ R     total ordering
  quaternions       H        4    H = C ⊕ C     commutativity
  octonions         O        8    O = H ⊕ H     associativity
  sedenions         S       16    S = O ⊕ O     division (zero divisors)
```

## Hurwitz's theorem (1898)

There are **exactly four normed division algebras** over the reals:
R, C, H, O. Beyond O, the doubled algebra (S, 16D) is no longer a
division algebra — there exist nonzero a, b in S with ab = 0 ("zero
divisors").

## Frobenius (1877)

**No 3D normed division algebra exists.** Hamilton spent 10 years
trying to construct 3D quaternions before landing on 4D (H).

## Key figures

- **William Rowan Hamilton** (1843): discovered H (quaternions),
  carved the multiplication rules `ij = k, ji = −k` into Brougham
  Bridge, Dublin.
- **Arthur Cayley** (1845): constructed O (octonions) the same
  year John Graves did independently.
- **Ferdinand Frobenius** (1877): proved no 3D division algebra.
- **Adolf Hurwitz** (1898): proved the normed-division ceiling
  at 4 algebras.
- **Leonard Dickson** (1919): generalized the doubling to an
  iterated construction.
