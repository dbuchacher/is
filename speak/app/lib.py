"""
speak/app/lib.py — atomic-file parsing + data loading.

parse_atomic(path) → dict with id, category, anchor, gloss,
descendants, definition, groups, refs.

load_graph(lang) → {id: parsed_dict} for a language.

lookup(word) → full substrate decomposition.
"""
import re
import json
from pathlib import Path

# speak/app/lib.py → speak/ is parent.parent
ROOT = Path(__file__).resolve().parent.parent
ROOTS_DIRS = {
    "pie": ROOT / "roots",
    "sumerian": ROOT / "sumerian" / "roots",
    "egyptian": ROOT / "egyptian" / "roots",
    "chinese": ROOT / "chinese" / "roots",
}
APP_DATA = Path(__file__).resolve().parent / "data"

# --- regex ---
CAT_RE = re.compile(r"category:\s*(\S+)", re.I)
SEED_RE = re.compile(r"\*\*seed\*\*")
ANCHOR_RE = re.compile(r"^(PIE|Sumerian|Egyptian|Chinese):\s*(.+)$", re.M)
GLOSS_RE = re.compile(r"^Gloss:\s*(.+)$", re.M)
DESC_RE = re.compile(r"^Descendants?:?\s*(.*)$", re.M | re.I)
DEF_SECTION_RE = re.compile(r"^## Definition\s*\n(.*?)(?=\n## |\Z)", re.M | re.S)
GROUPS_SECTION_RE = re.compile(r"^## Groups\s*\n(.*?)(?=\n## |\Z)", re.M | re.S)
# root-ref in prose: [id](id.md) where label == target
LINK_RE = re.compile(r"\[([a-zA-Z0-9_-]+)\]\(([a-zA-Z0-9_-]+)\.md\)")
# group-line: "- [group-id](group-id.md) — reason"
GROUP_LINE_RE = re.compile(
    r"^\s*-\s*\[([a-zA-Z0-9_-]+)\]\(\1\.md\)\s*(?:—|-|:)?\s*(.*)$"
)


def parse_atomic(path):
    path = Path(path)
    text = path.read_text()
    root_id = path.stem

    cat_m = CAT_RE.search(text)
    category = cat_m.group(1) if cat_m else "?"

    is_seed = bool(SEED_RE.search(text))

    anchor = None
    m = ANCHOR_RE.search(text)
    if m:
        anchor = {"lang": m.group(1), "form": m.group(2).strip()}

    gloss_m = GLOSS_RE.search(text)
    gloss = gloss_m.group(1).strip() if gloss_m else ""

    desc_m = DESC_RE.search(text)
    descendants = desc_m.group(1).strip() if desc_m else ""

    def_m = DEF_SECTION_RE.search(text)
    definition = def_m.group(1).strip() if def_m else ""

    groups = []
    grp_m = GROUPS_SECTION_RE.search(text)
    if grp_m:
        for line in grp_m.group(1).split("\n"):
            m = GROUP_LINE_RE.match(line)
            if m:
                groups.append(
                    {"id": m.group(1), "reason": m.group(2).strip()}
                )

    # refs in definition — same logic as verify.py (label == target)
    refs = set()
    for m in LINK_RE.finditer(definition):
        if m.group(1) == m.group(2):
            refs.add(m.group(1))

    return {
        "id": root_id,
        "category": category,
        "is_seed": is_seed,
        "anchor": anchor,
        "gloss": gloss,
        "descendants": descendants,
        "definition": definition,
        "groups": groups,
        "refs": sorted(refs),
    }


# cache to avoid re-parsing on repeat calls
_GRAPH_CACHE = {}


def load_graph(lang="pie"):
    if lang in _GRAPH_CACHE:
        return _GRAPH_CACHE[lang]
    d = ROOTS_DIRS.get(lang)
    if not d or not d.exists():
        _GRAPH_CACHE[lang] = {}
        return {}
    out = {}
    for p in sorted(d.glob("*.md")):
        parsed = parse_atomic(p)
        out[parsed["id"]] = parsed
    _GRAPH_CACHE[lang] = out
    return out


_APP_DATA_CACHE = None


def load_app_data():
    global _APP_DATA_CACHE
    if _APP_DATA_CACHE is not None:
        return _APP_DATA_CACHE
    data = {}
    for name in ("en-pie", "branches", "coord-unity"):
        p = APP_DATA / f"{name}.json"
        data[name] = json.loads(p.read_text()) if p.exists() else {}
    _APP_DATA_CACHE = data
    return data


