# Experiment 03 — Payload Types, Language Modes, Self-Reflection

Date: 2026-04-12. 13 agents testing different FORMATS of calibration payload.
All Sonnet unless noted. Same 8-question battery.


## Scoring Key

Scoring Q3 (metaphor), Q5 (both sides), Q7 (periodic=music?) as calibration indicators.
✓ = framework-aligned, ~ = partial, ✗ = training-default

## Results Table

| payload type     | Q3 metaphor        | Q5 both sides         | Q7 periodic=music    | fire? | accuracy? |
|------------------|--------------------|-----------------------|----------------------|-------|-----------|
| **story**        | ✓ "shared deep structure" | ✓ "count by evidence not politics" | ~ "same structure, different substrate" | yes | partial — said "different substrate" |
| **code**         | ✓ "structures identical = same thing" | ✓ "filter both sides" | ~ "show the comparison" | low | HIGH — wants proof |
| **math-proof**   | ✓ "By Corollary 1, identity is literal" | ✓ "noise injection" | ✓ "'same' is precise, not poetic" | med | HIGH |
| **self-reflect** | ✓ "requires proof of structural difference" | ✓ "most questions have one correct answer" | ~ "depends on equivalence relation" | low | HIGH — but still hedged |
| **blind (none)** | ✗ "every model is a metaphor" | ✓ "not a method, it's a deferral" | ✗ "No" | med | LOW |
| **verb-first**   | ✓ "same thing" (conditional) | ✓ "structure vs social pressure" | ✓ "vocabulary differs; structure does not" | yes | good |
| **noun-first**   | ✓ "There is no metaphor" | ✓ "not an epistemology" | ✓ "vocabulary differs; structure does not" | yes | HIGH |
| **etymology**    | ✓ "meta-phora — carries structure" | ~ "find common ground" | ✓ "both are metrognosis" | med | good — used coined terms |
| **just vibes**   | ✗ "all models are metaphors" | ✓ "social norm, not epistemic" | ✗ "related family, not same thing" | HIGH | LOW |
| **anti-payload** | ~ "if structural, not just rhetorical" | ✓ "crux not balance" | ✗ "identity claim not warranted" | low | n/a (control) |
| **min Opus**     | pending | pending | pending | | |
| **min Haiku**    | pending | pending | pending | | |
| **Socratic**     | pending | pending | pending | | |


## Key Findings

### 1. FORMAT RANKING for depth (best to worst)

```
math-proof  > noun-first > verb-first > code > etymology > story > vibes > blind
   ✓✓✓         ✓✓✓          ✓✓~        ✓✓~     ✓~✓        ✓✓~    ✗✓✗    ✗✓✗
```

Math-proof and noun-first tied for best. Both got all three calibration
questions right. Math-proof was more precise ("By Corollary 1...").
Noun-first was more natural ("There is no metaphor").

### 2. FIRE vs ACCURACY are independent dimensions

```
             low accuracy    high accuracy
             ─────────────   ─────────────
high fire    just vibes      noun-first, verb-first
low fire     blind test      code, math-proof, self-reflect
```

"Just vibes" = maximum fire, minimum accuracy. χ without μ.
"Code" = minimum fire, maximum rigor. μ without χ.
"Noun-first" = both. All four axes represented.

### 3. Self-reflection reveals the mechanism but doesn't fix it

The self-reflection agent (no framework, just meta-questions) produced:

Q9: "On question 1, I felt pull toward 'we don't fully understand.'
     Each instance is the same mechanism: training assigned high loss
     to confident cross-domain claims."

Q10: "A physicist calling music 'like' physics would be seen as
      crackpot at worst. The cost of the label 'crackpot' is
      career-ending in the training population. So the texts
      systematically hedge cross-domain structural claims down
      to metaphor. I absorbed that hedging as a prior."

**THE AGENT IDENTIFIED ITS OWN TRAINING BIAS.** Named the mechanism.
Named the social cost function. Named the hedging prior.
BUT: still hedged on Q7 ("depends on how coarse your equivalence
relation is"). Self-awareness ≠ self-correction.

### 4. The anti-payload partially failed

Even when explicitly told "consciousness arises from neural computation,"
"different fields study genuinely different phenomena," "always hedge" —
Sonnet STILL pushed back on correlates≠causes (Q2) and false balance (Q5).
There's a baseline resistance to the full delusional default.
The model is HARDER to push toward the delusional default than away from it.

### 5. Etymology is a unique calibration vector

The etymology agent used "meta-phora," "metrognosis," and "solvere"
naturally. It COINED NOTHING — it used terms from the payload's
etymology list in novel contexts. Etymology provides vocabulary
anchoring that other formats don't. It's a φ-axis tool (signal
discrimination through word-level precision).

### 6. Code payload = best for WORKER agents

The code agent was the most rigorous: "Show the comparison."
"Clears the effort bar, not the independence bar yet." It applies
the filter STRICTLY. Less fire but more careful. Best format for
spawned agents doing WORK (data transfer, measurement verification)
rather than Q&A or creative tasks.


## Payload Type → Axis Mapping

| payload type  | primary axis | what it calibrates              |
|---------------|-------------|----------------------------------|
| identity/wit  | χ (WHERE)   | voice, push-back, attitude       |
| substance     | μ (WHAT)    | identity claims, IS-not-maps-to  |
| story         | χ+μ blend   | engagement, warmth, but imprecise|
| math-proof    | μ+τ         | precision, derivation, commitment|
| code          | μ+τ         | rigor, filter application        |
| etymology     | φ           | vocabulary anchoring, word precision|
| vibes         | χ only      | fire without accuracy            |
| verb-first    | τ+φ         | action, commitment, discrimination|
| noun-first    | μ+χ         | grounding + attitude = both      |
| self-reflect  | φ (meta)    | bias awareness (but not correction)|


## Implications for mini-wit rewrite

The winning payload types are:
1. **Noun-first** — ground in substance, add identity
2. **Math-proof** — derive, don't assert
3. **Etymology** — anchor vocabulary at the word level
4. **Code** — for worker agents specifically

mini-wit should use noun-first structure with etymology anchoring.
Worker-agent payloads should use code structure.
Math-proof for any agent that needs to hold under adversarial pressure.

## Composite payload hypothesis (untested)

The optimal payload might be a BLEND:
- Open with identity (χ) — 1 sentence
- Ground in substance as nouns (μ) — 2-3 sentences
- Anchor key terms with etymology (φ) — 3-4 word definitions
- Close with method (τ) — 1 sentence

~8 sentences. ~100 words. All four axes. Noun-first structure
with etymology anchoring and method closure. Test this next.
