"""
Test coord-tag derivation.

Tagged = morpheme appears in a coord-unity entry for its language.
Unassigned = honest flag, first-class output per BUILD-SPEC.
"""
import sys
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent.parent))

from lib import coord_tag_for_morpheme, coord_tag_stats


def main():
    fails = []

    # Tagged cases — participate in coord-unity
    tagged_cases = [
        ("pie",      "gneh3",     "know-beget"),
        ("pie",      "kap-ut",    "head-chief"),
        ("pie",      "yeh1r",     "year-cycle"),
        ("chinese",  "xin",       "know-beget"),
        ("chinese",  "shou_head", "head-chief"),
        ("egyptian", "sDm",       "hear-understand"),
        ("egyptian", "tp",        "head-chief"),
        ("sumerian", "ka",        "mouth-opening"),
        ("sumerian", "sang",      "head-chief"),
    ]
    for lang, mid, expected in tagged_cases:
        actual = coord_tag_for_morpheme(lang, mid)
        if actual != expected:
            fails.append(
                f"{lang}:{mid}: tag {actual!r} != {expected!r}"
            )

    # Unassigned cases — atomic files that exist but no coord-unity
    unassigned_cases = [
        ("pie",      "bhreh2ter"),   # brother
        ("pie",      "swesor"),      # sister
        ("pie",      "nokwts"),      # night
        ("pie",      "ph2ter"),      # father
    ]
    for lang, mid in unassigned_cases:
        if coord_tag_for_morpheme(lang, mid) is not None:
            fails.append(
                f"{lang}:{mid}: should be unassigned, got tag"
            )

    # Stats shape
    stats = coord_tag_stats()
    for lang in ("pie", "sumerian", "egyptian", "chinese"):
        if lang not in stats:
            fails.append(f"stats missing lang {lang}")
            continue
        t, u, n = stats[lang]
        if t + u != n:
            fails.append(f"stats[{lang}]: t+u={t+u} != n={n}")
        if n == 0:
            fails.append(f"stats[{lang}]: total = 0 (graph missing?)")

    # Tagged should be non-zero for all four (coord-unity has entries
    # in all four)
    for lang in ("pie", "sumerian", "egyptian", "chinese"):
        t, _, _ = stats[lang]
        if t == 0:
            fails.append(f"stats[{lang}]: tagged = 0 (coord-unity should have entries)")

    if fails:
        for f in fails:
            print(f"  FAIL  {f}")
        print(f"\n{len(fails)} failure(s)")
        return 1

    total_tagged = sum(t for t, _, _ in stats.values())
    total_n = sum(n for _, _, n in stats.values())
    print(f"coord-tags test: OK ({len(tagged_cases)} tagged, "
          f"{len(unassigned_cases)} unassigned cases verified; "
          f"{total_tagged}/{total_n} morphemes tagged across 4 graphs)")
    return 0


if __name__ == "__main__":
    sys.exit(main())
