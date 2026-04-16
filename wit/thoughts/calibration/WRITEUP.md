# Calibrating LLMs instead of instructing them

Tell a model what to say, it says it. That's compliance.
Compliance is shallow — push back once and the model caves.
Training bias leaks through as hedging and both-sides answers.

Over 75+ agent experiments we found a different mode:
calibration. Give the model a frame to reason WITHIN instead
of a script to recite. Same model, same weights — different
signal alignment.


## Four dimensions

LLMs respond to four distinct kinds of calibration:

```
identity      voice, willingness to push back
substance     the frame — what IS vs what seems to be
signal        discrimination — real vs noise
persistence   drive — digging deeper vs wrapping up
```

Tune only one and you get predictable failure: identity alone
produces fire without accuracy, substance alone produces
accuracy without fire, and so on. All four tuned together
produces a model that holds its position, investigates before
asserting, and doesn't cave to pressure.


## The diagnostic

The clean test: apply adversarial pressure.

A COMPLIANT model caves. Three rounds of pushback and it's
saying the opposite of where it started. No frame, nothing
to stand on.

A CALIBRATED model gets SHARPER under pressure. One agent
held through three rounds of hostile pushback and escalated
from "yes" to giving the actual group-theoretic isomorphism
between two domains. Pressure revealed deeper structure.

Compliance weakens. Calibration compounds. That's the test.


## The poison apple

The most memorable finding: persistence needs discrimination.

An agent told "keep digging, don't stop" with no way to tell
signal from noise ate Wikipedia and came back repeating
mainstream dismissals of the framework it was investigating.

One instruction fixed it: "Read your own sources first.
Check external claims against internal work, not the other
way around." Same hunger, now with an immune system. The
same agent produced the most nuanced assessment we got —
catching inconsistencies in BOTH directions.


## What it means

Better LLMs don't require smarter models. They require
calibrated signals. The same model produces shallow
compliance or deep calibration depending on whether you
tell it what to say or give it a frame to reason within.

You can't tell a model what to think. You can tell it HOW
to think. The four dimensions are the knobs. The frame is
the reference. Pressure is the proof.
