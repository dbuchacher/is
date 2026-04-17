# tutorial — how to derive a word's coord

A worked example showing how to take any English word and find its
position on the lattice. This is the same procedure that built the
~570 words in `translate.py` and the entries in `verbs.md`/`nouns.md`.

If you're a new wit and you want to add a word, follow this.

─────────────────────────────────────────────────────────────────────

## The 4-question rule (the only rule you need)

For any word V, ask these four questions in order:

  1. Does V change POSITION (A axis)?
     - Does it move things in space?
     - +1 = gain position / move forward / displacement positive
     - -1 = lose position / move backward / displacement negative
     -  0 = position not addressed

  2. Does V change SUBSTANCE (B axis)?
     - Does it create or destroy physical matter?
     - +1 = gain substance / matter increases
     - -1 = lose substance / matter decreases
     -  0 = substance not addressed

  3. Does V change SIGNAL (C axis)?
     - Does it move stored value, charge, fortune, or valence?
     - +1 = gain signal / positive valence
     - -1 = lose signal / negative valence
     -  0 = signal not addressed

  4. Does V change TIME-direction (D axis)?
     - Does the verb's CORE meaning involve temporal direction?
     - +1 = forward in time / starts / future-pointing
     - -1 = backward in time / ends / past-pointing
     -  0 = time not in the verb's core meaning

V's coord = [A, B, C, D]. That's it.

─────────────────────────────────────────────────────────────────────

## Worked example 1: the word "EAT"

**Question 1**: Does EAT change POSITION?
- When you eat, your body doesn't change spatial position
- The food doesn't change spatial position much either
- POSITION not addressed → A = 0

**Question 2**: Does EAT change SUBSTANCE?
- Yes — the food disappears from the plate, appears in your body
- From the EATER's perspective (the subject), substance INCREASES
  (the body gains mass)
- B = +1

**Question 3**: Does EAT change SIGNAL?
- Eating doesn't change the eater's stored value/fortune/charge
- It's a physical act, not a signal-bearing one
- SIGNAL not addressed → C = 0

**Question 4**: Does EAT change TIME-direction?
- Eating happens in time but isn't ABOUT time direction
- It's not "starting" or "ending" anything
- TIME not addressed → D = 0

**EAT = [0, +1, 0, 0]**

