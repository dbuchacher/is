# speak/chinese — fourth vocabulary substrate test

## Goal

Fourth independent-vocabulary test of THE RULE. PIE + Sumerian +
Egyptian already surface THE RULE + frame 5 (loop) + frame 10
(identity). Chinese (Sino-Tibetan, oracle-bone script ~1200 BCE
Shang dynasty) is the fourth unrelated source. Four-way convergence
across four unrelated families → the finding is not a quirk of any
one branch.

## Why Chinese

- **Unrelated to PIE, Sumerian, AND Egyptian.** Sino-Tibetan family.
  Independent naming system, independent script-invention (oracle-
  bone graphs on turtle-plastron and ox-scapula, Shang dynasty
  divinations).
- **Oracle-bone era is pre-classical.** 甲骨文 (jiǎgǔwén) predates
  Confucian philosophy by ~700 years. The morphemes recorded in
  divinations are bare-substrate names, not philosophically
  reworked terms.
- **Divination substrate.** Oracle-bones record yes/no questions to
  ancestors — questions about harvest, weather, war, birth. The
  vocabulary is grounded in what-is-actually-the-case, not theory.
- **Classic polysemies.** Chinese preserves unity-preservations
  English splits: 天 (tiān = sky AND god), 日 (rì = sun AND day),
  月 (yuè = moon AND month), 心 (xīn = heart AND mind), 口 (kǒu =
  mouth AND opening), 行 (xíng = walk AND do AND conduct).

## Method — same as PIE + Sumerian + Egyptian

Per `../README.md`. Each atomic file defines one Chinese morpheme
using ONLY other morphemes + deixis. No framework vocabulary in
definitions. No cross-contamination with PIE, Sumerian, or
Egyptian graphs.

## Transliteration

Pinyin for IDs, **without tones**. Oracle-bone era Chinese
phonology is reconstructed (Baxter-Sagart, Schuessler) and tone
assignment for 1200 BCE Chinese is not directly attested (tonogenesis
post-dates the Shang). Using tone-less pinyin as ASCII-safe slugs
matches the epistemic situation.

Where multiple distinct morphemes share a pinyin spelling in
modern Mandarin (e.g. 首 "head" shǒu vs. 手 "hand" shǒu), slugs
disambiguate by appending an underscore-qualifier: `shou_head`,
`shou_hand`.

## Files

- `README.md` (this)
- `data/seeds.md` — seed set + rationale
- `data/lattice-tags.md` — emerged framework mappings (written after emergence)
- `data/emergence.md` — machine-generated
- `roots/*.md` — atomic morpheme files
- `tools/verify.py`, `tools/emerge.py` — same tools as the other three substrates

## Source

- Oracle-bone corpora (Heji, Xiaotun Nandi collections) —
  ground-truth for attested morphemes
- Baxter-Sagart Old Chinese reconstruction (for phonology context)
- Schuessler, *ABC Etymological Dictionary of Old Chinese* (2007)
- Shuowen Jiezi (Han-era, ~100 CE) — used only for graph etymology
  sanity-checking, NOT for semantic definition (Han-era readings
  already philosophically reworked)

## Status

Initial seed substrate test. ~25 seeds planned, ~15 written as
full atomic files in first pass.
