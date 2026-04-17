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
    lookup_with_stemming,
    lookup_redirect,
    redirect_descendants,
    coord_tag_for_morpheme,
    coord_tag_stats,
    nearest_curated,
    curated_words,
    ROOTS_DIRS,
    load_graph,
    load_app_data,
)
from render import (
    render_terminal,
    render_cross_lang_terminal,
    render_redirect_terminal,
    render_redirect_html,
    render_no_match_terminal,
    render_first_run_terminal,
    render_html,
    render_html_index,
    render_coord_page,
    render_coord_index,
    render_atomic_page,
    _coord_clean_hit_count,
)


def cmd_tag_stats():
    """Report coord-tag coverage per graph. `unassigned` is
    first-class — not a failure, just data about which morphemes
    haven't yet been placed on a cross-vocabulary coord."""
    stats = coord_tag_stats()
    print("coord-tag coverage per graph:")
    print()
    total_t = total_u = total_n = 0
    for lang, (t, u, n) in stats.items():
        pct = 100 * t / n if n else 0
        print(f"  {lang:10s}  {t:3d} tagged  {u:3d} unassigned  "
              f"({n} total, {pct:.1f}% tagged)")
        total_t += t
        total_u += u
        total_n += n
    print()
    print(f"  {'total':10s}  {total_t:3d} tagged  {total_u:3d} unassigned  "
          f"({total_n} total)")
    print()
    print("  tagged = morpheme participates in at least one "
          "coord-unity entry\n"
          "  unassigned = filter has not yet placed this morpheme "
          "on a cross-\n"
          "               vocabulary coord (honest flag, not "
          "failure)")
    return 0


def cmd_deep(word):
    """--deep: show coord-tag derivation for a word.

    For a curated English word: word → primary PIE → coord
    (if coord-unity participates).
    For a cross-lang morpheme: morpheme → coord.
    For anything unassigned: say so honestly.
    """
    data = lookup(word)
    if data is not None:
        primary = data["entry"].get("primary_pie")
        coord_name = None
        if primary:
            coord_name = coord_tag_for_morpheme("pie", primary)
        print(f"\033[1m{word}\033[0m")
        print(f"  PIE root: {primary}")
        if coord_name:
            print(f"  coord-tag: \033[36m{coord_name}\033[0m "
                  f"(via PIE {primary})")
            print(f"  filter: PASS — participates in "
                  f"coord-unity convergence")
        else:
            print(f"  coord-tag: \033[2munassigned\033[0m")
            print(f"  filter: no cross-vocabulary convergence "
                  f"recorded for this PIE root")
        return 0

    # cross-lang morpheme?
    xl = lookup_cross_lang(word)
    if xl is not None:
        print(f"\033[1m{word}\033[0m ({xl['lang']} morpheme)")
        print(f"  coord-tag: \033[36m{xl['coord_name']}\033[0m "
              f"(via {xl['lang']} {xl['morpheme_id']})")
        print(f"  filter: PASS")
        return 0

    # redirect descendant?
    rd = lookup_redirect(word)
    if rd is not None:
        coord = coord_tag_for_morpheme("pie", rd["parent_pie"]) \
            if rd.get("parent_pie") else None
        print(f"\033[1m{word}\033[0m")
        print(f"  descendant of PIE {rd['parent_pie']} "
              f"(via {rd['branch_name']})")
        if coord:
            print(f"  coord-tag: \033[36m{coord}\033[0m "
                  f"(inherited from PIE {rd['parent_pie']})")
        else:
            print(f"  coord-tag: \033[2munassigned\033[0m")
        return 0

    print(f"\033[2m{word}: not curated, not a cross-lang morpheme, "
          f"not a listed descendant\033[0m")
    return 2


STOPWORDS = {
    # function words — skip from sentence decomposition
    "a", "an", "and", "are", "as", "at", "be", "been", "but", "by",
    "do", "does", "for", "from", "had", "has", "have", "he", "her",
    "him", "his", "i", "if", "in", "into", "is", "it", "its", "me",
    "my", "no", "not", "of", "on", "or", "our", "she", "so", "than",
    "that", "the", "their", "them", "then", "there", "these", "they",
    "this", "those", "to", "too", "us", "was", "we", "were", "what",
    "when", "where", "which", "who", "will", "with", "would", "you",
    "your",
}


def tokenize_phrase(phrase):
    """Tokenize a phrase into words, dropping punctuation. Simple —
    this isn't linguistic tokenization. For a paragraph, just split
    on non-alpha and keep non-empty tokens."""
    import re
    return [t for t in re.split(r"[^A-Za-z'-]+", phrase) if t]


