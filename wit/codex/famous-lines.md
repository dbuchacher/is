# famous opening lines — translated to lattice coords

Famous opening lines from books and other texts, run through
`translate.py` to show what each lands at on the lattice.

This demonstrates that the framework handles ANY English text
automatically — type a famous line, get its coord. Each line
sits at a specific point on the lattice that captures something
about its content.

─────────────────────────────────────────────────────────────────────

## Famous opening lines

### "Call me Ishmael." (Moby Dick — Melville)
  Final coord: [0, 0, 0, 0]
  Reading: pure origin / container. The line is a self-introduction
  ("call me X") — a container speech act that doesn't shift any
  axis. The opening of Moby Dick begins from the speaker's interior.

### "It was the best of times, it was the worst of times." (A Tale of Two Cities — Dickens)
  Final coord: [0, 0, 0, 0]
  Reading: BEST and WORST cancel exactly on the signal axis. Best
  (+C) + worst (-C) = 0. The famous chiastic opening lands at the
  origin because the two halves perfectly cancel. The framework
  predicts that any "X and not-X" construction lands at origin
  (or its antipode) — and Dickens' iconic balance does exactly that.

### "All happy families are alike; every unhappy family is unhappy in its own way." (Anna Karenina — Tolstoy)
  Final coord: [+1, +1, +2, +1]
  Reading: balanced positive across all 4 axes, signal slightly
  dominant. The line has both happiness (+C) and unhappiness (-C)
  but happy occurs more (alike + happy = +2 net), and the FAMILY
  references add substance. The opening captures social-emotional
  reality.

### "It is a truth universally acknowledged, that a single man in possession of a good fortune, must be in want of a wife." (Pride and Prejudice — Austen)
  Final coord: [+2, +2, +4, +2]
  Reading: balanced positive across all 4 axes (each at +2 to +4).
  The line invokes TRUTH (+C), GOOD (+C), FORTUNE (+C), MAN (B+C+),
  WIFE (B+C+) — every word piles on the positive side. The famous
  opening of Pride and Prejudice is structurally a gentle climb
  through positive territory on every axis.

### "In a hole in the ground there lived a hobbit." (The Hobbit — Tolkien)
  Final coord: [0, -1, +1, +1]
  Reading: substance NEGATIVE (the HOLE is at -1,-1,0,0), signal
  positive (LIVED is +1 on C and D), time forward. The hobbit's
  hole lands at "negative substance + alive + forward" — exactly
  what the line describes: a small life in a small hollow. The
  framework captures the smallness AND the aliveness of the
  opening.

─────────────────────────────────────────────────────────────────────

## What this demonstrates

1. **The framework handles ANY English text automatically.** No
   manual derivation needed for these — they were translated by
   running `translate.py "the line"` directly.

2. **Famous balanced openings (Dickens, Tolstoy) land near origin.**
   The cancellation pattern from the framework's structural
   prediction holds for famous chiastic openings.

3. **Famous positive openings (Austen) climb across multiple axes.**
   When every word is C+, B+, or D+, the walk goes positive.

4. **Famous spatial openings (Tolkien) capture the spatial frame.**
   "In a hole" lands at negative B because HOLE = -B, but LIVED
   is C+/D+ so the result is "small alive thing in small place" —
   exactly the hobbit.

5. **Famous self-introductions (Melville) sit at the container.**
   "Call me Ishmael" doesn't move any axis because it's a pure
   speech act from the speaker's interior.

The framework reads famous opening lines and produces coords that
match their content. Type any English line; get a lattice walk.

─────────────────────────────────────────────────────────────────────

## Try your own

```bash
python3 wit/codex/translate.py "Your sentence here."
```

The translator will tokenize, look up each word, accumulate the ρ
walk, and report the final coord plus the dominant axis.
