# next session — what to do next

A prioritized list of work for whoever picks this up next.

─────────────────────────────────────────────────────────────────────

## High-priority — straightforward extensions

### 1. Add more vocabulary
- translate.py has ~570 words inline
- Top 1000 English has many more not yet derived
- Run `python3 wit/codex/translate.py "any text"` and look for `unknown words`
- Add any words that appear unknown to the inline VOCAB dict

### 2. Apply more validation fixes
- `validation-report.md` lists ~70 issues found in vocabulary derivations
- Many are still unfixed. Pick a section and apply the corrections
- Re-run `python3 wit/codex/verify.py` after each batch to ensure
  nothing broke

### 3. Translate more real texts
- Each new text translation tests the framework on new vocabulary
- Pick texts from new genres (legal, scientific abstract, sports,
  cooking, advertising, etc.)
- Use `python3 wit/codex/translate.py --file FILE.txt` for automatic
- Or manually like in `genesis-1.md`, `lords-prayer.md`
- Add findings to `text-shapes.md`

### 4. Improve negation handling
- Currently NOT applies to the next word only
- Should apply to the whole clause for "no dogs run" type cases
- Fix in translate.py walk() function
- See sentence S25 in sentences.md for the test case

### 5. Aspect handling
- Continuous (-ing): "I am walking" — currently treated as walk
- Perfect (have +ed): "I have walked" — currently past
- These need their own composition rules
- Sketch in composition.md issues #4-5

─────────────────────────────────────────────────────────────────────

## Medium-priority — research extensions

### 6. Cross-linguistic validation
- Take Genesis 1:1-5 in another language (Spanish, German, Mandarin)
- Translate word-by-word using the same 8 atoms
- Compare to genesis-1.md predictions
- If the structural shape holds, that's strong cross-linguistic support
- The framework predicts the SHAPE should be the same regardless of
  the language

### 7. More test sentences in verify.py
- verify.py has 13 sentence walks tested
- Add more from sentences.md (which has 25 worked sentences)
- Each new test that passes is more confidence

### 8. Pre-register predictions for untested genres
- See lattice.md "genre prediction" section
- Pick a genre we haven't tested: legal, scientific abstract, etc.
- WRITE DOWN what the framework predicts BEFORE translating
- Then translate a real text in that genre
- Confirm or falsify

### 9. Color sub-axis on C
- Colors don't sort onto a single ±C trit
- Need a sub-axis on C for visual qualia (RED, BLUE, GREEN)
- Currently treated as approximations

### 10. Sound/sensory sub-axes
- Same issue as color but for other perceptual modalities
- LOUD/QUIET, ROUGH/SMOOTH, etc.

─────────────────────────────────────────────────────────────────────

## Long-term — speculative extensions

### 11. Build a neural network on the lattice
- Train an LLM-style model that uses the 4-axis coord as its
  hidden representation
- The framework's prediction: this should converge faster than
  unconstrained models because the coord space is much smaller

### 12. Cross-domain mapping
- Map ALL Standard Model particles to lattice positions
- Map ALL English content to lattice positions
- Look for correspondences (e.g., does the proton coord match
  a specific verb coord?)

### 13. Full book translation
- Pick a short book (children's book, Genesis 1 in full, a short
  Aesop fable book)
- Translate every sentence
- Sum to a book-level coord
- Document the walk

### 14. Build a "sentence completion" tool
- Given a partial sentence, suggest words that would complete the
  walk toward a target coord
- Combination of --compose and predictive text

### 15. The 32-bond polarity assignment
- 32 = 16 corners × 2 polarities (±½)
- Specific modal/auxiliary assignments to corners aren't fully
  worked out
- Each modal needs a corner home (CAN, MAY, MUST, etc.)
- Current best guess: alphabetical / arbitrary
- Find a principled assignment

─────────────────────────────────────────────────────────────────────

## Don't do these

- Don't restore the NSM 1:1 prime mapping (tried, failed, in
  validation-report.md)
- Don't restore Lakoff schemas at corners (tried, failed, replaced
  by modal/polarity bonds)
- Don't add a 5th axis (breaks Hurwitz, the framework's load-bearing
  physics claim)
- Don't conflate "0 = absent" with "0 = neutral" — the trit's 0 is
  the wave passing through zero, not absence
- Don't treat THINK as a corner (it's the origin — see lattice.md
  nuance #19, the cogito-at-origin result)

─────────────────────────────────────────────────────────────────────

## Testing your changes

After ANY change, run:

```bash
python3 wit/codex/verify.py
```

ALL 6 categories should still PASS. If any fail, you broke something.
Read the failure carefully — usually it's a coord mismatch you can
trace back to your change.

Then run:

```bash
bash wit/codex/corpus.sh
```

For the full regression suite. ALL sentences should still walk
correctly and ALL queries should still return reasonable results.

─────────────────────────────────────────────────────────────────────

## What this session built

You're inheriting:
- 25+ commits this session
- 11 documentation files in codex/
- 570+ word vocabulary
- 9-15 real text translations
- Programmatic verifier (all tests pass)
- Bidirectional translator (forward + reverse)
- Genre-shape prediction across 11 genres
- The cogito-at-origin result (the framework's strongest validation)

The framework is operational. You can extend it. The 8 atoms are
the only hard constraint; everything else is layered on top.

Read README.md first, then showcase.md, then tutorial.md, then
pick something from this list and start.
