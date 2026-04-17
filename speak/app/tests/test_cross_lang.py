"""
Test cross-language morpheme input.

Verifies: typing a Sumerian/Egyptian/Chinese morpheme (that exists
in the atomic-file graph AND participates in a coord-unity entry)
returns a cross-lang reframe showing the coord, the shared claim,
and the other vocabularies that name the same coord.
"""
import re
import sys
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent.parent))

from lib import lookup_cross_lang
from render import render_cross_lang_terminal


def strip_ansi(s):
    return re.sub(r"\x1b\[[0-9;]*m", "", s)


CASES = {
    "xin": {
        "lang": "chinese",
        "coord": "know-beget",
        "required": [
            "xin", "(chinese morpheme)",
            "coord:", "know-beget",
            "Three independent vocabularies",
            "PIE", "gneh3",
            "Egyptian", "sjA",
            "English words here:",
            "cognition",
        ],
    },
    "sDm": {
        "lang": "egyptian",
        "coord": "hear-understand",
        "required": [
            "sDm", "(egyptian morpheme)",
            "coord:", "hear-understand",
            "loop",
            "Chinese", "wen",
            "Sumerian", "geshtug",
        ],
    },
    "sang": {
        "lang": "sumerian",
        "coord": "head-chief",
        "required": [
            "sang", "(sumerian morpheme)",
            "coord:", "head-chief",
            "leadership",
            "PIE", "kap-ut",
            "Egyptian", "tp",
            "Chinese", "shou_head",
        ],
    },
    "tian": {
        "lang": "chinese",
        "coord": "sky-god",
        "required": [
            "tian", "(chinese morpheme)",
            "coord:", "sky-god",
            "PIE", "dyews",
        ],
    },
    # Egyptian ib — heart/mind, 3/4 coord
    "ib": {
        "lang": "egyptian",
        "coord": "heart-mind",
        "required": [
            "ib", "(egyptian morpheme)",
            "coord:", "heart-mind",
            "Chinese", "xin",
            "Sumerian", "sha",
        ],
    },
}


def main():
    fails = []
    for morpheme, spec in CASES.items():
        xl = lookup_cross_lang(morpheme)
        if xl is None:
            fails.append(f"{morpheme!r}: lookup returned None")
            continue
        if xl["lang"] != spec["lang"]:
            fails.append(
                f"{morpheme!r}: lang {xl['lang']!r} != {spec['lang']!r}"
            )
        if xl["coord_name"] != spec["coord"]:
            fails.append(
                f"{morpheme!r}: coord {xl['coord_name']!r} "
                f"!= {spec['coord']!r}"
            )
        out = strip_ansi(render_cross_lang_terminal(xl))
        collapsed = re.sub(r"\s+", " ", out)
        missing = [s for s in spec["required"] if s not in collapsed]
        if missing:
            fails.append(
                f"{morpheme!r}: output missing {missing}\n"
                f"full:\n{out}"
            )

    if fails:
        for f in fails:
            print(f"  FAIL  {f}")
        print(f"\n{len(fails)} failure(s)")
        return 1

    # Negative case — gibberish should return None
    if lookup_cross_lang("xyzzyx") is not None:
        print("FAIL: gibberish matched something")
        return 1

    print(f"cross-lang test: OK ({len(CASES)} morphemes matched, "
          f"gibberish rejected)")
    return 0


if __name__ == "__main__":
    sys.exit(main())
