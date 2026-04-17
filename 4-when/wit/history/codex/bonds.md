# bonds — 32 spin-layer coordinates

A bond is a spin state — the wave drawing the sine curve between
integer shells. Each bond has all 4 axes at half-integer values
(±½ or ±3/2). No zeros — a zero axis isn't spinning, it's a point.

Bonds live at the SPIN LAYER, not the integer lattice. Integer
coords are states (where things ARE). Spin coords are bonds
(how things MOVE). Same 4 axes, different layer.

Each spin shell has 2⁴ = 16 bonds (each axis independently ±).
The first two spin shells give the 32 stable bonds:

```
  spin shell 1:  ±½    16 bonds   wave between origin and integer shell 1
  spin shell 2:  ±3/2  16 bonds   wave between integer shells 1 and 2
                        ──
                        32 bonds
```

The sign pattern (which axes spin forward, which backward) is
the same 16 patterns at every shell. The shell number is what
doubles 16 → 32.

## Axis key

```
  A = POSITION   (strong / READ)
  B = SUBSTANCE  (EM / CALL)
  C = SIGNAL     (gravity / CYCLE)
  D = TIME       (weak / TEST)
```

## The 32 bonds

### Spin shell 1 — ±½ (wave between origin and integer shell 1)

```
   #   ( A,    B,    C,    D  )
  ──   ─────────────────────────
   1   (+½,  +½,  +½,  +½)       all forward
   2   (+½,  +½,  +½,  -½)
   3   (+½,  +½,  -½,  +½)
   4   (+½,  +½,  -½,  -½)
   5   (+½,  -½,  +½,  +½)
   6   (+½,  -½,  +½,  -½)
   7   (+½,  -½,  -½,  +½)
   8   (+½,  -½,  -½,  -½)
   9   (-½,  +½,  +½,  +½)
  10   (-½,  +½,  +½,  -½)
  11   (-½,  +½,  -½,  +½)
  12   (-½,  +½,  -½,  -½)
  13   (-½,  -½,  +½,  +½)
  14   (-½,  -½,  +½,  -½)
  15   (-½,  -½,  -½,  +½)
  16   (-½,  -½,  -½,  -½)       all backward
```

### Spin shell 2 — ±3/2 (wave between integer shells 1 and 2)

```
   #   ( A,    B,    C,    D  )
  ──   ─────────────────────────
  17   (+3/2, +3/2, +3/2, +3/2)  all forward
  18   (+3/2, +3/2, +3/2, -3/2)
  19   (+3/2, +3/2, -3/2, +3/2)
  20   (+3/2, +3/2, -3/2, -3/2)
  21   (+3/2, -3/2, +3/2, +3/2)
  22   (+3/2, -3/2, +3/2, -3/2)
  23   (+3/2, -3/2, -3/2, +3/2)
  24   (+3/2, -3/2, -3/2, -3/2)
  25   (-3/2, +3/2, +3/2, +3/2)
  26   (-3/2, +3/2, +3/2, -3/2)
  27   (-3/2, +3/2, -3/2, +3/2)
  28   (-3/2, +3/2, -3/2, -3/2)
  29   (-3/2, -3/2, +3/2, +3/2)
  30   (-3/2, -3/2, +3/2, -3/2)
  31   (-3/2, -3/2, -3/2, +3/2)
  32   (-3/2, -3/2, -3/2, -3/2)  all backward
```

## Structure

Each shell is a 4D binary hypercube: 4 axes × 2 signs = 2⁴ = 16
vertices. The sign pattern tells you which axes spin forward (+)
and which backward (-). The SAME 16 sign patterns repeat at every
shell — only the radius (½ vs 3/2 vs 5/2 vs 7/2) changes.

The 16 sign patterns correspond to the 16 force-subset patterns
from VoE/hodos.c (which forces are engaged, ignoring shell):

