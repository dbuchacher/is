#!/usr/bin/env python3
"""
Extend shell-boundary compute to N = 11..14.

Test the candidate theorem:
    gcd(g values across prime-holding cells) = odd_part(x_N)
    where x_N = (3^N - 1)/2

And record π(x_N) for each, looking for framework-clean factorizations.

Also: record the RESIDUAL factor (g / odd_part(x_N)) for each cell —
what's left after stripping x_N's odd part.
"""

from math import comb, gcd
from fractions import Fraction
from functools import reduce
from multiprocessing import Pool, cpu_count


def sieve_primes(N):
    sieve = [True] * (N + 1)
    sieve[0] = sieve[1] = False
    for i in range(2, int(N**0.5) + 1):
        if sieve[i]:
            for j in range(i * i, N + 1, i):
                sieve[j] = False
    return [i for i in range(2, N + 1) if sieve[i]]


def to_balanced_ternary(n, num_digits):
    digits = []
    x = n
    for _ in range(num_digits):
        r = ((x + 1) % 3) - 1
        digits.append(r)
        x = (x - r) // 3
    return tuple(digits)


def odd_part(n):
    """Return n stripped of its 2-power."""
    while n % 2 == 0:
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


def analyze_N(N):
    max_val = (3**N - 1) // 2
    primes = sieve_primes(max_val)
    by_z = {z: 0 for z in range(N + 1)}

    for p in primes:
        digits = to_balanced_ternary(p, N)
        z = digits.count(0)
        by_z[z] += 2  # signed

    return (N, by_z, max_val, len(primes))


def cell_fg(A, B, C, D):
    r = Fraction(A * B, C * D)
    return r.denominator, r.numerator


def check_theorem(result):
    """Verify gcd(g) = odd_part(x_N) and report residuals."""
    N, by_z, max_val, pi_x = result
    C = 2 * pi_x
    B = 3**N - 1
    x_N = max_val
    op = odd_part(x_N)

    g_list = []
    cell_data = []
    for z in range(N + 1):
        D = comb(N, z) * (2 ** (N - z))
        A = by_z[z]
        if A == 0 or C == 0:
            continue
        f, g = cell_fg(A, B, C, D)
        g_list.append(g)
        residual = g // op if g % op == 0 else None
        cell_data.append((z, D, A, f, g, residual))

    gcd_g = reduce(gcd, g_list) if g_list else 0
    theorem_holds = (gcd_g == op)

    return {
        "N": N,
        "x_N": x_N,
        "pi": pi_x,
        "x_N_factors": fmt_factors(x_N),
        "odd_part": op,
        "odd_part_factors": fmt_factors(op),
        "gcd_g": gcd_g,
        "theorem_holds": theorem_holds,
        "cells": cell_data,
    }


def print_report(data):
    N = data["N"]
    op = data["odd_part"]
    print(f"\n{'='*98}")
    print(f"  N = {N}   x_N = {data['x_N']} = {data['x_N_factors']}")
    print(f"  π(x_N) = {data['pi']}   odd_part(x_N) = {op} = {data['odd_part_factors']}")
    print(f"  gcd(g) = {data['gcd_g']}   theorem: gcd(g) == odd_part(x_N)?  "
          f"{'✓' if data['theorem_holds'] else '✗ FAIL'}")
    print(f"{'='*98}")
    print(f"  {'z':<4}{'D':<10}{'A':<10}{'f':<18}{'g':<20}{'g/op':<12}{'g factors':<20}")
    print("  " + "-" * 96)

    for z, D, A, f, g, residual in data["cells"]:
        res_str = str(residual) if residual is not None else "NOT div"
        print(f"  {z:<4}{D:<10}{A:<10}{f:<18}{g:<20}{res_str:<12}{fmt_factors(g):<20}")


def main():
    # Extended N range
    Ns = [11, 12, 13, 14]
    print(f"Running extended analysis for N in {Ns} across {cpu_count()} processes...")
    print(f"Largest range: N={max(Ns)} → x = {(3**max(Ns) - 1) // 2}")

    with Pool(processes=min(cpu_count(), len(Ns))) as pool:
        results = pool.map(analyze_N, Ns)

    print("done.\n")

    all_data = []
    for result in results:
        data = check_theorem(result)
        all_data.append(data)
        print_report(data)

    # Summary
    print(f"\n{'='*70}")
    print(f"  SUMMARY: theorem gcd(g) = odd_part(x_N)")
    print(f"{'='*70}")
    print(f"  {'N':<5}{'x_N':<12}{'odd_part':<14}{'gcd(g)':<14}{'holds?':<8}")
    print("  " + "-" * 55)
    for d in all_data:
        mark = "✓" if d["theorem_holds"] else "✗"
        print(f"  {d['N']:<5}{d['x_N']:<12}{d['odd_part']:<14}{d['gcd_g']:<14}{mark}")

    # π(x_N) factorization summary
    print(f"\n{'='*80}")
    print(f"  π(x_N) FACTORIZATION (looking for framework-clean matches)")
    print(f"{'='*80}")
    print(f"  {'N':<5}{'x_N':<12}{'π(x_N)':<12}{'factors':<24}{'notes':<20}")
    print("  " + "-" * 73)
    for d in all_data:
        pi = d["pi"]
        print(f"  {d['N']:<5}{d['x_N']:<12}{pi:<12}{fmt_factors(pi):<24}")


if __name__ == "__main__":
    main()
