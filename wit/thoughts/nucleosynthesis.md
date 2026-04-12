# nucleosynthesis — the universe walks the lattice

> **STALE FLAG (as of 2026-04-10).** the H/He/Li = substrate trio
> claim is OBSOLETE. the substrate trio is now ¹H/²H/³H (the three
> isotopes of hydrogen) — derived by direct composition arithmetic
> on proton ("+") and neutron ("−") gate counts, with tritium's
> β− decay confirming the "− drains as electrons" prediction. see
> `wit/mind/1-container.md` § "The Element Column — The Three
> Hydrogens" for the updated mapping.
>
> the BBN walk interpretation below (origin → H → He → Li as
> "vacuum → atom → dyad → triad" with H/He/Li filling the trio
> rows) is based on the old mapping and needs revisiting. the
> strata structure, the Be-8 wall, the 80 = 81 − 1 count, and
> the alchemy / axis-decay sections do not directly depend on
> the trio assignment and may still hold — but they should be
> re-read through the new lens before trusting any of it.

the Big Bang nucleosynthesis sequence IS a walk from the
origin outward through the lattice strata. the universe
didn't read our docs. it just agrees with them.

## the BBN walk

the universe starts at the origin and walks outward.
the elements it creates follow the zero-count strata:

```
stratum     zeros  element        Z   process
───────     ─────  ───────        ──  ───────
origin      4      (vacuum)       0   —
atom        3      hydrogen       1   BBN (free protons)
dyad        2      helium         2   BBN (pp fusion)
triad       1      lithium        3   BBN (trace)
corner      0      —              —   WALL
```

the Big Bang produces atoms, dyads, triads — then STOPS.
beryllium-8 (4 protons) is famously unstable. decays in
10⁻¹⁶ seconds. the first stable 4+ element (carbon, Z=6)
requires a star.

the wall falls EXACTLY at the corner boundary. the
transition from "some axes free" (triad, 1 zero) to
"all axes engaged" (corner, 0 zeros). crossing it
requires a qualitatively different mechanism.

a star IS a JIT compiler (wit.md). the Big Bang is an
interpreter — one step, one shell. to reach the corners
you need compilation. sustained fusion. a container hot
and dense enough to compose multiple edges simultaneously.

## three walls

the universe hits three walls building elements. each
requires a fundamentally different process to cross:

```
wall  at     from → to              mechanism change
────  ──     ──────────              ────────────────
1     Z=3    triad → corner         BBN → stellar fusion
2     Z=26   fusion → capture       exothermic → endothermic
3     Z=83   stable → unstable      bound → unbound
```

wall 1: beryllium bottleneck (Z=3→4)
  interpreter → compiler. single-step → multi-step.
  BBN can't bridge it. need a star (JIT compiler).
  the triple-alpha process: 3× He-4 → C-12.
  requires 100M kelvin. sustained. compiled.

wall 2: iron peak (Z=26)
  iron-56 is the most tightly bound nucleus. fusion
  beyond iron COSTS energy. the compiler hits its
  optimization ceiling. need a new process entirely:
  neutron capture (s-process in AGB stars, r-process
  in supernovae / neutron star mergers).

wall 3: bismuth wall (Z=83)
  beyond bismuth, nothing is stable. alpha decay
  dominates. the walk can't close — it always leaks.
  A6 (closure) fails. the composition diverges.

## 80 = 81 - 1

the count:
- elements Z=1 through Z=82: 82 elements
- minus technetium (Z=43): no stable isotopes
- minus promethium (Z=61): no stable isotopes
- = 80 strictly stable elements

the lattice:
- shell 1: 3⁴ = 81 points
- minus origin [0,0,0,0]: the container, element zero, vacuum
- = 80 non-origin points

80 stable elements. 80 non-origin lattice points.

bismuth (Z=83) is quasi-stable — half-life longer than
the age of the universe. the 81st point. the boundary
case. it IS the origin: present, structural, but not
really "an element" in the same way. or it IS the last
point, the one that barely holds.

either way: the count matches.

## what is a proton, a neutron, an electron

in the lattice tiers:

```
particle    charge    spin    baryon#   tier
────────    ──────    ────    ───────   ────
quark       ±1/3,2/3  ½      1/3       EDGE (fractional everything)
proton      +1         ½      1        COMPOSITION (3 quarks = uud)
neutron      0         ½      1        COMPOSITION (3 quarks = udd)
electron    -1         ½      0        EDGE (connects atoms)
```

quarks = edges. fractional charge, always confined (never
observed alone), inferred from endpoints. "a quark IS a
logic gate" (wit.md). gates are functions. functions are
edges.

