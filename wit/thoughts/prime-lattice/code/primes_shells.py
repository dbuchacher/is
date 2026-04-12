#!/usr/bin/env python3
"""
Prime distribution at shell-completion boundaries.

Core claim (to verify):
  At each N, at the shell-1 boundary x_N = (3^N − 1)/2, the prime
  distribution satisfies integer identities of the form

     A · B · f  =  C · D · g

  where:
    A = signed primes at cell z
    D = point count at cell = C(N, z) · 2^(N-z)
    C = total signed primes in [-x_N, x_N]
    B = total nonzero points = 3^N − 1
    (f, g) = reduced integer pair from (A·B)/(C·D)

  At N=4, cell z=1 (edges): (f, g) = (12, 25) — gates · dims, gates² + dims²
  — the Pythagorean lattice fill constants.

Parallelized across N via multiprocessing.
"""

from math import comb, gcd
from fractions import Fraction
from functools import reduce
from multiprocessing import Pool, cpu_count


def isprime(n):
    if n < 2:
        return False
    if n < 4:
        return True
    if n % 2 == 0:
        return False
    for i in range(3, int(n**0.5) + 1, 2):
        if n % i == 0:
            return False
    return True


def sieve_primes(N):
    """Sieve of Eratosthenes up to N, returns list of primes."""
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


def prime_factorize(n):
    if n < 0:
        return [(-1, 1)] + prime_factorize(-n)
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
    """Count signed primes at each z-cell of N-digit balanced ternary.

    Returns (N, by_z_prime, max_val, primes_in_range).
    """
    max_val = (3**N - 1) // 2
    primes = sieve_primes(max_val)
    by_z = {z: 0 for z in range(N + 1)}

    for p in primes:
        digits = to_balanced_ternary(p, N)
        z = digits.count(0)
        by_z[z] += 2  # signed: +p and -p both counted

    return (N, by_z, max_val, len(primes))


def cell_fg(A, B, C, D):
    """Return (f, g) such that A·B·f = C·D·g in lowest terms."""
    # Rearrange: (A·B)/(C·D) = g/f
    r = Fraction(A * B, C * D)
    return r.denominator, r.numerator


def report_N(result):
    N, by_z, max_val, pi_x = result
    C = 2 * pi_x  # signed total primes
    B = 3**N - 1

    print(f"\n{'='*94}")
    print(f"  N = {N}   x_N = {max_val}   π(x_N) = {pi_x}   signed primes C = {C}")
    print(f"  B = 3^{N} − 1 = {B}")
    print(f"{'='*94}")
    print(f"  {'z':<4}{'k':<6}{'parity':<9}{'D (pts)':<12}"
          f"{'A (primes)':<14}{'(f, g)':<20}{'f factors':<14}{'g factors':<14}")
    print("  " + "-" * 92)

    for z in range(N + 1):
        nz = N - z
        parity = "odd" if nz % 2 == 1 else "even"
        D = comb(N, z) * (2 ** nz)
        A = by_z[z]
        if A == 0 or C == 0:
            print(f"  {z:<4}k={nz:<4}{parity:<9}{D:<12}{A:<14}{'(no primes)':<20}")
            continue
        f, g = cell_fg(A, B, C, D)
        lhs = A * B * f
        rhs = C * D * g
        assert lhs == rhs, f"identity fails at N={N} z={z}"
        print(f"  {z:<4}k={nz:<4}{parity:<9}{D:<12}{A:<14}"
              f"({f}, {g}){'':<8}{fmt_factors(f):<14}{fmt_factors(g):<14}")


def summary_pi(results):
    print(f"\n{'='*78}")
    print(f"  π(x_N) AT LATTICE-COMPLETE BOUNDARIES")
    print(f"{'='*78}")
    print(f"  {'N':<5}{'x_N':<10}{'π(x_N)':<12}{'factors of π':<22}"
          f"{'notes':<22}")
    print("  " + "-" * 70)

    notes = {
        3: "(2·3)",
        4: "(3·4 = gates·dims)",
        5: "(2·3·5)",
        6: "(?)",
    }

    for result in results:
        N, _, max_val, pi_x = result
        note = notes.get(N, "")
        print(f"  {N:<5}{max_val:<10}{pi_x:<12}"
              f"{fmt_factors(pi_x):<22}{note:<22}")


def cross_cell_analysis(results):
    print(f"\n{'='*84}")
    print(f"  SHARED FACTORS ACROSS CELLS AT FIXED N")
    print(f"{'='*84}")

    for result in results:
        N, by_z, max_val, pi_x = result
        C = 2 * pi_x
        B = 3**N - 1

        f_list = []
        g_list = []
        for z in range(N + 1):
            D = comb(N, z) * (2 ** (N - z))
            A = by_z[z]
            if A == 0 or C == 0:
                continue
            f, g = cell_fg(A, B, C, D)
            f_list.append(f)
            g_list.append(g)

        if not f_list:
            continue

        gcd_f = reduce(gcd, f_list)
        gcd_g = reduce(gcd, g_list)

        print(f"  N={N}:  f values = {f_list}")
        print(f"         g values = {g_list}")
        print(f"         gcd(f) = {gcd_f}   gcd(g) = {gcd_g}")
        print()


def main():
    Ns = [3, 4, 5, 6, 7, 8, 9, 10]
    print(f"Running analysis for N in {Ns} across {cpu_count()} processes...")

    with Pool(processes=min(cpu_count(), len(Ns))) as pool:
        results = pool.map(analyze_N, Ns)

    print("done.\n")

    for result in results:
        report_N(result)

    summary_pi(results)
    cross_cell_analysis(results)


if __name__ == "__main__":
    main()
