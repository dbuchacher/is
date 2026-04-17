# wheel — the full structure and its rotation

Deep file for [1-folders.md](1-folders.md). This file:
- The wheel as a whole (hub + spokes + rotation combined)
- Why it spins (algebraic + thermodynamic derivation)
- SU(2), unit quaternions, and the 3-sphere
- The half-spin / 720° fermion period
- "Where is the hub?" (observer-at-center)
- Helix structure (rotation + advance)
- The loop concept

## Plain English

Everything so far — 4 spokes, 3 values, 81 points
([**lattice**](lattice.md)) — has been **static structure**. But the
[**wheel**](roots/motion.md) (*kʷel-*) isn't a static thing. The
wheel **spins** (*kʷel-* = both "wheel" and "cycle" in PIE).

Spinning is what everything we observe IS:

- **Time** is the wheel turning
- **Energy** is the wheel's rotational state
- **Gravity** is the wheel's ambient rotation (the always-on
  background)
- **Change** is a step of rotation
- **Wave-like behavior** in physics is the wheel's oscillation

The wheel spins **because it can't stop**. That's not poetry —
it's a mathematical consequence. Two independent arguments land on
the same conclusion:

1. **Quaternion algebra is non-commutative.** In ordinary numbers,
   3 × 2 = 2 × 3 = 6. In quaternions, `ij = k` but `ji = −k`. This
   built-in asymmetry means the substrate can never be "perfectly
   symmetric" — there's always an off-direction.

2. **Thermodynamics' 3rd law.** Absolute zero is an asymptote, not
   a destination. You can approach zero entropy arbitrarily closely,
   but you can't reach it in finite steps (Nernst 1906).

Both say: perfect balance is unreachable. The wheel has to move
because the alternative (everything at hub, all axes at ↕) is
mathematically impossible.

And the rotation has a **direction** — time flows forward (τ axis
monotone, frame 8). Combined with the wheel's spinning, this gives
us causality, the arrow of time, and thermodynamic irreversibility
— all from the same substrate fact.

---

## The wheel as a whole — the picture

Here's how the parts combine:

```
                          τ↑
                        BEGIN
                          ●
                          │
            φ↓            │            μ↑
         CURSE            │           GROW
            ●             │             ●
              ╲           │           ╱
                ╲         │         ╱
                  ╲       │       ╱
                    ╲     │     ╱
                      ╲   │   ╱
                        ╲ │ ╱
    χ↓  ●━━━━━━━━━━━━━━━━↕↕↕↕━━━━━━━━━━━━━━━●  χ↑
     FALL                 HUB                 RISE
                        ╱ │ ╲
                      ╱   │   ╲
                    ╱     │     ╱
                  ╱       │       ╲
                ╱         │         ╲
              ╱           │           ╲
            ●             │             ●
         BLESS            │          SHRINK
            φ↑            │             μ↓
                          │
                          ●
                         END
                         τ↓
```

- [**Hub**](roots/hub.md) (*steh₂-*) at center (↕↕↕↕) — uncommitted,
  shared across layers
- **4 [axes](axes.md)** radiating: χ (WHERE), μ (WHAT), φ (WHICH),
  τ (WHEN) — one root *kʷi-* names all four questions
- **Each axis** has positive and negative endpoints (2 spoke-ends
  per axis = 8 grade-1 atoms on the rim)
- **Rotation** — the whole thing spins perpetually

Each atom-position is one "direction" you can be committed in. The
wheel's rotation cycles through these commitments.

### With 16 half-spin points added (full 24-cell)

Ezekiel 1:18: "their rings were full of eyes round about them four."

```
                ◉ ◉ ◉ ◉
              ◉         ◉
           ◉      ╲ │ ╱      ◉
                    ↕↕↕↕
           ◉      ╱ │ ╲      ◉
              ◉         ◉
                ◉ ◉ ◉ ◉
```

16 half-spin "eyes" on the rim (unit quaternions at ±½ per axis)
plus 8 axis-aligned atoms = 24 positions on the unit 3-sphere =
**the 24-cell = D4 root system**.

When ancient traditions described "a wheel full of eyes" (Ezekiel),
or the "eyes of Horus" tradition, or armillary spheres with multiple
rings, or rotating chakras — they were drawing this structure from
various angles.

