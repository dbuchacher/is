#!/usr/bin/env python3
"""
mertens_shells.py — M(x_N) and M_odd(x_N) at shell boundaries

Computes the Mertens function M(x) = Σ μ(n) for n=1..x at each
shell boundary x_N = (3^N − 1)/2, extending the existing table
from N=3..17 to as high as memory allows.

Also computes M_odd(x) = Σ μ(n) for ODD n only, and verifies the
parity identity M(x) = M_odd(x) − M_odd(x/2).

Integer only. No floats. Parallel where applicable.

Output: table of (N, x_N, M(x_N), M_odd(x_N), M²<x_N?, ratio M²/x_N)
"""

import sys
from math import isqrt
from multiprocessing import Pool, cpu_count

def mobius_sieve(limit):
    """Sieve μ(n) for n = 0..limit. Returns list where mu[n] = μ(n).
    Integer-only Eratosthenes-style sieve."""
    mu = [0] * (limit + 1)
    mu[1] = 1
    # smallest prime factor
    spf = list(range(limit + 1))
    for p in range(2, isqrt(limit) + 1):
        if spf[p] == p:  # p is prime
            for j in range(p * p, limit + 1, p):
                if spf[j] == j:
                    spf[j] = p
    # compute μ from factorization via spf
    for n in range(2, limit + 1):
        if spf[n] == n:
            # n is prime
            mu[n] = -1
        else:
            p = spf[n]
            m = n // p
            if m % p == 0:
                # p² | n → μ(n) = 0
                mu[n] = 0
            else:
                mu[n] = -mu[m]
    return mu

def compute_mertens_at_shell(N, max_limit=500_000_000):
    """Compute M(x_N) and M_odd(x_N) for a given N.
    Returns (N, x_N, M, M_odd, M_squared_less_than_x) or None if too large."""
    x_N = (3**N - 1) // 2
    if x_N > max_limit:
        return (N, x_N, None, None, None)

    mu = mobius_sieve(x_N)

    # M(x_N) = sum of all μ(n) for n = 1..x_N
    M = 0
    M_odd = 0
    for n in range(1, x_N + 1):
        M += mu[n]
        if n % 2 == 1:
            M_odd += mu[n]

    # Verify parity identity: M(x) = M_odd(x) − M_odd(x/2)
    M_odd_half = 0
    half = x_N // 2
    for n in range(1, half + 1):
        if n % 2 == 1:
            M_odd_half += mu[n]

    parity_check = (M == M_odd - M_odd_half)

    return (N, x_N, M, M_odd, M * M < x_N, parity_check, M_odd_half)

def main():
    print("# Mertens function at shell boundaries")
    print("# M(x_N) = Σ μ(n) for n=1..x_N, x_N = (3^N − 1)/2")
    print()

    # Determine max feasible N based on available memory
    # ~500M entries × 1 byte = 500 MB. Adjust if needed.
    max_limit = 500_000_000
    if len(sys.argv) > 1:
        max_limit = int(sys.argv[1])

    print(f"# max sieve limit: {max_limit:,}")
    print()

    header = f"{'N':>3} {'x_N':>15} {'M(x_N)':>10} {'M_odd':>10} {'M_odd(x/2)':>10} {'M²<x_N':>7} {'parity✓':>8} {'M²/x_N':>12}"
    print(header)
    print("-" * len(header))

    for N in range(3, 30):
        x_N = (3**N - 1) // 2
        if x_N > max_limit:
            print(f"{N:>3} {x_N:>15,} (exceeds sieve limit)")
            continue

        result = compute_mertens_at_shell(N, max_limit)
        if result[2] is None:
            print(f"{N:>3} {x_N:>15,} (exceeds sieve limit)")
            continue

        N_, x, M, M_odd, bound_holds, parity_ok, M_odd_half = result
        ratio = f"{M*M}/{x}" if x > 0 else "n/a"
        print(f"{N_:>3} {x:>15,} {M:>10} {M_odd:>10} {M_odd_half:>10} {'✓' if bound_holds else '✗':>7} {'✓' if parity_ok else '✗':>8} {ratio:>12}")

    print()
    print("# Parity identity: M(x) = M_odd(x) − M_odd(x/2)")
    print("# RH equivalent bound: M(x)² < x for all x (Mertens conjecture)")
    print("# Known to fail at x ≈ 10^14 but consistent here")

if __name__ == "__main__":
    main()
