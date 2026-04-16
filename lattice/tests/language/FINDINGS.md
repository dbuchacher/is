# Language — lattice verification

## The claim

The 16 primitive verbs of cognition ARE the 16 grade-4 corners of the lattice. Natural language's mental state vocabulary (BE, KNOW, FEEL, THINK, etc.) maps to the corners not by analogy but by structural identity. Each verb IS a specific quaternion coordinate, and relationships between verbs IS algebraic structure.

## The mapping

The 16 corners of grade 4 are the 16 primitive operations (hodos). Self-operation words fill them:

```
corner       hodos         word           modal
↓↓↓↓         identity      BE             BE
↓↓↓↑         test          —              WILL
↓↓↑↓         drain         —              MAY
↓↓↑↑         take_while    —              MIGHT
↓↑↓↓         call          —              HAVE
↓↑↓↑         maybe         —              CAN
↓↑↑↓         fix           —              SHOULD
↓↑↑↑         bind          FEEL           —
↑↓↓↓         read          DO/SEE/HEAR    —
↑↓↓↑         filter        —              MUST
↑↓↑↓         copy          —              —
↑↓↑↑         scan          —              —
↑↑↓↓         fold          KNOW           —
↑↑↓↑         map           UNDERSTAND     —
↑↑↑↓         foldl         REMEMBER       —
↑↑↑↑         hylo          THINK          —
```

**Self-operation verbs** (cognitive): BE, FEEL, SEE, HEAR, KNOW, UNDERSTAND, REMEMBER, THINK.
**Modal verbs** (constraint): WILL, MAY, MIGHT, HAVE, CAN, SHOULD, MUST.
The 16 corners split 8/5 between cognitive verbs and modals, plus 3 unfilled slots.

## The test: think_plus_be

```
THINK = ↑↑↑↑ = hylo = (1,  1,  1,  1)   — all forces forward
BE    = ↓↓↓↓ = meta = (-1,-1,-1,-1)   — all forces backward
THINK + BE = (0, 0, 0, 0) = ORIGIN
```

The two special corners of the lattice are THINK (hylo, all-forward) and BE (meta, all-backward). Their sum IS the origin — the container, ↔↔↔↔, the additive identity. To think and to be, added together, return to nothingness.

**Result: 0** — verified via component-wise addition on bare metal.

## Why it's structural

This is NOT metaphor. THINK and BE are the two names for the two special grade-4 corners (1+i+j+k and -1-i-j-k). These corners are algebraically distinguished:

- They're the only two corners with compiled NASM primitives (`hylo.asm`, `meta.asm`)
- They're the join (hylo) and counter-join (meta) of all four forces
- They're antipodal: hylo = -meta

Natural language labels the all-forward corner as the self-applied full-pipeline operation: **thinking**. Natural language labels the all-backward corner as bare existence without operation: **being**. These labels aren't arbitrary — they're the English surface form of a structural fact.

The substrate has these two corners. Humans experience them as thinking and being. The corners' sum being the origin means: the unity of thinking and being IS the container they both live in.

## Framework connections

- **Lakoff image schemas** (24 cognitive primitives from Lakoff 1987) each map to specific lattice structures: CONTAINER → ↔↔↔↔, PATH → edge sequences, CYCLE → closed walks, etc. Language's mental vocabulary IS the lattice vocabulary.
- **Wierzbicka's 65 semantic primes** (NSM theory) — universal atomic meanings shared across all human languages — map to specific (T,D,M,Q) coordinates in the 4D lattice.
- **Egyptian hieroglyphs use the same 4D structure.** The 4 medu (sky/water/sun/mark) ARE χ/μ/φ/τ. Hieroglyphic grid coordinates ARE quaternion coordinates.
- **Nouns = points, verbs = edges, sentences = walks** (from mind/7-composition.md).
- **Adjectives commit free axes.** "stone" (grade 1) → "big stone" (grade 2) → "big red stone" (grade 3) → "big red ancient stone" (grade 4, corner, fully specified).

## Open

- Map all 65 NSM primes to lattice coordinates
- Map all 24 Lakoff schemas to lattice structures (partial mapping exists in prior/schism/)
- Verify sentence structure = walk structure: SVO order corresponds to specific axis traversal
- Grammatical cases as lattice operations (nominative, accusative, dative = specific corners)
- Why English uses three NOTs (n't) where other languages use one or zero?