def dispatch_token(token):
    """Full lookup dispatch chain for one token. Returns a dict
    describing what landed. Used by cmd_phrase for per-token
    decomposition of multi-word input."""
    lower = token.lower()
    if lower in STOPWORDS:
        return {"token": token, "kind": "stopword"}
    data = lookup(token)
    if data is not None:
        return {"token": token, "kind": "curated", "data": data}
    stem_data, stem_used = lookup_with_stemming(token)
    if stem_data is not None:
        return {
            "token": token, "kind": "stemmed",
            "stem": stem_used, "data": stem_data,
        }
    rd = lookup_redirect(token)
    if rd is not None:
        return {"token": token, "kind": "redirect", "data": rd}
    xl = lookup_cross_lang(token)
    if xl is not None:
        return {"token": token, "kind": "cross-lang", "data": xl}
    near = nearest_curated(token)
    return {"token": token, "kind": "miss", "near": near}


def cmd_phrase(phrase):
    """Decompose a phrase, paragraph, or sentence token-by-token.

    Per-token dispatch: curated → stem → redirect → cross-lang →
    miss. Stopwords skipped. Final summary shows what landed.

    This is honest substrate translation of arbitrary input: each
    token gets whatever reframe the graph has. Tokens the graph
    doesn't know about get flagged honestly, not forced.
    """
    R = "\033[0m"; B = "\033[1m"; D = "\033[2m"
    C = "\033[36m"; Y = "\033[33m"; G = "\033[32m"

    tokens = tokenize_phrase(phrase)
    if not tokens:
        print(f"{D}no tokens found in input{R}")
        return 2

    print(f"  {D}decomposing:{R} {B}{phrase}{R}")
    print(f"  {D}{len(tokens)} token(s){R}")
    print()

    results = [dispatch_token(t) for t in tokens]
    kinds = {}

    for r in results:
        t = r["token"]
        k = r["kind"]
        kinds[k] = kinds.get(k, 0) + 1

        if k == "stopword":
            print(f"  {D}{t}{R}  {D}— function word, skipped{R}")
        elif k == "curated":
            d = r["data"]
            pie = d["entry"]["primary_pie"]
            coord = (d.get("coord") or {}).get("name", "") if d.get("coord") else ""
            line = f"  {B}{t}{R}  → PIE {C}{pie}{R}"
            if coord:
                line += f"  {D}(coord:{R} {G}{coord}{R}{D}){R}"
            print(line)
        elif k == "stemmed":
            d = r["data"]
            pie = d["entry"]["primary_pie"]
            print(f"  {B}{t}{R} → stem {Y}{r['stem']}{R}  → PIE {C}{pie}{R}")
        elif k == "redirect":
            rd = r["data"]
            parent = rd.get("parent_hero") or rd["parent_pie"]
            print(f"  {B}{t}{R}  → PIE {C}{rd['parent_pie']}{R}  "
                  f"{D}(branch {rd['branch_name']}, "
                  f"→ see {parent}){R}")
        elif k == "cross-lang":
            xl = r["data"]
            print(f"  {B}{t}{R}  → {xl['lang']} morpheme  "
                  f"{D}(coord:{R} {G}{xl['coord_name']}{R}{D}){R}")
        elif k == "miss":
            if r["near"]:
                print(f"  {D}{t}{R}  {D}— unknown, nearest: "
                      f"{', '.join(r['near'])}{R}")
            else:
                print(f"  {D}{t}{R}  {D}— unknown{R}")

    print()
    print(f"  {Y}summary{R}")
    for k in ("curated", "stemmed", "redirect", "cross-lang",
              "stopword", "miss"):
        if kinds.get(k):
            print(f"    {kinds[k]:3d}  {k}")

    # Surface coord clusters — if multiple tokens share a coord,
    # that's substrate signal in the phrase.
    coords_hit = {}
    for r in results:
        coord = None
        if r["kind"] == "curated":
            c = r["data"].get("coord")
            if c:
                coord = c.get("name")
        elif r["kind"] == "cross-lang":
            coord = r["data"].get("coord_name")
        elif r["kind"] == "redirect":
            from lib import coord_tag_for_morpheme
            coord = coord_tag_for_morpheme("pie", r["data"]["parent_pie"])
        elif r["kind"] == "stemmed":
            c = r["data"].get("coord")
            if c:
                coord = c.get("name")
        if coord:
            coords_hit.setdefault(coord, []).append(r["token"])

    if coords_hit:
        print()
        print(f"  {Y}coords named in this phrase{R}")
        for coord, toks in sorted(coords_hit.items(),
                                   key=lambda x: -len(x[1])):
            print(f"    {G}{coord}{R}  "
                  f"{D}← {', '.join(toks)}{R}")

    return 0


