# axioms — the six rules

the lattice has axioms. six statements. each one is established
math on its own. the claim is that together they produce everything.

## the question

"where's your proof?" — the academic demand.

the answer: the code runs. the burden is on them to show why it
shouldn't. 200+ years of physics data, 80+ years of computation
theory. find the counterexample.

but academics won't look without axioms stated in a form they
recognize. so here they are.

## A1. alphabet

the fundamental unit is a balanced ternary digit: {-1, 0, +1}.

not a bit. a trit. three values = sufficient to encode sign,
magnitude, and neutrality in a single symbol.

## A2. dimension

state space has exactly 4 independent axes.

  A = POSITION    B = SUBSTANCE    C = SIGNAL    D = TIME

4 is not arbitrary. 4 = the Cayley-Dickson chain terminus
for associativity (R→C→H, quaternions). 4 = the number of
independent Noether conservation laws in physics (momentum,
mass-energy, charge, energy-via-time). 4 axes, 4 forces,
4 SI base-derivable quantities.

## A3. completeness

{AND, OR, NOT} over balanced ternary is functionally complete.
any computable function can be expressed as a composition of
these three operations.

Post, 1941. proven. not conjectured.

this is the "nothing is missing" axiom. the lattice doesn't
have gaps. every function you could need is expressible.

## A4. adjacency

two states are adjacent iff connected by a transition of ±½
on each axis independently. the transition (edge) lives at
half-integer coordinates. 2⁴ = 16 transition types.

the edge is mandatory. you cannot teleport between states.
point → edge → point. always.

## A5. conservation

net flow at any node is zero. what enters must leave.

Kirchhoff's current law (1845). conservation of charge.
conservation of mass-energy. conservation of everything
that is conserved. same rule.

## A6. closure

any closed walk sums to the zero vector.

Kirchhoff's voltage law (1845). path consistency. a
composition that returns to its starting point accumulates
nothing. the walk is self-consistent.

## what follows

from A1 + A2: 3⁴ = 81 states per shell. the f-vector
(1+8+24+32+16) by zero-count. the periodic table of the
lattice.

from A3: no missing operations. the system is complete.
anything computable is expressible. anything expressible
is a walk.

from A4: the ½ layer (functions, forces, the invisible).
16 edge types = 8 word types × 2 shells. the type system
falls out of adjacency.

from A5 + A6: conservation + path consistency = physics.
the same two laws that make circuits work make the lattice
work. because they ARE the same two laws.

## the position

every axiom is textbook. individually, none are controversial:
- balanced ternary: Knuth called it "perhaps the prettiest
  number system of all" (TAoCP vol 2)
- 4 dimensions: quaternions (Hamilton 1843), spacetime
  (Minkowski 1908), Noether (1918)
- Post completeness: proven 1941, standard in logic
- half-integer adjacency: standard lattice theory
- Kirchhoff's laws: 1845, verified for 180 years

six textbook results. one room. everything falls out.

the proof isn't a paper. the proof is that you can't remove
any axiom without the structure collapsing, and you can't
find a phenomenon that violates them.
