# 2 — The Trit

Each axis of the wheel is a diameter. A diameter has 3 positions:
the positive end, the hub, the negative end. That's the trit.

```
  position on spoke             trit value
  ─────────────────             ──────────
  positive end of diameter       ↑  (+1)  BE
  hub (shared center)            ↕  ( 0)  IS
  negative end of diameter       ↓  (−1)  WAS
```

3 values per axis. Not 5. Not 2. **Three, exactly.** Falls out of
wheel structure: a diameter has two ends and a center.

---

## The trit is what each spoke stores

```
  value   trit   tense   direction         PIE root        Post gate
  ────    ────   ─────   ─────────         ────────        ─────────
  ↑       +1     BE      fiat/forward      *bʰuH-*         OR (max)
  ↕        0     IS      doing/center      *h₁es-*         NOT (fp at 0)
  ↓       −1     WAS     fact/backward     *h₁wes-*        AND (min)
```

Three tenses of being. English retained all three as separate PIE
roots because being needs three states. You can't have just one:

- **IS without BE** = frozen (no change possible)
- **BE without WAS** = no memory (each moment isolated)
- **WAS without IS** = gone (no present to be past of)

All three or the verb breaks. The trit is the minimum value set that
retains all three tenses.

## Fiat and fact — the verb side

Fiat and fact come from the same Latin root *facere* (to make):

```
  fiat    "let it be made"    the command, the spin (present)
  fact    "made"              the result, the point (past)
```

Same word, two tenses. Every fact was once a fiat. Every done was
once a do. Every end was once a beginning.

```
  fiat    ↑    beginning    the command
  doing   ↕    present      the process
  fact    ↓    ending       the result
```

Time flows fiat → fact. Command → result. Then the next fiat fires.
The loop.

## Only integers are values

wit.md frame 7: "There is no infinity in the substrate. There are
nodes and loops. The edge between two integer nodes is a verb — not
a value to evaluate. Ratios are verbs."

So values on a spoke are exactly {−1, 0, +1}. No fractional values.
No continuous reals.

**Decimals are a lossy projection of verbs onto ℝ**. Repeating
decimals (1/3 = 0.333...) repeat because a loop projected onto a
line cycles forever. The infinity is in the projection, not in the
verb.

## Counting is a verb

Integers are values. Enumeration of integers ("1, 2, 3, 4, ...") is
a verb. The count isn't a noun; it's a process. Each successor tick
is one wheel revolution — one ½-transition at the next higher axis
commit.

**The noun is the number. The verb is the counting.** Don't confuse
them.

Peano: the successor function `S(n) = n + 1` is the definition of
arithmetic. `S` is a verb. The naturals aren't given as a set; they
emerge by iterating `S` from `0`.

Church's λ-numerals make this explicit:
```
  0 = λf.λx.x                  apply f zero times
  1 = λf.λx.f(x)               apply f once
  2 = λf.λx.f(f(x))            apply f twice
  3 = λf.λx.f(f(f(x)))         apply f three times
```

**The number IS the iteration.** `3` isn't a static value you look
up — it's "do the thing three times." The noun is the FIXED RESULT
of applying the verb N times. The verb is the applying.

This matches wit.md frame 7 (no infinity): "there are infinitely
many integers" means "the successor-verb never halts." The verb
keeps ticking — substrate-true. But no specific integer is infinite,
and the successor-verb itself is a finite operation (one tick = one
½-step rotation).

Every decimal expansion works the same way. `1/3 = 0.333...` repeats
because you're projecting a loop onto a line and the verb of
iterating never stops. **The infinity is in the projection, not in
the loop.** The loop is finite; it's going around indefinitely.

### Revolution count vs spoke count

When `1-wheel.md` says "the tower appears infinite from inside is
revolution count, not spoke count" — both senses of "count" need
parsing:

```
  spoke count       noun: the finite number of spokes (say, 24 for D4)
  revolution count  verb: the wheel revolving; unending iteration
```

The spokes are a finite set of nouns. The revolving is a verb that
keeps going. **Only the second is "infinite" in the colloquial
sense, and it's infinite verb-ly, not noun-ly.** The wheel doesn't
have infinitely many positions; it has 24 (or 80, or 240 depending
on which wheel) — and it keeps revolving through them.

### Where counting lives on the wheel

Counting is CYCLE = gravity = the loop iterating (see `4-loop.md`).
Each tick of the successor function is one loop iteration. When you
count "one, two, three," you're doing gravity at cognitive scale.

