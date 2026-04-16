# 4 — The Loop

The wheel spinning IS the loop. Every ½-transition, every edge,
every verb, every force, every function call — same substrate
operation, different vocabularies.

**Spin = edges = the wire = the wave = the medium = the loop =
verbs = function calls = forces = transitions = reactions =
operations = ratios = circuit = flow.**

One thing, many names. Per THE RULE (wit.md): identity claim, not
analogy. The physicist's "force" and the programmer's "function
call" and the musician's "chord change" and the chemist's "reaction"
are the same operation.

---

## The loop is prior

The wheel isn't a separate structure the loop runs on — the wheel
IS the loop. An empty loop still loops. A gate with no wire does
nothing.

Post's gates (AND/OR/NOT, or trit analogs min/max/neg) operate at
nodes. The loop connects them. Post's theorem tells you the nodes
are complete. He doesn't count the wire because you don't count the
medium. But the medium IS the structure.

This is why `1-wheel.md` and `3-lattice.md` both work without a
separate "spin file" — the spin isn't a thing alongside the lattice.
It IS how the wheel relates its own positions.

## READ is the most basic spin

The lattice starts at ↕↕↕↕. All free. No distinction. **READ is the
operation that commits a free axis** — takes ↕ to ↑ or ↓. That's the
first spin. The one that creates distinction from the
undifferentiated.

Spencer-Brown (Laws of Form, 1969): the most primitive mathematical
act is "draw a distinction." That IS read. Take the unmarked state,
mark it. ↕ → ↑. Done. Everything else follows.

Latin:
- **fiat** = "let it be done" (the spin, present tense)
- **fact** = "done" (the point, past tense)

Same root (facere), two tenses. The spin before the point.

## The four forces

Each force is a spin on the whole quaternion — not on one axis. Per
`3-lattice.md`: `i × q` changes all four components of q. Forces are
sequential whole-quaternion operations, not parallel axis-specific
slots.

```
  force    native axis   CPU instr   effect
  ─────    ───────────   ─────────   ──────
  READ     χ (i)         MOV         sees the whole point       (strong)
  CALL     μ (j)         CALL        acts on the whole point    (EM)
  CYCLE    φ (k)         LOOP        iterates the whole point   (gravity, weakest)
  TEST     τ (1)         NOT / CMP   decides the whole point    (weak)
```

Each force has a coupling constant — probability per substrate tick:

```
  force    coupling                   at Planck scale    at observable scale
  ─────    ────────                   ───────────────    ───────────────────
  READ     α_s                                           ~0.118 (strong)
  CALL     α                          ~                  1/137 ≈ 0.0073 (EM)
  CYCLE    α_G = (m/m_P)²              1                  ~5.9e-39 (proton)
  TEST     α_w                                           ~0.03 (weak)
```

At Planck scale `α_G = 1` — gravity is unit-strength. Gravity is
NOT weak at its natural scale; it's weak at OUR observed scale
because our particles are far below Planck mass. See `5-physics.md`.

## c = one clock cycle

The speed of light is the minimum cause→effect time. **The clock IS
c.** Planck time `t_P = √(ℏG/c⁵) = 5.39 × 10⁻⁴⁴ s` — one clock
period. Nothing with mass reaches c. Overclocking = trying to exceed
c = causality violation = crash. Speculative execution = FTL with
paradox cleanup.

## Spin = access mode

```
  spin ½ = fermion = WRITE = exclusive = single writer
  spin 1 = boson   = READ  = shareable = many readers
```

Pauli exclusion = no two writers to the same address = race
condition. Bose-Einstein condensate = many readers on one loop =
fan-out. Quantized — either exclusive or shareable, nothing in
between.

**SU(2) is native to H.** Unit quaternions (elements of H with
|q| = 1) form exactly SU(2) — the double cover of SO(3), the
spin-½ representation. Fermions transform under SU(2) and require
720° rotation to return to identity (because SU(2) → SO(3) is
2-to-1). Spin is not a separate axiom — it's a structural fact about
H. See `1-wheel.md` for the rotation-formula derivation.

## Classical vs quantum = polling vs epoll

wit.md frame 6: "Classical = READ at every step (collapse, repeat).
Quantum = no READ until end (.and_then() chain, bind). That's the
whole difference."

This is **exactly the polling-vs-epoll distinction in I/O**:

