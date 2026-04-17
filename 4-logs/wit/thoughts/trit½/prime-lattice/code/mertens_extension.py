#!/usr/bin/env python3
"""
Faster segmented Mobius sieve using numpy.
Avoids per-prime division loops by using a dedicated "remaining" array
and doing a single division pass per prime after flipping sign.
"""
import time
import numpy as np
from math import isqrt


def build_primes(n):
    sieve = np.ones(n + 1, dtype=bool)
    sieve[:2] = False
    for p in range(2, isqrt(n) + 1):
        if sieve[p]:
            sieve[p*p::p] = False
    return np.flatnonzero(sieve).astype(np.int64)


def segmented_mertens(limit, checkpoints=None, segment=50_000_000, verbose=True):
    checkpoints = sorted(set(int(c) for c in (checkpoints or []) if c <= limit))

    root = isqrt(limit)
    primes = build_primes(root)
    if verbose:
        print(f"  primes up to sqrt({limit:,}) = {root:,}: {len(primes):,} primes", flush=True)

    M = 0
    results = {}
    max_ratio_sq = 0.0
    argmax_x = 0
    argmax_M = 0
    ck_idx = 0
    n_cks = len(checkpoints)

    lo = 1
    t0 = time.time()
    last_print = t0
    while lo <= limit:
        hi = min(lo + segment, limit + 1)
        size = hi - lo

        # Segmented linear mobius sieve:
        #  remaining[i]: n = lo + i, with all divisors <= root removed
        #  sign[i]: product of (-1) for each distinct prime factor dividing n
        #  is_sqfree[i]: False if any p^2 | n
        remaining = np.arange(lo, hi, dtype=np.int64)
        sign = np.ones(size, dtype=np.int8)
        is_sqfree = np.ones(size, dtype=bool)

        for p in primes:
            p = int(p)
            p2 = p * p
            if p > hi - 1:
                break
            # Mark squarefree violations
            if p2 <= hi - 1:
                start = ((lo + p2 - 1) // p2) * p2
                if start < hi:
                    is_sqfree[start - lo : size : p2] = False
            # Flip sign for multiples of p; also divide remaining
            start = ((lo + p - 1) // p) * p
            if start >= hi:
                continue
            i0 = start - lo
            sign[i0:size:p] = -sign[i0:size:p]
            # Divide remaining[i] by p^(v_p) efficiently: divide by p
            # repeatedly, but only at indices that are still multiples of p.
            # Use slicing with step p first, then catch p^2, p^3, etc.
            # Iterate while any in the strided slice is divisible by p.
            stride_idx = slice(i0, size, p)
            rem_slice = remaining[stride_idx]
            rem_slice //= p
            remaining[stride_idx] = rem_slice
            # Higher powers: only at multiples of p^2, p^3, ...
            pk = p2
            while pk <= hi - 1:
                start_k = ((lo + pk - 1) // pk) * pk
                if start_k >= hi:
                    break
                ik = start_k - lo
                sub = slice(ik, size, pk)
                rem_sub = remaining[sub]
                # Those that are still multiples of p (after earlier single
                # division) get further divided.
                mask = (rem_sub % p == 0)
                if mask.any():
                    rem_sub_masked = rem_sub.copy()
                    rem_sub_masked[mask] //= p
                    remaining[sub] = rem_sub_masked
                    pk *= p
                else:
                    break

        # Large prime factor: if remaining > 1, it's a prime > root,
        # appearing exactly once (since p > sqrt(n) means at most once).
        large_mask = remaining > 1
        sign[large_mask] = -sign[large_mask]

        mu = np.where(is_sqfree, sign.astype(np.int32), 0)

        if lo == 1:
            mu[0] = 1  # μ(1)=1

        cum = np.cumsum(mu, dtype=np.int64) + M

        # Track max M^2/x on x >= 100
        ns = np.arange(lo, hi, dtype=np.int64)
        start_idx = max(0, 100 - lo)
        if start_idx < size:
            cum_v = cum[start_idx:]
            ns_v = ns[start_idx:]
            sq_ratio = (cum_v.astype(np.float64) ** 2) / ns_v.astype(np.float64)
            imax = int(np.argmax(sq_ratio))
            if sq_ratio[imax] > max_ratio_sq:
                max_ratio_sq = float(sq_ratio[imax])
                argmax_x = int(ns_v[imax])
                argmax_M = int(cum_v[imax])

        while ck_idx < n_cks and checkpoints[ck_idx] < hi:
            cp = checkpoints[ck_idx]
            if cp >= lo:
                M_cp = int(cum[cp - lo])
                results[cp] = {
                    'M': M_cp,
                    'M_sq_over_x': (M_cp * M_cp) / cp,
                }
            ck_idx += 1

        M = int(cum[-1])
        lo = hi

        now = time.time()
        if verbose and now - last_print > 15:
            pct = 100 * (lo - 1) / limit
            print(f"  ... {lo-1:>15,} / {limit:,} ({pct:.1f}%)  "
                  f"M={M:>10}  max_ratio_sq={max_ratio_sq:.4f}  "
                  f"elapsed={now-t0:.1f}s", flush=True)
            last_print = now

    results['_final_M'] = M
    results['_max_ratio_sq'] = max_ratio_sq
    results['_argmax_x'] = argmax_x
    results['_argmax_M'] = argmax_M
    results['_elapsed'] = time.time() - t0
    return results


def main():
    import sys
    max_N = int(sys.argv[1]) if len(sys.argv) > 1 else 20

    shells = {N: (3**N - 1) // 2 for N in range(3, max_N + 1)}

    between_shell_xs = []
    for k in range(3, 11):
        base = 10**k
        if base > shells[max_N]:
            break
        for offset in [0, 1, 7, 23, 99, 101, 547, 1009, 9973, 99991, 999983]:
            x = base + offset
            if 100 <= x <= shells[max_N]:
                between_shell_xs.append(x)
        if 100 <= base - 1 <= shells[max_N]:
            between_shell_xs.append(base - 1)
        if 100 <= base + base // 2 <= shells[max_N]:
            between_shell_xs.append(base + base // 2)

    for N in range(3, max_N):
        a = shells[N]
        b = shells[N+1]
        for fn, fd in [(1, 4), (1, 2), (3, 4)]:
            x = a + (b - a) * fn // fd
            if a < x < b:
                between_shell_xs.append(x)

    all_cps = sorted(set(list(shells.values()) + between_shell_xs))
    limit = max(all_cps)

    print(f"# limit = {limit:,} (max N = {max_N})")
    print(f"# checkpoints: {len(all_cps)}")
    print(flush=True)

    results = segmented_mertens(limit, all_cps, segment=50_000_000)
    print(f"\n# elapsed: {results['_elapsed']:.1f}s\n", flush=True)

    # Task A
    print("=" * 90)
    print("TASK A — Shell boundaries")
    print("=" * 90)
    print(f"{'N':>3}  {'x_N':>15}  {'M(x_N)':>12}  {'M^2/x_N':>10}  {'bound?':>7}")
    print("-" * 90)
    ok_count = 0
    for N in sorted(shells):
        x = shells[N]
        if x in results:
            r = results[x]
            M = r['M']
            ok = (M * M) < x
            print(f"{N:>3}  {x:>15,}  {M:>12}  {r['M_sq_over_x']:>10.6f}  "
                  f"{'YES' if ok else 'NO':>7}")
            if ok:
                ok_count += 1
    print(f"\nShell bounds holding: {ok_count}/{len(shells)}")

    # Task B
    print()
    print("=" * 90)
    print("TASK B — Between-shell ratio M(x)^2 / x")
    print("=" * 90)
    print(f"{'x':>15}  {'M(x)':>12}  {'M^2/x':>12}")
    print("-" * 60)
    max_bet = 0.0
    max_bet_x = 0
    exceedances = []
    for x in sorted(between_shell_xs):
        if x in results:
            r = results[x]
            ratio = r['M_sq_over_x']
            if ratio > max_bet:
                max_bet = ratio
                max_bet_x = x
            if ratio >= 1.0:
                exceedances.append((x, r['M'], ratio))
            # Print just a subset to keep output readable
            print(f"{x:>15,}  {r['M']:>12}  {ratio:>12.6f}")

    print()
    print(f"Max between-shell M^2/x: {max_bet:.6f} at x={max_bet_x:,}")
    print(f"Exceedances (M^2/x >= 1): {len(exceedances)}")
    for x, M, r in exceedances[:10]:
        print(f"  x={x:,}  M={M}  ratio={r:.4f}")

    print()
    print("=" * 90)
    print(f"GLOBAL max M^2/x on [100, {limit:,}] = {results['_max_ratio_sq']:.6f} "
          f"at x={results['_argmax_x']:,} (M={results['_argmax_M']})")
    print("=" * 90)


if __name__ == '__main__':
    main()
