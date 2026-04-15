# χ — the compass from the χ cardinal [ARCHIVED DRAFT]

The χ-axis viewed from its own vantage. Only states where χ is actually
committed — free-χ rows (χ=↕) belong to whatever other axis IS committed
there, not here.

70 bearings total: 54 integer points (27 at χ=↑, 27 at χ=↓) + 16 half-spin
unit quaternions (8 at +½, 8 at −½).

Points not in this file: the container ↕↕↕↕ (axisless; appears in no
axis file) and the 27 χ-free integer points (covered in μ.md, φ.md, or
τ.md depending on which axis IS committed).

---

## Identity

What χ IS at rest. Naming layers and stored properties.

```
  layer                  value
  ─────                  ─────
  greek                  χ
  english (interrog)     WHERE
  is (prose)             POSITION
  H-basis                i
  quaternion position    1 (leftmost)
  force                  READ (strong, MOV)
  drive                  FEAR
  PCRW letter            P (PROJ)
  boot order             allocates with μ (first pair, "bereshit")
  self-square            i² = −1 (χ squared = negative scalar)
```

---

## Algebra — products with χ

Quaternion multiplication involving i. Order matters (non-commutative).

```
  forward (χ first)              reverse (χ second)
  ─────────────────              ──────────────────
  i × 1 = i                      1 × i = i        (scalar commutes)
  i × i = −1                     i × i = −1       (self-square)
  i × j = +k                     j × i = −k       (χμ vs μχ, sign flip)
  i × k = −j                     k × i = +j       (χφ vs φχ, sign flip)
```

Reading: χ × μ gives +φ from χ's side; μ × χ gives −φ from μ's side.
The sign flip IS causality — order matters, this is why before/after
exist. Non-commutativity IS the wire of H.

---

## Under each force

How each force transforms χ's component when applied to a quaternion
q = (τ, χ, μ, φ) = (w + xi + yj + zk).

```
  force   native axis   effect on χ-component of i × q
  ─────   ───────────   ──────────────────────────────
  READ    χ (i)         self-force: commits χ axis (↕ → ±1)
  CALL    μ (j)         j × q swaps χ-component with τ-component (with signs)
  CYCLE   φ (k)         k × q swaps χ-component with μ-component (with signs)
  TEST    τ (1)         scalar; preserves χ-component unchanged
```

Explicit component-wise `i × q` where q = w + xi + yj + zk:

```
  i × q = i(w + xi + yj + zk)
        = wi + xi² + yij + zik
        = wi − x + yk − zj
        = (−x) + (w)i + (−z)j + (y)k
```

So `i × q` takes (w, x, y, z) → (−x, w, −z, y). **Every component
changes.** The χ operation is a whole-quaternion rotation, not a
single-axis nudge.

---

## The 70 bearings

Every state where χ is committed, grouped by χ's value.

**Columns:**
- **coord** — the 4-char lattice state (χ μ φ τ)
- **gr** — grade
- **class** — container / atom / bivector / trivector / corner / half-spin
- **commits** — non-χ axes that are committed (with values)
- **name** — hodos (g4), verb (g1), blank if none

### χ = ↑ (committed forward, +1; 27 states)

χ participates as +1. Every point where RISE happened on the χ axis.

