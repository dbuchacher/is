# speak/ emergence report

**Graph state** (38 nodes, 70 edges)

## Category breakdown

```
  1a    4
  1c    1
  1d    5
  1e    9
  1h    3
  1i    2
  1j    2
  1k    2
  1m    2
  1n    8
```

## Strongly-connected components (cycles)

Total SCCs: 26 (of which non-trivial = cycle: 7)

Non-trivial SCCs (cycles, size ≥ 2):

  (5) ✓ seed-anchored: ['di', 'nian', 'ri', 'tian', 'yue']
  (3) ✓ seed-anchored: ['er', 'san', 'yi']
  (3) ✓ seed-anchored: ['qi', 'ru', 'wo']
  (2) ✓ seed-anchored: ['da', 'xiao']
  (2) ✓ seed-anchored: ['wu', 'you']
  (2) ✓ seed-anchored: ['kou', 'yan']
  (2) ✓ seed-anchored: ['shang', 'xia']

## Most-referenced nodes (inbound degree)

```
node          in   sample sources
─────────────────────────────────
  ri              8  bei, dong, jian, nan, nian +3
  di              7  bei, dong, nan, tian, xi +2
  tian            6  di, ming, ri, shang, shen +1
  wo              4  lai, qi, ru, shi
  yue             4  nian, ri, tian, yue
  wu              3  fu, gui, you
  qi              3  ru, shi, wo
  xi              2  dong, zhong
  yi              2  er, san
  san             2  er, yi
  shou_hand       2  fu, zuo
  yan             2  kou, ru
  xing            2  lai, zuo
  bei             2  nan, zhong
  ru              2  qi, wo
```

## True sources (inbound = 0)

Count: 9

```
  ['fu', 'jian', 'lai', 'shen', 'shi', 'shou_head', 'zhong', 'zu', 'zuo']
```

**Leaves** (refs nothing else): 4

## Lattice-tag candidates (rule 7: 3+ members, 3+ categories)

Found 2 groups that span 3+ vocabulary categories with 3+ members.
These are the strongest emergence signals — concepts from multiple unrelated domains converging on one group.

### unity-preservation  (21 members, 7 categories)

Categories: `['1d', '1e', '1h', '1i', '1j', '1k', '1n']`

  - 1d: kou, shou_hand, shou_head, xin, zu
  - 1e: nian, ri, shang, shen, tian, xia, yue
  - 1h: wu, you
  - 1i: xing
  - 1j: jian, wen
  - 1k: ming, yan
  - 1n: bei, yi

### read-write-unity  (5 members, 4 categories)

Categories: `['1d', '1h', '1j', '1k']`

  - 1d: xin
  - 1h: zuo
  - 1j: wen
  - 1k: ming, yan

## All groups ≥ 3 members (by size)

```
   21  unity-preservation                        cats: ['1d', '1e', '1h', '1i', '1j', '1k', '1n']
    7  spatial-prepositions                      cats: ['1e', '1n']
    5  body-parts                                cats: ['1d']
    5  cardinal-directions                       cats: ['1n']
    5  read-write-unity                          cats: ['1d', '1h', '1j', '1k']
    5  vertical-axis                             cats: ['1d', '1e']
    4  cosmic-axes                               cats: ['1e']
    3  cardinal-numbers                          cats: ['1n']
    3  count-line                                cats: ['1n']
    3  deixis-triangle                           cats: ['1a']
    3  divine-beings                             cats: ['1e']
    3  natural-phenomena                         cats: ['1e']
    3  pronoun-deictics                          cats: ['1a']
    3  time-cycles                               cats: ['1e']
```