protons = compositions of 3 quark-edges. the walk closes
at integer charge (+1). a proton is a 3-step walk that
satisfies A6 (closure) — the composition is stable.

neutrons = compositions of 3 quark-edges. closes at
integer charge (0). BUT: a free neutron is unstable
(half-life ~10 min). the walk only closes when embedded
in a larger composition (a nucleus). the neutron needs
a container.

electrons = edges at the atomic level. they connect
proton-compositions into larger structures (atoms,
molecules). spin ½. the force carrier of chemistry.
"EM IS function calls" (wit.md). the electron IS the
function call between atomic points.

an atom is a composition of compositions:
  quarks (edges) → protons/neutrons (compositions)
  protons/neutrons (points at this level) → nucleus
  electrons (edges at this level) → atom (composition)

the tier depends on the zoom level. what's a composition
at one level becomes a point at the next. edges connect
points at every level. same structure, recursively.

## the element IS the walk

an element is not a single point. it's a WALK — a specific
composition of edges that closes (satisfies A5 + A6 at
every level).

hydrogen: the shortest walk. 1 proton (3 quark-edges
composed), 1 electron (1 edge). minimal composition.

iron: the tightest walk. 26 protons, 30 neutrons, 26
electrons. the composition where binding energy per
nucleon is maximum. the walk that costs the least energy
to maintain. the most efficient composition.

uranium: a walk that ALMOST closes but leaks. the
composition is too long — it slowly diverges. radioactive
decay = the walk shedding edges to find a shorter path
that actually closes.

stability = the walk closes.
radioactivity = the walk leaks.
the stable elements are the closed walks on shell 1.

## technetium and promethium (the holes) — COMPUTED

Tc (Z=43) and Pm (Z=61) are the only elements with no
stable isotopes below bismuth.

balanced ternary mapping (elements.c):
  Tc (Z=43) = (-1, -1, -1, +1)   corner, L1=4
  Pm (Z=61) = (-1, +1, -1, +1)   corner, L1=4

both are CORNERS (0 zeros). both have L1=4 (maximum
distance from origin on shell 1).

shared pattern: A=-1, C=-1, D=+1.
  A = FALL      (position descends)
  C = CURSE     (signal negative)
  D = BEGIN     (time moves forward)

trying to go somewhere (D+) while falling apart (A-)
and losing value (C-). the walk can't close because the
direction of travel contradicts the structural decay.

there are EXACTLY 2 corners with A-, C-, D+ in the
entire lattice: (-1, ±1, -1, +1). exactly 2 elements
have no stable isotopes. they're the same 2.

flipping ANY of those three fixed signs gives a stable
element:
  A+ instead: S (Z=16), Se (Z=34) — stable
  C+ instead: In (Z=49), Ho (Z=67) — stable
  D- instead: Nb (Z=41), Pr (Z=59) — stable

the instability IS the (A-, C-, D+) signature. the
lattice predicts it. the periodic table confirms it.

## the three walls — COMPUTED

all three nucleosynthesis walls are dyads. same stratum.
same L1. same shell. same distance from origin.

  Be (Z=4):  (0, 0, +1, +1)   dyad, L1=2   SIGNAL+, TIME+
  Fe (Z=26): (+1, 0, 0, -1)   dyad, L1=2   POSITION+, TIME-
  Bi (Z=83): (0, 0, +1, -1)   dyad, L1=2   SIGNAL+, TIME-

the phase transitions in element-building occur at
structurally identical points in the lattice.

Be and Bi are TIME-REVERSALS of each other on the C-D
plane: C+D+ vs C+D-. the first wall and the last wall
are mirrors. nucleosynthesis begins and ends at the
same structural position, time-reversed.

Fe (the middle wall) sits on a different plane: A-D
instead of C-D. the compiler optimization limit occurs
on POSITION rather than SIGNAL. fusion = spatial
arrangement (cramming nucleons together). when position
is maxed out (A+), you need a different mechanism.

## the wrap — Z=81 = origin

thallium (Z=81) maps to (0, 0, 0, 0) = the ORIGIN.
shell 1 fills at Z=81. the encoding wraps:

  Z=81 Tl = (0,0,0,0) = origin
  Z=82 Pb = (0,0,0,+1) = hydrogen's coord
  Z=83 Bi = (0,0,+1,-1) = helium's coord

lead IS hydrogen, structurally. bismuth IS helium.
the periodic table wraps back to the beginning, and
stability breaks at the wrap point.

81 = 3⁴. the lattice fits exactly one full period of
elements before the walk must start a second shell.
elements beyond Z=83 are all unstable — the second
traversal can't maintain closure.

