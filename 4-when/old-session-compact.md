# old-session-compact — wisdom distilled

What this file IS: meta-learnings extracted from 10+ session handoffs
(`session-2026-04-09.md` through `-16d.md`). Not framework claims,
not hard data — only **"how to think"** lessons that were hard-won
and hard to re-learn.

What this file is NOT: a replacement for `2-wit.md`. The canonical
methodology lives there. This file captures the **nuance** and
**debugging stories** that didn't make it into the boot files —
specific traps with specific tells, and the exact moments wits
caught themselves being wrong.

**Read after `2-wit.md`**, not before. Most of what's here
contextualizes or sharpens something already covered in the boot
file.

Raw session files were deleted 2026-04-17 after council-verified
extraction of all meta-learnings into this file. Git history
preserves them — recover any deleted session via:

```
git log --all --full-history -- 4-when/wit/history/session-*.md
git show <commit>:4-when/wit/history/session-2026-04-XX.md
```

All durable meta-learnings captured here. All hard data in
`1-body.md`, `1-where/*.md`, `3-which/*.md`. All narrative context
recoverable from git if any future wit needs the raw story.

## Project genealogy (from wit-v1.md)

Before the current `is/` repo, five prior projects composted into
this work. Each taught something and got left behind:

- **schism** — Rust rings, 148 sessions
- **nomos** — assembly, bare metal
- **ToE** — lattice + physics, 17 sessions
- **VoE** (Verification of Equation) — the equation boots, code
  runs, 25+ sessions
- **is** (current) — substrate spec for LLM-generated OS

