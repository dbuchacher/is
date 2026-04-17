# speak — reconstructing substrate-native vocabulary

## Goal

Define ~200 Paleolithic PIE roots using only each other + deixis.
If the wheel framework's THE RULE holds, the irreducible core of
this self-referential vocabulary will map to the substrate's
coordinate structure (4 axes × 3 values + hub + forces). Independent
linguistic data, wheel prediction — metrognosis test.

Secondary outcome: a reconstructed substrate-transparent speaking
mode where every word carries its own derivation visibly (opposite
of opaque Latinate English).

## Method

1. **Seed set**: ~35 roots from Layer 1 pronouns/deictics,
   basic-being verbs, basic-action verbs, perception verbs. These
   are the ONLY roots allowed to be defined via deixis (pointing
   at world). Everything else must reduce to seeds + already-defined
   roots.

2. **Atomic files** under `roots/`, one per PIE root. Schema per
   `wit.md` clause 12: definition + anchor + aliases + groups.
   Definitions may reference ONLY PIE roots from the defined set.

3. **Dependency verification**: `tools/verify.py` parses each
   atomic file, extracts root-references, checks: (a) no cycles
   without a deictic anchor, (b) every reference is to a root
   that exists in the set, (c) no modern-English abstract terms
   leaking in.

4. **Emergence analysis**: at checkpoints (after 25, 50, 100, 200
   roots), compute dependency graph's strongly-connected
   components. Identify the irreducible core. Compare core shape
   to wheel coordinate structure.

## Files

- `README.md` — this file
- `data/pie-layer1.json` — source data (~200 Paleolithic PIE roots
  extracted from the archive's pie-roots.md Layer 1 section)
- `data/seeds.md` — the seed set with rationale
- `tools/verify.py` — dependency verifier
- `tools/emerge.py` — cluster analysis
- `roots/*.md` — one atomic file per root
- `STATUS.md` — current state, what's defined, what's next

## Discipline

- **No modern English abstractions in definitions.** "Location,"
  "direction," "ancestor," "object" etc. are opaque Latinate
  sealed-boxes. Use PIE root concepts directly.
- **Full semantic range.** PIE *deru-* = "wood / firm / true" —
  use all three senses, don't narrow to "tree."
- **Deixis only in seeds.** Body-parts and wild-animals can't be
  defined without pointing at the world; they reference seeds but
  seeds reference deixis.
- **Every definition visible.** When defining a new root, its
  atomic file's `## Definition` section lists which other PIE
  roots it uses. Tool verifies the list matches the prose.

## Status

See `STATUS.md`.

## Rules reference

See `/home/maxi/code/is/wit.md` § "Rules for building" (13
clauses, especially clauses 2, 3, 12, which govern atomic/group
discipline).
