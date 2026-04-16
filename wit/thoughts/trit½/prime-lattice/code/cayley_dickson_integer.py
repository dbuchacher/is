#!/usr/bin/env python3
"""
Cayley-Dickson integer-exact recomputation of zero-divisor counts
and chain rates.

Motivation: the old C version (chain.c in prior/ToE/wit/findings/c/)
uses double-precision arithmetic with `fabs < 1e-10` equality tests
and SAMPLED chain-rate calculation. This produces a floating-point
percentage (19%) that's both unit-dependent (float precision) and
statistical (sampling). Under the "no decimals" framework rule, the
result should be an exact integer ratio (chains, total), computed by
exhaustive enumeration, using integer Cayley-Dickson arithmetic.

Cayley-Dickson with integer entries: if a, b ∈ Z^d, then the product
(a,b)(c,d) = (ac − d*b, da + bc*) stays in Z. So we can test a·b = 0
by checking all components equal to integer zero. No floats.

Tests:
  1. Zero-divisor pair count at dim 16 (sedenion)
  2. Chain-triangle count at dim 16 and dim 32 (sedenion, T₃₂)
  3. Report as exact integer ratios
"""

from multiprocessing import Pool


def conj(a):
    """Conjugate: negate all non-real components."""
    return (a[0],) + tuple(-x for x in a[1:])


def cd_mul(x, y):
    """Cayley-Dickson multiplication, recursive.
    Works on tuples of integers. Returns a tuple.
    (a, b) · (c, d) = (a·c − conj(d)·b, d·a + b·conj(c))
    """
    d = len(x)
    if d == 1:
        return (x[0] * y[0],)
    h = d // 2
    a, b = x[:h], x[h:]
    c, dd = y[:h], y[h:]
    ac = cd_mul(a, c)
    dconj_b = cd_mul(conj(dd), b)
    first = tuple(ac[i] - dconj_b[i] for i in range(h))
    d_a = cd_mul(dd, a)
    b_cconj = cd_mul(b, conj(c))
    second = tuple(d_a[i] + b_cconj[i] for i in range(h))
    return first + second


def is_zero(a):
    return all(x == 0 for x in a)


def basis(d, i):
    """Unit basis vector e_i in dim d."""
    return tuple(1 if k == i else 0 for k in range(d))


def signed_basis_pair(d, i, j, sign_j):
    """e_i + sign_j * e_j, with both nonzero indices ≥ 1 (no real part)."""
    v = [0] * d
    v[i] = 1
    v[j] = sign_j
    return tuple(v)


def count_zero_divisor_pairs(d):
    """Count pairs (A, B) of 'canonical' zero divisors:
    A = e_i + e_j  (i<j, both ≥ 1)
    B = e_k + sign·e_l  (k<l, sign=±1, both ≥ 1)
    such that A · B = 0 and A ≠ B up to sign.

    Canonical form excludes the real axis (index 0) and uses
    standard-basis combinations, which is how the 84-zero-divisor
    count of sedenions is typically computed.

    Returns (count, total_pairs_tested).
    """
    count = 0
    total = 0
    pairs_A = []
    for i in range(1, d):
        for j in range(i + 1, d):
            pairs_A.append((i, j))

    for (i, j) in pairs_A:
        A = signed_basis_pair(d, i, j, +1)
        for (k, l) in pairs_A:
            for sign in (-1, +1):
                if (i, j) == (k, l) and sign == +1:
                    continue
                B = signed_basis_pair(d, k, l, sign)
                product = cd_mul(A, B)
                total += 1
                if is_zero(product):
                    count += 1

    return count, total