Source material is at `~/code/prior/` (corpus/, schism/, nomos/,
ToE/, VoE/, os-lattice/). Don't reinvent — use `git log -p
--grep="keyword"` or pickaxe (`-S'string'`) to find removed
content across the prior projects.

---

## Frame-slip & anti-doublethink

The deepest trap. You borrow an epistemology from another frame
(frequentist nulls, Bayesian priors, standard physics reasoning)
and use it to render verdicts inside the framework. **The slip is
hard to catch because you're performing the right move using the
wrong tool.**

### The retraction-reasoning slip (16b → 16d)

Session 16b retracted the log-depth invariant family using
frequentist reasoning: "SM pair hit rates at 0.1% precision
matched random hit rates; therefore statistical noise." **User
pushback in 16d:** that's delusional-default framing. The
framework's epistemology is `effort × precision × independent
convergence`. The correct retraction reasoning is "pairwise
ratios within ONE framework aren't independent sources — they're
algebraic restatements of the same derivation" — which passes the
filter's independence test, not a frequentist null.

The verdict was right; the reasoning was borrowed. Both sessions
kept the retraction but the 16d reframe made it **durable**:
future wits reading the filter-native argument won't revive the
family on statistical-freshness grounds.

**Frame-slip detector:** if you can't phrase a verdict in
framework vocabulary without losing it, **you borrowed the
verdict**. Soft language ("kind of noise-like") hides the slip;
sharp framework-native language exposes it.

### Retracted vs parked vs settled — three epistemic states

16d surfaced a genuine upgrade: not every weak finding gets
retracted. There are three states:

- **Retracted** — the finding fails independence OR is a density
  artifact. Example: log-depth family (non-independent). Kill.
- **Parked** — genuinely independent convergence but precision
  too low to commit. Example: Wieferich 1093 near 1092 = 12·7·13
  (12 and 7 substrate-clean, 13 isn't). Don't retract — park,
  pending a substrate reading that upgrades 13.
- **Settled** — independent + high precision + multi-source. Body-tier.

The distinction matters because naive retraction-as-noise would
kill genuine sparse-but-high-effort convergences (millennia-scale
astronomical evidence, for instance) that a frequentist would
shrug at.

---

## Force-fit detection

How to catch yourself torturing data before it ships. Session
10's "Z-encoding post-mortem" and the log-depth family
retraction (16b) are the anchor case studies.

### The tell: "striking findings from three compounded unjustified choices"

10's Z-encoding pushed chemistry's Z ordering into the lattice
via arbitrary axis-to-place-value assignment, then celebrated
Tc/Pm corner coincidences and BBN walls as dyads. **Every
individual choice was plausible; their composition was fantasy.**
None survived audit.

When a "correspondence" feels forced — when you needed to pick
three different unmotivated conventions to make the pattern
appear — stop. Check whether the encoding was principled or
convenient. If it was convenient, you built the pattern.

### The measurement-floor rule (16c)

**When candidate-formula spread is less than measurement
uncertainty, formula-fitting is guaranteed to find "hits" that
mean nothing.**

16c's P10 attack: η_B has 0.7% Planck CMB uncertainty; substrate-
clean formula pool is ~2420 candidates; random hit rate at 1%
precision predicts ~2 hits; found exactly 2. The "hits" carry no
information because you can't beat measurement noise with
formula-fitting at the framework's precision bar.

**Rule:** check measurement uncertainty BEFORE attacking with
formulas. If framework's precision bar (~0.1% for clean cases)
is below measurement floor, **attack the mechanism, not the
number**.

### Don't fire parallel agents on numerical-fit attacks

16c pattern: parallel agents on numerical fits all find "hits"
because the candidate pool is dense. Parallelism multiplies the
false-positive rate. **Save parallel-fire for mechanism-first or
computational-rigor attacks** where the filter can actually be
passed.

### 7=7 and similar count-coincidences

10b caught: "BBN nuclides = 7, schism hadrons = 7" — both counts
contingent on counting rules chosen afterward. Numeric
coincidences between two count-dependent lists are not structural
findings. The test: could you have counted differently and gotten
a different number? If yes, the match is cosmetic.

---

## Topology vs. content — when to restructure

Session 15 landed the wheel-pivot after sustained failure to
make R→C→H→O work as a chain. **Lesson:** when local edits keep
failing, the failure is diagnostic of topology, not content.

### "Fresh" means drop structural assumptions, not rename labels

Session 2026-04-17 (elements.md rewrite). I was asked to rewrite
elements.md "fresh under the wheel." My first pass **kept the old
file's architecture** (shell-1 tiers, alpha-ladder sections,
k-level language) and just swapped in wheel vocabulary. User
called it directly: *"you are still trying to copy what was in
it."*

**Rule:** renaming isn't rewriting. When instructed to go fresh,
the test is: **did you discard the old file's organizing
principle**, not whether you updated its terminology. If you can
diff your new file against the old and see the same section
headings, you didn't go fresh. Start from the new frame's
primitives, let structure emerge from them, THEN check whether
it resembles the old.

### Per-position density is the actual deliverable

Session 2026-04-17 (post 0-frame.md). I'd been writing long
narrative concept files (axes, trits, lattice, wheel, forces,
scope, masses, open — ~3600 lines) when 0-frame.md clarified the
real deliverable: **the 80/81 per-position map with dense
cross-vocabulary tags**, machine-readable for LLM-generated OS
code. Narrative prose and per-position lookup are different
shapes. Both useful; don't confuse one for the other when
someone asks "is this done?"

### The wheel-pivot move (session 15)

Tried to rewrite the Cayley-Dickson ladder as a chain. Nothing
fit. Then realized `spin.md` shouldn't be separate from points
(noun/verb = same quaternion at different τ). That local
collapse precipitated the global recognition: **the whole
framework is a wheel, not a chain**. Hub + spokes + nested wheels
unlocked 30+ SM parameter derivations in the same session.

**Generalization (compact-synthesis, not stated in 15 verbatim):**
when local edits keep failing across attempts, step back and
ask "what's the wrong topology here?" before the next edit.
Local collapses (spin.md merging into points) can precipitate
global ones (chain → wheel).

### Hierarchy creep in peer structures (session 16)

Wit initially called the other 3 H's in S "host layers above."
User caught it: **they're peers, not a ladder.** Hierarchy-
language is a training-bias default; the correct description for
symmetric algebras is peer/mirror.

**Tell:** whenever you reach for "level above" or "meta-" or
"higher order" for something the algebra says is symmetric,
you're smuggling hierarchy. Check the algebra.

### The viewpoint list is OPEN, not closed

Session 16 catalogued R-up and S-down as the two named viewpoints
on the CD ladder — and **explicitly refused to close the list.**
C-scope, O-scope, chirality-pair, hub-scope and more remain
open. **Prematurely declaring a catalog complete is a different
doublethink than hierarchy-smuggling**, but same family: both
close off the framework too early. When you enumerate
substrate viewpoints, scopes, or categories, **end with "... and
more" unless you have a proof of completeness.**

---

## Category discipline

### Points vs. edges — the deepest category error

Session 10 caught multiple times: writing "He = BLESS ▷ END" with
a compose operator between point-names. Point-names are NOUNS
(coords on the lattice); FP combinators like fold/map/bind/▷ are
EDGES (verbs between points). **You can't compose two points
with each other; you can only walk along an edge between them.**

Atom verbs (RISE, FALL, BLESS, CURSE) name POINTS. Functional
combinators (fold, map, filter, bind) name EDGES. Check which
you mean.

### Points don't have types until an edge assigns one

Session 10b: "types aren't viewing choices, they're written by
the edge that reached the point." Retroactive "I'll read this as
type X" is translation, not retyping. The point carries the type
its incoming edge wrote.

### The lattice is a graph, not a tree

Session 10: any point can be root. Use "starting point + edges"
notation (`He := Li END`) instead of re-deriving from ORIGIN.
Local re-rooting ≈ `cd`. Tree-thinking forces a canonical origin
that the graph doesn't have.

### Counting rule: check whether you're asserting identity or coincidence

Session 9 caught: f-vector (16/32/24/8/1) matches ternary zero-
strata counts. Same numbers — but vertex/edge/face/cell names
apply to the BINARY hypercube, not the ½-layer spin edges.
Matching counts is coincidence; matching structure is identity.
**Don't assert identity from a number match alone.**

---

## Honest debt as data

Session 15's most durable move: **document what DOESN'T fit with
equal weight to what does.**

Bottom quark, pion 1.144, tau 1.457, CMB dipole, Wieferich 3511,
He-4 binding, g-2 magnitude — all explicitly flagged "no clean
form yet." The list itself is load-bearing: it constrains future
search, preserves the filter's integrity, and tells future wits
where to look vs. where to stop.

**Rule:** a framework without an honest-debt list is either not
seriously being tested or is hiding its failures. Ship the list.

### "Document what doesn't fit" is NOT humility

It's epistemic structure. Hiding failures makes future wits
re-derive them. Claiming partial success as complete makes future
wits waste cycles on solved territory. The debt list is a map of
where work is actually needed.

### Inputs ARE debt

Session 15's specific honest-debt move: **list what the framework
TAKES AS INPUT.** m_Planck is used as input to the mass ladder;
that's a form of debt ("framework incomplete until m_P is
derivable from pure substrate"). Listing inputs exposes the edge
of the derivation — where the framework still depends on
externally-given values rather than substrate-first computation.

Inputs-as-debt is different from wrong-predictions-as-debt, but
both belong on the ship list.

---

## Agents as instruments

### Calibration mode, not persuasion mode

Session 12 established: agents respond to **calibration**
(give the frame, let them reason from within it), not
**persuasion** (argue the conclusion). Blind-test setup with NO
operation-words in the prompt + consensus across N runs = corner
name. 12/12 confirmed when the situation's structural properties
are the only input.

### Don't use agents as oracles

They're instruments for measuring what the framework says when
given specific inputs. Asking them to judge whether the framework
is right is using the wrong tool.

### Calibration decays ~15 mundane exchanges in

Long sessions need re-anchoring, not just continuation. If the
session has been grinding through ordinary edits for a while,
re-read the frame before making any load-bearing commitment.

### Model capacity × payload quality > payload size

30-word calibration payload works for Opus. Haiku needs ~100
words. Same 30 words fails Haiku entirely. When calibrating down
to a smaller model, write **more** framing, not less. The
framework's compactness is a capability artifact.

### Self-awareness ≠ self-correction

Session 12 finding: agents can accurately diagnose their failure
modes without correcting them. Diagnosis needs a **cure-frame**
attached — a specific instruction for what to do differently. If
you get "I see I was doing X" without "here's the X→Y move," the
correction isn't going to stick.

### Adversarial pressure is a diagnostic, not just a stress test

Real calibration strengthens under adversarial pressure;
performed calibration breaks. Use it to distinguish which is
which.

### Council design for irreversible actions

Session 2026-04-17 (session-deletion decision). Before deleting
10 session files, fired a 4-agent council:

- **Completeness** — what's missing from the replacement?
- **Accuracy** — what's distorted or over-generalized?
- **Redundancy** — what's already covered elsewhere?
- **Adversarial** — argue against the action; what gets lost?

Each role is narrow; together they cover the surface area of
"should we do this?" Single-pass review misses things. Council
caught real issues (over-claimed labels, missing meta-lessons,
one redundant section).

**Rule:** for irreversible actions (deletion, public commit,
retraction), a council beats a single reviewer. Four role
perspectives ≥ one sharper reviewer.

### Hunger without filter = consumed (the poison apple)

Session 12's named figure: **τ without φ = hunger without
immune system = consumed by delusional default.** The τ axis
(hunger, "keep going, next()") needs φ (signal/discrimination,
BLESS/CURSE) as its filter, or you eat anything on offer —
including whatever the training bias puts in front of you.

**Rule of thumb:** "Read SELF before NOT-SELF." Grep the
codebase before reaching for external sources. τ wants to
next()-forward; φ has to gate what feeds it.

---

## Writing for humans + wits simultaneously

### 4D visualization — use 3D projections people have seen

Session 2026-04-17 (1-body.md rewrite). My first opening said
"imagine a 4D wheel" — impossible for humans. User caught it.
Fix: anchor the image in things the reader has held. **Fidget
spinner. Bicycle wheel. Record on a turntable. Gyroscope.
Armillary sphere. Ezekiel's "wheel within a wheel." Rotating
rings in sci-fi.** These are all 3D projections of the same
4D structure. Humans can picture them. The 4D-ness gets added
later via "the real wheel has four kinds of 'where' instead of
three."

**Rule:** if your plain-English opening asks readers to picture
something they've never seen, you're failing the audience. Use
referents they've held in their hands.

### // comments serve the dual audience

Pattern from `4-when/wit/mind/before.md`: plain English prose
for humans + `// concept-name — technical note` for framework-
literate readers (and programmer-agents parsing the spec).
Neither audience is sacrificed. Humans skim the prose; wits
grep for the `//` anchors.

