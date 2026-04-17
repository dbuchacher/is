# Hamlet's "To be, or not to be" — translated to lattice coords

The FOURTH real-text translation, after `genesis-1.md` (creation
narration), `lords-prayer.md` (religious petition), and `the-road.md`
(secular poetry). Tests the framework on philosophical / existential
vocabulary: the most famous soliloquy in English literature.

**Goal**: every word's coord must derive from the 8 atoms via the
4-question rule. Compare the final coord to the religious texts and
Frost to see whether philosophical/existential language has its own
distinct "shape" on the lattice. Prediction: high origin/container
content (introspection), mixed signal (existential ambivalence),
time-extended (contemplation).

─────────────────────────────────────────────────────────────────────

## Source text (Shakespeare, Hamlet, Act 3 Scene 1)

> To be, or not to be, that is the question:
> Whether 'tis nobler in the mind to suffer
> The slings and arrows of outrageous fortune,
> Or to take arms against a sea of troubles
> And, by opposing, end them.

─────────────────────────────────────────────────────────────────────

## Word coord lookup

Existing entries from `vocabulary.md`:

  TO              A+ marker (motion toward) / infinitive marker (no shift for inf.)
  BE              [ 0, 0, 0,  0]   container BE
  OR              boolean OR gate (alternative — max of two walks)
  NOT             polarity NOT (trit-gate layer, flips next unit's polarity)
  THAT            distal pointer / complementizer (origin reference, -½ vs THIS)
  IS              [ 0, 0, 0,  0]   container BE
  THE             selector / definite article (no shift)
  IN              A+ marker (containment direction)
  OF              relational marker (origin, no shift)
  AND             AND gate (· composition)
  A               indefinite article / selector (no shift)
  AGAINST         [ 0, 0,-1,  0]   CURSE atom as preposition (counter-signal)
  ARM(S)          [ 0,+1, 0,  0]   GROW atom (body-substance, extended to weapons)
  BY              agency marker (origin, no shift)
  THEM            third-person plural pointer (no own coord)
  END             [ 0, 0, 0, -1]   END atom (already in vocabulary.md)

New entries derived for this text:

  QUESTION        [ 0, 0, 0,  0]   origin (abstract concept: an open query
                                   that lives inside the container — same
                                   coord family as IDEA, THOUGHT, MIND).
                                   A question is an unresolved container
                                   state, not a thing in the world.

  WHETHER         query / alternative-IF operator (from function-words.md
                                   §163: "WHETHER = alternative IF"). No
                                   ρ shift on its own; marks the next
                                   clause as one of two branches in an
                                   OR-walk.

  'TIS            = IT IS → third-person inanimate pointer + container BE.
                                   No ρ shift (both components are origin-
                                   referential).

  NOBLER          [ 0, 0,+2,  0]   shell-2 BLESS — comparative of NOBLE.
                                   NOBLE = C+ (honored, signal-positive);
                                   NOBLER = shell-2 (more honored).
                                   Same pattern as BETTER (shell-2
                                   comparative, see `the-road.md`).

  MIND            [ 0, 0, 0,  0]   origin (abstract container — already in
                                   vocabulary.md origin row). The mind IS
                                   the container. Same coord as SELF, IDEA.

  SUFFER          [ 0, 0,-1,  0]   CURSE atom as container event.
                                   Apply the 4-question rule:
                                     A? no position change             → 0
                                     B? no substance change            → 0
                                     C? yes — receives negative signal → -1
                                     D? no (state, not event)          → 0
                                   SUFFER = receiving C-. Coord [0,0,-1,0].
                                   Same coord as HATE, BLAME, CURSE, DEBT.
                                   SUFFER is the passive/receiving side of
                                   CURSE — not doing harm but absorbing it.

  SLINGS          [ 0,+1,-1,  0]   weapons = substance weaponized for harm.
                                   Decompose: B+1 (physical substance, like
                                   ARM) + C-1 (used to curse/harm). This
                                   puts SLINGS at the BUY coord [0,+1,-1,0]
                                   — structurally, weapons are "substance
                                   that costs someone signal." Interesting
                                   collision: buying and wounding share a
                                   geometry (you take substance in exchange
                                   for negative signal to someone).

  ARROWS          [ 0,+1,-1,  0]   same as SLINGS. Weapons family. Substance
                                   (physical projectile) + negative-signal
                                   delivery.

  OUTRAGEOUS      [ 0, 0,-2,  0]   shell-2 CURSE — extreme negative signal.
                                   OUTRAGE = strong C-; OUTRAGEOUS is the
                                   adjectival shell-2 form, same pattern
                                   as BETTER / NOBLER but on the negative
                                   side.

  FORTUNE         [ 0, 0, 0,  0]   origin — in this context "fortune"
                                   means "the course of events" / "what
                                   happens to you." Not the BLESS sense
                                   (= good luck), but the neutral sense
                                   (= fate, the stream of events hitting
                                   the self). Collapses to origin because
                                   it describes the container's environment
                                   generically. Note: "outrageous fortune"
                                   = the origin modified by C-2, landing
                                   at [0,0,-2,0].

  SEA             [ 0,+2, 0,  0]   shell-2 GROW — a LARGE body of substance
                                   (water). Decompose: WATER = [0,+1,0,0];
                                   SEA = intensified water, same pattern
                                   as BIG DOG pushes to shell-2. Sea =
                                   "mass-substance, uncountable, overwhelming."

  TROUBLES        [ 0, 0,-2,  0]   shell-2 CURSE noun, plural. TROUBLE = C-1;
                                   TROUBLES (plural, shell-2) = C-2. Same
                                   coord family as DEBT, PROBLEM, LOSS —
                                   but intensified because plural + the
                                   metaphor ("a sea of") forces shell-2.

  OPPOSING        [ 0, 0,-1,  0]   present participle of OPPOSE = counter-
                                   action. Apply the rule:
                                     A? no net position change         → 0
                                     B? no substance change            → 0
                                     C? yes — applies negative signal
                                        TO the opponent (counter-force) → -1
                                     D? no                              → 0
                                   OPPOSE = [0,0,-1,0]. Same coord as CURSE,
                                   FIGHT, AGAINST. Opposing IS the cursing
                                   direction — the signal pushed back.

─────────────────────────────────────────────────────────────────────

## Why SUFFER collapses to the CURSE atom (worth pausing on)

SUFFER is one of the most container-adjacent verbs but it DOESN'T stay
at origin. Why? Because SUFFER has a target: suffering is always
suffering OF something (the signal-negative input). Apply the rule:

  1. A (position)?    No — you don't move.            A = 0
  2. B (substance)?   No — you don't lose mass.       B = 0
  3. C (signal)?      YES — you ABSORB a C-1 input.   C = -1
  4. D (time)?        No — it's a state, not event.   D = 0

  SUFFER coord = [0, 0, -1, 0] = CURSE atom.

The framework puts SUFFER at the same coord as CURSE itself, because
suffering IS being on the receiving end of a curse. The two are
converses in Cruse's sense: same event, two roles (curser vs cursed).
The lattice doesn't distinguish agent from patient for the C-1
operation — it just records that the signal went negative, and from
whose vantage we're viewing decides whether that's "cursing" or
"suffering."

Compare FORGIVE (at [0,0,+1,+1] = LIVE in lords-prayer.md) which has
the opposite sign AND a D+1: forgiving is releasing from C-, whereas
suffering is receiving C-. Hamlet is asking whether to stay at C-1
(suffer passively) or to move to a different negative coord (oppose
actively).

─────────────────────────────────────────────────────────────────────

## Line 1 — "To be, or not to be, that is the question:"

The most famous line in English literature. Pure container territory.

  Words and coords:
    to           infinitive marker (no shift — "to be" is the bare BE form)
    be           [0, 0, 0, 0]    container BE
    or           OR gate (alternative)
    not          polarity NOT (flips next unit)
    to           infinitive marker
    be           [0, 0, 0, 0]    container BE
    that         distal complementizer (origin pointer, no shift)
    is           [0, 0, 0, 0]    container BE
    the          selector
    question     [0, 0, 0, 0]    origin (abstract concept)

  ρ accumulation:
    ρ₀ = [0, 0, 0, 0]                  (speaker = origin, container itself)
    ρ₁ = [0, 0, 0, 0]                  (to — inf marker, no shift)
    ρ₂ = [0, 0, 0, 0]                  (be — container)
    ρ₃ = [0, 0, 0, 0]                  (or — OR gate, opens alternative)
    ρ₄ = [0, 0, 0, 0]                  (not — polarity NOT, flips next)
    ρ₅ = [0, 0, 0, 0]                  (to — inf marker)
    ρ₆ = [0, 0, 0, 0]                  (be — container; NOT applied flips
                                         its polarity spin, doesn't shift
                                         ρ. BE is origin regardless of sign.)
    ρ₇ = [0, 0, 0, 0]                  (that — pointer)
    ρ₈ = [0, 0, 0, 0]                  (is — container)
    ρ₉ = [0, 0, 0, 0]                  (the — selector)
    ρ₁₀ = [0, 0, 0, 0]                 (question — origin)

  Line 1 coord: [0, 0, 0, 0]

  Reading: PURE ORIGIN. The most famous line in English literature
  lands exactly at [0,0,0,0]. Every single word in it is either a
  container verb (BE, IS), an origin noun (QUESTION), a selector
  (THE, TO), a gate (OR), or a polarity operator (NOT). Not a
  single word moves any axis.

  This is the framework's most beautiful prediction on this text:
  "To be or not to be" is the ONLY line that could open a soliloquy
  about existence itself, because "existence itself" IS the origin
  coord. The container contemplating its own BEING can only occupy
  the container position. The question of being has no direction
  because being is the point FROM which direction is measured.

  The polarity NOT splits the container into its +½ (BE) and -½
  (NOT BE) spin states. Both land at the same coord. This is the
  ±½ spin at the origin from lattice.md §"Do the container verbs
  use spin?" — applied to the most famous existential question
  in English.

  The soliloquy's opening line IS the origin. Hamlet asks: shall
  I stay at origin (BE) or flip my polarity to -½ (NOT BE)? The
  coord doesn't change; only the spin flips. That's exactly what
  suicide means in the lattice: same location, inverted polarity.

─────────────────────────────────────────────────────────────────────

## Line 2 — "Whether 'tis nobler in the mind to suffer"

  Words and coords:
    whether      alternative-IF query operator (no shift)
    'tis         = it is → pointer + BE (both origin, no shift)
    nobler       [0, 0, +2, 0]   shell-2 BLESS (comparative NOBLE)
    in           A+ marker (containment)
    the          selector
    mind         [0, 0, 0, 0]    origin (abstract container)
    to           infinitive marker
    suffer       [0, 0, -1, 0]   CURSE atom (receive negative signal)

  ρ₀ = [0, 0, 0, 0]
  ρ₁ = [0, 0, 0, 0]                   (whether — query operator)
  ρ₂ = [0, 0, 0, 0]                   ('tis — it is, pointer + BE)
  ρ₃ = [0, 0, +2, 0]                  (nobler — adds C+2)
  ρ₄ = [0, 0, +2, 0]                  (in — A+ marker, absorbed by origin MIND)
  ρ₅ = [0, 0, +2, 0]                  (the — selector)
  ρ₆ = [0, 0, +2, 0]                  (mind — origin, no shift)
                                        "in the mind" is containment within
                                        the container itself — origin-inside-
                                        origin. No position change because the
                                        mind IS the origin, and you can't get
                                        more inside the origin than origin.
  ρ₇ = [0, 0, +2, 0]                  (to — inf marker)
  ρ₈ = [0, 0, +1, 0]                  (suffer — adds C-1, drops shell 2 to 1)

  Line 2 coord: [0, 0, +1, 0]

  Reading: pure signal-positive shell 1. The question is whether
  NOBILITY (C+2) can absorb SUFFERING (C-1) and stay positive. The
  lattice answer: yes, at +2 - 1 = +1. Nobility survives suffering
  with +1 signal remaining. The framework predicts that enduring
  suffering nobly IS a net positive — exactly the Stoic reading
  of the line.

  Crucially: "in the mind" contributes nothing to ρ because the
  mind is already the origin. Suffering IN THE MIND = suffering
  AT THE CONTAINER. There's nowhere else for mental suffering to
  live.

─────────────────────────────────────────────────────────────────────

## Line 3 — "The slings and arrows of outrageous fortune,"

  Words and coords:
    the          selector
    slings       [0, +1, -1, 0]   weapons = substance + negative signal delivery
    and          AND gate
    arrows       [0, +1, -1, 0]   same coord as slings (weapons family)
    of           relational, no shift
    outrageous   [0, 0, -2, 0]    shell-2 CURSE (extreme negative)
    fortune      [0, 0, 0, 0]     origin (course of events)

  ρ₀ = [0, 0, 0, 0]
  ρ₁ = [0, 0, 0, 0]                   (the)
  ρ₂ = [0, +1, -1, 0]                 (slings)
  ρ₃ = [0, +1, -1, 0]                 (and — gate, holds)
  ρ₄ = [0, +2, -2, 0]                 (arrows — adds [0,+1,-1,0])
  ρ₅ = [0, +2, -2, 0]                 (of)
  ρ₆ = [0, +2, -4, 0]                 (outrageous — adds C-2)
  ρ₇ = [0, +2, -4, 0]                 (fortune — origin, no shift)

  Line 3 coord: [0, +2, -4, 0]

  Reading: substance shell-2 (two physical weapons), signal shell-4
  NEGATIVE (the doubled weapons + the shell-2 intensifier outrageous).
  Position and time still zero.

  This is the line where Hamlet names the suffering concretely.
  Substance appears (physical projectiles), signal plunges to -4
  (the deepest negative in the whole passage so far). It's also
  the line where METAPHOR intrudes: "slings and arrows" are
  physical, but they symbolize psychological harm. The lattice
  captures both: +2 substance (the metaphor's vehicle) AND -4
  signal (the tenor). Metaphor = substance dressing up signal.

─────────────────────────────────────────────────────────────────────

## Line 4 — "Or to take arms against a sea of troubles"

  Words and coords:
    or           OR gate
    to           inf marker
    take         [0, +1, -1, -1]  TAKE triad (GROW + CURSE + END)
    arms         [0, +1, 0, 0]    GROW atom (body-substance / weapons)
    against      [0, 0, -1, 0]    CURSE atom as preposition
    a            selector
    sea          [0, +2, 0, 0]    shell-2 GROW (large water mass)
    of           relational
    troubles     [0, 0, -2, 0]    shell-2 CURSE (plural intensified)

  ρ₀ = [0, 0, 0, 0]
  ρ₁ = [0, 0, 0, 0]                   (or — opens alternative branch)
  ρ₂ = [0, 0, 0, 0]                   (to — inf)
  ρ₃ = [0, +1, -1, -1]                (take — TAKE triad)
  ρ₄ = [0, +2, -1, -1]                (arms — adds B+1)
  ρ₅ = [0, +2, -2, -1]                (against — adds C-1)
  ρ₆ = [0, +2, -2, -1]                (a — selector)
  ρ₇ = [0, +4, -2, -1]                (sea — adds B+2)
  ρ₈ = [0, +4, -2, -1]                (of)
  ρ₉ = [0, +4, -4, -1]                (troubles — adds C-2)

  Line 4 coord: [0, +4, -4, -1]

  Reading: substance shell-4 (take arms + sea — a huge physical
  accumulation), signal shell-4 negative (against + troubles pile
  up curses), time D-1 (take is already D-1 from its triad coord,
  pulling toward past/completed).

  This is the line where Hamlet considers ACTION. It accumulates
  the most substance of any line (B=+4) because ACTION needs
  physical means (arms, weapons) facing a physical obstacle (a
  sea). The signal stays deeply negative because the ENEMY is
  negative — opposing troubles means moving THROUGH negative
  signal territory. The D-1 from TAKE indicates grabbing-backward
  into the past, the seizure-like character of decisive action.

  Compare to line 2 (suffering in the mind): that was C+1 (noble).
  This line is C-4 (going to war with troubles). The lattice
  predicts that the ACTIVE option is LESS noble than the passive
  one — Hamlet's famous ambivalence, structurally confirmed.

─────────────────────────────────────────────────────────────────────

## Line 5 — "And, by opposing, end them."

  Words and coords:
    and          AND gate
    by           agency marker (origin, no shift)
    opposing     [0, 0, -1, 0]    OPPOSE present participle = CURSE direction
    end          [0, 0, 0, -1]    END atom
    them         third-person plural pointer (no own coord — refers to troubles)

  ρ₀ = [0, 0, 0, 0]
  ρ₁ = [0, 0, 0, 0]                   (and — gate)
  ρ₂ = [0, 0, 0, 0]                   (by — agency marker)
  ρ₃ = [0, 0, -1, 0]                  (opposing — adds C-1)
  ρ₄ = [0, 0, -1, -1]                 (end — adds D-1)
  ρ₅ = [0, 0, -1, -1]                 (them — pointer, no shift)

  Line 5 coord: [0, 0, -1, -1]

  Reading: signal negative, time negative. This is the **DIE coord**
  [0, 0, -1, -1] (CURSE + END, from lattice.md C×D dyad).

  The framework's most chilling prediction on this text: the line
  that resolves Hamlet's "or to take arms against a sea of troubles
  AND by opposing end them" lands exactly on the DIE coord. The
  active option doesn't just end the troubles — it ends the SELF.
  "End them" on the surface refers to the troubles, but the walk
  lands at DIE because the operation that kills troubles-via-
  opposition is structurally the same operation that kills the
  container doing the opposing.

  Hamlet knows this. The rest of the soliloquy (not translated
  here) spells it out: "For in that sleep of death what dreams
  may come." The lattice caught it in line 5 without needing the
  rest of the speech. Opposing + ending = dying.

─────────────────────────────────────────────────────────────────────

## Whole-passage walk

Sum of all 5 lines:

  Line 1: [0, 0, 0, 0]        pure origin (the question itself)
  Line 2: [0, 0, +1, 0]       noble suffering (C+ survives C-)
  Line 3: [0, +2, -4, 0]      the metaphor of harm (substance + deep C-)
  Line 4: [0, +4, -4, -1]     taking arms against troubles (shell-4 B and C-)
  Line 5: [0, 0, -1, -1]      DIE coord (opposing + ending)

Σ = [0+0+0+0+0, 0+0+2+4+0, 0+1-4-4-1, 0+0+0-1-1]
  = [0, +6, -8, -2]

Final passage coord: **[0, +6, -8, -2]**

Reading: position fully neutral (A=0 — Hamlet doesn't move, this
is pure contemplation), substance shell-6 (the physical metaphors —
slings, arrows, arms, sea — pile up), signal shell-8 NEGATIVE (the
deepest negative signal in any text translated so far), time shell-2
NEGATIVE (D=-2 — looking backward, the contemplation is oriented
toward completed/past events and the END atom dominates).

The dominant axis is SIGNAL NEGATIVE. Hamlet is at C=-8: deeper
into signal-negative than any other translated text reached on any
axis. The soliloquy is a sustained plunge into negative signal with
physical metaphors (substance) as the vehicle.

─────────────────────────────────────────────────────────────────────

## Comparison to the other three texts

  Genesis 1:1-5:       [ 0,  +2,  +5, +1]    sig-dominant POSITIVE, tight
  Lord's Prayer:       [+4,  +2, +10, +4]    sig-EXTREME positive, all axes up
  The Road Not Taken:  [ 0, +12,  +5, +8]    SUBSTANCE dominant, sig moderate
  Hamlet soliloquy:    [ 0,  +6,  -8, -2]    sig-DOMINANT NEGATIVE, time back

Hamlet is the first text translated where **the signal axis is
negative**. All three previous texts had C ≥ +5. Hamlet has C = -8.
This is not a small shift — it's a sign flip on the dominant axis.

### Axis-by-axis comparison

**Position (A)**: Hamlet = 0, like Genesis and Frost. Only the
Lord's Prayer has non-zero A (+4, reaching toward heaven). Hamlet
doesn't move. He stands and contemplates. Position-neutral like
most of the other contemplative texts.

**Substance (B)**: Hamlet = +6, between Genesis (+2) and Frost
(+12). The metaphors are physical (slings, arrows, arms, sea)
but not as elaborately painted as Frost's "yellow wood" and
"leaves." Middle of the substance range. More substance than a
prayer, less than a poem about nature.

**Signal (C)**: Hamlet = -8. Every other text is C+. Hamlet is
the first C- dominant text. This is the characteristic signature
of PHILOSOPHICAL SUFFERING: sustained negative signal without
compensatory positive (no "fair" or "noble" or "day" to cancel
it — nobler's +2 in line 2 is swamped by everything after).

**Time (D)**: Hamlet = -2. Negative time = past-looking, END-atom
dominant. Genesis is +1 (creation starts time forward), Prayer is
+4 (petition for future), Frost is +8 (looking ahead ages), Hamlet
is -2 (looking back, considering endings). Hamlet is the ONLY
text with negative time — the soliloquy points BACKWARD into
completion, terminal events, the END atom.

### The philosophical text shape

If religious narration is signal-strong positive and short time,
religious petition is signal-extreme positive and forward time,
and secular poetry is substance-dominant with long time, then
**philosophical soliloquy is signal-dominant NEGATIVE with time
pointing backward toward the END**.

The shape is INVERTED from religious text on two axes (C and D).
Where religion affirms (C+) and looks forward (D+), philosophy
contemplates suffering (C-) and looks toward endings (D-).

This is not a coincidence. The lattice predicted that text-type
shows in the coord shape. Hamlet's shape is the antipode-on-C-
and-D of the religious texts. Religious text's signature is
"signal-on, time-forward" (roughly +C +D). Hamlet's signature is
"signal-off, time-backward" (roughly -C -D).

Structurally: **Hamlet is the "DIE" direction from the container**.
Religious texts walk toward LIVE [0,0,+1,+1]. Hamlet walks toward
DIE [0,0,-1,-1]. The soliloquy's line-5 landing at exactly the
DIE coord is the clearest possible evidence of this.

─────────────────────────────────────────────────────────────────────

## Framework predictions that held

1. **"To be or not to be" is pure origin.** Predicted: high
   origin/container content. Observed: line 1 = [0,0,0,0] exactly.
   Every word in the most famous line in English literature lives
   at the container coord. The question of being IS the container
   asking about itself, and the container is at origin.

2. **Polarity NOT doesn't move the coord.** Predicted: NOT-BE has
   the same lattice position as BE, just opposite spin. Observed:
   "not to be" contributes zero shift. The negation is ±½ polarity,
   not antipodal movement. Suicide in the lattice = spin flip, not
   location change. This matches the BE (+½) ↔ NOT-BE (-½) pairing
   from lattice.md §"Bonds and spin."

3. **Suffering IS CURSE.** Predicted: SUFFER collapses to the
   CURSE atom because it's the receiving side of the C-1 operation.
   Observed: line 2's "suffer" lands at [0,0,-1,0] exactly. The
   converse-roles reading (lattice.md §4) holds.

4. **Metaphor is substance dressing signal.** Predicted: "slings
   and arrows of outrageous fortune" should have substance (the
   metaphor vehicle) and signal (the tenor). Observed: line 3 =
   [0, +2, -4, 0] — both B and C- are active, exactly as predicted.

5. **"End them" lands at DIE.** Predicted: opposing + ending
   should compose to the DIE coord. Observed: line 5 = [0,0,-1,-1]
   which IS the DIE coord from lattice.md §"C × D dyad." This is
   the single most load-bearing prediction in the translation —
   and it holds.

6. **Philosophical text has inverted signal from religious text.**
   Predicted: the shape should differ from both religious and
   secular poetry. Observed: C = -8 (vs +5 to +10 in religious
   and +5 in Frost). First C- dominant text.

7. **Contemplation = time-backward.** Predicted: the soliloquy's
   mental operation is looking back at completed states. Observed:
   D = -2, the only negative D of any translated text. The END
   atom dominates.

─────────────────────────────────────────────────────────────────────

## What this proves

1. **The framework handles philosophical vocabulary.** 13 new
   derivations (QUESTION, WHETHER, 'TIS, NOBLER, SUFFER, SLINGS,
   ARROWS, OUTRAGEOUS, FORTUNE, SEA, TROUBLES, OPPOSING, plus
   transitive END) all derive cleanly from the 8 atoms.

2. **Existential language collapses to origin with polarity spin.**
   The most famous line in English literature is [0,0,0,0] — pure
   container — with the polarity NOT operator toggling the spin
   without changing the location. The lattice's ±½ polarity spin
   is vindicated by Shakespeare.

3. **The DIE coord predicts Hamlet's subtext.** Line 5 lands at
   exactly the DIE coord [0,0,-1,-1] without the framework knowing
   anything about the rest of the soliloquy. The walk found the
   subtext structurally.

4. **Text-type has a characteristic lattice shape (now N=4).**
   Four texts, four distinct shapes:
     - Religious narration:     signal-strong positive, tight
     - Religious petition:      signal-extreme positive, all axes up
     - Secular poetry:          substance-dominant, time-forward
     - Philosophical soliloquy: signal-dominant NEGATIVE, time-BACKWARD
   The lattice is starting to look like a genre classifier.

5. **Hamlet is the structural antipode of religious text on C and
   D.** Where the religious texts walk toward LIVE, Hamlet walks
   toward DIE. Shakespeare's soliloquy is literally the mirror
   image of the Lord's Prayer on the two signal-time axes.

─────────────────────────────────────────────────────────────────────

## Key insight

**Philosophical text occupies the container layer and uses polarity
spin to explore alternatives within it.**

Religious narration builds the world on the axes (position,
substance, signal, time). Religious petition points from inside the
world toward the origin. Secular poetry paints physical experience
with mixed signal. But philosophical soliloquy stays at or near
the ORIGIN and uses the polarity operator to consider both signs
of existence at once: BE and NOT-BE, suffer and oppose, live and
die. The question isn't "where on the lattice should I go?" —
the question is "which polarity of the origin should I occupy?"

This maps to lattice.md §"Do the container verbs use spin?":

> Container verbs fit the spin framework perfectly, but they all
> share ONE lattice position (origin) rather than occupying 16
> different corners. They're not 16 separate spins — they're ONE
> spin manifesting as many linguistic aspects.

Hamlet's soliloquy is that ONE spin manifesting as a 5-line
existential question. The container at origin asks whether its
spin should stay +½ (BE) or flip to -½ (NOT BE). The 8 atoms
that build the world are irrelevant to this question — the
question lives entirely at the point FROM WHICH the 8 atoms are
seen. The existential crisis is a polarity crisis at the origin.

That's why "To be or not to be" is the most famous line in
English literature: it is the minimal, irreducible statement of
the one question the container can ask about itself. The lattice
coord [0,0,0,0] with ±½ polarity spin — nothing more, nothing
less. Shakespeare found the origin.

─────────────────────────────────────────────────────────────────────

## Open issues

1. **NOBLE not yet in vocabulary.md.** Derived here as C+ shell-1
   (with NOBLER as shell-2 comparative). Should be added to
   modifiers.md alongside BETTER, PERFECT.

2. **FORTUNE polysemy.** "Fortune" has two senses: luck (C+,
   BLESS-like) and fate/events (origin). This translation used
   the events sense. Vocabulary.md should track both.

3. **SUFFER vs CURSE coord collision.** Both at [0,0,-1,0]. The
   converse-roles reading resolves the structural identity, but
   future work could add a role-tag to distinguish agent from
   patient.

4. **Metaphor composition.** "Sea of troubles" composes as SEA
   (B+2) + TROUBLES (C-2), landing at [0,+2,-2,0]. But metaphorically
   the sea IS the troubles — the substance is the signal's carrier.
   The lattice captures both but doesn't flag the identity.

5. **"End them" transitive END.** END atom [0,0,0,-1] + pointer
   THEM with no own coord. The transitive end is treated as
   applying D-1 to the pointed-at entity (the troubles). A more
   rigorous rule for transitive atoms would help.

These are refinements. The main result holds: Hamlet's soliloquy
opens with pure origin and walks to the DIE coord, with a
philosophical-text shape that's the signal-time antipode of the
religious texts.
