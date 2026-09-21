# Source-only inventory: NBER Working Paper 22252 (June 2017)

This record preserves the source-first review completed before the current Lean
extensions. It is a working inventory, not a v11 source map, statement-match
judgment, or closeout receipt.

## Pinned source

- Version: NBER Working Paper 22252, revised June 2017, 87 PDF pages.
- Private paper-local artifact: `source/w22252-june2017.pdf`.
- PDF SHA-256: `441d01202afd56ef8002fc24ffc2beb51191741c0b5accb11d2534620dd616b7`.
- Private extracted text: `source/w22252-june2017.txt`.
- Text SHA-256: `1f89a7cd560a604f7e10f4a401a924ce0857b89459170885ba7dd16b1534bd50`.
- The full 4,689-line text extraction was read source-only. PDF pages carrying
  equations (5), (6), (13), Proposition 3, and the capital-threshold clause
  were also visually checked against the pinned PDF.
- Both source artifacts remain ignored and private.

## Named theoretical-result candidates

The source-only pass found 19 independently labelled result candidates:

1. Main text: Propositions 1--9 and Corollaries 1--2.
2. Appendix A: Lemmas A1--A3.
3. Appendix B: Proposition B1, Lemma B1, and Propositions B2--B4.

The paper also labels Assumptions 1, 2, 3, 1′, 4, 1″, 2′, and 2″. Those
are semantic prerequisites, not results. No source result is promoted into
`PaperInterface.lean` yet, because the required atomized source map and v11
statement review have not been completed.

## Priority source chain

- Section 2.1 defines a unit measure of tasks on `[N - 1, N]` and interprets
  an increase in `N` as replacing the lowest-index task with a new top task.
- Section 2.1 defines `I` as the technological automation frontier: tasks at
  or below it can use capital; tasks above it cannot.
- Equation (5) gives unit costs. Assumption 1 makes `γ` strictly increasing.
- Equation (6) defines the cost-equality cutoff by `W/R = γ(Ĩ)`. The source
  then sets `I* = min {I, Ĩ}` and assigns a tie at `I*` to capital (footnote
  12). Lower tasks use capital and higher tasks use labor.
- Equation (13), visually checked in the pinned PDF, is
  `ln ω + (1/σ̂) ln Lˢ(ω) = (1/σ̂ - 1) ln K
  + (1/σ̂) ln((∫_I^N γ(i)^(σ̂-1) di)/(I-N+1))`, with
  `ω = W/(R K)`.
- Proposition 3 gives, in the technology-constrained branch, the exact wage
  response
  `d ln W = d ln Y|_{K,L}
    + (1-s_L)/( σ̂+ε_L ) · (Λ_N dN - Λ_I dI)`.
  It separately states that a capital threshold `K̄ > K_` exists below which
  automation raises wages and above which it reduces them.
- Appendix equations (B9)--(B10) give the factor-income log decomposition and
  relative-price response used to solve for wages. The current Lean work
  covers the `dN = 0` automation specialization only.
- The paper describes automation's adverse task-reallocation term as the
  displacement effect. Creation of new tasks supplies the opposing force. The
  reviewed June 2017 passage does not use the word "reinstatement" for it.

## Source issues found during the source-only pass

These are open leads for the fidelity audit, not repaired source claims:

1. Appendix A Assumption 2′ prints exponent `2+2σ+η`, while the proof of
   Lemma A1 later uses `2+2σ+ζ` (extracted-text lines 1885--1887 versus
   3124).
2. Proposition B1's Assumption-2 specialization prints a negative sign on the
   `N` response, although its own earlier qualitative statement and (B10)
   require the new-task response to be positive (lines 3180--3192 versus
   equation (B10)).
3. Proposition 9 and Proposition B2 state `I* = I > Ĩ`; the paper's definition
   `I* = min {I, Ĩ}` and the technology-constrained branch elsewhere require
   `I* = I < Ĩ`.
4. Proposition B3 invokes Assumption 1″ immediately after introducing the more
   demanding homotheticity Assumption 2″. Whether this is intentional is not
   resolved by the source text.
5. Proposition B3 says the baseline capital and labor market-clearing
   equations remain unchanged even though the variant also lets
   non-automated tasks use capital. This requires a fresh derivation before
   formal use.
6. A dynamic wage display mixes `n*` and `n`; the intended evaluation point
   has not been established and remains quarantined.

## Current formalization boundary

- Fully proved as support mathematics: endpoint width and task-mass
  decomposition; cutoff minimum branches; capital/labor partition and tie
  convention; unit-cost ordering around the cost cutoff; constrained
  displacement and fixed-cutoff new-task expansion; the lower-bound derivative
  producing `-Λ_I`; equation (13) to automation-side (B10); fixed-factor
  income accounting to (B9); normalization `ω = W/(R K)`; and the resulting
  automation-only wage equality and strict sign condition.
- Partial named-result coverage: the threshold/allocation components of
  Propositions 1--2 and the `dI` wage-response component of Proposition 3.
  These results are not claimed because equilibrium existence/uniqueness,
  source assumptions, the `dN` term, positivity package, and the `K̄` clause
  remain open.
- Fully claimed named source results: none of 19.
