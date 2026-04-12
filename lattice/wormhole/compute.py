#!/usr/bin/env python3
# wormhole/compute.py
#
# Test: is origin [0,0,0,0] the topological throat through which all
# shortest walks between non-adjacent lattice points must pass?
#
# Integer only. Exhaustive. No floats. No sampling.
#
# Adjacency: two points A, B in the 81-point ternary lattice {-1,0,+1}^4
# are adjacent iff they differ by exactly +/-1 in exactly one coordinate
# AND the change stays within {-1,0,+1}.
#
# Under this definition, a point with k committed axes (|coord|==1) has
# degree (8 - k): k "back-toward-0" edges on committed axes, 2*(4-k) "out"
# edges on free axes.

from itertools import product, combinations
from collections import deque, defaultdict


# ----- 1. enumerate points ----------------------------------------------

VALUES = (-1, 0, 1)
POINTS = list(product(VALUES, repeat=4))
assert len(POINTS) == 81

ORIGIN = (0, 0, 0, 0)
INDEX = {p: i for i, p in enumerate(POINTS)}


def committed(p):
    """Number of coordinates with |value|==1 (= 'grade', hypercube k)."""
    return sum(1 for c in p if c != 0)


# ----- 2. adjacency -----------------------------------------------------

def neighbors(p):
    out = []
    for axis in range(4):
        for delta in (-1, 1):
            new_val = p[axis] + delta
            if new_val in (-1, 0, 1):
                q = list(p)
                q[axis] = new_val
                out.append(tuple(q))
    return out


ADJ = {p: tuple(neighbors(p)) for p in POINTS}

# --- verify degree distribution -----------------------------------------

deg_by_grade = defaultdict(list)
for p in POINTS:
    deg_by_grade[committed(p)].append(len(ADJ[p]))

for k, degs in sorted(deg_by_grade.items()):
    assert all(d == 8 - k for d in degs), (k, degs)

# grade counts should be C(4,k)*2^k: 1, 8, 24, 32, 16
grade_counts = {k: len(v) for k, v in deg_by_grade.items()}
assert grade_counts == {0: 1, 1: 8, 2: 24, 3: 32, 4: 16}

assert len(ADJ[ORIGIN]) == 8
assert len(ADJ[(1, 1, 1, 1)]) == 4
assert len(ADJ[(1, 0, 0, 0)]) == 7

# total undirected edges
edge_sum = sum(len(v) for v in ADJ.values())
assert edge_sum % 2 == 0
TOTAL_EDGES = edge_sum // 2

# closed form: sum over k of C(4,k)*2^k*(8-k) / 2
closed = sum(grade_counts[k] * (8 - k) for k in range(5)) // 2
assert closed == TOTAL_EDGES


# ----- 3. BFS + predecessor DAG for shortest-path enumeration -----------

def bfs_preds(src):
    """Return (dist, preds) where preds[v] = set of parents on shortest
    paths from src to v. Distances are integers."""
    dist = {src: 0}
    preds = {src: set()}
    q = deque([src])
    while q:
        u = q.popleft()
        for v in ADJ[u]:
            if v not in dist:
                dist[v] = dist[u] + 1
                preds[v] = {u}
                q.append(v)
            elif dist[v] == dist[u] + 1:
                preds[v].add(u)
    return dist, preds


def l1(a, b):
    return sum(abs(a[i] - b[i]) for i in range(4))


def count_shortest_paths(src, preds):
    """Count number of shortest paths from src to every other node."""
    # topological order by distance (BFS levels are already topo).
    dist = {src: 0}
    for v in preds:
        pass
    # recount via preds sizes: paths[v] = sum(paths[u] for u in preds[v])
    # order vertices by distance:
    # we need dist to order; compute from preds DAG via BFS again isn't great;
    # but we have preds so we can derive distances by re-BFS.
    # Simpler: BFS once here.
    d = {src: 0}
    q = deque([src])
    order = [src]
    while q:
        u = q.popleft()
        for v in ADJ[u]:
            if v not in d:
                d[v] = d[u] + 1
                q.append(v)
                order.append(v)
    paths = {src: 1}
    for v in order:
        if v == src:
            continue
        paths[v] = sum(paths[u] for u in preds[v])
    return paths, d


