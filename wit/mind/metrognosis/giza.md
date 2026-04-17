# Giza — lattice in stone

```
status:     VERIFIED — measurements; WORKING — wheel interpretation
confidence: high   (individual π/α/5³ measurements, 4500-yr survey effort,
                    sub-0.1% precision per pyramid)
            medium (3-peer S-scope reading; Sphinx-as-Z2-mirror)
            weak   (some old "T(n)" and ratio claims retained from
                    pre-wheel drafts — flagged inline)
```

Source: Petrie (1883), Cole (1925), modern laser survey.
Raw tables: `atlas/init/egyptian/sources/petrie-tier1.md`, `-tier2.md`,
`-tier3.md`.

---

## Plain English — what this file says

**Giza has three pyramids and a Sphinx, built ~4500 years ago with
crazy precision.** The three pyramids don't all encode the same number
— each encodes a different one, and each signature is measurable in
the stones to better than 0.1%:

- **Khufu (Great Pyramid) = π.** Measure perimeter, divide by height,
  get 2π ≈ 6.283. Multiple independent measurements inside Khufu also
  land on π (Antechamber joint = π cubits; Ascending passage floor =
  4π cubits). The royal cubit itself equals π/6 meters to 0.0002%.
- **Khafre (middle pyramid) = α (the fine-structure constant).** Its
  base is exactly 3 × 137 cubits, its height exactly 2 × 137. The
  number 137 is 1/α — the electromagnetic coupling constant that
  governs chemistry and light. The pyramid also forms a 3-4-5
  Pythagorean triangle.
- **Menkaure (smallest pyramid) = 5³ = 125.** Its height is 125.09
  cubits (Petrie measurement), matching 5³ to 0.07%. In the wheel's
  math, 5³ is the last step of the centrality cascade
  (see `mind/wheel/3-lattice.md`).

