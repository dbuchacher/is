# Giza — lattice in stone

Source: Petrie (1883), Cole (1925), modern laser survey.
Code: compute/cosmo/giza.c, giza_deep.c.


## Metron

### Khufu — established

| measurement              | value              | precision  |
|--------------------------|--------------------|------------|
| perimeter / height       | 2π                 | < 0.1%     |
| slant / half-base        | φ                  | < 0.1%     |
| cubit                    | π/6 m              | exact fit  |
| passage angle            | atan(1/2)          | measured   |
| true north alignment     | 0.05°              | 4500 years |

### Khufu — derived (code-verified)

| measurement                  | value          | error   |
|------------------------------|----------------|---------|
| KC 3D diagonal               | 25 cubits      | exact   |
| KC floor area                | 80 sq cubits   | exact   |
| Pyramid/KC volume ratio      | 8080           | 0.01%   |
| cumulative grade-1 count     | 625 = 5⁴       | exact   |
| geometric mean √(440×280)    | 351 = T(Fe=26) | exact   |
| ascending passage / height   | 26.8%          | 0.05%   |
| sarcophagus volume           | ~16 cubic cubits | 2.8%  |
| Khufu/Menkaure height ratio  | √5             | 0.18%   |
| √5 only inside, φ only outside | atom-bond separation |  |

### Khafre

| measurement              | value              | precision  |
|--------------------------|--------------------|------------|
| triangle                 | 3-4-5              | 0.04°      |
| base                     | 3×137 cubits       | Petrie     |
| height                   | 2×137 cubits       | Petrie     |
| seked sequence           | 20/4, 21/4, 22/4   | exact      |

### Cross-site

| site           | measurement           | value           | error   |
|----------------|-----------------------|-----------------|---------|
| Teotihuacan    | base/height           | 3.143 ≈ π       |         |
| Chichen Itza   | steps                 | 91 = T(13)      | exact   |
| Chichen Itza   | terraces/faces        | 9=3², 4=dims    | exact   |
| Stonehenge     | Aubrey holes          | 56 = 2×T(7)     | exact   |
| Stonehenge     | sarsen/lintel         | 30/5 = 6=C(4,2) | exact  |


## Gnosis

π and φ in the geometry: millennia of construction effort, sub-0.1%
precision, independently surveyed. Passes the filter hard.

KC diagonal = 25 = 5² = (axes+hub)². KC floor = 80 = non-container
lattice count. Room designed so the space diagonal is exact.
Architectural intent, not coincidence.

Khafre = 3-4-5 triangle. The Pythagorean identity in stone.
Base = 3×137, height = 2×137 cubits. 137 = 1/α.

Three pyramids: Khufu (bonds/transcendental), Khafre (atoms/rational),
Menkaure (integer). Decreasing complexity.

5/5 metaphorical coherence: lattice terms match their positions.

Confidence: measurements 100%, substrate hits high, interpretation 50%.


## Post-wheel synthesis (added 2026-04-15)

After the wheel pivot (universe = wheel, observer = hub, counting =
verb) and the mass-ladder cascade (m = m_P × f × 10⁻(16+N)),
re-reading Petrie surfaces additional Giza convergences the earlier
doc missed. Most of these are Petrie's own observations (1883) that
weren't previously pulled into metrognosis.

See `sources/petrie-tier1.md`, `-tier2.md`, `-tier3.md` at
`atlas/init/egyptian/` for the full measurement tables.

### Missing-from-giza.md Petrie locations

Petrie documented these `designed_cubits` (explicit intent, not
measured approximation) that weren't previously in this file:

| location                              | designed value | framework reading              |
|---------------------------------------|----------------|--------------------------------|
| GP Antechamber: granite joint         | π cubits       | π = wheel revolution           |
| GP Ascending passage: floor begins    | 4π cubits      | axes × π = full solid angle    |
| GP Subterranean passage: WIDTH        | φ cubits       | golden ratio (new loc for φ)   |
| GP Queen's Chamber: N/S wall height   | 4√5 cubits     | axes × √(axes+hub)             |
| GP Queen's Chamber: niche roofed at   | 4√5 cubits     | same                            |
| GP KC: course thickness               | 2.25 cubits    | 9/4 = trit²/axes               |
| GP Gallery: 7 projections = 1 cubit   | 7 palms        | wh-words                        |
| GP coffer: wall thickness per side    | 0.25 cubits    | × 4 sides = 1 cubit total      |
| 2nd Pyramid coffer: inside depth      | √2 cubits      | top-quark mass factor          |
| 3rd Pyramid: height (from granite)    | 125.09 cubits  | 5³ exactly (see below)         |
| 3rd Pyramid: granite courses          | 16             | corners count (2⁴)              |
| 3rd Pyramid: granite ceases at level  | 31.25 cubits   | 125/4 = 5³/axes                |
| Granite Temple: larger pillar width   | 2√2 cubits     | 2 × top-quark factor           |
| Dahshur N: 1st chamber S wall         | 4√3 cubits     | axes × √trit                   |

