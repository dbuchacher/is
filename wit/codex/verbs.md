# verbs — top ~200 English verbs derived from 8 atoms

Framework: 4 axes A=POSITION, B=SUBSTANCE, C=SIGNAL, D=TIME, trit values {-1,0,+1}.
Derivation rule: for each verb V, ask whether the subject changes A, B, C, D.
The verb's coord = [A,B,C,D] and must equal the sum of its atom meanings.
Subject convention: the grammatical subject's gain/loss determines sign.
See `lattice.md` for the full framework. This file derives ~190 verbs from
the top-1000 English word list at `top-1000-english.txt`.

## Atoms (8) — the foundation

  [+1, 0, 0, 0]  RISE      family: RISE, ENTER, ARRIVE, CLIMB, ASCEND, RAISE, APPROACH, GO, COME, REACH, MOVE
  [-1, 0, 0, 0]  FALL      family: FALL, EXIT, DEPART, DESCEND, LOWER, RECEDE, LEAVE
  [ 0,+1, 0, 0]  GROW      family: GROW, EXPAND, SWELL, INFLATE, ENLARGE, FILL, GAIN, INCREASE, ADD
  [ 0,-1, 0, 0]  SHRINK    family: SHRINK, CONTRACT, DEFLATE, EMPTY, LOSE, REDUCE, CUT
  [ 0, 0,+1, 0]  BLESS     family: BLESS, PRAISE, HONOR, LIKE, LOVE, REWARD, ENRICH, THANK
  [ 0, 0,-1, 0]  CURSE     family: CURSE, BLAME, DISGRACE, HATE, PUNISH, IMPOVERISH
  [ 0, 0, 0,+1]  BEGIN     family: BEGIN, START, INITIATE, OPEN, COMMENCE, LAUNCH
  [ 0, 0, 0,-1]  END       family: END, STOP, TERMINATE, CLOSE, CONCLUDE, CEASE, FINISH

─────────────────────────────────────────────────────────────────────

## Monads (1-axis verbs) — atom families pulled from top-1000

### A axis (POSITION)

[+1,0,0,0]  GO, COME, MOVE, RUN, ENTER, REACH, VISIT, RETURN, FOLLOW, BROWSE, TRAVEL
  derivation: subject changes spatial position (treated as +A by convention; direction subtype lives on shell-2)
  notes: GO/COME both at +A — direction relative to deictic center is a sub-axis we don't lexicalize here.
  RUN sense = locomote (most common), not "operate."
  RETURN = re-displace (RISE family by motion).

[-1,0,0,0]  LEAVE, DROP, LOWER, RECEDE
  derivation: subject loses spatial position relative to reference
  notes: most A-negative verbs in top-1000 are paired phrasals; raw atoms here.

### B axis (SUBSTANCE)

[0,+1,0,0]  ADD, INCLUDE, FILL, GAIN, GROW, INCREASE, EXPAND
  derivation: substance count goes up (subject acquires mass/quantity)

[0,-1,0,0]  REMOVE, CUT, REDUCE, EMPTY, SHRINK, LOSE-mass
  derivation: substance count goes down

### C axis (SIGNAL)

[0,0,+1,0]  LIKE, LOVE, PRAISE, THANK, REWARD, BLESS, HONOR, CHOOSE, PREFER
  derivation: subject's stored signal/fortune toward object goes positive; no displacement, mass, or time-direction change.
  notes: CHOOSE/PREFER = signal-tag a target as +.

[0,0,-1,0]  HATE, BLAME, CURSE, PUNISH, REJECT, DENY, FAIL
  derivation: subject's stored signal toward object goes negative.
  notes: FAIL = self-curse (signal toward own performance drops).

### D axis (TIME)

[0,0,0,+1]  START, BEGIN, OPEN, LAUNCH, INITIATE, COMMENCE
  derivation: cursor moves forward; nothing else changes axis.

[0,0,0,-1]  END, STOP, CLOSE, FINISH, CEASE, TERMINATE, QUIT
  derivation: cursor halted/reversed; nothing else changes.

─────────────────────────────────────────────────────────────────────

## Dyads (2-axis verbs)

### A × B (position × substance)

