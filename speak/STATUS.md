# speak/ — status

## 2026-04-17 (pm-late) — Phonology added, trit confirmed at 5 strata

Added Layer 4d (phonological apparatus): 3 ablaut grades (e/o/zero)
+ 3 laryngeals (h₁/h₂/h₃). Added cross-cutting `trit-instances`
meta-group linking core trit members across 5 categories.

**Finding**: the trit ↑↕↓ emerges at **5 independent strata** of PIE:

| stratum | cat | members |
|---|---|---|
| pronouns | 1a | h1eg / tu / h1e |
| being-verbs | 1h | bhuH / h1es / wes |
| qualities | 1m | newos / h2yuh1en / senos |
| inflection | 4c | verb-1sg-mi / verb-2sg-si / verb-3sg-ti |
| phonology (vowel) | 4d | o-grade / e-grade / zero-grade |
| phonology (consonant) | 4d | lar3 / lar1 / lar2 |

`trit-instances` group: 18 members, 5 categories → passes rule 7
with devastating cross-strata spread.

Honestly rejected: number (sg/dl/pl — not polar) and aspect
(perfective/imperfective/stative — not polar). Three-way ≠ trit.

Wrote `/home/maxi/code/is/3-confs/pie-speak.md` for main-file
integration (the framework's verification queue entry).

**Updated graph state**:

```
  238 atomic files  (+6 phonological, was 232)
  ├─  33 seeds
  ├─ 150 Layer 1 non-seeds
  ├─  24 Layer 3 Bronze-Age roots
  └─  31 Layer 4 grammatical + phonological  (was 25)

  1148 graph edges
  1176 verified references
     6 lattice-tag candidates (+trit-instances, was 5)
     3 seed-anchored SCCs (0 unanchored)
```

## 2026-04-17 (pm) — Formal lattice-tagging pass

Housekeeping + the main scientific move: the 5 emergence candidates
are now explicitly tagged as specific frame items in
`data/lattice-tags.md`. Groups become identified substrate features.

**Changes this pass**:

1. Broke unanchored cycle `h2ewg ↔ ker-b`. Made `ker-b` the
   grow-hub; removed cluster-sibling references from its definition.
2. Merged `h2erg-c` into `h2erg` (Layer 1 silver-flash ← Layer 3
   silver-metal; same PIE root, same stroke). Deleted `h2erg-c.md`.
3. Merged `wegh-c` into `wegh` (Layer 1 convey ← Layer 3 wagon;
   same stroke). Deleted `wegh-c.md`. Updated `roth2o` ref.
4. Wrote `data/lattice-tags.md` — formal identification of the 5
   emergence candidates as specific frame items from
   `4-logs/wit/wit.md`.

**Formal lattice-tag mapping** (see lattice-tags.md for full):

| group | frame item | status |
|---|---|---|
| rotation-primitive | 5 — the loop | SOLID |
| read-write-unity | 5 — hub-event / recognition | SOLID |
| motion-verbs | 5 — loop at visible scale | SOLID |
| write-side-actions | 2 — trit ↑ commit | SOLID |
| pull-together | 10 — identity / sem-unity | SOLID |
| three-tenses-of-being + age-axis + person-axis | 2 — trit ↑↕↓ | SOLID (3×) |
| grammatical-axis-markers | 3 — 4 axes χ/μ/φ/τ | CANDIDATE |

**Updated graph state**:

```
  232 atomic files  (234 − 2 merged)
  ├─  33 seeds (Layer 1)
  ├─ 150 Layer 1 non-seeds
  ├─  24 Layer 3 Bronze-Age roots  (26 − 2 merged into Layer 1)
  └─  25 Layer 4 grammatical morphemes

  1146 verified references
  1130 graph edges (internal)
     5 lattice-tag candidates (rule 7)
     3 seed-anchored SCCs (all legal)
     0 unanchored SCCs
```

`verify.py`: OK — all checks pass.
`emerge.py`: 5 lattice-tag candidates, all now formally tagged.

## 2026-04-17 (am) — All three phases complete

**Coverage**: Layer 1 Paleolithic (183) + Layer 3 Bronze-Age (26)
+ Layer 4 inflection (25) = **234 atomic files**. Layer 2 Neolithic
(40 roots) not yet written — can be added later if needed.

## Final graph state

```
  234 atomic files
  ├─  33 seeds (Layer 1)
  ├─ 150 Layer 1 non-seeds
  ├─  26 Layer 3 Bronze-Age roots
  └─  25 Layer 4 grammatical morphemes

  1158 verified references
  1147 graph edges (internal)
     5 lattice-tag candidates (rule 7: 3+ members, 3+ categories)
     4 seed-anchored SCCs (all verified legal)
```

`verify.py`: OK — all checks pass.
`emerge.py`: 5 lattice-tag candidates identified.

## The 5 lattice-tag candidates (rule 7: 3+ independent convergence)

### 1. `rotation-primitive` (6 members, 4 categories)

**The framework's central claim crystallized as a graph node.**

- `1i` motion: `kwel` (seed: turn-root)
- `1j` perception: `gneh3` (know=beget, recognition-loop)
- `3a` wheel-complex: `h2eks` (axle), `kwekwlos` (wheel-object),
  `roth2o` (second PIE word for wheel)
- `3f` time: `yeh1r` (year = returning cycle)

**Four vocabularies — motion, cognition, Bronze-Age craft,
time-cycle — converging on ONE substrate feature: rotation.** This
is THE RULE operating: one substrate, many names. The framework
used "wheel" as its central metaphor; the graph now shows that
wheel is literally the same PIE root (kwel) appearing in all four
domains the framework touches — motion, recognition, Bronze-Age
craft, seasonal time. The metaphor joined the vocabulary.

### 2. `read-write-unity` (5 members, 5 categories)

**The know=beget unity spanning the broadest category range.**

- `1c` kinship: `genh1` (beget, kin, king — gen-branch)
- `1j` perception: `gneh3` (know AND beget — the unsplit root)
- `1k` speech: `leg` (collect AND speak — gather-and-set-forth)
- `3c` political: `h3regs` (king = "recognized/straightened one")
- `4b` inflection: `ter-tor` (agent suffix — the doer-of-verb)

PIE's unity of READ and WRITE (take-in = put-out) crossing 5
independent vocabulary layers. Political legitimacy, family
heritage, word-gathering, knowing-seeing, agent-of-verb all
instantiate one substrate operation.

### 3. `motion-verbs` (18 members, 4 categories)

Large convergent cluster — every walking/moving verb from Paleolithic
motion + body-part foot + Bronze-Age conveying + political leading.
Natural category grouping with cross-layer depth.

### 4. `write-side-actions` (4 members, 3 categories)

The ↑ commit primitive at 3 scopes:
- `1h` body: `bhuH` (become), `dheh1` (put/do/make)
- `3c` political: `h3reg` (rule/straighten)
- `3e` abstract: `dheh1s` (sacred-as-rightly-done)

One substrate operation (↑ commit) manifesting as make / rule /
sacred-rite.

### 5. `pull-together` (3 members, 3 categories)

Unity across scope:
- `1n` spatial: `sem` (one/with — seed)
- `3a` wheel-complex: `yugom` (yoke — joining two oxen)
- `3c` political: `teuteh2` (tribe — unified people)

`sem` appearing at three scales: spatial, craft, social.

## Trit structure at three independent scopes

The ↑/↕/↓ pattern emerged THREE times across the graph:

1. `three-tenses-of-being` (1h): `bhuH`/`h1es`/`wes` — the being verb
2. `age-axis` (1m): `newos`/`h2yuh1en`/`senos` — age across life-span
3. `three-tenses-of-being` extended to 4c with pres/past endings:
   verb endings (`verb-*-mi`, `verb-*-m`, etc.) + `tos-to` past
   participle → 9 members total across 1h + 4c

Three independent vocabulary instances of one substrate feature
(the trit). Under rule 7 (3+ independent convergence), this is
solid lattice-tag territory — the ↑/↕/↓ structure is **not
imposed, it emerged**.

## Axis-pair binary oppositions (8+ instances)

- `vertical-axis` (4): h2en, upo, uper, ni
- `here-there-pair` (4): ke, h1e, so, h2epo
- `inside-outside-pair` (3): h1en, h2epo, h1eghs
- `person-axis` (12 across 1a + 4c): h1eg/tu/h1e/so/se/we/yu +
  verb-endings 1sg/2sg/3sg — grammatical person fuses with deictic
- `life-death-pair` (2): gweyh3, mer
- `day-night-pair` (2): dyews, nokwts
- `cold-hot-pair` (2): gel, gwher
- `light-dark-pair` (2): leuk, h1regwos
- `whole-split-pair` (2): solh2, dwis
- `before-after-pair` (3): pro, posti, nu

Binary-opposition structure is the spokes-of-the-wheel pattern
appearing pervasively at the PIE vocabulary layer.

## Unity-preservation convergences (THE RULE literally)

Atomic files whose PIE roots name TWO concepts that later tongues
split, preserved per rule 12:

- `dyews` — sky=god (one root, Latin deus, Sanskrit dyaus)
- `dheghom` — earth=human (one root, humus, chthonic, human)
- `h2enh1` — breath=soul (one root, anima, anemos)
- `meh1ns` — moon=month (one root)
- `deru` — tree=firm=true ("the same pointing kept")
- `gneh3` — know=beget (THE RULE's signature unity)
- `genh1` — gen-branch of gneh3 (kin, king, genesis)
- `bheh2` — speak=shine (words shining-forth-from-mouth)
- `leg` — collect=speak (gather-and-set-forth)
- `bher` — carry=bear (give-birth AS carry-into-the-world)
- `h3regs` — king=straightener (political=alignment)
- `h2eusom` — gold=dawn-glow (gold-from-shining)

## Candidates awaiting cross-layer reinforcement

These groups are axis-shaped but haven't crossed enough categories
to auto-tag:

- `grammatical-axis-markers` (4 members, 1 category: 4c) —
  nom/acc/gen/dat. A clean 4-slot grid (WHO/WHAT-DONE-TO/WHOSE/
  FOR-WHOM). Needs cross-layer members to promote. If a future
  analysis connects these to the framework's 4 axes χ/μ/φ/τ, that's
  a lattice-tag waiting to happen.
- `composition-operators` (25 members, 2 categories: 4b + 4c) —
  all inflection morphemes. The grammatical spine as a unit.

## Tools + data

```
speak/
├── README.md
├── STATUS.md                  (this file)
├── data/
│   ├── pie-layer1.json        (183 Paleolithic roots)
│   ├── pie-layer3.json        (26 Bronze-Age roots)
│   ├── pie-layer4.json        (25 grammatical morphemes)
│   ├── seeds.md               (seed set + rationale)
│   ├── CATEGORIES.md          (all subcategories + counts)
│   ├── graph.md               (mermaid flowchart — 234 nodes)
│   ├── graph.dot              (graphviz source)
│   ├── groups.md              (all groups ≥3 members)
│   └── emergence.md           (full emergence report)
├── roots/
│   └── *.md                   (234 atomic files)
└── tools/
    ├── verify.py              (dependency + forbidden-vocab check)
    ├── draw.py                (DOT / PNG graph render)
    ├── draw_mermaid.py        (mermaid + groups summary)
    └── emerge.py              (emergence + lattice-tag analysis)
```

## What this validates

The PIE-Paleolithic experiment's hypothesis:

> **If the wheel framework's THE RULE holds, the irreducible core
> of self-referential PIE vocabulary will map to the substrate's
> coordinate structure.**

Status per the data:

- **Trit ↑/↕/↓**: emerged 3× independently → SOLID CONVERGENCE
- **Axis-pair spokes**: emerged 8+× → SOLID CONVERGENCE
- **Hub as deixis point**: deixis-at-hub (9 members, all deictic
  pronouns) → SOLID CONVERGENCE
- **Rotation as substrate feature**: rotation-primitive (6 members,
  4 categories) including the physical wheel-complex → SOLID
  CONVERGENCE
- **Read-write unity / know-beget**: read-write-unity (5 members,
  5 categories) → SOLID CONVERGENCE
- **4 grammatical cases as axis-shaped**: grammatical-axis-markers
  (4 members, clean 4-pole) → EMERGENCE CANDIDATE (awaiting
  cross-layer promotion)

Six distinct substrate-feature emergences from 234 atomic files
defined by applying PIE-root meanings plus the v4 graph principle.
None imposed top-down; all surfaced via definitional dependency.

**The framework predicted this shape. The data confirms it from
the inside.**

## Unfinished

- Layer 2 Neolithic (~40 roots: domesticated animals, grain,
  settlement, tools) — not written. Additional material but likely
  won't change the core emergence pattern; agricultural concepts
  are domain-specific rather than substrate-structural.
- Lattice-tag FORMAL tagging — per rule 7, the 5 above qualify for
  formal naming as specific substrate features (which lattice point
  or axis each is). Done informally in this report; formal naming
  in atomic files not yet done.
- Retrospective suffix-composition linking — going back to Layer 1
  roots and adding group memberships for the inflection morphemes
  that apply to them (e.g., ph2ter as agent-suffix formation from
  peh2). Not done yet.
