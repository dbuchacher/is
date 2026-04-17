# speak/sumerian — cross-vocabulary substrate test

## Goal

Apply the same graph discipline to Sumerian as `../speak/` applied
to PIE. If THE RULE holds, an honest self-referential Sumerian
morpheme graph should surface the same substrate features the PIE
graph surfaced (trit, loop, hub, identity) through completely
independent roots.

Sumerian is a language isolate — no family, no sisters, no shared
ancestor with PIE. If both surface the same frame items, that's
independent convergence at the vocabulary layer. Third independent
source (Egyptian) gives three-way convergence → body-quality signal
(promote from `3-confs/` to `1-folders/`).

## Why Sumerian

- **Isolate**. No PIE contamination.
- **Oldest attested**. Written record 3500-2000 BCE, ~1000 attested
  morphemes, not reconstructed but preserved on tablets.
- **Agglutinative and compositionally transparent**. Sumerians
  built complex words by stacking roots (*lú-gal* = big-man = king;
  *é-gal* = big-house = palace). Transparent composition is ideal
  for a self-referential graph.
- **Known polysemy unity**. Multiple Sumerian morphemes name
  concepts modern languages treat as separate coords: `an` =
  sky=god, `ki` = earth=place, `ud` = day=sun=light=time, `zu` =
  tooth=know, `ŋeštug` = ear=wisdom, `til` = live=complete.
  Pre-test evidence that Sumerian preserved substrate unity that
  other tongues split.

## Method — same as PIE

Per `../README.md` and `../../wit.md § Rules for building`.

1. **Seed set**: ~25 Sumerian morphemes grounded in deixis
   (pronouns, basic deictics, basic being, basic perception,
   cosmic axes). Seeds defined via pointing; everything else
   defined via seeds + already-defined morphemes.
2. **Atomic files** per morpheme, one paragraph definition, 4-8
   group memberships, no modern abstracts in prose.
3. **Discipline**: no PIE vocabulary in Sumerian definitions (this
   is the cross-test; don't cross-contaminate). Each graph stands
   alone.
4. **Verify** (`tools/verify.py`): dependency check + forbidden
   vocabulary + cycle check (same tool as PIE).
5. **Emerge** (`tools/emerge.py`): identify lattice-tag candidates
   (3+ members in 3+ categories).
6. **Cross-compare**: does Sumerian surface trit, loop, hub,
   identity? Via which morphemes? Note where PIE and Sumerian
   agree on substrate coord.

## Source

Morpheme inventory drawn from
`../../4-logs/wit/thoughts/etymology/sumerian.md` (~100 morphemes
with glosses and polysemy notes, compiled from standard
Assyriological sources).

## Files

- `README.md` (this)
- `data/seeds.md` — seed set + rationale
- `data/lattice-tags.md` — emerged framework mappings
- `data/emergence.md` — machine-generated (by emerge.py)
- `roots/*.md` — atomic morpheme files
- `tools/verify.py`, `tools/emerge.py` — same tools as PIE

## Status

See `STATUS.md` in this directory.
