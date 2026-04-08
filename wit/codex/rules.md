# rules — patterns discovered through derivation

This file consolidates all the structural rules and patterns that emerged
from the vocabulary derivation work. They were not written into the framework
in advance — they were discovered by doing the derivations and watching what
patterns emerged.

Each rule traces back to the 8 atoms and the · operator. Nothing here is
imposed; it all comes from doing the work.

─────────────────────────────────────────────────────────────────────

## Layer rules (which words go to which layer)

### R1: The container layer is the largest single coord
~75 word entries collapse to origin [0,0,0,0]. They include:
- Cognition verbs (THINK, KNOW, UNDERSTAND, BELIEVE, LEARN, STUDY)
- Perception verbs (SEE, LOOK, WATCH, HEAR, LISTEN, FEEL, SENSE)
- Speech-act verbs (SAY, SPEAK, TELL, ASK, REPLY, CALL, ANNOUNCE)
- Stative existence verbs (BE, EXIST, SEEM, BECOME, REMAIN)
- Stative possession verbs (HAVE, OWN, HOLD, KEEP)
- Internal state verbs (WANT, NEED, WISH, HOPE, DREAM, SLEEP, REST)
- Cognitive evaluation verbs (JUDGE, RATE, COMPARE, CHECK, TEST, DECIDE)
- Abstract nouns (IDEA, MIND, LOVE, JUSTICE, TRUTH, BEAUTY, FREEDOM)
- First-person pronouns (I, ME, MY, WE, US, OUR)
- Proximal adverbs (HERE, NOW, TODAY, THIS-here)
- Self-related adjectives (PERSONAL, PRIVATE, OWN, HUMAN, MENTAL)

These are NOT failures of derivation — they're operations of the
container/self/observer. The container is one coord but holds many
words, all describing different experiential flavors of being-at-rest.

### R2: Verbs and nouns share coords (noun-verb collision)
The most-confirmed pattern. Each lattice coord holds:
- A verb (the operation)
- A noun (the static residue at that coord)
- An adjective (the feature)
- An adverb (the modifier)

Examples verified:
- BUILD (verb) and HAT (noun) both = [+1,+1,0,0]
- LIVE (verb) and LIFE / DOG / FIRE (nouns) both = [0,0,+1,+1] or [0,+1,+1,+1]
- BLESS (verb) and MONEY / VALUE / GOLD (nouns) both = [0,0,+1,0]
- DEMOLISH (verb) and HOLE / PIT / GRAVE (nouns) both = [-1,-1,0,0]
- BUY (verb) and PURCHASE / GROCERIES (nouns) both = [0,+1,-1,0]
- CREATE (verb) and CREATION / WRITING / LOG (nouns) both = [0,+1,0,+1]
- GIVE (verb) and GIFT / DONATION (nouns) both = [0,-1,+1,+1]
- BEGIN (verb) and BEGINNING / DAWN / BIRTH (nouns) both = [0,0,0,+1]
- END (verb) and END / EVENING / DEATH-event (nouns) both = [0,0,0,-1]

The lattice is part-of-speech polymorphic: each coord is multi-modal.

### R3: Modals/aux live at corners with ±½ polarity
The 16 corners of shell 1 each hold one modal/auxiliary operator:
BE, HAVE, DO, CAN, MAY, MUST, SHALL, WILL, COULD, MIGHT, WOULD,
SHOULD, OUGHT, NEED, DARE, plus articles THE/A.

Each corner has TWO spin states: +½ (affirmative) and -½ (negative).
The contraction `n't` IS the polarity NOT operator. CAN/CAN'T is the
same corner with opposite spin.

  16 corners × 2 polarities = 32 bonds total

### R4: Modals collapse to origin under content derivation
When you try to derive a modal (CAN, WILL, MUST) using the
4-question rule, they all collapse to [0,0,0,0]. This isn't a
failure — it's evidence that they belong to the bond layer, not
the content layer. They're operators that wrap content verbs;
they don't ARE content verbs themselves.

