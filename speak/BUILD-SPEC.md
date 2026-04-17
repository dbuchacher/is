# BUILD-SPEC — speak/ app v2

Status: **DRAFT** (iter-1 of /loop). Adversarial review in iter-2.
Lock after integration.

Supersedes LOOP.md done-criteria per LOOP.md R6.

## What's being built

The substrate-translation bot at vocabulary + phrase scale.
Input: English word OR phrase OR Sumerian/Egyptian/Chinese morpheme.
Output: substrate decomposition with the CLAIM made textually.

v1 (shipped) handles 31 hand-curated hero words. v2 scales to
400-600 quality entries, adds cross-language input, adds an
interactive text box on the static site, and tags coord/spin on
atomic files where the filter passes.

## THE RULE applied to the bot itself

The bot IS the operation at three apertures:

```
speak app       word → substrate decomposition
moral compass   wit  → substrate-coherent wit
reverse-LLM     any  → substrate-native reframe (born-indexed, O(1))
```

One operation. Three inputs. The bot instantiates the operation at
the text/vocabulary layer. v2 is the second and third of these
pulled closer into the first.

## The LLM question — DROPPED from v1/v2

LOOP.md called for a 3-7B GGUF local LLM. This is rejected:

- `reverse-llm.md` thesis: the lattice REPLACES the LLM. 58KB vs
  140GB. Born-indexed. Walker IS the intelligence.
- LOOP.md R3 itself predicted this verdict: "The bot doesn't need
  an LLM at all."
- If the lattice is the LLM, putting an LLM *on top of* the lattice
  is a category error — it reintroduces the NP cost per query that
  the born-index was built to avoid.

Surface parsing (tokenize, lemmatize) = spaCy + regex. No LLM needed.
Claim-prose generation = hand-written + inherited from atomic-file
descendants. NL-synthesis of the walk = deferred indefinitely; if
wanted, an LLM call becomes an OPTIONAL Phase-3 feature via API,
not bundled.

This is the principled deviation from LOOP.md. Every other pillar
stays or sharpens.

## Done criteria — v2

### Must (gate before "done")

1. **Interactive text box on docs/** — client-side JS, loads
   en-pie.json, renders a word lookup inline with the same output
   as the CLI. No server. No page navigation. Single-page.
2. **Expanded en-pie.json → 400-600 entries** via descendant
   reverse-index (parse `Descendants:` lines in atomic files,
   invert to English→PIE map, merge with hand-curated 31).
   Auto-entries inherit parent claim + "{word} descends from
   {parent} via {branch}".
3. **Cross-language input** — sumerian-en.json, egyptian-en.json,
   chinese-en.json reverse-indexes. Type `speak xin` → get Chinese
   xin reframe + the PIE coord it sits at (via coord-unity).
4. **Coord-tag 50+ atomic files** where clean (pronouns,
   being-verbs, cardinals, trit members, axis members). Flag rest
   `unassigned`. Output: `app/data/coord-tags.json`. Surface in CLI
   via `--deep` flag.
5. **Lemmatize unknown words** — if input isn't curated, spaCy
   lemmatizes and tries stem lookup. If still no match, suggest
   3 nearest curated words.
6. **Golden tests ≥15** — cover text-box, cross-lang, coord tags,
   lemmatization, nearest-suggest.
7. **Comprehension test 3/3** on 5 new outputs (cold-reader
   agents). Blocks ship if fails.
8. **Ship**: README + STATUS updated, commits pushed, docs/
   rebuilt, GH Pages live.
9. **HANDOFF-v2.md** for next wit.

### Want (stretch, not gating)

- Bond-pattern task switch (comprehension/generation/translation)
  — real reverse-LLM dispatch per `reverse-llm.md`
- Walk visualization on docs/ (atomic file as node, links as edges)
- Phrase compose with substrate-meaningful operators

### Will not do (v2)

- Local LLM integration (see above)
- Wiktionary scrape at 1500+ scale (noise > signal)
- Full sentence-level compose (unclear substrate semantics)
- Heavyweight ML deps (Transformers, GPU libs, HuggingFace)

## Falsification

What would prove this can't work:

- **Descendant reverse-index produces nonsense.** If autowired
  entries have no visible substrate-connection to the parent claim
  (just "descends from X" with no structural warrant), the scale
  dimension fails. Mitigation: spot-check 50 auto-entries with
  filter; if <80% pass a quick BLESS, abort expansion and stay at
  hand-curated scale.
- **Coord-tagging force-fits 80%+ of files.** If most atomic files
  don't map cleanly to coords, "50+ tagged cleanly" won't land.
  Mitigation: honest flag "N tagged, M unassigned" and report what
  it means. Unassigned is data.
- **Cold-reader gate fails repeatedly.** If three rounds of
  rendering changes can't get 3/3 comprehension, the output spec
  is wrong. Stop feature-adding, rewrite output, iterate.
- **Interactive text box adds nothing over static pages.** If
  user-experience review says "just typing URL is faster", cut
  feature and invest in content instead.

## Architecture

```
speak/
├── app/                    v1 entry (unchanged structure)
│   ├── speak.py
│   ├── lib.py
│   ├── render.py
│   ├── data/
│   │   ├── en-pie.json     expanded: 31 → 400-600
│   │   ├── branches.json
│   │   ├── coord-unity.json
│   │   ├── coord-tags.json NEW — atomic-file coord assignments
│   │   ├── sumerian-en.json NEW
│   │   ├── egyptian-en.json NEW
│   │   └── chinese-en.json  NEW
│   ├── tests/
│   │   ├── test_golden.py  extended 7 → 15+
│   │   └── test_expand.py  NEW — descendant-index sanity
│   └── web/                NEW
│       ├── search.js       client-side lookup
│       └── index.html      text-box + result area
├── tools/
│   └── expand.py           NEW — descendant reverse-index builder
├── BUILD-SPEC.md           this file
├── STATUS.md               updated per iter
├── LOOP.md                 unchanged
├── HANDOFF-v2.md           end of run
└── scratch/                iter notes
```

## Build plan (iteration-ordered)

- **iter-1**: recon + this draft (done)
- **iter-2**: adversarial review (3 parallel agents), integrate
- **iter-3**: B1 scaffold — web/index.html + search.js + JSON
  embed. Simplest inline-lookup. Commit.
- **iter-4**: D1 descendant reverse-index — expand.py + new
  en-pie.json entries. Commit.
- **iter-5**: D3 cross-language reverse-indexes. Commit.
- **iter-6**: D4 coord-tags (clean ones only). Commit.
- **iter-7**: B2 lemmatization fallback + nearest suggest. Commit.
- **iter-8**: extend golden tests. Commit.
- **iter-9**: comprehension test (spawn 3 cold-reader agents).
  Iterate renderer if fails.
- **iter-10**: final README/STATUS/HANDOFF. Push + rebuild docs.

Sub-iterations likely to split further as work lands.

## Voice + quality gates

Every entry and claim passes through wit.md voice + 3-confs filter:

- No hedging. "X IS Y" when the frame says so.
- Effort × precision × independent convergence required for new
  cross-vocabulary claims.
- No modern-English abstracts in definition-level prose.
- Honest flags (`unassigned`, `no clean form`) beat forced fits.
- Comprehension gate = the filter applied to UX.

## One line

**v2 scales the vocabulary bot to 400+ entries across 4 languages,
adds an interactive lookup on the site, and tags coord/spin where
the filter passes. Local LLM dropped. Walker IS the intelligence.**
