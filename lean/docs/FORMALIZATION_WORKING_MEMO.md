# Formalization Working Memo: The Race Between Machine and Man: Implications of Technology for Growth, Factor Shares and Employment

This is a working lead log, not audit evidence and not a final validation
report. Record possible issues while reading and proving; independently verify
each retained item against the pinned source and final Lean surface during
closeout.

For every item, record the exact source location, current mathematical reading,
Lean treatment, and review state. Prefer “clarification” unless the printed
formula or statement is actually false.

## Possible Source Clarifications

- Proposition B3 (Appendix B, around equation (B17)) refers to Assumption 1″
  immediately after introducing Assumption 2″ as the homotheticity condition.
  The intended assumption reference is unresolved. No Lean premise or result
  has been created from this passage.
- Proposition B3 says the baseline market-clearing equations (8)--(9) still
  apply in a variant where non-automated tasks can also use capital. This needs
  a direct re-derivation before use.
- A dynamic wage display mixes `n*` and `n`. The intended evaluation point is
  unresolved and the display is outside the current static proof seam.

## Possible Printed Typos Or Errors

- Assumption 2′ (Appendix A; extracted-text lines 1885--1887) has exponent
  `2+2σ+η`; the later proof of Lemma A1 uses `2+2σ+ζ` (line 3124).
  Classification: possible printed exponent error; open.
- Proposition B1's Assumption-2 specialization prints
  `(1/ω)∂ω/∂N = -Λ_N/(σ̂+ε_L)` (lines 3180--3192), conflicting
  with its earlier positive `N` comparative static and the positive `Λ_N`
  term in (B10). Classification: likely sign error; no corrected endpoint is
  yet claimed.
- Proposition 9 and Proposition B2 state `I* = I > Ĩ`, although equation (6)
  defines `I* = min {I, Ĩ}` and the constrained branch elsewhere is
  `I* = I < Ĩ`. Classification: likely inequality-direction error; open.

## Possible Proof-Strategy Deviations

- `taskRatio_hasDerivAt_log` derives the `-Λ_I` term directly with the
  fundamental theorem of calculus and quotient/log differentiation. It does
  not import the paper's Proposition 2 conclusion as a premise.
- `B9_from_factorIncome` differentiates
  `W(I)L + R(I)K = (1-η)Y(I)` at fixed `K,L`; it does not assume (B9).
- `B10_from_relativeDemandEquation` differentiates the exact equation (13),
  then proves that the normalized-wage derivative equals
  `d ln W - d ln R`. The current route assumes equation (13) as a functional
  identity and does not yet derive it from all equilibrium equations.

## Possible Model Conventions Or Extra Assumptions

- Tasks are represented by reals in `[N-1,N]`; the task interval width and
  capital/labor subinterval lengths are formalized algebraically.
- `IsCapitalTask` uses `i ≤ I*` and `IsLaborTask` uses `I* < i`, matching
  footnote 12's tie-to-capital convention.
- Unit-cost ordering makes `R>0` and `γ(i)>0` explicit. These are economic
  domain conditions needed to transport inequalities through division; they
  are not silently inferred from strict monotonicity.
- The equation-(13) bridge exposes continuity, differentiability, nonzero
  integral/interval width, nonzero prices/output/capital, and
  `σ̂+ε_L ≠ 0`. A later paper-facing Spec must source or derive the
  economically stronger positivity conditions instead of treating this
  support signature as the final source statement.
- The June 2017 text calls the opposing mechanism "creation of new tasks";
  the current documentation uses that source wording and notes its relation to
  later "reinstatement" terminology without attributing that word to this PDF.

## Deferred Formalization Or Library Work

- Construct the full static equilibrium and derive equation (13), rather than
  receiving it as a functional premise.
- Instantiate `weight` with `paperTaskWeight γ σ̂` and prove continuity and
  positivity from source-domain assumptions.
- Derive the `Λ_N dN` response and combine it with the proved automation term.
- Prove the productivity response and the existence/order of the Proposition 3
  capital threshold `K̄ > K_`; neither is implied by the current sign iff.
- Complete the v11 source map and atomized statement review before adding any
  of the 19 named results to `PaperInterface.lean`.
