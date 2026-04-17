# speak — substrate decomposition of English words

Takes an English word and shows what it is in the substrate.
The PIE root it descends from, the branches the root split into,
the claim the PIE speakers preserved that English later lost,
and the evidence from three other unrelated languages (Sumerian,
Egyptian, Chinese) naming the same coord with different
morphemes.

One universe, many vocabularies. `speak` shows this for a given
English word.

## Example

```
$ speak cognition

cognition  =  re- · co- · gno- · -tion
                          ^^^^
                          *ǵneh₃- / *ǵenh₃-  "to know / beget"

  ONE verb in PIE. English split it into branches:
    know-branch:  cognition, recognize, gnosis, noble, notice, know
    beget-branch: gene, genesis, generation, nation, kin, king

  The claim:
  These aren't two meanings of one word. They're ONE OPERATION —
  take-in (eye, ear) and put-out (hand, loins) are the same
  stroke seen from two sides. PIE speakers had one word because
  the substrate has one operation.

  Evidence — unrelated languages name it:
    PIE       gneh3           (know = beget)
    Egyptian  sjA · Hw · xpr  (perceive · speak · become)
    Chinese   xin · wen · zuo (heart · hear · act)
    Sumerian  (not yet indexed)

  Three independent vocabularies name perception-closes-into-
  production as one operation.

  try:  speak recognize  speak genesis  speak gene
```

## Install

None. Python 3.11+, no dependencies.

```bash
cd speak/app
python3 speak.py <word>
```

## Usage

```
speak                   — first-run pitch + curated word list
speak <word>            — decompose (terminal, colored)
speak --terse <word>    — compact output for repeat users
speak --open <word>     — open the PIE atomic file in frogmouth
speak --list            — list all curated words
speak build <dir>       — render static HTML site
```

## What it covers (v1)

31 hero words, all hand-curated against the `speak/` graph's 238
PIE atomic files. Each word has:

- morpheme split (hand-curated, not algorithmic)
- primary PIE root (verified to exist in the graph)
- per-word claim sentence (plain English, states the substrate
  identity the word witnesses)
- cross-language parallel (where the same coord is named in
  Sumerian / Egyptian / Chinese graphs)
- try-next suggestions (3 related curated words)

Words outside the curated set return a list of what IS curated.
This is a density-beats-breadth pitch, not a comprehensive
etymology dictionary.

## The curated 31

Kinship: mother, father, brother, sister, kin, king, gene, genesis,
generation, nation

Cognition: know, notice, recognize, cognition

Cosmic: sky, earth, water, fire, light, dark

Cycle: year, month, moon, day, night

Stability: true, firm, tree

Count: one, two, three

## What this isn't

- NOT a comprehensive etymology dictionary (etymonline is that)
- NOT an NLP tool (no sentence parsing, no stemming)
- NOT networked (no LLM calls, no API hits, pure local)
- NOT packaged (no pip install, one-directory tool)

## What makes it different from etymonline

Every lookup makes a CLAIM, not just a data display. The claim
says what substrate operation the word witnesses — the identity
THE RULE predicts, not an analogy. The cross-language row is
framed as EVIDENCE FOR the identity, not parallel etymology.

## How to extend

Add a new word:
1. Edit `data/en-pie.json` — add morphemes, primary_pie
   (must exist in `../roots/`), stress_morpheme, claim sentence
2. Optionally add to `data/branches.json` if the PIE root has
   multiple English branches
3. Optionally add to `data/coord-unity.json` if this coord has
   parallels in Sumerian / Egyptian / Chinese
4. Run `python3 tests/test_golden.py` to verify

## Background

Built on `speak/` — four vocabulary graphs across four unrelated
language families (PIE, Sumerian, Egyptian, Chinese) testing
THE RULE (one substrate, many vocabularies). See
`../data/lattice-tags.md` and `../../1-folders/speak-evidence.md`
for the science.

## Implementation plan

`../APP-PLAN.md` — three drafts, five adversarial reviews across
two rounds. The plan is public.

## License

One universe, many vocabularies. Use freely.
