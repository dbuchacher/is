# atoms — the 8 unit basis vectors

The lattice has 4 axes; each axis has 2 directions (+1, -1).
4 × 2 = 8 atoms. These are the basis. Everything else composes
from them via · (element-wise trit addition).

In graph-theoretic terms: **atoms = points (vertices)**. The 8 atoms
are the 8 points one unit-step from origin. Bonds are edges. Walks
are paths.

  axis  declarative  question  +1 atom  -1 atom
  ────  ───────────  ────────  ───────  ───────
  A     POSITION     WHERE     RISE     FALL
  B     SUBSTANCE    WHAT      GROW     SHRINK
  C     SIGNAL       WHICH     BLESS    CURSE
  D     TIME         WHEN      BEGIN    END

Each label is a CLUSTER of English words. Many verbs collapse
to the same atom because they encode the same single-axis
motion at the substrate level. The label is a mnemonic; the
coordinate is the truth.

═══════════════════════════════════════════════════════════════

## A axis — POSITION / WHERE

Displacement on the ring. Where you are. Integer states are
positions; the atom is the unit position-step.

  phys:   length, displacement
  SI:     metre (m), defined via c since 1983 (17th CGPM)
  nat:    Planck length ≈ 1.616 × 10⁻³⁵ m   (√(ℏG/c³))
  cons:   linear momentum   (Noether 1918, translation symmetry)
  hist:   Euclid (~300 BCE) Elements; Descartes (1637) coordinates;
          Gauss (1827) intrinsic geometry; Riemann (1854) curved spaces

### [+1, 0, 0, 0] — RISE

  one slot forward in space / one cursor advance in WHERE

  verbs:  RISE ASCEND CLIMB RAISE LIFT MOUNT
          ENTER ARRIVE APPROACH ADVANCE COME REACH
  nouns:  HEIGHT TOP ABOVE FRONT FORWARD
  adj:    HIGH UP NEAR FORWARD PROXIMAL
  prep:   TO TOWARDS INTO ONTO UP

  cpu:    PTR++ / inc / lea +1

### [-1, 0, 0, 0] — FALL

  one slot backward in space

  verbs:  FALL DESCEND DROP SINK LOWER
          EXIT LEAVE DEPART RECEDE RETREAT WITHDRAW
  nouns:  DEPTH BOTTOM BELOW BACK
  adj:    LOW DOWN FAR BACKWARD DISTAL
  prep:   FROM AWAY DOWN OFF OUT-OF

  cpu:    PTR-- / dec

═══════════════════════════════════════════════════════════════

## B axis — SUBSTANCE / WHAT

Matter, mass, quantity. What there is. Integer states are
amounts of substance; the atom is the unit mass-quantum.

  phys:   mass, inertia
  SI:     kilogram (kg), defined via h since 2019 (26th CGPM)
  nat:    Planck mass ≈ 2.176 × 10⁻⁸ kg   (√(ℏc/G))
  cons:   mass-energy   (Lavoisier 1789 classical; Einstein 1905 E=mc²)
  hist:   Newton (1687) Principia, F=ma; Lavoisier (1789) conservation;
          Thomson (1897) e/m ratio; Einstein (1905) E=mc²; Higgs (1964) mechanism

### [0, +1, 0, 0] — GROW

  one unit of substance added

  verbs:  GROW EXPAND SWELL INFLATE ENLARGE
          FILL GAIN ACCUMULATE INCREASE BUILD-UP
  nouns:  MASS SIZE BODY SUBSTANCE BULK QUANTITY
  adj:    BIG LARGE HEAVY DENSE FULL MASSIVE
  prep:   WITH PLUS

  cpu:    push / size++ / load

