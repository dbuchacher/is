"""
Test atomic-file page rendering.

Built only for coord-tagged morphemes. Coord-page evidence tables
link through to these. Sibling references in definitions linkify
only when the target sibling also has a built page (no 404s).
"""
import sys
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent.parent))

from lib import load_graph, coord_tag_for_morpheme
from render import render_atomic_page, _has_atomic_page


def main():
    fails = []

    # Known-tagged morphemes should have atomic-page capability
    tagged_samples = [
        ("egyptian", "sjA"),
        ("egyptian", "Hw"),
        ("egyptian", "xpr"),
        ("chinese",  "xin"),
        ("chinese",  "wen"),
        ("sumerian", "geshtug"),
        ("pie",      "gneh3"),
        ("pie",      "kap-ut"),
    ]
    for lang, mid in tagged_samples:
        if not _has_atomic_page(lang, mid):
            fails.append(f"{lang}:{mid}: expected atomic page available")

    # A known untagged sibling should NOT have a page (prevents 404s)
    if _has_atomic_page("egyptian", "mAA"):
        # mAA is referenced from sjA but not in coord-unity
        fails.append("egyptian:mAA: not coord-tagged, should not have page")

    # Render sjA and verify:
    #   - word id shown
    #   - definition present
    #   - siblings with built pages link; others are plain spans
    graph = load_graph("egyptian")
    sja = graph.get("sjA")
    if sja is None:
        fails.append("sjA atomic file not parsed")
    else:
        html = render_atomic_page("egyptian", sja)
        if ">sjA<" not in html:
            fails.append("render_atomic_page: missing word id")
        if "Definition" not in html:
            fails.append("render_atomic_page: missing definition section")
        # ib and rA are coord-tagged (heart-mind, mouth-opening) → should link
        if 'href="ib.html"' not in html:
            fails.append("render_atomic_page: ib cross-ref should link (coord-tagged)")
        if 'href="rA.html"' not in html:
            fails.append("render_atomic_page: rA cross-ref should link (coord-tagged)")
        # mAA is NOT in coord-unity → should be plain span, not link
        if 'href="mAA.html"' in html:
            fails.append("render_atomic_page: mAA would 404 — should be plain span")
        if "Groups this morpheme belongs to:" not in html:
            fails.append("render_atomic_page: missing groups section")

    if fails:
        for f in fails:
            print(f"  FAIL  {f}")
        print(f"\n{len(fails)} failure(s)")
        return 1

    print(f"atomic-pages test: OK ({len(tagged_samples)} tagged samples, "
          f"sibling-link gating verified)")
    return 0


if __name__ == "__main__":
    sys.exit(main())
