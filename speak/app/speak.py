#!/usr/bin/env python3
"""
speak — substrate decomposition of English words.

Usage:
  speak                          — first-run pitch + curated word list
  speak <word>                   — decompose the word (terminal output)
  speak --open <word>            — open the atomic file in frogmouth
  speak --terse <word>            — compact output for repeat users
  speak build <site-dir>         — render all curated words as static HTML
  speak --list                   — list all curated words

Requires: Python 3.11+, no external dependencies.
"""
import argparse
import subprocess
import sys
from pathlib import Path

from lib import (
    lookup,
    lookup_cross_lang,
    curated_words,
    ROOTS_DIRS,
    load_graph,
    load_app_data,
)
from render import (
    render_terminal,
    render_cross_lang_terminal,
    render_no_match_terminal,
    render_first_run_terminal,
    render_html,
    render_html_index,
    render_coord_page,
    render_coord_index,
    _coord_clean_hit_count,
)


def cmd_word(word, terse=False):
    data = lookup(word)
    if data is None:
        # Not in English set — try cross-language morpheme lookup
        xl = lookup_cross_lang(word)
        if xl is not None:
            print(render_cross_lang_terminal(xl))
            return 0
        print(render_no_match_terminal(word))
        return 2
    if terse:
        # compact: just morphemes + claim
        entry = data["entry"]
        forms = " · ".join(m["form"] for m in entry["morphemes"])
        pie = entry["primary_pie"]
        atomic = data.get("atomic") or {}
        gloss = atomic.get("gloss", "")
        print(f"{word} = {forms}")
        print(f"  PIE {pie} ({gloss})")
        print(f"  {entry.get('claim', '')}")
    else:
        print(render_terminal(data))
    return 0


def cmd_open(word):
    data = lookup(word)
    if data is None:
        print(f"not curated: {word}", file=sys.stderr)
        return 2
    atomic = data.get("atomic")
    if not atomic:
        print(f"no atomic file for PIE root "
              f"{data['entry']['primary_pie']}", file=sys.stderr)
        return 3
    pie_dir = ROOTS_DIRS["pie"]
    atomic_path = pie_dir / f"{atomic['id']}.md"
    # try frogmouth, fall back to cat / less
    for tool in ("frogmouth", "glow", "less", "cat"):
        try:
            subprocess.run([tool, str(atomic_path)], check=True)
            return 0
        except FileNotFoundError:
            continue
        except subprocess.CalledProcessError as e:
            return e.returncode
    print(atomic_path, file=sys.stderr)
    return 4


def cmd_build(site_dir):
    site = Path(site_dir).resolve()
    site.mkdir(parents=True, exist_ok=True)
    words = curated_words()
    print(f"building {len(words)} word pages → {site}")
    for w in words:
        data = lookup(w)
        if data is None:
            continue
        html = render_html(data)
        (site / f"{w}.html").write_text(html)
        print(f"  {w}.html")

    # Coord pages — the argument surface.
    coord_data = load_app_data()["coord-unity"]
    coord_dir = site / "coord"
    coord_dir.mkdir(parents=True, exist_ok=True)
    print(f"building {len(coord_data)} coord pages → {coord_dir}")
    coord_list = []
    for name, c in sorted(coord_data.items()):
        hit = _coord_clean_hit_count(c)
        coord_list.append((name, c, hit))
        html = render_coord_page(name, c)
        (coord_dir / f"{name}.html").write_text(html)
        print(f"  coord/{name}.html  [{hit}/4]")
    coord_index_html = render_coord_index(coord_list)
    (coord_dir / "index.html").write_text(coord_index_html)
    print(f"  coord/index.html")

    index_html = render_html_index()
    (site / "index.html").write_text(index_html)
    print(f"  index.html")
    print(f"done.")
    return 0


def cmd_list():
    words = curated_words()
    print(f"{len(words)} curated words:")
    # print 4 per line
    for i in range(0, len(words), 4):
        print("  " + "  ".join(f"{w:<14}" for w in words[i:i+4]))
    return 0


def main():
    ap = argparse.ArgumentParser(
        prog="speak",
        description="substrate decomposition of English words",
        epilog="one universe, many vocabularies — see README.",
        formatter_class=argparse.RawDescriptionHelpFormatter,
    )
    ap.add_argument("word", nargs="?", help="English word to decompose, "
                    "or 'build' for static site")
    ap.add_argument("target", nargs="?", help="for 'build': output directory")
    ap.add_argument("--open", action="store_true",
                    help="open the atomic file in frogmouth")
    ap.add_argument("--terse", action="store_true",
                    help="compact output (morphemes + claim only)")
    ap.add_argument("--list", action="store_true",
                    help="list all curated words")
    args = ap.parse_args()

    if args.list:
        return cmd_list()

    if args.word is None:
        print(render_first_run_terminal())
        return 0

    if args.word == "build":
        target = args.target or "site"
        return cmd_build(target)

    if args.open:
        return cmd_open(args.word)

    return cmd_word(args.word, terse=args.terse)


if __name__ == "__main__":
    sys.exit(main())