def find_coord_for_pie(primary_pie, coord_data):
    """Find the coord-unity group that this PIE root belongs to."""
    for coord_name, coord in coord_data.items():
        pie_entry = coord.get("pie")
        if not pie_entry:
            continue
        if isinstance(pie_entry, dict):
            if pie_entry.get("id") == primary_pie:
                return {"name": coord_name, **coord}
            ids = pie_entry.get("ids") or []
            if primary_pie in ids:
                return {"name": coord_name, **coord}
    return None


def coord_tag_for_morpheme(lang, morpheme_id):
    """Return coord_name if this morpheme participates in a coord-unity
    entry in its language slot, else None (unassigned)."""
    idx = cross_lang_index()
    return idx.get(lang, {}).get(morpheme_id)


def coord_tag_stats():
    """Return {lang: (tagged, unassigned, total)} across all 4 graphs.
    Tagged = morpheme appears in coord-unity as that lang. Unassigned
    is first-class per BUILD-SPEC — honest flag, not a failure."""
    stats = {}
    for lang in ("pie", "sumerian", "egyptian", "chinese"):
        d = ROOTS_DIRS.get(lang)
        if not d or not d.exists():
            stats[lang] = (0, 0, 0)
            continue
        all_ids = {p.stem for p in d.glob("*.md")}
        tagged = 0
        for mid in all_ids:
            if coord_tag_for_morpheme(lang, mid):
                tagged += 1
        stats[lang] = (tagged, len(all_ids) - tagged, len(all_ids))
    return stats


_CROSS_LANG_INDEX_CACHE = None


def cross_lang_index():
    """Build {lang: {morpheme_id: coord_name}} reverse index on-demand
    from coord-unity.json. Cached."""
    global _CROSS_LANG_INDEX_CACHE
    if _CROSS_LANG_INDEX_CACHE is not None:
        return _CROSS_LANG_INDEX_CACHE
    app = load_app_data()
    coord_data = app.get("coord-unity", {})
    idx = {"sumerian": {}, "egyptian": {}, "chinese": {}, "pie": {}}
    for coord_name, coord in coord_data.items():
        for lang in idx:
            entry = coord.get(lang)
            if not entry or not isinstance(entry, dict):
                continue
            ids = []
            if entry.get("id"):
                ids.append(entry["id"])
            ids.extend(entry.get("ids") or [])
            for rid in ids:
                # Prefer the first coord encountered; multiple coords
                # referencing the same morpheme is unusual and worth
                # surfacing in validation rather than silently picking.
                idx[lang].setdefault(rid, coord_name)
    _CROSS_LANG_INDEX_CACHE = idx
    return idx


SUFFIX_STRIPS = [
    # ordered longest-first
    ("ization", ""),
    ("ations", "ation"),
    ("ization", ""),
    ("izing", "ize"),
    ("ized", "ize"),
    ("izes", "ize"),
    ("ation", ""),
    ("ities", "ity"),
    ("ility", ""),
    ("ing", ""),
    ("ed", ""),
    ("ly", ""),
    ("es", ""),
    ("s", ""),
]


def simple_stem_guess(word):
    """Return a list of candidate stems to probe against curated set.

    Light stemmer — enough for common English forms. Doesn't handle
    irregular verbs; spaCy could, but adds a heavy dependency that
    the v2 budget doesn't justify for 31 curated words.
    """
    word = word.lower().strip()
    candidates = [word]
    for suffix, replacement in SUFFIX_STRIPS:
        if word.endswith(suffix) and len(word) > len(suffix) + 2:
            stem = word[:-len(suffix)] + replacement
            if stem and stem not in candidates:
                candidates.append(stem)
    return candidates


def nearest_curated(word, n=3):
    """Return up to `n` curated words nearest to `word` by difflib
    similarity. Empty list if no candidates hit the similarity floor."""
    import difflib
    words = curated_words()
    return difflib.get_close_matches(word.lower().strip(), words, n=n, cutoff=0.6)


