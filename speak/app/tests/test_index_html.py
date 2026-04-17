"""
Test that the rendered index.html carries the interactive search
block: <datalist>, the URL-state JS, and every curated word as an
<option>.
"""
import sys
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent.parent))

from lib import curated_words
from render import render_html_index


def main():
    html = render_html_index()
    words = curated_words()
    assert len(words) > 0, "no curated words loaded"

    required = [
        '<datalist id="speak-words">',
        'id="speak-search"',
        'id="speak-word"',
        'name="w"',
        'URLSearchParams',
        "params.get('w')",
        "window.location.href = lower + '.html'",
        # cross-language bridge: coord-page redirect for morpheme match
        "window.location.href = 'coord/'",
        'var xlang =',
    ]
    missing = [s for s in required if s not in html]
    assert not missing, f"index.html missing: {missing}"

    # every curated word shows up as a datalist option AND a browse-list link
    for w in words:
        opt = f'<option value="{w}">'
        link = f'<a href="{w}.html">{w}</a>'
        assert opt in html, f"datalist missing option for '{w}'"
        assert link in html, f"browse list missing link for '{w}'"

    print(f"index-html test: OK ({len(words)} curated words, "
          f"{len(required)} structural assertions)")
    return 0


if __name__ == "__main__":
    sys.exit(main())
