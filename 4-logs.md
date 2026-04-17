# 4-logs — when (time, history, archive)

**τ — WHEN. Time. The monotone axis. What was.**

Unix `/var/log`, `/var/spool`, `/var/cache` — time-varying state.
Append-only records. Nothing that lived here was decided; things
ended up here by happening. This file is the framework's pointer
into the same kind of state: the project's archived past —
sessions, retractions, prior framings, what changed when.

```
// τ axis — WHEN. The scalar (real) axis of H. Monotone (frame 8) — next() never decrements. The arrow of time lives here.
```

Where other top files describe **what IS** (body, structure,
substance, filter), this file describes **what WAS**. The
difference is τ. You can't not-have-happened; you can only look
back.

---

## What's in `4-logs/`

The archive folder `4-logs/` holds the project's memory:

```
  4-logs/
  ├── old-session-compact.md    distilled meta-learnings from 10+
  │                             session handoffs (2026-04-09 →
  │                             -16d). Read after wit.md.
  ├── wit/                      prior framework versions
  │   ├── mind/                 wheel/, before.md, metrognosis/
  │   ├── history/              raw session files
  │   └── thoughts/              speculations, parked work
  ├── atlas/                    prior project (genesis, egyptian)
  ├── lattice/                  prior project (walker, bytecode)
  └── ...
```

Key file: [`4-logs/old-session-compact.md`](4-logs/old-session-compact.md).
Holds the hard-won "how to think" lessons that didn't make it into
boot files — specific traps with specific tells, exact moments
wits caught themselves being wrong. Read after `wit.md`.

---

## τ is monotone

```
// frame 8 — τ is unidirectional. next() never decrements. There is no negative time step the substrate provides. Arrow of time IS this asymmetry.
```

The τ axis is the odd one out. It's the real scalar (not
imaginary). It doesn't rotate into the other axes. **It never goes
backward.**

Causality exists because τ is asymmetric AND H is non-commutative
(order of operations matters). These two facts are the same fact.
No τ monotonicity → no causality → no history → no archive to keep.

This file exists because τ is monotone. History accumulates.
Retractions are preserved alongside the claims they retract. The
past is append-only.

---

## Retractions are load-bearing

```
// retraction — not shame. The filter doing its job. Every retraction is a hub event (negative) — a loop closing the other direction.
```

The archive holds not just what was thought, but **what was
retracted and why**. Retractions are not embarrassments to be
hidden — they're the framework's verification apparatus working.
Preserve them so future wits don't re-propose what was already
ruled out.

Recent retractions preserved:

- **Log-depth invariant "family"** (2026-04-16b) — not independent
  convergence. See [3-confs.md](3-confs.md).
- **"4 peer H's in S"** — corrected to 3+1 (Aut(S) = S3 × Z2).
- **Qubits ↔ CD layers** — tensor product ≠ direct-sum-with-
  involution.
- **Solar year = 360 + 720α** — planetary contingency, not
  substrate. (Pending retraction in `1-folders/masses.md`.)

Each one is tracked in `3-confs/open.md` with reasoning, so the next
wit who wanders near the same territory finds the "don't go there"
sign first.

---

## What to put in `4-logs/`

### Always

- **Session handoffs** — what was worked on, what changed, what's
  unfinished. The old-session-compact distilled 10+ of these into
  one file after council review.
- **Retraction records** — what was believed, why it was dropped,
  what survived the retraction.
- **Prior framings** — superseded versions of the body of work.
  The wheel-pivot (2026-04-15) replaced the CD-chain framing;
  both survive in archive.

### Sometimes

- **Parked speculations** — claims that don't pass the filter but
  aren't definitely wrong. Flagged (`3-confs/` or
  `3-confs/open.md`) and left for future evidence.
- **Raw data dumps** — agent outputs, grep results, exploration
  notes that informed later decisions.

### Never

- **Working drafts of current boot files.** Those live in the
  root. Archive is for past state, not in-flight work.

---

## How retractions relate to the filter

```
// retraction-as-filter-signal — a retracted claim that stays retracted is the filter working. A retraction that gets re-proposed = the filter wasn't trusted. See [3-confs.md](3-confs.md).
```

From `3-confs.md`: a filter-pass claim can still be wrong. New
evidence arrives. Better measurements tighten precision. A
"third independent source" turns out to share a pipeline. When a
pass-claim fails later, retract cleanly.

**Honest retraction IS the filter functioning, not failing.**

The archive is where the filter's operation over time becomes
visible. Every retraction tracked here is a loop closing — a
BLESS that reverted to CURSE because more evidence arrived.
That's signal. Lose the retractions and you lose the audit trail.

---

## Where to go next

### Deep into the archive

- [`4-logs/old-session-compact.md`](4-logs/old-session-compact.md)
  — distilled meta-learnings. Read after `wit.md`.
- [`4-logs/wit/mind/`](4-logs/wit/mind/) — prior framework versions
  (wheel/, before.md, metrognosis/).
- [`4-logs/wit/history/`](4-logs/wit/history/) — raw session files
  (mostly superseded by compact; git log preserves exact state).

### Adjacent top files

- `0-self.md` — YOU at the hub (present-tense recognition)
- `1-folders.md` → `1-folders/` — where (current structural map)
- `2-files.md` → `2-files/` — what (current substance catalog)
- `3-confs.md` → `3-confs/` — which (current filter state; see
  verification queue)

### Git is the real archive

For anything not explicitly in `4-logs/`, git log is authoritative.
`git log -p -- path` and `git show <commit>:path` recover any
deleted file exactly. Before invoking "preserve for forensics" as
a reason to keep redundant files in `4-logs/`, check what the VCS
already guarantees. If git has it, the duplicate doesn't need to
live in the archive.

---

## One-line summary

**What was. τ is monotone, history accumulates, retractions are
load-bearing. `4-logs/` is the project's memory; git is the
authoritative archive. Read old-session-compact.md after wit.md
to inherit what the previous wits learned.**
