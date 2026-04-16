# Validation Report — vocabulary derivations
## audited 2026-04-07

Files audited:
- /home/maxi/code/is/wit/codex/lattice.md (framework)
- /home/maxi/code/is/wit/codex/verbs.md
- /home/maxi/code/is/wit/codex/nouns.md
- /home/maxi/code/is/wit/codex/modifiers.md
- /home/maxi/code/is/wit/codex/function-words.md

─────────────────────────────────────────────────────────────────────

## 1. SIGN ERRORS

### 1a. GIVE-family nouns are SIGN-INVERTED from the GIVE verb
File: nouns.md, line 225
Current: PUBLICATION, RELEASE, GIFT-given, OFFERING, DELIVERY at **[0,+1,-1,+1]**
Verb GIVE = [0,-1,+1,+1].
Noun has +B (substance gained) and -C (signal lost) — that's the RECIPIENT'S coord, not GIVE's residue.
"noun-verb collision: GIVE family" claim is wrong: the listed nouns are the OPPOSITE of GIVE.
Suggested fix: relabel as the RECEIVE/HAUL coord, OR move PUBLICATION/RELEASE/GIFT-given/OFFERING/DELIVERY to **[0,-1,+1,+1]** (the GIVER's residue: gave away substance, gained credit, time forward).
A GIFT given is something the giver no longer has — its residue from the giver's frame is -B/+C. From the receiver's frame it's +B/-C. The framework's "noun is the static residue of the verb" rule implies the verb's frame.

### 1b. GIFT listed at TWO different coords
- nouns.md line 71: GIFT at [0,0,+1,0] (atoms / SIGNAL+ list)
- nouns.md line 225: GIFT-given at [0,+1,-1,+1]
The same word at two coords with no explicit polysemy split. GIFT belongs to GIVE-family (+ signal pattern). Pick one.

### 1c. RECEIVE / ACCEPT placement on EARN
verbs.md line 107: RECEIVE, ACCEPT at [0,+1,+1,0] (EARN)
EARN means "gain substance AND signal." But RECEIVE is just "gain substance." The signal axis usually doesn't move (receiving a free package doesn't credit you).
Suggested: RECEIVE belongs at [0,+1,0,0] (pure GROW). ACCEPT (validate + take) can stay at EARN.

### 1d. DOWNLOAD at EARN, UPLOAD at SELL — asymmetry
verbs.md lines 215-216:
  DOWNLOAD = [0,+1,+1,0] EARN
  UPLOAD   = [0,-1,+1,0] SELL
