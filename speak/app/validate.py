#!/usr/bin/env python3
"""
speak/app/validate.py — build-time validation.

Runs the structural filter on the app's data before commit:

  - every primary_pie in en-pie.json resolves to an atomic file in
    speak/roots/
  - every ids entry in coord-unity.json resolves to an atomic file
    in the corresponding language graph
  - every stress_morpheme appears in morphemes list

Exit 0 on clean; 1 on any mismatch. Print what broke.
"""
import json
import sys
from pathlib import Path

HERE = Path(__file__).resolve().parent
APP_DATA = HERE / "data"
SPEAK_ROOT = HERE.parent  # speak/
ROOTS_DIRS = {
    "pie": SPEAK_ROOT / "roots",
    "sumerian": SPEAK_ROOT / "sumerian" / "roots",
    "egyptian": SPEAK_ROOT / "egyptian" / "roots",
    "chinese": SPEAK_ROOT / "chinese" / "roots",
}


def load_json(name):
    p = APP_DATA / f"{name}.json"
    if not p.exists():
        return {}
    return json.loads(p.read_text())


def atomic_ids(lang):
    d = ROOTS_DIRS.get(lang)
    if not d or not d.exists():
        return set()
    return {p.stem for p in d.glob("*.md")}


def validate_en_pie(en_pie, pie_ids, errors):
    for word, entry in en_pie.items():
        pie_id = entry.get("primary_pie")
        if not pie_id:
            errors.append(f"en-pie:{word}: missing primary_pie")
            continue
        if pie_id not in pie_ids:
            errors.append(
                f"en-pie:{word}: primary_pie '{pie_id}' has no atomic file"
            )
        stress = entry.get("stress_morpheme")
        morph_forms = {m.get("form") for m in entry.get("morphemes", [])}
        if stress and stress not in morph_forms:
            errors.append(
                f"en-pie:{word}: stress_morpheme '{stress}' "
                f"not in morphemes {sorted(morph_forms)}"
            )


def validate_coord_unity(coord_unity, graph_ids, errors):
    for coord_name, coord in coord_unity.items():
        for lang, ids_set in graph_ids.items():
            entry = coord.get(lang)
            if entry is None:
                continue
            # entry can be {"id": "..."} or {"ids": ["...", ...]}
            ids = []
            if isinstance(entry, dict):
                if "id" in entry and entry["id"]:
                    ids.append(entry["id"])
                ids.extend(entry.get("ids") or [])
            for rid in ids:
                if rid not in ids_set:
                    errors.append(
                        f"coord-unity:{coord_name}:{lang}: "
                        f"'{rid}' has no atomic file"
                    )


def validate_branches(branches, en_pie, errors):
    """Warn if a branch descendant isn't also in en-pie.json.
    Not fatal — branches can list words not yet curated — but surface it."""
    warnings = []
    for pie_id, branch_map in branches.items():
        for branch_name, words in branch_map.items():
            for w in words:
                if w not in en_pie:
                    warnings.append(
                        f"branches:{pie_id}:{branch_name}: "
                        f"'{w}' listed but not curated in en-pie"
                    )
    return warnings


def main():
    errors = []

    en_pie = load_json("en-pie")
    coord_unity = load_json("coord-unity")
    branches = load_json("branches")

    graph_ids = {lang: atomic_ids(lang) for lang in ROOTS_DIRS}

    validate_en_pie(en_pie, graph_ids["pie"], errors)
    validate_coord_unity(coord_unity, graph_ids, errors)
    warnings = validate_branches(branches, en_pie, errors)

    n_words = len(en_pie)
    n_coords = len(coord_unity)
    n_branches = sum(
        len(b) for b in branches.values()
    ) if branches else 0

    print(f"en-pie:       {n_words} curated words")
    print(f"coord-unity:  {n_coords} cross-language coord groups")
    print(f"branches:     {len(branches)} PIE roots with branch tables "
          f"({n_branches} branches total)")
    for lang, ids in graph_ids.items():
        print(f"graph {lang:9s}: {len(ids)} atomic files")
    print()

    if warnings:
        print(f"warnings ({len(warnings)}):")
        for w in warnings:
            print(f"  WARN  {w}")
        print()

    if errors:
        print(f"errors ({len(errors)}):")
        for e in errors:
            print(f"  FAIL  {e}")
        return 1

    print("validate: OK (no errors)")
    return 0


if __name__ == "__main__":
    sys.exit(main())