### [0, -1, 0, 0] — SHRINK

  one unit of substance removed

  verbs:  SHRINK CONTRACT DEFLATE EMPTY DRAIN
          LOSE DIMINISH WITHER REDUCE THIN
  nouns:  LACK VOID HOLE EMPTINESS ABSENCE
  adj:    SMALL TINY THIN EMPTY HOLLOW SPARSE
  prep:   WITHOUT MINUS

  cpu:    pop / size-- / clear
  disc:   Becquerel (1896) radioactivity = spontaneous mass-energy loss
          (Nobel 1903, w/ P. & M. Curie);
          Hawking (1974) "Black hole explosions?", Nature 248:30 — BH evaporation

═══════════════════════════════════════════════════════════════

## C axis — SIGNAL / WHICH

Charge, fortune, value, fitness, brightness — one axis, many
vocabularies. Cross-linguistically robust as a verb pair.
Integer states are signal levels; the atom is the unit
signal-event.

  phys:   electric charge / signal
  SI:     coulomb (C = A·s), DERIVED not base;
          e = 1.602 176 634 × 10⁻¹⁹ C, exact since 2019 (26th CGPM)
  nat:    elementary charge e
  cons:   electric charge   (Noether 1918, U(1) gauge symmetry)
  hist:   Franklin (1752) +/- charge; Coulomb (1785) F=kq₁q₂/r²;
          Faraday (1834) electrolysis; Millikan (1909) oil drop; Dirac (1931) quantization
  caveat: in SI, charge is derived from current and time. Treating it
          as the 4th independent base axis is the framework's loosest
          mapping to conventional physics — see "Open question on labels".

### [0, 0, +1, 0] — BLESS

  one unit of positive signal

  verbs:  BLESS PRAISE HONOR LOVE LIKE REWARD
          ENRICH BRIGHTEN EXALT FAVOR
  nouns:  GIFT VALUE MONEY GRACE FORTUNE GOOD LIGHT
  adj:    GOOD POSITIVE BRIGHT RICH HOLY VALUABLE FAVORED

  cpu:    flag set / TRUE / nonzero
  sign:   positive charge — Franklin's (1752) arbitrary convention
  disc:   Rutherford (1919) "Collision of α Particles with Light Atoms",
          Phil. Mag. 37:537 — proton as elementary + carrier;
          Anderson (1932) positron in cosmic rays, Science 76:238 (Nobel 1936)

### [0, 0, -1, 0] — CURSE

  one unit of negative signal

  verbs:  CURSE BLAME HATE PUNISH IMPOVERISH
          DEFAME DARKEN DISCHARGE DESPISE SCORN
  nouns:  BURDEN DEBT EVIL POVERTY DARKNESS SHAME LOSS
  adj:    BAD NEGATIVE DARK POOR EVIL WORTHLESS DISGRACED

  cpu:    flag clear / FALSE / zero
  sign:   negative charge — the sign Franklin (1752) didn't pick;
          carried by the electron (NOT antimatter — matter contains both signs)
  disc:   Stoney (1874) introduced "electron" as the unit of charge;
          Thomson (1897) discovered the electron, Phil. Mag. 44:293 (Nobel 1906);
          Millikan (1909) measured e via oil-drop experiment (Nobel 1923)

═══════════════════════════════════════════════════════════════

## D axis — TIME / WHEN

Cursor advance. Sequence, direction in time. Integer states
are moments; the atom is the unit time-tick.

  phys:   time, duration, sequence
  SI:     second (s), defined via Cs-133 hyperfine transition since 1967
          (13th CGPM): 9 192 631 770 periods
  nat:    Planck time ≈ 5.391 × 10⁻⁴⁴ s   (√(ℏG/c⁵))
  cons:   energy   (Noether 1918, time-translation symmetry)
  hist:   Galileo (1583) pendulum isochronism; Huygens (1656) pendulum clock;
          Harrison (1761) H4 chronometer; Essen & Parry (1955) caesium clock