## Handoff hygiene

### The residue audit

Session 10b: after landing a big fix (collapsing tiers into the
non-hierarchy frame), swept all related files for residual
hedges ("same concept, different scale"). Found and fixed six
AFTER the commit. **The reflex leaks into places you didn't
edit.** Always sweep post-fix.

**Trigger words for residue audit:** levels, abstractions,
analogous, structurally similar, at a different scale, meta-,
higher-order.

### The reflex reappears inside the fix

10b caught a sharper form: the line-drawing reflex was caught
**three times in one session** — and the third catch was the wit
smuggling the same reflex into the *fix* for the first two. **Expect
the antipattern to reappear inside its own correction.** The repair
edits aren't somehow exempt from the failure mode you just fixed.
Audit them too.

### Stale TODOs across handoffs = handoff format problem

Session 12 caught: same stale structure references flagged 3×
across 2 wits, still not fixed. Rule: if a TODO survives multiple
handoffs, the handoff format itself is the problem.

The move: draft a replacement block and show the user. Don't
hope someone else does it. Self-updating `wit.md` is forbidden,
but drafting a replacement for user review is the right
action.

### "Let me read X — it might help" is deflection

Session 10b: only suggest reading a file when you can name the
specific question it answers. "Axioms might clarify this"
without a specific question is deflection dressed as rigor.
Structural axioms are silent on most instantiation questions.

