# pie-speak — substrate features emerged from self-referential PIE graph

Status: **signal, verified inside experiment**. Ready for body
promotion pending cross-vocabulary corroboration (Sumerian, Egyptian).

**What this is**: `/home/maxi/code/is/speak/` reconstructs ~230
Paleolithic + Bronze-Age PIE roots by defining each using only other
roots + deixis. No framework vocabulary, no top-down imposition, no
substrate language in definitions. Then checks whether framework
substrate features emerge from the resulting dependency graph.

They do. At five independent strata of one language.

## Frame items that matter

- **THE RULE** (one substrate, many vocabularies) — predicts that
  building an honest self-referential graph in one vocabulary
  should surface substrate structure from the inside.
- **Frame 2** (the trit ↑↕↓) — PIE being-verbs already documented
  at [1-folders/trits.md](../1-folders/trits.md). Experiment extends trit
  to 5 independent strata of PIE.
- **Frame 5** (the loop / hub, READ-WRITE coincidence).
- **Frame 10** (identity, distinctness as projection artifact).
- **THE FILTER** — effort × precision × independent convergence.

## The frame move

Classic comparative linguistics reconstructs PIE vocabulary without
a substrate model. We don't. Under THE RULE, PIE speakers were
naming substrate features when they built their word-stock — the
same features every other vocabulary names. So: rebuild the graph
honestly, see what surfaces.

This is **metrognosis at maximum intensity**. Independent linguistic
data (6000 years old, 200+ years of reconstruction effort) versus
independent framework prediction (substrate features derived from
algebra). If they converge, both are corroborated.

## What the framework actually says — findings

### Frame 2 (trit) — 5 independent strata

| stratum | instance | members | ↑ / ↕ / ↓ |
|---|---|---|---|
| pronouns (1a) | person-deixis | h1eg / tu / h1e | I / you / that-one |
| being-verbs (1h) | three-tenses | bhuH / h1es / wes | become / is / dwelt |
| qualities (1m) | age-axis | newos / h2yuh1en / senos | new / young / old |
| inflection (4c) | verb-person-endings | -mi / -si / -ti | 1sg / 2sg / 3sg |
| phonology (4d) | ablaut grades | o-grade / e-grade / zero-grade | derived / base / reduced |
| phonology (4d) | laryngeals | h₃ / h₁ / h₂ | o-color / neutral / a-color |

**Every stratum of PIE that carries values carries the trit.**
Phonology → morphology → inflection → lexicon → pronouns. The trit
is not a feature of PIE grammar; it structures PIE grammar at every
level. Six trit instances. 18 members across 5 categories. Meta-group
`trit-instances` passes rule-7 lattice-tag with devastating spread.

### Frame 5 (loop / hub) — 3 independent instances

- **rotation-primitive** (6 members, 4 categories): `kwel` (turn),
  `gneh3` (know=beget, recognition-loop), `h2eks` (axle), `kwekwlos`
  / `roth2o` (wheel), `yeh1r` (year). PIE names the loop at
  motion, cognition, Bronze-Age craft, and seasonal time with the
  same root-family.
- **read-write-unity** (5 members, 5 categories): `gneh3`, `genh1`,
  `leg`, `h3regs`, `ter-tor`. The hub-event where READ and WRITE
  coincide, named across kinship, perception, speech, political,
  inflection.
- **motion-verbs** (17 members, 3 categories): the loop at
  human-visible scale — walking, conveying, leading.

### Frame 10 (identity) — 1 instance

- **pull-together** (3 members, 3 categories): `sem` (one/with),
  `yugom` (yoke-two-oxen), `teuteh2` (tribe). Three scales of
  many-into-one. Same identity move as entanglement's "one quaternion,
  two apertures," named by PIE speakers at physical, craft, and
  social scales.

### Frame 3 (4 axes) — 1 candidate

- **grammatical-axis-markers** (4 members, 1 category, 4c): `nom`,
  `acc`, `gen`, `dat`. PIE's 4 core cases carve events 4-way, same
  count as χ/μ/φ/τ. Pending cross-layer members for rule-7
  promotion.