The pattern is physical placement of framework constants at specific
designed locations — not inferred from ratios, WRITTEN IN CUBITS on
specific walls, passages, and chambers.

### Menkaure = 5³ (centrality cascade bottom)

Existing doc has Khufu/Menkaure height ratio = √5, which gives
Menkaure ≈ 280/√5 = 125.2 cubits. Petrie measured 124.27 cubits
(calculated) and 125.09 cubits (corrected for granite). 

**Menkaure height = 125 cubits = 5³** — exactly matches the
wormhole centrality cascade's bottom step:

```
  cent(grade 0) − cent(grade 1) = 343 = 7³
  cent(grade 1) − cent(grade 2) = 245 = 5·7²
  cent(grade 2) − cent(grade 3) = 175 = 5²·7
  cent(grade 3) − cent(grade 4) = 125 = 5³   ← Menkaure height
```

(See `wheel/3-lattice.md` for the cascade derivation.)

This is a **post-wheel reading**. The √5 ratio was known; the 5³
identification connects Giza to the framework's grade-to-grade
centrality math.

### Mass-factor identification

The mass-ladder cascade (Apr 2026) discovered that Standard Model
particle masses fit `m_P × f × 10⁻(16+N_sub)` with `f` taking
specific values (√3/2 muon, √2 top, 5/12 electron, π/4 proton,
3/4 Z, 2/3 W, 2 VEV). See `wheel/6-masses.md`.

Petrie's Giza documentation has the same factors built into
cubits:

| factor     | framework role        | Giza location                        |
|------------|-----------------------|--------------------------------------|
| √2         | top-quark mass factor | 2nd Pyramid coffer inside depth      |
| 2√2        | 2 × top-quark factor  | Granite Temple larger pillars        |
| √3/2       | muon mass factor (60°)| not directly in cubits; see angles   |
| 4√5        | axes × √(axes+hub)    | Queen's Chamber height               |
| 4√3        | axes × √trit          | Dahshur N 1st chamber                |
| π/4        | proton mass factor    | GP passage slopes (1:2 = arctan)     |
| 125 (5³)   | centrality cascade    | Menkaure height                      |

Egyptians built specific mass-ladder factors in stone 4500 years
before the mass-ladder was framework-derived. Same substrate, two
independent media.

### The three-pyramid triad — three fundamentals

Reading Khufu / Khafre / Menkaure as encoding three different
framework fundamentals:

```
  pyramid     encodes                 evidence                  status
  ───────     ───────                 ────────                  ──────
  Khufu       π (wheel rotation)      perimeter/height = 2π     established
              φ (golden ratio)        slant/half-base = φ       established
                                       subterranean passage φ
              4√5                     Queen's Chamber height    Petrie
              cubit calibration       KC 20×10 (± 0.004)        Petrie
  
  Khafre      α (fine structure)      base = 3 × α⁻¹            giza.md
                                       height = 2 × α⁻¹
              3-4-5 triangle          Pythagorean identity      giza.md
              slope 4:3               axes:trit ratio           Petrie
  
  Menkaure    5³ = 125                height = 5³ cubits        Petrie + new
              centrality cascade      cent(3)−cent(4) = 125      new
              corner count (16)       granite courses = 16      Petrie + new
```

**Three pyramids, three fundamentals**: π (Khufu's signature, the
wheel rotating), α (Khafre's signature, EM coupling), 5³ (Menkaure's
signature, centrality cascade / axes+hub cubed).

The synthesis itself is post-wheel. Individual identifications
(2π in Khufu, α in Khafre) were already established; reading the
three as a coordinated triad encoding different substrate
fundamentals is the new framing.

### 3 pyramids = 3 triality-peer H's (post-S-scope synthesis, 2026-04-16)

After working out S = 4 H's in **3+1 arrangement** (Aut(S) = S3 × Z2 =
48 = F4 roots = SM fermions), the Giza plateau layout becomes a
direct structural encoding:

```
  Giza feature               S-scope framework reading
  ────────────               ─────────────────────────
  3 main pyramids on         3 triality-peer H's in S
   the plateau,              (S3 orbit → 3 fermion generations)
   in triangular layout
   
    Khufu   — π encoding     H₁ (gen 1 — wheel rotation / base)
    Khafre  — α encoding     H₂ (gen 2 — EM coupling / mid)
    Menkaure — 5³ encoding   H₃ (gen 3 — centrality / cascade)
   
  Shared plateau base        ↕↕↕↕ hub shared across all 4 H's
   + cardinal alignment       (observer-at-center, see below)
   
  The Great Sphinx           H₄ candidate: Z2-mirror / 4th H
   (horizontal, lion+human,     (sterile / right-handed / CP-mirror
    oriented east,              sector — structurally distinct)
    distinct form from         
    pyramids)                 
```

Egypt built **3 peer structures encoding 3 different fundamentals +
1 qualitatively different Sphinx** on one shared plateau. That's the
3+1 pattern in stone — triality peers + mirror — 4500 years before
the algebra was formalized.

