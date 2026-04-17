"""
Test descendant redirect handling.

A word in branches.json that's NOT curated in en-pie.json should
route through lookup_redirect → render_redirect_* output. Structured
one-card, no forged claim prose.
"""
import sys
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent.parent))

from lib import (
    lookup,
    lookup_redirect,
    redirect_descendants,
)
from render import render_redirect_terminal, render_redirect_html


# Known descendants NOT curated in en-pie.json (per validate.py warnings)
KNOWN_REDIRECTS = {
    "genetic":   {"parent_pie": "gneh3",   "branch": "beget-branch"},
    "genuine":   {"parent_pie": "genh1",   "branch": "gen-branch"},
    "lucid":     {"parent_pie": "leuk",    "branch": "lux-branch"},
    "Jupiter":   {"parent_pie": "dyews",   "branch": "god-branch"},
    "chakra":    {"parent_pie": "kwel",    "branch": "turn-branch"},
    "trust":     {"parent_pie": "deru",    "branch": "firm-branch"},
    "menstrual": {"parent_pie": "meh1ns",  "branch": "month-branch"},
}


def main():
    fails = []

    # 1. lookup_redirect matches; lookup (curated) does not.
    for word, spec in KNOWN_REDIRECTS.items():
        rd = lookup_redirect(word)
        if rd is None:
            fails.append(f"{word!r}: lookup_redirect returned None")
            continue
        if rd["parent_pie"] != spec["parent_pie"]:
            fails.append(
                f"{word!r}: parent_pie {rd['parent_pie']!r} "
                f"!= {spec['parent_pie']!r}"
            )
        if rd["branch_name"] != spec["branch"]:
            fails.append(
                f"{word!r}: branch {rd['branch_name']!r} "
                f"!= {spec['branch']!r}"
            )
        # Curated lookup should return None for these
        if lookup(word) is not None:
            fails.append(f"{word!r}: expected NOT curated, got curated hit")

    # 2. Curated words should NOT redirect.
    for curated_word in ("cognition", "year", "mother"):
        if lookup_redirect(curated_word) is not None:
            fails.append(
                f"{curated_word!r}: curated word should not redirect"
            )

    # 3. Gibberish returns None.
    if lookup_redirect("flibbertigibbet") is not None:
        fails.append("gibberish matched a redirect")

    # 4. Terminal render contains parent PIE and branch; NO forged claim.
    rd = lookup_redirect("genetic")
    term = render_redirect_terminal(rd)
    import re
    term_stripped = re.sub(r"\x1b\[[0-9;]*m", "", term)
    if "genetic" not in term_stripped:
        fails.append("terminal render missing word")
    if "gneh3" not in term_stripped:
        fails.append("terminal render missing parent PIE")
    if "beget-branch" not in term_stripped:
        fails.append("terminal render missing branch")
    if "cognition" not in term_stripped:
        fails.append("terminal render missing curated parent hero")
    # Honest-flag discipline: no claim prose
    if "claim" in term_stripped.lower():
        fails.append("terminal render has claim prose (should be structured)")

    # 5. HTML render is small + points at parent hero page.
    html = render_redirect_html(rd)
    if "genetic" not in html:
        fails.append("HTML render missing word")
    if 'href="cognition.html"' not in html:
        fails.append("HTML render missing parent hero link")
    if "beget-branch" not in html:
        fails.append("HTML render missing branch name")

    # 6. redirect_descendants returns a reasonable list
    all_r = redirect_descendants()
    if len(all_r) < 20:
        fails.append(
            f"redirect_descendants returned only {len(all_r)} entries "
            f"(expected ≥20 based on branches.json)"
        )

    if fails:
        for f in fails:
            print(f"  FAIL  {f}")
        print(f"\n{len(fails)} failure(s)")
        return 1

    print(f"redirect test: OK ({len(KNOWN_REDIRECTS)} known redirects, "
          f"{len(all_r)} total descendants)")
    return 0


if __name__ == "__main__":
    sys.exit(main())