### R5: Boolean conjunctions are trit-gate primitives
AND, OR, NOT live at the trit-gate layer (1-container.md), not at
coordinates. They're the Post primes that the framework's
3-gate-completeness theorem covers. English lexicalizes them
exactly:
  AND  =  boolean AND
  OR   =  boolean OR
  NOT  =  boolean NOT (also `n't` contraction at the bond layer)

─────────────────────────────────────────────────────────────────────

## Word-class rules

### R6: Speech-act verbs always collapse to origin
SAY, TELL, ASK, REPLY, ANNOUNCE, EXPLAIN, MENTION, NOTE, COMMENT,
DESCRIBE, SUGGEST, DISCUSS, TALK, SPEAK, CALL — all at origin.
Speech is a container operation. Signal originates inside the
container and is uttered without changing world axes (until a
listener's container catches it at THEIR origin).

### R7: Perception verbs always collapse to origin
SEE, LOOK, WATCH, OBSERVE, NOTICE, HEAR, LISTEN, FEEL, SENSE,
SMELL, TASTE — all at origin. Perception is intake into the
container, no world-state change.

### R8: Stative possession is origin, transition is +B
HAVE, OWN, HOLD, KEEP — these don't grow substance, they describe
a container-object relation → origin.
GAIN, RECEIVE, EARN — the *transition* into possession → +B.

### R9: Cognitive evaluation is origin
JUDGE, RATE, COMPARE, CHECK, TEST, REVIEW (cognitive sense),
DECIDE, GUESS, CONSIDER — interior evaluations of intake signal.
They use the container's stored knowledge but emit nothing
externally that moves world axes.

### R10: Quantifier adverbs map to corner reach
ALL, EVERY = universal across all 4 axes (corner [+,+,+,+]).
NONE, NO = its antipode + NOT applied.
SOME, ANY = partial / not-yet-corner.
MANY, MUCH = B+ magnitude (shell 1 or shell 2).
FEW, LITTLE = B- magnitude.

### R11: Comparatives push to shell 2; superlatives to shell 3
GOOD [0,0,+1,0] → BETTER [0,0,+2,0] → BEST [0,0,+3,0]
BIG [0,+1,0,0] → BIGGER [0,+2,0,0] → BIGGEST [0,+3,0,0]
FAST [0,0,0,+1] → FASTER [0,0,0,+2] → FASTEST [0,0,0,+3]
Morphology = shell jump.

### R12: Intensifier adverbs are shell-multiplier operators
VERY, REALLY, TOO, EXTREMELY = shell-2 multipliers. They take a
shell-1 adjective and lift it to shell 2 on the same axis. Not
coordinates themselves; they're operators.

### R13: Color adjectives need a SIGNAL sub-axis
RED, BLUE, GREEN don't sort onto a single ± trit on C. They're
distinct phases of the SIGNAL axis (visual-channel qualia).
Mapped as a C-axis sub-shell. BLACK = C-, WHITE = C+ on the
lightness sub-axis.

### R14: Frequency adverbs are D-axis density operators
ALWAYS, OFTEN, USUALLY, NEVER = density tiles on the D axis.
ALWAYS = full tile (forever D+), NEVER = empty tile (no D
present), OFTEN = positive density.

### R15: Manner adverbs inherit their root adjective's coord
WELL ≈ GOOD, BADLY ≈ BAD, QUICKLY ≈ FAST, SLOWLY ≈ SLOW.
The -LY suffix is grammatical, not lattice-transformative.

### R16: Proximals collapse to origin (deictic to container)
HERE, NOW, TODAY, THIS-here, THIS-now — all proximal references.
They reference the container's own position/time. Not at a coord;
they ARE the origin from which coords are seen.

### R17: Distals are origin-relative displacement markers
THERE, THEN, THOSE, AWAY, THAT — point AWAY from origin. Not
specific coords; they're "origin-relative displacement" markers
that take their direction from context.

─────────────────────────────────────────────────────────────────────

## Composition rules

### R18: Sentences are walks; ρ accumulates
Each word adds its coord to a running state ρ via the · operator
(element-wise trit addition). Final ρ = sentence coord.
  ρ₀ = [0,0,0,0]                  (start at speaker = container)
  ρₙ = ρₙ₋₁ · wordₙ                (composition)
  final ρ = sentence's lattice destination

### R19: Antipodal cancellation = full axis coverage
When two words compose to net zero on some axis, that axis was
fully covered (both ends instantiated and they cancel).
Examples:
  heaven + earth → A+ + A- → A=0 (vertical axis fully covered)
  light + darkness → C+ + C- → C=0 (binary established)
  evening + morning → D- + D+ → D=0 (one full oscillation)
  red + ugly → C+ + C- → C=0 (visual feature canceled by aesthetic judgment)

Cancellation isn't a bug; it's the framework expressing "both
ends present" which on a single axis means the axis is fully
spanned.

### R20: Selectors don't shift ρ
Articles (THE, A) and determiners (THIS, THAT, MY, YOUR) are
selectors. They narrow or widen the reference of the next noun
without changing its coord. The article's spin is tracked
separately at the bond/operator layer (±½ polarity).

### R21: Prepositions modify the next noun's POSITION
Spatial prepositions (IN, OUT, UP, DOWN, ON, OFF, TO, FROM, AT)
add to the A axis of the noun they introduce.
Temporal prepositions (BEFORE, AFTER, DURING) add to the D axis.
Relational prepositions (OF, WITH, BY) are origin-rooted (no shift).

### R22: Adjectives modify the noun's coord on the relevant axis
RED hat = red SIGNAL feature added to HAT → [+1,+1,+1,0]
BIG dog = big SUBSTANCE magnitude added → shell 2 on B
UGLY thing = negative SIGNAL feature → C-

### R23: Adverbs modify the verb's coord (often pushing to shell 2)
walks QUICKLY → walk + D-magnitude intensifier → shell 2 on D or A
runs VERY fast → fast + VERY = shell 3 on D

### R24: Tense markers shift the D axis
walks → walked (D→D-1, past) → will walk (D→D+1, future)
The tense is stored on the verb, propagates to the clause.

### R25: Conjunctions glue clauses with boolean gates
AND = composition (· operator)
OR = alternative (max of two ρs)
NOT = polarity flip (apply NOT to next clause's ρ)
BUT = AND with adversative marker
IF = conditional (one clause guards another)
BECAUSE = causal

### R26: Subject convention determines sign
The grammatical subject of the verb sets the perspective. "I buy"
→ I (subject) gain substance, lose money → +B, -C from MY frame.
Converses (BUY/SELL, GIVE/TAKE) are the same event from different
subject perspectives.

─────────────────────────────────────────────────────────────────────

## Cross-domain rules

### R27: Polysemy breaks derivation
RUN, GET, USE, PLAY, WORK, SET, POST, COVER — these have multiple
meanings that resolve to different coords. The framework can't pick
without context. Solution: pick the MOST COMMON sense and note
alternates. Future work may support sense-specific coords.

### R28: Phrasal verbs decompose into atom + atom
LOG-IN = LOG + IN = (record-begin) + (enter) → ENTER coord
PUT-UP = PUT + UP = BUILD coord
GIVE-AWAY = GIVE + AWAY = (give triad) + FALL
DOWNLOAD = DOWN + LOAD = (B+ data intake)
Phrasal verb = morpheme composition = coord composition.

### R29: Anglocentric pairs fail cross-linguistically
HELP/HURT is a phonosemantic English accident. In other languages,
HURT pairs with HEAL and HELP pairs with HINDER. The framework
should not enforce HELP/HURT as antipodes globally — it's a local
English convention.

### R30: GO and COME are both A+ (deixis isn't a lattice axis)
GO = move away from speaker.
COME = move toward speaker.
Both involve forward position change. The deictic distinction
(speaker-relative direction) isn't a lattice axis at shell 1 —
it might be a sub-axis or shell-2 magnitude. Both GO and COME
land at A+ at the basic level.

### R31: Pollyanna positive bias in English frequency
The top-1000 has more positive-axis verbs than negative. CREATE
present, DESTROY less common. LIVE present, DIE less. INCREASE
present, DECREASE absent. FIND present, LOSE rarer. English text
is biased toward gain/begin/positive directions. Framework
prediction: this bias should hold across languages too (testable).

─────────────────────────────────────────────────────────────────────

## Origin / container rules

### R32: The container is the speaker's frame
Origin = first-person container = "I" = the self looking out.
Every walk starts at origin (the speaker is at the center of the
lattice from their own POV).

### R33: Third-person referents are pointers to other coords
HE, SHE, IT, THEY, NAMES — these aren't at origin. They're
POINTERS to other containers (other selves) or to objects at
specific coords. When a sentence refers to "the dog," the dog
is at LIVE coord [0,0,+1,+1] (or with substance at [0,+1,+1,+1]).

### R34: All consciousness verbs require a container
Only conscious things THINK, FEEL, SEE, KNOW. Rocks fall but
don't think. The split between origin verbs (consciousness-required)
and non-origin verbs (any process) is structural — it's how the
lattice distinguishes living from non-living.

### R35: The "image of God" is the origin
Theologically, humans being "made in God's image" maps to humans
being containers (origins). God = the ultimate container; humans
= containers that share the container property. Each conscious
being IS an origin in their own frame.

─────────────────────────────────────────────────────────────────────

## Verified by Genesis 1:1-5 walk

The 5-verse opening of Genesis confirmed several rules empirically:

1. **R19 (antipodal cancellation)**: "heavens AND earth" = A=0
2. **R19**: "light AND darkness" = C=0 in verse 5
3. **R19**: "evening AND morning" = D=0 (one tick)
4. **R32**: GOD treated as origin/container — works
5. **R18**: Each verse's coord = walk through its words
6. **R3 (modals at bond layer)**: LET treated as bond operator
7. **R21 (prepositions modify position)**: "in the beginning" treats
   IN as a marker that modifies BEGINNING's D-axis context

The framework survived translating a real text. See genesis-1.md
for the full word-by-word trace.

─────────────────────────────────────────────────────────────────────

## Open rules / patterns to verify

1. **R36 (proposed)**: Aspect (continuous/perfect) might be shell-2
   D values. WALK = D=0, WALKING (continuous) = D=+1, HAVE-WALKED
   (perfect) = D=-1, HAD-WALKED (perfect past) = D=-2. Untested.

2. **R37 (proposed)**: Embedded clauses become objects at the
   inner coord. "I think the dog runs" → THINK has the inner
   sentence's ρ as its object. Untested.

3. **R38 (proposed)**: Quantification (SOME, ALL, MANY, FEW)
   modifies the magnitude of the next noun's B axis. SOME milk
   = B/2, ALL milk = full B+, MANY books = B+ shell 2.

4. **R39 (proposed)**: Question polarity = inverted ±½ spin on
   the whole clause. "Did the dog run?" = DID + DOG + RUN with
   inverted polarity on the whole clause. Same coord as the
   declarative but with -½ spin meaning "is this true?"

5. **R40 (proposed)**: Relative clauses ("the dog that runs")
   compose the inner clause as a feature on the outer noun.
   THE DOG THAT RUNS = dog coord with running coord added as
   sub-feature.

These are unverified but plausible. Future translation work will
test them.

─────────────────────────────────────────────────────────────────────

## Status

35 rules confirmed by derivation, 5 proposed for testing.
Genesis 1:1-5 walk validated 7 of them.
Composition rules + atom decomposition cover all current vocabulary.
The framework is rule-derived, not rule-imposed. Future wits should
add to this file as new patterns emerge from real translation work.