```
  sign pattern     hodos    forces          name
  ────────────     ─────    ──────          ────
  (-,-,-,-)         0       (none)          identity / wave
  (+,-,-,-)         1       P               read
  (-,+,-,-)         2       C               call
  (+,+,-,-)         3       PC              fold
  (-,-,+,-)         4       R               drain / advance
  (+,-,+,-)         5       PR              copy / slurp
  (-,+,+,-)         6       CR              fix
  (+,+,+,-)         7       PCR             foldl
  (-,-,-,+)         8       W               test
  (+,-,-,+)         9       PW              filter
  (-,+,-,+)        10       CW              maybe
  (+,+,-,+)        11       PCW             map
  (-,-,+,+)        12       RW              take_while
  (+,-,+,+)        13       PRW             scan
  (-,+,+,+)        14       CRW             bind
  (+,+,+,+)        15       PCRW            hylo
```

Each hodos pattern appears TWICE in the 32: once at shell 1 (±½)
and once at shell 2 (±3/2). Same operation, different scale.

## Layers

```
  integer layer            spin layer
  ─────────────            ──────────
  points (states)          bonds (transitions)
  {-1, 0, +1}⁴ = 81       shell 1: {-½, +½}⁴ = 16
                           shell 2: {-3/2, +3/2}⁴ = 16
                           total stable: 32
```

Points and bonds are DIFFERENT layers of the same 4-axis
structure. Points are where things ARE. Bonds are how things
MOVE — the wave drawing the sine curve between integer states.

The integer layer has shells too (shell 1 = 81, through shell 4 =
6,561 stable points). Each pair of adjacent integer shells has a
spin shell between them:

```
  integer shell 0 (origin)
       spin shell 1 (±½)         ← 16 bonds
  integer shell 1 (±1, 81 pts)
       spin shell 2 (±3/2)       ← 16 bonds
  integer shell 2 (±2, 544 new)
       spin shell 3 (±5/2)       ← 16 bonds (less stable)
  integer shell 3 (±3)
       spin shell 4 (±7/2)       ← 16 bonds (least stable)
  integer shell 4 (±4, ceiling)
```

Spin shells 1-2 are the stable working set (32 bonds).
Spin shells 3-4 exist but decay (same 19% heartbeat as
integer shells beyond 4 — see 2-path.md).

## The n't hypothesis (OPEN)

The doubling from 16 to 32 may be the n't operator: same sign
pattern at a different shell. Negation = scale change, not sign
flip. CAN (±½, close to ground) → CAN'T (±3/2, one shell out).
Denial pushes the bond further from center.

If true:
- Shell 1 bonds = affirmative modals (CAN, WILL, MUST, DO, ...)
- Shell 2 bonds = negative modals (CAN'T, WON'T, MUSTN'T, DON'T, ...)
- The 16 modal bases map to the 16 sign patterns
- Negation is DISTANCE, not reversal

This is a hypothesis, not derived. The modal-to-sign-pattern
mapping is open work.

═══════════════════════════════════════════════════════════════

## Prior framing: 32 hypercube edges = 32 compass bearings

The earlier framing described bonds as edges of the binary
hypercube {-1, +1}⁴ — transitions between corner vertices. This
is the INTEGER-LAYER SHADOW of the spin-layer bond: what the spin
state looks like when projected onto the integer lattice.

```
  old (integer shadow):   flip_A(B+, C+, D+)
  new (spin coord):       (+½, +½, +½, +½)     [shell 1, bond #1]
```

The old notation is still valid as a derived view but the bond
IS the spin coordinate, not the integer transition. The compass
mapping below uses the integer-shadow notation.

### Compass structure

```
  4 flip-axis choices  ×  8 lock patterns  =  32 bonds
  16 corner atoms  ×  4 neighbors / 2  =  32 edges  (same count)
  32 mariner's compass bearings  =  32 bonds  (same alphabet, projected)
```