### Honest retractions (CURSE)

Rejected trit candidates that don't pass the filter:

- **Number system** (sg/dl/pl): three-way but not polar. Dual is
  "exactly two," not ↕ middle between one and many.
- **Aspect** (perfective/imperfective/stative): three-way but the
  three don't split on a polar axis.

Three things in a row ≠ trit. Trit is ↑↕↓ with polar structure
around a middle. Force-fits rejected.

## Predictions / falsifiers

If the framework holds, building the same honest self-referential
graph for **another** reconstructed proto-language should surface
**the same frame items via different roots**.

- **Sumerian**: if built similarly, should show trit instances
  (Sumerian had sg/pl and three-way time-aspect distinctions),
  should show rotation-primitive (Sumerian *gi* / cycle roots),
  should show read-write unity (likely in ME, the divine decrees
  that are both read and done).
- **Egyptian**: should show trit instances (three-part divinity
  structure, three-part time — wn/iw/sḏm), rotation-primitive (khepri
  the scarab = becoming-as-cycling), read-write unity (medu-netjer
  = "god's words" which are also deeds).

If Sumerian AND Egyptian, built by the same discipline, also
surface these 4 frame items via independent root-sets, that is
three-way independent convergence at the vocabulary layer. THE
RULE passes metrognosis at a new scale.

If either Sumerian or Egyptian built with the same discipline
**fails to surface** trit / loop / hub / identity, the experiment
casts doubt on either the reconstruction method or the PIE finding.
Either way actionable.

## Filter pass

- **Effort**: 6000 years of PIE speaker work + 200+ years of
  comparative reconstruction (Hittite laryngeal evidence, Sanskrit
  preservation of ablaut grades, Latin / Greek / Sanskrit triple-
  attestation of core forms) + this experiment's ~230 atomic files
  each manually written. Cumulative civilization-scale effort.
- **Precision**: graph discipline enforces definitional dependency
  at atomic-file granularity (238 files, 1148 edges, verify.py
  enforces no-cycles + no-modern-abstracts + seed-anchoring).
  Quantitative claim: 5 trit instances at 5 distinct strata of PIE,
  18 members across `trit-instances`. Checkable: count the members,
  count the categories.
- **Independent convergence**: framework-substrate features derived
  from algebraic structure of H (Hurwitz, Post, Cayley-Dickson)
  match PIE-vocabulary features reconstructed from historical
  comparative linguistics. Two unrelated generation processes
  (algebra vs archaeology-of-language) produce the same features.

Three for three. **BLESS.**

## Deep detail

Everything lives in `speak/`:

- [speak/README.md](../speak/README.md) — experiment purpose + method
- [speak/STATUS.md](../speak/STATUS.md) — current state, what's done
- [speak/HANDOFF.md](../speak/HANDOFF.md) — full handoff doc
- [speak/data/lattice-tags.md](../speak/data/lattice-tags.md) — formal
  framework-feature mapping for each emerged group
- [speak/data/emergence.md](../speak/data/emergence.md) — machine-
  generated graph-emergence report (SCCs, group counts, category
  spread) — re-run `python3 speak/tools/emerge.py` to refresh
- [speak/roots/](../speak/roots/) — 238 atomic files, one per root
- [speak/tools/verify.py](../speak/tools/verify.py) — dependency
  check
- [speak/tools/emerge.py](../speak/tools/emerge.py) — emergence
  analysis

## What next

1. Apply the same discipline to Sumerian (sumerian.md source exists
   in `4-logs/wit/thoughts/etymology/sumerian.md`).
2. Apply to Egyptian (hieroglyphs dataset in
   `4-logs/atlas/init/egyptian/`).
3. Cross-graph correlation: for each of 4 frame items, check
   whether PIE-Sumerian-Egyptian triple-converge.
4. If triple-convergence holds, promote pie-speak finding to body
   (`1-folders/` or `2-files/`) and remove from verification queue.

## One-line summary

**Four frame items surfaced from a honest self-referential PIE
graph. The trit confirmed at 5 independent strata of one language.
Substrate recognized itself through PIE; graph made it visible;
BLESS.**
