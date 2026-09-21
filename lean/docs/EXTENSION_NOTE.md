# Joint changes in task creation and automation

This extension asks what happens to the measure of tasks performed by labor
when the technological frontier and the endpoint of the unit task interval
change together. It is an accounting result about task allocation. It is not
a new proposition attributed to Acemoglu and Restrepo.

Let the initial interval be `[N − 1, N]`, with frontier `I`. Let the new
endpoint be `N + ΔN` and the new frontier be `I + ΔI`. The cost cutoff may
change from `c₀` to `c₁`. The theorem requires `I ≤ c₀` and `I + ΔI ≤ c₁`,
so the technological frontier determines actual allocation in both states.
It also requires both frontiers to lie inside their corresponding unit task
intervals.

Under these conditions, the labor task masses are `m₀ = N − I` and
`m₁ = (N + ΔN) − (I + ΔI)`. Hence

```text
m₁ − m₀ = ΔN − ΔI
m₁ > m₀  if and only if  ΔN > ΔI
```

The first equality and the strict equivalence are proved in
`JointTaskExtension.lean`. The first theorem also checks that capital and
labor task masses are nonnegative in both states. The Lean proof uses the
cutoff minimum from `StaticModel.lean`, then exact real arithmetic.

For illustration, `N = 1`, `I = 0.4`, `c₀ = c₁ = 0.8`, `ΔI = 0.15`, and
`ΔN = 0.25` give `m₀ = 0.6` and `m₁ = 0.7`. This is a feasible example of
task mass expansion, not a calibrated or solved equilibrium.

The proof does not show what happens to hours, employment, labor share,
output, or wages. Those outcomes depend on prices, supply, and equilibrium
conditions that this extension does not establish.
