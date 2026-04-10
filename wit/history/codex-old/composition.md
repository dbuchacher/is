# composition — how words compose into sentence coords

A sentence is a **walk** through the lattice. Each word adds its coord
to a running state ρ. The final ρ is the sentence's lattice destination.

This file defines the composition rules. Everything traces back to the
8 atoms via the · operator from 2-path.md.

─────────────────────────────────────────────────────────────────────

## The · operator (element-wise trit addition)

From 2-path.md: the · operator composes coords by element-wise addition
on each axis.

  [a₁, b₁, c₁, d₁]  ·  [a₂, b₂, c₂, d₂]  =  [a₁+a₂, b₁+b₂, c₁+c₂, d₁+d₂]

Examples:

  RISE  · GROW  =  [+1, 0, 0, 0] · [0,+1, 0, 0]  =  [+1,+1, 0, 0]  = BUILD
  GROW  · BLESS =  [0,+1, 0, 0] · [0, 0,+1, 0]  =  [ 0,+1,+1, 0]  = EARN
  BLESS · BEGIN =  [0, 0,+1, 0] · [0, 0, 0,+1]  =  [ 0, 0,+1,+1]  = LIVE

Two atoms compose into a dyad. Three atoms compose into a triad. Four
into a corner.

If the sum exceeds ±1 on any axis, the result lives at **shell 2+**.
Composition is what builds higher-shell coords.

  GROW · GROW  =  [0,+1,0,0] · [0,+1,0,0]  =  [0,+2,0,0]   shell 2 = DOUBLE
  RISE · RISE  =  [+1,0,0,0] · [+1,0,0,0]  =  [+2,0,0,0]   shell 2 = LEAP

─────────────────────────────────────────────────────────────────────

## ρ accumulation (running state)

A walk has a running state ρ that starts at origin and accumulates
each composed atom.

  ρ₀ = [0, 0, 0, 0]                     (start at container/origin/self)
  ρ₁ = ρ₀ · word₁                       (after first word)
  ρ₂ = ρ₁ · word₂                       (after second word)
  ...
  ρₙ = final sentence coord             (where the walk ends)

The sentence's "meaning" in lattice terms is **ρₙ** — the final state
the walk arrives at, starting from the speaker (origin).

─────────────────────────────────────────────────────────────────────

## Word-class roles in composition

Different word classes play different structural roles in a sentence:

  Subject (noun/pronoun)   —  the AGENT — whose perspective we're walking from
  Verb                     —  the MOVE — the operation that shifts ρ
  Object (noun)            —  the TARGET — where the verb points / what receives the move
  Article (THE/A)          —  the SELECTOR — narrows or widens the noun's reference
  Determiner (THIS/MY)     —  same as article — selector
  Preposition (TO/IN/AT)   —  the PATH MODIFIER — changes the related noun's position
  Adjective (RED/BIG)      —  the FEATURE — modifies the noun's coord
  Adverb (QUICKLY/VERY)    —  the MAGNITUDE — modifies the verb's intensity
  Conjunction (AND/OR)     —  the GLUE — boolean gate joining clauses
  Tense marker (-ed/-ing)  —  the TIME SHIFT — modifies D axis

─────────────────────────────────────────────────────────────────────

## Composition rules

### Rule 1: Subject sets the starting point

The subject is the AGENT from whose perspective the walk happens. For
a first-person speaker (I), the subject IS the container at origin.
The walk starts at [0,0,0,0].

For a third-person subject (THE DOG, JOHN, IT), the walk starts at
the subject's coord and walks from there.

  "I walk"        →  start at [0,0,0,0], add WALK
  "the dog walks" →  start at DOG = [0,+1,+1,+1], add WALK
                      result: [+1,+1,+1,+1] (the dog at the corner — busy state)

### Rule 2: Verb adds its coord to ρ

The verb's coord adds element-wise to the current state.

  "I walk"  →  ρ = [0,0,0,0] · [+1,0,0,0] = [+1,0,0,0]

