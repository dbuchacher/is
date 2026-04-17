#!/usr/bin/env python3
"""
Test EVERYTHING about shell-boundary prime distribution in one parallel
sweep across N = 3..17.

Branches tested per N:
  A. gcd(g) = odd_part(x_N)? (the almost-theorem)
  B. gcd(x_N, π(x_N)) — failure predictor
  C. Primitive prime divisors of 3^N - 1 (Zsygmondy sequence) — when
     does a new prime first enter?
  D. M(x_N) at the lattice-complete boundary
  E. π(x_N) factorization (framework match hunt)
  F. Where does each prime ≤ 100 first enter as a factor of x_N?

Parallel by default. Each N is an independent compute; Pool across all.
"""

from math import comb, gcd
from fractions import Fraction
from functools import reduce
from multiprocessing import Pool, cpu_count


def sieve_primes(N):
    if N < 2:
        return []
    sieve = [True] * (N + 1)
    sieve[0] = sieve[1] = False
    for i in range(2, int(N**0.5) + 1):
        if sieve[i]:
            for j in range(i * i, N + 1, i):
                sieve[j] = False
    return [i for i in range(2, N + 1) if sieve[i]]


def mobius_sieve(N):
    if N < 1:
        return []
    mu = [0] * (N + 1)
    mu[1] = 1
    spf = list(range(N + 1))
    for i in range(2, int(N**0.5) + 1):
        if spf[i] == i:
            for j in range(i * i, N + 1, i):
                if spf[j] == j:
                    spf[j] = i
    for n in range(2, N + 1):
        p = spf[n]
        m = n // p
        if m % p == 0:
            mu[n] = 0
        else:
            mu[n] = -mu[m]
    return mu


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
    """Full analysis at N: primes, cells, M, theorems."""
    x_N = (3**N - 1) // 2
    B = 3**N - 1  # == 2 * x_N

    # Sieve Möbius and prime markers up to x_N
    # Also collect primes for cell analysis
    primes_list = sieve_primes(x_N)
    mu = mobius_sieve(x_N)
    pi_x = len(primes_list)

    # Cell-level prime counts
    by_z = {z: 0 for z in range(N + 1)}
    for p in primes_list:
        digits = to_balanced_ternary(p, N)
        z = digits.count(0)
        by_z[z] += 2  # signed

    # Mertens function at x_N
    M_x = sum(mu[1:x_N + 1])

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

    # gcd(x_N, π(x_N))
    shared_factor = gcd(x_N, pi_x)
    shared_odd = odd_part(shared_factor)

    return {
        "N": N,
        "x_N": x_N,
        "x_N_factors": prime_factorize(x_N),
        "pi": pi_x,
        "pi_factors": prime_factorize(pi_x),
        "odd_part": op_xN,
        "op_factors": prime_factorize(op_xN),
        "gcd_g": gcd_g,
        "gcd_g_factors": prime_factorize(gcd_g),
        "theorem_holds": theorem_holds,
        "shared_pi_x": shared_factor,
        "shared_odd": shared_odd,
        "M_x": M_x,
        "g_list": g_list,
    }


def primitive_prime_divisors(max_N):
    """For each N, find primes that divide 3^N - 1 but not 3^k - 1
    for any 1 <= k < N. Zsygmondy sequence."""
    seen_primes = set()
    result = {}
    for N in range(1, max_N + 1):
        val = 3**N - 1
        factors = set()
        d = 2
        v = val
        while d * d <= v:
            if v % d == 0:
                factors.add(d)
                while v % d == 0:
                    v //= d
            d += 1
        if v > 1:
            factors.add(v)
        new_primes = factors - seen_primes
        result[N] = sorted(new_primes)
        seen_primes |= factors
    return result


def print_main_report(results, primitive_map):
    print(f"\n{'='*105}")
    print(f"  ALMOST-THEOREM STATUS across all tested N")
    print(f"{'='*105}")
    print(f"  {'N':<4}{'x_N':<14}{'π(x_N)':<10}{'odd_part':<14}"
          f"{'gcd(g)':<14}{'holds?':<9}{'shared odd':<12}{'M(x_N)':<10}")
    print("  " + "-" * 103)

    for r in results:
        mark = "✓" if r["theorem_holds"] else "✗"
        shared = r["shared_odd"] if r["shared_odd"] > 1 else "—"
        print(f"  {r['N']:<4}{r['x_N']:<14}{r['pi']:<10}{r['odd_part']:<14}"
              f"{r['gcd_g']:<14}{mark:<9}{str(shared):<12}{r['M_x']:<10}")


def print_primitive_primes(primitive_map, results):
    print(f"\n{'='*90}")
    print(f"  PRIMITIVE PRIME DIVISORS of 3^N − 1  (Zsygmondy — first appearance)")
    print(f"{'='*90}")
    print(f"  {'N':<4}{'new primes entering at this N':<40}{'theorem holds at N?':<20}")
    print("  " + "-" * 80)

    th_map = {r["N"]: r["theorem_holds"] for r in results}

    for N in sorted(primitive_map.keys()):
        if N < 3:
            continue
        new = primitive_map[N]
        new_str = ", ".join(str(p) for p in new) if new else "(none)"
        held = th_map.get(N)
        if held is None:
            th_str = "(not tested)"
        elif held:
            th_str = "✓"
        else:
            th_str = "✗"
        print(f"  {N:<4}{new_str:<40}{th_str:<20}")


def print_pi_factors(results):
    print(f"\n{'='*80}")
    print(f"  π(x_N) FACTORIZATION — hunting for framework-clean matches")
    print(f"{'='*80}")
    print(f"  {'N':<4}{'x_N':<14}{'π(x_N)':<10}{'factors':<30}")
    print("  " + "-" * 65)
    for r in results:
        pi = r["pi"]
        factors = fmt_factors(pi)
        print(f"  {r['N']:<4}{r['x_N']:<14}{pi:<10}{factors:<30}")


def print_M_at_boundaries(results):
    print(f"\n{'='*70}")
    print(f"  M(x_N) at LATTICE-COMPLETE BOUNDARIES")
    print(f"{'='*70}")
    print(f"  {'N':<4}{'x_N':<14}{'M(x_N)':<12}{'|M|':<10}{'M² vs x_N':<20}")
    print("  " + "-" * 64)
    for r in results:
        M = r["M_x"]
        abs_M = abs(M)
        sq = abs_M * abs_M
        comp = f"{sq} vs {r['x_N']}  {'<' if sq < r['x_N'] else '≥'}"
        print(f"  {r['N']:<4}{r['x_N']:<14}{M:<12}{abs_M:<10}{comp:<20}")


def main():
    Ns = list(range(3, 18))  # N = 3 through 17
    print(f"Running parallel sweep for N in {Ns[0]}..{Ns[-1]}")
    print(f"Max range: N={Ns[-1]} → x = {(3**Ns[-1] - 1) // 2:,}")
    print(f"Using {cpu_count()} parallel workers")

    with Pool(processes=min(cpu_count(), len(Ns))) as pool:
        results = pool.map(analyze_N, Ns)

    print("done.\n")

    # Sort by N
    results.sort(key=lambda r: r["N"])

    # Zsygmondy sequence up to N=17
    primitive_map = primitive_prime_divisors(17)

    print_main_report(results, primitive_map)
    print_primitive_primes(primitive_map, results)
    print_pi_factors(results)
    print_M_at_boundaries(results)


if __name__ == "__main__":
    main()
