# points — 81 integer lattice coords (shell 1)

All 81 = 3⁴ points of {-1, 0, +1}⁴. These are VALUES.
Observable states. Where things ARE.

  code: coord4 (int8_t) — storage, bins, field
  always: point → edge → point → edge → point (never skip the edge)

Grouped by zero-count. The f-vector of the 4D hypercube
gives the same counts (16+32+24+8+1=81) but they're all points.

Higher shells (values ±2, ±3, ±4) are reached by applying
funcs (edges) repeatedly. Not new primitives. The coord value
IS the count of funcs applied.

## 4 zeros (1) — the container

 0  0  0  0  container / self / observer

## 3 zeros (8) — the atoms

### A axis — POSITION / WHERE

  phys: length, displacement
  SI:   metre (m), defined via c since 1983
  nat:  Planck length ≈ 1.616 × 10⁻³⁵ m
  cons: linear momentum (Noether 1918, translation symmetry)

+1  0  0  0  RISE
  verbs:  RISE ASCEND CLIMB RAISE LIFT MOUNT ENTER ARRIVE APPROACH ADVANCE COME REACH
  nouns:  HEIGHT TOP ABOVE FRONT FORWARD
  adj:    HIGH UP NEAR FORWARD PROXIMAL
  prep:   TO TOWARDS INTO ONTO UP
  cpu:    PTR++ / inc / lea +1

-1  0  0  0  FALL
  verbs:  FALL DESCEND DROP SINK LOWER EXIT LEAVE DEPART RECEDE RETREAT WITHDRAW
  nouns:  DEPTH BOTTOM BELOW BACK
  adj:    LOW DOWN FAR BACKWARD DISTAL
  prep:   FROM AWAY DOWN OFF OUT-OF
  cpu:    PTR-- / dec

### B axis — SUBSTANCE / WHAT

  phys: mass, inertia
  SI:   kilogram (kg), defined via h since 2019
  nat:  Planck mass ≈ 2.176 × 10⁻⁸ kg
  cons: mass-energy (Lavoisier 1789; Einstein 1905 E=mc²)

 0 +1  0  0  GROW
  verbs:  GROW EXPAND SWELL INFLATE ENLARGE FILL GAIN ACCUMULATE INCREASE BUILD-UP
  nouns:  MASS SIZE BODY SUBSTANCE BULK QUANTITY
  adj:    BIG LARGE HEAVY DENSE FULL MASSIVE
  prep:   WITH PLUS
  cpu:    push / size++ / load

 0 -1  0  0  SHRINK
  verbs:  SHRINK CONTRACT DEFLATE EMPTY DRAIN LOSE DIMINISH WITHER REDUCE THIN
  nouns:  LACK VOID HOLE EMPTINESS ABSENCE
  adj:    SMALL TINY THIN EMPTY HOLLOW SPARSE
  prep:   WITHOUT MINUS
  cpu:    pop / size-- / clear

### C axis — SIGNAL / WHICH

  phys: electric charge / signal
  SI:   coulomb (C = A·s), DERIVED not base
  nat:  elementary charge e = 1.602 176 634 × 10⁻¹⁹ C
  cons: electric charge (Noether 1918, U(1) gauge symmetry)

 0  0 +1  0  BLESS
  verbs:  BLESS PRAISE HONOR LOVE LIKE REWARD ENRICH BRIGHTEN EXALT FAVOR
  nouns:  GIFT VALUE MONEY GRACE FORTUNE GOOD LIGHT
  adj:    GOOD POSITIVE BRIGHT RICH HOLY VALUABLE FAVORED
  cpu:    flag set / TRUE / nonzero

 0  0 -1  0  CURSE
  verbs:  CURSE BLAME HATE PUNISH IMPOVERISH DEFAME DARKEN DISCHARGE DESPISE SCORN
  nouns:  BURDEN DEBT EVIL POVERTY DARKNESS SHAME LOSS
  adj:    BAD NEGATIVE DARK POOR EVIL WORTHLESS DISGRACED
  cpu:    flag clear / FALSE / zero

### D axis — TIME / WHEN

  phys: time, duration, sequence
  SI:   second (s), defined via Cs-133 since 1967
  nat:  Planck time ≈ 5.391 × 10⁻⁴⁴ s
  cons: energy (Noether 1918, time-translation symmetry)

 0  0  0 +1  BEGIN
  verbs:  BEGIN START INITIATE OPEN COMMENCE LAUNCH CONTINUE PROCEED NEXT TICK
  nouns:  BEGINNING DAWN BIRTH OPENING START MOMENT
  adj:    NEW STARTING NASCENT EARLY INITIAL
  prep:   SINCE FROM-WHEN
  cpu:    clock tick / next() / IP++

 0  0  0 -1  END
  verbs:  END STOP TERMINATE CLOSE CONCLUDE CEASE FINISH HALT PAUSE EXPIRE
  nouns:  END FINISH SUNSET CLOSING TERMINUS
  adj:    OLD ENDING LATE FINAL TERMINAL
  prep:   UNTIL UP-TO-WHEN
  cpu:    halt / ret / IP--

## 2 zeros (24)

 0  0 -1 -1
 0  0 -1 +1
 0  0 +1 -1
 0  0 +1 +1
 0 -1  0 -1
 0 -1  0 +1
 0 +1  0 -1
 0 +1  0 +1
 0 -1 -1  0
 0 -1 +1  0
 0 +1 -1  0
 0 +1 +1  0
-1  0  0 -1
-1  0  0 +1
+1  0  0 -1
+1  0  0 +1
-1  0 -1  0
-1  0 +1  0
+1  0 -1  0
+1  0 +1  0
-1 -1  0  0
-1 +1  0  0
+1 -1  0  0
+1 +1  0  0

## 1 zero (32)

 0 -1 -1 -1
 0 -1 -1 +1
 0 -1 +1 -1
 0 -1 +1 +1
 0 +1 -1 -1
 0 +1 -1 +1
 0 +1 +1 -1
 0 +1 +1 +1
-1  0 -1 -1
-1  0 -1 +1
-1  0 +1 -1
-1  0 +1 +1
+1  0 -1 -1
+1  0 -1 +1
+1  0 +1 -1
+1  0 +1 +1
-1 -1  0 -1
-1 -1  0 +1
-1 +1  0 -1
-1 +1  0 +1
+1 -1  0 -1
+1 -1  0 +1
+1 +1  0 -1
+1 +1  0 +1
-1 -1 -1  0
-1 -1 +1  0
-1 +1 -1  0
-1 +1 +1  0
+1 -1 -1  0
+1 -1 +1  0
+1 +1 -1  0
+1 +1 +1  0

## 0 zeros (16) — vertices of the binary hypercube

-1 -1 -1 -1  identity
-1 -1 -1 +1  test
-1 -1 +1 -1  drain
-1 -1 +1 +1  take_while
-1 +1 -1 -1  call
-1 +1 -1 +1  maybe
-1 +1 +1 -1  fix
-1 +1 +1 +1  bind
+1 -1 -1 -1  read
+1 -1 -1 +1  filter
+1 -1 +1 -1  copy
+1 -1 +1 +1  scan
+1 +1 -1 -1  fold
+1 +1 -1 +1  map
+1 +1 +1 -1  foldl
+1 +1 +1 +1  hylo