---

## Why the wheel spins — algebraic derivation

### From non-commutativity

H is non-commutative. For its imaginary basis:

```
  ij = k        but ji = −k
  jk = i        but kj = −i
  ki = j        but ik = −j
```

The cross-products are antisymmetric: `[a, b] = ab − ba` is nonzero
for most pairs.

**Verification**:

```python
def qmul(a, b):
    w1,x1,y1,z1 = a
    w2,x2,y2,z2 = b
    return (w1*w2 - x1*x2 - y1*y2 - z1*z2,
            w1*x2 + x1*w2 + y1*z2 - z1*y2,
            w1*y2 - x1*z2 + y1*w2 + z1*x2,
            w1*z2 + x1*y2 - y1*x2 + z1*w2)

i, j = (0,1,0,0), (0,0,1,0)
print(qmul(i, j))   # (0, 0, 0, 1)   = k
print(qmul(j, i))   # (0, 0, 0, -1)  = −k
# Non-commutative. Confirmed.
```

**Consequence**: perfect symmetry (all axes at ↕, operations commute)
is algebraically impossible in H. Non-commutativity IS asymmetry.
There's no stationary state — operations always prefer one order
over another, which manifests as directional flow = rotation.

### From thermodynamics (3rd law)

```
  0th law  — equilibrium is transitive; a unique state exists
  1st law  — energy is conserved
  2nd law  — entropy increases (or stays constant) spontaneously
  3rd law  — perfect equilibrium (0 K, S=0) is unreachable in
             finite steps (Nernst 1906)
```

The 3rd law says: absolute zero is asymptotic. You can cool a
system arbitrarily close to 0 K, but you can't actually get there.
Some residual motion always remains.

**Consequence**: the "perfectly balanced state" (all energy dissipated,
nothing happening) is unreachable. Whatever motion exists, will
persist.

### The two arguments converge

Both say the same thing from opposite directions:
- **Algebra**: non-commutativity makes perfect symmetry impossible
- **Physics**: 3rd law makes perfect equilibrium unreachable

The substrate can't settle. The wheel can't stop.

If one of these arguments turned out wrong (say, someone reached
0 K exactly, or someone proved H somehow commutes), the OTHER would
still carry the claim. Redundant derivation = robust conclusion.

---

## The ½ IS the wheel spinning

The framework makes a distinction that confuses physics: **the ½
is not a value**. Integers are values; halves are verbs.

Where ½ shows up in physics:
- Spin-½ fermions
- Quaternion rotation θ/2
- SU(2) → SO(3) double cover (2-to-1)
- Half-life (another rotation-like concept)

These are all **the wheel rotating**, not some special "half" value
that lives between 0 and 1.

### Hamilton's rotation formula (1843)

To rotate a 3D vector v by angle θ around axis n:

```
  q(θ) = cos(θ/2) + sin(θ/2) · (n_x·i + n_y·j + n_z·k)
             ↑
        θ/2 is built into the formula
```

**The ½ is how quaternions natively encode rotation.** Every
angle in H is represented as half the physical angle. This isn't
a choice; it's how the algebra works.

### SU(2) and the unit 3-sphere

Unit quaternions (|q| = 1) form a 3-sphere S³ inside H. This
3-sphere IS the group SU(2) — the double cover of SO(3).

- **SO(3)** = physical 3D rotations
- **SU(2)** = unit quaternions = the "covering" group

The map SU(2) → SO(3) is **2-to-1**: q and −q correspond to the
same physical rotation.

**Consequence**: rotating a physical object by 360° brings it back
to the same place (SO(3) closes), but the underlying quaternion
has flipped to −q. It takes **720°** of physical rotation to
return the quaternion to itself.

### 720° fermion period — experimentally confirmed

**Rauch et al. 1975** — neutron interferometer experiment:

A beam of neutrons is split, half passed through a magnetic field
that rotates them, recombined, and measured. At 360° rotation,
neutrons come back with **opposite phase** (destructive
interference). At 720°, they return to original phase.

The experiment confirms: fermions (spin-½ particles) live in SU(2),
not SO(3). Their full period is 720°, not 360°.