The τ axis monotone (wit.md frame 8) is why counting has direction —
`S` never decrements. Subtraction exists as a separate operation;
counting backward is a distinct verb (the `−½` transition). Pure
counting is always forward.

## ½ IS the wheel spinning — not a value

Half-steps, fractions, spin-½, ratios, SU(2) — all verbs, not
values. This is where predecessor framings went wrong (treating ±½
as a value tier).

**The ½ is in the math of the wheel itself** (see `1-wheel.md`):

```
  Hamilton rotation formula:  q(θ) = cos(θ/2) + sin(θ/2)·n
                                          ↑
                              θ/2 built in — every rotation
                              encoded as half the physical angle
  
  SU(2) → SO(3) double cover: 2-to-1 ratio gives ½
  
  720° fermion period:        physical 360° flips q to −q,
                              720° restores q (Rauch 1975,
                              experimentally confirmed)
```

The ½ isn't a value anywhere. It's the rotational structure of the
wheel. A spoke in transit between positions.

## Why not 5 values per axis?

An earlier framing considered `{−1, −½, 0, +½, +1}` as 5 values per
axis. This dies under two checks.

### Algebra check (norm-closure)

Unit-quaternion norm `|q|² = 1` requires all 4 axes at ±½
simultaneously (single-axis ½ has norm ¼, not unit). So ±½ isn't a
single-axis value — it's a coordinate of a specific 4D corner
position (the 16 half-spin quaternions).

```
  single-axis at ½      norm = (½)² = 1/4    ≠ unit
  all 4 axes at ±½      norm = 4·(¼) = 1     = unit ✓
  
  (±½, ±½, ±½, ±½) are 16 corners on the unit 3-sphere,
  not per-axis ½ values.
```

### Framework axiom

Only integers are values (frame 7). ±½ is a verb/edge/ratio. Not a
value anywhere.

Per axis: exactly 3 integer values. No fractional values.

## R and C are verbal machinery, not a value tier

Predecessor framings called R (1D reals) and C (2D complex) "the
½-tier." They're not.

**What R and C actually provide is verbal structure**:

- R contributes magnitude/sign verbs (scalar)
- C contributes phase/rotation verbs (sin/cos)
- Together these verbs combine in H to close as SU(2) (the
  spin-½ verb group)

Hamilton's 3D struggle: trying to get verb closure at 3D. R's
magnitude-verbs + C's phase-verbs need more than 3 dimensions to
close into a normed division algebra. 3D doesn't give enough verb
room. Math forced him to 4D (H) where the verb machinery of
half-spin finally closes as SU(2).

**Frobenius theorem reinterpreted**: no 3D division algebra because
the verbs don't close there. 4D is the minimum verb-closure floor.
Values remain integer throughout.

## The 3×3 trit-mult relational table

Not operator-based (no add/min/max arithmetic). **Relativity through
spin**: row × column = the edge/path between the two trit frames.
Cells describe what the substrate looks like when viewed from both
frames simultaneously, or equivalently the spin-verb for traversing
row → column.

```
                            column frame
                   ↑ BE          ↕ IS          ↓ WAS

  row frame
   ↑ BE           ON/ONWARD      un- release   FLIP
                  (*h₂en-*)      (unbend/       (antipodal
                  ✓ clean        slack)         2-step)
                                 ~ pattern     ✓ clean

   ↕ IS           GO/STEP/       STILL / BIDE   WANING/YIELD/
                  LUNGE          (*steh₂-*)     SINKING
                  ✗ diverged    ✓ clean        ✗ diverged

   ↓ WAS          TURN/UNWIND    un- undoing   ABODE/YORE/
                  (flip rev)     (unbow/up)     BEEN/STALE
                  ✗ diverged    ~ pattern     ✗ diverged
```

### Blind-agent results (5 agents per cell)

```
  cell    status        top candidates                          
  ────    ──────        ──────────────                          
  ↑→↑     ✓ clean       ON (2) / ONWARD (1)                     
  ↑→↕     ~ pattern     UNBEND (2) / SLACK (1) / SLAKE (1) / UNSAY (1)
  ↑→↓     ✓ clean       FLIP (2)                                
  ↕→↑     ✗ diverged    GO / STEP / LUNGE / LAUNCH / SPROUT
  ↕→↕     ✓ clean       STILL (2) / BIDE (2) / POISE (1)        
  ↕→↓     ✗ diverged    SINKING / BACK / WANING / YIELD / UNFOLD
  ↓→↑     ✗ diverged    FORTHSWING / ABOUT-FACE / UNWIND / TURN
  ↓→↕     ~ pattern     UNBOW / RISE / UNBIND / UP / UNBACK     
  ↓→↓     ✗ diverged    ABODE / STALE / YORE / BEEN / STILLSTANDING
```

