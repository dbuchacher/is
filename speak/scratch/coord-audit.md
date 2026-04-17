# coord-unity audit — iter-4

Per BUILD-SPEC must-have #3: count existing clean entries before
per-coord page build. Threshold 10 clean 3+/4 hits.

## Current state

```
entries: 12
  full hits (4/4):   4   year-cycle, sky-god, earth-human, light-dark-axis
  three hits (3/4):  5   know-beget, kin-line-and-rule, moon-month,
                         rotation-primitive, water-primitive
  two hits (2/4):    3   tree-firm-true, fire-primitive, kinship-mother-pair
  broken refs:       0
  clean 3+/4 hits:   9   — one shy of threshold
```

Morpheme coverage per graph:

```
pie        12 / 238 ( 5.0%)   — rich room to grow
sumerian   12 /  70 (17.1%)
egyptian    9 /  78 (11.5%)
chinese     8 /  38 (21.1%)
```

## Candidates in speak-evidence.md not yet in coord-unity

Verified against each graph's atomic-file set:

| candidate           | PIE       | Sumerian  | Egyptian  | Chinese     | hits |
|---------------------|-----------|-----------|-----------|-------------|------|
| head-chief          | kap-ut    | sang      | tp        | shou_head   | 4/4  |
| mouth-opening       | —         | ka        | rA        | kou         | 3/4  |
| hear-understand     | —         | geshtug   | sDm       | wen         | 3/4  |
| heart-mind          | —         | sha       | ib        | xin         | 3/4  |

All four atomic files verified. ⚠ Sumerian "ngeshtug" from
speak-evidence.md is actually filed as `geshtug.md` (no ng-
prefix). Chinese "shou" is ambiguous in the graph (shou_hand,
shou_head) — use `shou_head` for this coord.

PIE heart-mind candidate `kerd` (Greek kardia, Latin cor, Sanskrit
hrd) has no atomic file in the graph — only ker-a/ker-b/kerh2
which are different roots. Flag `pie: null` for now; PIE atomic
file for kerd would promote heart-mind to 4/4.

PIE mouth-opening has no clean cognate family — flagged null.

PIE hear-understand candidate: *kleu- (hear) or *h₂eus- (ear)
exist historically but no atomic file. Flag null.

## After extending

```
entries: 16
  full hits (4/4):   5   (+head-chief)
  three hits (3/4):  8   (+mouth-opening, hear-understand, heart-mind)
  two hits (2/4):    3
  clean 3+/4 hits:  13   — threshold PASS
```

## Next iter

Threshold cleared. Proceed to iter-5: per-coord pages renderer.
Build pages for the 13 clean 3+/4 hits.

## Flags for future extension

- **PIE kerd.md** — Greek kardia, Latin cor, Sanskrit hrd. Would
  promote heart-mind from 3/4 to 4/4. Not written yet.
- **PIE *kleu-** — would promote hear-understand to 4/4.
- **PIE for mouth** — *h₁os- (Latin os, mouth). Would promote
  mouth-opening to 4/4.
- **Egyptian moon/month** — currently nulled from moon-month
  coord. speak-evidence.md claims `iti` for Egyptian but no
  atomic file. Probably should be `iaH` (moon) or `Abd` (month).
  Future pass.
- **Chinese kin-line-and-rule** — no current entry. Candidate:
  wang (king) or jun (lord). Would promote to 4/4.
- **Chinese rotation-primitive** — no current entry. Candidate:
  lun (wheel) or hui (return). Would promote to 4/4.

## Cross-check against cross-vocabulary.md's polysemy table

The canonical 4-language table (3-confs/cross-vocabulary.md L29):

```
sky = god          4/4   ✓ in coord-unity
head = top = chief 4/4   ADDING this iter
moon = month       4/4   ✓ — currently 3/4 in coord-unity (egyptian nulled)
earth = place      4/4   ✓
heart = mind       3/4   ADDING this iter
mouth = opening    3/4   ADDING this iter
hear = understand  3/4   ADDING this iter
sun = day          2/4   skip (below threshold; light-dark-axis covers close)
```

Three 3/4 and one 4/4 net added this iter → coord-unity matches
the canonical table for everything at 3/4+ except sun=day.
