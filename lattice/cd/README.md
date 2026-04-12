# cd — the Cayley-Dickson tower project

Second project built on top of the lattice framework. Integer-exact
Cayley-Dickson multiplication from d=2 (complex) up through d=32
(pathion), with the end goal being `cd_chains_d32` — exact integer
enumeration of zero-divisor chains in the 32-dimensional CD algebra.

Lattice is the framework. Primes is one project (prime-shell
theorem). CD is another. Each lives under its own folder so a future
wit can ignore whichever track isn't theirs.

## Layout

    README.md          this file
    TEST_SPEC.md       Tier D spec (d4 → d8 → d16 → d32 → chains)
    handoff/           wit ↔ coder dialogue archive
      v1.md            first CD handoff
    inc/               shared .winc fragments (none yet)
    tests/
      expect.txt       <test_name> <expected_integer>
      passing/         walk sources

## Progression

- **d2** (complex): base case. Already green as `cd_mul_d2_real_neg7`
  and `cd_mul_d2_imag_22` under `tests/passing/` in the framework
  root (pre-dates the compartment split).
- **d4** (quaternion): walker-native `fn_cd_mul_d4` bond, |D|=45.
  First-compiled Turn 15. Four sanity walks (identity, i², non-
  commutativity, norm²).
- **d8** (octonion): upcoming.
- **d16** (sedenion): first zero-divisors appear here.
- **d32** (pathion): target of `cd_chains_d32`.

## Running

From the lattice root:

    ./run            fast battery (framework + primes + cd)
    ./run slow       adds slow/ walks

The runner auto-discovers walks under `tests/`, `primes/tests/`, and
`cd/tests/`, and loads expected values from each `expect.txt`.
