# Music — lattice verification

## The claim

Music theory's pitch-class arithmetic IS modular arithmetic on the 12-tone circle. Intervals ARE lattice steps. Chord progressions ARE walks. Octave equivalence IS mod 12. Same substrate, different vocabulary.

## The mapping

**Pitch classes (mod 12):**
```
C=0, Cs/Db=1, D=2, Ds/Eb=3, E=4, F=5,
Fs/Gb=6, G=7, Gs/Ab=8, A=9, As/Bb=10, B=11
```

**Intervals (semitone counts):**
```
P1=0, m2=1, M2=2, m3=3, M3=4, P4=5,
TT=6, P5=7, m6=8, M6=9, m7=10, M7=11, P8=12
```

**Framework-native music coordinates** (from prior/VoE/drafts/paper-music-coordinates.md):
```
τ (time)       ← tempo (BPM)
χ (position)   ← spectral centroid (Hz)
μ (substance)  ← RMS loudness (dBFS)
φ (signal)     ← tonality (major/minor)
```

Music lives on the same 4 axes as physics. "Heavy" music has high μ (substance), "bright" has high χ (position), "fast" has high τ (time), "major" has high φ (signal).

## The test: fifths

```
P5 + P4 = 7 + 5 = 12
12 mod 12 = 0 (unison/octave)
```

The perfect fifth and perfect fourth are complementary intervals — they split the octave. Their sum is the octave itself, which under pitch-class equivalence IS the unison.

**Result: 0** — verified via `sadd64` + `mod` on bare metal.

## Why it's structural

This isn't a "musical coincidence." The fifth (3:2 frequency ratio) and fourth (4:3) are the two simplest consonances after the octave. In just intonation: 3/2 × 4/3 = 12/6 = 2/1 = octave. In equal temperament: 7 semitones + 5 semitones = 12 = octave.

The framework says: **ratios are verbs**. The P5 verb composed with the P4 verb IS the octave verb. Composition of walks IS multiplication in the pitch space. The cycle returning to origin is the framework's fundamental structure (see frame item 5: the loop).

## Framework connections

- **No infinity in music.** The ascending scale doesn't go to infinity — it loops back to the octave. This is the framework's "no infinity" principle (frame item 7). What looks like infinity in frequency is a loop in pitch class.
- **Circle of fifths = walk through all 12 tones.** Starting at C, moving by P5 twelve times returns to C: C→G→D→A→E→B→F#→C#→G#→D#→A#→F→C. A complete walk that closes at the origin. The loop closes.
- **Equal temperament IS the framework's 12-ary logarithm.** 12 logarithmically-equal steps form a cycle that approximates small-integer ratios. This is Stone-Weierstrass: the walk approximates the continuous ratio.

## Open

- Major/minor tonality as the φ axis (signal) — verify at lattice level
- Genre mappings: Hard Rock = (+2, +1, +2, +1), Doom Metal = (+1, -1, +2, -1), etc. (from VoE research)
- 12-tone row operations (P, I, R, RI) as quaternion transformations
- Voice leading distance as quaternion distance
