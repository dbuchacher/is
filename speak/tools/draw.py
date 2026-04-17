#!/usr/bin/env python3
"""
draw.py — render the current speak/ graph.

Emits:
  - data/graph.dot       graphviz source
  - data/graph.png       rendered (if `dot` is installed)
  - ASCII summary to stdout
"""
import json
import re
import subprocess
from collections import defaultdict
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent
ROOTS_DIR = ROOT / "roots"
DATA_DIR = ROOT / "data"
LINK_RE = re.compile(r"\[([a-zA-Z0-9_-]+)\]\(([a-zA-Z0-9_-]+)\.md\)")

# category → color
CAT_COLOR = {
    "1a": "#9BB4FF",  # pronouns/deictics — blue
    "1h": "#FFB39B",  # being/action — orange
    "1i": "#9BFFB4",  # motion — green
    "1j": "#FFE49B",  # perception — yellow
    "1k": "#E49BFF",  # speech — purple
    "1n": "#9BFFF4",  # spatial — cyan
}

def parse(path):
    text = path.read_text()
    cat_match = re.search(r"category:\s*(\w+)", text)
    category = cat_match.group(1) if cat_match else "?"
    is_deictic = "**deictic**" in text
    # extract seed → seed refs from Definition section only
    def_match = re.search(r"## Definition\s*\n(.*?)(?=\n## |\Z)", text, re.DOTALL)
    def_body = def_match.group(1) if def_match else ""
    seed_refs = set()
    for m in LINK_RE.finditer(def_body):
        label, tgt = m.groups()
        if label == tgt and (ROOTS_DIR / f"{tgt}.md").exists():
            seed_refs.add(tgt)
    # extract group refs from Groups section
    grp_match = re.search(r"## Groups\s*\n(.*?)(?=\n## |\Z)", text, re.DOTALL)
    grp_body = grp_match.group(1) if grp_match else ""
    groups = set()
    for m in LINK_RE.finditer(grp_body):
        label, tgt = m.groups()
        if label == tgt and tgt not in [p.stem for p in ROOTS_DIR.glob("*.md")]:
            groups.add(tgt)
    return dict(
        id=path.stem, category=category, is_deictic=is_deictic,
        refs=seed_refs, groups=groups,
    )


def main():
    files = sorted(ROOTS_DIR.glob("*.md"))
    parsed = [parse(f) for f in files]

    # ASCII summary
    print("=" * 60)
    print(f"speak/ graph — {len(parsed)} nodes")
    print("=" * 60)

    by_cat = defaultdict(list)
    for r in parsed:
        by_cat[r["category"]].append(r["id"])
    print("\nseeds by category:")
    for cat in sorted(by_cat):
        color = {"1a": "deictic ▣▣▣", "1h": "being  ▨▨▨",
                 "1i": "motion ▦▦▦", "1j": "percept▧▧▧",
                 "1k": "speech ▤▤▤", "1n": "spatial▥▥▥"}.get(cat, "")
        print(f"  {cat} {color}  ({len(by_cat[cat])}): "
              f"{', '.join(by_cat[cat])}")

    # most-referenced seeds (inbound)
    inbound = defaultdict(set)
    for r in parsed:
        for tgt in r["refs"]:
            inbound[tgt].add(r["id"])
    print(f"\ntotal seed→seed edges: "
          f"{sum(len(r['refs']) for r in parsed)}")
    print("\nmost-referenced seeds (inbound):")
    top = sorted(inbound.items(), key=lambda x: -len(x[1]))[:8]
    for tgt, srcs in top:
        print(f"  {tgt:10s}  ← {len(srcs):2d}  ({', '.join(sorted(srcs))})")

    # group accumulation
    gcount = defaultdict(set)
    for r in parsed:
        for g in r["groups"]:
            gcount[g].add(r["id"])
    print(f"\ntotal distinct groups proposed: {len(gcount)}")
    print("\ngroups with ≥3 members (emergence candidates):")
    for g, members in sorted(gcount.items(), key=lambda x: -len(x[1])):
        if len(members) >= 3:
            print(f"  {g:40s}  ({len(members)}) "
                  f"{sorted(members)}")

    # DOT
    lines = ["digraph speak {",
             "  rankdir=LR;",
             "  bgcolor=\"#1e1e1e\";",
             "  node [style=filled, fontname=\"Monospace\", "
             "fontcolor=\"#000000\", penwidth=2];",
             '  edge [color="#888888"];']
    for r in parsed:
        color = CAT_COLOR.get(r["category"], "#cccccc")
        shape = "diamond" if r["is_deictic"] else "box"
        lines.append(f'  "{r["id"]}" [fillcolor="{color}", '
                     f'shape={shape}];')
    for r in parsed:
        for tgt in sorted(r["refs"]):
            lines.append(f'  "{r["id"]}" -> "{tgt}";')
    # add high-membership groups as light nodes
    for g, members in gcount.items():
        if len(members) >= 3:
            lines.append(f'  "{g}" [fillcolor="#444444", '
                         f'fontcolor="#ffffff", shape=ellipse, '
                         f'style="filled,dashed"];')
            for m in members:
                lines.append(f'  "{m}" -> "{g}" '
                             f'[style=dotted, color="#666666"];')
    lines.append("}")

    dot_path = DATA_DIR / "graph.dot"
    png_path = DATA_DIR / "graph.png"
    svg_path = DATA_DIR / "graph.svg"
    dot_path.write_text("\n".join(lines))
    print(f"\nwrote {dot_path}")

    # try to render
    for fmt, out in [("png", png_path), ("svg", svg_path)]:
        try:
            subprocess.run(
                ["dot", f"-T{fmt}", str(dot_path), "-o", str(out)],
                check=True, capture_output=True,
            )
            print(f"rendered {out}")
        except (subprocess.CalledProcessError, FileNotFoundError) as e:
            print(f"  ({fmt} render skipped: {e})")


if __name__ == "__main__":
    main()