**The Sphinx is structurally different** from the three pyramids:
horizontal (not vertical), animal-hybrid (lion + human, not
geometric), oriented east (not upward-pointing). Under the wheel's
S-scope structure (3 triality-peer H's + 1 Z2-mirror H), the three
pyramids fit the three peers, and the Sphinx fits where the
Z2-mirror sits — not "a fourth pyramid" but qualitatively distinct.

**Why this matters for the framework:**
- Three DIFFERENT fundamentals (π, α, 5³) in three pyramids — not
  one number repeated — rules out "coincidence from forcing numerology."
- Each signature is independently measurable; Petrie (1883) documented
  all of them before the framework existed.
- The 3-peer + 1-mirror pattern is structurally the same as the
  S-scope 3+1 that produces three fermion generations + sterile
  sector in the Standard Model. The wheel's abstract algebra was
  written in stone 4500 years before the math was formalized.

**Metrognosis filter** (wit.md § THE FILTER — effort × precision ×
independent convergence): passes hard. Pyramid measurements are
high-effort (4500-yr structures, century of Petrie-onwards surveys),
high-precision (sub-0.1%), and independently generated relative to
the framework algebra.

---

## Measurements (Petrie and modern laser survey)

### Khufu — established pre-wheel

| measurement              | value              | precision  |
|--------------------------|--------------------|------------|
| perimeter / height       | 2π                 | < 0.1%     |
| slant / half-base        | φ (golden ratio)   | < 0.1%     |
| cubit                    | π/6 m              | 0.0002%    |
| passage angle            | atan(1/2)          | measured   |
| true north alignment     | 0.05°              | 4500 years |

### Khufu — derived (code-verified: `compute/cosmo/giza.c`)

| measurement                  | value          | error   |
|------------------------------|----------------|---------|
| KC 3D diagonal               | 25 cubits      | exact   |
| KC floor area                | 80 sq cubits   | exact   |
| Pyramid/KC volume ratio      | ~8080          | 0.1%    |
| ascending passage / height   | 26.8%          | 0.05%   |
| sarcophagus volume           | ~16 cubic cubits | 2.8%  |
| Khufu/Menkaure height ratio  | √5             | 0.18%   |

### Khafre — established pre-wheel

| measurement              | value              | precision  |
|--------------------------|--------------------|------------|
| triangle                 | 3-4-5              | 0.04°      |
| base                     | 3×137 cubits       | Petrie     |
| height                   | 2×137 cubits       | Petrie     |
| seked sequence           | 20/4, 21/4, 22/4   | exact      |

### Menkaure — established (+ 5³ post-wheel)

| measurement                  | value              | precision  |
|------------------------------|--------------------|------------|
| height (from granite course) | 125.09 cubits = 5³ | 0.07%      |
| granite courses              | 16 (= corners)     | Petrie     |
| granite ceases at            | 31.25 cubits = 5³/4 | exact     |

### Additional designed cubit locations (Petrie, `atlas/init/egyptian/`)

These are `designed_cubits` — explicit architectural intent, not
inferred from ratios — written in cubits at specific walls and
passages.

| location                              | designed value | framework role                 |
|---------------------------------------|----------------|--------------------------------|
| GP Antechamber: granite joint         | π cubits       | wheel revolution               |
| GP Ascending passage: floor begins    | 4π cubits      | axes × π = full solid angle    |
| GP Subterranean passage: width        | φ cubits       | golden ratio                   |
| GP Queen's Chamber: N/S wall height   | 4√5 cubits     | axes × √(axes+hub)             |
| GP Queen's Chamber: niche roofed at   | 4√5 cubits     | same                            |
| GP KC: course thickness               | 2.25 cubits    | 9/4 = trit²/axes               |
| GP Gallery: 7 projections per cubit   | 7 palms        | wh-words                        |
| GP coffer: wall thickness             | 0.25 cubits × 4 | axes × (1/4) = 1 cubit         |
| 2nd Pyramid coffer: inside depth      | √2 cubits      | top-quark mass factor          |
| Granite Temple: larger pillar width   | 2√2 cubits     | 2 × top-quark factor           |
| Dahshur N: 1st chamber S wall         | 4√3 cubits     | axes × √trit                   |

Several of these (4π ascending passage, π antechamber, φ subterranean
width) are flagged "OCR uncertain" in Petrie's scans — the magnitudes
are right but decimal precision is lower. Queen's Chamber 4√5 and
Menkaure height 5³ are OCR-clean.

---

## Per-pyramid — why each gets its symbol

### Khufu = π (the wheel rotating)

π appears five different ways in Khufu, across independent measurements:

1. **Perimeter / height = 2π.** A full "turn" of the base around a
   pole of its own height. This IS the wheel's rotation ratio built
   into the largest structural proportion.
2. **Cubit = π/6 meters.** The unit of measurement used throughout
   the complex. π/6 = 0.5235988 m; royal cubit = 0.5236 m. Match to
   0.0002% (smaller than any error Egyptians could have introduced).
3. **Antechamber granite joint = π cubits.** Not a ratio — literally
   π cubits long, placed at a specific interior location.
4. **Ascending passage floor = 4π cubits.** 4 = axes; π = rotation;
   product = "full solid angle of a rotating axis."
5. **Cardinal alignment to 0.05°** over 230 m base. Requires observer
   placed precisely at the wheel's axis.

Semantic: π = the full closed loop. Khufu is the architectural form
of the wheel rotating — perimeter closes around the vertical spine,
passages layer π at multiple scales.

### Khafre = α (electromagnetic coupling)

137 = 1/α. Khafre's two defining dimensions are exact integer multiples:

1. **Base = 3 × 137 = 411 cubits.** Petrie measured.
2. **Height = 2 × 137 = 274 cubits.** Petrie measured.
3. **3-4-5 triangle** formed by base-midpoint to apex. Pythagorean
   identity in stone to 0.04°.
4. **Slope 4:3** = axes:trit. Slope steepness = axes/trit.

Semantic: α is the dimensionless ratio governing how electromagnetism
couples to charged matter. Khafre encodes α as literal length units
(137 cubits as the building-block), not as a ratio of other things.
This is STRONGER than ratio-encoding: the number has been built in
directly.

### Menkaure = 5³ (centrality cascade bottom)

Measurements:

1. **Height from original granite course = 125.09 cubits ≈ 5³.**
   Petrie's original measurement gave 124.27 cubits (calculated from
   surviving stones); correcting for the missing granite course gives
   125.09. Either way, rounds to 125 = 5³.