def nodes_on_any_shortest_path(src, dst, preds_from_src):
    """Return set of nodes lying on AT LEAST one shortest path src->dst.
    Walks the preds DAG backward from dst."""
    if dst not in preds_from_src:
        return set()
    seen = set()
    stack = [dst]
    while stack:
        u = stack.pop()
        if u in seen:
            continue
        seen.add(u)
        for p in preds_from_src[u]:
            stack.append(p)
    return seen


def nodes_on_every_shortest_path(src, dst, preds_from_src, preds_from_dst):
    """A vertex v lies on EVERY shortest path src->dst iff
    d(src,v) + d(v,dst) == d(src,dst) AND
    #paths(src->v) * #paths(v->dst) == #paths(src->dst).
    We already have the 'on at least one' set via the preds DAG.
    """
    # easier: v is on every shortest path iff removing v disconnects all
    # shortest src->dst paths. Use path counts.
    paths_src, d_src = count_shortest_paths(src, preds_from_src)
    paths_dst, d_dst = count_shortest_paths(dst, preds_from_dst)
    total = paths_src[dst]
    D = d_src[dst]
    required = set()
    on_any = nodes_on_any_shortest_path(src, dst, preds_from_src)
    for v in on_any:
        if d_src[v] + d_dst[v] != D:
            continue
        if paths_src[v] * paths_dst[v] == total:
            required.add(v)
    return required, on_any, total, D


# ----- 4. precompute BFS from every source -----------------------------

PREDS = {}
DIST = {}
PATHCOUNT = {}   # PATHCOUNT[src][v] = # shortest paths src -> v
for src in POINTS:
    d, pr = bfs_preds(src)
    PREDS[src] = pr
    DIST[src] = d
    pc, _ = count_shortest_paths(src, pr)
    PATHCOUNT[src] = pc

# verify L1 equals graph distance everywhere (should: unit steps in the
# {-1,0,+1} box never force a detour).
for a in POINTS:
    for b in POINTS:
        assert DIST[a][b] == l1(a, b), (a, b, DIST[a][b], l1(a, b))


def classify(a, b):
    """Return ('REQUIRED'|'OPTIONAL'|'EXCLUDED', npaths, dist) for the
    question: does origin appear as an INTERMEDIATE vertex on shortest
    paths from a to b? Assumes a,b != origin and a != b."""
    D = DIST[a][b]
    total = PATHCOUNT[a][b]
    # origin on at least one shortest path?
    d_ao = DIST[a][ORIGIN]
    d_ob = DIST[ORIGIN][b]
    if d_ao + d_ob != D:
        return 'EXCLUDED', total, D
    # origin lies on at least one shortest path.
    through = PATHCOUNT[a][ORIGIN] * PATHCOUNT[ORIGIN][b]
    if through == total:
        return 'REQUIRED', total, D
    else:
        return 'OPTIONAL', total, D


# ----- 5. classify all non-origin unordered pairs ----------------------

non_origin_points = [p for p in POINTS if p != ORIGIN]
assert len(non_origin_points) == 80

required_pairs = []
optional_pairs = []
excluded_pairs = []

for a, b in combinations(non_origin_points, 2):
    cls, npaths, D = classify(a, b)
    if cls == 'REQUIRED':
        required_pairs.append((a, b, npaths, D))
    elif cls == 'OPTIONAL':
        optional_pairs.append((a, b, npaths, D))
    else:
        excluded_pairs.append((a, b, npaths, D))

R = len(required_pairs)
O = len(optional_pairs)
E = len(excluded_pairs)
TOTAL_PAIRS = R + O + E
assert TOTAL_PAIRS == 80 * 79 // 2  # = 3160


# ----- 6. centrality for every point -----------------------------------

