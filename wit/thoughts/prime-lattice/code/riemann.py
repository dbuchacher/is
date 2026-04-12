#!/usr/bin/env python3
"""
Riemann hypothesis via the compute-first method + framework tools.

RH (one of several equivalents):
   |M(x)| = O(x^{1/2+ε})  where M(x) = Σ_{n≤x} μ(n) is the Mertens function.

Framework observations that motivate the approach:
  1. Möbius μ(n) ∈ {-1, 0, +1} is a NATIVE TRIT-VALUED function on integers.
  2. Mertens M(x) is a walk accumulating trit values.
  3. RH says this walk stays bounded by ~√x.
  4. Our prime compute showed primes are parity-constrained on the lattice —
     does the same parity structure bound μ(n) and hence M(x)?

Compute:
  (A) Sieve μ(n), π(n), M(n), π-Li growth up to N = 1_000_000
  (B) Lattice structure of μ: distribute μ values by balanced-ternary zero-count
  (C) Check the RH-equivalent: is M(x)/√x bounded? How does π(x) - Li(x) grow?
  (D) Sign-sum in each lattice cell: do signs cancel cell-by-cell?

Run:
    python3 riemann.py
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
    """Compute μ(n) for n in 0..N using factorization through smallest prime."""
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


def prime_sieve(N):
    is_prime = [False, False] + [True] * (N - 1)
    for i in range(2, int(N**0.5) + 1):
        if is_prime[i]:
            for j in range(i * i, N + 1, i):
                is_prime[j] = False
    return is_prime


def li_approx(x):
    """Logarithmic integral Li(x) = ∫₂^x dt/ln(t). Trapezoidal."""
    if x < 2:
        return 0
    n = max(2000, int(x) // 5)
    n = min(n, 500_000)
    dx = (x - 2) / n
    s = 0.5 * (1.0 / log(2.0) + 1.0 / log(x))
    t = 2.0 + dx
    for _ in range(1, n):
        s += 1.0 / log(t)
        t += dx
    return s * dx


def to_balanced_ternary(n, num_digits):
    digits = []
    x = n
    for _ in range(num_digits):
        r = ((x + 1) % 3) - 1
        digits.append(r)
        x = (x - r) // 3
    return tuple(digits)


def growth_analysis(mu, is_prime, checkpoints):
    """Tabulate M(x), π(x), Li(x), and growth rates at checkpoints."""
    max_x = max(checkpoints)
    print("\n(A) GROWTH RATES")
    print("=" * 100)
    print(
        f"  {'x':>10}  {'M(x)':>10}  {'|M|/√x':>10}  "
        f"{'π(x)':>10}  {'Li(x)':>11}  {'π−Li':>10}  {'|π−Li|/(√x ln x)':>18}"
    )
    print("  " + "-" * 96)

    # Accumulate
    Mx = 0
    pix = 0
    n_cur = 0
    for x in sorted(checkpoints):
        while n_cur < x:
            n_cur += 1
            Mx += mu[n_cur]
            if is_prime[n_cur]:
                pix += 1
        lix = li_approx(x)
        bound_M = abs(Mx) / sqrt(x)
        err = pix - lix
        bound_pi = abs(err) / (sqrt(x) * log(x))
        print(
            f"  {x:>10}  {Mx:>10}  {bound_M:>10.4f}  "
            f"{pix:>10}  {lix:>11.2f}  {err:>10.2f}  {bound_pi:>18.4f}"
        )
    print("  " + "-" * 96)
    print("  RH ⟺ |M(x)|/√x bounded (or grows slower than any x^ε)")
    print("  RH ⟺ |π(x) − Li(x)| = O(√x ln x), so the last column should stay bounded")


def lattice_structure(mu, N_DIGITS):
    """Distribute μ(n) by balanced-ternary zero-count."""
    max_val = (3**N_DIGITS - 1) // 2
    max_val = min(max_val, len(mu) - 1)

    print(f"\n(B) LATTICE STRUCTURE OF μ(n)")
    print(f"    N = {N_DIGITS}-digit balanced ternary, integers 1..{max_val}")
    print("=" * 100)
    print(
        f"  {'z':<4}{'nonzero':<9}{'parity':<8}{'points':<10}"
        f"{'μ=+1':<10}{'μ=−1':<10}{'μ=0':<10}"
        f"{'sum μ':<10}{'|sum|/√N':<12}"
    )
    print("  " + "-" * 96)

    by_z = {z: {"pos": 0, "neg": 0, "zero": 0, "total": 0} for z in range(N_DIGITS + 1)}

    for n in range(1, max_val + 1):
        digits = to_balanced_ternary(n, N_DIGITS)
        z = digits.count(0)
        by_z[z]["total"] += 1
        if mu[n] == 1:
            by_z[z]["pos"] += 1
        elif mu[n] == -1:
            by_z[z]["neg"] += 1
        else:
            by_z[z]["zero"] += 1

    full_sum_pos = 0
    full_sum_neg = 0
    for z in range(N_DIGITS + 1):
        d = by_z[z]
        tot = d["total"]
        if tot == 0:
            continue
        sum_mu = d["pos"] - d["neg"]
        full_sum_pos += d["pos"]
        full_sum_neg += d["neg"]
        pts = comb(N_DIGITS, z) * (2 ** (N_DIGITS - z))
        nz = N_DIGITS - z
        parity = "odd" if nz % 2 == 1 else "even"
        bound = abs(sum_mu) / sqrt(max(tot, 1))
        print(
            f"  {z:<4}{nz:<9}{parity:<8}{tot:<10}"
            f"{d['pos']:<10}{d['neg']:<10}{d['zero']:<10}"
            f"{sum_mu:<10}{bound:<12.4f}"
        )
    print("  " + "-" * 96)
    print(f"  Total μ=+1: {full_sum_pos}   μ=−1: {full_sum_neg}   "
          f"M({max_val}) = {full_sum_pos - full_sum_neg}")
    print(f"  |M|/√{max_val} = {abs(full_sum_pos - full_sum_neg)/sqrt(max_val):.4f}")


def ratio_test(mu, is_prime, N):
    """Test: is |M(x)/√x| bounded across the range?"""
    print("\n(C) MAX |M(x)|/√x OVER RANGE  (RH predicts: bounded)")
    print("=" * 60)
    Mx = 0
    max_ratio = 0.0
    max_at = 0
    for n in range(1, N + 1):
        Mx += mu[n]
        if n >= 100:
            ratio = abs(Mx) / sqrt(n)
            if ratio > max_ratio:
                max_ratio = ratio
                max_at = n
    print(f"  Max |M(x)|/√x on [100, {N}] = {max_ratio:.4f} at x = {max_at}")
    print(f"  Final M({N}) = {Mx}")
    print(f"  Final |M({N})|/√{N} = {abs(Mx)/sqrt(N):.4f}")

    # The disproven Mertens conjecture was |M(x)| < √x (ratio < 1).
    # Known max ratio up to ~10^13 is around 0.57.
    # If ratio grows unboundedly here, something's off.


def prime_parity_check(mu, N_DIGITS):
    """From the prime compute: cells where (N-z) is even have only μ=0 or ±2 issues.
    Check: does the parity rule for primes translate to structure in μ?"""
    max_val = min((3**N_DIGITS - 1) // 2, len(mu) - 1)

    print(f"\n(D) PARITY CORRELATION")
    print(f"    N = {N_DIGITS}, integers 1..{max_val}")
    print("=" * 90)
    print("    Does 'cell parity determines μ possibilities' hold?")
    print("    Recall: (N-z)-even cells hold even integers, (N-z)-odd cells hold odd.")
    print()

    even_cells_mu = {"pos": 0, "neg": 0, "zero": 0}
    odd_cells_mu = {"pos": 0, "neg": 0, "zero": 0}

    for n in range(1, max_val + 1):
        digits = to_balanced_ternary(n, N_DIGITS)
        z = digits.count(0)
        nz = N_DIGITS - z
        cell_parity = "even" if nz % 2 == 0 else "odd"
        key = "pos" if mu[n] == 1 else ("neg" if mu[n] == -1 else "zero")
        if cell_parity == "even":
            even_cells_mu[key] += 1
        else:
            odd_cells_mu[key] += 1

    total_even = sum(even_cells_mu.values())
    total_odd = sum(odd_cells_mu.values())
    print(f"    Even-parity cells (n even): total {total_even}")
    print(f"      μ=+1: {even_cells_mu['pos']:>8}  ({100*even_cells_mu['pos']/total_even:.2f}%)")
    print(f"      μ=−1: {even_cells_mu['neg']:>8}  ({100*even_cells_mu['neg']/total_even:.2f}%)")
    print(f"      μ= 0: {even_cells_mu['zero']:>8}  ({100*even_cells_mu['zero']/total_even:.2f}%)")
    print(f"      sum:  {even_cells_mu['pos'] - even_cells_mu['neg']:>8}")
    print()
    print(f"    Odd-parity cells (n odd): total {total_odd}")
    print(f"      μ=+1: {odd_cells_mu['pos']:>8}  ({100*odd_cells_mu['pos']/total_odd:.2f}%)")
    print(f"      μ=−1: {odd_cells_mu['neg']:>8}  ({100*odd_cells_mu['neg']/total_odd:.2f}%)")
    print(f"      μ= 0: {odd_cells_mu['zero']:>8}  ({100*odd_cells_mu['zero']/total_odd:.2f}%)")
    print(f"      sum:  {odd_cells_mu['pos'] - odd_cells_mu['neg']:>8}")


def main():
    N = 1_000_000
    print(f"Sieving μ, π up to N = {N:,}...")
    mu = mobius_sieve(N)
    is_prime = prime_sieve(N)
    print("  done.")

    growth_analysis(mu, is_prime, [100, 1000, 10_000, 100_000, 1_000_000])

    # 12-digit BT covers integers up to (3^12-1)/2 = 265720
    lattice_structure(mu, 12)

    ratio_test(mu, is_prime, N)

    prime_parity_check(mu, 12)

    print()
    print("=" * 100)
    print("INTERPRETATION")
    print("=" * 100)
    print("""
  If |M(x)|/√x stays bounded across the range, that's CONSISTENT with RH
  (known: the max ratio up to 10^13 is about 0.57, peaking and declining).

  The lattice-structure table shows how μ distributes across k-cells of
  the balanced-ternary N-cube. Look for: cells where μ sums to near-zero
  vs cells where it doesn't. If cell-level sums are bounded by √(cell
  size), then M(x) = Σ (cell sums) is bounded by Σ √(cell size) ≤ √N ·
  √(# cells) = √N · √(3^N) (loose bound) — not tight enough for RH.

  A TIGHT bound would need: cell sums cancel PAIRWISE (antipodal cells
  have opposite μ sums), or the sum over cells is itself √N-bounded.

  The parity check (D) shows μ distribution across even vs odd cells.
  Even-parity cells hold even integers; all even numbers > 2 have even
  numbers of prime factors OR have a squared 2 as factor. So μ on even
  cells is skewed.
""")


if __name__ == "__main__":
    main()