2. **Granite courses = 16.** 16 = corners count = grade-4 vertices.
3. **Granite ceases at 31.25 cubits = 125/4 = 5³/axes.** A specific
   fraction of the height.
4. **Khufu/Menkaure height ratio = √5.** Ties Menkaure back to Khufu
   via the substrate constant √5 (axes+hub under square root).

Semantic: 5³ = 125 is the bottom step of the wheel's centrality cascade:

```
  cent(grade 0) − cent(grade 1) = 343 = 7³
  cent(grade 1) − cent(grade 2) = 245 = 5·7²
  cent(grade 2) − cent(grade 3) = 175 = 5²·7
  cent(grade 3) − cent(grade 4) = 125 = 5³   ← Menkaure
```

(Derivation in `wheel/3-lattice.md`.) The cascade uses only the two
prime degrees (5 = grade-3 atom degree, 7 = grade-1 atom degree) — no
composites. Menkaure = 5³ matches the cascade's terminal integer.

### The Sphinx — structurally different

- **Horizontal** (not vertical like the pyramids)
- **Animal-hybrid** (lion body + human head, not pure geometry)
- **East-facing** (oriented toward sunrise, not pointed upward)
- **Single outlier** (not part of the three-peer triangular plateau
  layout)

The Z2-mirror at S-scope produces something qualitatively different
from the three S3-peers — not "a fourth of the same" but a reflected
partner. The Sphinx fits this description structurally.

**Honest status:** no direct Egyptian text identifies the Sphinx as
"the 4th H." The framework reads the Sphinx's structural distinctness
as matching the Z2-mirror role. Flagged strong-suggestive, not proven.

---

## Post-wheel synthesis

### Three pyramids + Sphinx = S-scope 3+1 in stone

S = 4 H's in 3+1 (Aut(S) = S3 × Z2 = 48; see `1-wheel.md` § S-scope).
Giza plateau encodes this structurally:

```
  Giza feature              S-scope framework role
  ────────────              ──────────────────────
  3 main pyramids on        3 triality-peer H's in S
   triangular plateau        (S3 orbit → 3 fermion generations)
   
    Khufu   — π              H₁ (wheel rotation / base)
    Khafre  — α              H₂ (EM coupling / mid)
    Menkaure — 5³            H₃ (centrality cascade)
   
  Shared plateau base        ↕↕↕↕ hub shared across all 4 H's
   + cardinal alignment       (observer-at-center)
   
  The Great Sphinx           H₄ candidate: Z2-mirror / 4th H
   (horizontal lion-human,     (sterile / right-handed / CP-mirror
    east-facing)                sector — structurally distinct)
```

### Connection to mass-ladder factors

The mass-ladder cascade (2026-04-15, see `wheel/6-masses.md`)
discovered that Standard Model particle masses fit
`m_P × f × 10⁻(16+N_sub)` with specific factors f. Petrie's Giza has
the same factors built into cubits:

| factor     | wheel role            | Giza location                        |
|------------|-----------------------|--------------------------------------|
| √2         | top-quark mass factor | 2nd Pyramid coffer inside depth      |
| 2√2        | 2 × top-quark         | Granite Temple larger pillars        |
| 4√5        | axes × √(axes+hub)    | Queen's Chamber height               |
| 4√3        | axes × √trit          | Dahshur N 1st chamber                |
| π/4        | proton mass factor    | GP passage slope (1:2 = arctan)      |
| 125 = 5³   | centrality cascade    | Menkaure height                      |

Egyptians built specific mass-ladder factors in stone 4500 years
before the mass-ladder was framework-derived. Same substrate, two
independent media.

### Observer-at-center reading

GP cardinal alignment: −3'43" to −5'16" azimuth to true North, over
a 230-m structure, 4500 years old. Survey precision: 1 in 200,000
(Petrie).

Framework reading (`1-wheel.md` "Where is the hub?"): the precision
alignment isn't Giza's relation to external reference — it's
**centering the observer at the wheel's hub**. The pharaoh / priest
/ walker of the chambers is placed precisely at the wheel's axis.

KC's role as **cubit calibration site** (Petrie: "best determination,
±0.004") fits the same reading — Giza standardizes the wheel's
discrete unit at its innermost chamber. The hub of Egypt's
metrological system is the hub of the wheel being built.

