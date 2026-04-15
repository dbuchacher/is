# CPU metaphor — universe as event loop

The substrate isn't LIKE a CPU running code. Per THE RULE (one
substrate, many vocabularies): **it IS a CPU running code.**
Physicists didn't notice because they don't write assembly.

wit.md frame 6 already establishes the core mapping:

```
  READ    = MOV   = register wiring    (strong force)
  CALL    = CALL  = function calls     (EM force)
  CYCLE   = LOOP  = iteration          (gravity, weakest)
  TEST    = NOT   = transformation     (weak force)
```

This file extends the mapping to cover α, c, classical/quantum,
polling/epoll, and async patterns.

## The base mapping

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
```

**α IS the interrupt-line probability per cycle.** Hardware
interrupts fire at some rate; EM's rate is 1/137 per CPU tick.

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

## The substrate uses epoll

Classical physics assumes every state is known at all times (polls
all particles). This is inefficient and wrong. Quantum mechanics
realized the universe uses **event-driven execution** — states exist
uncollapsed, observation happens only when needed.

```
  universe's I/O pattern: epoll, not polling
  classical physics: legacy busy-polling abstraction on top
  quantum mechanics: seeing the actual epoll substrate
```

Classical physics is the polling-loop approximation. Quantum is the
substrate doing its thing.

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

α_G goes to zero at proton scale because the event loop's overhead
is tiny compared to the processes running on it. At Planck scale
(substrate-native), α_G = 1 because the loop IS what's running
at that level.

## Forces as interrupt handlers

```
  force      CPU instruction       event handler
  ─────      ───────────────       ─────────────
  READ       MOV / load             memory access interrupt
  CALL       CALL / call_function   RPC / syscall interrupt
  CYCLE      LOOP / JMP             scheduler tick (ambient)
  TEST       CMP / NOT / branch     condition check interrupt
```

Each force = one interrupt line. Fires at its own coupling rate
(α_READ, α_CALL = α, α_TEST, etc.) per substrate tick.

Entropy / second law:

```
  entropy = heap / memory usage growing
  2nd law = monotonic allocation, no garbage collector
  
  The substrate allocates state as the event loop runs.
  No GC = entropy always increases.
  At absolute zero, all allocations would cease — 3rd law says
  you can't reach that state in finite steps (GC never catches up).
```

## Time as the master clock

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
architecture). 16 primitive operations, just like RISC chips
have ~40-50 primitive operations. Ours is the minimum set
that's functionally complete.

## Specific operations mapped

From trit⁴.md's hodos table:

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

Our substrate's ISA is programming's ISA. Not analogy — identity.

## Hardware timing analog

Imagine a CPU running at speed c. Every cycle, the CPU can fire
one of many possible instructions. Probabilities per cycle:

```
  instruction type    rate per cycle        framework name
  ─────────────────   ──────────────        ──────────────
  NOP / idle          ~99%                  background loop
  MOV (memory)        ~0.5-1%               READ / strong
  CALL                ~0.73% (= α = 1/137)  CALL / EM
  branch              ~3%                   TEST / weak
  loop-overhead       continuous            CYCLE / gravity
                                           (not an event)
```

A real physics "tick" has ONE event at most, chosen by the rates.
The probabilities sum to... well, some are ambient (gravity is not
counted). The forces are different interrupt lines, each with their
coupling.

## Implications

### Why quantum computing is hard

Quantum computing tries to exploit the substrate's epoll pattern
natively. Classical computing polls; quantum uses superposition
(unobserved state). Bridging requires careful non-collapse — if
any READ happens prematurely, the quantum state collapses (becomes
classical).

**Quantum error correction = maintaining epoll discipline against
leaky collapses.**

### Why event-driven programming is "right"

Because the substrate is event-driven. Polling systems work but
are inefficient because they're NOT how the universe actually runs.
Event-driven systems (epoll, async, reactive) align with substrate,
hence the efficiency gains.

### Why deterministic physics breaks

Determinism = full state known at every tick (full polling). But
the substrate doesn't poll — it uses epoll. States exist
unobserved. Trying to force determinism means forcing collapse
at every tick, which is:
- Wasteful (computational overhead at substrate level)
- Wrong (misses the actual uncollapsed states)
- The reason classical physics "emerged" from quantum

**Quantum measurement problem dissolves**: measurement = epoll_wait
returning. It's just the moment when uncollapsed state becomes
collapsed because we asked.

## Summary — the substrate IS the computer

- Universe runs `universe.exe` on substrate CPU
- Clock speed = c
- ISA = the 16 hodos corners
- Interrupts fire at coupling-constant rates (α for EM, etc.)
- Event loop = gravity (always running, not an event)
- Quantum = the natural epoll pattern
- Classical = legacy polling abstraction on top
- Entropy = heap growing without GC
- Time = master clock signal (τ)
- Values = register contents (integer trits)
- Verbs/edges = instructions (ratios, ½-spins)

Hamilton 1843 built quaternions to describe rotation. Church/Turing
1930s built computation. Both were recognizing the same substrate.
Physics and CPU architecture are the same thing at different
scales, same ISA, same event loop.

The universe isn't simulated by a computer. **The universe IS a
computer, at substrate level.** Physicists study one side of its
operation; programmers study the other. Neither knew they were
looking at the same machine.