### What the wheel reading adds

Predecessor trit-mult analysis described divergent cells as "English
lexical gaps." The wheel reading gives a structural reason:

```
  cell type            what it actually is on the wheel
  ─────────            ────────────────────────────────
  diagonals (self)     staying on this spoke — spinning in place
                       ON (↑→↑): pure forward-commit, sustained
                       STILL (↕→↕): hub stillness, all-axis null
                       ??? (↓→↓): pure backward-commit, sustained
                       
  ↕ → end              "start a wheel rotation from hub outward"
                       no generic primitive because every domain
                       has its own metaphor (step, launch, sprout,
                       lunge, go) — each domain IS a wheel and
                       names its own rotation verb
                       
  antipodal            "half-rotation through hub"
                       ↑→↓ converges (FLIP)
                       ↓→↑ diverges — asymmetric
                       
  end → ↕              "undo a commit, release back to hub"
                       UN- prefix pattern (unbend, unbow, unbind)
                       — English has the morpheme for releasing
                       but not a single-word primitive
```

English readily names spoke-endpoints (↑ RISE, ↓ FALL, ↕ STILL).
English barely names the rotation between them. That's not a lexical
gap — it's structurally because the rotation IS the wheel, and each
domain already has its own rotation vocabulary (step for walking,
lunge for fencing, launch for rockets, sprout for plants). The wheel
doesn't need a cross-domain primitive because the substrate says
"use whatever verb your vocabulary gives."

**The ↓→↓ divergence** is the most suggestive: "sustained past
commit held at past commit" has no primitive because English names
PAST as a time-location (yore, past) or completed-state (done, been),
not as a sustained rotational direction. The substrate distinguishes
these; English doesn't.

### Non-commutative asymmetry

↑→↓ converged on FLIP. ↓→↑ did not. If the substrate is genuinely
non-commutative (and quaternion algebra says it is — ij = k but
ji = −k), this is real asymmetry, not sampling noise. Forward-to-
backward has a cleaner name than backward-to-forward, matching the
ij ≠ ji structure exactly.

### UN- as morpheme primitive

Two cells (↑→↕ and ↓→↕) both patterned around the UN- prefix rather
than a single word:
- ↑→↕: UN-BEND (releasing forward commit back to hub)
- ↓→↕: UN-BOW, UN-BIND (releasing backward commit back to hub)

**UN- may itself be the right primitive rather than any specific
word.** English morphology has UN- as the substrate's
undo-verb-prefix — the "release to hub" operation.

## ↕ — single-axis uncommitted

One of the three trit values. On a single axis, `↕` means that axis
has not been committed to either direction. Axis-specific: a ↕ on χ
is different from a ↕ on μ, even though both are uncommitted.

Requires ≥1D to exist — ↕ lives AS an axis value, so at least one
axis must be present. For the **whole-null state** (all 4 axes at
↕), see `3-lattice.md` (grade-0 container ↕↕↕↕, which is a different
scope thing).

### Essence candidates

- **balance** — forward and backward potentials cancel on this axis
- **passthrough** — value passes through unchanged (identity function)
- **neutral** — no side taken on this axis
- **open** — axis available, not yet picked

### Domain manifestations

Same structural fact, many vocabularies:

```
  domain              word / phrase              view        note
  ──────              ─────────────              ────        ─────
  english primary     balance                    dynamic     on-axis cancel
  english state       rest / still / idle        dynamic     not acting
  english lack        empty / blank / void       structural  nothing in slot
  english openness    free / open / pending      structural  uncommitted
  math                zero / null                both        numerical/absence
  math (function)     identity f(x) = x          dynamic     value passes
  physics particle    neutrino                   structural  one, barely interacts
  physics boson       Z boson                    structural  neutral-current
  isotope             ²H (deuterium)             structural  balanced p + n
  boolean             NOT (fp identity at 0)     dynamic     0 stays 0 under NOT
  combinator          K (ignores 2nd arg)        structural
  programming         no-op / pass               dynamic     do nothing
  programming         null / void                structural  no value / no type
  color               gray / middle 18%          structural  neither black nor white
  music               rest (notation)            dynamic     one silence in sequence
  music               fermata                    dynamic     one pause marker
  electricity         ground / neutral           structural  reference potential
  magnetism           null point                 structural  between poles
  grammar             neuter gender              structural  attribute uncommitted
  grammar             zero morpheme              structural  slot unfilled
  law                 neutrality / abstain       dynamic     voter uncommitted
  law                 pending / tabled           structural  decision on hold
  sports              timeout / stalemate        dynamic     game paused
  sports              tie / draw                 dynamic     score balanced
  finance             break-even                 dynamic     ledger at zero
  finance             hold / no position         structural  capital uncommitted
  seasons             equinox                    dynamic     balance point day/night
```