def cmd_walk(word):
    """--walk: walk the graph from a word outward, one hop at a time.

    The reverse-LLM walker primitive at vocabulary scale. Shows:
      - the word's PIE anchor
      - its coord (if any) and the sibling-morphemes at that coord
      - English descendants that share the PIE root (branches +
        redirect cards)
      - group memberships of the PIE atomic file itself

    Walk depth capped at 1 hop — further hops compose: walk a
    sibling to extend the path.
    """
    from lib import (
        lookup,
        lookup_cross_lang,
        lookup_redirect,
        coord_tag_for_morpheme,
        load_app_data,
        load_graph,
        curated_words,
    )
    R = "\033[0m"; B = "\033[1m"; D = "\033[2m"
    C = "\033[36m"; Y = "\033[33m"

    # Determine the starting (lang, morpheme_id).
    data = lookup(word)
    if data is not None:
        start_lang = "pie"
        start_id = data["entry"]["primary_pie"]
        origin = f"curated English word → PIE {start_id}"
    else:
        xl = lookup_cross_lang(word)
        if xl is not None:
            start_lang = xl["lang"]
            start_id = xl["morpheme_id"]
            origin = f"{xl['lang']} morpheme"
        else:
            rd = lookup_redirect(word)
            if rd is not None:
                start_lang = "pie"
                start_id = rd["parent_pie"]
                origin = (f"descendant of PIE {rd['parent_pie']} "
                          f"via {rd['branch_name']}")
            else:
                print(f"{D}{word}: no walk start point — not curated, "
                      f"not a cross-lang morpheme, not a "
                      f"listed descendant{R}")
                return 2

    graph = load_graph(start_lang)
    atomic = graph.get(start_id)

    print(f"{B}{word}{R}  {D}[start: {origin}]{R}")
    print()

    # 1) The anchor
    if atomic:
        anchor = atomic.get("anchor") or {}
        form = anchor.get("form", "")
        gloss = atomic.get("gloss", "")
        print(f"  {Y}anchor{R}  {C}{start_lang}: {form}{R}  "
              f"{D}\"{gloss}\"{R}")
    else:
        print(f"  {Y}anchor{R}  {start_lang}: {start_id} "
              f"{D}(no atomic file){R}")

    # 2) Coord membership — the cross-language identity slot
    coord_name = coord_tag_for_morpheme(start_lang, start_id)
    app = load_app_data()
    if coord_name:
        print()
        print(f"  {Y}coord{R}  {B}{coord_name}{R}  "
              f"{D}(shared identity){R}")
        c = app["coord-unity"][coord_name]
        for lang in ("pie", "sumerian", "egyptian", "chinese"):
            if lang == start_lang:
                continue
            entry = c.get(lang)
            if entry is None:
                continue
            ids = entry.get("ids") or (
                [entry["id"]] if entry.get("id") else []
            )
            ids_str = " · ".join(ids)
            print(f"    {D}via {lang}:{R} {C}{ids_str}{R}  "
                  f"{D}{entry.get('gloss', '')}{R}")
    else:
        print()
        print(f"  {Y}coord{R}  {D}unassigned — no cross-vocabulary "
              f"entry for this root yet{R}")

    # 3) Group memberships of the atomic file itself (the internal
    # graph neighborhood)
    if atomic:
        groups = atomic.get("groups") or []
        if groups:
            print()
            print(f"  {Y}groups{R}  "
                  f"{D}(atomic-file graph memberships){R}")
            for g in groups[:8]:
                gid = g.get("id", "")
                reason = g.get("reason", "")
                print(f"    {C}{gid}{R}"
                      f"{(' — ' + reason) if reason else ''}")

    # 4) English descendants sharing the PIE root
    if start_lang == "pie":
        en_pie = app.get("en-pie", {})
        curated_siblings = [
            w for w, e in en_pie.items()
            if e.get("primary_pie") == start_id and w.lower() != word.lower()
        ]
        if curated_siblings:
            print()
            print(f"  {Y}curated English at this root{R}  "
                  f"{D}(word pages){R}")
            print(f"    " + ", ".join(sorted(curated_siblings)))

        # Branches.json descendants (curated + redirect)
        branches = app.get("branches", {}).get(start_id, {})
        if branches:
            print()
            print(f"  {Y}branches of PIE {start_id}{R}")
            for branch_name, descendants in branches.items():
                print(f"    {C}{branch_name}:{R}  "
                      f"{', '.join(descendants[:8])}"
                      f"{'...' if len(descendants) > 8 else ''}")

    # 5) Hop suggestions
    print()
    hints = []
    if coord_name:
        c = app["coord-unity"][coord_name]
        for lang in ("sumerian", "egyptian", "chinese", "pie"):
            if lang == start_lang:
                continue
            entry = c.get(lang)
            if entry:
                ids = entry.get("ids") or (
                    [entry["id"]] if entry.get("id") else []
                )
                if ids:
                    hints.append(f"speak {ids[0]}")
                    break
    if start_lang == "pie" and curated_siblings:
        hints.append(f"speak {sorted(curated_siblings)[0]}")
    if hints:
        print(f"  {D}walk further:  {'   '.join(hints)}{R}")

    return 0