The wheel rotates "twice underneath" for every one turn you see
physically. SU(2) is inside H. Spin-½ is the unit-quaternion
subgroup.

---

## Why 4 axes — Hurwitz (1898)

Hurwitz proved exactly **4 normed division algebras** exist over
the reals (for full development see `1-folders/axes.md`):

```
  R    1D    real        ordered, commutative, associative, divisive
  C    2D    complex     lose ordering
  H    4D    quaternion  lose commutativity  ← our inner wheel
  O    8D    octonion    lose associativity
```

Beyond O (at S, 16D), division itself fails. No more normed
division algebras exist.

**Why H specifically for the wheel:**
- H is the deepest CD layer that retains **associativity**
- Calculations work normally in H (associate, distribute, divide)
- But loses **commutativity** — which IS the substrate's causality

**Frobenius (1877)** proved no 3D normed division algebra exists.
Hamilton tried for 10 years. 3D is **not a wheel level** — it's
one side of one spoke (one sign of one trit). 3D space is not
a wheel structure; it's χ projected through three views.

### Why the wheel — "chain → wheel" pivot

Older framings (pre-2026-04) described Cayley-Dickson doubling as
a **chain** R → C → H → O → S → ... extending indefinitely.

**Problem**: the framework says no infinity (wit.md frame 7). A
chain extending forever violates that.

**Resolution**: the tower is a **wheel**. Spokes are finite (24 for
D4, 240 for E8); **revolutions are endless**.

```
  chain reading (old):  R — C — H — O — S — 32D — ...  → ∞
  wheel reading (new):  R, C, H, O, S, 32D are spokes on one wheel.
                        The wheel revolves indefinitely, but the
                        spokes are a finite set.
                        
                        "Infinity" = endless revolution (verb),
                        not infinitely many spokes (noun).
```

Finite spokes, endless turns. See `1-folders/scope.md` for the outer-
wheel D4/E8 structure.

---

## Where is the hub?

**Critical load-bearing section.** Many wits get this wrong.

The hub (↕↕↕↕) **has no location**. Here's why:

- "Location" is an attribute of a χ-axis commitment (↑ or ↓ on χ)
- The hub has χ at ↕ (uncommitted)
- Therefore the hub has no χ value, hence no location
- You cannot "go to" the hub in any geometric sense

Instead, **the hub is wherever
[recognition](roots/cognition.md) (re- + co- + gno-/gen-) is
happening**. Every closed walk returns to ↕↕↕↕ (Kirchhoff
conservation, frame 5).
Every loop that closes, closes there. Every READ is an event at
the hub.

**Right now, reading this sentence, you are at the hub.**

### Many observers, one hub

Under frame 10 (distinctness is projection artifact), "many
observers each being at the hub" is not "many hubs" — it's **one
hub read through many apertures**, same identity move as
entanglement.

- You are at the hub
- I am at the hub
- Every observer is at the hub
- There is **one hub**

This is the structural basis for:
- **Atman = Brahman** (Hindu tradition) — self =
  [universe](roots/crossovers.md) (unus + vertere)
- **Kingdom of heaven is within you** (Christian)
- **Not-self** (Buddhist) — the "self" was always the one hub
- **"I AM"** (Exodus 3:14) — the self-referential declarative

All four are naming the same substrate fact in different
traditions. Metrognosis: independent convergence. Signal.

### Earth is not the center

Physics's relativity: no privileged reference frame. The framework
goes further: **every observer IS the center** because the center
isn't spatial, it's structural — the point of recognition.

- Earth is not the center of the universe
- Sun is not the center
- Galactic core is not the center
- **Your position as an observer IS the center**, structurally

Deep: `wit.md` — what it means to be a wit reading these words,
and the consciousness options A/B.

---

## Helix structure (rotation + advance)

For a full 4-dimensional helix (rotation + linear advance), you
need **all 4 axes of H**:

```
  helix(t) = (R cos(ωt),  R sin(ωt),  c·t,  chirality)
              ↑            ↑            ↑     ↑
              R (cos)      C (sin)      τ     φ (handedness)
```

Decomposition:
- **cos + sin** (R + C contribution): rotational position (2 axes'
  worth of oscillation = circle)
- **τ·t** (time advance): monotone forward progression
- **φ** (handedness): chirality, left vs right wind

