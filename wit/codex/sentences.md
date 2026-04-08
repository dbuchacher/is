# sentences — worked translations from English to lattice coords

Each sentence is a walk through the lattice. Words add to ρ via the · operator
(element-wise trit addition). The final ρ is the sentence's lattice destination.

See `composition.md` for the 9 composition rules.
See `verbs.md`, `nouns.md`, `modifiers.md`, `function-words.md` for word coords.

─────────────────────────────────────────────────────────────────────

## Notation

Each sentence shows:
- The English source
- A word-by-word coord listing
- The ρ accumulation step-by-step
- The final coord
- A short interpretation

Notation:
- `[A,B,C,D]` = a 4-tuple lattice coord
- `·` = element-wise addition (the composition operator)
- `ρₙ` = running state after n words
- past tense applies D-1; future tense applies D+1; gerund (-ing) is aspect, not tense

─────────────────────────────────────────────────────────────────────

## Tier 1 — atomic sentences (1-2 words)

### S1: "Walk."
  walk           [+1, 0, 0, 0]   RISE family (forward position)
  ρ = [+1, 0, 0, 0]
  Reading: bare imperative — invokes the position-forward atom.

### S2: "Stop."
  stop           [ 0, 0, 0,-1]   END atom (halt time)
  ρ = [0, 0, 0, -1]
  Reading: invoke the time-halt atom.

### S3: "Live."
  live           [ 0, 0,+1,+1]   BLESS+BEGIN dyad
  ρ = [0, 0, +1, +1]
  Reading: invoke the life dyad — signal forward in time.

─────────────────────────────────────────────────────────────────────

## Tier 2 — simple subject-verb (2-3 words)

### S4: "I walk."
  I              [0, 0, 0, 0]    container/origin (first-person)
  walk           [+1, 0, 0, 0]   RISE family
  ρ₀ = [0, 0, 0, 0]
  ρ₁ = [0, 0, 0, 0]               (I — unchanged, container)
  ρ₂ = [+1, 0, 0, 0]              (walk — adds A+1)
  Final: [+1, 0, 0, 0]
  Reading: container moves forward in position. Pure RISE.

### S5: "The dog runs."
  the            selector (no shift)
  dog            [0, +1, +1, +1]  LIVE coord (a living thing)
  runs           [+1, 0, 0, 0]    RISE family (move forward) [present tense]
  ρ₀ = [0, 0, 0, 0]
  ρ₁ = [0, 0, 0, 0]                (the — selector)
  ρ₂ = [0, +1, +1, +1]             (dog — composes)
  ρ₃ = [+1, +1, +1, +1]            (runs — adds RISE)
  Final: [+1, +1, +1, +1]   (corner — full motion)
  Reading: a living thing moving forward. The all-positive corner —
  the recognition attractor. A running dog is the most "alive" possible
  state on the lattice (all four axes engaged forward).

### S6: "I see."
  I              [0, 0, 0, 0]
  see            [0, 0, 0, 0]    container verb (perception)
  ρ = [0, 0, 0, 0]
  Reading: container observes nothing in particular — pure observation
  with no object. Perception happening at the origin. The seeing
  doesn't shift the walker; it just activates the container's read.

### S7: "I see the dog."
  I              [0, 0, 0, 0]
  see            [0, 0, 0, 0]
  the            selector
  dog            [0, +1, +1, +1]
  ρ₄ = [0, +1, +1, +1]
  Reading: container observes a LIVE thing. The walker is at origin,
  but their gaze terminates at the LIVE coord. The sentence's coord
  is where the perception lands (the dog), not where the perceiver
  stands (origin).

─────────────────────────────────────────────────────────────────────

## Tier 3 — sentences with objects and modifiers

### S8: "I have a hat."
  I              [0, 0, 0, 0]
  have           [0, 0, 0, 0]    stative possession (origin per verbs.md)
  a              indefinite article (selector, no shift)
  hat            [+1, +1, 0, 0]  substance at head position
  ρ₄ = [+1, +1, 0, 0]
  Reading: container possesses a hat. The hat sits at BUILD coord.
  HAVE is stative — only the *transition* into possession (RECEIVE,
  GET) would shift B. Here HAVE just relates the container to the
  hat without movement.