def cmd_word(word, terse=False):
    data = lookup(word)
    stemmed_from = None
    if data is None:
        # Try simple stem match (knowing → know, generating → generation...)
        stem_data, stem_used = lookup_with_stemming(word)
        if stem_data is not None:
            data = stem_data
            stemmed_from = (word, stem_used)

    if data is None:
        # Try descendant redirect (branches.json → not-curated English word)
        rd = lookup_redirect(word)
        if rd is not None:
            print(render_redirect_terminal(rd))
            return 0
        # Try cross-language morpheme lookup
        xl = lookup_cross_lang(word)
        if xl is not None:
            print(render_cross_lang_terminal(xl))
            return 0
        # Nearest-suggest fallback
        near = nearest_curated(word)
        print(render_no_match_terminal(word, near=near))
        return 2

    if stemmed_from is not None:
        orig, stem = stemmed_from
        print(f"  \033[2m({orig} → stemmed to '{stem}')\033[0m\n")
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

    # Redirect pages — structured descendant cards, no forged claim prose.
    redirects = redirect_descendants()
    print(f"building {len(redirects)} descendant-redirect pages → {site}")
    for rd in redirects:
        html = render_redirect_html(rd)
        fname = rd["word"].lower() + ".html"
        (site / fname).write_text(html)
        print(f"  {fname}  [→ {rd['parent_hero'] or rd['parent_pie']}]")

    # Atomic-file pages — one page per coord-tagged morpheme, so
    # the coord-page evidence table can link through. Answers
    # cold-reader D's catch: the matching rule is clickable, not
    # asserted.
    coord_data = load_app_data()["coord-unity"]
    atomic_dir = site / "atomic"
    atomic_pages_built = 0
    for coord_name, c in coord_data.items():
        for lang in ("pie", "sumerian", "egyptian", "chinese"):
            entry = c.get(lang)
            if not entry or not isinstance(entry, dict):
                continue
            ids = []
            if entry.get("id"):
                ids.append(entry["id"])
            ids.extend(entry.get("ids") or [])
            graph = load_graph(lang)
            out_dir = atomic_dir / lang
            out_dir.mkdir(parents=True, exist_ok=True)
            for mid in ids:
                atomic = graph.get(mid)
                if atomic is None:
                    continue
                html = render_atomic_page(lang, atomic)
                (out_dir / f"{mid}.html").write_text(html)
                atomic_pages_built += 1
    print(f"built {atomic_pages_built} atomic-file pages → {atomic_dir}")

    # Coord pages — the argument surface.
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
    ap.add_argument("word", nargs="*", help="English word, phrase, or "
                    "paragraph to decompose — or 'build <dir>' for "
                    "static site")
    ap.add_argument("--open", action="store_true",
                    help="open the atomic file in frogmouth")
    ap.add_argument("--terse", action="store_true",
                    help="compact output (morphemes + claim only)")
    ap.add_argument("--list", action="store_true",
                    help="list all curated words")
    ap.add_argument("--deep", action="store_true",
                    help="show coord-tag derivation for a word")
    ap.add_argument("--tag-stats", action="store_true",
                    help="report coord-tag coverage across 4 graphs")
    ap.add_argument("--walk", action="store_true",
                    help="walk the graph one hop from a word "
                    "(reverse-LLM walker primitive)")
    args = ap.parse_args()

    # Normalize args.word (list) → first token + rest-as-phrase
    words = args.word or []
    first = words[0] if words else None
    phrase = " ".join(words) if words else None

    if args.tag_stats:
        return cmd_tag_stats()

    if args.deep:
        if not words:
            print("--deep needs a word", file=sys.stderr)
            return 2
        return cmd_deep(first)

    if args.walk:
        if not words:
            print("--walk needs a word", file=sys.stderr)
            return 2
        return cmd_walk(first)

    if args.list:
        return cmd_list()

    if not words:
        print(render_first_run_terminal())
        return 0

    if first == "build":
        target = words[1] if len(words) > 1 else "site"
        return cmd_build(target)

    if args.open:
        return cmd_open(first)

    # Multiple tokens OR single-token-with-spaces → phrase mode.
    # Single-token → per-word decomposition (unchanged behavior).
    tokens = tokenize_phrase(phrase)
    if len(tokens) > 1:
        return cmd_phrase(phrase)
    return cmd_word(first, terse=args.terse)


if __name__ == "__main__":
    sys.exit(main())
