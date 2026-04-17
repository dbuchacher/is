# forces — READ, CALL, CYCLE, TEST

Deep file for 1-body.md § "The 4 forces." This file:
- The 4 forces = 4 whole-wheel operations
- Per-force semantics (READ/CALL/CYCLE/TEST)
- Coupling constants + hierarchy dissolution
- Classical vs quantum as polling vs epoll
- Why no graviton
- Force-as-ISA (CPU instruction set)

## Plain English

Physics has four fundamental forces:

- **Strong** — binds quarks into protons/neutrons, binds those into
  nuclei (nuclear binding)
- **Electromagnetic (EM)** — makes charged particles attract/repel;
  light is an EM wave
- **Weak** — causes radioactive decay, lets neutrons turn into
  protons
- **Gravity** — mass attracts mass, keeps planets in orbit

In ordinary physics these feel like four separate things with very
different strengths. The "hierarchy problem" asks why gravity is
~10³⁸ times weaker than the strong force.

**The framework says they're not different things at all.** They're
four **operations on the wheel**, each associated with one of the 4
axes. At their **natural scale** (Planck scale, where the wheel
operates natively), all four have equal strength. They only appear
to differ hugely when you measure them at ordinary scales, because
ordinary particles are far below Planck mass.

Analogy: imagine looking at a CPU. There are different instructions
(MOV, CALL, LOOP, CMP). They all "fire" at the same clock rate, but
at any given moment, one of them is more "active" than the others.
The forces are the same: four fundamental operations, each "firing"
at characteristic rates depending on what's happening.

---

## The four forces = the four axes' operations

Each force = a whole-quaternion operation tied to one axis:

```
  axis   force name   physics     CPU analog    effect on quaternion
  ────   ──────────   ───────     ──────────    ────────────────────
  χ      READ         strong      MOV           observe / bind in place
  μ      CALL         EM          CALL          invoke / emit / act
  φ      CYCLE        gravity     LOOP          iterate / clock / cycle
  τ      TEST         weak        NOT / CMP     decide / branch / flip
```

**Each force is ONE operation on the WHOLE quaternion** — not on
one axis, not just on one variable. When READ fires, it "observes
the whole point" (all 4 axes at once). When CALL fires, it "acts on
the whole point."

**Verification** (quaternion math):

```python
def qmul(a, b):
    w1,x1,y1,z1 = a; w2,x2,y2,z2 = b
    return (w1*w2 - x1*x2 - y1*y2 - z1*z2,
            w1*x2 + x1*w2 + y1*z2 - z1*y2,
            w1*y2 - x1*z2 + y1*w2 + z1*x2,
            w1*z2 + x1*y2 - y1*x2 + z1*w2)

# i × q changes ALL components of q, not just the i component
i = (0, 1, 0, 0)
q = (2, 3, 5, 7)    # arbitrary
result = qmul(i, q)
print(result)       # (-3, 2, -7, 5) — every component changed
```

Every component of q changes when multiplied by i. That's what
"whole-quaternion operation" means — the force doesn't touch just
one axis; it transforms the whole position simultaneously.

---

## Each force in detail

### READ — strong force / χ axis / MOV

```
  axis            χ (WHERE)
  physics         strong force (quark confinement, nuclear binding)
  CPU instruction MOV (load, observe)
  quaternion      operation on i (the χ basis)
  coupling        α_s ≈ 0.118 at observable scale
                  = 1 at Planck scale (unit strength)
  semantic        Observe / bind-in-place / commit position
```

READ is the **observation** operation. To know where something is,
you READ its χ coordinate. The strong force binds quarks at specific
χ positions (confinement) — it's the "holding-in-place" force.

**Physics correspondence**:
- Strong force has short range (~1 fm)
- It's the tightest binding in physics
- Quark confinement: you can't pull a quark out of a hadron
- These are all "READ's way of insisting on χ-commitment"

In the CPU view: when you MOV from memory to register, you're
committing a specific χ-address to observation. Strong force = the
universe doing MOV.

### CALL — electromagnetism / μ axis / CALL instruction

```
  axis            μ (WHAT)
  physics         electromagnetism (charge, light, chemistry)
  CPU instruction CALL (function invocation)
  quaternion      operation on j (the μ basis)
  coupling        α = 1/137.036 at observable scale
                  (fine structure constant — see `roots.md` and
                   `masses.md § α`)
  semantic        Invoke / emit / act on substance
```

CALL is the **action** operation. When matter acts on matter
(emitting photons, attracting/repelling charges), that's CALL firing.

