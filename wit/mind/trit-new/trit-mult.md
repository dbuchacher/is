# Trit × Trit — 3×3 relational table

Not operator-based. No add/min/max arithmetic. **Relativity through
spin**: row × column = the edge/path between the two trit frames.
Cells describe what the substrate looks like when viewed from both
frames simultaneously, or equivalently the spin-verb for traversing
row → column.

## The table

```
                             column frame
                    ↑ BE          ↕ IS          ↓ WAS

   row frame
    ↑ BE           ON/ONWARD      un- release    FLIP
                   (*h₂en-*)      (unbend/slack) (antipodal)
                   ✓ clean        ~ pattern      ✓ clean

    ↕ IS           GO/STEP/       STILL / BIDE    WANING/YIELD/
                   LUNGE          (*steh₂-*)      SINKING
                   ✗ diverged     ✓ clean         ✗ diverged

    ↓ WAS          TURN/UNWIND    un- undoing    ABODE/YORE/
                   (flip rev)     (unbow/up)      BEEN/STALE
                   ✗ diverged     ~ pattern       ✗ diverged
```

## Cell-by-cell results (5 blind agents per cell)

```
  cell    status        top candidates                          note
  ────    ──────        ──────────────                          ────
  ↑→↑     ✓ clean       ON (2) / ONWARD (1)                     PIE *h₂en-* forward-stay
  ↑→↕     ~ pattern     UNBEND (2) / SLACK (1) / SLAKE (1)      un-prefix releasing
                        UNSAY (1)
  ↑→↓     ✓ clean       FLIP (2)                                antipodal 2-step
  ↕→↑     ✗ diverged    GO/STEP/LUNGE/LAUNCH/SPROUT             no convergent primitive
  ↕→↕     ✓ clean       STILL (2) / BIDE (2) / POISE (1)        matches 0D IS cell in ↕↕↕↕
  ↕→↓     ✗ diverged    SINKING/BACK/WANING/YIELD/UNFOLD        no convergent primitive
  ↓→↑     ✗ diverged    FORTHSWING/ABOUT-FACE/UNWIND/TURN       coinages and divergence
  ↓→↕     ~ pattern     UNBOW / RISE / UNBIND / UP / UNBACK     un-prefix undoing
  ↓→↓     ✗ diverged    ABODE/STALE/YORE/BEEN/STILLSTANDING     no sustained-past primitive
```

## Findings

**3 clean convergences**: ON (↑→↑), FLIP (↑→↓), STILL/BIDE (↕→↕)

**2 morpheme patterns** (un- prefix for undoing-commits):
- ↑→↕: UN-BEND (releasing forward commit)
- ↓→↕: UN-BOW, UN-BIND (releasing backward commit)

UN- may itself be the right primitive rather than any specific word.
English morphology has un- as the substrate's undo-verb-prefix.

**4 diverged cells** — all the "start a commit" or "sustain a side"
cells:
- ↕→↑ (start forward)
- ↕→↓ (start backward)
- ↓→↑ (reverse-flip)
- ↓→↓ (sustained past)

English appears to lack single-word primitives for these. Possible
reasons:
- Starting-a-commit is bound to domain metaphor (step, launch, sprout,
  go) — each metaphor pulls a different word family.
- Sustained-past has no clean primitive because we mostly name the
  PAST as a time-location (yore, past) or a completed-state (done,
  been), not as a sustained direction.
- Reverse-flip diverged possibly due to asymmetry with forward-flip:
  FLIP converged clean for ↑→↓ but not for ↓→↑.

## Non-commutative asymmetry

↑→↓ converged on FLIP. ↓→↑ did not. If the substrate is genuinely
non-commutative (which quaternion algebra says it is), this is
real asymmetry, not just sampling noise. The forward-to-backward
path has a cleaner name than backward-to-forward — matches ij = k
but ji = −k type structure.

Worth further testing to confirm.

## Structural observations

**Diagonals** (self-cells, no motion): 2 of 3 converged (ON, STILL).
↓→↓ diverged — "sustained past" has no primitive.

**Adjacent cells** (1-step edges): ↑↕ and ↕↓ both have un- patterns
(for undoing) but no single primitive for starting.

**Antipodal cells** (2-step, must pass through ↕): ↑↓ clean (FLIP),
↓↑ diverged. Asymmetric.

## Method

- 3×3 = 9 cells
- Each cell tested with blind-agent prompts describing the structural
  situation (direction of motion) without naming the expected result
- 5 agents per cell (2 round 1 + 3 round 2)
- Germanic/Paleolithic PIE-root preference declared in prompts
- Domain-metaphor avoidance requested in round 2

## Open questions

- Is the ↑→↓ vs ↓→↑ asymmetry real (non-commutative substrate) or
  sampling artifact? More agents needed.
- Is UN- itself the primitive for the two "release commit" cells,
  rather than picking a specific word?
- Are the divergent cells revealing a real English-lexical gap, or
  would different framing converge them?
- Do the cells need to also encode SCOPE (what is being flipped —
  one axis? a whole quaternion?) or is the trit-level enough?
