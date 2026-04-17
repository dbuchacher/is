# points — 81 integer lattice coords (shell 1)

All 81 = 3⁴ points of {-1, 0, +1}⁴. These are VALUES.
Observable states. Where things ARE.

  code: coord4 (int8_t) — storage, bins, field
  always: point → edge → point → edge → point (never skip the edge)

Grouped by zero-count. The f-vector of the 4D hypercube gives
the same counts (16+32+24+8+1=81) but these are all points in
the ternary lattice.

Higher shells (values ±2, ±3, ±4) are reached by applying
funcs (edges) repeatedly. Not new primitives. The coord value
IS the count of funcs applied.

## The Clifford grading

The lattice IS a **generalized Clifford algebra** — specifically
Cl_3(4), the 4-generator Clifford algebra at ω = primitive cube
root of unity, instead of the ordinary ω = -1. Yamazaki 1964,
Morris 1967 are the canonical refs. Standard (binary) Cl(4) has
dimension 2⁴ = 16; ours has 3⁴ = 81. Three values per axis instead
of two.

The "zero-count" groupings below ARE the Clifford grades. Grade
k = number of axes committed to a nonzero value, with 2^k sign
combinations at each grade (each axis can be ±1):

  grade 0  scalar        C(4,0)·2⁰ =  1 × 1  =  1    4 zeros
  grade 1  vectors       C(4,1)·2¹ =  4 × 2  =  8    3 zeros
  grade 2  bivectors     C(4,2)·2² =  6 × 4  = 24    2 zeros
  grade 3  trivectors    C(4,3)·2³ =  4 × 8  = 32    1 zero
  grade 4  pseudoscalar  C(4,4)·2⁴ =  1 × 16 = 16    0 zeros
                                                     ──
                                                     81 = 3⁴

The 24 "faces" ARE 24 bivectors. The 32 "cells" ARE 32 trivectors.
Naming the grades explicitly puts the framework in a named
mathematical category instead of a bespoke ternary lattice. When
a geometric-algebra/Hestenes-school interlocutor says "you're only
thinking geometrically, geometry is emergent from algebra," the
answer is: the lattice IS the algebra, and it's richer than
binary Cl(4) — ternary multiplicity at every grade.

## 4 zeros (1) — grade 0 / scalar / the container

 0  0  0  0  container / self / observer
               the origin. all 16 edges from origin land on the
               16 corners (one-to-one). see corners section below.

## 3 zeros (8) — grade 1 / vectors / the atoms

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

## 2 zeros (24) — grade 2 / bivectors

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

## 1 zero (32) — grade 3 / trivectors

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

## 0 zeros (16) — grade 4 / pseudoscalars / corners

The 16 all-nonzero points. Every axis committed to a direction.
These are the vertices of the binary hypercube sitting inside
the ternary lattice.

From origin, ALL 16 edges go outward, and all 16 land on the
16 corners one-to-one. So each corner can be labeled by the
edge that reaches it — a "self-operation" from origin.

Sign rule: + = that force engaged, - = force not engaged.
4 primary aux = the 4 single-force corners (one axis each).
BE = no force = identity. THINK = all forces = hylo.
Articles and quantifiers share corners with self-ops/modals.
Word type (verb vs article vs modal vs quantifier) = which edge.

Multiple vocabularies converge at each corner:

corner          hodos       lakoff              self-op      modal   article  quantifier
─────           ─────       ──────              ───────      ─────   ───────  ──────────
-1 -1 -1 -1     identity    IDENTITY            BE           BE      A/AN     NO NONE
-1 -1 -1 +1     test        LINK/MATCH                       WILL
-1 -1 +1 -1     drain       CYCLE                            MAY
-1 -1 +1 +1     take_while  SCALE                            MIGHT?
-1 +1 -1 -1     call        PATH                             HAVE
-1 +1 -1 +1     maybe       ENABLEMENT                       CAN
-1 +1 +1 -1     fix         ITERATION                        SHOULD?
-1 +1 +1 +1     bind        BALANCE             FEEL
+1 -1 -1 -1     read        FORCE                            DO
+1 -1 -1 +1     filter      CONTACT/BLOCKAGE    SEE HEAR     MUST
+1 -1 +1 -1     copy        FULL-EMPTY
+1 -1 +1 +1     scan        NEAR-FAR
+1 +1 -1 -1     fold        TRAVERSAL           KNOW
+1 +1 -1 +1     map         PART-WHOLE          UNDERSTAND
+1 +1 +1 -1     foldl       ACCUMULATION        REMEMBER
+1 +1 +1 +1     hylo        CONTAINER           THINK        THE      ALL EVERY

4 corners unmapped for modals. COULD/WOULD are tense variants
of CAN/MUST. OUGHT ≈ SHOULD. DARE, NEED, USED-TO = open.

The two poles of the main diagonal:
  (+,+,+,+) = THINK = THE = ALL = full engagement / recognition
  (-,-,-,-) = BE    = A   = NO  = zero engagement / existence

Five independent discoveries of the same 16-element structure:
  FP combinatory logic (Schönfinkel 1924)
  Lakoff image schemas (1987)
  English modals (grammaticalized over centuries)
  English articles (THE/A as recognition poles)
  English quantifiers (ALL/NO as totality poles)

The hodos names (identity/read/.../hylo) fundamentally describe
OPERATIONS (combinators / edge-types), not points. They appear
here because from origin there's a 1:1 mapping between each
edge-from-origin and the corner it lands on, so the corner
serves as a convenient index for the combinator. See `edges.md`
for the edges themselves.