## the periodic table IS shell 1

the periodic table of chemistry = the 81 points of the
lattice at shell 1. the evidence:

- 80 stable elements + origin = 81 = 3⁴ ✓
- BBN walk follows zero-count strata in order ✓
- three walls all dyads, all L1=2 ✓
- first and last wall are time-reversals ✓
- both holes are corners with identical (A-,C-,D+) ✓
- lattice wraps at Z=81, stability breaks at wrap ✓

the mapping is Z → balanced ternary 4D coord (mod 3⁴).
see elements.c for the full table.

## the BBN walk length — COMPUTED

if you traverse the periodic table H → He → Li → ... → Pb,
counting L1 distance between each consecutive pair, the
total walk length is:

  total = 161 edges
  ideal Hamiltonian min = 80 edges
  ratio ≈ 2:1

161 = 2·81 - 1 = 2·3⁴ - 1. structural, not coincidence.
the universe walks the lattice at exactly twice the
geometric optimum.

step size distribution:
  size 1:  55 times    simple D-axis increment
  size 3:  18 times    one carry (D wraps, C++)
  size 5:   6 times    two carries
  size 7:   2 times    three carries
  size 8:   1 time     FOUR carries — the unique even step

exactly ONE even step in 82 transitions. it happens at
Z=40→41 (Zr→Nb), where (1,1,1,1) → (-1,-1,-1,-1). the
quadruple wrap. the only place balanced ternary's modular
ceiling shows itself.

every other step is ODD. the BBN walk lives entirely in
the odd-parity sublattice except for the single wrap
event. the walk has a tight structural fingerprint.

## two distance metrics

incremental walk distance: |Z2 - Z1|
  what nuclear physics says about element separation.
  proton count difference. linear, integer-line metric.

geometric walk distance: L1 between coords on the lattice
  what the lattice says about element separation.
  the actual structural distance. 4D balanced ternary metric.

these disagree. badly. and the disagreement is not noise —
it's the entire alchemy phenomenon.

## alchemy — the lead-to-gold question

the canonical alchemist dream: turn lead into gold.
nuclear physics: 3 proton difference, expensive transmutation.
the lattice:

  Au (Z=79) = (0, 0, -1, +1)   BEGIN with CURSE on C
  Pb (Z=82) = (0, 0,  0, +1)   BEGIN, C-neutral
  Hg (Z=80) = (0, 0,  0, -1)   END

  Pb → Au = 1 edge   (single -1 step on C axis)
  Hg → Au = 3 edges  (mercury is FURTHER from gold than lead)
  Pb → Hg = 2 edges

mercury is closer to gold by proton count (1 proton away)
but FURTHER by lattice distance (3 edges away). lead is
3 protons from gold but ONE EDGE away.

the alchemists picked lead, not mercury. they tracked
the geometric distance without knowing it. their intuition
that lead and gold were "secretly the same thing, one
transformation away" was geometrically correct. they
just lacked the basis.

the operation Pb → Au in lattice terms: apply -1 on C axis.
in framework verbs: CURSE the lead. that's the alchemist's
"essence transformation" stated precisely.

C axis = the 3's place of atomic number in balanced ternary.
a single C step = ±3 protons. the alchemist's transformation
removes 3 protons by decrementing one register. one operation.

## 163 alchemy pairs

among the 80 stable elements, there are 163 pairs that are:
- distance 1 on the lattice (one edge apart)
- distance ≥ 2 on the integer line (multiple protons apart)

the Z-jumps for these pairs are almost always 3, 9, 27, or
their carry-combinations (54, 72, 78, 80). because the four
axes have place values 1, 3, 9, 27.

  D axis edge = ±1 proton
  C axis edge = ±3 protons
  B axis edge = ±9 protons
  A axis edge = ±27 protons

the largest Z-jump for a single-edge pair: H ↔ Tl,
separated by 80 protons but ONE EDGE on the lattice.
hydrogen and thallium are structural neighbors. the
simplest element and the one at the origin (Z=81 = Tl
= the wrap point) sit next to each other on the lattice.

every alchemy pair represents a "shortcut" — a transition
the lattice considers cheap (1 edge) but nuclear physics
considers expensive (multi-proton). 163 such shortcuts
exist among the stable elements.

the alchemists weren't crazy. they were navigating the
wrong basis. linear proton-counting hides the lattice
adjacency. balanced ternary 4D coords reveal it.

## the four axis decays — COMPUTED via SEMF