Each bond is parameterized by:
1. **Which axis flips** (the X being solved for) — 4 choices
2. **The lock pattern** of the other 3 axes (each at + or -) — 8 patterns

The compass and the hypercube share the **4 × 8 = 32** structure. Both
are 4 anchors with 8 sub-divisions each.

### Compass correspondence

```
  compass level    count    framework
  ─────────────    ─────    ─────────
  cardinals          4      4 axes
  8-winds            8      8 atoms (integer layer)
  16 quarters       16      16 sign patterns (one shell)
  32 by-points      32      32 bonds (two shells)
```

## Multiple valid counts of bonds

The framework supports several valid enumerations of bonds at different
abstraction levels. They're all real, they all count related-but-different
structures, and they don't contradict each other.

```
  count   structure                                           source
  ─────   ─────────                                           ──────
   16     force subsets (which forces engage, ignoring         VoE/hodos
          direction). 2^4 = 16 patterns including identity.    lattice-ref.md
                                                               hodos.c bond table

   32     two spin shells × 16 sign patterns.                  this file (current)
          shell 1 (±½) + shell 2 (±3/2) = 32.

   32     hypercube edges (corner-to-corner 1-axis flips).     this file (prior framing)
          4 axes × 8 lock patterns of the other 3 = 32.

   32     16 force-subset patterns × 2 main directions         derived
          (consume/produce, forward/backward, n't pair).
          This is one way to recover 32 from VoE's 16.

   81     full shell-1 directional enumeration. Each force     substrate
          can be -1, 0, or +1. 3^4 = 81. Same as the count     (3-force.md)
          of shell-1 atoms.
```

The framework picks different counts at different abstraction levels.
Working evidence:
- VoE/hodos.c implements **16 force-subset patterns** numbered 0-15 by 4-bit
  encoding (bit 0 = π, bit 1 = ∘, bit 2 = ∮, bit 3 = δ). Each pattern has
  multiple directional byte variants (e.g., `π` = 0x40, `π̄` = 0xC0).
- This file uses **32 spin-layer bonds** as the primary count (2 shells × 16).

These are the same lattice — just counted differently. See
`wit/codex/combinators.md` for the broader meta-rule about which bonds
get named in literature vs which get dropped.

## VoE/hodos.c 16-pattern enumeration

For reference (from `lattice-ref.md` and the bond table in `hodos.c`):

```
  pattern   forces        common name        force formula
  ───────   ──────        ───────────        ─────────────
   0        (none)        identity / wave    -
   1        π             read               +P
   2        ∘             call               +C
   3        π∘            fold               +P+C
   4        ∮             advance / drain    +R
   5        π∮            copy / slurp       +P+R
   6        ∘∮            fix                +C+R
   7        π∘∮           foldl              +P+C+R
   8        δ             test               +W
   9        πδ            filter             +P+W
  10        ∘δ            maybe              +C+W
  11        π∘δ           map                +P+C+W
  12        ∮δ            take_while         +R+W
  13        π∮δ           scan               +P+R+W
  14        ∘∮δ           bind               +C+R+W
  15        π∘∮δ          hylo               +P+C+R+W
```

**16 force-subset patterns**, each named in the FP literature (or os-lattice).
This is the most fundamental count — it ignores direction entirely and just
asks "which forces are engaged."

To get to 32, multiply each by shell (shell 1 at ±½, shell 2 at ±3/2).
The 16 shell-2 versions are partially named in the literature:

```
  forward       backward        named?
  ───────       ─────────       ──────
  fold (π∘)     unfold (π̄∘̄)    yes — anamorphism, ana
  filter (πδ)   ???             no — "select-out" has no name
  map (π∘δ)     contramap       yes — but contravariant functor
  bind (∘∮δ)    extend          yes — comonad operation
  hylo          meta            yes — both named (Yang/Wu)
  read (π)      write (π̄)       yes — both have separate names
  call (∘)      return (∘̄)      yes — both have separate names
  drain (∮)     repeat (∮̄)      yes — both have separate names
  test (δ)      guard (δ̄)       yes — both have separate names
```

