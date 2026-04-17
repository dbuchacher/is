#!/usr/bin/env python3
"""
emerge.py — emergence analysis on the speak/ graph.

Reads all roots/*.md files, computes:
  1. Dependency graph (directed: A → B if A's definition references B)
  2. Strongly-connected components (cycles)
  3. Irreducible core (roots nothing points back to in a chain)
  4. Group membership counts (emergent cluster candidates)
  5. Lattice-tagging candidates per rule 7: groups with 3+ members
     spanning 3+ distinct vocabulary categories

Output: data/emergence.md (human-readable report)
"""
import json
import re
from collections import defaultdict
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent
ROOTS_DIR = ROOT / "roots"
DATA_DIR = ROOT / "data"
LINK_RE = re.compile(r"\[([a-zA-Z0-9_-]+)\]\(([a-zA-Z0-9_-]+)\.md\)")


def parse(path):
    text = path.read_text()
    cat = re.search(r"category:\s*(\w+)", text)
    category = cat.group(1) if cat else "?"
    is_seed = "**seed**" in text
    is_deictic = "**deictic**" in text
    def_match = re.search(r"## Definition\s*\n(.*?)(?=\n## |\Z)",
                           text, re.DOTALL)
    def_body = def_match.group(1) if def_match else ""
    refs = set()
    for m in LINK_RE.finditer(def_body):
        label, tgt = m.groups()
        if label == tgt and (ROOTS_DIR / f"{tgt}.md").exists():
            refs.add(tgt)
    grp_match = re.search(r"## Groups\s*\n(.*?)(?=\n## |\Z)",
                          text, re.DOTALL)
    grp_body = grp_match.group(1) if grp_match else ""
    groups = set()
    for m in LINK_RE.finditer(grp_body):
        label, tgt = m.groups()
        if label == tgt and not (ROOTS_DIR / f"{tgt}.md").exists():
            groups.add(tgt)
    return dict(
        id=path.stem, category=category, is_seed=is_seed,
        is_deictic=is_deictic, refs=refs, groups=groups,
    )


def tarjan_scc(graph):
    index_counter = [0]
    stack, lowlink, index, on_stack = [], {}, {}, {}
    sccs = []

    def strongconnect(node):
        index[node] = index_counter[0]
        lowlink[node] = index_counter[0]
        index_counter[0] += 1
        stack.append(node); on_stack[node] = True
        for nbr in graph.get(node, ()):
            if nbr not in index:
                strongconnect(nbr)
                lowlink[node] = min(lowlink[node], lowlink[nbr])
            elif on_stack.get(nbr):
                lowlink[node] = min(lowlink[node], index[nbr])
        if lowlink[node] == index[node]:
            scc = []
            while True:
                w = stack.pop()
                on_stack[w] = False
                scc.append(w)
                if w == node: break
            sccs.append(scc)

    for n in list(graph):
        if n not in index:
            strongconnect(n)
    return sccs