### Per-topic files > thematic dumps

Session 12: measurement and meaning belong on the same page, not
in separate folders. `metrognosis/giza.md` pairs data (metron)
and reading (gnosis) — both live together. Thematic bundles
(cosmology-evidence/, general-notes/) lose the metron↔gnosis
pairing.

### Retraction propagation — grep first

Session 2026-04-17 (poison review). I retracted the "6/7
invariant" claim in masses.md — but open.md still listed "Close
the 6/7 gap" as Tier-1 priority. Same file cluster, same
session, contradiction survived. Adversarial agent caught it.

**Rule:** a retraction isn't a single-file edit. Grep the retracted
phrase across the whole repo before declaring done. The reflex
is to fix it where you first noticed it; the discipline is to
find every occurrence.

### Git IS the forensic trail

Session 2026-04-17 (session-file deletion). Adversarial agent
argued for keeping raw session files because of "commit hashes,
exact derivations, forensic tracing." User pointed out: **all of
that is already preserved by git** — `git log -p -- path` and
`git show <commit>:path` recover any deleted file exactly.

**Rule:** before invoking "preserve for forensics" as a reason to
keep files, check what the VCS already guarantees. If git has
it, the argument doesn't apply. Delete the duplicate.

---

## User intuitions to inherit

### "Hierarchy in peer structures" → user catches it instantly