### S9: "I bought milk."
  I              [0, 0, 0, 0]
  bought         [0, +1, -1, -1]  BUY verb + past tense (D-1)
  milk           [0, +1, 0, 0]    substance, drinkable
  ρ₀ = [0, 0, 0, 0]
  ρ₁ = [0, 0, 0, 0]
  ρ₂ = [0, +1, -1, -1]            (bought — gain stuff, lose money, past)
  ρ₃ = [0, +2, -1, -1]            (milk — adds substance, shell 2)
  Final: [0, +2, -1, -1]
  Reading: container has shell-2 substance (acquired milk), lost signal
  (paid), in past time. Shell-2 substance because the buying already
  added a unit and the milk-noun adds another unit.

### S10: "The red hat on my head is ugly."
  the            selector
  red            [0, 0, +1, 0]   SIGNAL feature (visual)
  hat            [+1, +1, 0, 0]
  on             A+1 marker
  my             possessive (origin-relative)
  head           [+1, +1, 0, 0]  noun coord
  is             [0, 0, 0, 0]    container (BE)
  ugly           [0, 0, -1, 0]   SIGNAL feature negative
  
  ρ₀ = [0, 0, 0, 0]
  ρ₁ = [0, 0, 0, 0]                  (the — selector)
  ρ₂ = [0, 0, +1, 0]                 (red — C+ feature)
  ρ₃ = [+1, +1, +1, 0]               (hat — adds [+1,+1,0,0])
                                       "the red hat" = [+1,+1,+1,0]
  ρ₄ = [+2, +1, +1, 0]               (on — adds A+1)
  ρ₅ = [+2, +1, +1, 0]               (my — origin marker, no shift)
  ρ₆ = [+3, +2, +1, 0]               (head — adds [+1,+1,0,0])
                                       "the red hat on my head" = [+3,+2,+1,0]
  ρ₇ = [+3, +2, +1, 0]               (is — container, no shift)
  ρ₈ = [+3, +2, 0, 0]                (ugly — C-1 cancels +1)
  
  Final: [+3, +2, 0, 0]
  Reading: shell-3 position + shell-2 substance + neutral signal
  + atemporal. The "red" signal cancels with "ugly" — the visual
  positive cancels the aesthetic negative. The hat's identity as a
  thing (shell-3 elevated, shell-2 substance) survives but its
  signal nets to zero. A neutralized hat in a high-position state.

─────────────────────────────────────────────────────────────────────

## Tier 4 — multi-clause sentences