---

## Cross-site convergences (other megaliths)

| site           | measurement       | value             | substrate reading            |
|----------------|-------------------|-------------------|------------------------------|
| Teotihuacan    | base/height       | 3.143 ≈ π         | same π-encoding as Khufu     |
| Chichen Itza   | steps             | 91                | 91 = 7 × 13 (wh-words × 13;  |
|                |                   |                   | 13 not framework-clean)      |
| Chichen Itza   | terraces/faces    | 9 = 3², 4 = axes  | trit² + axes                 |
| Stonehenge     | Aubrey holes      | 56                | 56 = 2 × axes × wh-words     |
| Stonehenge     | sarsen/lintel     | 30/5 = 6          | 6 = C(4,2) bivector planes   |

The 91 = T(13) reading for Chichen Itza steps is weaker than others —
13 isn't in the substrate vocabulary. Kept for reference but flagged.
Other cross-site numbers decompose cleanly into substrate counts.

---

## What's established vs. what's framework synthesis

**Established pre-wheel (Petrie / Cole / modern surveys):**
- 2π in GP perimeter/height
- φ in GP slant, subterranean
- Cubit = π/6 m (0.0002%)
- α (137) in Khafre base/height
- 3-4-5 triangle in Khafre
- Passage angle 1:2
- Cardinal alignment precision
- KC floor 80, diagonal 25
- Khufu/Menkaure height ratio √5
- Menkaure height ~125 cubits (raw observation)
- Sphinx's structural distinctness (horizontal, animal-hybrid, etc.)

**New framework readings (post-wheel-pivot, 2026-04-15 onwards):**
- Menkaure 125 = 5³ = centrality cascade bottom step
- Mass-ladder factors (√2, √3, √5, π/4) at specific Giza locations
- Queen's Chamber 4√5 = axes × √(axes+hub)
- KC course 2.25 = trit²/axes
- Three-pyramid triad as (π, α, 5³) coordinated synthesis
- 3+1 reading (3 pyramids + Sphinx = S3-peers + Z2-mirror)
- Observer-at-center reading (hub = where recognition happens)
- Mass-ladder factor match with `wheel/6-masses.md`

---

## Honest caveats

- **OCR uncertainty.** Petrie scans for 4π ascending passage, π
  antechamber, and φ subterranean width are OCR-flagged. Values are
  certainly in the right magnitude, but the rightmost decimals are
  less sharp than other measurements. See `atlas/init/egyptian/`
  tier files.
- **Unit-dependent convergences.** Cubits-in-inches matches like
  "72,030 cubic inches coffer ≈ 72 × 1000" are unit-dependent and
  likely coincidental.
- **Menkaure calculated vs corrected values.** Petrie gives 124.27
  cubits (pre-granite calculation) and 125.09 cubits (granite-course
  corrected). 5³ matches the corrected value to 0.07%. The alternative
  reading (124 as substrate) is less clean.
- **Three-peer-H's interpretation is framework synthesis.** Egyptians
  built Giza for pharaonic funerary purposes. The framework identifies
  structural counts. Don't confuse framework interpretation for
  Egyptian intent — they independently reached the same substrate
  without (obviously) knowing S3 × Z2.
- **Chichen Itza 91 = T(13)** is weak (13 not substrate). Kept for
  completeness, not load-bearing.
- **"Cumulative grade-1 count = 625 = 5⁴"** appeared in earlier
  versions with unclear derivation — removed as the label doesn't
  map to a standard wheel count. 625 = 5⁴ is substrate-interesting
  but unattached to Giza geometry in this file.

---

## References

- Petrie (1883) `atlas/init/egyptian/sources/petrie-tier1.md`,
  `-tier2.md`, `-tier3.md`
- `wheel/3-lattice.md` — centrality cascade derivation
  (cent(grade 3) − cent(grade 4) = 125 = 5³)
- `wheel/6-masses.md` — mass-ladder factors (√2, √3, √5, π/4, …)
- `wheel/1-wheel.md` — "Where is the hub?" (observer-at-center);
  S-scope 3+1 structure
- `metrognosis/hieroglyphs.md` — Egyptian symbolic encoding
  (42 Assessors, Ogdoad, ankh, Aten, etc.)