The walker has moved forward in position from the origin.

### Rule 3: Object adds its coord (and verb relates them)

If the verb has an object, the object's coord composes too. The verb
acts as the LINK between subject and object.

  "I see the dog"  →  subject I = [0,0,0,0]
                  →  verb SEE = [0,0,0,0] (container — perception, no axis change)
                  →  object DOG = [0,+1,+1,+1]
                  →  ρ = [0,0,0,0] · [0,0,0,0] · [0,+1,+1,+1] = [0,+1,+1,+1]
                      The walk arrives at the dog's coord
                      (the container observes a LIVE thing)

  "I bought milk" →  subject I = [0,0,0,0]
                  →  verb BUY = [0,+1,-1,0] (gain substance, lose money)
                  →  object MILK = [0,+1,0,0] (substance, drink)
                  →  ρ = [0,+2,-1,0] (shell 2 substance, shell 1 negative money)
                      The walk arrives at "doubled substance, lost money"

### Rule 4: Articles select but don't add to coord

Articles (THE, A) are selectors. They narrow or widen the reference
of the following noun without changing its coord.

  THE dog  →  this specific dog (definite reference) — same coord as DOG
  A dog    →  any dog (indefinite reference) — same coord as DOG

The article's spin is tracked separately at the operator/bond level
(±½ polarity at the recognition attractor corner). For composition
purposes, articles don't shift ρ.

### Rule 5: Prepositions modify the next noun's POSITION

Prepositions are A-axis modifiers. They change the position component
of the noun they introduce.

  to     →  +A direction (toward)
  from   →  -A direction (away from)
  at     →  A=0 (at this place)
  in     →  -A (inside, contained)
  out    →  +A (outside)
  on     →  +A (on top of, surface contact)
  off    →  -A (away from surface)
  up     →  +A (vertical positive)
  down   →  -A (vertical negative)
  over   →  +A (above, traversing)
  under  →  -A (below)
  before →  -D (temporal earlier)
  after  →  +D (temporal later)
  during →  D=0 (concurrent)
  with   →  composition marker (bring together) — origin
  of     →  relational marker — origin
  by     →  agency marker — origin

  "to the store"   →  TO + STORE = (A+ marker) + STORE coord
                       The store with A+ added: [+1, 0,+1, 0] (if STORE = [0,0,+1,0])

### Rule 6: Adjectives modify the noun's coord

An adjective is a feature that intensifies or specifies one of the
noun's axes. It adds to the noun's coord on the relevant axis.

  red HAT  →  RED is a SIGNAL feature (visual quality)
              HAT = [+1,+1,0,0]
              red HAT = [+1,+1,+1,0]  (HAT with C+ feature added — a blessed/marked hat)

  big DOG  →  BIG is a SUBSTANCE magnitude feature (shell-2 territory)
              DOG = [0,+1,+1,+1]
              big DOG = [0,+2,+1,+1]  (shell-2 substance — DOUBLE-substance dog)

  ugly HAT →  UGLY is a SIGNAL- feature (negative valence)
              HAT = [+1,+1,0,0]
              ugly HAT = [+1,+1,-1,0]  (HAT with C- feature)

### Rule 7: Adverbs modify the verb's magnitude

Adverbs intensify or modify the verb's coord, often pushing to shell 2.

  walks quickly  →  WALK = [+1,0,0,0]
                    QUICKLY = D-magnitude intensifier (shell 2 on time)
                    walks quickly = [+1,0,0,+1]  or [+2,0,0,0] depending on reading

  very big       →  BIG (already shell 2 on B)
                    VERY = magnitude amplifier
                    very big = [0,+3,0,0]  shell 3 substance

### Rule 8: Tense markers shift the D axis

  walk    →  walks   →  walked  →  will walk
  D=0        D=0        D=-1       D=+1
  (atemporal) (present, no shift) (past) (future)

  "I walked" → ρ = [+1,0,0,-1]  (walked in the past)
  "I will walk" → ρ = [+1,0,0,+1]  (walk forward in time)