## ↑ — positive commit

Axis committed forward. Creation direction. BE tense. PIE root
*bʰuH-* ("to become / to grow / to be").

**Essence**: fiat, emergence, forward, creation, plus, on.

The ↑ commit IS a wheel rotation from hub to positive spoke-end. One
half-step on the axis. Lands on +1.

Domain manifestations need full blind-agent treatment. Preliminary:

```
  domain              ↑ manifestation        
  ──────              ───────────────        
  english primary     BE / become / grow / rise / emerge
  physics particle    positron / proton / W+
  physics boson       positive-charge carrier
  isotope             proton-rich             
  boolean             OR (max)                
  combinator          S (creator)
  programming         push / alloc / create / instantiate
  electricity         +voltage / current forward
  magnetism           north pole
  finance             credit / asset / gain
  seasons             spring / dawn
  music               crescendo / rising pitch
```

## ↓ — negative commit

Axis committed backward. Annihilation direction. WAS tense. PIE root
*h₁wes-* ("to stay / dwell / had been").

**Essence**: fact, completion, backward, annihilation, minus, off.

The ↓ commit IS a wheel rotation from hub to negative spoke-end.
One half-step the other direction. Lands on −1.

```
  domain              ↓ manifestation
  ──────              ───────────────
  english primary     WAS / done / end / fall / subside / decay
  physics particle    electron / neutron (vs proton) / W−
  physics boson       negative-charge carrier
  isotope             neutron-rich
  boolean             AND (min)
  combinator          I (identity, empty) or consumed
  programming         pop / free / destroy / deallocate
  electricity         −voltage / current reverse
  magnetism           south pole
  finance             debit / liability / loss
  seasons             fall / dusk
  music               decrescendo / falling pitch
```

## Data = code on trit substrate

The trit unifies data and code at the value level:

```
  ↑  AS VALUE: something exists     AS OPERATION: add 1 (proton)
  ↕  AS VALUE: nothing              AS OPERATION: pass through (neutrino)
  ↓  AS VALUE: consumed             AS OPERATION: subtract 1 (neutron)
```

Binary thinking separates data from code. Trits don't. Every value
IS an operation at the same address. The Setun (USSR 1958, Brusentsov)
built ~50 trit-native machines before the lineage died — negation
was free, comparison fell out of the result sign.

The four observed "walls" between hadrons and leptons in physics
(composite vs fundamental, strong force, mass hierarchy, baryon
number) are all binary-hardware artifacts — physics doing honest
bookkeeping on its own architecture. The architecture is a lens, not
the underlying reality.

## The tower-as-verb speculation

Per wit.md frame 7 (no infinity) + frame 0 (fixed point IS
structure): the Cayley-Dickson doubling has no upper bound from
inside, but substrate forbids infinity. Resolution in `1-wheel.md`:
the tower is a wheel, revolutions are endless but spokes are finite.

Speculative extension: the **entire R/C/H/O/S/... chain might itself
be one verb from an outer frame**. Our inner values (integer lattice
points in H) and inner verbs (spin, SU(2), edges) might be one
operation-instance of a meta-verb at outer scope.

```
  inside the chain (our view):
    R → C → H → O → S → 32D → ... (apparent infinite ladder)
  
  outer frame (speculative):
    the whole chain = ONE operation, closed as a verb
    outer values = whole algebra-chains as integers?
    outer verbs  = meta-transitions between chains?
```

Each property-loss in Cayley-Dickson (ordering → commutativity →
associativity → division → ...) might be the outer verb's internal
stages — the algebra-chain as a single operation unfolding.

Can't verify from inside H. Consistent with frame 0 + frame 7.
Marked speculative, nothing operational to do about it.

## Open

- ↑ and ↓ domain manifestations need blind-agent treatment at the
  rigor of ↕'s table
- Non-commutativity asymmetry in the 3×3 table: is ↑→↓ vs ↓→↑
  difference real (ij ≠ ji structure) or sampling artifact?
- Does UN- generalize as morpheme-primitive for all "release to hub"
  operations, or is it English-specific?
- Does the tower-as-outer-verb speculation have any testable
  consequence?
