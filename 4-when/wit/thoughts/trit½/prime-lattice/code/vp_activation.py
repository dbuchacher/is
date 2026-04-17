#!/usr/bin/env python3
"""
vp_activation.py — for each small prime p, find smallest N where p | π(x_N)

This computes a new integer sequence: the "π-side activation" of each prime.

The refined three-term shell-identity theorem strips prime p from shell_gcd_N
when v_p(C_N) > 0, i.e., when p | π(x_N) (since C_N = 2·π(x_N)).

Question: for each prime p, what is the SMALLEST N such that p | π(x_N)?

This tells us where each prime "activates" its π-side stripping mechanism
in the shell-identity theorem. If a prime p divides π(x_N) at some N AND
also divides B_N = 3^N − 1 at that same N, the three-term formula strips
p from shell_gcd_N via the v_p(C) term.

Integer only. No floats.
"""

import sys
from math import isqrt

def sieve_count(limit):
    """Count primes up to limit via sieve. Returns π(limit)."""
    if limit < 2:
        return 0
    is_p = bytearray(b'\x01') * (limit + 1)
    is_p[0] = is_p[1] = 0
    for p in range(2, isqrt(limit) + 1):
        if is_p[p]:
            for j in range(p*p, limit + 1, p):
                is_p[j] = 0
    return sum(is_p)

def factor(n):
    """Trial-division factorization. Returns dict {prime: power}."""
    factors = {}
    d = 2
    while d * d <= n:
        while n % d == 0:
            factors[d] = factors.get(d, 0) + 1
            n //= d
        d += 1
    if n > 1:
        factors[n] = factors.get(n, 0) + 1
    return factors

def main():
    max_limit = 200_000_000
    if len(sys.argv) > 1:
        max_limit = int(sys.argv[1])

    print("# π-side activation: smallest N where p | π(x_N)")
    print(f"# sieve limit: {max_limit:,}")
    print()

    # Compute π(x_N) for each N, then factor it
    pi_data = {}  # N -> (x_N, pi_x_N, factors_of_pi)
    for N in range(3, 30):
        x_N = (3**N - 1) // 2
        if x_N > max_limit:
            print(f"N={N:>2}  x_N={x_N:>15,}  (exceeds sieve)")
            break

        pi_x = sieve_count(x_N)
        f = factor(pi_x)
        pi_data[N] = (x_N, pi_x, f)

        primes_in_pi = sorted(f.keys())
        factors_str = ' · '.join(
            f"{p}^{e}" if e > 1 else str(p)
            for p, e in sorted(f.items())
        )
        print(f"N={N:>2}  x_N={x_N:>12,}  π(x_N)={pi_x:>8,} = {factors_str}")

    print()
    print("# Activation table: first N where each prime divides π(x_N)")
    print()

    # Collect all primes that appear as factors of any π(x_N)
    all_primes_seen = set()
    for N, (x_N, pi_x, f) in pi_data.items():
        all_primes_seen.update(f.keys())

    # For each prime, find the smallest N where it divides π(x_N)
    activation = {}
    for p in sorted(all_primes_seen):
        for N in sorted(pi_data.keys()):
            _, pi_x, f = pi_data[N]
            if p in f:
                activation[p] = N
                break

    for p, N in sorted(activation.items()):
        x_N, pi_x, _ = pi_data[N]
        # Check if p also divides B_N = 3^N − 1
        B_N = 3**N - 1
        divides_B = B_N % p == 0

        status = "** BOTH B and π **" if divides_B else "(π only)"
        print(f"  p={p:>5}  first activates at N={N:>2}  "
              f"π(x_N)={pi_x:>8,}  p|B_N: {'YES' if divides_B else 'no':>3}  {status}")

    print()
    print("# Primes where p | π(x_N) AND p | B_N at the SAME N are the")
    print("# ones that contribute v_p(C) stripping in the three-term theorem.")
    print("# Example: p=73 at N=12, p=5 and p=11 at N=20.")

    # Also: list all N where π-side stripping is active (at least one shared prime)
    print()
    print("# N values with active π-side stripping (shared primes between B_N and π(x_N)):")
    for N in sorted(pi_data.keys()):
        x_N, pi_x, pi_factors = pi_data[N]
        B_N = 3**N - 1
        B_factors = factor(B_N)
        shared = set(pi_factors.keys()) & set(B_factors.keys())
        # exclude 2 (always shared, not interesting for odd shell_gcd)
        shared_odd = {p for p in shared if p > 2}
        if shared_odd:
            print(f"  N={N:>2}  shared odd primes: {sorted(shared_odd)}  "
                  f"→ v_p(C) strips these from shell_gcd_N")

if __name__ == "__main__":
    main()