def centrality(P):
    """Count unordered pairs {A,B} with P not in {A,B} such that P lies
    on AT LEAST one shortest path A->B."""
    count = 0
    for a, b in combinations(POINTS, 2):
        if P == a or P == b:
            continue
        D = DIST[a][b]
        if DIST[a][P] + DIST[P][b] == D:
            count += 1
    return count


CENT = {p: centrality(p) for p in POINTS}

max_c = max(CENT.values())
top_points = [p for p, c in CENT.items() if c == max_c]

# rank of origin (1 = highest)
sorted_cents = sorted(set(CENT.values()), reverse=True)
origin_cent = CENT[ORIGIN]
origin_rank = sorted_cents.index(origin_cent) + 1


# ----- 7. symmetry check: points in same grade class should have equal
# centrality (the hyperoctahedral group B_4 acts transitively on each
# grade-k shell because within {-1,0,+1}^4 a grade-k point is determined
# up to B_4 by its support size and signs, and B_4 = S_4 x {+/-1}^4
# permutes axes and flips signs).

cent_by_grade = defaultdict(set)
for p in POINTS:
    cent_by_grade[committed(p)].add(CENT[p])

for k, vals in sorted(cent_by_grade.items()):
    assert len(vals) == 1, (k, vals)
cent_per_grade = {k: next(iter(vs)) for k, vs in cent_by_grade.items()}


# ----- 8. specific structural probes -----------------------------------

# (a) single-axis opposites: (+e_i, -e_i) for each axis
axis_atoms = [((1,0,0,0),(-1,0,0,0)),
              ((0,1,0,0),(0,-1,0,0)),
              ((0,0,1,0),(0,0,-1,0)),
              ((0,0,0,1),(0,0,0,-1))]
axis_opposite_classes = []
for a, b in axis_atoms:
    cls, n, D = classify(a, b)
    axis_opposite_classes.append((a, b, cls, n, D))

# (b) antipodal corners
corner_pos = (1, 1, 1, 1)
corner_neg = (-1, -1, -1, -1)
cls_cc, n_cc, D_cc = classify(corner_pos, corner_neg)

# (c) cross-axis atoms
cross_a = (1, 0, 0, 0)
cross_b = (0, 1, 0, 0)
cls_ca, n_ca, D_ca = classify(cross_a, cross_b)

# explicit check: for cross-axis atoms, origin should be OPTIONAL (one
# path goes 1,0,0,0 -> 0,0,0,0 -> 0,1,0,0, the other via 1,1,0,0).


# ----- 9. framework-native ratios --------------------------------------

# REQUIRED : TOTAL_PAIRS
# origin centrality : max centrality
# origin centrality : C(80,2)

def gcd(x, y):
    while y:
        x, y = y, x % y
    return x