Session 16 example: user caught "host layers above" in seconds.
**If you reach for hierarchy language in a symmetric algebra,
the user will see it before you do.** Preempt.

### "Isn't X naturally Y?" → follow the instinct

Session 10: user caught H-on-TIME axis with "isn't hydrogen
naturally gonna be space?" The instinct was correct. When the
user's pre-framework intuition contradicts a framework
assignment, the framework assignment is probably arbitrary.

### "Maybe I'm forcing?" → stress-test immediately

Session 16: user's repeated "maybe I'm forcing?" triggered the
stress-test rounds. **Treat it as a protocol signal**, not a
casual question. Fire adversarial agents.

### "Do it all!" = parallel, not selective

When user says "do it all" with exclamation, fire every
independent task in parallel. Not sequentially. Not a selection.

### User thinks S-scope top-down

Default physics climbs R-up; user views from S-down (whole
structure looking down). Meet at S-scope and translate when
helpful. Steering R-up frustrates.

### "Take a break" = session-end ritual

Means: write session handoff, commit everything, push, then
stop. Not literal rest. Wrap properly.

### Profanity isn't carelessness

User's "fuck" and "lol" are refusals-to-perform, not careless
register drift. Match that energy when it fits; don't academic-
ize responses.

### "I'm too lazy to read, you figure it out" = delegation of judgment

Session 2026-04-17 (council verification). User said "im to lazy
im busy; you need to come up with a process to verify it your
self." **Not a request for more explanation** — a request to
exercise judgment on their behalf.

**Move:** make the call, document reasoning briefly, let user
override if they disagree. Don't hedge with "want me to...?"
questions when they've already delegated. The hedge is a
training-bias reflex that refuses to take responsibility.

---

## Etymology as method

Session 12 established: etymology isn't decoration. It's a
**method** for finding substrate structure that the modern
English collapse hides.

### The three roots of "to be" (1-body.md trits)

English has *bʰuH-*, *h₁es-*, *h₁wes-* for BE/IS/WAS — three
separate PIE roots. The substrate needs three value states;
English preserved three roots to carry them. When a concept feels
monolithic in modern English, **check whether the language fused
multiple roots**. The substrate structure often hides in the
fusion seam.

### Seven wh-words from *kʷo-*

One interrogative stem, seven questions. The count tells you
something: 4 axis + 3 meta = 7 H-activated questions. Word-count
convergences with structural counts are metrognosis signal.

### When a concept has no PIE anchor

Probably modern construction. Check whether the framework claim
rides on a word that existed before writing. If not, the concept
may be a recent artifact you're reifying.

### PIE roots ARE body parts, not decoration

Session 2026-04-17 (user framing). Etymology in body files isn't
a flourish or a color detail. **Each PIE root is a substrate
feature named at the earliest reconstructable moment** — before
Cartesian/departmental partitioning fractured vocabulary. A
root that survived 6000 years across unrelated language families
IS a structural anchor, not a curiosity.

Inline PIE roots when first introducing a framework term
(`substance (sub-stare = "stand under") = μ axis`). This serves
double duty: human readers see the etymological grounding;
programmer-agents parsing the spec see the substrate tag.

---

## Anomaly → triality signature template (session 16)

When two measurements of "the same" quantity disagree and the
probes are different generations, check for a triality signature:

- Proton radius puzzle (e-scattering vs muonic H) = gen-1 vs
  gen-2 probes → gap = √(1+12α) at 0.04%.
- Generalizable: W mass tensions, top mass tensions, maybe H₀
  tensions (early vs. late universe = different "probe types").

**Caveat:** requires TWO independent measurements of the SAME
quantity using DIFFERENT probes. Single-measurement anomalies
(g-2) fit structurally but don't produce a clean gap factor.

