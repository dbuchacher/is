#!/usr/bin/env python3
"""
verify.py — dependency verification for speak/ atomic files.

Parses each roots/*.md file, extracts:
  - the root id (from filename)
  - the definition's references to other roots (via [id] markdown link pattern)
  - whether the root declares itself as a SEED (seeds are allowed to ground
    in deixis without defining themselves via other roots)

Checks:
  1. Every referenced root-id exists as a file in roots/ or is a seed
  2. No cycles without at least one seed in the cycle
  3. Every non-seed root has a non-empty "## Definition" section
  4. Forbidden-vocabulary check: modern-English abstract words that signal
     a definition is cheating (see FORBIDDEN list below)

Run: python3 tools/verify.py
Exit 0 on clean, non-zero on any failure.
"""
import json
import re
import sys
from collections import defaultdict, deque
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent
ROOTS_DIR = ROOT / "roots"
DATA = ROOT / "data" / "pie-layer1.json"

FORBIDDEN = {
    "location", "direction", "ancestor", "object", "concept",
    "abstract", "property", "instance", "reference", "relationship",
    "function", "procedure", "entity", "representation", "attribute",
}

LINK_RE = re.compile(r"\[([a-zA-Z0-9_]+)\]\(\1\.md\)")


def parse_file(path):
    """Return {id, is_seed, refs:set, has_definition:bool, forbidden:set}."""
    text = path.read_text()
    root_id = path.stem
    is_seed = "**seed**" in text.lower() or "seed: true" in text.lower()
    refs = set(LINK_RE.findall(text))
    refs.discard(root_id)
    has_def = bool(re.search(r"^## Definition", text, re.MULTILINE))
    lowered = text.lower()
    forbidden_hits = {w for w in FORBIDDEN if re.search(rf"\b{w}\b", lowered)}
    return dict(
        id=root_id, is_seed=is_seed, refs=refs,
        has_definition=has_def, forbidden=forbidden_hits,
    )


def main():
    if not ROOTS_DIR.exists():
        print(f"no roots dir at {ROOTS_DIR}")
        sys.exit(2)

    known_ids = set()
    if DATA.exists():
        known_ids = {r["id"] for r in json.loads(DATA.read_text())}

    files = sorted(ROOTS_DIR.glob("*.md"))
    if not files:
        print("no root files yet")
        sys.exit(0)

    parsed = {p.stem: parse_file(p) for p in files}
    problems = defaultdict(list)

    # 1. missing references
    for rid, r in parsed.items():
        for ref in r["refs"]:
            if ref not in parsed and ref not in known_ids:
                problems[rid].append(f"unknown reference: [{ref}]")

    # 2. cycles without seed
    graph = {rid: r["refs"] & set(parsed.keys()) for rid, r in parsed.items()}
    # find SCCs via Tarjan's
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

    for n in graph:
        if n not in index:
            strongconnect(n)

    for scc in sccs:
        if len(scc) > 1:
            if not any(parsed[n]["is_seed"] for n in scc):
                problems["_cycle"].append(
                    f"cycle without seed anchor: {scc}"
                )

    # 3. missing definitions
    for rid, r in parsed.items():
        if not r["has_definition"] and not r["is_seed"]:
            problems[rid].append("no ## Definition section")

    # 4. forbidden vocabulary
    for rid, r in parsed.items():
        if r["forbidden"]:
            problems[rid].append(
                f"modern-English abstracts: {sorted(r['forbidden'])}"
            )

    # report
    print(f"parsed {len(parsed)} root files")
    print(f"  seeds: {sum(1 for r in parsed.values() if r['is_seed'])}")
    print(f"  non-seeds: {sum(1 for r in parsed.values() if not r['is_seed'])}")
    print(f"  total refs: {sum(len(r['refs']) for r in parsed.values())}")
    if not problems:
        print("OK — all checks pass")
        sys.exit(0)
    print("\nPROBLEMS:")
    for rid, plist in sorted(problems.items()):
        print(f"  {rid}:")
        for p in plist:
            print(f"    - {p}")
    sys.exit(1)


if __name__ == "__main__":
    main()
