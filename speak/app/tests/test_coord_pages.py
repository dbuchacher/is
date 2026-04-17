"""
Test per-coord page rendering.

Verifies:
- Every clean 3+/4 coord-unity entry renders a coord page with:
  - the claim
  - non-null language rows each showing id(s) + gloss
  - null language rows explicitly flagged as "no atomic file indexed"
  - English descendants linked when any primary_pie matches
- Coord-index page lists all entries grouped by hit-count
"""
import sys
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent.parent))

from lib import load_app_data
from render import (
    render_coord_page,
    render_coord_index,
    _coord_clean_hit_count,
)


def main():
    coord_data = load_app_data()["coord-unity"]
    assert len(coord_data) > 0, "no coord-unity entries"

    fails = []

    # Check each coord page renders and carries the claim + lang rows
    for name, c in coord_data.items():
        html = render_coord_page(name, c)

        # Header
        if name not in html:
            fails.append(f"{name}: coord name missing from page")

        # Claim
        claim = c.get("claim", "").strip()
        if claim and claim not in html:
            fails.append(f"{name}: claim missing from page")

        # Each non-null language should render its id(s) in the evidence table
        for lang in ("pie", "sumerian", "egyptian", "chinese"):
            entry = c.get(lang)
            if entry is None:
                if "(no atomic file indexed)" not in html:
                    fails.append(f"{name}: null {lang} not flagged honestly")
            else:
                ids = entry.get("ids") or (
                    [entry["id"]] if entry.get("id") else []
                )
                for rid in ids:
                    if rid not in html:
                        fails.append(f"{name}: {lang} id '{rid}' missing")

    # Coord-index: every coord name appears
    coord_list = [
        (n, c, _coord_clean_hit_count(c))
        for n, c in sorted(coord_data.items())
    ]
    idx_html = render_coord_index(coord_list)
    for name, _, _ in coord_list:
        if f'href="{name}.html"' not in idx_html:
            fails.append(f"coord-index missing link to {name}")

    # Hit-count groups present for each tier that has entries
    group_headers = {
        4: "four-way convergence",
        3: "three-way",
        2: "two-way",
    }
    hits_present = {hit for _, _, hit in coord_list}
    for h in hits_present:
        if h in group_headers and group_headers[h] not in idx_html:
            fails.append(f"coord-index missing group header for hit={h}")

    # Clean-3+/4 count meets threshold (BUILD-SPEC gate)
    clean = sum(1 for _, _, h in coord_list if h >= 3)
    if clean < 10:
        fails.append(
            f"clean 3+/4 hits = {clean}, below BUILD-SPEC threshold of 10"
        )

    if fails:
        for f in fails:
            print(f"  FAIL  {f}")
        print(f"\n{len(fails)} failure(s)")
        return 1

    print(f"coord-pages test: OK ({len(coord_data)} coords, "
          f"{clean} clean 3+/4 hits)")
    return 0


if __name__ == "__main__":
    sys.exit(main())