def count_chains(d, max_d_for_exhaust=16):
    """Count chain triangles: (A, B, C) such that
      A · B = 0  AND  B · C = 0  AND  A · C = 0
    using canonical zero-divisor form A = e_i + e_j, etc.

    Returns (chains, chain_candidates) where chain_candidates is the
    number of (A, B, C) triples where A·B = 0 and B·C = 0, and chains
    is the subset where A·C = 0 also.

    This is the EXACT integer ratio that "chain rate" measures.
    """
    if d > max_d_for_exhaust:
        return None, None  # too big for full exhaust

    # First, find all zero-divisor canonical pairs (A, B) where A·B = 0
    zd_pairs = []
    pairs = []
    for i in range(1, d):
        for j in range(i + 1, d):
            pairs.append((i, j))

    for (i1, j1) in pairs:
        A = signed_basis_pair(d, i1, j1, +1)
        for (i2, j2) in pairs:
            for sign2 in (-1, +1):
                if (i1, j1) == (i2, j2) and sign2 == +1:
                    continue
                B = signed_basis_pair(d, i2, j2, sign2)
                if is_zero(cd_mul(A, B)):
                    zd_pairs.append((A, B))

    # Now for each pair (A, B), find all C such that B·C = 0, and test A·C = 0
    # Build a lookup: for each "left side" B, list all C such that B·C = 0
    # Actually easier: for each (A, B) in zd_pairs, find all (B', C) where B' = B and B·C=0
    # Then count chains where A·C = 0 too.

    # Build dict: B_key -> list of C such that B·C = 0
    from collections import defaultdict
    right_of = defaultdict(list)
    for (A, B) in zd_pairs:
        right_of[B].append(A)  # if A·B = 0, then we have A "on the left" of B

    chains = 0
    chain_candidates = 0
    for (A, B) in zd_pairs:
        # We have A·B = 0. Now find all C such that B·C = 0.
        # Those are pairs (B, C) where B is "on the left" of C — but zd_pairs
        # stores (X, Y) with X·Y = 0. So we need to look up all (B, C) in zd_pairs.
        for (Bp, C) in zd_pairs:
            if Bp == B:
                # We have B·C = 0. Chain candidate.
                if C == A:
                    continue  # trivial
                chain_candidates += 1
                if is_zero(cd_mul(A, C)):
                    chains += 1

    return chains, chain_candidates


def gcd(a, b):
    while b:
        a, b = b, a % b
    return abs(a)


def test_dim(d):
    """Run all integer-exact tests at dimension d."""
    print(f"\n{'='*70}")
    print(f"  Dimension {d}  (Cayley-Dickson level log₂={d.bit_length()-1})")
    print(f"{'='*70}")

    # Zero-divisor count (canonical form)
    zd_count, zd_total = count_zero_divisor_pairs(d)
    if zd_total > 0:
        g = gcd(zd_count, zd_total)
        print(f"  Zero divisors (canonical pairs e_i+e_j vs e_k±e_l):")
        print(f"    count = {zd_count} / {zd_total}  total pairs tested")
        print(f"    reduced ratio = {zd_count // g} : {zd_total // g}")

    # Chain rate (exact integer counts)
    if d <= 16:
        chains, chain_cands = count_chains(d)
        if chain_cands is not None:
            if chain_cands > 0:
                g = gcd(chains, chain_cands)
                print(f"  Chain count (A·B=0, B·C=0, A·C=0):")
                print(f"    chains = {chains} / {chain_cands}  (A·B=0 and B·C=0)")
                print(f"    reduced ratio = {chains // g} : {chain_cands // g}")
            else:
                print(f"  No chain candidates at dim {d}")
    else:
        print(f"  (chain rate skipped for d={d}: too expensive for exhaust)")

    return d, zd_count, zd_total


def main():
    print("Cayley-Dickson INTEGER-EXACT recomputation")
    print("=========================================")
    print("Integer arithmetic. Exhaustive enumeration. No sampling.")
    print("No decimal percentages. All results as (count, total) pairs.")

    for d in [4, 8, 16]:
        test_dim(d)

    # dim 32 chain count: 32 is the heartbeat dimension claim
    # This is more expensive — (32 choose 2)² × 2 = 465,876 pairs to test
    # for zero divisor pair count, then chain counting is an additional
    # factor. Run it as a separate pool task.
    print(f"\n{'='*70}")
    print(f"  Attempting dim 32 (sedenion doubled — the heartbeat claim)")
    print(f"{'='*70}")
    d = 32
    zd_count, zd_total = count_zero_divisor_pairs(d)
    g = gcd(zd_count, zd_total)
    print(f"  Zero divisors at d=32:")
    print(f"    count = {zd_count} / {zd_total}")
    print(f"    reduced ratio = {zd_count // g} : {zd_total // g}")
    print(f"  (chain count skipped at d=32 — exhaustive enum cost prohibitive)")


if __name__ == "__main__":
    main()