def main():
    files = sorted(ROOTS_DIR.glob("*.md"))
    parsed = [parse(f) for f in files]
    by_id = {r["id"]: r for r in parsed}

    graph = {r["id"]: r["refs"] & set(by_id) for r in parsed}
    # reverse graph for inbound degree
    inbound = defaultdict(set)
    for src, tgts in graph.items():
        for tgt in tgts:
            inbound[tgt].add(src)

    sccs = tarjan_scc(graph)
    non_trivial = [s for s in sccs if len(s) > 1]

    # group membership
    gmembers = defaultdict(set)
    gcats = defaultdict(set)  # categories per group
    for r in parsed:
        for g in r["groups"]:
            gmembers[g].add(r["id"])
            gcats[g].add(r["category"])

    # lattice-tag candidates: 3+ members AND span 3+ categories
    lattice_candidates = [
        (g, members, cats) for g, members in gmembers.items()
        for cats in [gcats[g]]
        if len(members) >= 3 and len(cats) >= 3
    ]
    lattice_candidates.sort(key=lambda x: (-len(x[1]), x[0]))

    # irreducible core: nodes with 0 inbound edges OR only seed inbound
    true_sources = [r["id"] for r in parsed if not inbound[r["id"]]]
    # leaves: nodes that reference nothing else (seeds mostly)
    leaves = [r["id"] for r in parsed if not graph[r["id"]]]

    # most-referenced = highest inbound
    most_cited = sorted(inbound.items(), key=lambda x: -len(x[1]))[:15]

    # category breakdown
    cat_counts = defaultdict(int)
    for r in parsed:
        cat_counts[r["category"]] += 1

    # report
    lines = [
        f"# speak/ emergence report",
        "",
        f"**Graph state** ({len(parsed)} nodes, "
        f"{sum(len(v) for v in graph.values())} edges)",
        "",
        "## Category breakdown",
        "",
        "```",
    ]
    for c in sorted(cat_counts):
        lines.append(f"  {c}  {cat_counts[c]:3d}")
    lines.append("```")
    lines.append("")

    lines.extend([
        "## Strongly-connected components (cycles)",
        "",
        f"Total SCCs: {len(sccs)} "
        f"(of which non-trivial = cycle: {len(non_trivial)})",
        "",
    ])
    if non_trivial:
        lines.append("Non-trivial SCCs (cycles, size ≥ 2):")
        lines.append("")
        for scc in sorted(non_trivial, key=lambda s: -len(s)):
            seed_in = any(by_id[n]["is_seed"] for n in scc)
            marker = "✓ seed-anchored" if seed_in else "⚠ UNANCHORED"
            lines.append(f"  ({len(scc)}) {marker}: "
                         f"{sorted(scc)}")
        lines.append("")
    else:
        lines.append("No cycles — graph is a DAG.")
        lines.append("")

    lines.extend([
        "## Most-referenced nodes (inbound degree)",
        "",
        "```",
        "node          in   sample sources",
        "─────────────────────────────────",
    ])
    for tgt, srcs in most_cited:
        sample = sorted(srcs)[:5]
        more = f" +{len(srcs)-5}" if len(srcs) > 5 else ""
        lines.append(f"  {tgt:12s}  {len(srcs):3d}  "
                     f"{', '.join(sample)}{more}")
    lines.append("```")
    lines.append("")

    lines.extend([
        "## True sources (inbound = 0)",
        "",
        f"Count: {len(true_sources)}",
        "",
        f"```",
        f"  {sorted(true_sources)}",
        f"```",
        "",
        f"**Leaves** (refs nothing else): {len(leaves)}",
        "",
    ])

    lines.extend([
        "## Lattice-tag candidates (rule 7: 3+ members, 3+ categories)",
        "",
        f"Found {len(lattice_candidates)} groups that span 3+ "
        "vocabulary categories with 3+ members.",
        "These are the strongest emergence signals — concepts from "
        "multiple unrelated domains converging on one group.",
        "",
    ])
    for g, members, cats in lattice_candidates:
        lines.append(f"### {g}  ({len(members)} members, "
                     f"{len(cats)} categories)")
        lines.append("")
        lines.append(f"Categories: `{sorted(cats)}`")
        lines.append("")
        by_cat = defaultdict(list)
        for m in members:
            by_cat[by_id[m]["category"]].append(m)
        for c in sorted(by_cat):
            lines.append(f"  - {c}: {', '.join(sorted(by_cat[c]))}")
        lines.append("")

    lines.extend([
        "## All groups ≥ 3 members (by size)",
        "",
    ])
    all_groups = sorted(gmembers.items(), key=lambda x: (-len(x[1]), x[0]))
    lines.append("```")
    for g, members in all_groups:
        if len(members) >= 3:
            cats = sorted(gcats[g])
            lines.append(f"  {len(members):3d}  {g:40s}  "
                         f"cats: {cats}")
    lines.append("```")
    lines.append("")

    out = DATA_DIR / "emergence.md"
    out.write_text("\n".join(lines))
    print(f"wrote {out}")
    print(f"  {len(parsed)} nodes")
    print(f"  {sum(len(v) for v in graph.values())} edges")
    print(f"  {len(non_trivial)} non-trivial SCCs")
    print(f"  {len(lattice_candidates)} lattice-tag candidates "
          f"(3+ members, 3+ categories)")


if __name__ == "__main__":
    main()