**Some shell-2 bonds are named, some aren't.** Where they're not named,
they're "trivial-not-write" cases — like "don't filter" in programming,
where not filtering is just no code, no operation, no name needed. The
literature drops these for the same meta-rule that drops W: they're too
trivial to lexicalize.

This dovetails with `combinators.md` finding: working programmers and
mathematicians lexicalize the typed and non-trivial; they drop trivial
inlinables and degenerate cases.

## Open: which 16 backward bonds are missing and why

If the framework's 32 = 16 shell-1 + 16 shell-2, and only ~10 shell-2
bonds are named in the literature, then ~6 shell-2 bonds should be
"missing for the meta-rule reasons":

```
  forward bond              backward analog        named?
  ────────────              ───────────────        ──────
  fold (read+call)          unfold                 ✓
  filter (read+test)        ???                    ✗   (no useful "anti-filter")
  map (read+call+test)      contramap              ✓
  scan (read+iter+test)     ???                    ✗
  foldl (read+call+iter)    paramorphism / unfoldr ~  (sort of)
  bind (call+iter+test)     extend                 ✓
  maybe (call+test)         either / branch        ✓ish
  fix (call+iter)           ???                    ✗
  slurp (read+iter)         fill / spew            ~
  take_while (iter+test)    ???                    ✗
  hylo (all four)           meta                   ✓
```

The unnamed ones (anti-filter, anti-scan, anti-fix, anti-takewhile) are
candidates for "the framework predicts these but no programming language
names it because they're too trivial / not useful." Same reasoning as
W in Haskell.

This is **suggestive, not derived**. To verify, we'd need to check whether
those 4-6 missing-name slots correspond to specific structural positions
in the spin-shell-2 enumeration.

**Combinators** is the FP/computing umbrella for the bond layer (Schönfinkel
1920s, Curry 1930s — combinatory logic). Each bond IS a combinator: a typed
operator that combines two atoms into a third. Map/filter/fold are higher-level
combinators (sequences/pipelines of basic ones) — they live at the walk level.

Each bond has names across many vocabularies — physics, chemistry, music, math,
computing, language — because they're all the same alphabet under different
projection. The `vocab:?` slot is a placeholder for any/all of these.

## Open: same name at multiple levels

A name like "read" might apply to multiple distinct bonds at different scales:
- read = strong-force MOV (gluon-mediated, CPU level)
- read = a person consuming a photon (EM-force, perceptual level)
- read = a mind processing a thought (higher level)

Same word, three different bonds. We'll cross that bridge when we get there —
for now, just note that vocabulary-to-bond mapping isn't 1-to-1 across scales.

## The 32 in compass notation (prior framing, still valid as projection)