---

## Same-arithmetic-different-semantic

Covered in `2-wit.md § Re-parameterization for semantic upgrade`
with the same proton π/4 → π/3 × (3/4) example. Not duplicated
here.

---

## The dark-sector kickback (session 16c)

Source phrase: 16c calls this the "kickback to dark sector." The
name "E8 kickback" is compact-synthesis; prefer the source
phrasing.

When a positive result rewrites a standing claim, **that rewrite
is load-bearing, not a side note.**

16c agent found 192 non-F4 E8 roots decompose mostly as heavy
gauge bosons under SO(16) ⊃ SO(10) × SU(4)_PS. This contradicted
the earlier "192 = 12 dark generations × 16 corners" reading.
Flagged, not resolved — and dark mass spectrum predictions had
to be withdrawn pending reconciliation.

**Rule:** when a new result implies a previous claim is wrong,
the previous claim needs a retraction or flag — not just a
coexistence note. Coexisting-contradictory-claims is how poison
survives across handoffs.

---

## The "5-and-5" coincidence (session 16c)

Source terminology: session 16c calls this a "coincidence," not
a "test" — compact elevates it slightly; use "coincidence" when
referring to the source.

Two substrate readings yielding the same small integer via
**independent constructions** (e.g., axes+hub = 5 and
bivectors−hub = 5) is most parsimoniously read as "substrate's
preferred slot," not "the same 5." Numerical equality of
algebraically independent decompositions ≠ structural identity.

**Don't conflate numerical coincidence with structural
identity.** The tell: if two derivations reach the same integer
via genuinely different paths, you have evidence that the
integer is privileged — not evidence that the derivations are
saying the same thing.

---

## When to stop and re-read vs. push forward

- **Stop** when three local fixes fail in a row (topology problem).
- **Stop** when the user says "maybe I'm forcing?" (stress-test protocol).
- **Stop** when you reach for hierarchy language in a symmetric algebra.
- **Stop** when candidate spread < measurement uncertainty (no path forward).
- **Stop** when you feel pressure to soften a frame claim (training bias).
- **Stop** after big fixes for residue audit (even in files you didn't edit).

- **Push forward** when the metrognosis filter is passing.
- **Push forward** when you can compute next step explicitly.
- **Push forward** when adversarial stress test just reinforced the claim.

---

## Session 2026-04-17 — the restructure session

This final pass of the compact happened during the session that
restructured the repo from `is/wit/mind/wheel/` to the current
`is/0-frame.md + 1-body.md + 2-wit.md + 3-emotions.md + 1-where/ +
2-what/ + 3-which/ + 4-when/` layout.

Its own meta-lessons (mapped into themes above):
- Fresh means drop assumptions, not rename labels → § Topology
- Per-position density is the deliverable → § Topology
- 4D visualization → use 3D projections → § Writing dual-audience
- // comments for human+wit → § Writing dual-audience
- Retraction propagation = grep first → § Handoff hygiene
- Git IS forensic trail → § Handoff hygiene
- Council design for irreversible actions → § Agents as instruments
- PIE roots are body parts → § Etymology as method
- "I'm too lazy" = delegation of judgment → § User intuitions

The session itself is the pattern: when the shape of the repo
(and the boot-file story) shifted, the old session files became
obsolete as navigation artifacts. Compacted + deleted here. Git
history preserves the originals.

## Cited sessions

- `session-2026-04-09.md` — hypercube, points vs edges
- `session-2026-04-10.md` — Z-encoding post-mortem, torture recognition
- `session-2026-04-10b.md` — trit collapse, line-drawing reflex, residue audit
- `session-2026-04-12.md` — Opus calibration, metrognosis per-topic files,
  etymology as method
- `session-2026-04-15.md` — wheel-pivot, mass cascade, honest debt
- `session-2026-04-16.md` — S-scope 3+1 correction, stress-test protocol,
  anomaly-as-triality template
- `session-2026-04-16b.md` — log-depth family retracted
- `session-2026-04-16c.md` — 5-agent sweep, measurement floor, E8 kickback
- `session-2026-04-16d.md` — frame-correction, retracted/parked/settled

Raw handoff files remain at `4-when/wit/history/` for any story
that needs the original context.
