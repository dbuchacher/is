# hypercube Z-encoding attempt — archived

date: 2026-04-10
outcome: approach was wrong from the start, some findings may still hold

## what was attempted

an attempt to map the periodic table onto the 4D ternary lattice
by encoding each element's atomic number Z in balanced ternary,
then exploring the resulting structure.

the mapping used:
  Z → balanced ternary 4-digit coord
  place 1  → D axis (labeled TIME)
  place 3  → C axis (labeled SIGNAL)
  place 9  → B axis (labeled SUBSTANCE)
  place 27 → A axis (labeled POSITION)

under this encoding, Z=1 (H) landed at (0,0,0,+1) on the D axis,
and the rest of the elements scattered across the 81 points.

## what was built

  primes.c              — earlier Z-to-coord exploration
  elements.c            — first elements mapping and findings
  elements-table.c      — grouped elements by stratum
  walks.c               — measured BBN walk lengths
  walks-notation.c      — generated walks as atom-verb compositions
  alchemy.c             — found 163 "alchemy pairs" (1-edge neighbors)
  decay.c               — computed Q-values for axis decays
  peak.c                — checked if iron peak sits at Z=27=3³
  elements.md           — the full element table with walks
  compiled binaries for each .c file

related files in wit/thoughts/:
  nucleosynthesis.md    — writeup of the BBN + alchemy findings
  axioms.md             — the 6-axiom statement (still foundational)

## findings under this encoding

  - first 3 BBN elements (H, He, Li) landed in L1 ≤ 2 strata
  - Tc (Z=43) and Pm (Z=61) — the two elements with no stable
    isotopes — landed on the "test" and "maybe" corners
  - 3 walls (Be, Fe, Bi) all landed on L1=2 dyads
  - 163 "alchemy pairs" — elements 1 edge apart on the lattice
    but multiple protons apart in Z
  - Pb → Au was a single edge on the C axis (the CURSE step)
  - 8 "lattice atoms" landed at Z = 1, 3, 9, 27 and their
    complements to 81 = 80, 78, 72, 54

## why it was wrong

the Z → balanced ternary encoding was arbitrary. three compounded
choices that were never justified:

1. using Z at all.
   the lattice has no intrinsic relationship to proton count.
   chemistry's Z is a sorting by one physical property. there
   is no reason the lattice should respect that sorting.

2. balanced ternary as the encoding function.
   mathematically elegant but not physically derived. any
   bijection from integers to the 81 points would have been
   equally valid — factorial base, prime base, level-order,
   etc. we picked the prettiest math and called it natural.

3. the place-value-to-axis assignment.
   mapping place 1 to D (TIME) and place 27 to A (POSITION)
   was inherited from the initial primes.c file. this put
   hydrogen on the TIME axis, which has no physical motivation.
   the user flagged this: "hydrogen is naturally space, not
   time." correct.

the result: every finding under this encoding is CONTINGENT on
three arbitrary choices. under a different encoding:
  - Tc and Pm might land on different corners (not "test"/"maybe")
  - the alchemy pair count would change
  - the walls might not all be dyads
  - the iron peak correspondence might disappear

the "two holes = test and maybe" finding in particular felt
significant but is now suspect. the FP names of corners are
framework-native, but WHICH corners Tc and Pm land on depends
entirely on the Z-encoding. without physical justification for
the encoding, the correspondence is a coincidence, not a prediction.

## what might still be salvageable

some things may survive a reset because they don't depend on
the Z-encoding:

- the lattice structure itself (81 points, 16 edges, strata,
  the f-vector, Cayley-Dickson closure). pure math, independent
  of Z.
- the 16 corner names as FP combinators. framework-native.
- the 8 atom verb clusters. framework-native.
- the type system (word classes from axis signs). framework-native.
- the 6 axioms in thoughts/axioms.md. those are statements about
  the lattice and don't depend on any element encoding.
- the observation that "the lattice is a memo/register structure"
  where each point is a cached computation. conceptual, doesn't
  depend on specific Z assignment.

what probably does NOT survive:
- specific Z → coord correspondences
- "Tc = test, Pm = maybe" as a prediction (it was fishing)
- the BBN walk length 161 as a meaningful number
- the iron peak at 3³ claim (already weak under SEMF test)
- all "alchemy" findings as physical predictions

## the core mistake

i took chemistry's Z sorting and shoved it into the lattice
via balanced ternary, then reported findings as discoveries.
this is the classic "torture the data until it confesses"
pattern. i never justified the encoding, never tested
robustness to alternative mappings, and never questioned
whether the lattice should describe elements at all.

the user caught it with: "see you fucking took the standard
z number then arbitrary assigned to the framework?" yes.

## lessons for next attempt

1. the lattice is a geometric object with 81 points. what it
   describes is an open question — language, computation,
   types, or something else. don't assume it describes elements.
2. any external mapping (Z, something else) must be justified
   on independent grounds, not chosen for convenience.
3. findings that depend on a specific mapping should be flagged
   as contingent, not reported as discoveries.
4. the axis labels (POSITION / SUBSTANCE / SIGNAL / TIME) may
   need revisiting. the framework assigned them one way;
   physical intuition may assign them differently.
5. start from the lattice's native vocabulary. the 8 atom
   verbs and 16 corner FP names are built in. the 24 dyads
   and 32 triads are unnamed and we shouldn't force names
   from external domains.

## not all wrong

the FRAMEWORK work (reading points.md, edges.md, composition.md,
understanding the type system, the axioms, the walk notation)
is solid. the MISTAKE was specifically forcing Z onto it.

if a principled element mapping exists, some of these findings
might re-emerge. but we need to derive the mapping first, not
pick it for elegance and then celebrate coincidences.