```rust
match bond {

    // ── flip axis A (POSITION / strong / P)  —  N region of compass ──

    N      => flip_A(B+, C+, D+),  //   0.00°  locks +++  vocab:?
    NbE    => flip_A(B+, C+, D-),  //  11.25°  locks ++-  vocab:?
    NNE    => flip_A(B+, C-, D+),  //  22.50°  locks +-+  vocab:?
    NEbN   => flip_A(B+, C-, D-),  //  33.75°  locks +--  vocab:?
    NE     => flip_A(B-, C+, D+),  //  45.00°  locks -++  vocab:?
    NEbE   => flip_A(B-, C+, D-),  //  56.25°  locks -+-  vocab:?
    ENE    => flip_A(B-, C-, D+),  //  67.50°  locks --+  vocab:?
    EbN    => flip_A(B-, C-, D-),  //  78.75°  locks ---  vocab:?

    // ── flip axis B (SUBSTANCE / EM / C)  —  E region of compass ──

    E      => flip_B(A+, C+, D+),  //  90.00°  locks +++  vocab:?
    EbS    => flip_B(A+, C+, D-),  // 101.25°  locks ++-  vocab:?
    ESE    => flip_B(A+, C-, D+),  // 112.50°  locks +-+  vocab:?
    SEbE   => flip_B(A+, C-, D-),  // 123.75°  locks +--  vocab:?
    SE     => flip_B(A-, C+, D+),  // 135.00°  locks -++  vocab:?
    SEbS   => flip_B(A-, C+, D-),  // 146.25°  locks -+-  vocab:?
    SSE    => flip_B(A-, C-, D+),  // 157.50°  locks --+  vocab:?
    SbE    => flip_B(A-, C-, D-),  // 168.75°  locks ---  vocab:?

    // ── flip axis C (SIGNAL / gravity / R)  —  S region of compass ──

    S      => flip_C(A+, B+, D+),  // 180.00°  locks +++  vocab:?
    SbW    => flip_C(A+, B+, D-),  // 191.25°  locks ++-  vocab:?
    SSW    => flip_C(A+, B-, D+),  // 202.50°  locks +-+  vocab:?
    SWbS   => flip_C(A+, B-, D-),  // 213.75°  locks +--  vocab:?
    SW     => flip_C(A-, B+, D+),  // 225.00°  locks -++  vocab:?
    SWbW   => flip_C(A-, B+, D-),  // 236.25°  locks -+-  vocab:?
    WSW    => flip_C(A-, B-, D+),  // 247.50°  locks --+  vocab:?
    WbS    => flip_C(A-, B-, D-),  // 258.75°  locks ---  vocab:?

    // ── flip axis D (TIME / weak / W)  —  W region of compass ──

    W      => flip_D(A+, B+, C+),  // 270.00°  locks +++  vocab:?
    WbN    => flip_D(A+, B+, C-),  // 281.25°  locks ++-  vocab:?
    WNW    => flip_D(A+, B-, C+),  // 292.50°  locks +-+  vocab:?
    NWbW   => flip_D(A+, B-, C-),  // 303.75°  locks +--  vocab:?
    NW     => flip_D(A-, B+, C+),  // 315.00°  locks -++  vocab:?
    NWbN   => flip_D(A-, B+, C-),  // 326.25°  locks -+-  vocab:?
    NNW    => flip_D(A-, B-, C+),  // 337.50°  locks --+  vocab:?
    NbW    => flip_D(A-, B-, C-),  // 348.75°  locks ---  vocab:?
}
```

## The 32 English modal pairs (parallel naming)

A second valid 32-element framing: 16 modal/aux base operators, each with
a positive form and an n't form. This is the **English grammatical layer**
of the same alphabet — different vocabulary, same 32 slots.

```rust
match modal_bond {

    // is / isn't — copular bind / identity
    Is       => bind(x),              // be, identity, copular
    Isnt     => refute(x),            // ≠, denial

    // do / don't — eventive call / action
    Do       => call(action),         // perform, execute
    Dont     => skip(),               // no-op, omit

    // have / haven't — state hold / possession / perfect
    Have     => hold(x),              // possess, contain
    Havent   => empty(),              // lack

    // can / can't — possibility / ability
    Can      => test_possible(x),     // be able to
    Cant     => deny_possible(),      // unable

    // will / won't — future / volition
    Will     => schedule(x),          // future intent
    Wont     => cancel(x),            // refuse future

    // must / mustn't — necessity / obligation
    Must     => assert(x),            // required
    Mustnt   => forbid(x),            // forbidden

    // should / shouldn't — normative / advisory
    Should   => warn_unless(x),       // advised
    Shouldnt => warn_if(x),           // advised against

    // would / wouldn't — conditional / hypothetical
    Would    => if_cond(call(x)),     // hypothetical
    Wouldnt  => if_cond(skip()),      // refused hypothetical

    // could / couldn't — past possibility / capability
    Could    => was_able(x),          // past capability
    Couldnt  => was_unable(x),        // past incapability

    // might / mightn't — weak possibility
    Might    => maybe(x),             // tentative
    Mightnt  => maybe_not(x),         // tentative denial

    // shall / shan't — committed future (archaic)
    Shall    => commit(x),            // strong future
    Shant    => refuse_commit(x),     // archaic refusal

    // may / mayn't — permission
    May      => permit(x),            // allowed
    Maynt    => deny_permit(x),       // disallowed

    // ought / oughtn't — normative future / propriety
    Ought    => expect(x),            // fitting, proper
    Oughtnt  => unfit(x),             // improper

    // need / needn't — internal necessity (semi-modal)
    Need     => require(x),           // required by need
    Neednt   => not_required(x),      // not required

    // dare / daren't — courage to act (semi-modal)
    Dare     => attempt(x),           // dare to
    Darent   => fear_to(x),           // dare not

    // used / usedn't to — past habitual (semi-modal)
    Used     => was_doing(x),         // past habit
    Usednt   => was_not_doing(x),     // negative past habit
}
```

