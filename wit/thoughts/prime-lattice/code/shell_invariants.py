#!/usr/bin/env python3
"""
shell_invariants.py — multiple reductions of the g-vector at each shell boundary

At each N, for each prime-holding cell z, we compute:
  g_z = (A_z · B) / gcd(A_z · B, C · D_z)

where A_z = signed primes at cell z, B = 3^N − 1, C = 2·π(x_N),
D_z = C(N,z) · 2^(N−z).

Then we compute MULTIPLE reductions of the g-vector across prime-holding cells:
  - gcd(all g_z)           — the shell_gcd_N we already know
  - lcm(all g_z)           — new
  - sum(all g_z)           — new
  - max(g_z)               — new
  - min(g_z)               — new
  - count of distinct g_z  — new
  - product(all g_z)       — new (may be huge)

Looking for framework-constant factorizations in any of these.

Integer only. No floats. Parallel via multiprocessing.
"""

import sys
from math import gcd, comb, isqrt
from functools import reduce
from multiprocessing import Pool, cpu_count
from collections import Counter

def lcm(a, b):
    return abs(a * b) // gcd(a, b)

def multi_lcm(values):
    return reduce(lcm, values)

def multi_gcd(values):
    return reduce(gcd, values)

def is_prime_trial(n):
    if n < 2: return False
    if n < 4: return True
    if n % 2 == 0 or n % 3 == 0: return False
    i = 5
    while i * i <= n:
        if n % i == 0 or n % (i + 2) == 0:
            return False
        i += 6
    return True

def sieve_primes(limit):
    """Simple sieve of Eratosthenes. Returns set of primes up to limit."""
    if limit < 2:
        return set()
    is_p = bytearray(b'\x01') * (limit + 1)
    is_p[0] = is_p[1] = 0
    for p in range(2, isqrt(limit) + 1):
        if is_p[p]:
            for j in range(p*p, limit + 1, p):
                is_p[j] = 0
    return {n for n in range(2, limit + 1) if is_p[n]}

def balanced_ternary_sum(digits):
    """Given a tuple of {-1, 0, +1} digits, compute the integer sum
    Σ d_i · 3^i for i = 0..len-1."""
    return sum(d * (3**i) for i, d in enumerate(digits))

def enumerate_shell_data(N, max_x=200_000_000):
    """At shell-1 boundary x_N = (3^N−1)/2, compute A_z, D_z for each
    prime-holding cell z (z = number of zero coords)."""
    from itertools import product as iproduct

    x_N = (3**N - 1) // 2
    if x_N > max_x:
        return None

    B = 3**N - 1  # = 2 * x_N

    # sieve primes up to x_N
    primes = sieve_primes(x_N)
    pi_x_N = len(primes)
    C = 2 * pi_x_N

    # enumerate all 3^N points, classify by z (number of zeros)
    VALUES = (-1, 0, 1)
    cell_primes = {}  # z -> list of (signed) prime values at that cell

    for point in iproduct(VALUES, repeat=N):
        z = sum(1 for d in point if d == 0)
        val = balanced_ternary_sum(point)
        if val == 0:
            continue
        aval = abs(val)
        if aval <= x_N and aval in primes:
            if z not in cell_primes:
                cell_primes[z] = []
            cell_primes[z].append(val)

    # prime-holding cells: z where (N − z) is odd (parity law)
    prime_holding_z = [z for z in range(N+1) if (N - z) % 2 == 1]

    results = {}
    for z in prime_holding_z:
        A_z = len(cell_primes.get(z, []))  # signed prime count
        if A_z == 0:
            continue
        D_z = comb(N, z) * (2 ** (N - z))
        # g_z / f_z = (A_z · B) / (C · D_z) in lowest terms
        num = A_z * B
        den = C * D_z
        g = gcd(num, den)
        f_z = den // g
        g_z = num // g
        results[z] = {
            'A_z': A_z,
            'D_z': D_z,
            'f_z': f_z,
            'g_z': g_z,
        }

    return {
        'N': N,
        'x_N': x_N,
        'B': B,
        'C': C,
        'pi_x_N': pi_x_N,
        'cells': results,
    }

def compute_invariants(N, max_x=200_000_000):
    """Compute all shell invariants at dimension N."""
    data = enumerate_shell_data(N, max_x)
    if data is None:
        return (N, (3**N - 1) // 2, None)

    g_values = [c['g_z'] for c in data['cells'].values()]
    f_values = [c['f_z'] for c in data['cells'].values()]

    if not g_values:
        return (N, data['x_N'], None)

    shell_gcd = multi_gcd(g_values)
    shell_lcm = multi_lcm(g_values)
    shell_sum = sum(g_values)
    shell_max = max(g_values)
    shell_min = min(g_values)
    shell_prod = reduce(lambda a, b: a * b, g_values)
    n_distinct = len(set(g_values))
    n_cells = len(g_values)

    # factor shell_gcd for display
    def small_factor(n):
        if n <= 1: return str(n)
        factors = []
        for p in [2,3,5,7,11,13,17,19,23,29,31,37,41,43,47,53,59,61,67,71,73,79]:
            while n % p == 0:
                factors.append(p)
                n //= p
        if n > 1:
            factors.append(n)
        return ' · '.join(str(f) for f in factors)

    return (N, data['x_N'], {
        'shell_gcd': shell_gcd,
        'shell_lcm': shell_lcm,
        'shell_sum': shell_sum,
        'shell_max': shell_max,
        'shell_min': shell_min,
        'shell_prod': shell_prod,
        'n_cells': n_cells,
        'n_distinct': n_distinct,
        'g_values': sorted(g_values),
        'gcd_factors': small_factor(shell_gcd),
        'lcm_factors': small_factor(shell_lcm),
        'pi_x_N': data['pi_x_N'],
        'C': data['C'],
        'B': data['B'],
    })

def main():
    max_x = 200_000_000
    if len(sys.argv) > 1:
        max_x = int(sys.argv[1])

    print("# Shell invariants — multiple reductions of the g-vector")
    print(f"# max sieve: {max_x:,}")
    print()

    for N in range(3, 25):
        result = compute_invariants(N, max_x)
        N_, x_N, inv = result
        if inv is None:
            print(f"N={N_:>2}  x_N={x_N:>15,}  (exceeds sieve limit)")
            continue

        print(f"N={N_:>2}  x_N={x_N:>12,}  π(x_N)={inv['pi_x_N']:>8,}")
        print(f"  cells={inv['n_cells']}  distinct_g={inv['n_distinct']}")
        print(f"  gcd  = {inv['shell_gcd']:>12}  = {inv['gcd_factors']}")
        print(f"  lcm  = {inv['shell_lcm']:>12}  = {inv['lcm_factors']}")
        print(f"  sum  = {inv['shell_sum']:>12}")
        print(f"  max  = {inv['shell_max']:>12}")
        print(f"  min  = {inv['shell_min']:>12}")
        print(f"  g_values = {inv['g_values']}")
        print()

if __name__ == "__main__":
    main()