def lookup_redirect(word):
    """Return redirect info if `word` is a descendant listed in
    branches.json but NOT curated in en-pie.json.

    Returns {parent_pie, parent_hero, branch_name, word} or None.

    parent_hero = the first en-pie curated word with primary_pie == parent_pie.
    That's the ship-to target. If no curated word exists for the parent root,
    we can still surface the PIE root itself + branch info without a hero target.
    """
    word = word.strip()
    if not word:
        return None
    app = load_app_data()
    en_pie = app.get("en-pie", {})
    if word.lower() in en_pie:
        return None  # already curated; not a redirect
    branches = app.get("branches", {})
    for pie_id, branch_map in branches.items():
        for branch_name, descendants in branch_map.items():
            if word in descendants or word.lower() in [d.lower() for d in descendants]:
                # Find a curated hero word for this pie root
                hero = None
                for w, entry in en_pie.items():
                    if entry.get("primary_pie") == pie_id:
                        hero = w
                        break
                return {
                    "word": word,
                    "parent_pie": pie_id,
                    "branch_name": branch_name,
                    "parent_hero": hero,
                }
    return None


def redirect_descendants():
    """Return all English descendants in branches.json that are NOT
    curated in en-pie.json. Used by the static-site builder to
    generate redirect pages.

    Returns list of redirect dicts (same shape as lookup_redirect returns).
    """
    app = load_app_data()
    en_pie = app.get("en-pie", {})
    en_pie_lc = {w.lower() for w in en_pie}
    branches = app.get("branches", {})
    out = []
    seen = set()
    for pie_id, branch_map in branches.items():
        hero = None
        for w, entry in en_pie.items():
            if entry.get("primary_pie") == pie_id:
                hero = w
                break
        for branch_name, descendants in branch_map.items():
            for d in descendants:
                if d.lower() in en_pie_lc or d.lower() in seen:
                    continue
                seen.add(d.lower())
                out.append({
                    "word": d,
                    "parent_pie": pie_id,
                    "branch_name": branch_name,
                    "parent_hero": hero,
                })
    return out


def lookup_with_stemming(word):
    """Try direct lookup; if miss, try simple stems; if still miss,
    return None. Returns (data, stem_used) where stem_used is None
    on direct hit, or the matched stem when a stem matched."""
    direct = lookup(word)
    if direct is not None:
        return direct, None
    for stem in simple_stem_guess(word):
        if stem == word.lower().strip():
            continue
        d = lookup(stem)
        if d is not None:
            return d, stem
    return None, None


def lookup_cross_lang(morpheme):
    """English lookup miss? Try cross-lang indexes. Returns dict with
    {lang, morpheme_id, coord_name, coord_data, atomic} or None."""
    morpheme = morpheme.strip()
    if not morpheme:
        return None
    idx = cross_lang_index()
    for lang in ("sumerian", "egyptian", "chinese", "pie"):
        # Match case-insensitive on ID — graphs use native casing
        # (e.g. sjA, Hw, xpr) which we preserve.
        for mid, coord_name in idx[lang].items():
            if mid.lower() == morpheme.lower():
                app = load_app_data()
                coord = app["coord-unity"][coord_name]
                graph = load_graph(lang)
                atomic = graph.get(mid)
                return {
                    "lang": lang,
                    "morpheme_id": mid,
                    "coord_name": coord_name,
                    "coord_data": {"name": coord_name, **coord},
                    "atomic": atomic,
                }
    return None


def lookup(word):
    """English word → full substrate-decomposition dict, or None if not curated."""
    word = word.lower().strip()
    app = load_app_data()
    entry = app["en-pie"].get(word)
    if not entry:
        return None

    primary = entry["primary_pie"]
    pie_graph = load_graph("pie")
    atomic = pie_graph.get(primary)

    branches = app["branches"].get(primary, {})
    coord = find_coord_for_pie(primary, app["coord-unity"])

    return {
        "word": word,
        "entry": entry,
        "atomic": atomic,
        "branches": branches,
        "coord": coord,
    }


def curated_words():
    """Return sorted list of all English words in en-pie.json."""
    app = load_app_data()
    return sorted(app["en-pie"].keys())


if __name__ == "__main__":
    # smoke test
    import sys
    if len(sys.argv) > 1:
        word = sys.argv[1]
        data = lookup(word)
        if data is None:
            print(f"not curated: {word}")
            print(f"curated: {', '.join(curated_words())}")
        else:
            print(json.dumps(data, indent=2, default=str))
    else:
        print("curated words:", curated_words())