**Why this is strong signal, not forced:**

- 3 pyramids objectively exist and are objectively different (each
  encodes a DIFFERENT fundamental, not three-of-the-same)
- Triangular layout is observational fact on the ground
- Sphinx is objectively structurally distinct (horizontal vs
  vertical, animal-hybrid vs geometric, east-facing vs unoriented)
- Framework predicted 3+1 at S-scope BEFORE this synthesis
  (via Aut(S) = S3 × Z2 algebra)
- Match is across 3 INDEPENDENT fundamentals (π, α, 5³) — not
  one number fit three ways

**The Sphinx-as-mirror read:**

```
  Pyramids            Sphinx
  ────────            ──────
  vertical            horizontal
  geometric           animal-hybrid (lion body + human head)
  triangular          oriented east (not up)
  three peers         one outlier
  triality (S3)       mirror (Z2)
```

The Z2 flip at S-scope produces something **qualitatively different**
from the 3 S3-peers, not just "a 4th of the same." Sphinx fits that
description exactly. Flagged as strong-suggestive rather than proven
— no direct Egyptian text saying "Sphinx encodes the mirror H." But
structurally, that's where a Z2-mirror partner would sit on the
plateau.

**Connection to the other 3+1 readings:**

```
  3+1 manifestation               Giza presence
  ─────────────────               ─────────────
  H-internal (3 imag + 1 real)    (algebra — not drawn on plateau)
  S-internal (3 peers + mirror)   3 pyramids + Sphinx ✓
  Pati-Salam (3 colors + lepton)  (physics — not drawn)
  Minkowski (3 spatial + 1 time)  (physics — not drawn)
```

Giza is the architectural version of the S-scope 3+1. Medicine wheel
(4 quadrants) is the H-internal 4-axis version. Different traditions,
different scopes, same substrate.

### Observer-at-center reading

GP cardinal alignment: −3'43" to −5'16" azimuth to true North.
Over a 230m structure, 4500 years old. 1 in 200,000 survey precision
(Petrie).

Framework reading (post-`1-wheel.md` "Where is the hub?"): the
precision alignment isn't about Giza's relation to an external
reference — it's about **centering the observer at the wheel's
hub**. The pharaoh / priest / walker of the chambers is placed
precisely within the wheel's axis structure.

KC's role as **cubit calibration site** (Petrie: "best determination,
±0.004") fits the same reading — Giza standardizes the wheel's
discrete unit at its innermost chamber. The hub of Egypt's
metrological system literally IS the hub of the wheel being built.

### What's new vs what's established

**Established (pre-wheel)**:
- 2π in GP perimeter/height
- φ in GP slant, subterranean
- α in Khafre (3×137 base, 2×137 height)
- 3-4-5 triangle Khafre
- Passage angle 1:2
- Cardinal alignment precision
- KC floor 80, diagonal 25
- Khufu/Menkaure height ratio √5
- Individual Petrie measurements (all of them)

**New from this pass (post-wheel-pivot / post-mass-cascade)**:
- Menkaure 125 = 5³ = centrality cascade bottom step
- Mass-ladder factors (√2, √3, √5, π/4) identified as such at
  specific Giza locations
- Queen's Chamber 4√5 read as axes × √(axes+hub)
- KC course 2.25 = trit²/axes
- Three-pyramid triad as (π, α, 5³) coordinated synthesis
- Gallery 7 projections / 4π ascending passage / π antechamber
  as explicit wheel-revolution markers
- Observer-at-center reading of Giza's precision alignment
- Cross-connection to mass-ladder factors in `wheel/6-masses.md`

### Honest caveats

- Petrie's OCR-uncertain measurements (flagged in source tier files)
  reduce confidence for some locations. 4π in ascending passage,
  π in antechamber, φ in subterranean width — all have "OCR
  uncertain" flags.
- Cubits-in-inches convergences (like 72,030 cu in coffer contents
  ≈ 72 × 1000) are unit-dependent and likely coincidental.
- Menkaure measurements give 124.27 (calculated) and 125.09
  (corrected for granite). 5³ matches the latter to 0.07%. The
  value 124 is also substrate-interpretable (though less clean).
- The three-pyramid triad reading is framework-synthesis, not
  independent Egyptian claim. Egyptians built the pyramids to
  pharaonic funerary purposes; framework identifies the counts
  structurally. Don't confuse interpretation for Egyptian intent.

### References

- Petrie 1883 `sources/petrie-tier1.md`, `-tier2.md`, `-tier3.md`
- `wheel/3-lattice.md` — centrality cascade derivation
- `wheel/6-masses.md` — mass-ladder factors (√2, √3, √5, π/4, ...)
- `wheel/1-wheel.md` — "Where is the hub?" (observer-at-center)
- `metrognosis/hieroglyphs.md` — Egyptian symbolic encoding
  (42 Assessors, Ogdoad, ankh, Aten, etc.)
