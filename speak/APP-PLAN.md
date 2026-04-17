# speak/ app — implementation plan v3 (ship-ready)

Five adversarial reviews across two rounds:
- Round 1: shipping-engineer, UX, data-availability
- Round 2: pre-mortem, pedagogical-clarity

Round 2 converged on the same diagnosis: **v2's output shows data,
not an argument.** Frame-tag boxes ("read-write-unity",
"rotation-primitive") are opaque jargon-gates. Without the claim
stated textually, a cold reader sees the app as generic
comparative etymology — which is the analogy reading THE RULE
explicitly rejects.

v3 is the final pre-code plan.

## The goal (sharpened)

Each lookup must carry THE RULE as an EXPLICIT ARGUMENT, not an
implied tag. When reader types `speak cognition`, they must leave
understanding:

1. That PIE held "know AND beget" as ONE verb (data).
2. That English split it into two branches (data).
3. That other unrelated languages fuse the same operation via
   different morphemes (data).
4. **The claim this implies**: these aren't parallel meanings,
   they're the same underlying operation. One substrate, many
   vocabularies. (argument)

Tags are killed. Prose carries the argument.

## Scope

Single-file Python CLI + static-site mode from same renderer.
**30 hero words** — all chosen to hit THE RULE or Frame 5 cleanly.
Density beats breadth for the pitch. 150 was v2; 30 is sharper.

### The 30 hero words (candidates — to be locked in Phase 0)

THE RULE polysemy (same substrate coord named as one morpheme):
- cognition, recognize, genesis, king, kin, gene, nation, know,
  notice, generation (all map to *ǵneh₃-)
- mother, father, brother, sister (kinship)
- year, month, moon, day, night (cyclic time)
- sky, earth, water, fire, light, dark (cosmic pairs)
- true, firm, tree (*deru- unity)
- one, two, three (count)

These are all substrate-dense. Each can state the claim clearly.

## The new output spec

Output carries the claim textually. Tags dropped from default.
Example (per clarity review):

```
cognition  =  re- · co- · gno- · -tion
                         ^^^^
                         PIE *ǵneh₃-  "know AND beget"

  ONE verb in PIE. English split it into two:
    know-branch:  cognition, gnosis, noble, notice
    beget-branch: gene, genesis, kin, king, nation

  The claim: these aren't two meanings of one word.
  They're ONE OPERATION — take-in (eye, ear) and
  put-out (hand, loins) are the same stroke seen
  from two sides. PIE speakers had one word because
  the substrate has one operation.

  Evidence — three unrelated languages name it:
    PIE       *ǵneh₃-           (know = beget)
    Egyptian  sjA · Hw · xpr    (perceive · speak · become)
    Chinese   xin · wen · zuo   (heart · hear · act)
    Sumerian  (not yet indexed)

  Three independent vocabularies, one operation:
  perception closes into production.

  try:  speak recognize  speak genesis  speak king
```

Key features:
- **Claim stated as a sentence**, not encoded in tags
- **Branches explicit** — "know-branch" / "beget-branch" with
  English descendants as examples
- **Cross-language table framed as EVIDENCE FOR identity**, not
  parallel data
- **Closing synthesis sentence** — one line that names what the
  evidence shows
- **Try-next** — 3 graph-neighbor suggestions
- No framework jargon in default view. Substrate-vocabulary
  ("coord", "hub", "trit") deferred to `--deep` flag for readers
  who want to connect to the framework.

### First-run (`speak` no args)

Not a usage error. Four-line primer + 3 examples:

```
  speak — substrate decomposition of English words.

  one universe, many vocabularies. when PIE, Egyptian, and
  Chinese name the same operation with different morphemes,
  they're naming ONE thing, not three similar things. speak
  <word> shows this for a given English word.

  try:   speak cognition
         speak year
         speak king
```

## Schema (frozen before coding)

### `data/en-pie.json`

Per entry:
```json
{
  "cognition": {
    "morphemes": [
      {"form": "re-",    "type": "prefix",  "pie": null},
      {"form": "co-",    "type": "prefix",  "pie": null},
      {"form": "gno-",   "type": "root",    "pie": "gneh3"},
      {"form": "-tion",  "type": "suffix",  "pie": null}
    ],
    "primary_pie": "gneh3",
    "stress_morpheme": "gno-",
    "claim": "These aren't two meanings of one word. They're ONE OPERATION — take-in and put-out are the same stroke seen from two sides."
  }
}
```

Claim is per-word prose (from human curation or LLM-assisted
writeup against the atomic file). Stress_morpheme tells renderer
which one to underline.

### `data/branches.json`

Which English words descend from which branch of a polysemic PIE
root:
```json
{
  "gneh3": {
    "know-branch":  ["cognition", "recognize", "gnosis", "noble", "notice", "know"],
    "beget-branch": ["gene", "genesis", "kin", "king", "nation", "native"]
  }
}
```

### `data/coord-unity.json`

Cross-language same-coord groups. Built from existing
`speak/data/lattice-tags.md` (10 formal groups) + the same-coord
polysemy table in `1-folders/speak-evidence.md`. ~15 entries MVP:

