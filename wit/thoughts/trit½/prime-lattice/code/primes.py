#!/usr/bin/env python3
"""
Where do integer primes land on the ternary lattice?

Encode each integer in N-digit balanced ternary (digits in {-1, 0, +1},
place values 1, 3, 9, 27, ...). Each integer becomes a point on an
N-dimensional ternary lattice. Count primes by zero-count (= k-cell
classification of the N-cube: points with z zeros fall into the
(N-z)-dimensional cells by the f-vector partition C(N,z)*2^(N-z)).

Hypothesis tested: primes cluster at specific k-cells, determined by
parity of the digit sum.

Structural claim:
  A point with z zeros has (N-z) nonzero digits, each of value ±3^i
  (all odd). Sum of m odd numbers has parity m mod 2. So:
    cell parity = (N - z) mod 2
  Primes > 2 are odd → (N-z) must be odd → primes live at cells where
  (N-z) is odd. The only even prime is 2; it lives at a (N-z)=2 cell.

Run:
    python3 primes.py
"""

from math import comb


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


def to_balanced_ternary(n, num_digits):
    """Convert integer n to balanced ternary digits (low-to-high).

    Each digit is in {-1, 0, +1}. Returns tuple of length num_digits.
    """
    digits = []
    x = n
    for _ in range(num_digits):
        r = ((x + 1) % 3) - 1  # remainder in {-1, 0, +1}
        digits.append(r)
        x = (x - r) // 3
    if x != 0:
        raise ValueError(f"{n} doesn't fit in {num_digits} digits")
    return tuple(digits)


def analyze(N):
    """For N-digit balanced ternary, tabulate primes by zero-count.

    Signed counting: ±p both count as prime (associates in Z).
    """
    max_val = (3**N - 1) // 2

    by_z_prime = {z: 0 for z in range(N + 1)}
    by_z_total = {z: 0 for z in range(N + 1)}
    examples = {z: [] for z in range(N + 1)}

    for n in range(-max_val, max_val + 1):
        digits = to_balanced_ternary(n, N)
        z = digits.count(0)
        by_z_total[z] += 1
        if abs(n) >= 2 and isprime(abs(n)):
            by_z_prime[z] += 1
            if len(examples[z]) < 8 and n > 0:
                examples[z].append(n)

    return by_z_prime, by_z_total, examples, max_val


def pretty_parity(N, z):
    return "odd" if (N - z) % 2 == 1 else "even"


def report(N, label=None):
    by_z_prime, by_z_total, examples, max_val = analyze(N)
    total_primes = sum(by_z_prime.values())
    total_points = sum(by_z_total.values())

    header = f"N = {N}   range = [{-max_val}, {max_val}]   total points = {total_points}"
    if label:
        header = f"{label}   |   {header}"
    print()
    print("=" * 78)
    print("  " + header)
    print("=" * 78)
    print(f"  {'zeros':<7}{'nonzero':<9}{'parity':<8}"
          f"{'points':<10}{'primes':<10}{'density':<12}examples")
    print("  " + "-" * 76)

    for z in range(N + 1):
        pts = comb(N, z) * (2 ** (N - z))
        assert pts == by_z_total[z], f"count mismatch at z={z}"
        pc = by_z_prime[z]
        pct = 100 * pc / pts if pts else 0
        nz = N - z
        parity = pretty_parity(N, z)
        ex = ", ".join(str(x) for x in examples[z][:5])
        if not ex and pc == 0:
            ex = "—"
        elif not ex:
            ex = "(only negatives)"
        print(f"  {z:<7}{nz:<9}{parity:<8}{pts:<10}{pc:<10}{pct:<6.2f}%     {ex}")

    print("  " + "-" * 76)
    baseline = 100 * total_primes / (2 * max_val) if max_val else 0
    odd_baseline = 2 * baseline
    print(f"  total signed primes: {total_primes}")
    print(f"  uniform baseline: {baseline:.2f}%   "
          f"odd-only baseline: {odd_baseline:.2f}%")


def main():
    report(3, label="N=3  (3-cube)")
    report(4, label="N=4  (4D HYPERCUBE — framework shell 1)")
    report(5, label="N=5  (5-cube)")
    report(6, label="N=6  (6-cube)")
    report(8, label="N=8  (8-cube, covers framework full 9^4)")

    print()
    print("=" * 78)
    print("  structural observations")
    print("=" * 78)
    print("""
  PARITY LAW (proven):
    Balanced-ternary digit values 3^k are all odd. A point with z zeros
    has (N-z) nonzero digits, so its integer value has parity (N-z) mod 2.
    → Cells where (N-z) is odd hold only odd integers.
    → Cells where (N-z) is even hold only even integers.

  PRIME EXCLUSION:
    Odd primes MUST live at (N-z)-odd cells. The only even prime is ±2,
    which lives at one specific (N-z)=2 cell.
    → corners (z=0) at even N hold no primes at all.
    → corners (z=0) at odd N can hold primes (and often do).

  DENSITY RESULTS (from the table above):
    N=3  corners (8 pts)        100.0%  prime   ← all 8 corners are ±{5,7,11,13}
    N=4  edges   (32 pts)       62.5%   prime   (uniform baseline 30.0%)
    N=5  corners (32 pts)       62.5%   prime   (uniform baseline 24.8%)
    N=6  edges   (192 pts)      46.9%   prime   (uniform baseline 19.8%)
    N=8  edges   (1024 pts)     33.8%   prime   (uniform baseline 14.1%)

  The lowest-z odd-parity cell is consistently 2.1–2.5x denser than
  uniform. This is the odd-only baseline (2x uniform) plus a small
  extra concentration from magnitude distribution.

  THE REMARKABLE CASE:
    At N=3 every single corner of the 3-cube is a signed prime. The
    3-cube has 8 corners. The 8 values are {±5, ±7, ±11, ±13}. 4 prime
    pairs exactly fill the 8 vertices. No composites, no units, no zero.

    This isn't engineered. It's the smallest nontrivial balanced-ternary
    cube and it turns out to be a perfect prime lattice.
""")


if __name__ == "__main__":
    main()