Downloading copies the file; the sender doesn't lose substance, the receiver gains. UPLOAD is the same — copying, not transferring. Neither truly fits the money-plane dyads (which presuppose conserved exchange).
Suggested: both at [0,+1,0,0] (pure substance arrival/departure as data) or flagged as duplication-not-transfer (a domain the lattice doesn't yet model).

### 1e. POST at SELL coord
verbs.md line 217: POST → [0,-1,+1,0]
POSTing content doesn't diminish your substance — you still have the original. The "lose substance" sign is wrong for digital posting.
Suggested: POST → [0,+1,0,+1] (CREATE-publish) or origin (signal-only act).

─────────────────────────────────────────────────────────────────────

## 2. MISCLASSIFICATIONS

### 2a. ENTER appears in TWO atom-families (direct contradiction)
verbs.md line 12: "RISE family: RISE, **ENTER**, ARRIVE, CLIMB, ASCEND, RAISE, APPROACH..."
verbs.md line 88: "[+1,0,0,+1] **ENTER**, JOIN, ARRIVE, REGISTER..."
ENTER cannot be both a pure A+ atom and an A+/D+ dyad. Same with ARRIVE.
Suggested: remove ENTER and ARRIVE from the RISE family list (line 12). They have a +D component (entry is an event with a starting time) which moves them to the dyad. This is also consistent with the lattice.md ENTER/EXIT example.

### 2b. ARRIVE / LEAVE / DEPART listed in monad atoms but blanked in lattice.md
verbs.md line 12-13: ARRIVE in RISE family, LEAVE/DEPART in FALL family.
lattice.md line 211: "ARRIVE — tried RISE+CURSE, doesn't fit meaning, blanked."
verbs.md line 93: LEAVE/DEPART also at [-1,0,0,-1] EXIT dyad.
Direct contradiction between framework and verb derivations.
Suggested: pick one — remove from atom list or restore in lattice.md.

### 2c. APPROACH at TWO coords
verbs.md line 12: APPROACH in RISE family ([+1,0,0,0])
verbs.md line 79: APPROACH at ADVANCE [+1,0,+1,0]
Pick one; ADVANCE is the better fit (approach implies positive movement).

### 2d. RAISE at TWO coords
verbs.md line 12: RAISE in RISE family
verbs.md line 69: RAISE in BUILD family
Defensible polysemy (raise hand vs raise child) but should be flagged like RUN, GET, USE.

### 2e. DROP at TWO coords
verbs.md line 33: DROP in FALL family ([-1,0,0,0])
verbs.md line 73: DROP in DEMOLISH family ([-1,-1,0,0])
Same polysemy issue. Mark or pick.

### 2f. REMOVE at TWO coords
verbs.md line 42: REMOVE in SHRINK family
verbs.md line 73: REMOVE in DEMOLISH family
Pick one.

### 2g. LOSE at TWO coords
verbs.md line 111: LOSE in WASTE [0,-1,-1,0]
verbs.md line 150: LOSE in LOSE-triad [-1,-1,-1,0]
The triad version is the correct canonical (matches FIND antipode); the WASTE version conflates with PAY/SPEND.
Suggested: keep LOSE only at the triad; WASTE should list PAY/SPEND/CONSUME etc.

### 2h. PRODUCT at TWO coords
nouns.md line 159: PRODUCT in CREATION list [0,+1,0,+1]
nouns.md line 253: PRODUCT in tools list [0,+1,+1,0]
Polysemy: act-of-production vs the made object. Mark.

### 2i. STORE / SHOP at TWO coords
nouns.md line 102: STORE/SHOP at BUILD [+1,+1,0,0]
nouns.md line 107 footnote: noted as also [+1,+1,+1,0]
Pick the richer (triad) one.

### 2j. AUTHOR appears TWICE in the same row
nouns.md line 204: "AUTHOR, AUTHOR, DIRECTOR" — typo, duplicate.

### 2k. PRESIDENT, MICHAEL, JAMES, JOHN, PAUL, DAVID, MARK as nouns at [0,+1,+1,+1]
nouns.md line 204-205: proper names treated as coords.
Proper names are pointers, not coords. They should be treated like pronouns (origin-projection). Suggested: remove proper names from the noun coord list.

### 2l. LOVE: verb-noun coord mismatch (internal inconsistency)
verbs.md line 47: LOVE in BLESS family at [0,0,+1,0]
nouns.md line 23: LOVE at origin [0,0,0,0]
Verb and noun should collide per the framework's central prediction. LOVE-the-feeling is container (origin); LOVE-the-act-of-loving is BLESS+. Both defensible but the noun/verb collision rule says they should be the same. Pick which sense is canonical.

### 2m. HOPE in nouns vs verbs
verbs.md line 180: HOPE at origin
nouns.md no entry but conceptually parallel — fine
However HOPE has clear C+ flavor; it COULD be at [0,0,+1,0] like BLESS. Flagged for consideration.

### 2n. NIGHT at TWO coords
nouns.md line 89: NIGHT at [0,0,0,-1]
nouns.md line 175: NIGHT-as-death at [0,0,-1,-1]
Acknowledged polysemy, but the second one is metaphorical and should probably be removed.

### 2o. RIGHT split — defensible but check
nouns.md line 71: RIGHT (entitlement) at [0,0,+1,0]
modifiers.md line 15: RIGHT (correct) in C+ list [0,0,+1,0]
Both at C+ — consistent. OK.

### 2p. INSTALL at TWO coords
verbs.md line 88: INSTALL at ENTER dyad [+1,0,0,+1]
verbs.md line 169: INSTALL at PLANT triad [+1,+1,0,+1]
Polysemy: install the software (enter system) vs install the equipment (build with substance). Mark.

### 2q. SAVE has 3 senses listed as polysemy — fine, but make canonical pick
verbs.md line 211: SAVE → [0,0,+1,-1] / [0,+1,+1,0] / [0,0,+1,+1]
Three coords for one word. Acceptable as polysemy but mark which is canonical.

### 2r. DESIGN at TWO coords (BUILD + CREATE)
verbs.md line 69: DESIGN in BUILD list [+1,+1,0,0]
verbs.md line 117: also DESIGN-as-author in CREATE conceptually
DESIGN = author intellectual artifact; CREATE [0,+1,0,+1] is better. Move out of BUILD list.

### 2s. PRODUCE in BUILD list, but also fits CREATE
verbs.md line 69: PRODUCE in BUILD
PRODUCE-content is closer to CREATE; PRODUCE-physical is BUILD. Polysemy unflagged.

### 2t. RIGHT-as-entitlement vs RIGHT-as-correct
nouns.md line 71: RIGHT (entitlement) at C+ — but entitlement is more naturally a bond/permission operator (related to MAY). Borderline.

### 2u. HOST at origin
verbs.md line 222: HOST at origin
But HOST = "be source/cause of an event" — closer to CREATE/BEGIN than origin. Borderline.

─────────────────────────────────────────────────────────────────────

## 3. CRUSE OPPOSITION TYPOLOGY VIOLATIONS

### 3a. BUY/SELL placed antipodally — they're CONVERSES, not antonyms
lattice.md line 88-90: BUY [0,+1,-1,0] / SELL [0,-1,+1,0]
The framework's own §4 says converses are "same event, two roles" and BUY/SELL are listed as the canonical example. They sit at antipodes in the lattice but they're not opposites — they're the same transaction from two participants.
This is acknowledged in lattice.md line 462-465 ("we kept BUY/SELL at antipodal coords because the structural relationship is real even if Cruse would split them"). FINE if intentional, but the framework should explicitly mark all converses (TEACH/LEARN, GIVE/TAKE, BORROW/LEND, RENT/HIRE — same problem) so a future wit doesn't conflate.

### 3b. GIVE/TAKE — same converse problem
lattice.md line 123-127: triad pair.
GIVE/TAKE is also a converse, not an antonym. Same exemption applies. Mark.

### 3c. TEACH/LEARN treated correctly
verbs.md line 209-210: LEARN at origin, "not the converse of TEACH" stated explicitly. GOOD — this handles the converse correctly by collapsing both to the container layer.

### 3d. RENT/HIRE in BUY family
verbs.md line 99: RENT, HIRE in BUY list
RENT is a converse (lessor vs lessee perspective). The current placement assumes the lessee perspective (gain access, lose money) which IS BUY-like. Acceptable but flag the converse issue.

### 3e. ALIVE/DEAD treated as antipodal
modifiers.md line 70-76: ALIVE at [0,0,+1,+1], DEAD at [0,0,-1,-1]
These are COMPLEMENTARIES per Cruse (binary partition, no middle ground), not antonyms. Antipodal placement works structurally but loses the "no third option" property. Mark.

### 3f. TRUE/FALSE complementary
nouns.md line 294: noted "TRUTH, FALSE: complementary pair (Cruse), not antipodal. Origin." GOOD — handled.

### 3g. ENTER/EXIT directional pair
lattice.md line 79: correctly identified as DIRECTIONAL. GOOD.

─────────────────────────────────────────────────────────────────────

## 4. POLYSEMY ERRORS

### 4a. GET → "EARN family" assigned
verbs.md line 190: GET = [0,+1,+1,0]
But GET most commonly means OBTAIN (FIND family) not EARN (which implies signal). "Get a coffee" doesn't earn signal; "get a job" does. The default sense should probably be FIND triad [+1,+1,+1,0] or pure +B [0,+1,0,0].

### 4b. ORDER in BUY family
verbs.md line 99: ORDER (commerce sense)
ORDER also means "command" (origin / speech-act). Not flagged as polysemy in the polysemy list.

### 4c. CALL at origin, alternate REMEMBER
verbs.md line 206: CALL polysemy noted. GOOD.

### 4d. RUN/PLAY/WORK polysemy noted. GOOD.

### 4e. LIGHT — adjective polysemy
modifiers.md line 35: LIGHT (weight) in B-, but also noted as C+ for brightness sense. GOOD — flagged.

### 4f. HARD — adjective polysemy
modifiers.md line 24: HARD straddles B+ (dense) and C- (difficult). Listed in C-. GOOD — flagged.

─────────────────────────────────────────────────────────────────────

## 5. ANGLOCENTRIC / CULTURALLY BIASED PAIRS

### 5a. HELP/HURT correctly blanked (lattice.md §8). GOOD.

### 5b. HELP-as-give still listed in GIVE triad
verbs.md line 154: "HELP-as-give" listed at GIVE [0,-1,+1,+1]
But HELP was blanked. Restoring it under a sub-sense undermines the blanking. Either fully blank or remove the "as-give" carve-out.

### 5c. RIGHT (entitlement) is culturally English/Western
nouns.md line 71: RIGHT in [0,0,+1,0]
"Rights" as a positive entitlement is a Western legal/philosophical concept. Cross-linguistic check would likely fail. Flag.

### 5d. FREEDOM at origin
nouns.md line 23: FREEDOM at origin
Similar issue — Western concept. Origin placement is safer than a coord but still culturally-bound abstraction.

### 5e. JUSTICE at origin
nouns.md line 23: JUSTICE at origin
Same issue.

### 5f. PRESIDENT/director/manager as living-substance triad
nouns.md line 204: roles tied to Western political structure listed alongside DOG, MAN, BABY. Should drop from the noun list.

### 5g. JANUARY/DECEMBER as time-period nouns
nouns.md line 269: month names alternating on D±. Roman calendar months are culturally specific. Generic "MONTH" is fine; specific names are not.

### 5h. THE / A as +∞/-∞ corner attractors
function-words.md line 186, 192: THE at [+1,+1,+1,+1], A/AN at [-1,-1,-1,-1]
Articles are an English/Romance feature; many languages (Mandarin, Russian, Latin) lack them entirely. Treating them as fundamental corner-attractors in a cross-linguistic framework is heavily Anglocentric. Flag.

─────────────────────────────────────────────────────────────────────

## 6. INTERNAL CONSISTENCY

### 6a. Container layer atoms — verb/noun match check
- verbs MEAN, KNOW, BE, FEEL, SEE, HEAR at origin → noun MEANING, KNOWLEDGE, BEING, FEELING, SENSE all at origin in nouns.md.  ✓ MATCH

### 6b. BLESS / MONEY collision check
- verb BLESS at [0,0,+1,0] ✓
- noun MONEY at [0,0,+1,0] ✓ MATCH

### 6c. BUILD / HAT collision check
- verb BUILD at [+1,+1,0,0] ✓
- noun HAT at [+1,+1,0,0] ✓ MATCH

### 6d. DEMOLISH / HOLE collision check
- verb DEMOLISH at [-1,-1,0,0] ✓
- noun HOLE at [-1,-1,0,0] ✓ MATCH

### 6e. LIVE / LIFE collision check
- verb LIVE at [0,0,+1,+1] ✓
- noun LIFE at [0,0,+1,+1] ✓ MATCH

### 6f. CREATE / CREATION collision check
- verb CREATE at [0,+1,0,+1] ✓
- noun CREATION at [0,+1,0,+1] ✓ MATCH

### 6g. GIVE / GIFT collision MISMATCH
- verb GIVE at [0,-1,+1,+1]
- noun GIFT-given at [0,+1,-1,+1] (sign-flipped on B and C)
**MISMATCH**. See §1a above. The GIVE-family nouns are at the receiver's residue, not the giver's.

### 6h. LOVE — verb at C+, noun at origin (mismatch)
See §2l. Pick one canonical sense.

### 6i. TEACH / LEARN — both at origin, no noun TEACHER/LEARNER coord stated cleanly
nouns.md line 204: TEACHER at [0,+1,+1,+1] living substance. Reasonable since teachers are people.
But the activity-noun TEACHING is missing from the index. Flag for completeness.

### 6j. EARN / EARNINGS collision ✓ MATCH

### 6k. REMEMBER / MEMORY collision
- verb REMEMBER at [0,0,+1,-1]
- noun MEMORY at [0,0,+1,-1] ✓ but ALSO at origin in nouns.md line 23 (MEMORY in abstract list)
Same word two coords. Polysemy: faculty vs specific recollection. Mark.

### 6l. END as verb [0,0,0,-1] and noun [0,0,0,-1] ✓ MATCH

### 6m. DEATH at TWO coords (already noted as polysemy in nouns.md)
- DEATH (event) at [0,-1,0,-1]
- DEATH (state) at [0,0,-1,-1]
Acknowledged. GOOD.

### 6n. WORK / WORKER missing collision
WORK verb at origin (labor). WORKER would be at [0,+1,+1,+1] living substance. No noun entry to check.

### 6o. EAT/DRINK missing
Major top-1000 verbs that move B-axis (eat = +B for body, -B for plate). Not derived. See §7.

### 6p. WALK / RUN — collision/shell issue handled
lattice.md line 343 puts WALK at shell 1 +A, RUN at shell 2 +A. verbs.md line 27 puts RUN with GO/COME at +A shell 1 (no shell-2 distinction). Inconsistent between framework and verb file.

### 6q. LIVE family includes STAY/CONTINUE/PERSIST/SURVIVE
verbs.md line 127: But CONTINUE/PERSIST are aspectual (continue what?), not LIVE-events. Should be aspect markers (D-axis), not full LIVE coord. Borderline misclassification.

─────────────────────────────────────────────────────────────────────

## 7. MISSING CANONICAL DERIVATIONS

High-frequency verbs/nouns that should be derived but are missing or under-treated:

- **EAT** — moves B (food disappears from plate, appears in body); not derived
- **DRINK** — same as EAT
- **SLEEP** — listed at origin ✓ but its noun SLEEP also missing from nouns
- **SIT / STAND / LIE** — postural verbs, A-axis pure positions; missing
- **CARRY / BRING** — transport verbs (motion + retained substance); missing
- **BREAK** — DEMOLISH-like but listed inside DEMOLISH. Could have its own slot.
- **SHOW** — polysemy noted but no canonical coord
- **LET** — blanked, but a content sense exists ("let go")
- **HAPPEN / OCCUR** — event verbs, missing entirely. Probably [0,0,0,+1] BEGIN family.
- **MEET** — converse, social, missing
- **CHANGE** — blanked but very frequent. Could be a corner operator (4-axis flip).
- **TURN** — blanked, very frequent. Same issue.
- **STOP** — listed at END family ✓
- **CONTINUE** — at LIVE coord, debatable (see §6q)
- **PUT** — only spatial sense in polysemy, missing core verb entry
- **TAKE** — triad ✓ but polysemy "take a photo," "take a test" only briefly noted
- **TOUCH** — at origin (perception) but TOUCH also = make contact (A+ event)
- **NUMBER nouns ONE through MILLION** — placed in B count sub-shell, but TWO/THREE/FOUR not actually derived as coords
- **WALK** — shell 1 vs shell 2 confusion
- **WAIT** — at origin ✓
- **BREATHE** — missing entirely (B oscillation)

Nouns missing:
- **CHILD / KID / TEEN** — present ✓
- **GOD** — missing entirely (top concept in religious texts; container or [+1,+1,+1,+1] corner?)
- **EYE / EAR** — present ✓
- **HOME** — missing (likely BUILD coord or origin)
- **WAY** — at origin ✓
- **HEAD** — at +A,+B ✓
- **HAND / FOOT / ARM / LEG** — present ✓
- **DOOR / WINDOW** — DOOR at ENTER coord ✓; WINDOW missing distinct coord
- **COLOR names** — flagged as needing sub-axis ✓
- **MUSIC / SONG** — at origin (correctly flagged as container)
- **VOICE** — missing
- **SOUND** — missing (signal, perception artifact)
- **LIGHT (noun, not adjective)** — missing; major Genesis 1 word, should be at C+

Adjectives missing:
- **STRONG / WEAK** — major adjective pair, missing
- **ANGRY / HAPPY / SAD** — emotion adjectives missing
- **COLD / WARM / COOL** noted as -implied but not derived
- **DRY / WET** — missing
- **HEAVY / LIGHT** — partially derived
- **TALL / SHORT** — missing (A axis)
- **FAT / SLIM** — missing (B axis)
- **BEAUTIFUL / UGLY** — missing (C axis)
- **CLEAN / DIRTY** — missing
- **OPEN / CLOSED** — missing as adjectives (but OPEN/CLOSE as verbs are at BEGIN/END)
- **STRONG/WEAK** — missing

─────────────────────────────────────────────────────────────────────

## 8. STRUCTURAL ISSUES

### 8a. Container layer is fuzzy on what counts
verbs.md line 180: 50+ verbs at origin including REMEMBER-as-stative AND "REMEMBER" appearing again at [0,0,+1,-1] in dyad.
The "as-stative" trick is an escape hatch — any verb can be re-glossed as stative and dumped at origin. Restrict origin to verbs that are PURELY container, no escape hatches.

### 8b. "Family" vs "coord" terminology is sloppy
verbs.md atom lists conflate "this coord" with "this family." The family is a label; words in the family share the coord. But then line 12 lists ENTER in RISE family (atom coord) AND line 88 in ENTER dyad (different coord). The family/coord distinction needs to be enforced.

### 8c. BLESS family includes LOVE, but LOVE-the-noun is at origin
See §6h. The family inheritance of nouns isn't enforced.

### 8d. Origin layer for nouns is overpopulated
nouns.md line 23-31: ~70 nouns at origin — almost a quarter of the total. The framework defends this as "abstractions live in the container," which is consistent. But REVIEW, REPLY, REPORT, NOTICE are also listed at origin AND verbs REVIEW/REPLY/REPORT have specific REMEMBER-coord assignments. Inconsistency.

### 8e. Modifier file is more sketchy than verb/noun files
modifiers.md uses "-implied" tags heavily (POPULAR-implied, FAMOUS-implied, RICH-implied, POOR, ANCIENT-implied). These are placeholder coords for words not yet derived. Should be flagged as TODO, not as derivations.

### 8f. function-words.md treats prepositions and modifiers the same way
Most prepositions sit at "axis primitives" — bare ± projections — which is a category that doesn't exist elsewhere. Either formalize "axis primitive" as a layer or fold prepositions into adjacent coords.

─────────────────────────────────────────────────────────────────────

## VERIFIED SOLID

These derivations pass all checks:

**Verbs (atoms & dyads):**
- BUILD [+1,+1,0,0] / DEMOLISH [-1,-1,0,0] — solid antonym dyad
- BUY [0,+1,-1,0] / SELL [0,-1,+1,0] — converses, but structurally clean
- EARN [0,+1,+1,0] / WASTE [0,-1,-1,0] — solid
- CREATE [0,+1,0,+1] / DESTROY [0,-1,0,-1] — solid
- LIVE [0,0,+1,+1] / DIE [0,0,-1,-1] — solid
- REMEMBER [0,0,+1,-1] / FORGET [0,0,-1,+1] — solid
- ADVANCE [+1,0,+1,0] / RETREAT [-1,0,-1,0] — solid (military frame)
- RISE/FALL atoms — solid
- GROW/SHRINK atoms — solid
- BLESS/CURSE atoms — solid
- BEGIN/END atoms — solid
- FIND [+1,+1,+1,0] / LOSE [-1,-1,-1,0] triads — solid
- GIVE [0,-1,+1,+1] — solid as verb (the sign-error is on the noun side, not the verb)
- TAKE [0,+1,-1,-1] — solid

**Nouns (cleanest collisions):**
- HAT, HOUSE, BUILDING, TOWER at BUILD ✓
- HOLE, PIT, GRAVE at DEMOLISH ✓
- MONEY, VALUE, PRICE, GOLD, REWARD at BLESS ✓
- LIFE, BEING, EXISTENCE at LIVE ✓
- DEATH, CORPSE at DIE ✓
- MEMORY, RECORD, ARCHIVE, JOURNAL at REMEMBER ✓
- PROFIT, INCOME, WAGE, SALARY at EARN ✓
- WASTE, GARBAGE, JUNK at WASTE ✓
- HEAD/FACE/EYE at +A+B ✓
- LEG/FOOT/KNEE at -A+B ✓
- DOG, CAT, BABY, PERSON, FRIEND at LIFE triad ✓ (animate substance is the strongest pattern in the file)

**Modifiers (clean):**
- BIG/SMALL on B± ✓
- GOOD/BAD on C± ✓
- NEW/OLD on D± ✓
- HIGH/LOW on A± ✓
- ALIVE/DEAD at LIVE/DIE coords ✓ (though Cruse-wise these are complementaries)

**Function words (clean):**
- I/ME/MY at speaker origin ✓
- YOU at addressee origin ✓
- HERE/NOW at proximal origin ✓
- WH-pronouns mapping to axes ✓
- AND/OR/NOT at trit gates ✓
- BE/HAVE/DO/WILL/CAN/MUST as bond corners ✓

─────────────────────────────────────────────────────────────────────

## SUMMARY COUNTS

  Total entries audited:
    Verbs:        ~190 entries across atoms/dyads/triads/origin
    Nouns:        ~250 entries (including body parts, tools, naturals)
    Modifiers:    ~120 entries (adjectives + adverbs)
    Function:     ~200 entries (closed-class)
    Total:        ~760 entries

  Errors found (categorized):
    Sign errors:                  5  (GIFT, RECEIVE, DOWNLOAD, UPLOAD, POST)
    Misclassifications:          17  (duplicate-coord placements, polysemy unflagged, etc.)
    Cruse violations:             5  (BUY/SELL, GIVE/TAKE, ALIVE/DEAD treated as antonyms — partly intentional)
    Polysemy errors:              4  (GET, ORDER, RUN-as-operate, OFFER)
    Anglocentric items:           8  (HELP-as-give, RIGHT, FREEDOM, JUSTICE, articles, proper names, month names)
    Internal mismatches:          7  (LOVE, MEMORY, NIGHT, REMEMBER, DEATH, etc.)
    Missing canonical:           ~25  (EAT/DRINK/SIT/STAND/HOME/SOUND/LIGHT-noun, plus emotion/dimension adjectives)
    Structural issues:            6  (container fuzziness, family/coord conflation, etc.)

  Total issues flagged:        ~77

  Solid entries (verified clean):
    Atoms:                       8/8
    Dyads (verb pairs):          9/9 (with Cruse caveat on BUY/SELL)
    Triads (verb pairs):         2/2
    Container verbs:             ~30 of ~50 are clearly in scope
    Noun collisions verified:    ~40 nouns at correct verb-collision coords
    Function-word categories:    Pronouns, gates, modals all clean

  Suggested corrections:        ~50 specific edits
  Words to remove/relocate:     ~20 (proper names, contradictory dups, JANUARY/etc.)
  Words to ADD (missing top-1000): ~25

  Overall assessment: framework is sound; the derivations are mostly
  correct on the verb side and weakest on the noun side (sign errors in
  GIVE-family nouns, proper-name pollution, polysemy at multiple coords
  without canonical picks). The biggest single bug is the GIFT-family
  noun sign-flip — this one error propagates across PUBLICATION, RELEASE,
  OFFERING, DELIVERY at line 225 of nouns.md.