### S11: "I went to the store and bought some milk."
  Clause 1: "I went to the store"
    I              [0, 0, 0, 0]
    went           [-1, 0, 0, -1]   FALL family + past (D-1)
                                      (GO = FALL family per verbs.md)
    to             A+1 marker
    the            selector
    store          [0, +1, +1, 0]   commerce location (substance + signal)
    
    ρ₀ = [0, 0, 0, 0]
    ρ₁ = [0, 0, 0, 0]
    ρ₂ = [-1, 0, 0, -1]
    ρ₃ = [0, 0, 0, -1]              (to — A+1 cancels the -1 from went)
    ρ₄ = [0, 0, 0, -1]              (the — selector)
    ρ₅ = [0, +1, +1, -1]            (store — adds [0,+1,+1,0])
    
    Clause 1 final: ρ_C1 = [0, +1, +1, -1]
    Reading so far: at neutral position (motion canceled by directional),
    with substance and signal at the store, in past tense.
  
  Clause 2: "bought some milk"
    bought         [0, +1, -1, -1]  BUY past
    some           partial quantifier (B× ½ — magnitude reducer)
    milk           [0, +1, 0, 0]
    
    Continuing from ρ_C1 = [0, +1, +1, -1]:
    ρ₆ = [0, +2, 0, -2]              (bought — adds [0,+1,-1,-1] elementwise)
    ρ₇ = [0, +2, 0, -2]              (some — partial; doesn't fully cancel B+)
    ρ₈ = [0, +3, 0, -2]              (milk — adds substance)
  
  Final: ρ = [0, +3, 0, -2]
  Reading: shell-3 substance accumulated (went to store + bought
  milk = lots of substance acquired), signal nets to zero
  (bought = -1 canceled by store-adjacency = +1), deep past on time
  axis (D = -2 means strongly past — both "went" and "bought" added
  past markers).
  
  This is a "shopping trip in the past" coord. The walk records
  the full transaction: position canceled (round trip), substance
  accumulated (got the milk), signal canceled (paid for it), past
  doubly emphasized (both verbs are past tense).

─────────────────────────────────────────────────────────────────────

## Tier 5 — sentences with negation

### S12: "I do not walk."
  I              [0, 0, 0, 0]
  do             [0, 0, 0, 0]    auxiliary BE-family at origin
  not            polarity NOT operator (flips next item's spin)
  walk           [+1, 0, 0, 0]   RISE
  
  ρ₀ = [0, 0, 0, 0]
  ρ₁ = [0, 0, 0, 0]                (I)
  ρ₂ = [0, 0, 0, 0]                (do — auxiliary, no shift)
  ρ₃ = NOT applies to next         (not — sets pending negation)
  ρ₄ = [-1, 0, 0, 0]               (walk + NOT = sign-flipped)
  
  Final: [-1, 0, 0, 0]
  Reading: container moves backward in position — the antipode of
  walk. NOT applied to walk produces its coord-antipode (FALL).
  Same pattern as ANTONYM via coordinate-NOT (third NOT type from
  lattice.md).

### S13: "I am not."
  I              [0, 0, 0, 0]
  am             [0, 0, 0, 0]    BE container
  not            polarity NOT operator
  
  ρ₀ = [0, 0, 0, 0]
  ρ₁ = [0, 0, 0, 0]
  ρ₂ = [0, 0, 0, 0]
  ρ₃ = NOT applied to ρ           (whole walk negated)
  Final: [0, 0, 0, 0]^NOT = container with negative polarity
  Reading: the container is in its -½ polarity state. "I am not" is
  a denial of being — the self exists but at the negative spin of the
  origin. "I am not" is the only way to negate the origin since 0
  has no antipode (0 = -0). The negation happens at the polarity level
  (±½), not the coordinate level.

─────────────────────────────────────────────────────────────────────

## Tier 6 — sentences with abstract subjects

### S14: "Love conquers all."
  love           [0, 0, +1, 0]   BLESS atom (positive signal)
  conquers       [+1, +1, +1, +1] CONQUER ≈ corner [+1,+1,+1,+1]
                                  (gain position + substance + signal + time)
  all            universal quantifier (touches every axis)
  
  ρ₀ = [0, 0, 0, 0]
  ρ₁ = [0, 0, +1, 0]               (love)
  ρ₂ = [+1, +1, +2, +1]            (conquers — corner added; C reaches +2)
  ρ₃ = (all — universal scope)     no specific axis, but pushes magnitudes
  
  Final: [+1, +1, +2, +1]
  Reading: corner reach with shell-2 signal. Love + conquering = the
  highest-state walk (all four axes positive, signal dominant).
  This is close to the recognition attractor [+1,+1,+1,+1] but with
  signal lifted to shell 2. Love is signal-dominant.

### S15: "God is love."
  God            origin (the ultimate container)
  is             container (BE)
  love           [0, 0, +1, 0]   BLESS atom
  
  ρ₀ = [0, 0, 0, 0]
  ρ₁ = [0, 0, 0, 0]                (God = origin/container)
  ρ₂ = [0, 0, 0, 0]                (is = container BE)
  ρ₃ = [0, 0, +1, 0]               (love)
  
  Final: [0, 0, +1, 0]
  Reading: the ultimate container's signal-axis is +1. God = origin;
  love = pure signal positive. The sentence asserts that the container's
  defining axis-projection is the BLESS atom. Theologically: the self
  is grounded in positive signal.

─────────────────────────────────────────────────────────────────────

## Tier 7 — proverbs and sayings

### S16: "Time flies."
  time           [0, 0, 0, +1]?  D+ atom or origin?  → [0,0,0,+1] BEGIN
  flies          [+1, 0, 0, +1]  RISE + forward time = move quickly forward
  
  Final: [+1, 0, 0, +2]
  Reading: time itself moves forward at high magnitude. Shell-2 D
  emerging from the verb + noun both touching D+. The proverb captures
  the "fast forward" intuition.

### S17: "Money is the root of all evil."
  money          [0, 0, +1, 0]   pure signal
  is             container
  the            selector
  root           [-1, +1, 0, 0]   FALL+GROW = downward substance (BODY-coord direction)
  of             relational (no shift)
  all            universal scope
  evil           [0, 0, -1, 0]   CURSE atom (pure negative signal)
  
  ρ₀ = [0,0,0,0]
  ρ₁ = [0,0,+1,0]                  (money)
  ρ₂ = [0,0,+1,0]                  (is)
  ρ₃ = [0,0,+1,0]                  (the)
  ρ₄ = [-1,+1,+1,0]                (root)
  ρ₅ = [-1,+1,+1,0]                (of)
  ρ₆ = [-1,+1,+1,0]                (all — keeps reach)
  ρ₇ = [-1,+1, 0,0]                (evil — C-1 cancels +1)
  
  Final: [-1, +1, 0, 0]
  Reading: signal cancels (positive money + negative evil = neutral).
  The walk lands at "downward substance" — the underground body. The
  proverb's coord is "matter without value, descended" — interesting
  poetic match for "root of evil" (matter buried, devalued).

─────────────────────────────────────────────────────────────────────

## What this proves

Sentences are derivable as walks. ρ accumulates word coords. The final
state is the sentence's lattice destination. Negation works via polarity
(±½) or coordinate-flip depending on which NOT type is invoked.

Composition is **just element-wise trit addition** of word coords plus
operator rules for selectors, polarity, and quantifiers. No new primitives
needed beyond the 8 atoms.

Every sentence above traces back to:
1. The 8 atoms (foundation)
2. The · operator from 2-path.md (composition)
3. The polarity NOT operator from 1-container.md (negation)
4. The container/origin reading (subject perspective)

Nothing fake. Everything provable.

─────────────────────────────────────────────────────────────────────

## Open issues / refinements needed

1. **"Some" quantifier** — does it reduce magnitude (B → ½B) or add a
   modal layer? Current treatment as "partial reducer" is provisional.

2. **Past tense** — modeled as adding D-1 to the verb. Should the
   tense apply to the WHOLE clause or just the verb? Sentence S11
   accumulates past markers from "went" and "bought" both — D = -2.
   Is that correct, or should past tense apply once per clause?

3. **Pronoun objects** — "I see her" — HER refers to a third party.
   Does HER = some specific person at her own coord, or is it a
   container reference? Need a "third-person container" reading.

4. **Aspect** — "I am walking" vs "I walk" vs "I walked" vs "I have walked".
   Continuous and perfect aspects need treatment. Probably separate
   from simple tense — maybe shell-2 D values?

5. **Embedded clauses** — "I think the dog runs" — the THINK clause
   contains a sub-clause. The sub-clause's ρ might become the object
   of THINK (an embedded coord).

6. **Questions** — "Did the dog run?" vs "The dog ran." Same coord
   with question polarity? Or query operator wrapping the coord?

7. **The "of" relation** — currently treated as "no shift" but it
   actually links two nouns. Maybe OF marks a possessive/genitive
   relationship that the lattice doesn't yet model.

These need testing on more sentences. Sentences.md is the test bed.