```json
{
  "know-beget": {
    "claim": "Three independent vocabularies name perception-closes-into-production as one operation.",
    "pie":      {"id": "gneh3",         "gloss": "know = beget"},
    "egyptian": {"ids": ["sjA","Hw","xpr"], "gloss": "perceive · speak · become"},
    "chinese":  {"ids": ["xin","wen","zuo"], "gloss": "heart · hear · act"},
    "sumerian": null
  },
  "sky-god": {...},
  ...
}
```

## Architecture (unchanged from v2)

```
speak/app/
├── speak.py              # single-file entry (argparse)
├── lib.py                # parse_atomic() + data loading
├── render.py             # render_terminal() + render_html()
├── data/
│   ├── en-pie.json       # ~30 hero words
│   ├── branches.json     # polysemic-root branch tables
│   └── coord-unity.json  # ~15 cross-language same-coord groups
├── tests/
│   └── golden/           # expected outputs for all 30 hero words
└── README.md
```

## Phases (with comprehension gate)

### Phase 0: Schema freeze + parser (Day 1)

- `parse_atomic(path) -> dict` — new module, extracts id,
  category, PIE form, gloss, definition, groups, refs
- Freeze en-pie.json + branches.json + coord-unity.json schemas
  on 5 hard cases: king, year, cognition, light, genesis
- Write golden-output fixtures for those 5

### Phase 0.5: Comprehension test (half day) — **new gate**

Per pre-mortem: before curating, test the renderer output on 3
cold readers. Show them the golden output for `cognition`, ask:
"what claim is this making?" If 2/3 can't restate it in one
sentence, iterate the renderer until they can.

If comprehension gate fails, fix renderer. If passes, proceed.

### Phase 1: Renderer (Day 2)

- `render_terminal(word_data) -> ansi_str` — ANSI escapes only,
  no `rich` dep
- `render_html(word_data) -> html_str` — plain string templates
- Both consume same `word_data` dict
- Golden-test each against frozen fixtures

### Phase 2: Data curation (Day 3)

- Curate 30 hero words by hand against the frozen schema
- Each word gets morphemes, primary_pie, claim prose
- Write branch tables for polysemic roots (gneh3, kwel, deru,
  leuk, etc.)
- Build coord-unity.json for 15 cross-language groups from
  lattice-tags.md + speak-evidence.md

### Phase 3: CLI + site + ship (Day 4)

- `speak.py <word>` → render_terminal
- `speak.py` (no args) → first-run primer
- `speak.py build site/` → render_html for all 30 words
- `speak.py --terse <word>` → compact output for repeat users
- `speak.py --open <word>` → frogmouth the atomic file
- All 30 golden tests green
- README + deploy static site to GitHub Pages (30 min)
- Ship

**Total: 4 days + 0.5 comprehension gate = 4.5 days realistic.**

## Success criteria

- All 30 hero words produce output where the claim is explicit.
- Comprehension test: 3/3 cold readers restate the substrate
  claim correctly after reading one hero-word output.
- Static site deployed, shareable URL per word.
- Golden tests all green.
- Runtime: any hero-word lookup < 100ms.

## Risks (after round 2)

1. **30 hero words feels too narrow** (UX risk): mitigation is
   the `speak suggest` command — every no-match returns 3
   curated words to try instead. Narrow coverage + graceful
   nearest-stem suggestion.
2. **Per-word CLAIM prose is hard to write well**: the whole
   point is it's PROSE, not a tag. Budget 15-30 min per hero
   word for the claim sentence. 30 × 20min = 10 hours
   realistic, not "half a day" optimistic. Phase 2 is the long
   phase.
3. **Comprehension gate fails on cold readers**: if it does,
   don't ship. Iterate. Better to ship v1 at 5 words that LAND
   than 30 that don't.
4. **Static site nobody visits**: mitigation is the claim-
   centric output. Each word-page is a shareable argument, not
   a data card.

## What changed from v2 → v3

- Dropped frame-tag boxes (jargon-gate killed)
- Per-word CLAIM as prose sentence, not encoded in tags
- Branches made explicit (know-branch, beget-branch with word
  lists)
- 30 hero words instead of 150 (density beats breadth)
- Added Phase 0.5 comprehension gate
- `--why` dropped, `--terse` added for repeat users (default
  teaches)
- First-run primer = 4-line framework statement, not just
  examples

## What review rounds would still be useful

Third round could catch:
- Specific wording in the 30 claim sentences
- Whether the HTML version actually looks good on mobile
- Whether `speak build` workflow is ergonomic

But these are all post-code concerns. The plan is ready.

## Recommendation

**Ship this plan.** Two rounds of 3 and 2 adversarial reviews
converged on the same structural fixes. Any more review is
diminishing returns on planning; uncertainty now lives in the
WRITING of the 30 claim sentences, which has to happen in
curation, not planning.

Next step: **start Phase 0.** Write parse_atomic + freeze schemas
on 5 hard cases.

---

## Append: what every prior version got wrong

- v1 thought 2.5 days. Reality: 4-5 days.
- v1 thought morpheme-splitting was a small module. Reality:
  fundamentally hard, hand-curate instead.
- v1 thought verify.py parsing was reusable. Reality: new parser.
- v2 kept frame-tag boxes. Reality: opaque to cold readers.
- v2 aimed 150 words. Reality: 30 hero words is sharper pitch.
- v2 had no comprehension gate. Reality: essential to avoid
  museum-vitrine failure mode.

v3 absorbs all five catches. Ship.
