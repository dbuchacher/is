#!/usr/bin/env python3
"""
Test the "decay past shell 4" hypothesis.

Framework mapping: N balanced-ternary digits ↔ framework shell (N/4).
So N=16 = shell 4 boundary (stable). N=17+ = decay regime.

Predictions under this hypothesis:
  N=18 = 2·3² — composite with small divisors → FAIL
  N=19 prime → HOLD (heartbeat brief re-stabilization)

Parallel compute for N=18, 19. Records:
  - theorem status
  - π(x_N) and its factors
  - M(x_N) at boundary
  - primitive prime divisors
  - mertens M² vs x_N
"""

from math import comb, gcd
from fractions import Fraction
from functools import reduce
from multiprocessing import Pool, cpu_count


def segmented_sieve_primes_count_and_walk(limit, callback_per_prime):
    """Count primes up to limit, calling callback(p) for each prime.
    Memory-efficient: uses a bit array."""
    if limit < 2:
        return 0
    sieve = bytearray([1]) * (limit + 1)
    sieve[0] = sieve[1] = 0
    for i in range(2, int(limit**0.5) + 1):
        if sieve[i]:
            for j in range(i * i, limit + 1, i):
                sieve[j] = 0
    count = 0
    for i in range(2, limit + 1):
        if sieve[i]:
            count += 1
            callback_per_prime(i)
    return count


def sieve_primes(limit):
    if limit < 2:
        return []
    sieve = bytearray([1]) * (limit + 1)
    sieve[0] = sieve[1] = 0
    for i in range(2, int(limit**0.5) + 1):
        if sieve[i]:
            sieve[i * i::i] = bytearray(len(sieve[i * i::i]))
    return [i for i, s in enumerate(sieve) if s]


def mobius_sum(limit):
    """Compute M(limit) = sum of mu(1..limit). Memory-efficient using
    smallest prime factor, no full list of mu values."""
    if limit < 1:
        return 0
    spf = list(range(limit + 1))
    for i in range(2, int(limit**0.5) + 1):
        if spf[i] == i:
            for j in range(i * i, limit + 1, i):
                if spf[j] == j:
                    spf[j] = i
    M = 0
    mu_cache = [0] * (limit + 1)
    mu_cache[1] = 1
    for n in range(1, limit + 1):
        if n == 1:
            mu_n = 1
        else:
            p = spf[n]
            m = n // p
            if m % p == 0:
                mu_n = 0
            else:
                mu_n = -mu_cache[m]
        mu_cache[n] = mu_n
        M += mu_n
    return M


def to_balanced_ternary(n, num_digits):
    digits = []
    x = n
    for _ in range(num_digits):
        r = ((x + 1) % 3) - 1
        digits.append(r)
        x = (x - r) // 3
    return tuple(digits)


def odd_part(n):
    while n > 0 and n % 2 == 0:
        n //= 2
    return n


def prime_factorize(n):
    if n < 2:
        return []
    factors = []
    d = 2
    while d * d <= n:
        if n % d == 0:
            e = 0
            while n % d == 0:
                n //= d
                e += 1
            factors.append((d, e))
        d += 1 if d == 2 else 2
    if n > 1:
        factors.append((n, 1))
    return factors


def fmt_factors(n):
    fs = prime_factorize(n)
    if not fs:
        return "1"
    return "·".join(f"{p}^{e}" if e > 1 else f"{p}" for p, e in fs)


def cell_fg(A, B, C, D):
    r = Fraction(A * B, C * D)
    return r.denominator, r.numerator


def analyze_N(N):
    """Theorem check + basic stats at N. Memory-efficient."""
    x_N = (3**N - 1) // 2
    B = 3**N - 1

    # Sieve primes (memory intensive at N=18, 19)
    primes = sieve_primes(x_N)
    pi_x = len(primes)

    # Cell-level prime counts
    by_z = {z: 0 for z in range(N + 1)}
    for p in primes:
        digits = to_balanced_ternary(p, N)
        z = digits.count(0)
        by_z[z] += 2  # signed

    # Free the prime list
    del primes

    # Mertens function
    M_x = mobius_sum(x_N)

    # gcd(g) across prime-holding cells
    C = 2 * pi_x
    g_list = []
    for z in range(N + 1):
        D = comb(N, z) * (2 ** (N - z))
        A = by_z[z]
        if A == 0 or C == 0:
            continue
        _, g = cell_fg(A, B, C, D)
        g_list.append(g)

    gcd_g = reduce(gcd, g_list) if g_list else 0
    op_xN = odd_part(x_N)
    theorem_holds = (gcd_g == op_xN)
    shared_factor = gcd(x_N, pi_x)
    shared_odd = odd_part(shared_factor)

    return {
        "N": N,
        "x_N": x_N,
        "pi": pi_x,
        "odd_part": op_xN,
        "gcd_g": gcd_g,
        "theorem_holds": theorem_holds,
        "shared_odd": shared_odd,
        "M_x": M_x,
        "by_z": by_z,
    }


def main():
    Ns = [18, 19]
    print(f"Running decay-hypothesis test for N = {Ns}")
    print(f"N=18 → x = {(3**18 - 1)//2:,}")
    print(f"N=19 → x = {(3**19 - 1)//2:,}")
    print(f"Parallel across {min(cpu_count(), len(Ns))} workers...")
    print()

    with Pool(processes=min(cpu_count(), len(Ns))) as pool:
        results = pool.map(analyze_N, Ns)

    results.sort(key=lambda r: r["N"])

    print(f"\n{'='*90}")
    print(f"  RESULTS")
    print(f"{'='*90}")
    print(f"  {'N':<4}{'x_N':<16}{'π(x_N)':<12}{'odd_part':<14}{'gcd(g)':<14}"
          f"{'holds?':<10}{'M(x_N)':<10}")
    print("  " + "-" * 88)

    for r in results:
        mark = "✓" if r["theorem_holds"] else "✗"
        print(f"  {r['N']:<4}{r['x_N']:<16}{r['pi']:<12}{r['odd_part']:<14}"
              f"{r['gcd_g']:<14}{mark:<10}{r['M_x']:<10}")

    print()
    for r in results:
        print(f"  N={r['N']}:  x_N = {r['x_N']} = {fmt_factors(r['x_N'])}")
        print(f"          π(x_N) = {r['pi']} = {fmt_factors(r['pi'])}")
        print(f"          M(x_N) = {r['M_x']}   M² = {r['M_x']**2}   "
              f"M²<x_N: {r['M_x']**2 < r['x_N']}")
        pred = "FAIL predicted" if r['N'] in [18, 20, 21] else "HOLD predicted"
        actual = "HELD" if r["theorem_holds"] else "FAILED"
        print(f"          Prediction: {pred}   Actual: {actual}")
        print()


if __name__ == "__main__":
    main()
