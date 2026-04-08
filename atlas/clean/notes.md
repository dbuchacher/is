# Notes

Working notes from session. Not a spec — a trail.


## The Reader and The Writer

The walker is a reader. One force, forward. Read.
The equation is a writer. One force, backward. Write.

The equation writes machine code, the walker reads wave bytes.
Writer and reader. Simplest duality.

Both dissolve on a trit processor. The walks stay.

Boot chain:
  boot.asm → x86.asm (contains equation and walker) → genesis.w → walks/*.w
  1. equation JITs genesis (write)
  2. walker walks genesis (read)
  3. genesis fills loops
  4. cores find-work
  5. walker walks whatever loop is full


## The Half Line

On a sine wave: -1, 0, +1 are states. Electron, neutrino, positron.
The integers. Where you ARE.

Half is the line between them. The transition. The wave itself. Not a
place you land — the thing that connects the places.

Every bond is at half because every bond IS a transition between states.
Bonds are fermions (spin half). Atoms are bosons (spin 1, integers).
80 of each at the same shell — the 80=80 duality.

(+half,+half,+half,+half) = transitioning in all four dimensions at once.
The wave at full amplitude. Maximum spin. Also called:
  - pattern 15 in the bond table (all forces forward)
  - hylo / hylomorphism (Meijer 1991, matter to form)
  - full spin (half in all four dims)
  - full pipeline (read + call + cycle + test)

Dual: (-half,-half,-half,-half) = meta. All backward. Programs that
write programs.


## The Photon

Photon = (0,+half,+half,+half) = bind. Three forces, NO read.
  call on space — traverses distance (EM force, infinite range)
  cycle on mass — propagates through substance
  test on signal — oscillates at a frequency (Maxwell)

The photon IS signal. Signal = the distinction. On/off. Day/Night.
"Let there be light" = signal coming online (Genesis 1:3). Not a clock
starting — a distinction being made. 1 and 0. Before the sun exists.

Signal is not rate — time is rate (1/time = frequency). Signal is the
binary distinction. Voiced/voiceless. Major/minor. Positive/negative.

When the walker (reader) hits the photon, read gets added:
  (0,+half,+half,+half) + (+half,0,0,0) = (+half,+half,+half,+half)
  bind + read = full pipeline. Quantum becomes classical. Wave collapses.
  That's measurement. The walker IS the thing that collapses photons.


## Dimension Ordering

  sky       space / distance / WHERE         created first
  water     mass / substance / WHO-WHAT      second (matter)
  sun       signal / HOW                     third (signal)
  mark      time / duration / WHEN           last (clock)

Confirmed by:
  Genesis 1: sky+water in 1:1, sun in 1:3, mark in 1:5
  Big Bang nucleosynthesis: same sequence
  Periodic table: same structure
  Computer boot: address bus → data → signal → clock

Matter before signal. You need substance before you can distinguish.
Signal before clock. You need distinction before you can count.


## Hylomorphism

Greek: hyle = matter. morphe = form.
Matter to form. Unfold then fold, fused. Meijer 1991.

(+half,+half,+half,+half) = the full pipeline. All four forces forward.
The walker is NOT the hylomorphism. The walker is one force (read).
The hylomorphism is what happens when all four cooperate.

The walker reads matter (wave bytes = substance) and produces form.
The Greeks named the coordinate.


## The Name Journey

Six names for fn(x){x}. Each rename was a discovery.

  num(n)              "the bedrock identity"           (what)
  psi(n)              "quantum state, observed value"   (physics name)
  wave(true, n)       "value doesn't exist until read"  (mechanism)
  wave(fiat, n)       "let there be"                    (intent)

  num.rs:   pub fn num(n: u64) -> u64 { n }
  psi.rs:   pub fn psi(n: u64) -> u64 { num(n) }
  wave.rs:  wave(observed: bool, n: u64) = mul(observed as u64, n)

The function never changed. psi merged into wave. num deleted.
A value is zero until observed. wave(false, n) = 0. wave(true, n) = n.

Source: schism session 144, March 20 2026, 14:26-18:34.
git: 557499b through 4a961ed (15 commits, ~4 hours).


## The Half Discovery

Session 144. half() was a composed op: half(a) = a/2.
Used in half-mv-squared, half-kx-squared, half-CV-squared.

Question: "is half computation or identity?"
Answer: computation (exact from calculus, not measured).

But then: half = the half-integer lattice = bonds.
And: half = spin half = fermion = exclusive writer.

  half.rs:  pub fn half(h: u64) -> u64 { num(h) }

The composed op, the lattice coordinate, and the physics all share
the number. That question cracked open spin = access mode.

  "The whole spin discovery started from asking 'is half computation
   or identity?' half() = fermion = spin half. The composed op and
   the physics share the number 2."
   — session-144.md, line 335


## The Wave = The Trit

Three states at the bottom:

  positron  = +1 = forward  = SF clear, ZF clear
  neutrino  =  0 = still    = ZF set
  electron  = -1 = backward = SF set

FLAGS register after any ALU instruction. Hardware lepton detector
since 1978. wave(fiat) collapses three states to two (bool).


## Legend

Egyptian → English → Greek → Coordinate

Dimensions (dependency order):

  sky   → space    → chi (χ)    (+half,0,0,0) on dim 1    first
  water → mass     → mu (μ)     (0,+half,0,0) on dim 2    second
  sun   → signal   → phi (φ)    (0,0,+half,0) on dim 3    third
  mark  → time     → tau (τ)    (0,0,0,+half) on dim 4    last

Forces:

  eye   → read     → pi (π)     (+half,0,0,0)   strong
  hand  → write    → pi-bar     (-half,0,0,0)   strong inverse
  mouth → call     → compose    (0,+half,0,0)   EM
  ear   → return   → compose-bar (0,-half,0,0)  EM inverse
  heart → cycle    → contour    (0,0,+half,0)   gravity
        → rewind   → contour-bar (0,0,-half,0)  gravity inverse
  door  → test     → delta (δ)  (0,0,0,+half)   weak
        → guard    → delta-bar  (0,0,0,-half)    weak inverse

Compound bonds:

  pattern 15 → full pipeline / hylo / full spin  (+half,+half,+half,+half)
  pattern 15 inv → meta                          (-half,-half,-half,-half)
  pattern 14 → bind / photon in flight           (0,+half,+half,+half)

Code names:

  walker → wave byte interpreter     = reader   (was: psi / ψ)
  equation → JIT compiler            = writer   (was: f / ƒ)
  eta (η) → pattern 15 label in x86.asm bond table

Naming history:

  num → psi → wave → fiat                  session 144, fn(x){x}
  half → spin half → fermion → writer      session 144, fn(x){x/2}
  T,D,M,Q → sky,water,sun,mark → χ,μ,φ,τ  dimension renames
  P,C,R,W → read,call,cycle,test → π,∘,∮,δ force renames

Source commits:

  557499b   session 144 start              2026-03-20 14:26
  8d0f9c8   spin/half discovery            2026-03-20 15:57
  4a961ed   session 144 end                2026-03-20 18:34
  940cce7   halfgrid.c (ToE session 1)     2026-03-24