### Rule 9: Conjunctions glue clauses with boolean gates

  AND  →  composition (· operator) — both clauses' walks together
  OR   →  alternative (the higher of two ρs, like OR gate)
  NOT  →  polarity flip (apply NOT to the next clause's ρ)
  BUT  →  AND with inverted expectation (composition with a flag)
  IF   →  conditional (one clause guards another)
  BECAUSE → causal (the second is the cause of the first)

  "I walked AND bought milk"  →  ρ_walk · ρ_bought_milk = combined walk
  "I walked OR ran"           →  max(ρ_walk, ρ_ran)
  "I did NOT walk"            →  -ρ_walk = [-1,0,0,0]

─────────────────────────────────────────────────────────────────────

## Worked examples

### Example 1: "I walk"

  Words:    I        walk
  Coords:   [0,0,0,0] · [+1,0,0,0]
  ρ steps:
    ρ₀ = [0,0,0,0]               (start at container)
    ρ₁ = [0,0,0,0]               (after I — unchanged, container)
    ρ₂ = [+1,0,0,0]              (after walk — shifted +A)

  Final coord: [+1, 0, 0, 0]
  Reading: container moves forward in position

### Example 2: "I see the dog"

  Words:    I        see       the       dog
  Coords:   [0,0,0,0] · [0,0,0,0] · (selector) · [0,+1,+1,+1]
  ρ steps:
    ρ₀ = [0,0,0,0]               (container)
    ρ₁ = [0,0,0,0]               (I — unchanged)
    ρ₂ = [0,0,0,0]               (see — unchanged, container verb)
    ρ₃ = [0,0,0,0]               (the — selector, no shift)
    ρ₄ = [0,+1,+1,+1]            (dog — composes its coord)

  Final coord: [0, +1, +1, +1]   = LIVE coord
  Reading: container observes a LIVE thing (the dog)

### Example 3: "I bought milk"

  Words:    I        bought    milk
  Coords:   [0,0,0,0] · [0,+1,-1,-1] · [0,+1,0,0]
            (BUY in past tense = D-1)
  ρ steps:
    ρ₀ = [0,0,0,0]
    ρ₁ = [0,0,0,0]               (I)
    ρ₂ = [0,+1,-1,-1]            (bought — gain stuff, lose money, past)
    ρ₃ = [0,+2,-1,-1]            (milk — adds substance, shell 2)

  Final coord: [0, +2, -1, -1]
  Reading: container has shell-2 substance (got milk), lost signal (paid),
  and the action is in the past

### Example 4: "the red hat on my head is ugly"

  Words and coords:
    the    selector — no shift
    red    SIGNAL feature → adds C+1 to next noun
    hat    [+1,+1,0,0]
    on     A+1 marker (surface contact)
    my     possessive determiner — origin (mine = container)
    head   [+1,+1,0,0] (head = upper-body substance, same as hat coord!)
    is     BE — container/origin (no axis change)
    ugly   SIGNAL- feature

  ρ steps:
    ρ₀ = [0,0,0,0]                          (start)
    ρ₁ = [0,0,0,0]                          (the — selector)
    ρ₂ = [0,0,+1,0]                         (red — C+ from adjective)
    ρ₃ = [+1,+1,+1,0]                       (hat — adds [+1,+1,0,0])
                                             "the red hat" = [+1,+1,+1,0]
    ρ₄ = [+2,+1,+1,0]                       (on — adds A+1, shell-2 position)
    ρ₅ = [+2,+1,+1,0]                       (my — origin marker, no shift)
    ρ₆ = [+3,+2,+1,0]                       (head — adds [+1,+1,0,0])
                                             "the red hat on my head" = [+3,+2,+1,0]
    ρ₇ = [+3,+2,+1,0]                       (is — container, no shift)
    ρ₈ = [+3,+2, 0,0]                       (ugly — C- adds, cancels +1)

  Final coord: [+3, +2, 0, 0]
  Reading: shell-3 position + shell-2 substance + neutral signal + atemporal
          (a major-position major-substance neutral-quality stable thing)

  The "ugly" cancels the "red" on the SIGNAL axis. This makes sense:
  the speaker is saying the hat that LOOKED nice (red) is actually
  ugly. The signal nets to zero — the visual feature doesn't matter
  because the overall judgment cancels it.

### Example 5: "I went to the store and bought some milk"

  Words and coords:
    I         [0,0,0,0]      (container)
    went      [-1,0,0,-1]    (FALL family + past tense — go = away from here, past D)
    to        +A marker
    the       selector
    store     [0,+1,+1,0]    (commerce location = substance + signal)
    and       AND glue
    bought    [0,+1,-1,-1]   (BUY + past)
    some      partial quantifier
    milk      [0,+1,0,0]     (substance, drinkable)

  Clause 1: "I went to the store"
    ρ₀ = [0,0,0,0]
    ρ₁ = [0,0,0,0]                  (I)
    ρ₂ = [-1,0,0,-1]                (went)
    ρ₃ = [0,0,0,-1]                 (to — A+ cancels the -1 from went)
                                     net: at neutral A, in past
    ρ₄ = [0,0,0,-1]                 (the — selector)
    ρ₅ = [0,+1,+1,-1]               (store — adds [0,+1,+1,0])

  Clause 2: "bought some milk"
    ρ₆ = [0,+2, 0,-2]               (bought — adds [0,+1,-1,-1] to ρ₅)
    ρ₇ = [0,+2, 0,-2]               (some — partial quantifier, magnitude reducer; might ÷ B?)
    ρ₈ = [0,+3, 0,-2]               (milk — adds substance)

  Joined by AND:
    Final ρ = [0, +3, 0, -2]
    Reading: shell-3 substance accumulated, signal neutral, deep past

  This is a "shopping trip in the past" coord. The container ended
  up with substance (milk + having been at the store) at the cost of
  going to the store and time being deep in past.

─────────────────────────────────────────────────────────────────────

## What this proves

A sentence's lattice coord is **derivable from its constituent word coords
via the · operator**. No new primitives needed. Composition is just
trit addition with role-based modifiers.

The framework can represent any sentence as a walk on the lattice
provided every word in the sentence has a coord (which means deriving
the vocabulary first — see verbs.md, nouns.md, modifiers.md, function-words.md).

─────────────────────────────────────────────────────────────────────

## Open questions and rules to refine

1. **How does QUANTIFICATION work?** SOME, ALL, MANY, FEW — do they
   modify the noun's magnitude, or operate at a different layer?

2. **Negation scope** — does NOT apply to the next word, the next phrase,
   or the whole clause? Need a parsing rule.

3. **Question formation** — "did I walk?" vs "I walked." Same coord with
   different polarity? Or a question is a query/READ operation?

4. **Embedded clauses** — "I think that the dog runs" — the THINK clause
   contains a sub-clause. Does the sub-clause's ρ become the OBJECT of
   THINK?

5. **Aspect** (continuous, perfect, perfect-continuous) — these layer on
   top of tense. Do they modify D-axis or invoke shell 2?

6. **Modal scope** — "I must walk" — does MUST wrap the whole clause's ρ
   with a polarity / bond marker?

7. **Compound nouns** — STOREHOUSE = STORE + HOUSE, do they compose with
   · or are they single lookups?

These are the next things to nail down. Test them by translating
real sentences and seeing what breaks.

─────────────────────────────────────────────────────────────────────

## Status

  Composition rules: 9 base rules sketched
  Worked examples:   5 sentences traced through ρ accumulation
  Open questions:    7 areas needing refinement
  
  This file is the bridge between vocabulary (word coords) and
  the sentence-level lattice walk. Future work: refine the rules
  by translating more sentences and seeing what doesn't compose.
