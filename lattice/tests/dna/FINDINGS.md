# DNA — lattice verification

## The claim

Watson-Crick base pairing IS quaternion additive inverse. Not "like" additive inverse — same operation, different vocabulary. DNA's 4 bases map to quaternion axis directions, and the complementarity that makes DNA work IS negation in H.

## The mapping

```
A (adenine)  → +χ = (0,  1, 0, 0) = i
T (thymine)  → -χ = (0, -1, 0, 0) = -i     ← complement of A
C (cytosine) → +μ = (0, 0,  1, 0) = j
G (guanine)  → -μ = (0, 0, -1, 0) = -j     ← complement of C
```

**Watson-Crick pairing** (the hydrogen bonds that hold DNA together):
- A ≡≡ T (2 hydrogen bonds, χ axis)
- C ≡≡≡ G (3 hydrogen bonds, μ axis)

**Pairing IS addition to zero:**
```
A + T = i + (-i) = 0
C + G = j + (-j) = 0
```

The complementary strand of DNA isn't "a mirror copy" — it's the additive inverse. Conjugation on the relevant axis.

## The test: complement

```
base a = A   →  (0, 1, 0, 0)
base t = T   →  (0,-1, 0, 0)
pair = a + t →  (0, 0, 0, 0)
```

Sum of complementary bases IS the origin. Return pair.i = 0.

**Result: 0** — verified via component-wise addition on bare metal.

## Why it's structural

DNA replication works because the complementary strand reconstructs uniquely from the original. This requires an invertible operation. The framework says: **invertibility in H IS additive inverse**. DNA's complement operation IS quaternion negation on the bonding axis.

The 4 bases fit exactly on 2 axes with ±1 each. This isn't coincidence — it's the minimum algebraic structure that supports complementary pairing:
- 1 base would have no partner
- 2 bases could pair but don't encode information
- 3 bases can't pair (odd number)
- **4 bases = 2 complementary pairs = minimum for invertible coding**

Why exactly 4? Same reason H is 4D (Hurwitz): 4 is the unique dimension that supports both addition/inversion AND multiplication/associativity. DNA lives at H for the same structural reason spacetime does.

## Framework connections

- **Codons are trivectors.** A codon is 3 bases = 3 axis commitments = grade 3 lattice point. There are 4³ = 64 possible codons, subset of the 81 shell-1 lattice points. 64 codons encode 20 amino acids + 3 stop codons + 1 start = redundancy by design (the framework allows multiple walks to the same target).
- **Double helix = spin structure.** Two strands running antiparallel = spin ½ coupling. DNA's geometric structure IS SU(2) at molecular scale.
- **Transcription = walk.** DNA → RNA → protein is a composed walk through the lattice. Each step is a quaternion operation; the protein is the composed result.

## Open

- Codon → amino acid mapping: derive from lattice structure, not the genetic code table
- Why 20 amino acids? Structural constraint on grade 3 points
- Start/stop codons as special lattice positions
- DNA replication as quaternion conjugation applied to a sequence
- RNA's use of U instead of T — U = T with one methyl group less. Does this map to a shell½ difference?
