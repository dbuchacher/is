#!/usr/bin/env python3
"""Emit mermaid flowchart + progress ASCII overview."""
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
    return dict(id=path.stem, category=category,
                is_deictic=is_deictic, refs=refs, groups=groups)


def main():
    files = sorted(ROOTS_DIR.glob("*.md"))
    parsed = [parse(f) for f in files]
    by_cat = defaultdict(list)
    for r in parsed:
        by_cat[r["category"]].append(r)
    gmembers = defaultdict(set)
    for r in parsed:
        for g in r["groups"]:
            gmembers[g].add(r["id"])

    cat_label = {
        "1a": "POINTING (deictic)",
        "1h": "BEING+ACTION",
        "1i": "MOTION",
        "1j": "PERCEPTION",
        "1k": "SPEECH",
        "1n": "SPATIAL",
    }
    cat_style = {
        "1a": "fill:#9BB4FF,stroke:#333",
        "1h": "fill:#FFB39B,stroke:#333",
        "1i": "fill:#9BFFB4,stroke:#333",
        "1j": "fill:#FFE49B,stroke:#333",
        "1k": "fill:#E49BFF,stroke:#333",
        "1n": "fill:#9BFFF4,stroke:#333",
    }

    lines = ["```mermaid", "flowchart LR"]
    # subgraph per category
    for cat in sorted(by_cat):
        lines.append(f'  subgraph {cat}["{cat_label.get(cat, cat)}"]')
        for r in by_cat[cat]:
            shape = f'{{"{r["id"]}"}}' if r["is_deictic"] else f'["{r["id"]}"]'
            lines.append(f"    {r['id']}{shape}")
        lines.append("  end")
    # inter-root edges (only non-deictic; deictics ground in pointing)
    seen = set()
    for r in parsed:
        if r["is_deictic"]: continue
        for tgt in sorted(r["refs"]):
            key = (r["id"], tgt)
            if key in seen: continue
            seen.add(key)
            lines.append(f"  {r['id']} --> {tgt}")
    # styles
    for r in parsed:
        lines.append(f"  style {r['id']} {cat_style.get(r['category'], '')}")
    lines.append("```")

    out = DATA_DIR / "graph.md"
    out.write_text("\n".join(lines))
    print(f"wrote mermaid to {out}")
    print(f"  nodes: {len(parsed)}  edges: {len(seen)}")
    print(f"  paste the file's contents into any mermaid renderer")
    print(f"  (GitHub renders it natively; or https://mermaid.live)")

    # group summary
    lines2 = ["```", "GROUPS WITH ≥3 MEMBERS (emergence candidates)", ""]
    for g, members in sorted(gmembers.items(),
                              key=lambda x: -len(x[1])):
        if len(members) >= 3:
            lines2.append(f"  {g} ({len(members)})")
            for m in sorted(members):
                # category of each member
                cat = next((r["category"] for r in parsed
                            if r["id"] == m), "?")
                lines2.append(f"    {cat}  {m}")
            lines2.append("")
    lines2.append("```")
    grp_out = DATA_DIR / "groups.md"
    grp_out.write_text("\n".join(lines2))
    print(f"wrote groups summary to {grp_out}")


if __name__ == "__main__":
    main()
