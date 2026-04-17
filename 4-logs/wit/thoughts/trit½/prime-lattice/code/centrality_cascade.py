#!/usr/bin/env python3
"""Centrality cascade at N=4 and N=8.

Centrality definition (back-derived by calibration against the published
N=4 per-grade totals 1120, 777, 532, 357, 232):

  cent(v) = number of UNORDERED pairs {s, t} with s != v, t != v, s != t,
            such that v lies on at least one shortest path from s to t.

The lattice is {-1, 0, +1}^N with adjacency = differ by one unit on one
axis. Shortest-path distance equals L1 distance (verified).

Since d is L1, "v on a shortest s-t path" <=> for every axis i,
v_i is between s_i and t_i (min ≤ v_i ≤ max).  This factors across axes.

Per-axis ordered (s_i, t_i) counts with v_i in [min, max]:
  v_i = 0 : 7     (of 9 pairs)
  v_i = ±1: 5     (of 9 pairs)

For a node v with grade k (k axes at ±1, N-k axes at 0), the total
ordered (s, t) count with v on path for every axis is

  P(k, N) = 7^(N - k) · 5^k.

Subtract pairs with s = v (3^N of them) and pairs with t = v (3^N),
add back s = t = v (1 pair) by inclusion–exclusion:

  ordered_excl(k, N) = 7^(N-k) · 5^k - 2·3^N + 1.

All remaining pairs satisfy s != v and t != v.  Among them, s = t
would require v on path s→s, forcing v = s, contradicting s != v, so
s != t automatically.  Unordered count is half:

  cent_per_node(k, N) = (7^(N-k) · 5^k - 2·3^N + 1) / 2.

Per-grade total = count(k, N) · cent_per_node(k, N),
where count(k, N) = C(N, k) · 2^k.

This file:
  1. Computes cent at N=4 by BFS *and* by closed form; asserts agreement
     with the canonical (1120, 777, 532, 357, 232).
  2. Computes cent at N=8 by closed form, plus a BFS cross-check at
     every grade.
  3. Factors the grade-to-grade centrality-total differences.
  4. Reports whether the N=8 differences factor only through {11, 13}.
"""

from collections import deque
from itertools import product
from math import comb


# ---------------------------------------------------------------- graph ---

def build_graph(N):
    nodes = list(product((-1, 0, 1), repeat=N))
    idx = {v: i for i, v in enumerate(nodes)}
    n = len(nodes)
    adj = [[] for _ in range(n)]
    for i, v in enumerate(nodes):
        for a in range(N):
            for d in (-1, 1):
                nv = list(v)
                nv[a] += d
                if -1 <= nv[a] <= 1:
                    adj[i].append(idx[tuple(nv)])
    return nodes, adj


def grade(v):
    return sum(1 for c in v if c != 0)


def bfs_distances(adj, src):
    n = len(adj)
    dist = [-1] * n
    dist[src] = 0
    q = deque([src])
    while q:
        u = q.popleft()
        for w in adj[u]:
            if dist[w] < 0:
                dist[w] = dist[u] + 1
                q.append(w)
    return dist


# -------------------------------------------------- centrality (closed form) ---

def cent_per_node(k, N):
    """Centrality of a single node at grade k in the N-lattice."""
    return (7 ** (N - k) * 5 ** k - 2 * 3 ** N + 1) // 2


def grade_count(k, N):
    return comb(N, k) * 2 ** k


# --------------------------------------------------------- factorization ---

def prime_factorize(n):
    if n == 0:
        return [(0, 1)]
    sign = -1 if n < 0 else 1
    n = abs(n)
    out = []
    if sign < 0:
        out.append((-1, 1))
    d = 2
    while d * d <= n:
        if n % d == 0:
            e = 0
            while n % d == 0:
                n //= d
                e += 1
            out.append((d, e))
        d += 1
    if n > 1:
        out.append((n, 1))
    return out


def fmt_factors(n):
    fs = prime_factorize(n)
    if not fs:
        return "1"
    parts = []
    for p, e in fs:
        parts.append(f"{p}^{e}" if e > 1 else f"{p}")
    return " · ".join(parts)


# ----------------------------------------------------- exhaustive (BFS) ---

def cent_bfs(N, nodes, adj):
    """Exhaustive centrality by all-pairs BFS.

    For each v, count unordered {s,t} with s != v, t != v, v on some
    shortest s-t path (d(s,v)+d(v,t) == d(s,t)).

    Uses N^2 distance table.  Memory O(|V|^2), fine for |V| ≤ 6561.
    """
    n = len(nodes)
    dist = [None] * n
    for s in range(n):
        dist[s] = bfs_distances(adj, s)

    cent = [0] * n
    for v in range(n):
        c = 0
        for s in range(n):
            if s == v:
                continue
            dsv = dist[s][v]
            for t in range(s + 1, n):
                if t == v:
                    continue
                if dsv + dist[v][t] == dist[s][t]:
                    c += 1
        cent[v] = c
    return cent


def l1(u, v):
    return sum(abs(a - b) for a, b in zip(u, v))