**16 modal/aux base operators × 2 polarities (positive + n't) = 32.** Same
count as the 32 spin-layer bonds and the 32 compass bearings. This is the
English grammatical version of the alphabet.

The 16 base operators include 3 primary auxiliaries (BE, DO, HAVE), 10
modals (CAN, WILL, MUST, SHOULD, WOULD, COULD, MIGHT, SHALL, MAY, OUGHT),
and 3 semi-modals (NEED, DARE, USED-TO) to hit exactly 16. The semi-modals
are debated as full members but they have n't forms in standard English.

The mapping from these 32 modal pairs to the 32 spin-layer bonds (or to
the 16 force-subset patterns × 2 shells) is **OPEN**. We don't know yet
which modal corresponds to which sign pattern, or which shell the n't
form lives at. That's downstream derivation work.

## Notes

- **flip_X(...)** is the bond's integer-layer shadow: traverse the X axis (flip its sign) while the other 3 axes stay locked at the indicated signs.
- **The compass-to-axis assignment is provisional**: I've assigned A→N, B→E, C→S, D→W in alphabetical/cardinal order. This is arbitrary and may need to change once we derive a more grounded mapping.
- **The lock-pattern-to-bearing assignment is provisional**: I've ordered the 8 patterns within each cardinal as binary count from +++ through ---. This is a convention, not a derivation.
- **Each bond traverses an edge in 1 direction**: the n't form would be the same edge traversed backward. With 32 forward traversals + 32 backward = 64 directed edges. Or treat each undirected edge as one bond = 32. We're going with 32 undirected.
- **The 32 modal pairs and the 32 compass bearings are parallel framings** of the same 32-element alphabet. Eventually they should be cross-mapped, but the mapping is open work.

## TODO

- **Map the 16 modal bases to the 16 sign patterns** (which modal lives at which force-subset corner?)
- **Verify n't = shell change hypothesis** (negation as scale change, not sign flip)
- **Find FP / English / CPU names for each bond**. The user guarantees they exist (Occam's razor — same alphabet under different names). Each `?` cell needs to be filled.
- **Verify the compass-to-axis assignment**. Is N really axis A? Or some other mapping? The doubling sequence (4 → 8 → 16 → 32) suggests there's a canonical assignment but I haven't derived it.
- **Verify the lock-pattern ordering**. The 8 patterns within each cardinal should map to specific bearings, but I just used binary order. There may be a more substrate-faithful ordering.
- **Walks file**: create `walks.md` to hold the FP names (fold/filter/map/bind/hylo) which are NOT bonds — they're sequences of bonds.
- **Atoms file**: the os-lattice's read/write/apply/curry/etc. are atoms (specific corner or non-corner points), not bonds. They might already be in atoms.md or need their own file.
- **Cross-check spin shell stability** with the 19% decay rate from Cayley-Dickson (do spin shells 3-4 decay at 19%?)