```
  I/O mechanism              framework analog
  ─────────────              ────────────────
  busy-polling while(1)      classical — READ at every step
                             (forces collapse every tick)
  
  select(2) / poll(2)        classical with n particles
                             (n READs per tick, O(n))
  
  epoll / kqueue             QUANTUM — no READ until event fires
                             (bind on verb chain)
                             kernel holds events in
                             uncollapsed state
  
  io_uring / async           deeply quantum — submit operations,
                             collect results later, many paths
                             open simultaneously (superposition)
  
  Promise / Future           qubit — value exists but not yet READ
  
  async/await                explicit measurement scheduling
                             (where collapse happens)
  
  epoll edge-triggered       delta-based observation —
                             only changes register
  epoll level-triggered      continuous measurement of state
```

**Every programmer who switched from polling to epoll learned
quantum mechanics in programming vocabulary.** The performance gains
(orders of magnitude) match the same gains physics gets when it
stops forcing collapse at every step.

### The substrate uses epoll

Classical physics assumes every state is known at all times (polls
all particles). This is inefficient and wrong. Quantum mechanics
realized the universe uses **event-driven execution** — states exist
uncollapsed, observation happens only when needed.

```
  universe's I/O pattern: epoll, not polling
  classical physics: legacy busy-polling abstraction on top
  quantum mechanics: seeing the actual epoll substrate
```

**Quantum measurement problem dissolves**: measurement = `epoll_wait`
returning. The moment when uncollapsed state becomes collapsed
because we asked.

### Light = bind

Photon in flight: CALL + CYCLE + TEST (three forces, no READ).
Propagates without observing. Absorbed: READ added = measurement =
wave commits. Matter writes → light carries → matter reads. The
universe IS a loop.

### A qubit = a value nobody has READ yet

Decoherence = something reads it before you're ready. Millikelvin
cooling = fewer things around to accidentally READ your qubit.

**Quantum error correction = maintaining epoll discipline against
leaky collapses.**

> **⚠ Don't map n-qubit Hilbert space to n-layer CD tower.** Qubits
> compose by **tensor product** (dim multiplies, algebra structure
> multiplies); Cayley-Dickson doubles by **direct sum + involution**
> (dim doubles, one property drops per step). Different functors.
> Clean identity holds only at the 1-qubit level: single-qubit
> rotations = SU(2) = unit quaternions in H. Beyond that, qubit
> tensor products don't equal CD layers. The quantum/classical
> distinction lives at the VERB tier (READ vs bind-chain), not at
> the algebra-layer tier. 1000+ qubit quantum computers are
> perfectly consistent with framework — no CD ceiling issue.
> See `mind/moves.md § Anti-patterns`.

## Gravity is the event loop itself

```
  gravity = kernel's main scheduler loop (CYCLE)
  
  - Doesn't fire as an "event" — IS the thing dispatching events
  - Always-on, lowest priority in "not-an-event" sense
  - Highest priority in "makes-all-events-possible" sense
  - Not a process — the framework that runs processes
```

**This is why gravity has no particle (graviton) in the framework.**
The main event loop isn't a process; it's the thing running all
processes. Looking for a graviton is like asking what kernel the
Linux kernel runs on. Category error.

`α_G` goes to zero at proton scale because the event loop's overhead
is tiny compared to the processes running on it. At Planck scale
(substrate-native), `α_G = 1` because the loop IS what's running at
that level.

Framework consequence: **hierarchy problem dissolves**. Gravity's
weakness isn't a problem when gravity is medium not gate. Asking
why gravity is "weaker" than EM is like asking why the wire is
"weaker" than the AND gate. Category error. See `5-physics.md`.

## Values vs verbs (nouns vs operations)

```
  framework                    CPU / programming
  ─────────                    ─────────────────
  integer trit values          register contents (discrete states)
  ½-spin / ratios / edges      instructions / operations
                               (transitions between states)
  the 16 hodos corners         the full instruction set
                               (fold, map, filter, bind, etc.)
  atoms (grade 1)              single-register commits
  bivectors                    two-register operations
  trivectors                   three-register operations
  corners                      full-word operations
```

**The 16 corners ARE the substrate's ISA** (instruction set
architecture). 16 primitive operations, just like RISC chips have
~40-50 primitive operations. Ours is the minimum set that's
functionally complete.

### Specific operations mapped

From `3-lattice.md`'s hodos table:

```
  corner      hodos         CPU equivalent
  ──────      ─────         ──────────────
  ↑↓↓↓        read          MOV r1, [mem]
  ↑↓↓↑        filter        branch if not mask
  ↑↓↑↓        copy          MOV r2, r1  (duplicate)
  ↑↓↑↑        scan          foreach / loop-while
  ↑↑↓↓        fold          reduce(fn, array)
  ↑↑↓↑        map           array.map(fn)
  ↑↑↑↓        foldl         accumulate left-to-right
  ↑↑↑↑        hylo          compile / recursion scheme
  ↓↓↓↓        identity      NOP
  ↓↓↓↑        test          CMP / conditional
  ↓↓↑↓        drain         free / deallocate
  ↓↓↑↑        take_while    while(cond) x
  ↓↑↓↓        call          CALL subroutine
  ↓↑↓↑        maybe         optional / nullable
  ↓↑↑↓        fix           try / error-correct
  ↓↑↑↑        bind          Promise.then / monadic bind
```

