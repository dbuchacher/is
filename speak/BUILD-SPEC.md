# BUILD-SPEC — speak/ app v2

Status: **LOCKED** (iter-2 — post 3-review integration).

Supersedes LOOP.md done-criteria per LOOP.md R6.

Three adversarial reviews (shipping, UX, pre-mortem) converged on
the same diagnosis: the original draft's numeric targets
(400-600 entries, 50+ coord-tags) are force-fit generators. An
autonomous loop WILL hit the number by lowering the filter; three
weeks later the 31-hero-word signal is buried in derivative slop.
Every numeric floor has been replaced with filter-gated language.

## What's being built

The substrate-translation bot at vocabulary scale — densified on
the coord axis, not the word axis.

Input: English word OR cross-language morpheme OR lemmatizable
stem. Output: substrate decomposition with the CLAIM made
textually. Reader sees one coord-identity supported by many
vocabularies, not one word wrapped many times.

## THE RULE applied to the bot

The bot IS the operation at three apertures:

```
speak app       word → substrate decomposition
moral compass   wit  → substrate-coherent wit
reverse-LLM     any  → substrate-native reframe (born-indexed)
```

v2 navigates the lattice by coord primarily; words are apertures
on each coord, and descendants of a hero word are redirects to
their parent coord-page.

## Pillars (load-bearing decisions)

### 1. Local LLM — DROPPED completely

`reverse-llm.md` thesis: the lattice REPLACES the LLM. 58KB vs
140GB. Born-indexed. Walker IS the intelligence. Putting an LLM
on top of the lattice is a category error — reintroduces the NP
cost per query the born-index was built to avoid.

No API fallback either. Cutting the "optional API Phase-3"
sentence entirely — an API-hosted LLM is the same category error
just moved to someone else's GPU.

Surface parsing = spaCy + regex. Claim-prose = hand-written where
it exists, structured redirect where it doesn't. No NL synthesis.

### 2. No numeric quantity targets

The filter fails under numeric pressure. Replaced everywhere:

- ~~400-600 en-pie entries~~ → "ship every descendant entry that
  passes structural filter, flag the rest, count at the end"
- ~~50+ coord-tags~~ → "tag atomic files where the filter passes;
  `unassigned` is first-class output; report N/M at end"
- ~~15 golden tests~~ → "each new feature ships with its own test
  cases; total reported, not targeted"

### 3. Scale the argument surface, not the word count

Old v2 plan: expand to 400-600 word-pages, each a thin inherited
wrapper. **Dropped.**

New v2 plan: build per-coord pages from `coord-unity.json`. Each
page is one coord, the evidence from 4 vocabularies, the shared
claim once. `speak/coord/know-beget.html` is the argument surface
for `*ǵneh₃-` and its Egyptian/Chinese/Sumerian witnesses,
navigable from every English descendant as "see coord: know-beget".

Descendant English words that inherit from a hero word get
**redirect cards**: one line ("noble → see cognition (know-branch
of *ǵneh₃-)") with no forged claim prose.

### 4. Gate before scale

Cold-reader comprehension test runs on the existing 31 + newly-
added coord pages + cross-lang input, **before** any descendant
expansion. If the gate fails, iter loops through renderer fixes
ONLY; no new data expansion until comprehension lands.

### 5. STOP-THE-LINE on comprehension failure

If cold-reader gate fails, the next iteration is RENDERER AND
TESTS ONLY. No feature-adds, no data expansion, no commits
outside `render.py` + tests. After 2 rounds of renderer changes
that still miss the gate: ship partial with honest flag. Partial
beats feature-sprawl.

This resolves the LOOP.md ambiguity (DISCIPLINE says "keep going,
don't bail on convergence issues" — but "keep going" at a failed
comprehension gate means feature-drift away from the real problem.
STOP-THE-LINE is the narrow exception to keep-going).

### 6. Autocomplete over text-box

Client-side JS text-box was over-scoped (ANSI → HTML renderer
port, 400KB JSON blob, client-side lemmatizer forking from CLI,
no URL state unless explicitly added). **Dropped.**

