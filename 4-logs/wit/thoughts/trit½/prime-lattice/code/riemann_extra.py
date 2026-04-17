#!/usr/bin/env python3
"""
Follow-up computes on top of riemann.py:

1. M(x) at EACH lattice-complete boundary x = (3^k - 1)/2.
   If the walk really balances at lattice boundaries, M should be small
   at all these points.

2. Antipodal pairing: does each lattice point n pair with -n (same
   balanced-ternary digits, all signs flipped), and if so does μ(n) +
   μ(-n) tend to cancel?  (μ is only defined for positive n, but we
   can test the weaker claim: at each cell class z, are +n and the
   "sign-flipped" positive integer partners?)

3. Cell-sum distribution: is the variance of cell sums small enough
   to give RH?
"""

from math import log, sqrt, comb


def smallest_prime_factor_sieve(N):
    spf = list(range(N + 1))
    for i in range(2, int(N**0.5) + 1):
        if spf[i] == i:
            for j in range(i * i, N + 1, i):
                if spf[j] == j:
                    spf[j] = i
    return spf


def mobius_sieve(N):
    mu = [0] * (N + 1)
    mu[1] = 1
    spf = smallest_prime_factor_sieve(N)
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


def M_at_lattice_boundaries(mu, max_k):
    """Report M(x) at x = (3^k - 1)/2 for each k up to max_k."""
    print("\n(E) MERTENS AT LATTICE-COMPLETE BOUNDARIES")
    print("    x_k = (3^k − 1)/2 covers all integers representable in k balanced trits")
    print("=" * 80)
    print(f"  {'k':<4}{'x_k = (3^k-1)/2':<20}{'M(x_k)':<12}{'√x_k':<14}{'|M|/√x_k':<14}")
    print("  " + "-" * 76)

    M = 0
    n_cur = 0
    results = []
    for k in range(1, max_k + 1):
        x_k = (3**k - 1) // 2
        if x_k >= len(mu):
            break
        while n_cur < x_k:
            n_cur += 1
            M += mu[n_cur]
        ratio = abs(M) / sqrt(x_k) if x_k > 0 else 0
        results.append((k, x_k, M, ratio))
        print(f"  {k:<4}{x_k:<20}{M:<12}{sqrt(x_k):<14.3f}{ratio:<14.6f}")
    print("  " + "-" * 76)
    print("  If RH holds, |M(x_k)|/√x_k should be bounded. If M(x_k) stays O(1)")
    print("  at lattice-complete boundaries specifically, that's stronger than RH there.")

    return results


def cell_sum_distribution(mu, N_DIGITS):
    """For each k-cell (grouping by the POSITION of zeros, not just count),
    sum μ within that cell and look at the distribution."""
    print(f"\n(F) CELL-SUM DISTRIBUTION  (N = {N_DIGITS} digits)")
    print("=" * 80)
    max_val = min((3**N_DIGITS - 1) // 2, len(mu) - 1)

    # Group by exact digit pattern, treating 0 as "free" and ±1 as "fixed"
    # Cell key = tuple indicating positions of zeros, ignoring nonzero signs
    # Actually — group by (zero_mask, sign_mask_of_nonzero)
    # For RH-relevant pairing: each "cell" = a unique (zero_positions, nonzero_signs) pattern

    # Simpler: use zero-count + signature
    # Actually: for each n in range, its balanced-ternary digits give a "cell address"
    # and within each cell we get exactly one integer. So "cell sums" at the point
    # level are just individual μ values. That's too granular.

    # Grouping by zero-count is what we did in (B). Let's also group by
    # (zero_positions) alone — i.e., which digits are 0, ignoring signs.
    # Each such group holds 2^(# nonzero positions) integers.

    groups = {}  # key = frozenset of zero positions → list of n
    for n in range(1, max_val + 1):
        digits = to_balanced_ternary(n, N_DIGITS)
        zero_positions = frozenset(i for i, d in enumerate(digits) if d == 0)
        groups.setdefault(zero_positions, []).append(n)

    # For each group, compute sum of μ
    cell_sums = []
    for zpos, ns in groups.items():
        s = sum(mu[n] for n in ns)
        cell_sums.append((len(ns), len(zpos), s, abs(s)))

    cell_sums.sort(key=lambda t: -t[3])  # by |sum| desc

    n_cells = len(cell_sums)
    total_sum = sum(s for _, _, s, _ in cell_sums)
    max_abs = max(abs(s) for _, _, s, _ in cell_sums)
    avg_abs = sum(abs(s) for _, _, s, _ in cell_sums) / n_cells
    sum_of_abs = sum(abs(s) for _, _, s, _ in cell_sums)

    print(f"  Number of distinct cells (grouped by zero-position pattern): {n_cells}")
    print(f"  Total M(x) from all cells: {total_sum}")
    print(f"  Max |cell sum|: {max_abs}")
    print(f"  Average |cell sum|: {avg_abs:.2f}")
    print(f"  Sum of |cell sums|: {sum_of_abs}  (this is an upper bound on |M(x)|)")
    print()
    print(f"  Top 10 cells by |sum|:")
    print(f"    {'zero positions':<25}{'size':<10}{'sum':<10}")
    for size, nz, s, abs_s in cell_sums[:10]:
        # we don't have zpos back, fix that
        pass
    # redo sorted with zpos
    cell_info = []
    for zpos, ns in groups.items():
        s = sum(mu[n] for n in ns)
        cell_info.append((tuple(sorted(zpos)), len(ns), s))
    cell_info.sort(key=lambda t: -abs(t[2]))
    for zpos, size, s in cell_info[:10]:
        zp_str = str(zpos) if zpos else "()"
        print(f"    {zp_str:<25}{size:<10}{s:<10}")


def main():
    N = 1_000_000
    print(f"Sieving μ up to {N:,}...")
    mu = mobius_sieve(N)
    print("  done.")

    M_at_lattice_boundaries(mu, 13)
    cell_sum_distribution(mu, 12)


if __name__ == "__main__":
    main()
