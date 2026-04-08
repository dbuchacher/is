# codex/ — lattice translation work

The verb/noun/sentence/text mapping work for the lattice framework.
This is the live workspace for mapping English (and eventually all
language) onto the 4-axis lattice from `wit/mind/`.

─────────────────────────────────────────────────────────────────────

## Start here

If you're a new wit reading this, read in this order:

1. **`lattice.md`** — THE FRAMEWORK. Read this first. Defines the
   4 axes, the 8 atoms, the derivation rule, the container/origin
   layer, the 32-bond polarity, and 19 nuance sections explaining
   things future wits need to know.

2. **`composition.md`** — How sentences compose from word coords.
   The · operator, ρ accumulation, 9 base composition rules, worked
   examples.

3. **`rules.md`** — 35 derivation rules discovered through doing the
   work. These are patterns that emerged from translation, not
   stipulated in advance. Each traces back to the 8 atoms.

Then explore the vocabulary and text translations as needed.

─────────────────────────────────────────────────────────────────────

## File index

### Framework
- `lattice.md` — the core framework + nuances + status
- `composition.md` — sentence composition rules
- `rules.md` — 35 derivation rules + 5 proposed
- `text-shapes.md` — multi-text genre comparison table

### Vocabulary derivations
- `verbs.md` — ~190 verbs derived from 8 atoms
- `nouns.md` — ~200 nouns by static-feature decomposition
- `modifiers.md` — adjectives + adverbs (axis projections)
- `function-words.md` — prepositions, conjunctions, articles, modals
- `vocabulary-extended.md` — long-tail vocabulary (~100 words)
- `vocabulary.md` — auto-compiled master index (555+ unique words)

### Test sentences
- `sentences.md` — 25 worked sentence translations from atomic to
  multi-clause with negation, conditionals, embedded clauses

### Real text translations
- `genesis-1.md` — Genesis 1:1-5 (religious narration)
- `genesis-2-3.md` — Genesis 1:6-13 (Days 2 and 3)
- `lords-prayer.md` — Matthew 6:9-13 (religious petition)
- `beatitudes.md` — Matthew 5:3-12 (signal +15, NEW MAX)
- `the-road.md` — Frost "The Road Not Taken" (secular poetry)
- `hamlet.md` — "To be or not to be" (philosophical drama)
- `newton-1.md` — Newton's First Law (scientific physics)
- `short-texts.md` — haiku + Beatles + news headline

### Programmatic tools
- `verify.py` — Python verifier (independently checks the math)
- `translate.py` — Automated English→coord translator with stemmer

### Source data
- `top-1000-english.txt` — top 1000 English words by frequency

### Documentation (read after framework)
- `showcase.md` — 5-minute pitch with the cogito-at-origin result
- `tutorial.md` — step-by-step guide to deriving a new word's coord
- `next-session.md` — prioritized work for whoever picks this up

### Audit / process
- `validation-report.md` — ~70 issues found in vocabulary derivations
- `session-2026-04-08.md` — full session log from this work session
- `README.md` — this file

─────────────────────────────────────────────────────────────────────

## Quick start: try the tools

### Verify the framework

```bash
python3 wit/codex/verify.py
```

Runs all built-in tests. Expected output: ALL PASS (atom decomposition,
antipodal pairs, origin self-duality, sentence walks, Genesis verses).

### Translate English to coords

```bash
python3 wit/codex/translate.py "I bought milk."
```

Outputs the per-word ρ trace and final coord. Try any English sentence.

```bash
python3 wit/codex/translate.py --file SOMEFILE.txt
```

Translate a whole file (continuous walk).

```bash
python3 wit/codex/translate.py --lines SOMEFILE.txt
```

Translate each line independently and report per-line + total coords.

### Look up synonyms / antonyms / neighbors

```bash
python3 wit/codex/translate.py --synonyms love
python3 wit/codex/translate.py --antonyms love
python3 wit/codex/translate.py --neighbors hat 1
python3 wit/codex/translate.py --coord '0,1,1,1'
```

These query the lattice geometrically — words at the same coord are
synonyms, words at antipodal coords are antonyms, words within
Manhattan distance N are neighbors.

### Reverse direction (compose / closest)

```bash
python3 wit/codex/translate.py --closest '+1,+1,+1,+1' 5
python3 wit/codex/translate.py --compose '+5,+4,+15,+1'
```

These work in reverse — given a target coord, find words near it
(--closest) or build a sentence whose walk approaches it (--compose,
greedy). The framework is bidirectional: words → coords (translate)
and coords → words (compose).

### Compare two texts

```bash
python3 wit/codex/translate.py --compare "I love you" "I hate you"
```

Computes the Manhattan distance between two texts on the lattice.
Tells you how close or different the texts are by lattice geometry.

### Run regression tests

```bash
bash wit/codex/corpus.sh
```

Runs translate.py on a corpus of test sentences, queries word
synonyms/antonyms, and runs verify.py. The complete regression
test suite for the framework.

─────────────────────────────────────────────────────────────────────

## What this proves

**The framework is operational on real text.** Not in theory — in
practice. You can run `verify.py` and confirm the math. You can run
`translate.py` on any English sentence and get a lattice coord. You
can look up synonyms and antonyms by lattice geometry.

**9-10 real texts have been translated**, each landing at a distinct
"shape" predicted by its genre:

  Beatitudes        signal +15  (max — 8x BLESSED)
  Lord's Prayer     signal +10
  Genesis 1         signal +5
  Frost             substance dominant
  Newton            position dominant
  Hamlet            signal NEGATIVE -7
  Pop song          balanced positive
  Haiku             cancellation pattern
  News headline     time forward

The genre-shape prediction is the framework's strongest cross-text
finding: each genre privileges certain axes, and the dominant axis
is computable from the words used.

**Nothing is fake.** Every word's coord derives from the 8 atoms via
the 4-question rule. Every sentence's coord composes via the · operator
(element-wise trit addition). The verifier confirms it. The translator
runs it. Future wits can extend it.

─────────────────────────────────────────────────────────────────────

## What's still open

- ~45 of 81 shell-1 coords are still empty
- Polysemy isn't fully handled
- Aspect (continuous, perfect) only sketched
- Cross-linguistic validation incomplete
- Color sub-axis on C is unmapped
- The translator's vocabulary is ~430 words; would benefit from more

These are refinements, not framework-breakers.

─────────────────────────────────────────────────────────────────────

## How to extend the framework

1. **Add new vocabulary**: append entries to `verbs.md`, `nouns.md`,
   `modifiers.md`, or `function-words.md`. Use the `[A,B,C,D]  WORDS`
   inline format. Re-run the parser via vocabulary.md to update the
   master index.

2. **Add new test sentences**: append to `sentences.md` with full
   ρ trace. Add to `verify.py` test_sentences() for regression.

3. **Translate a new text**: create a new file like `genesis-1.md`.
   Show the source quote, word coord lookup, per-verse trace, final
   coord, and comparison to other texts.

4. **Add to translate.py**: update the inline VOCAB dict in
   translate.py so the automated translator can handle more words.

5. **Discover new rules**: add to `rules.md`. Note the rule, why it
   emerged, and which texts confirmed it.

6. **Apply validation fixes**: read `validation-report.md`, find
   issues you can fix, update the source files, document in commit
   message.

The framework is designed to be extended. Each new text translation,
new vocabulary entry, new rule discovery makes it more useful. The
8 atoms are the only hard constraint; everything else is layered
on top via composition.