Instead: `<datalist>` autocomplete on the existing `index.html`
index page + URL state `?w=X` that renders the relevant static
page. Half-day, not a week. Shareable-per-word (v1's pitch)
preserved.

## Done criteria — v2 final

### Must-have (gate before "done")

1. **`<datalist>` autocomplete + URL state `?w=X`** on
   `docs/index.html`. Type a word, see dropdown, hit enter → load
   `<word>.html`. Bookmark-able, shareable.
2. **Per-coord pages** built from `coord-unity.json`. One page
   per coord, four-vocabulary evidence, shared claim. Every
   hero-word page links to its coord page. Count at end.
3. **Coord-unity audit.** Before cross-lang expansion, count
   existing entries. Report N. If N < 10 clean entries,
   iter-before-expansion is adding entries, not reverse-indexing.
4. **Cross-language input** — `sumerian-en.json`,
   `egyptian-en.json`, `chinese-en.json` reverse-indexes. Input
   `xin` → redirect to `coord/know-beget.html`. Every morpheme in
   a coord-unity entry is looked up-able. Morphemes NOT in any
   coord-unity get `"see <lang-id>.md"` — honest, not forged.
5. **Lemmatize unknown words** — spaCy stems; if no match,
   suggest 3 nearest curated words.
6. **Build-time validation**: every `primary_pie` in
   `en-pie.json` resolves to an existing atomic file. Every
   coord-unity morpheme resolves to an atomic file in its graph.
   Any mismatch fails the commit.
7. **Cold-reader comprehension test** on 5 output types:
   - auto-generated redirect entry (e.g. `speak noble`)
   - cross-language input (e.g. `speak xin`)
   - per-coord page (e.g. `coord/know-beget.html`)
   - `--deep` atomic-file coord-tagged output
   - lemmatized unknown-word miss with nearest-suggest
   Gate: 3/3 readers restate the claim for each. Fails → STOP-THE-LINE.
8. **Descendant redirect cards** — structured, one-line, no forged
   prose. Filter-gated. Ship what's clean; flag the rest.
9. **Coord-tag atomic files where filter passes.** No minimum.
   `coord-tags.json` has N entries + M `unassigned`. Both numbers
   reported. Surface in CLI as `--deep`.
10. **Ship**: README + STATUS updated, commits pushed, docs/
    rebuilt, GH Pages live, HANDOFF-v2.md for next wit.

### Want (stretch, not gating)

- Per-coord pages styled as a standalone argument (not derivative
  of word pages)
- `speak --walk <word>` — walk the lattice from a seed root,
  terminal visualization, bond-pattern aware (real reverse-LLM
  primitive)

### Will not do (v2)

- Local LLM integration (category error; see Pillar 1)
- Cloud/API LLM fallback (same category error, hosted)
- JS text-box that forks CLI behavior client-side (Pillar 6)
- Wiktionary scrape at 1500+ scale (noise > signal; superseded
  by per-coord surface)
- Full sentence-level compose (unclear substrate semantics)
- Walk visualization on docs/ (eye candy, no argument surface)
- Bond-pattern dispatch as demo feature (framework-inside joke
  to cold readers)

## Falsification

- **Coord-unity.json is too thin.** If existing entries < 10
  clean cross-language coord-IDs, per-coord pages won't carry
  the four-vocabulary pitch. Mitigation: iter-4 is "audit and
  extend coord-unity" before building pages.
- **Per-coord pages feel derivative.** If 3 cold readers can't
  restate the per-coord page's claim, the renderer is wrong. Hit
  STOP-THE-LINE, fix renderer, retest. No new data.
- **Build-time validation catches mismatches we didn't expect.**
  The speak/ graphs have been edited across sessions; some atomic
  files may have been renamed. Fix references before merging.
- **Descendant redirects feel empty.** If a reader sees "noble →
  see cognition" and loses interest, the redirect is wrong shape.
  Iterate the redirect card (maybe include a two-word gloss of
  WHY this word is in this branch).

## Architecture

```
speak/
├── app/
│   ├── speak.py
│   ├── lib.py
│   ├── render.py
│   ├── expand.py                NEW — coord-page + redirect builder
│   ├── validate.py              NEW — build-time validation
│   ├── data/
│   │   ├── en-pie.json          extended with redirects
│   │   ├── branches.json
│   │   ├── coord-unity.json     audited + possibly extended
│   │   ├── coord-tags.json      NEW — atomic-file coord assignments
│   │   ├── sumerian-en.json     NEW
│   │   ├── egyptian-en.json     NEW
│   │   └── chinese-en.json      NEW
│   ├── tests/
│   │   ├── test_golden.py       extended
│   │   ├── test_validate.py     NEW
│   │   ├── test_coord_pages.py  NEW
│   │   └── test_redirects.py    NEW
├── tools/
│   └── (existing, unchanged)
├── docs/                        site output
│   ├── index.html               + <datalist> + ?w= URL state
│   ├── coord/                   NEW
│   │   ├── know-beget.html
│   │   └── ...
│   └── <word>.html              existing 31 + redirects
├── BUILD-SPEC.md                this file
├── STATUS.md
├── LOOP.md
├── HANDOFF-v2.md                at end of run
└── scratch/                     iter notes
```

## Build plan (revised — gate before scale)

Realistic estimate per shipping review: 12-15 iterations / 10-14
hours. Given the 6-hour budget, v2 may ship partial. Priority
order below is built so the most important things land first.

- **iter-1** ✓ — recon + draft
- **iter-2** ✓ — 3-review integration + locked spec (this commit)
- **iter-3** — autocomplete `<datalist>` + URL state `?w=X` on
  `docs/index.html`. Build-time validator scaffold. Commit.
- **iter-4** — audit `coord-unity.json`: count entries per coord,
  identify gaps. Report in `scratch/coord-audit.md`. If < 10
  clean, extend to ≥ 10 before next iter.
- **iter-5** — per-coord pages renderer + build ~N pages
  (N = number of clean coord-unity entries). Golden tests.
  Commit.
- **iter-6** — cross-language reverse-indexes. Morpheme →
  coord-page redirect. Golden tests. Commit.
- **iter-7** — lemmatize + nearest-suggest in CLI + web. Golden
  tests. Commit.
- **iter-8** — cold-reader comprehension gate on 5 output types.
  Spawn 3 agents × 5 outputs = 15 prompts in parallel.
- **iter-9** — if gate passes: descendant redirect cards (one-
  liner, filter-gated). Otherwise: STOP-THE-LINE, renderer fixes
  only.
- **iter-10** — coord-tag atomic files where filter passes;
  `--deep` mode. Report N tagged / M unassigned.
- **iter-11** — final tests, README, STATUS, HANDOFF. Push.

Iterations past 11 are overflow — only if time remains after ship.

## Voice + quality gates

- No hedging. "X IS Y" when the frame says so.
- Effort × precision × independent convergence for new claims.
- Numeric quantity targets are filter-antagonists; banned from
  done-criteria.
- Honest flags beat forced fits. `unassigned` is data.
- STOP-THE-LINE on comprehension-gate failure — the filter applied
  to the build process itself.

## One line

**v2 builds the argument surface on the coord axis (per-coord
pages as primary output), wires cross-language input, tags atomic
files where the filter passes, and gates scale behind a
comprehension test. No numeric targets. No LLM. Walker IS the
intelligence.**