[+1,+1,0,0]  BUILD, CONSTRUCT, ERECT, RAISE, ELEVATE, DESIGN, MAKE, FORM, DEVELOP, PRODUCE
  derivation: RISE + GROW — bring growing substance into a higher/realized position
  notes: MAKE is closest English synonym; BUILD canonical. PRODUCE = "make and emit."

[-1,-1,0,0]  DEMOLISH, DESTROY-physical, DROP, DUMP, REMOVE, CLEAR, BREAK
  derivation: FALL + SHRINK — drop substance off the structure
  notes: DESTROY here is the physical demolition sense; the create/destroy temporal antonym lives at B×D.

### A × C (position × signal)

[+1,0,+1,0]  ADVANCE, PROGRESS, APPROACH, IMPROVE, PROMOTE
  derivation: RISE + BLESS — move forward gaining signal
  notes: PROMOTE both elevates position and adds signal/honor.

[-1,0,-1,0]  RETREAT, WITHDRAW, RESIGN, DECLINE, DEMOTE
  derivation: FALL + CURSE — move back losing signal

### A × D (position × time)

[+1,0,0,+1]  ENTER, JOIN, ARRIVE, REGISTER, LOG-IN, INSTALL, ATTEND
  derivation: RISE + BEGIN — position-in + time-start
  notes: REGISTER, LOG-IN, JOIN: "enter the system at the start of a session" — pure A+D+ composite.
  ATTEND = enter and begin participation.

[-1,0,0,-1]  EXIT, LEAVE, QUIT, LOG-OUT, DEPART, ESCAPE
  derivation: FALL + END — position-out + time-stop
  notes: LOG-OUT explicitly antipodal of LOG-IN.

### B × C (substance × signal) — THE MONEY PLANE

[0,+1,-1,0]  BUY, PURCHASE, ORDER, RENT, HIRE, IMPORT
  derivation: GROW + CURSE — gain thing, lose money
  notes: HIRE = buy a person's labor. ORDER (commerce sense, not "command").

[0,-1,+1,0]  SELL, OFFER, EXPORT, RELEASE-product, SHIP, DELIVER, SEND
  derivation: SHRINK + BLESS — lose thing, gain money/signal
  notes: SHIP/DELIVER/SEND: subject parts with substance and gains signal-credit. Polysemy: SEND a message lives at origin.

[0,+1,+1,0]  EARN, GAIN, PROFIT, WIN, ACHIEVE, ACQUIRE, COLLECT, RECEIVE, ACCEPT
  derivation: GROW + BLESS — gain substance and signal in one move
  notes: WIN = earn via contest. ACCEPT = receive and validate.

[0,-1,-1,0]  WASTE, SPEND, PAY, CONSUME, LOSE, COST, FUND
  derivation: SHRINK + CURSE — lose both substance and stored value
  notes: PAY/SPEND collapse here. COST is the same event from the substance's frame.

### B × D (substance × time)

[0,+1,0,+1]  CREATE, GENERATE, INVENT, AUTHOR, COMPOSE, WRITE, DRAW, PRINT, PUBLISH
  derivation: GROW + BEGIN — substance grows from a starting point
  notes: WRITE/PRINT/PUBLISH = subject creates content from time-zero. AUTHOR = create + sign.

