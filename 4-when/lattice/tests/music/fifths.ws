; circle of fifths — P5 + P4 = octave
; Perfect fifth (7) + perfect fourth (5) = 12 semitones = 0 mod 12.
; The two intervals that split the octave sum to the octave itself.

interval fifth = P5
interval fourth = P4
let sum : Z = fifth + fourth
return sum mod 12
