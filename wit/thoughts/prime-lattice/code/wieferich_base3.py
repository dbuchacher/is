#!/usr/bin/env python3
"""
wieferich_base3.py — search for base-3 Wieferich primes

A base-b Wieferich prime is a prime p such that b^(p−1) ≡ 1 (mod p²).
Base-2 Wieferich primes: only 1093 and 3511 are known.

The framework already noticed: 1093 is the Zsygmondy primitive at
base-3 N=7 (i.e., ord_1093(3) = 7). 1093 is ALSO a base-2 Wieferich.

Question: are there base-3 Wieferich primes (3^(p−1) ≡ 1 mod p²)?
Do any of them also appear as Zsygmondy primitives in the base-3
lattice?

Integer only. No floats.
"""

import sys
from math import isqrt

def sieve_primes(limit):
    """Returns list of primes up to limit."""
    is_p = bytearray(b'\x01') * (limit + 1)
    is_p[0] = is_p[1] = 0
    for p in range(2, isqrt(limit) + 1):
        if is_p[p]:
            for j in range(p*p, limit + 1, p):
                is_p[j] = 0
    return [n for n in range(2, limit + 1) if is_p[n]]

def is_wieferich_base(b, p):
    """Check if p is a base-b Wieferich prime: b^(p-1) ≡ 1 (mod p²)."""
    return pow(b, p - 1, p * p) == 1

def multiplicative_order(b, p):
    """Compute ord_p(b) = smallest k > 0 with b^k ≡ 1 (mod p).
    Returns k, or 0 if gcd(b, p) > 1."""
    if p <= 1 or b % p == 0:
        return 0
    power = b % p
    for k in range(1, p):
        if power == 1:
            return k
        power = (power * b) % p
    return 0  # shouldn't reach here for prime p

def main():
    limit = 1_000_000
    if len(sys.argv) > 1:
        limit = int(sys.argv[1])

    print(f"# Base-3 Wieferich prime search up to {limit:,}")
    print("# Checking: 3^(p−1) ≡ 1 (mod p²) for each prime p")
    print()

    primes = sieve_primes(limit)
    print(f"# {len(primes):,} primes to check")
    print()

    wieferich_b2 = []
    wieferich_b3 = []
    wieferich_both = []

    for p in primes:
        if p == 3:
            continue  # skip base itself

        w2 = is_wieferich_base(2, p)
        w3 = is_wieferich_base(3, p)

        if w2:
            wieferich_b2.append(p)
        if w3:
            wieferich_b3.append(p)
        if w2 and w3:
            wieferich_both.append(p)

    print("## Base-2 Wieferich primes (known: 1093, 3511)")
    for p in wieferich_b2:
        ord3 = multiplicative_order(3, p)
        print(f"  p = {p:>8}  ord_p(3) = {ord3}  "
              f"(Zsygmondy primitive at N={ord3} in base-3 lattice)")

    print()
    print("## Base-3 Wieferich primes (3^(p−1) ≡ 1 mod p²)")
    if wieferich_b3:
        for p in wieferich_b3:
            ord3 = multiplicative_order(3, p)
            ord2 = multiplicative_order(2, p)
            print(f"  p = {p:>8}  ord_p(3) = {ord3}  ord_p(2) = {ord2}")
    else:
        print(f"  (none found up to {limit:,})")

    print()
    print("## Primes that are Wieferich in BOTH base 2 and base 3")
    if wieferich_both:
        for p in wieferich_both:
            print(f"  p = {p}")
    else:
        print(f"  (none found up to {limit:,})")

    print()
    print("## Cross-reference: base-2 Wieferich primes as Zsygmondy primitives")
    for p in wieferich_b2:
        ord3 = multiplicative_order(3, p)
        x_ord = (3**ord3 - 1) // 2
        print(f"  1093: base-2 Wieferich, base-3 Zsygmondy primitive at N={ord3}")
        print(f"        x_{ord3} = {x_ord}")
        print(f"        shell_gcd_N{ord3} = {'(known: check MILESTONE)'}")

    # Also check: are any Zsygmondy primitives from the framework's table
    # also base-3 Wieferich?
    print()
    print("## Framework Zsygmondy primitives — base-3 Wieferich check")
    zsygmondy_table = {
        3: [13], 4: [5], 5: [11], 6: [7], 7: [1093], 8: [41],
        9: [757], 10: [61], 11: [23, 3851], 12: [73], 13: [797161],
        14: [547], 15: [4561], 16: [17, 193], 17: [1871, 34511],
    }
    for N, primitives in sorted(zsygmondy_table.items()):
        for p in primitives:
            if p > limit:
                status = "(above search limit)"
            elif is_wieferich_base(3, p):
                status = "** BASE-3 WIEFERICH **"
            else:
                status = "not Wieferich"
            w2 = is_wieferich_base(2, p) if p <= limit else False
            b2_status = " (also base-2 Wieferich!)" if w2 else ""
            print(f"  N={N:>2}  p={p:>8}  {status}{b2_status}")

if __name__ == "__main__":
    main()