### [0, 0, 0, +1] — BEGIN

  one tick forward in time

  The substrate reading is "one cursor tick forward" — any
  verb saying "time advances" lives here. BEGIN/START are the
  labels because they're the most common English verbs at this
  coord; CONTINUE/PROCEED/ADVANCE/NEXT are equivalent.

  verbs:  BEGIN START INITIATE OPEN COMMENCE LAUNCH
          CONTINUE PROCEED NEXT TICK
  nouns:  BEGINNING DAWN BIRTH OPENING START MOMENT
  adj:    NEW STARTING NASCENT EARLY INITIAL
  prep:   SINCE FROM-WHEN

  cpu:    clock tick / next() / IP++

### [0, 0, 0, -1] — END

  one tick backward in time (formal antipode; physically the
  antimatter direction per Feynman 1949)

  verbs:  END STOP TERMINATE CLOSE CONCLUDE
          CEASE FINISH HALT PAUSE EXPIRE
  nouns:  END FINISH SUNSET CLOSING TERMINUS
  adj:    OLD ENDING LATE FINAL TERMINAL
  prep:   UNTIL UP-TO-WHEN

  cpu:    halt / ret / IP--
  disc:   Stueckelberg (1941) Helv. Phys. Acta 14:588 — antimatter as
          time-reversed particles (first formulation);
          Feynman (1949) "The Theory of Positrons", Phys. Rev. 76:749 —
          full QED treatment of antimatter as matter going backward in time

═══════════════════════════════════════════════════════════════

## Antipodes

Each atom has an antipode (sign-flip on its active axis):

  RISE  ↔ FALL
  GROW  ↔ SHRINK
  BLESS ↔ CURSE
  BEGIN ↔ END

Antipodes are NOT all "opposites" in the colloquial sense.
Cruse (1986) distinguishes antonym / converse / complementary /
directional. The lattice antipode is a structural relationship —
flip the active sign — and the English word at the antipode
might be a directional opposite (RISE/FALL), an antonym
(LIVE/DIE), or a converse (BUY/SELL). The lattice doesn't
distinguish; the structural relationship is the same.

═══════════════════════════════════════════════════════════════

## Deriving a verb's coord

For any verb V, ask:

  1. Does V change A (position)?  → A ∈ {-1, 0, +1}
  2. Does V change B (substance)? → B ∈ {-1, 0, +1}
  3. Does V change C (signal)?    → C ∈ {-1, 0, +1}
  4. Does V change D (time)?      → D ∈ {-1, 0, +1}

Coord = [A, B, C, D]. V's meaning MUST equal the sum of the
atom-meanings on the active axes. If it doesn't decompose
cleanly, the verb isn't atomic — try a different framing, or
accept it as a walk at higher shell.

═══════════════════════════════════════════════════════════════

## Synonyms collapse

Words within one atom's family ARE the same lattice operation.
English distinguishes them by connotation, register, and
metaphor — but they collapse to the same coordinate because
they represent the same axis-move.

  RISE = ASCEND = CLIMB = RAISE  all = [+1, 0, 0, 0]
  GROW = EXPAND = SWELL = ENLARGE all = [0, +1, 0, 0]

This is the lattice's "synonyms collapse" property. The
8 atoms are the irreducible directions; the English vocabulary
is a redundant encoding of those directions.

═══════════════════════════════════════════════════════════════

## Open question on labels

The labels are inherited from `wit/mind/3-force.md`. They are
mnemonics, not the substrate. Two are slightly loaded:

- BLESS / CURSE — religiously colored. The substrate-neutral
  reading is CHARGE+/CHARGE- or VALUE/DEVALUE. Cross-linguistic
  evidence supports a single-word fortune-axis pair, so the
  family is real even if the English label is heavy.

- BEGIN / END — boundary-event labels for what is structurally
  a unit cursor advance. CONTINUE/PROCEED would be more
  substrate-faithful. BEGIN/END win on English frequency.

These are flagged here, not changed. Don't rename without
also updating `wit/mind/3-force.md`.