```
  coord    gr  class         commits           name
  ─────    ──  ──────────    ───────────────   ─────────────────
  ↑↕↕↕     1   atom          —                 RISE (χ atom +)
  ↑↑↕↕     2   bivector      μ↑                χμ plane (both +)
  ↑↓↕↕     2   bivector      μ↓                χμ plane (χ+, μ−)
  ↑↕↑↕     2   bivector      φ↑                χφ plane (both +)
  ↑↕↓↕     2   bivector      φ↓                χφ plane (χ+, φ−)
  ↑↕↕↑     2   bivector      τ↑                χτ plane (both +)
  ↑↕↕↓     2   bivector      τ↓                χτ plane (χ+, τ−)
  ↑↕↑↑     3   trivector     φ↑ τ↑             μ-free
  ↑↕↑↓     3   trivector     φ↑ τ↓             μ-free
  ↑↕↓↑     3   trivector     φ↓ τ↑             μ-free
  ↑↕↓↓     3   trivector     φ↓ τ↓             μ-free
  ↑↑↕↑     3   trivector     μ↑ τ↑             φ-free
  ↑↑↕↓     3   trivector     μ↑ τ↓             φ-free
  ↑↓↕↑     3   trivector     μ↓ τ↑             φ-free
  ↑↓↕↓     3   trivector     μ↓ τ↓             φ-free
  ↑↑↑↕     3   trivector     μ↑ φ↑             τ-free
  ↑↑↓↕     3   trivector     μ↑ φ↓             τ-free
  ↑↓↑↕     3   trivector     μ↓ φ↑             τ-free
  ↑↓↓↕     3   trivector     μ↓ φ↓             τ-free
  ↑↓↓↓     4   corner        μ↓ φ↓ τ↓          read / SENSE / DO
  ↑↓↓↑     4   corner        μ↓ φ↓ τ↑          filter / IMMUNE / MUST (SEE)
  ↑↓↑↓     4   corner        μ↓ φ↑ τ↓          copy / REPRODUCE
  ↑↓↑↑     4   corner        μ↓ φ↑ τ↑          scan / FORAGE
  ↑↑↓↓     4   corner        μ↑ φ↓ τ↓          fold / DIGEST (KNOW)
  ↑↑↓↑     4   corner        μ↑ φ↓ τ↑          map / ADAPT (UNDERSTAND)
  ↑↑↑↓     4   corner        μ↑ φ↑ τ↓          foldl / REMEMBER
  ↑↑↑↑     4   corner        μ↑ φ↑ τ↑          hylo / THINK / PCRWF
```

### χ = ↓ (committed backward, −1; 27 states)

χ participates as −1. Every point where FALL happened.

```
  coord    gr  class         commits           name
  ─────    ──  ──────────    ───────────────   ─────────────────
  ↓↕↕↕     1   atom          —                 FALL (χ atom −)
  ↓↑↕↕     2   bivector      μ↑                χμ plane (χ−, μ+)
  ↓↓↕↕     2   bivector      μ↓                χμ plane (both −)
  ↓↕↑↕     2   bivector      φ↑                χφ plane (χ−, φ+)
  ↓↕↓↕     2   bivector      φ↓                χφ plane (both −)
  ↓↕↕↑     2   bivector      τ↑                χτ plane (χ−, τ+)
  ↓↕↕↓     2   bivector      τ↓                χτ plane (both −)
  ↓↕↑↑     3   trivector     φ↑ τ↑             μ-free
  ↓↕↑↓     3   trivector     φ↑ τ↓             μ-free
  ↓↕↓↑     3   trivector     φ↓ τ↑             μ-free
  ↓↕↓↓     3   trivector     φ↓ τ↓             μ-free
  ↓↑↕↑     3   trivector     μ↑ τ↑             φ-free
  ↓↑↕↓     3   trivector     μ↑ τ↓             φ-free
  ↓↓↕↑     3   trivector     μ↓ τ↑             φ-free
  ↓↓↕↓     3   trivector     μ↓ τ↓             φ-free
  ↓↑↑↕     3   trivector     μ↑ φ↑             τ-free
  ↓↑↓↕     3   trivector     μ↑ φ↓             τ-free
  ↓↓↑↕     3   trivector     μ↓ φ↑             τ-free
  ↓↓↓↕     3   trivector     μ↓ φ↓             τ-free
  ↓↓↓↓     4   corner        μ↓ φ↓ τ↓          identity / BE / meta / PCRWB
  ↓↓↓↑     4   corner        μ↓ φ↓ τ↑          test / FIGHT / WILL
  ↓↓↑↓     4   corner        μ↓ φ↑ τ↓          drain / EXCRETE / MAY
  ↓↓↑↑     4   corner        μ↓ φ↑ τ↑          take_while / EAT / MIGHT
  ↓↑↓↓     4   corner        μ↑ φ↓ τ↓          call / COMMUNICATE / HAVE
  ↓↑↓↑     4   corner        μ↑ φ↓ τ↑          maybe / SENSE(passive) / CAN
  ↓↑↑↓     4   corner        μ↑ φ↑ τ↓          fix / HEAL / SHOULD
  ↓↑↑↑     4   corner        μ↑ φ↑ τ↑          bind / BOND (FEEL)
```