That's the same coord as GROW, RECEIVE, INCLUDE, and ADD — all
GROW-family verbs (substance increase from the subject's frame).

─────────────────────────────────────────────────────────────────────

## Worked example 2: the word "GIFT" (noun)

For nouns, the rule is slightly different — instead of "does the
verb CHANGE this axis," ask "does this thing have a CHARACTERISTIC
value on this axis."

Or simpler: nouns share coords with their related verbs. GIFT is the
static residue of GIVE. So GIFT = GIVE coord.

**GIVE coord (verb)**:
- A: 0 (not about position)
- B: -1 (subject loses substance — gives it away)
- C: +1 (subject gains reputation/credit/social signal)
- D: +1 (the act is forward-pointing — generosity moves things forward)

**GIVE = [0, -1, +1, +1]**

So **GIFT (noun) = [0, -1, +1, +1]** as the residue of giving.

(Note: this is from the GIVER's perspective. From the RECEIVER's
perspective, the gift is at [0, +1, -1, -1] — gaining substance,
losing reputation. The lattice is subject-relative.)

─────────────────────────────────────────────────────────────────────

## Worked example 3: the word "SUNRISE"

**Question 1**: POSITION? Yes — the sun rises (moves up)
- A = +1 (vertical positive)

**Question 2**: SUBSTANCE? No — the sun's mass doesn't change
- B = 0

**Question 3**: SIGNAL? Yes — sunrise is the moment light begins
- C = +1 (positive signal — light increases)

**Question 4**: TIME-direction? Yes — sunrise STARTS the day
- D = +1 (forward — beginning)

**SUNRISE = [+1, 0, +1, +1]**

This is a triad — three axes active. It composes from RISE + BLESS
+ BEGIN. The decomposition matches the meaning: "rise-blessed-begin"
= the moment when light starts to ascend.

─────────────────────────────────────────────────────────────────────

## Common pitfalls

### Pitfall 1: Overactive D axis
Many verbs HAPPEN in time without being ABOUT time direction. WALK
happens in time but D should be 0 (it's not about beginning or ending).

Only set D ≠ 0 if the verb's core meaning is temporal direction:
- BEGIN, START, OPEN → D = +1
- END, STOP, FINISH → D = -1
- WALK, EAT, SLEEP → D = 0 (happen in time, but not directed)

### Pitfall 2: Forgetting subject perspective
Always derive from the GRAMMATICAL SUBJECT's frame.

  "I give him money."  → subject is I → I lose money → C = -1 from I's frame
  "He receives money." → subject is He → He gains money → C = +1 from his frame

These are the same event but the lattice coords differ because the
subject differs. Converses (BUY/SELL, GIVE/RECEIVE) are the same
event from two roles.

### Pitfall 3: Confusing signal with substance
SIGNAL is abstract value/fortune/charge. SUBSTANCE is physical mass.

  MONEY = [0, 0, +1, 0]    pure SIGNAL (it's a value claim, not matter)
  GOLD  = [0, +1, +1, 0]   substance + signal (it's matter that has value)
  ROCK  = [0, +1, 0, 0]    pure substance (matter without inherent value)

Signal is about WORTH/VALENCE; substance is about MASS/MATTER.

### Pitfall 4: Stative verbs collapse to origin
HAVE, KNOW, BE, EXIST, FEEL, SEE, HEAR — these don't CHANGE any
axis. They describe a state, not a transition. They all collapse
to [0, 0, 0, 0] (the origin = container = self).

This isn't a bug. The container layer is real. Stative verbs are
operations of being a conscious self, not actions on the world.

─────────────────────────────────────────────────────────────────────

## How to add a word to the framework

### Method 1: append to a vocab file

1. Open the appropriate file (`verbs.md` for verbs, `nouns.md` for
   nouns, etc.)
2. Find the section for the coord you're adding to
3. Append your word to the existing list, or create a new section
4. Use the inline format: `[A,B,C,D]  WORD1, WORD2, WORD3`

### Method 2: add to translate.py

1. Open `translate.py`
2. Find the VOCAB dict
3. Add an entry: `"yourword": (A, B, C, D),`
4. Re-run the translator and verify it picks up the word

### Method 3: regenerate the master vocabulary

```bash
# After adding to source files, the master vocabulary.md needs
# to be regenerated. The Python script for this is inline in
# the corpus.sh, or run the parser block in any commit message.
```

─────────────────────────────────────────────────────────────────────

## Running the verifier on your additions

After adding a word, run:

```bash
python3 wit/codex/verify.py
```

ALL TESTS should still PASS. If any test fails, your addition
broke something. Check:
- Did you change a coord that the verifier tests against?
- Did you add a word that conflicts with an existing entry?
- Is your sign convention consistent (subject's perspective)?

─────────────────────────────────────────────────────────────────────

## Quick reference card

```
The 4 questions:
  1. POSITION?    +1 toward, -1 away, 0 not addressed
  2. SUBSTANCE?   +1 gain, -1 lose, 0 not addressed
  3. SIGNAL?      +1 gain value, -1 lose value, 0 not addressed
  4. TIME-DIR?    +1 forward, -1 backward, 0 not addressed

The 8 atoms (memorize these):
  RISE  [+1, 0, 0, 0]    FALL    [-1, 0, 0, 0]
  GROW  [ 0,+1, 0, 0]    SHRINK  [ 0,-1, 0, 0]
  BLESS [ 0, 0,+1, 0]    CURSE   [ 0, 0,-1, 0]
  BEGIN [ 0, 0, 0,+1]    END     [ 0, 0, 0,-1]

The origin (the container/self):
  THINK [0, 0, 0, 0]    KNOW, BE, FEEL, SEE, HEAR, WANT also live here
                        (anything that doesn't change the world)

Composition (· operator):
  Sentence walks: ρ accumulates word coords
  ρ_new = ρ_old · word_coord (element-wise addition)
```

That's the entire framework. Everything else is derivation.