[0,-1,0,-1]  DESTROY, KILL, ERASE, DELETE, CANCEL, ABOLISH, BURN
  derivation: SHRINK + END — substance shrinks to nothing at terminal time
  notes: KILL is the action sense (the patient's life ends, substance gone).

### C × D (signal × time) — THE LIFE / MEMORY PLANE

[0,0,+1,+1]  LIVE, GROW-up (mature), STAY, CONTINUE, PERSIST, SURVIVE
  derivation: BLESS + BEGIN — signal active and going forward
  notes: STAY/CONTINUE = persist signal forward. SURVIVE = live through.

[0,0,-1,-1]  DIE, EXPIRE, FADE, PASS-away
  derivation: CURSE + END — signal off, time halted

[0,0,+1,-1]  REMEMBER, RECALL, RECORD, ARCHIVE, REVIEW, REPORT, REFERENCE
  derivation: BLESS + END — signal retrieved from past
  notes: RECORD, ARCHIVE, REPORT: encode signal pointing back. REVIEW = re-look at past stored signal.

[0,0,-1,+1]  FORGET, IGNORE, OVERLOOK, MISS, SKIP
  derivation: CURSE + BEGIN — signal lost going forward
  notes: SKIP/MISS = signal of the slot vanishes as time advances.

─────────────────────────────────────────────────────────────────────

## Triads (3-axis verbs)

[+1,+1,+1,0]  FIND, DISCOVER, CATCH, OBTAIN, IDENTIFY, LOCATE, DETECT
  derivation: RISE + GROW + BLESS — locate, hold, and value
  notes: DISCOVER/DETECT/LOCATE all triadic findings.

[-1,-1,-1,0]  LOSE, MISPLACE, DROP-and-lose
  derivation: FALL + SHRINK + CURSE — un-locate, drop, devalue
  notes: pure inverse of FIND.

[0,-1,+1,+1]  GIVE, GRANT, OFFER, PROVIDE, SUPPLY, SHARE, SUPPORT, DONATE, CONTRIBUTE, HELP-as-give
  derivation: SHRINK + BLESS + BEGIN — lose substance, gain reputation, forward in time
  notes: PROVIDE/SUPPLY/SUPPORT/SHARE: all "I lose mine, recipient and I both gain signal, time advances." HELP here = the give-resources sense.

[0,+1,-1,-1]  TAKE, GRAB, SEIZE, STEAL, REMOVE-from
  derivation: GROW + CURSE + END — gain substance, lose reputation, time backward
  notes: GRAB/SEIZE/STEAL = grabby backward.

[+1,0,+1,+1]  RISE-into-life, AWAKE, EMERGE, APPEAR, ARISE, ENTER-stage
  derivation: RISE + BLESS + BEGIN — position emerges, signal active, forward in time
  notes: APPEAR/EMERGE: the patient is the subject; thing comes into being-position.

[-1,0,-1,-1]  VANISH, DISAPPEAR, COLLAPSE, DIE-out, FAIL-and-fall
  derivation: FALL + CURSE + END

[+1,+1,0,+1]  PLANT, INSTALL, BUILD-from-zero, FOUND, ESTABLISH
  derivation: RISE + GROW + BEGIN — emplace growing substance from a starting time
  notes: FOUND = build-with-genesis. ESTABLISH = put in place at t=0.

[-1,-1,0,-1]  DISMANTLE, UNINSTALL, DEMOLISH-completely, RAZE
  derivation: FALL + SHRINK + END

─────────────────────────────────────────────────────────────────────

## Container layer (origin)

[0,0,0,0]  THINK, KNOW, BELIEVE, UNDERSTAND, MEAN, LEARN, STUDY, READ, ASK, ANSWER, SAY, SPEAK, TELL, TALK, CALL, DISCUSS, COMMENT, REPLY, NOTE, MENTION, DESCRIBE, EXPLAIN, REPORT-speech, ANNOUNCE, SUGGEST, SEE, LOOK, WATCH, VIEW, OBSERVE, NOTICE, HEAR, LISTEN, FEEL, SENSE, BE, EXIST, SEEM, BECOME, REMAIN, HAVE, OWN, HOLD, KEEP, WANT, WISH, NEED, HOPE, DREAM, SLEEP, REST, WAIT, TRY, ATTEMPT, PRACTICE, TEST, CHECK, COMPARE, MATCH, RATE, JUDGE, GUESS, DECIDE, PLAN, CONSIDER, EXPECT, INTEND, FOCUS, REMEMBER-as-stative

  derivation: no axis changes — operations of the conscious self
  notes: every speech-act collapses to origin (the signal originates inside the container and is uttered without changing world axes). Perception verbs (SEE, HEAR, FEEL) intake without altering the world. Stative possession (HAVE, OWN, HOLD, KEEP) doesn't change substance — only the relation. WANT/HOPE/NEED/DREAM are pure interior states. JUDGE/RATE/COMPARE/CHECK/TEST are cognitive evaluations performed inside.

─────────────────────────────────────────────────────────────────────

## Polysemy notes (chose most common sense)

- RUN: locomotion sense → [+1,0,0,0]. "Run a program" → origin. "Run a business" → origin.
- GET: receive sense → [0,+1,+1,0] (EARN family). "Get to a place" → [+1,0,0,0]. "Get sick" → CURSE.
- USE: consume-with-purpose → [0,-1,0,0] (mild SHRINK). Stative "use a tool" → origin.
- PLAY: recreate sense → origin (container activity). "Play a card" → [0,-1,0,0].
- WORK: labor → origin (interior effort, no axis change). Polysemy: "work the field" → [+1,+1,0,0].
- SET: place sense → [+1,0,0,0]. Many idiomatic uses.
- POST: publish/send → [0,-1,+1,0] (SELL family — emit content for signal). Forum sense same.
- SHOW: display → origin (perception offering — no axis change in subject). Alternate: REVEAL → [0,0,+1,+1] (signal becomes visible).
- HOLD: stative origin. Alternate: "hold a position" → origin.
- PUT: place sense → [+1,0,0,0]. Phrasal "put up" → BUILD; "put down" → DEMOLISH.
- TAKE: grab sense → triad above. "Take a test" → origin.
- MAKE: create sense → BUILD coord. "Make a friend" → BLESS.
- GIVE: triad above. "Give up" = QUIT → END atom.
- OFFER: SELL family (presents substance for signal). Alternate origin sense (offer an opinion).
- LET: permit → origin (modal-like).
- KEEP: stative origin. Alternate "keep going" → CONTINUE → [0,0,+1,+1].
- SHOW: see above.
- CALL: phone/speech → origin. Alternate "call to mind" → REMEMBER.
- WRITE: CREATE coord (canonical).
- READ: origin (perception).
- LEARN: origin (interior signal acquisition); not the converse of TEACH.
- TEACH: not in top-1000 directly but appears as STUDY/EDUCATION nominalizations. Origin.
- SAVE: store sense → [0,0,+1,-1] (REMEMBER family — preserve signal). Alternate "save money" → [0,+1,+1,0]. "Save a life" → [0,0,+1,+1].
- CHANGE: not derived (see blanked).
- COVER: spatial sense → [+1,0,0,0]. Alternate origin (cover a topic).
- TURN: not derived (see blanked).
- DOWNLOAD: receive substance → [0,+1,+1,0] (EARN family — get content with signal cost = nil).
- UPLOAD: emit substance → [0,-1,+1,0] (SELL family — emit for signal/credit).
- VIEW: origin (perception).
- ENTER: A×D dyad above.
- DRIVE: locomote → [+1,0,0,0]. Alternate "drive a project" → origin.
- VISIT: locomote → [+1,0,0,0].
- HOST: stative origin (be the source of an event).

─────────────────────────────────────────────────────────────────────

## Blanked verbs (no clean derivation)

- HELP / HURT — Anglocentric (per lattice.md §8). HELP-as-give lives at GIVE coord; HURT has no clean atom decomposition.
- CHANGE — too generic; "change" can move any axis. Marker for "axis flip" not a single coord.
- TURN — same problem; rotation isn't a lattice motion.
- TRY / ATTEMPT — origin-leaning but really an aspectual marker (effort over time). Listed at origin.
- USE — too polysemous; mild SHRINK at best; functions as a transitive marker.
- KEEP — stative; aspectual continuation marker. Origin if forced.
- SET — placement is +A but the word is mostly idiomatic.
- COVER — spatial polysemy.
- LET — permission/causation operator, not a content verb. Probably a corner/bond.
- MUST / SHOULD / WILL / CAN / MAY — modals; live at corners, not has-zero.
- PROVIDE — placed at GIVE but the financial sense is borderline.
- PROCESS — too abstract.
- INCLUDE — placed at +B but "include" is a relation, not an action.
- COMPARE — origin (cognitive); listed there but borderline.
- WORK — origin under labor sense; phrasal alternates.
- PLAY — origin under recreation; phrasal alternates.

─────────────────────────────────────────────────────────────────────

## Discovered rules

1. **All speech-act verbs collapse to origin.** SAY, SPEAK, TELL, TALK, CALL, ASK, ANSWER, REPLY, COMMENT, NOTE, MENTION, ANNOUNCE, EXPLAIN, DESCRIBE, SUGGEST — they utter signal but don't change the 4 axes of the world. The signal stays inside the container until a hearer's container catches it (which is also at their origin). Communication is origin-to-origin transfer that the lattice doesn't mark.

2. **All transfer verbs sit on the B×C plane.** BUY/SELL/EARN/WASTE/PAY/SPEND/EARN/COST/RECEIVE/ACCEPT/SHIP/DELIVER/SEND-physical: every commercial or material exchange is purely B×C with the subject convention determining sign. The "money plane" is the most populous dyad.

3. **All "computer-system entry" verbs map to A×D.** LOG-IN, REGISTER, JOIN, INSTALL, ENTER (a system), SUBSCRIBE → [+1,0,0,+1]. LOG-OUT, UNINSTALL, QUIT, EXIT → [-1,0,0,-1]. Software adopts the ENTER/EXIT atom as its basic verb pair.

4. **All "publish/emit content" verbs map to SELL coord [0,-1,+1,0].** POST, PUBLISH, SHIP, DELIVER, RELEASE, UPLOAD: they all decrement subject's substance and increment signal. Authoring is at CREATE [0,+1,0,+1]; emitting is at SELL [0,-1,+1,0]. Two distinct steps.

5. **All "memory/record" verbs map to [0,0,+1,-1] (REMEMBER coord).** RECORD, ARCHIVE, REVIEW, REPORT-stored, REFERENCE, SAVE-data, REMEMBER, RECALL: all encode signal pointing back to past time. RECORD is the canonical lattice operation for "preserve signal across time-direction reversal."

6. **All cognitive evaluation verbs collapse to origin.** JUDGE, RATE, COMPARE, CHECK, TEST, REVIEW (the cognitive sense, not the records sense), DECIDE, GUESS, CONSIDER: interior evaluations of intake signal. They use the container's stored knowledge but emit nothing externally that moves world axes.

7. **All "make from nothing" verbs map to [0,+1,0,+1] (CREATE).** WRITE, DRAW, COMPOSE, INVENT, GENERATE, AUTHOR, DESIGN-as-author, PRINT-original — substance grows from time-zero.

8. **All "find" verbs are triadic [+1,+1,+1,0].** FIND, DISCOVER, DETECT, LOCATE, IDENTIFY, OBTAIN, CATCH: locating + holding + valuing in one act. Conversely all "lose" verbs are [-1,-1,-1,0].

9. **All "give-class" verbs are [0,-1,+1,+1] (GIVE triad).** PROVIDE, SUPPLY, SUPPORT, GRANT, DONATE, CONTRIBUTE, SHARE, OFFER (when not commerce). The "I lose mine, you and I both gain signal, time advances" pattern is universal across English giving verbs. This validates GIVE as a triad atom.

10. **The container layer is the largest single coord.** ~50 of the ~190 verbs collapse to origin — over a quarter. This is consistent with lattice.md's prediction that consciousness-required verbs cluster at the self-point.

11. **Phrasal verbs decompose into atom + atom.** PUT-UP = BUILD; PUT-DOWN = DEMOLISH; LOG-IN = ENTER; LOG-OUT = EXIT; GIVE-UP = QUIT (END); SET-UP = ESTABLISH (RISE+GROW+BEGIN). The particle is one atom, the root is another.

12. **Modals don't fit has-zero.** WILL, CAN, MAY, MUST, SHOULD, SHALL: per lattice.md these are corner-bond operators with ±½ polarity, not content verbs. They're correctly excluded from this derivation.

13. **GO/COME both at +A, not antipodal.** Direction relative to deictic center (toward speaker vs away) is not a lattice axis at shell 1; both verbs are pure A+ position-changers. The deixis lives on a sub-axis (or shell-2 magnitude).

14. **Stative possession is origin, not B+.** HAVE, OWN, HOLD, KEEP — these don't grow substance, they describe a relation between container and object. GAIN/RECEIVE/EARN are the +B verbs (the *transition* into possession).

─────────────────────────────────────────────────────────────────────

## Tally

  Atoms (1-axis):    ~40 verbs at 8 coords (across 8 families)
  Dyads (2-axis):    ~70 verbs at 18 coords (9 dyad pairs)
  Triads (3-axis):   ~30 verbs at 8 coords
  Container:         ~50 verbs at 1 coord (origin)
  Blanked:           ~16 verbs (modals, polysemes, anglocentric)

  Total derived:     ~190 verbs from top-1000 list
  Lattice coverage:  35 distinct has-zero coords + origin populated

Pulled from across the entire top-1000, including the long tail
(WRITE, INCREASE, REMEMBER, CREATE, INVENT, REGISTER, INSTALL, etc.)
not just the first 100.
