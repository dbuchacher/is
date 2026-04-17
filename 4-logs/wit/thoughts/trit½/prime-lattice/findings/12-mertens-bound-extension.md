# Mertens bound extension — shells N=19..21 and between-shells

**Date**: 2026-04-16
**Prior**: `05-riemann-compute.md` had shells through N=13; prior
session counted 15 consecutive holds through N=17/18.
**Method**: segmented numpy Mobius sieve with running `M²/x`
extremum tracking. **Code**: `../code/mertens_extension.py`.

## Task A — shell-boundary extension

```
  N       x_N                M(x_N)    M²/x_N     M²<x_N?
  18      193,710,244        −2,254    0.02623    YES
  19      581,130,733         2,800    0.01349    YES
  20    1,743,392,200        −2,619    0.00393    YES
  21    5,230,176,601        13,540    0.03505    YES
```

Cross-validation: M(10⁸) = 1928 and M(10⁹) = −222 match OEIS
A084237 exactly. Runtime: N=20 = 184s, N=21 = 567s.

**Consecutive-hold count**: **19** (N=3..21). Earlier 15-hold count
is extended by 4 more shells through x_21 ≈ 5.23×10⁹.

Shell extrema: smallest ratio at N=12 (4×10⁻⁶, M=1). Next: N=16
and N=20 both at 0.0039. Largest (among recent): N=9 = 0.163.
N=21 lands at a generic 0.035 — NOT abnormally suppressed.

## Task B — between-shell density scan

Sampled ~140 x values: `10^k + {0, 1, 7, 23, 99, 101, 547, 1009,
9973, 99991, 999983, 10^k/2}` for k=3..9, plus mid-shell fractions
(¼, ½, ¾) between each (x_N, x_{N+1}) pair for N=3..20, plus
lattice points (powers of 2,3,5,...).

Results on [100, 5.23×10⁹]:

- **Global max M²/x = 0.3216** at x=199 (M=−8). Classical Mertens
  peak. Does NOT move as we extend past 5×10⁹.
- **Second peak**: 0.1433 at x=59,048 (M=−92).
- At x=10⁹: M=−222, ratio 4.9×10⁻⁵. At x=10⁸: M=1928, 0.037.
- At x=10⁷+547: 0.115 (local peak near 10⁷).
- Mid-shell (x_20,x_21)≈2.615×10⁹: M=−13,941, ratio 0.074.

**Exceedances (M²/x ≥ 1): ZERO** across all sampled points AND the
full cumulative walk. The ratio fluctuates roughly in [10⁻⁸, 0.3],
with largest values concentrated at small x (<10⁴). For large x
typical ratios are 10⁻² to 10⁻⁵ — declining on average.

## Framework implication

**The tighter bound M²/x < 1 holds at shell boundaries AND between
them, uniformly through 5.23×10⁹.** The data does NOT support a
"bound holds at shells, fails between" story (framework's preferred
reading — wheel writes only at grade boundaries).

What the data DOES show:

1. Some shell boundaries are abnormally suppressed: N=12 (~10⁻⁶),
   N=16, N=20 (~0.004). 10×–1000× below nearby between-shell
   ratios. Consistent with the cell-cancellation observation in
   findings/05.

2. But suppression is probabilistic, not deterministic: N=21 at
   0.035 is a generic mid-shell value. The "lattice complete"
   property doesn't force small M(x_N) uniformly.

3. Between-shell ratios also stay under 1. The global max (0.32
   at x=199) is a small-x artifact, not a shell-structural event.

## Honest verdict — NEUTRAL, leaning weakly STRONGER

Stronger:
- 19 consecutive shell holds is a clean extension of the pattern.
- Six shells (k=4,6,10,12,16,20) give M² < 10⁻² · x — an order of
  magnitude below random-walk expectation.
- No counterexample to M² < x anywhere in [100, 5.23×10⁹].

Neutral:
- Bound holds between shells too → "shells-only" framing NOT
  supported by data.
- N=21's generic ratio shows suppression is not deterministic.
- 10⁴× below the Odlyzko–te Riele 1985 counterexample region
  (~10¹⁴); can't distinguish framework-wheel from generic
  √x-random-walk scaling.

The framework reading survives but isn't uniquely validated. The
"between-shells fail" prediction would have been stronger evidence;
we don't see it. Conversely, the shell-suppression at k=12,16,20
IS real and distinct from generic behavior — worth formalizing
(Claim A in findings/05 gains empirical weight).

**Next move**: find the *specific* x where M²/x spikes in the
5×10⁹ to 10¹⁴ region (infeasible with this sieve — needs
Deléglise–Rivat or equivalent). If spikes localize at
lattice-adjacent positions (just past a shell, near a
highly-composite), that's a framework signal. Generic fluctuations
would be neutral.
