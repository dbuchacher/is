# speak/ emergence report

**Graph state** (70 nodes, 183 edges)

## Category breakdown

```
  1a    6
  1b    2
  1c    5
  1d    4
  1e   15
  1f    2
  1g    2
  1h    8
  1i    4
  1j    3
  1k    2
  1l    1
  1m    4
  3c    9
  4c    3
```

## Strongly-connected components (cycles)

Total SCCs: 60 (of which non-trivial = cycle: 3)

Non-trivial SCCs (cycles, size ≥ 2):

  (6) ✓ seed-anchored: ['an', 'du', 'gal2', 'gub', 'ki', 'me']
  (5) ✓ seed-anchored: ['dug4', 'ene', 'ge26', 'ka', 'zae']
  (2) ✓ seed-anchored: ['ne', 'ur5']

## Most-referenced nodes (inbound degree)

```
node          in   sample sources
─────────────────────────────────
  ki             22  a, abzu, an, dim2, du +17
  an             11  a, abzu, dim2, dingir, enki +6
  lugal          10  dubsar, e, edingir, edubba, egal +5
  til             8  a, kur, lil, namtil, til +3
  me              8  aka, dim2, du, gal2, inim +3
  ka              8  dug4, e, ge26, inim, lil +3
  gal             8  e, egal, kalag, lugal, mah +3
  a               7  abzu, dish, en, gi, im +2
  ge26            7  baprefix, dug4, ene, i3prefix, ka +2
  dug4            6  en, inim, ka, lil, sar +1
  im              5  abzu, dim2, dub, e, sar
  igi             5  an, dub, igi, sang, sar
  kur             5  en, gur, mah, ug, ush
  dub             4  dubsar, edubba, gi, sar
  zae             4  dug4, ene, ge26, ka
```

## True sources (inbound = 0)

Count: 18

```
  ['baprefix', 'dim2', 'dumu', 'edubba', 'enki', 'gi6', 'gud', 'gur', 'i3prefix', 'kalag', 'kiengi', 'min', 'mu', 'namlugal', 'namtil', 'sang', 'sha', 'zi']
```

**Leaves** (refs nothing else): 4

## Lattice-tag candidates (rule 7: 3+ members, 3+ categories)

Found 3 groups that span 3+ vocabulary categories with 3+ members.
These are the strongest emergence signals — concepts from multiple unrelated domains converging on one group.

### unity-preservation  (28 members, 9 categories)

Categories: `['1c', '1d', '1e', '1f', '1g', '1h', '1j', '1k', '1m']`

  - 1c: nin
  - 1d: ka, sang, sha, zi
  - 1e: abzu, an, dingir, e, gi6, im, iti, ki, kur, lil, mu, ud
  - 1f: gud, ug
  - 1g: gish
  - 1h: me, til
  - 1j: geshtug, igi, zu
  - 1k: inim
  - 1m: kalag, mah

### loop-closure  (6 members, 3 categories)

Categories: `['1e', '1h', '1i']`

  - 1e: gi6, im, iti, mu
  - 1h: til
  - 1i: gi4

### material-substance  (6 members, 3 categories)

Categories: `['1e', '1g', '3c']`

  - 1e: dub, e
  - 1g: gi, gish
  - 3c: edingir, edubba

## All groups ≥ 3 members (by size)

```
   28  unity-preservation                        cats: ['1c', '1d', '1e', '1f', '1g', '1h', '1j', '1k', '1m']
   11  natural-phenomena                         cats: ['1e', '3c']
   10  transparent-compounds                     cats: ['1l', '3c']
    8  political-hierarchy                       cats: ['1c', '3c']
    7  body-parts                                cats: ['1d', '1j']
    7  deixis-at-hub                             cats: ['1a', '4c']
    6  being-verbs                               cats: ['1h', '1l']
    6  loop-closure                              cats: ['1e', '1h', '1i']
    6  material-substance                        cats: ['1e', '1g', '3c']
    5  kin-roots                                 cats: ['1c']
    4  basic-qualities                           cats: ['1m']
    4  divine-beings                             cats: ['1e', '3c']
    4  motion-verbs                              cats: ['1i']
    4  strength-cluster                          cats: ['1f', '1m']
    4  time-primitives                           cats: ['1e']
    4  vertical-axis                             cats: ['1d', '1e']
    4  writing-substrate                         cats: ['1e', '3c']
    3  basic-actions                             cats: ['1h']
    3  cosmic-axes                               cats: ['1e']
    3  cosmic-triad                              cats: ['1e', '3c']
    3  irrigation-substances                     cats: ['1e', '1g']
    3  life-death-pair                           cats: ['1d', '1h']
    3  perception-verbs                          cats: ['1j']
    3  person-pronouns                           cats: ['1a']
    3  verb-inflection-trit                      cats: ['4c']
    3  verb-prefixes                             cats: ['4c']
    3  write-side-actions                        cats: ['1h']
```