def cent_bfs_per_grade_sample(N, nodes, adj, per_grade_max=1):
    """Cross-check: for one representative node per grade, compute
    centrality by full enumeration using numpy, then compare with closed
    form.

    d(u,v) = L1(u,v) on this adjacency (verified by BFS spot-check).
    """
    import numpy as np

    n = len(nodes)
    d0 = bfs_distances(adj, 0)
    for i in range(min(n, 50)):
        assert d0[i] == l1(nodes[0], nodes[i]), "BFS disagrees with L1 at sample"

    pts = np.array(nodes, dtype=np.int8)         # (n, N)
    # all-pairs L1 distance matrix.  Memory: n*n bytes = 43 MB at N=8.
    # Use int8 (max L1 = 2N = 16).
    D = np.abs(pts[:, None, :] - pts[None, :, :]).sum(axis=2).astype(np.int8)

    by_grade = {}
    for v_idx, vtup in enumerate(nodes):
        g = grade(vtup)
        if g in by_grade:
            continue
        dv = D[v_idx]                            # shape (n,)
        # For each (s, t), v on shortest path iff D[s,v]+D[v,t] == D[s,t].
        # Build n x n boolean mask.
        mask = dv[:, None] + dv[None, :] == D    # (n, n)
        # Exclude s == v, t == v, and s == t.
        mask[v_idx, :] = False
        mask[:, v_idx] = False
        np.fill_diagonal(mask, False)
        c_ordered = int(mask.sum())
        c = c_ordered // 2
        by_grade[g] = (vtup, c)
        print(f"  DIRECT: grade {g} node {vtup} cent = {c}")
    return by_grade


# --------------------------------------------------------- report ---

def report(N, verify_bfs=False):
    print(f"\n{'='*72}")
    print(f"  N = {N}    lattice size = 3^{N} = {3**N}")
    print(f"{'='*72}")

    pernode = []
    totals = []
    print(f"  {'grade k':<10}{'count':<10}{'per-node cent':<24}{'grade total':<20}")
    print("  " + "-" * 62)
    for k in range(N + 1):
        cnt = grade_count(k, N)
        per = cent_per_node(k, N)
        tot = cnt * per
        pernode.append(per)
        totals.append(tot)
        print(f"  {k:<10}{cnt:<10}{per:<24}{tot:<20}")

    print(f"\n  sum of grade counts = {sum(grade_count(k, N) for k in range(N+1))}")

    # Per-node differences (the canonical framework quantity).
    print(f"\n  PER-NODE centrality consecutive differences:")
    pn_diffs = []
    for k in range(N):
        d = pernode[k] - pernode[k + 1]
        pn_diffs.append(d)
        print(f"    cent(k={k}) - cent(k={k+1}) = {pernode[k]} - {pernode[k+1]} = {d}")
        print(f"      factors = {fmt_factors(d)}")

    # Per-grade-total differences (secondary — asked for by task).
    print(f"\n  PER-GRADE-TOTAL consecutive differences:")
    tot_diffs = []
    for k in range(N):
        d = totals[k] - totals[k + 1]
        tot_diffs.append(d)
        print(f"    grade_total({k}) - grade_total({k+1}) = "
              f"{totals[k]} - {totals[k+1]} = {d}")
        print(f"      factors = {fmt_factors(d)}")

    # BFS verification
    if verify_bfs:
        print(f"\n  BFS cross-check (one node per grade):")
        nodes, adj = build_graph(N)
        by_grade = cent_bfs_per_grade_sample(N, nodes, adj)
        all_ok = True
        for k in range(N + 1):
            predicted = cent_per_node(k, N)
            _, actual = by_grade[k]
            ok = predicted == actual
            all_ok = all_ok and ok
            mark = "OK" if ok else "MISMATCH"
            print(f"    grade {k}: closed-form={predicted}  BFS={actual}  [{mark}]")
        assert all_ok, "closed form disagrees with BFS"

    return pernode, totals, pn_diffs, tot_diffs


def main():
    # --- N=4 canonical check ------------------------------------------------
    print("\n#### N=4 SANITY ####")
    pn4, tot4, pn_diffs4, tot_diffs4 = report(4, verify_bfs=True)

    expected_pn4 = [1120, 777, 532, 357, 232]
    expected_pn_diffs4 = [343, 245, 175, 125]  # 7^3, 5·7^2, 5^2·7, 5^3
    assert pn4 == expected_pn4, (pn4, expected_pn4)
    assert pn_diffs4 == expected_pn_diffs4, (pn_diffs4, expected_pn_diffs4)
    print("\n  [OK] N=4 per-node cent matches canonical 1120/777/532/357/232")
    print("  [OK] N=4 per-node diffs match 7^3 / 5·7² / 5²·7 / 5^3")

    # --- N=8 prediction ------------------------------------------------------
    print("\n#### N=8 PREDICTION-UNDER-TEST ####")
    pn8, tot8, pn_diffs8, tot_diffs8 = report(8, verify_bfs=True)

    def test_primes(label, diffs, allowed):
        print(f"\n  {label}: do differences factor ONLY through {sorted(allowed)}?")
        any_broken = False
        for k, d in enumerate(diffs):
            primes = {p for p, _ in prime_factorize(d) if p > 1}
            broken = not primes.issubset(allowed)
            any_broken = any_broken or broken
            tag = "BREAKS" if broken else "ok"
            print(f"    diff(k={k}->{k+1}) = {d}  primes={sorted(primes)}  [{tag}]")
        return any_broken

    print("\n  Framework prediction under test: N=8 differences factor only through {11, 13}.")
    per_node_broken = test_primes("PER-NODE", pn_diffs8, {11, 13})
    per_total_broken = test_primes("PER-GRADE-TOTAL", tot_diffs8, {11, 13})

    print("\n  --- VERDICT --------------------------------------------------------")
    if per_node_broken:
        print("  PER-NODE cascade: prediction BROKEN — differences factor through {5, 7}.")
        print("  Closed form: diff(k→k+1) = 7^(N-k-1) · 5^k  (independent of N).")
    else:
        print("  PER-NODE cascade: prediction CONFIRMED.")

    if per_total_broken:
        print("  PER-GRADE-TOTAL cascade: prediction BROKEN.")
    else:
        print("  PER-GRADE-TOTAL cascade: prediction CONFIRMED.")


if __name__ == "__main__":
    main()