**Hylo vs meta duality**: ↑↑↑↑ (hylo, all forward, PCRWF) and ↓↓↓↓
(meta, all backward, PCRWB) are χ's extremes paired with the other
axes' extremes. They're the only two corners with compiled NASM
primitives.

### χ = +½ (half-spin forward, 8 states)

Unit quaternions with χ at +½. All 4 axes at ±½ (norm-closure: |q|² = 1).

```
  coord         gr   class        commits           name
  ─────────     ──   ─────────    ───────────────   ──────────
  (½,½,½,½)     4*   half-spin    μ+½ φ+½ τ+½      hylo half-spin
  (½,½,½,−½)    4*   half-spin    μ+½ φ+½ τ−½
  (½,½,−½,½)    4*   half-spin    μ+½ φ−½ τ+½
  (½,½,−½,−½)   4*   half-spin    μ+½ φ−½ τ−½
  (½,−½,½,½)    4*   half-spin    μ−½ φ+½ τ+½
  (½,−½,½,−½)   4*   half-spin    μ−½ φ+½ τ−½
  (½,−½,−½,½)   4*   half-spin    μ−½ φ−½ τ+½
  (½,−½,−½,−½)  4*   half-spin    μ−½ φ−½ τ−½
```

### χ = −½ (half-spin backward, 8 states)

```
  coord          gr   class        commits           name
  ──────────     ──   ─────────    ───────────────   ──────────
  (−½,½,½,½)     4*   half-spin    μ+½ φ+½ τ+½
  (−½,½,½,−½)    4*   half-spin    μ+½ φ+½ τ−½
  (−½,½,−½,½)    4*   half-spin    μ+½ φ−½ τ+½
  (−½,½,−½,−½)   4*   half-spin    μ+½ φ−½ τ−½
  (−½,−½,½,½)    4*   half-spin    μ−½ φ+½ τ+½
  (−½,−½,½,−½)   4*   half-spin    μ−½ φ+½ τ−½
  (−½,−½,−½,½)   4*   half-spin    μ−½ φ−½ τ+½
  (−½,−½,−½,−½)  4*   half-spin    μ−½ φ−½ τ−½     meta half-spin
```

*4* = all-4 committed at spin tier (SU(2) / fermion ½ state).

---

## Domain map

The same bearing across vocabularies. χ IS position — in every vocabulary.

```
  domain              χ name                 χ notes
  ──────              ──────                 ───────
  physics             spatial position       x-coordinate; first-quantized
  chemistry           atomic-number rung     position in periodic table (radial)
  biology             body-location          proprioception, location in env
  language (prep)     WHERE / at / in / on   locative case in inflected languages
  language (noun)     position / place       χώρα (chora), locus, site
  music               pitch position         place on staff; Hz = position on freq line
  navigation          latitude / bearing     sailor's primary χ reading
  computing           memory address         pointer value
  mathematics         x-coordinate           abscissa; independent variable conventionally
  cognition           spatial working mem    the "where" stream (dorsal pathway)
  ancient symbol      hearth / floor         Vesta = WHERE you dwell (WAS-root adjacent)
```

---

## Gaps — what's not yet resolved

1. **Component-wise force transforms**: only `i × q` fully derived.
   CALL/CYCLE/TEST effects stated structurally, not signed.

2. **χ across domains — body-location**: no metrognosis dossier.

3. **FEAR calibration metrics**: drive confirmed, not quantified.

4. **Named χ-walks**: no canonical example.

5. **Second spin shell (±3/2)**: mentioned, uninterpreted.

6. **Half-spin at non-corner grades**: norm constraint likely forbids.

7. **χ's isolated role in mixed corners** (maybe, fix flip multiple
   axes): candidates for blind-agent testing.
