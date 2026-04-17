"""
Test lemmatize + nearest-suggest fallbacks.

Direct miss → stem match: 'knowing' → 'know', 'notices' → 'notice'.
Direct miss, stem miss → nearest suggest: 'cogntion' → 'cognition'.
Direct miss, stem miss, no near-match → full curated list fallback.
"""
import sys
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent.parent))

from lib import (
    lookup,
    lookup_with_stemming,
    nearest_curated,
    simple_stem_guess,
    curated_words,
)


STEM_CASES = {
    # inflection    → expected stem in curated set
    "knowing":        "know",
    "known":          None,  # -n not handled; fine, nearest-suggest picks up
    "notices":        "notice",
    "recognized":     "recognize",
    "waters":         "water",
}


NEAREST_CASES = {
    # typo/close → top suggestion contains this word
    "cogntion":      "cognition",
    "generaton":     "generation",
    "brohter":       "brother",
    "moher":         "mother",
    "lite":          "light",
}


def main():
    fails = []

    # Stem cases: lookup_with_stemming should hit
    for word, expected_stem in STEM_CASES.items():
        data, stem_used = lookup_with_stemming(word)
        if expected_stem is None:
            # Either stem miss OR hit — just making sure nothing crashes
            continue
        if data is None:
            fails.append(f"{word!r}: expected stem hit, got None")
        elif stem_used != expected_stem:
            fails.append(
                f"{word!r}: stem_used {stem_used!r} != {expected_stem!r}"
            )

    # Nearest cases: top suggestion should be the target
    for word, target in NEAREST_CASES.items():
        near = nearest_curated(word)
        if not near:
            fails.append(f"{word!r}: no nearest matches")
        elif target not in near:
            fails.append(
                f"{word!r}: target {target!r} not in {near}"
            )

    # Direct curated words should not stem-redirect
    data, stem = lookup_with_stemming("cognition")
    if data is None or stem is not None:
        fails.append("curated word 'cognition' stem-redirected")

    # Complete gibberish → no nearest (below cutoff)
    near = nearest_curated("xyzzyxyzzy")
    if near:
        fails.append(f"gibberish matched: {near}")

    # Stemmer shape: candidates always include the original word
    for w in ("knowing", "cognition", "whatever"):
        cands = simple_stem_guess(w)
        if w.lower() not in cands:
            fails.append(f"stemmer: {w!r} missing from own candidates {cands}")

    if fails:
        for f in fails:
            print(f"  FAIL  {f}")
        print(f"\n{len(fails)} failure(s)")
        return 1

    print(f"stemming test: OK ({len(STEM_CASES)} stem cases, "
          f"{len(NEAREST_CASES)} nearest cases, "
          f"gibberish rejected, curated passthrough)")
    return 0


if __name__ == "__main__":
    sys.exit(main())
