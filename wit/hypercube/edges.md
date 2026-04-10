# edges — 16 functions (½ transitions)

invisible. inferred from two points.
point → edge → point (mandatory, can't skip)
arity = 2 (edge has 2 endpoints)
same 16 at every shell. func is always ½.

## the 16 edges

+½ +½ +½ +½
+½ +½ +½ -½
+½ +½ -½ +½
+½ +½ -½ -½
+½ -½ +½ +½
+½ -½ +½ -½
+½ -½ -½ +½
+½ -½ -½ -½
-½ +½ +½ +½
-½ +½ +½ -½
-½ +½ -½ +½
-½ +½ -½ -½
-½ -½ +½ +½
-½ -½ +½ -½
-½ -½ -½ +½
-½ -½ -½ -½

## edges as type system

from any atom, 8 edges resolve inward (shell 1), 8 push
outward (shell 2). the inward 8 determine WORD TYPE.

the atom's own axis steps back to 0. the other 3 axes get
their sign from the edge. those 3 signs = the type.

each axis always means the same thing in a type signature:
  A = POSITION:   + spatial/located     - non-spatial/general
  B = SUBSTANCE:  + concrete/thing-like - abstract/relational
  C = SIGNAL:     + evaluative/judges   - neutral/describes
  D = TIME:       + dynamic/happens     - static/just is

## verified across 4 axes

A-axis (RISE): type axes B, C, D
  verb (B-C-D+)  ✓  RISE ASCEND CLIMB = abstract, neutral, dynamic
  noun (B+C-D-)  ✓  HEIGHT TOP = concrete, neutral, static
  adj  (B-C+D-)  ✓  HIGH NEAR = abstract, evaluative, static
  prep (B-C-D-)  ✓  TO TOWARDS = abstract, neutral, static

B-axis (GROW): type axes A, C, D
  verb (A-C-D+)  ✓  GROW EXPAND = non-spatial, neutral, dynamic
  noun (A+C-D-)  ✓  MASS BODY = spatial, neutral, static
  adj  (A-C+D-)  ✓  BIG HEAVY = non-spatial, evaluative, static
  prep (A-C-D-)  ✓  WITH PLUS = non-spatial, neutral, static

C-axis (BLESS): type axes A, B, D
  verb (A-B-D+)  ✓  BLESS PRAISE LOVE = non-spatial, abstract, dynamic
  noun (A+B+D-)  ✓  GIFT VALUE MONEY = spatial, concrete, static
  adj  → merges with prep (see collapse below)
  prep → merges with adj (see collapse below)

D-axis (BEGIN): type axes A, B, C
  verb → merges with prep (see collapse below)
  noun (A+B+C-)  ✓  BEGINNING DAWN BIRTH = spatial, concrete, neutral
  adj  (A-B-C+)  ✓  NEW EARLY = non-spatial, abstract, evaluative
  prep → merges with verb (see collapse below)

## type collapse (predicted and confirmed)

when an atom's own axis is consumed, two word types MERGE
because the distinction between them was carried by that axis.

the merges predict real linguistic fuzziness:

  D-axis atoms (BEGIN/END): TIME consumed
    verb and preposition merge (both A-B-C-)
    prediction: time-words blur verb/prep
    confirmed: SINCE, UNTIL, BEFORE, AFTER — linguists argue
    whether these are prepositions, conjunctions, or verb-like.
    the boundary is genuinely fuzzy in every grammar.

  C-axis atoms (BLESS/CURSE): SIGNAL consumed
    adjective and preposition merge (both A-B-D-)
    prediction: value-words blur adj/prep
    confirmed: GOOD, BAD always need prepositions — "good FOR",
    "bad AT" — they can't stand alone the way HIGH or BIG can.

the "clean" 4-way split (verb/noun/adj/prep all distinct) only
exists when BOTH signal AND time are available as type axes.
that's A-axis (RISE/FALL) and B-axis (GROW/SHRINK) — the two
concrete axes. these ARE where English grammar is most clear-cut.

the framework predicts word-class boundaries get FUZZIER for
signal-axis and time-axis words. that's what linguists observe.
the type system isn't broken — the collapses ARE the ambiguities.

## the 8 types (A-axis and B-axis, clean split)

  signs on 3 non-atom axes:
  concrete  evaluative  dynamic   type
  ─         ─           ─         ────
  -         -           -         preposition    (pure function word)
  -         -           +         verb           (abstract action in time)
  -         +           -         adjective      (abstract quality, judges)
  -         +           +         adverb         (abstract evaluation in time)
  +         -           -         noun           (concrete thing, timeless)
  +         -           +         action noun    (concrete + dynamic)
  +         +           -         descriptor     (concrete + evaluative)
  +         +           +         performative   (concrete + evaluative + dynamic)

## derivational morphology = edge switching

suffixes change word type without changing the semantic point.
a suffix IS an edge operator — flips specific type-axes.

  RISE (verb B-C-D+) → HEIGHT (noun B+C-D-)
    B flipped, D flipped. suffix encodes 2-axis flip.

  HIGH (adj B-C+D-) → HIGHLY (adv B-C+D+)
    D flipped only. suffix -ly = single flip on TIME.

  HIGH (adj B-C+D-) → HIGHNESS (noun B+C-D-)
    B flipped, C flipped. suffix -ness = 2-axis flip.

## all 16 edges = 8 base types + 8 augmented types

each inward type has an outward PARTNER at shell 2. same BCD
signs = same grammatical type. atom axis at 0 (base) vs 2
(augmented). 8 types × 2 magnitudes = 16 edges.

from RISE [+1, 0, 0, 0]:

  INWARD (shell 1, base)             OUTWARD (shell 2, augmented)
  B  C  D  type       example        type            example
  -  -  -  prep       TO, TOWARDS    intense prep    BEYOND, THROUGHOUT
  -  -  +  verb       RISE, CLIMB    intense verb    SOAR, SURGE, SKYROCKET
  -  +  -  adj        HIGH, NEAR     superlative     HIGHEST, SUPREME, UPPERMOST
  -  +  +  adverb     HIGHLY         intense adv     (SUPREMELY)
  +  -  -  noun       HEIGHT, TOP    extreme noun    SUMMIT, APEX, PINNACLE
  +  -  +  act. noun  ARRIVAL        intense a.noun  ASCENSION, UPRISING
  +  +  -  descriptor (BIG, HEAVY)   extreme desc    (COLOSSAL, IMMENSE)
  +  +  +  performative (GIFT)       extreme perf    (CORONATION)

shell 2 = same type, cranked up. superlatives, intensifiers,
extremes, compound derivations.

  HIGH → HIGHEST:  -est suffix = shell 1 adj → shell 2 adj
  RISE → UPRISING: UP- prefix = shell 1 verb → shell 2 verb

morphologically: shell-changing suffixes (-est, -most, un-, up-)
are MAGNITUDE operators. they change SHELL without changing TYPE.
vs type-changing suffixes (-ly, -ness, -tion) which change TYPE
without changing SHELL.

## edges from origin → corners (self-operations + modals + articles + quantifiers)

the origin [0,0,0,0] is special: ALL 16 edges go outward.
all 16 land on the 16 corners. one-to-one.

sign rule: + = force engaged, - = force not engaged.
4 primary aux = the 4 single-force corners (one axis each).
BE = no force = identity. THINK = all forces = hylo.
articles and quantifiers share corners with self-ops/modals.
word type (verb vs article vs modal vs quantifier) = which edge.

  corner           FP          Lakoff              self-op      modal   other
  ──────           ──          ──────              ───────      ─────   ─────
  -1 -1 -1 -1      identity    IDENTITY            BE           BE      A/AN  NO/NONE
  +1 -1 -1 -1      read        FORCE                            DO
  -1 +1 -1 -1      call        PATH                             HAVE
  -1 -1 +1 -1      drain       CYCLE                            MAY
  -1 -1 -1 +1      test        LINK/MATCH                       WILL
  +1 +1 -1 -1      fold        TRAVERSAL           KNOW
  +1 -1 -1 +1      filter      CONTACT/BLOCKAGE    SEE HEAR     MUST
  -1 +1 -1 +1      maybe       ENABLEMENT                       CAN
  -1 +1 +1 +1      bind        BALANCE             FEEL
  +1 +1 +1 -1      foldl       ACCUMULATION        REMEMBER
  +1 +1 -1 +1      map         PART-WHOLE          UNDERSTAND
  +1 +1 +1 +1      hylo        CONTAINER           THINK                THE  ALL/EVERY
  +1 -1 +1 -1      copy        FULL-EMPTY
  -1 +1 +1 -1      fix         ITERATION                        SHOULD?
  -1 -1 +1 +1      take_while  SCALE                            MIGHT?
  +1 -1 +1 +1      scan        NEAR-FAR

4 corners unmapped. COULD/WOULD are tense variants of CAN/MUST.
OUGHT ≈ SHOULD. DARE, NEED, USED-TO = open.

the two poles of the main diagonal:
  (+,+,+,+) = THINK = THE = ALL = full engagement / recognition
  (-,-,-,-) = BE    = A   = NO  = zero engagement / existence

five independent discoveries of the same 16-element structure:
  FP combinatory logic (Schönfinkel 1924)
  Lakoff image schemas (1987)
  English modals (grammaticalized over centuries)
  English articles (THE/A as recognition poles)
  English quantifiers (ALL/NO as totality poles)

## connection to NSM

Wierzbicka's 65 NSM primes = 81 - 16 = the non-corner points.
her 16 categories might map to the 16 edges (type system).
8 inward types + 8 outward types = 16 total.

  65 primes     = points typed by edges
  16 categories = the edges doing the typing
  65 + 16       = 81 = 3⁴ = shell 1