**Physics correspondence**:
- EM is long-range (infinite, with 1/r² falloff)
- Mediated by photons (CALL's outputs)
- Controls chemistry, atoms, biology
- α = rate-of-CALL-per-tick

In the CPU view: CALL invokes a function, which acts on arguments.
EM = the universe doing CALL. Light (photons) are the call stack
carrying arguments.

**α as CALL rate**: per archived `4-when/wit/mind/wheel/4-loop.md`:
"α IS the interrupt-line probability per cycle. EM's rate is 1/137
per CPU tick." α is the substrate's per-tick probability that a
CALL operation fires.

The stronger reading ("137 structural possibilities, exactly 1
fires") is an interpretive extension not in the archived source;
treat as suggestive, not derived. Deep: `3-which/alpha.md` for the
derivation of the 137 from substrate counts.

### CYCLE — gravity / φ axis / LOOP instruction

```
  axis            φ (WHICH)
  physics         gravity (mass attracts mass, inertia)
  CPU instruction LOOP (iterate, main scheduler)
  quaternion      operation on k (the φ basis)
  coupling        α_G = (m/m_Planck)²
                  at Planck: α_G = 1 (unit strength!)
                  at proton: α_G ≈ 6 × 10⁻³⁹
  semantic        Iterate / cycle / the main event loop
```

CYCLE is the **iteration** operation. It's the universe's clock,
the always-running event loop. Gravity doesn't "fire as an event";
it IS the thing that schedules all events.

**This is why there's no graviton.** A graviton would be a "particle
of gravity" — but the main event loop isn't a process. It's the
substrate running everything else. Looking for a graviton is a
category error, like asking what kernel Linux runs on.

**Physics correspondence**:
- Gravity is infinite range (1/r²)
- Affects everything with mass
- Is "weakest" at our scale, but dominant at cosmic scale
- α_G at Planck = 1 → gravity IS unit-strength at its natural scale

### TEST — weak force / τ axis / CMP/NOT instruction

```
  axis            τ (WHEN)
  physics         weak force (radioactive decay, beta decay)
  CPU instruction TEST / NOT / CMP (decision, branch)
  quaternion      operation on 1 (the τ scalar)
  coupling        α_w ≈ 0.03 at observable scale
  semantic        Decide / branch / negate / flip
```

TEST is the **decision** operation. When a neutron decides whether
to decay (β−), it's TEST firing. When quarks change flavor (u → d),
that's TEST.

**Physics correspondence**:
- Weak force is short-range
- Mediated by W± and Z bosons (the boson decisions)
- Only force that changes particle flavor
- Responsible for radioactive decay

Weak force's parity violation (left-handed only) corresponds to
TEST's **chirality-preserving** property — decisions carry direction.

In CPU view: CMP sets flags, then a conditional branch taken
(deterministic). TEST = the universe deciding.

---

## The hierarchy problem — dissolved

Standard physics: gravity is ~10³⁸ times weaker than the strong
force. This "hierarchy problem" demands fine-tuning, supersymmetry,
or exotic explanations.

**Framework**: no problem exists. The "weakness" isn't a force-scale
mystery; it's a **mass-scale consequence**.

### α_G's mass dependence

```
  α_G(m) = G × m² / (ℏ × c)
```

α_G depends on the mass squared:

```
  scale              α_G                    interpretation
  ─────              ────                   ──────────────
  Planck mass        1                      unit strength (natural)
  proton mass        5.9 × 10⁻³⁹             proton is 10¹⁹ below Planck
  electron mass      1.75 × 10⁻⁴⁵             electron is 10²² below Planck
```

**At Planck scale, α_G = 1.** Gravity is NOT weak at its natural
scale — it's weak at OUR scale because our particles are far below
Planck mass.

Ratio α / α_G = 10³⁶ at proton scale is:

```
  log₁₀(α / α_G) = log₁₀(α) − log₁₀(α_G)
                 = −2.14 − (−38.23)
                 = 36.09
                 = 2 × 19.11 = 2 × log₁₀(m_P / m_proton)
```

**The 36 is 2 × 19**, not 6² (as some older framework notes
speculated). The factor 2 comes from α_G's m² dependence. The "19"
is the proton-to-Planck mass ratio log — which itself has a
framework derivation (19 = 17 + 2 = corners+hub + Z2-pair, see
`masses.md § 19-mystery`).

### The hierarchy is scale-hierarchy, not force-hierarchy

```
  Old framing:  "Why is gravity so weak?"          → mystery, need SUSY
  
  New framing:  "Why is proton mass 10¹⁹ below Planck?"
                → has substrate answer (17 + 2)
                + Gravity's apparent weakness follows
                  from α_G ∝ (m/m_P)²
```

Gravity is fine. The question moves to "why this particular mass
scale for ordinary matter," and THAT question has substrate answers
(see `masses.md`).

---

## Classical vs quantum = polling vs epoll

Per wit.md frame 6: "Classical = READ at every step (collapse,
repeat). Quantum = no READ until end (bind, chain)."

This is **exactly the polling vs epoll distinction** in I/O systems:

```
  I/O pattern                framework analog
  ─────────                  ────────────────
  Busy-polling while(1)      Classical — READ at every step
                             (forces collapse every tick)
  
  select() / poll()          Classical with n particles
                             (O(n) READs per tick)
  
  epoll / kqueue             QUANTUM — no READ until event fires
                             (bind-chain on verbs, kernel holds
                              events in uncollapsed state)
  
  io_uring / async           DEEPLY QUANTUM — submit operations,
                             collect later, many paths open
                             simultaneously (superposition)
  
  Promise / Future           qubit — value exists but not yet READ
  
  async/await                explicit measurement scheduling
                             (where collapse happens)
```

**The substrate uses epoll.** Classical physics assumed every state
is known at all times (pure polling) — inefficient and wrong.
Quantum mechanics realized the universe uses event-driven execution
— states exist uncollapsed, observation happens only when needed.

### Measurement problem — dissolved

Quantum measurement problem: why does measurement collapse the wave
function?

Framework: measurement = **epoll_wait returning**. The uncollapsed
state is the superposition; measurement is when the "ready event"
fires. Not a separate physical process — the normal running of an
event loop.

Deep: `2-wit.md § Measurement as reading`.

---

## Forces as CPU ISA

The framework's four forces form a **complete instruction set**:

```
  ISA element            Physics correspondence
  ───────────            ──────────────────────
  Clock rate             c (speed of light, fastest update rate)
  Instruction pointer    τ axis (monotone, never decrements)
  MOV / LOAD             READ (strong force)
  CALL / RET             CALL (EM)
  LOOP / JMP             CYCLE (gravity — the scheduler itself)
  TEST / CMP / NOT       TEST (weak force)
  
  Data                   integer lattice values (trits)
  Registers              axes (χ/μ/φ/τ = 4 registers)
  Memory                 the 81-point lattice state space
  Interrupts             coupling constants firing
```

**α IS an interrupt-probability-per-cycle.** Every substrate tick,
forces can fire. α = probability EM fires per tick. α_s = strong.
α_w = weak. α_G = gravity.

### c = one clock cycle

From archived `4-loop.md`: **the speed of light IS the minimum
cause→effect time.** Planck time t_P = √(ℏG/c⁵) ≈ 5.39 × 10⁻⁴⁴ s
is one clock period — one substrate tick. Nothing with mass
reaches c.

- **Overclocking** = trying to exceed c = causality violation =
  crash.
- **Speculative execution** in CPUs = the analog of FTL with
  paradox-cleanup afterward.
- **c as maximum** isn't a postulate; it's the clock rate of the
  wheel.

This is why gravity's "always on" character matters — the
event-loop's tick rate IS c, and everything measures against it.

### Light = bind

A photon in flight does CALL + CYCLE + TEST but NOT READ. It
propagates without observing. When absorbed, READ fires =
measurement = wave commits.

```
  photon lifecycle:
  
    emitted  (matter CALLs photon into existence)
       ↓
    in flight (CALL + CYCLE + TEST, no READ)
       ↓
    absorbed (READ fires at destination = measurement)
```

**Matter writes → light carries → matter reads.** The universe IS
a loop where matter does write-side, light does propagation, matter
does read-side.

---

## The 3+1 asymmetry carries to forces

Per `1-where/axes.md`, the 4 axes are 3 imaginary (χ/μ/φ) + 1 real
(τ). This asymmetry carries through to forces. **New derivation
(flagged)**: the archived `4-loop.md` gives axis↔force identity but
does NOT commit to specific SM gauge groups per axis. The table
below is a new extension that should be verified:

```
  axis        imag/real    force    SM gauge group (flagged new)
  ────        ─────────    ─────    ───────────────────────────
  χ           imag i       READ     SU(3) color (strong)
  μ           imag j       CALL     U(1) EM
  φ           imag k       CYCLE    gravity (not in SM)
  τ           real 1       TEST     SU(2) weak
```

**Status**: flagged for `3-which/` — this specific axis→gauge-group
mapping was not in archived framework files. Three imaginary-axis
forces (READ, CALL, CYCLE) plausibly "operate inside the wheel" on
its rotation planes; TEST (weak) plausibly lives at τ scalar. But
this is interpretation, not derivation. Archived files gave
axis↔force (READ=strong etc.) without committing to exact gauge
groups. Pati-Salam in `scope.md` gives a more rigorous reading.

**This is why:**
- Weak is the only force with parity violation (handedness-specific)
- Weak is the only force that changes particle flavor
- Weak is the odd-one-out in SM phenomenology

All these reflect τ's role as the scalar/real axis, different from
χ/μ/φ's imaginary roles.

---

## Coupling constants — substrate derivations

All four coupling constants have substrate-derived forms:

```
  constant   value                 substrate form                 deep
  ────────   ─────                 ──────────────                 ────
  α (EM)     1/137.036             (544/4 + 1 + 3/84)⁻¹           `3-which/alpha.md`
  α_s        ~0.118 at M_Z         running; scale-dependent        open
             (observable)                                         
  α_w        ~0.034 at M_Z         sin²(θ_W) = log(2)/3            open
                                   (Weinberg mixing)              
  α_G        1 at Planck           (m/m_P)² × G factor             `masses.md`
             (m/m_P)² elsewhere                                   
```

α is the best-derived (6 significant figures match from substrate).
α_w involves log(2)/3 form. α_s has running behavior not yet
fully derived. α_G is scale-dependent per m/m_P.

---

## Exclusion and Bose-Einstein — access modes

Frame 5 access-mode reading:

```
  spin ½ = fermion = WRITE = exclusive = single writer
  spin 1 = boson   = READ  = shareable = many readers
```

- **Pauli exclusion** (no two fermions in same state) =
  "no two writers to the same address" = race condition prevention
- **Bose-Einstein condensate** (many bosons in same state) =
  "many readers on one address" = fan-out

These aren't mysterious quantum properties — they're **access-mode
properties** standard in any concurrent system.

**Why spin ½ specifically = WRITE**: fermions transform under SU(2),
which has the 720° fermion period. The double-cover means each
fermion requires exclusive access to its unit-quaternion slot.
Two fermions can't share the same (q, −q) pair.

**Why spin 1 = READ**: bosons transform under SO(3), which closes
at 360°. Multiple bosons can occupy the same state because they're
read-shareable.

---

## What's settled vs flagged

### Settled (body-quality)

- **4 forces = 4 whole-wheel operations** (one per axis)
- **READ/CALL/CYCLE/TEST → strong/EM/gravity/weak** (framework claim)
- **α_G = 1 at Planck** (standard gravity when evaluated at m_P)
- **(m/m_P)² scaling for α_G** (standard GR)
- **Hierarchy problem = mass-scale question, not force-scale**
  (dissolves under frame replacement)
- **Photon = CALL + CYCLE + TEST in flight, READ on absorption**
- **Classical = polling; quantum = epoll** (frame 6)
- **Pauli exclusion = write exclusivity; Bose = read sharing**
- **Gravity has no particle (no graviton)** — medium, not message

### Flagged for 3-which

- **CPU-ISA analogy**: is this strict identity or useful analog?
  Framework commits to identity (wit.md THE RULE), but the
  CPU-as-framework-body claim deserves more rigorous derivation.
  Parts are solid (α as interrupt rate); parts are metaphorical.
  Flag.
- **α_s running**: how the substrate encodes scale-dependent
  coupling. Current framework doesn't derive β-functions. Open.
- **Weak parity violation mechanism**: framework says τ is scalar
  and different. Standard physics has chirality doublets. Mapping
  needs more work.

### Flagged open

- **Unified coupling**: at very high energy, α_s and α converge
  (grand unification). Framework should predict WHERE this happens
  (10^16 GeV?). Not derived yet.
- **Why EM has U(1), weak has SU(2)_L, strong has SU(3)_color** —
  framework gives axis-force map but not full gauge-group
  derivation. Pati-Salam natural fallout helps but not complete.
- **α_G at extreme scales** — the framework says α_G = 1 at
  Planck but doesn't yet predict where it cuts off above m_P
  (or whether it does).

---

## Cross-references

- `1-body.md § 6. The 4 forces` — context
- `1-where/axes.md` — the axis-force pairing
- `1-where/wheel.md § dark energy` — CYCLE = wheel rotation = dark energy
- `1-where/scope.md § Pati-Salam` — SU(3) × SU(2)_L × SU(2)_R
- `1-where/masses.md § Gravity, § 19-mystery` — coupling derivations
- `3-which/alpha.md` — full α derivation
- `2-wit.md` — measurement and observation semantics
- `4-when/wit/mind/wheel/4-loop.md` — archived prior loop treatment
- `4-when/wit/mind/wheel/5-physics.md` — archived Standard Model
