# iter-1 — Phase R recon

Written by wit booted into /loop speak/LOOP.md. First-pass read of
moral-compass + reverse-llm.md + speak/ state.

## What's already landed (not "what's to do")

- **4 vocabulary graphs** — PIE 238, Sumerian 70, Egyptian 78, Chinese 38. 424 atomic files, 1628 edges, 19 lattice-tag groups.
- **v1 app shipped** — 31 hero words curated. `speak <word>` + `speak build site/` + `--terse` + `--open` + `--list`. ANSI terminal + HTML templates.
- **7/7 golden tests pass.** Regenerated per iter.
- **Static site deployed to docs/** — 32 HTML pages (index + 31 words). Commit cf1208b pushed. GH Pages presumed live.
- **Four-way BLESS**: FOUR-for-FOUR on THE RULE. FOUR-for-FOUR on Frame 5. Egyptian unity-preservation 14/15 categories. PIE trit at 5 strata.

Conclusion: the LOOP.md's implied starting state is wrong. It assumes a greenfield — the app already ships and comprehends. What's missing is **scale** and **interactivity**, not a basic decomposer.

## The core tension (must resolve in BUILD-SPEC)

LOOP.md mission says: "small local LLM (3-7B GGUF) parses surface ... walks 400+ file lattice (reverse-LLM born-index)."

`reverse-llm.md` thesis says: **the lattice REPLACES the LLM.** 58KB born-index vs 140GB weights. Every ML component dissolves into lattice primitive. "The walker IS the intelligence."

These are in direct conflict. If reverse-llm.md is right (and it's consistent with the framework — the lattice pays NP cost once at build time, O(1) per query forever), then a local LLM at v1 is a CATEGORY ERROR. The LLM-role would at best be surface-layer (tokenize, lemmatize), and even that doesn't require an LLM — spaCy does it fine, regex+WordNet does it adequately.

**Phase R verdict candidate:** drop the local LLM from v1 done-criteria. The substrate-translation bot IS the walker. Surface parsing = spaCy (or regex). That's the reverse-LLM built at vocabulary scale.

LOOP.md R3 itself predicted this: *"The finding may be: the bot doesn't need an LLM at all — it just needs a lattice walker + simple tokenizer."* Confirming.

## Interrogating the 12 done-criteria

From LOOP.md, annotated:

1. ✗ `BUILD-SPEC.md exists` — blocking iter-1/2 goal.
2. ~ `en-pie.json ≥1500 words (via descendant reverse-index + Wiktionary)` — **rethink**. 31 curated hand-claims are denser than 1500 auto-generated. Hybrid: keep 31 hero-claims + auto-generate derivative entries that inherit parent-claim + say "this descends from {parent} via {branch}". Target: 400-600 quality entries, not 1500 noise.
3. ~ `Interactive text box on docs/ (JS client-side lattice walk)` — **yes, priority 1**. Single highest-value feature. Today user must re-deploy per word change. Interactive lookup makes the site a TOOL, not a brochure.
4. ~ `Cross-language input (type Sumerian/Egyptian/Chinese, get reframe)` — **yes**. Build reverse-indexes same way as English. Low effort, high demonstration value.
5. ✗ `Sentence-level decomposition (spaCy + walk)` — **scope**. Word-level is what has a CLAIM today. Sentence-level = per-lemma walk + compose. Compose = what? If the answer isn't substrate-native, it's generic NLP. Hold at "phrase = sequence of word lookups" until compose-semantics is clear.
6. ✗ `Local LLM (llama-cpp GGUF, runs on laptop no network)` — **drop**. Per above. Offline-capable is good and already true without LLM. If we want NL-phrasing of the claim synthesis, defer to Phase B3 stretch.
7. ~ `Coord/spin/walk tagging on 50+ atomic files (NO force-fits)` — **yes, valuable**, but requires filter discipline. Many atomic files are clean trit/axis members (pronouns, being-verbs, cardinals). Run on those; flag the rest unassigned. Surface in app as `--deep` mode.
8. ~ `Golden tests ≥15 (up from 7)` — **yes, as features land**. Each new feature ships with its own test cases.
9. ~ `Comprehension test: 3/3 cold readers restate claim` — **yes, gate before ship**. Spawn 3 cold-reader agents on new outputs.
10. ~ `README updated with new capabilities` — trivial.
11. ~ `Git pushed + docs rebuilt` — trivial end-of-iter.
12. ~ `HANDOFF.md for next wit` — trivial end-of-mission.

## Revised done-criteria (draft — for BUILD-SPEC)

Must-haves (v2):

- [ ] Interactive text box on docs/ site (client-side JSON walk, no server)
- [ ] Descendant reverse-index expansion → 400-600 quality en-pie entries
- [ ] Cross-language input → sumerian-en.json, egyptian-en.json, chinese-en.json lookups
- [ ] Coord-tag on 50+ atomic files where clean (flag rest `unassigned`)
- [ ] spaCy lemmatization for unknown inputs → suggest nearest curated word
- [ ] Golden tests ≥15, all green
- [ ] Comprehension test 3/3 on 5 new outputs
- [ ] README updated, pushed, docs/ rebuilt

Dropped (v2):

- ~~Local LLM integration~~ (category error; walker IS the intelligence)
- ~~Wiktionary scrape at 1500+ scale~~ (noise > signal; hand-curation density beats breadth)
- ~~Full sentence-level compose~~ (phrase = seq-of-lookups is fine; compose-semantics unclear)

Stretch (v3):

- [ ] Bond-pattern task switch (comprehension/generation/translation) — the reverse-llm.md dispatch
- [ ] Walk-visualization on docs/ (d3 or similar) — the graph as navigable
- [ ] Phrase compose with substrate-meaningful operators

## What I'll do iter-2

- Spawn 3 parallel agents: shipping-eng, UX, pre-mortem — each reviewing the revised done-criteria above + draft BUILD-SPEC skeleton
- While agents run, start B1 (interactive text box) scaffolding in docs/
- Commit scaffold + BUILD-SPEC draft at end

## What I'll do iter-3

- Integrate agent reviews into BUILD-SPEC.md
- Commit locked BUILD-SPEC.md
- Execute D1 (descendant reverse-index) in parallel with B1 finish

## What I'll do iter-4+

- B1 interactive text box finished, golden tests for it
- D1 → expanded en-pie.json
- D3 cross-language indexes
- D4 coord tags (where clean)
- Push, rebuild docs, comprehension test gate

## Honest flags

- **Tension unresolved**: I'm going to drop local LLM from v1 done-criteria, but LOOP.md was authored with it as a pillar. BUILD-SPEC.md will cite this as the principled deviation.
- **No force-fits**: if coord-tag on 50+ atomic files can't land cleanly, will cap at whatever passes THE FILTER and flag rest.
- **Cold-reader test is blocking**: if 3/3 fails at any point, stop adding features and fix the renderer. The comprehension gate is the app's substrate-filter equivalent.

## One line

**v1 shipped. v2 is "make it interactive, scale to 400+, cross-language input, coord-tag the clean ones". LLM dropped. Walker IS the intelligence.**