def reduce_ratio(a, b):
    g = gcd(a, b)
    return (a // g, b // g)


r_ratio = reduce_ratio(R, TOTAL_PAIRS)
o_ratio = reduce_ratio(O, TOTAL_PAIRS)
e_ratio = reduce_ratio(E, TOTAL_PAIRS)

oc_max_ratio = reduce_ratio(origin_cent, max_c)


# ----- 10. print the report --------------------------------------------

def header(s):
    print()
    print("# " + s)


header("LATTICE / EDGES")
print(f"points           = {len(POINTS)}")
print(f"total edges      = {TOTAL_EDGES}")
print(f"grade counts     = {grade_counts}")
print(f"degree by grade  = {{k: 8-k for k in 0..4}} verified")

header("SHORTEST-PATH CLASSIFICATION (origin as intermediate)")
print(f"unordered non-origin pairs = {TOTAL_PAIRS}   (C(80,2)={80*79//2})")
print(f"REQUIRED  = {R}   ratio {r_ratio[0]}/{r_ratio[1]}")
print(f"OPTIONAL  = {O}   ratio {o_ratio[0]}/{o_ratio[1]}")
print(f"EXCLUDED  = {E}   ratio {e_ratio[0]}/{e_ratio[1]}")
print(f"sum       = {R+O+E}")

header("STRUCTURAL PROBES")
print("single-axis opposites (atom, -atom):")
for a, b, cls, n, D in axis_opposite_classes:
    print(f"  {a} <-> {b}   class={cls}  npaths={n}  dist={D}")

print(f"\nantipodal corners {corner_pos} <-> {corner_neg}:")
print(f"  class={cls_cc}  npaths={n_cc}  dist={D_cc}")
print(f"  expected npaths = 8!/(2!^4) = {8*7*6*5*4*3*2*1 // (2*2*2*2)}")
assert n_cc == 2520

print(f"\ncross-axis atoms {cross_a} <-> {cross_b}:")
print(f"  class={cls_ca}  npaths={n_ca}  dist={D_ca}")

header("CENTRALITY (pairs {A,B}, P on at least one shortest path, P notin {A,B})")
print(f"max centrality         = {max_c}")
print(f"points at max          = {len(top_points)}")
print(f"origin centrality      = {origin_cent}")
print(f"origin rank (1 = top)  = {origin_rank}")
print(f"origin/max ratio       = {oc_max_ratio[0]}/{oc_max_ratio[1]}")
print()
print("centrality by grade (symmetry check — one value per grade):")
for k in range(5):
    print(f"  grade {k}  count={grade_counts[k]:>2}  centrality={cent_per_grade[k]}")

header("TOP CENTRALITY POINTS")
for p in top_points[:10]:
    print(f"  {p}  grade={committed(p)}  centrality={CENT[p]}")
print(f"  ...({len(top_points)} total at max)")

header("EXAMPLES PER CLASS")
print("REQUIRED examples:")
for a, b, n, D in required_pairs[:5]:
    print(f"  {a} <-> {b}   npaths={n}  dist={D}")
print("OPTIONAL examples:")
for a, b, n, D in optional_pairs[:5]:
    print(f"  {a} <-> {b}   npaths={n}  dist={D}")
print("EXCLUDED examples:")
for a, b, n, D in excluded_pairs[:5]:
    print(f"  {a} <-> {b}   npaths={n}  dist={D}")

header("DISTRIBUTION OF REQUIRED PAIRS BY (grade_a, grade_b)")
req_by_grades = defaultdict(int)
for a, b, n, D in required_pairs:
    gs = tuple(sorted((committed(a), committed(b))))
    req_by_grades[gs] += 1
for k, v in sorted(req_by_grades.items()):
    print(f"  grades {k} -> {v}")

header("DISTRIBUTION OF ALL NON-ORIGIN PAIRS BY (grade_a, grade_b)")
all_by_grades = defaultdict(int)
for a, b in combinations(non_origin_points, 2):
    gs = tuple(sorted((committed(a), committed(b))))
    all_by_grades[gs] += 1
for k, v in sorted(all_by_grades.items()):
    print(f"  grades {k} -> {v}")

header("FRAMEWORK CONSTANTS CHECK")
FW = {3, 4, 5, 8, 12, 16, 24, 25, 32, 72, 80, 81, 91, 108, 144}
def flag(label, n):
    hit = "FW!" if n in FW else ""
    print(f"  {label} = {n}  {hit}")
flag("REQUIRED", R)
flag("OPTIONAL", O)
flag("EXCLUDED", E)
flag("origin centrality", origin_cent)
flag("max centrality", max_c)
flag("#points at max", len(top_points))
flag("total edges", TOTAL_EDGES)
flag("antipodal-corner shortest paths", n_cc)

# per-grade ratios
header("PER-GRADE CENTRALITY RATIOS")
for k in range(5):
    c = cent_per_grade[k]
    # ratio c / 3160 (all pairs P notin {A,B} is actually C(80,2) only
    # if P is non-origin; in general total "eligible" pairs is C(80,2)
    # when P itself is counted from the 81. Strictly, centrality is out
    # of C(81-1,2) = C(80,2) = 3160.)
    print(f"  grade {k}: {c}/3160  reduced {reduce_ratio(c, 3160)}")
