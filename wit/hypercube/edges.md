# edges — 16 functions (the ½ transitions)

Invisible. Inferred from two points.
point → edge → point (mandatory, can't skip)
arity = 2 (edge has 2 endpoints)
same 16 at every shell. func is always ½.

Edges are TRANSITIONS — the · operator, the spin layer, the
combinators. You never observe an edge directly; you observe
two integer states and infer what happened between them.

  code: float4 passes through these during walk computation
  classification: classify_bond(coord4 a, coord4 b) → bitmask
                  takes 2 points, infers 1 edge-type
                  the edge itself is never stored — only its effect

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

## why invisible

You never observe a force. You observe two states and infer
the force from the difference. You never observe spin (½). You
observe integer states and infer the transition between them.

In code: the bitmask isn't stored. It's computed ON DEMAND
from two coord4 values. The edge has no independent storage —
it exists only as the relationship between its endpoints.

In physics: a force has no independent existence. It's the
name for what happened between two states. Remove the states
and the force has nothing to act on.

In FP: a combinator like `map` doesn't exist as a value. It
exists as a type signature — a description of what happens
between input and output. `map :: (a -> b) -> [a] -> [b]` talks
entirely about VALUES (a, b, [a], [b]). The combinator itself
is invisible in the type.

## binary vs trit count

On binary hardware, edges are classified by a 4-bit bitmask:
"which axes changed between two points?" 2⁴ = 16 types.

  binary (x86):   if (a.t != b.t) mask |= 1;    // 1 bit: yes/no
  trit (native):  bond.t = b.t - a.t;            // 1 trit: -1/0/+1

On trits: 3⁴ - 1 = 80 directed edge-types. The 16 is what you
get when you throw away direction to fit on binary hardware.
The Setun (1958) would have given 80 natively. This file lists
16 because classification currently happens on binary silicon.

## edges as type system

From any atom, 8 edges resolve inward (shell 1), 8 push
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

## connection to NSM

Wierzbicka's 65 NSM primes = 81 - 16 = the non-corner points.
her 16 categories might map to the 16 edges (type system).
8 inward types + 8 outward types = 16 total.

  65 primes     = points typed by edges
  16 categories = the edges doing the typing
  65 + 16       = 81 = 3⁴ = shell 1