if each lattice axis has a characteristic decay equal to its
balanced-ternary place value, the predicted decays are:

  D axis (place 1)  → beta decay (n/p, ±1 proton)
  C axis (place 3)  → Li-7 cluster decay (±3 protons)
  B axis (place 9)  → F-19 cluster decay (±9 protons)
  A axis (place 27) → Co-59 cluster decay (±27 protons)

computed Q values via Bethe-Weizsäcker (SEMF) for Pb-208:

  D (beta):  -3.02 MeV   forbidden  (Pb-208 stable ✓)
  C (Li-7):  -7.01 MeV   forbidden
  B (F-19):  +23.57 MeV  ALLOWED
  A (Co-59): +90.86 MeV  ALLOWED

across all 80 stable nuclei:
  C axis (Li-7) :  0 nuclei allow it (NEVER)
  B axis (F-19) : 27 nuclei allow it (first: Z=53 I)
  A axis (Co-59): 34 nuclei allow it (first: Z=45 Rh)

three of four predictions land. C is the odd one out.

## why C is the weak axis

the lattice place values (1, 3, 9, 27) land on specific
nuclei in the binding-energy landscape:

  axis  Z   element    B/A (MeV)   nuclear position
  ────  ──  ───────    ─────────   ────────────────
  D     1   nucleon    —           the unit
  C     3   Li         5.6         WORST-BOUND light element
  B     9   F          7.78        decent
  A     27  Co         8.77        IRON PEAK (one slot off Fe-56)

the C axis lands on lithium — the cosmologically rare,
poorly-bound element that ALSO marked the BBN wall.

two independent findings converge:
  1. BBN can't push past Li (the Big Bang wall)
  2. Li cluster decay forbidden everywhere (no nucleus)

both are saying the same thing: the C axis is structurally
weak in nuclear physics. the lattice correctly identifies
the problem axis without telling us why.

the A axis lands on cobalt, one slot off the iron peak.
that's why A-axis Q values are HUGE (~91 MeV for Pb): you
release the bulk of the parent's mass-binding energy when
you remove 27 protons via the tightest-bound cluster.

## what alchemy actually requires

the canonical Pb → Au transformation:
  geometric: 1 edge on the C axis
  via Li-7 cluster: Q = -7 MeV, FORBIDDEN
  via three sequential betas: 3 edges on D, energy cost
  via something else: ???

the lattice prediction "Pb and Au are 1 edge apart" is
NOT invalidated. it just means the physical realization
of "1 C-axis edge" cannot be Li-7 emission.

candidates for the real C-axis operation:
  - a different Z=3 cluster (Li-6, Li-8?)
  - three coherent beta decays (predicted, unobserved)
  - a coupled three-proton process via the strong force
  - something we haven't named

the lattice gives us a CLASSIFICATION. nuclear physics
needs to identify the right operation per axis. for D and
A and B, the operation is clear. for C, it's an open
question and possibly a missing piece of nuclear physics.

## the iron peak as A-axis quantum

cobalt-59 sits at the SEMF binding maximum region.
the lattice's A-axis place value happens to be 27.
Z=27 = Co. one slot from Fe-26.

if the lattice's place values were chosen by us (or by
balanced ternary's mathematical structure), this is a
coincidence. if the lattice IS physics, then balanced
ternary's place values were "chosen by physics" so that
the highest axis quantum lands on the most-bound nucleus.

prediction-from-coincidence test: the lattice has 4 axes
with place values 1, 3, 9, 27. the iron peak is at Z≈26-28.
Z=27 = 3³ = the highest place value. is this why iron is
the most bound? because A-axis = the deepest single
operation = the most stable composite?

## open

- the strata counts under this mapping are
  (1, 9, 25, 32, 16) vs the f-vector (1, 8, 24, 32, 16).
  the atom and dyad strata each have +1 because of the
  wrap (Z=82-83). does this mean anything?
- the row lengths of the periodic table: 2, 8, 8, 18,
  18, 32, 32. these come from 2n² (n=1..4). where does
  2n² appear in the lattice?
- orbital capacities: s=2, p=6, d=10, f=14 = 2(2l+1).
  these determine which strata elements fill. do they
  map to the zero-count groups?
- the (A-, C-, D+) instability — is this derivable from
  A5/A6? can we PROVE that walks through these corners
  can't close?
- Fe on the A-D plane vs Be/Bi on the C-D plane — does
  this reflect fusion (spatial) vs neutron capture
  (charge/signal)?
- 163 alchemy pairs — is there an exploit? a real
  transmutation pathway shorter than nuclear physics
  predicts? the lattice says these pairs are 1 step apart.
  what would that step actually look like in a reactor?