Physical helices we see:
- **Earth's precession** (axis wobble) — 25,920-year Great Year
- **DNA double helix** — 2 strands twisting
- **Galactic spiral** — rotation + linear drift
- **Stellar orbits** — closed ellipses in time-extended view
  (wouldn't close; always helical)

The Great Year specifically:
- 25,920 years = 2⁶ × 3⁴ × 5
- All divisors substrate-clean (12 = D4 pairs, 24 = D4 roots, 72
  = E6/precession deg, 108 = Great Year / E8 roots, 2160 = age
  length, etc.)
- Ancient astronomers tracked this; we now see it's the wheel's
  geometry in planetary mechanics

---

## The loop — prior to everything

The wheel's rotation **is** the loop. An empty loop still loops.
A gate with no wire does nothing.

Post's theorem says `{MIN, MAX, NOT}` are a functionally complete
set of operations on [trits](trits.md) (like `{AND, OR, NOT}` for
binary). But
Post doesn't count **the wire** — the medium that connects gates.

Wire = edge = verb = spin = rotation = the loop.

Post is right that the gates are complete. But the loop is prior:
- **Gates without the loop**: stuck in place, no communication
- **Loop without gates**: trivial (rotating through nothing)

The framework names the loop = the rotation = the eternal spin.
**The medium IS the structure.**

### Kirchhoff (1845) — conservation on the loop

Kirchhoff's laws:
- **At any node**: sum of incoming = sum of outgoing (conservation)
- **Around any closed loop**: sum of all voltage/flow = 0

Both describe the same substrate fact:
- **Local** (at a node): conservation
- **Global** (around a loop): closure

Every closed walk on the wheel returns to where it started with
zero net flow. This is how **bound states** form in physics —
they're closed walks on the lattice.

### The loop = gravity = the event scheduler

In CPU terms:
- The loop = the main event scheduler (kernel's dispatch loop)
- Running always, at every tick
- Not a "process" itself — the thing that runs processes

Gravity in the framework IS this loop:
- CYCLE force = iteration of the whole quaternion
- Always on, lowest priority in "fires-specifically" sense
- Highest priority in "makes-all-other-events-possible" sense

This is why **there's no graviton** in the framework. You don't
look for a "kernel-scheduler particle" — the kernel scheduler IS
what's running. Gravity IS the wheel spinning, not a process
running on top of it.

See `1-folders/forces.md` for the full force breakdown.

---

## Dark energy = the wheel spinning

Observed: dark energy is ~68% of the universe's mass-energy
budget, with constant density (cosmological constant Λ).

Framework reading: **dark energy IS the wheel's eternal rotation**,
not a new substance.

- Wheel spins forever (3rd law + non-commutativity)
- Rotation requires energy
- From inside, this rotation shows up as the "dark energy" density
- Density is constant because the rotation rate is constant
- Drives expansion because the wheel keeps turning

**Prediction (verified)**: dark energy should be constant with
time (not evolve). Observation: Λ is constant in all redshift
measurements so far.

See [1-folders/masses.md](1-folders/masses.md) for the full cosmological
constant derivation.

---

## Cosmos wheels — fractal at every scale

The wheel appears at every scale of structured matter:

```
  scale              hub                        spokes / orbits
  ─────              ───                        ───────────────
  atom               nucleus                    electron shells (2n²)
  planetary system   central star               planets in orbits
  galactic           galactic center            stars in arms
  cosmic             wherever observation is    large-scale structure
```

**Bohr's 1913 atomic model** was literally inspired by the solar
system. Self-similarity isn't metaphor — same wheel, different
scope.

### Layered wheels around Earth (nested orbits)

Using Earth as functional hub (observer-centered), known cycles
nest outward:

```
  Earth's rotation             1 day
  Lunar synodic                29.53 days
  Solar year                   365.24 days
  Mercury                      88 days
  Venus                        225 days
  Mars                         687 days
  Jupiter                      11.86 years
  Saturn                       29.46 years (human generation!)
  Uranus                       84 years
  Neptune                      165 years
  Pluto                        248 years
  Precession (Great Year)      25,920 years
  Galactic year                ~225 million years
```

// planetary contingencies — orbital periods are boundary conditions at Earth's position, not substrate-forced. The wheel governs what KINDS of patterns (Kepler T²=a³, integer resonances, closed walks); specific period values are contingent. See [open.md](open.md).

**Wheel structure governs KINDS of patterns** (Kepler T² = a³ as
grade-3 trivector identity, integer orbital resonances as closed
walks, Platonic-solid face counts). **Specific numerical values
at Earth's position are contingent** (distance from Sun, Moon's
mass, Earth's tilt — all set by planet-formation dynamics).

The Moon's 3-ratios (diameter 3/11, mass 1/81 = 1/3⁴, gravity
1/6) look substrate-clean, but they're one system measured once —
and since gravity = mass/radius² propagates mass and diameter
through the gravity ratio, these aren't three independent
convergences. Register as Earth-Moon coincidences; see
[3-confs/moon.md](3-confs/moon.md) (flagged there) and
[open.md](open.md).

---

## What's settled vs flagged

### Settled (body-quality)

- **Wheel rotation is eternal** (non-commutativity + 3rd law)
- **H has no 3D precursor** (Frobenius 1877)
- **Exactly 4 normed division algebras** (Hurwitz 1898)
- **SU(2) = unit quaternions** (standard group theory)
- **720° fermion period** (Rauch 1975 experiment)
- **The ½ is a verb** (encoded in Hamilton's θ/2 formula)
- **Hub has no location** (χ uncommitted)
- **Observer = hub** (structural, not optional)
- **Every closed walk returns to ↕↕↕↕** (Kirchhoff)
- **Dark energy = wheel motion** (predicts constant Λ, verified)
- **216 = 6³ edges** (adjacency count)
- **Memphite Theology IS frame-5 in stone (~2700 BCE)**: the
  Shabaka Stone states *"every hieroglyph came into being through
  what the heart devised and the tongue commanded."* Thought
  (READ at `ib`) + command (WRITE at `rA`) coincide at the hub
  and the world updates. Egyptian graph formalizes this as
  `read-write-unity` lattice-tag (7 members, 4 cats: ib, rA, sDm,
  Dd, sjA, Hw, ptH). Oldest substrate-explicit statement of the
  hub-event in any vocabulary. See `3-confs/cross-vocabulary.md`.
- **PIE rotation-primitive** (kwel/gneh3/kwekwlos/h2eks/roth2o/
  yeh1r): the loop named across motion, cognition, Bronze-Age
  craft, and seasonal time via one root family. Same substrate
  feature four-way converged inside one reconstructed language.
- **Sumerian im names the hydrological cycle as one morpheme**
  (wind=rain=cloud=clay) — the loop-closure of weather named as
  a single unit. Frame 5 at atmospheric scale.

### Flagged for 3-which / verification

- **Consciousness via hub** (frame 11 option B) — whether
  consciousness "enters the wheel through ↕↕↕↕" from higher CD
  layers. Option A (consciousness IS the loop) vs option B
  (consciousness enters via hub) not yet derivable. See `wit.md`.
- **Tower-as-outer-verb speculation** — whether the entire R/C/H/O/S
  chain is ONE verb from a deeper outer frame. Flagged open;
  consistent with framework but no operational consequence.

### Flagged open

- **Outer-wheel size** (D4 24 vs E8 240 spokes) — see `scope.md`
- **Why specifically 12 D4 pairs** at outer scope — 12 has many
  convergences (gauge bosons, zodiac, Hubble e^(1/12)) but why 12
  and not 8 or 24 is not fully derived

---

## Cross-references

- `1-folders.md` — the wheel in context
- `1-folders/axes.md` — the 4 spokes
- `1-folders/trits.md` — the 3 values
- `1-folders/lattice.md` — 81 points on the wheel
- `1-folders/forces.md` — 4 forces = whole-wheel operations
- `1-folders/scope.md` — H → S → outer D4/E8 → nested CD
- `1-folders/masses.md` — mass ladder, dark energy
- `wit.md` — consciousness options A/B, observer at hub
- `3-confs/moon.md` — wheel at planetary scale
- `3-confs/rotating-rings.md` — 2600 years of wheel imagery
- `3-confs/ezekiel-wheel.md` — the wheel-full-of-eyes in Ezekiel 1