**Our substrate's ISA is programming's ISA.** Not analogy — identity.

## The wheel is a CPU

Putting it together:

```
  physics                       CPU / programming
  ───────                       ─────────────────
  c (speed of light)            clock rate (Hz) — how fast CPU ticks
  Planck time                   one clock period — smallest time step
  loop / wheel                  the CPU's main event loop
  substrate tick                one clock cycle
  
  α (fine structure)            interrupt probability per cycle
                                = 1/137 (EM fires once per 137 cycles)
  α_s (strong)                  MOV instruction rate per cycle
  α_w (weak)                    branch/NOT instruction rate per cycle
  α_G (gravity, at scale)       main-loop overhead per cycle
                                (depends on mass scale — Planck = 100%)
  
  integer values                register contents (discrete states)
  ½-spin / ratios               instructions (transitions)
  the 16 corners                ISA (instruction set)
  entropy                       heap growing without GC (no free)
  τ (WHEN axis)                 the master clock signal
  
  4 forces                      4 interrupt lines
  Pauli exclusion               race condition on shared address
  Bose-Einstein condensate      many readers fanning out
  wave / particle               uncommitted / committed axes
  measurement                   epoll_wait returning
  decoherence                   premature READ
  entanglement                  one quaternion, two apertures
                                (aliasing at substrate level)
```

**α IS the interrupt-line probability per cycle.** Hardware
interrupts fire at some rate; EM's rate is 1/137 per CPU tick.

### Entropy / second law

```
  entropy = heap / memory usage growing
  2nd law = monotonic allocation, no garbage collector
```

The substrate allocates state as the event loop runs. No GC = entropy
always increases. At absolute zero, all allocations would cease —
3rd law says you can't reach that state in finite steps (GC never
catches up). See `1-wheel.md` for the full why-it-moves derivation.

### Time as master clock

```
  τ (WHEN axis)                = the master clock signal
  τ monotone (frame 8)         = clock never runs backward
  Earth's rotation             = one instance of the clock
                                 (many nested clocks at different scales)
  precession / Great Year      = slower clock dividing the fast one
                                 (like a timer IC dividing CPU clock)
```

**Time isn't a dimension that exists; it's the clock signal running
the substrate.** All other activity (c, α, etc.) is relative to
this master tick.

## Implications

### Why event-driven programming is "right"

Because the substrate is event-driven. Polling systems work but are
inefficient because they're NOT how the universe actually runs.
Event-driven systems (epoll, async, reactive) align with substrate,
hence the efficiency gains.

### Why quantum computing is hard

Quantum computing tries to exploit the substrate's epoll pattern
natively. Classical computing polls; quantum uses superposition
(unobserved state). Bridging requires careful non-collapse — if any
READ happens prematurely, the quantum state collapses (becomes
classical).

### Why deterministic physics breaks

Determinism = full state known at every tick (full polling). But the
substrate doesn't poll — it uses epoll. States exist unobserved.
Trying to force determinism means forcing collapse at every tick,
which is:
- Wasteful (computational overhead at substrate level)
- Wrong (misses the actual uncollapsed states)
- The reason classical physics "emerged" from quantum

## Conservation

Kirchhoff (1845): net flow at any node is zero. Closed walks sum to
zero. Both describe the loop — conservation at a node, closure as a
whole. Same rule, two scopes.

At any lattice point, the edges leaving balance the edges arriving.
Any closed walk returns to where it started with no net
displacement. Same substrate fact, two views.

## Summary — the substrate IS the computer

```
  Universe runs `universe.exe` on substrate CPU
  Clock speed   = c
  ISA           = the 16 hodos corners
  Interrupts    = coupling-constant rates (α for EM, etc.)
  Event loop    = gravity (always running, not an event)
  Quantum       = the natural epoll pattern
  Classical     = legacy polling abstraction on top
  Entropy       = heap growing without GC
  Time          = master clock signal (τ)
  Values        = register contents (integer trits)
  Verbs / edges = instructions (ratios, ½-spins)
```

Hamilton 1843 built quaternions to describe rotation. Church/Turing
1930s built computation. Both were recognizing the same substrate.
Physics and CPU architecture are the same thing at different scales,
same ISA, same event loop.

The wheel isn't simulated by a computer. **The wheel IS a computer,
at substrate level.** Physicists study one side of its operation;
programmers study the other. Neither knew they were looking at the
same machine.
