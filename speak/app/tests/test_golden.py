"""
Golden tests for speak/ app. Run: python3 test_golden.py

Tests that each success-criteria word produces output containing
load-bearing strings. Not a pixel-exact match — a claim-level
match.
"""
import sys
from pathlib import Path

# Add parent dir to path so we can import from speak/app/
sys.path.insert(0, str(Path(__file__).resolve().parent.parent))

from lib import lookup
from render import render_terminal


def strip_ansi(s):
    import re
    return re.sub(r"\x1b\[[0-9;]*m", "", s)


def check_contains(word, required_strings):
    """Render word, verify output contains all required_strings.
    Whitespace is collapsed so wrap-induced line breaks don't
    cause false failures."""
    import re
    data = lookup(word)
    assert data is not None, f"{word!r} is not curated"
    out = strip_ansi(render_terminal(data))
    collapsed = re.sub(r"\s+", " ", out)
    missing = [s for s in required_strings if s not in collapsed]
    assert not missing, (
        f"{word!r} output missing: {missing}\n\n"
        f"full output:\n{out}"
    )
    return True


CASES = {
    "cognition": [
        # morphemes shown
        "re- · co- · gno- · -tion",
        # PIE form
        "ǵneh",
        # branches
        "know-branch:",
        "beget-branch:",
        # claim
        "ONE OPERATION",
        "same stroke",
        # cross-lang evidence
        "Egyptian",
        "sjA",
        "Chinese",
        "xin",
        # synthesis
        "perception-closes",
        # try-next
        "try:",
    ],
    "king": [
        "king",
        "ǵenh",
        "beget-line",
        # cross-lang
        "Sumerian",
        "lugal",
        "Egyptian",
        "nsw",
    ],
    "year": [
        "year",
        "yeh",
        "loop closing",
        # cross-lang — four-way match
        "Chinese",
        "nian",
        "Sumerian",
        "mu",
        "Egyptian",
        "rnpt",
    ],
    "light": [
        "light",
        "leuk",
        "polar axis",
        # cross-lang
        "Egyptian",
        "ra",
        "Chinese",
        "ri",
    ],
    "mother": [
        "mother",
        "meh",
        "ma-shape",
        # cross-lang
        "Sumerian",
        "ama",
    ],
    "recognize": [
        "re- · co- · gno- · -ize",
        "ǵneh",
        "again-together-knowing",
        "loop closing",
        "Egyptian",
        "sjA",
    ],
    "tree": [
        "tree",
        "deru",
        "firm",
        "true",
        "Sumerian",
        "gish",
    ],
}


def main():
    passes = 0
    fails = []
    for word, required in CASES.items():
        try:
            check_contains(word, required)
            passes += 1
            print(f"  PASS  {word}")
        except AssertionError as e:
            fails.append((word, str(e)))
            print(f"  FAIL  {word}")
    print()
    print(f"{passes}/{len(CASES)} golden tests passed")
    if fails:
        print()
        for word, err in fails:
            print(f"=== {word} ===")
            print(err)
            print()
        return 1
    return 0


if __name__ == "__main__":
    sys.exit(main())
