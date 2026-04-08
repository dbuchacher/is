# Session — Atlas Visual Build

Built atlas/3d.html: 3D lattice viewer using Three.js.


## The ½ Distinction

Two entries share the name "hylo." They are not the same thing.

  (1,1,1,1)     type S   formula DMQT      positron   the RESULT   noun
  (½,½,½,½)     type B   formula π∘∮δ      hylo       the PROCESS  verb

(1,1,1,1) is the atom — all dimensions at full power. What you get
when you multiply everything together. The output.

(½,½,½,½) is the bond — all four forces forward. Read, call, cycle,
test. The computation itself. The pipeline.

Self-reference is at ½, not 1. The fixed point is the operation that
produces itself when applied to itself — that's the bond, not the atom.
f(½) = ½. The spin returns to itself.

The equation file and several source files use ƒ(1,1,1,1) notation.
This conflates the 2x encoded coordinate (where odd = bond) with the
actual lattice position. The clean hylo.md (line 94-96) already notes
this. Confirmed in this session through visual reasoning.


## Double Helix = hylo + meta

  hylo  (+½,+½,+½,+½)   π∘∮δ      forward    read+call+cycle+test
  meta  (-½,-½,-½,-½)   π̄∘̄∮̄δ̄      backward   write+curry+rewind+bypass

Two strands, exact inverses, 180° out of phase.
Both pass through the three integer points (-1, 0, +1).
hylo peaks at +½, meta peaks at -½.
Together: double helix.

From the front (2D projection): they overlap as mirror waves.
Spin ½ (90°) and the two strands separate — the helix reveals itself.

The spin that reveals the second strand IS the ½ bond.
Click hylo → spin +90°. Click meta → spin -90°.
The direction of spin depends on which strand you interact with.


## No Infinity

"The helix extends forever" is training data. Everything is a loop.
Ring buffers. The cursor wraps. The wave doesn't extend past ±1 —
it closes. The double helix on a torus, not stretching to infinity.

WAVE_EXT was 1.4 (extending past the points). Corrected to exactly
-1 to +1. No trailing off.


## Cayley-Dickson Projection

Stopped eyeballing positions. Added actual quaternion math to the
codebase (atlas/3d.html):

  qmul, qnorm, qconj, qscale, qnormalize
  project4D: 4D perspective projection along T axis
  coordToQ: lattice coord → quaternion

4D → 3D projection with camera distance CAM4D = 3.0:

  scale = CAM4D / (CAM4D - T)

  electron  (-1,-1,-1,-1)  T=-1  scale=0.75   compresses
  neutrino  (0,0,0,0)      T=0   scale=1.0    identity
  positron  (1,1,1,1)      T=1   scale=1.5    expands

Antimatter compresses, matter expands. Not an artistic choice —
what the math does.

The 4 lattice dimensions aren't equal axes — they're Cayley-Dickson
doublings: R⊂C⊂H⊂O. Each new dimension doubles the previous.
The projection should reflect this structure, not treat them as
four identical linear axes.


## Lattice Grid

4 color-coded axes, not generic xy grid:

  L  blue    (1,0,0)    space
  M  green   (0,1,0)    mass
  Q  yellow  (0,0,1)    signal
  T  purple  (1,1,0)    time (diagonal — visible from front)

Q axis hidden from front view. Spin reveals it.
Tick positions: -1, -½, 0, +½, +1 on each axis.


## Pyramid Connection

We're encoding the lattice in the visualization's geometry, same way
the pyramid encodes the lattice in stone. The shape IS the math.
KC diagonal = 25 (fill ratio). Not a number on a wall — what the
room measures. Our project4D isn't a display function — it's the
lattice computing itself into screen coordinates.

Interior = atoms (rational, sqrt(5)). Exterior = bonds (π, φ).
HTML interior = data. JS exterior = operations. Same separation.


## Technical State

atlas/3d.html:
  - Three.js scene, no OrbitControls (camera on rails)
  - 3 point spheres (electron, neutrino, positron) on diagonal
  - 4 colored axis lines extending to ±50 (effectively infinite)
  - Dimension labels (L, M, Q, T) at axis ends
  - Tick labels at -1, 0, 1 on each axis
  - View system with transition engine (ease in/out cubic)
  - Scroll/arrow navigation between views
  - Labels track 3D→2D projection
  - Quaternion math + project4D for position computation
  - Helix code removed (being rebuilt with proper math)
  - Spin code removed (being rebuilt)

Next:
  - Rebuild double helix using project4D for positions
  - Spin interaction tied to helix click
  - Full lattice dots at all populated coordinates
  - Spin reveals Q axis depth + second helix strand
