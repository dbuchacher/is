# primes — the prime-lattice project

One project built on top of the lattice framework. Everything under
this folder is specific to the shell-identity theorem: the balanced-
ternary prime decoder, the Tier B/C walks, the C-side sieve, and the
full dialogue archive.

The lattice framework itself (hodos, core.asm, main.c, tests/) knows
nothing about primes. This folder exists so that future wits working
with lattice can ignore it unless they're extending this project.

## Layout

    TEST_SPEC.md       original wit-side test specification
    README.md          this file
    handoff/
      v1-archive.md    wit ↔ coder dialogue, turns 1-6
      v2-archive.md    wit ↔ coder dialogue, turns 7-13 (active)
    inc/
      is_prime.winc          walker trial-division (Tier B)
      shell_phase1.winc      walker phase 1 (N≤13, trial division)
      shell_phase1_sieve.winc walker phase 1 (N≥14, C-side bit sieve)
    tests/
      expect.txt              <test_name> <expected_integer>
      *.w                     fast primes walks (sub-second battery)
      slow/*.w                slow walks (N=17, N=18, minutes)

## Tiers

- **Tier B — prime counting**: `prime_pi_{13,40,121,364}`, `sieve_pi_364`.
  Validates trial-division walker and the C-side sieve against each
  other at π(364) = 72.
- **Tier C — shell-identity theorem**: `shell_reduce_{N3,N4}` (hardcoded
  reductions), `shell_gcd_{N3,N4,N12}` (full pipeline, walker phase 1),
  `shell_gcd_{N3,N4}_c` (parallel C phase 1 cross-validation),
  `slow/shell_gcd_{N17,N18}{,_c}` (large-N serial + parallel pairs).

## Known results

    N=3   g = 13
    N=4   g = 5
    N=12  g = 91
    N=17  g = 64570081
    N=18  g = 532171       (first new finding, matches wit prediction)

Serial walker and parallel C give the same answer for all N≥3 tested.
The `_c` variants exist to catch phase-1 bugs before they corrupt
large-N results.

## Running

From the lattice root:

    ./run            fast battery (framework + primes, sub-second)
    ./run slow       adds slow/ primes walks (minutes per walk)

The runner auto-discovers walks under both `tests/` and `primes/tests/`
and loads expected values from both `expect.txt` files.
