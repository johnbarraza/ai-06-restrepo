# Repository 6: Acemoglu and Restrepo (2018)

![A task continuum divided between capital and labor](assets/banner.svg)

[![Read the paper](assets/badges/paper.svg)](https://www.nber.org/papers/w22252)
[![View presentation](assets/badges/slides.svg)](presentation.pdf)
[![Explore Lean proofs](assets/badges/lean.svg)](lean/)
[![Read prompt record](assets/badges/prompts.svg)](prompts.md)

**The Race between Man and Machine: Implications of Technology for Growth, Factor Shares, and Employment.** *American Economic Review* 108(6), 1488–1542. [DOI](https://doi.org/10.1257/aer.20160696) · [NBER working paper 22252](https://www.nber.org/papers/w22252) · [course issue](https://github.com/alexanderquispe/AI-Econ-Modeling/issues/5)

This repository reads the **87-page NBER version revised in June 2017**. The pinned PDF has SHA-256 `441d01202afd56ef8002fc24ffc2beb51191741c0b5accb11d2534620dd616b7`. Result and page numbering below refer to that version.

## Question and economic mechanism

When does automation reduce labor's share, employment, or the real wage, and when can new tasks reverse those effects? A unit measure of tasks occupies $[N-1,N]$. Tasks up to the technological frontier $I$ can use capital; those above it require labor. Because labor productivity $\gamma(i)$ rises with task complexity, competitive firms allocate lower-index tasks to capital up to $I^{\ast}=\min\{I,\widetilde I\}$, where $W/R=\gamma(\widetilde I)$. Raising $I$ displaces labor from existing tasks. Raising $N$ introduces new labor-intensive tasks and replaces the least complex old tasks, reinstating labor.

## The agents' problems

Firms minimize the *effective factor cost* task by task: for $i\le I$, they compare $R$ with $W/\gamma(i)$; for $i>I$, only labor is feasible (equation 5). The full unit price also reflects the intermediate-input share $\eta$, so it is not generally just that effective factor cost. A representative household chooses consumption $C$ and labor $L$ subject to $C=WL+RK$, maximizing the utility in equation (4), with increasing convex labor disutility $\nu(L)$. Its interior labor-supply condition is $\nu'(L)=W/C$. Capital $K$ and technology $(I,N)$ are fixed in the static model; factor prices, output, and the actual task threshold clear competitively.

## Main results and conditions

Propositions 1–3 assume: **(1)** $\gamma(i)$ is strictly increasing; **(2)** either the intermediate-input share $\eta\to0$ or its substitution elasticity $\zeta=1$; and **(3)** $K<\bar K$ as defined in the paper, so the newest task is used. The task elasticity $\sigma>0$, effective elasticity $\widehat\sigma=\sigma(1-\eta)+\zeta\eta>0$, and labor-supply elasticity $\varepsilon_L>0$ enter the comparative statics. In the base environment $\eta\in(0,1)$, $\zeta>0$, $K>0$, and $\nu$ is continuously differentiable, increasing, convex, and satisfies the paper's extra concavity restriction $\nu''(L)+(\theta-1)(\nu'(L))^2/\theta>0$.

When automation is **technology constrained**, $I^{\ast}=I<\widetilde I$, Proposition 2 gives

$$\frac{d\ln(W/R)}{dI}=\frac{d\ln\omega}{dI}=-\frac{\Lambda_I}{\widehat\sigma+\varepsilon_L}<0,\qquad \Lambda_I>0.$$

The labor share $s_L=WL/(WL+RK)=WL/[(1-\eta)Y]$ and employment move with $\omega=W/(RK)$, so both fall. Proposition 3 separates the **positive productivity effect** $P_I=d\ln Y|_{K,L}/dI$ from **displacement**:

$$\frac{d\ln W}{dI}=P_I-\frac{(1-s_L)\Lambda_I}{\widehat\sigma+\varepsilon_L}.$$

Thus the real wage **rises precisely when** $P_I>(1-s_L)\Lambda_I/(\widehat\sigma+\varepsilon_L)$, falls when the inequality reverses, and is locally unchanged at equality. Automation does not necessarily reduce wages. If $I^{\ast}=\widetilde I<I$, the automation constraint is slack and a marginal rise in $I$ has no effect on factor prices or the labor share. At $I^{\ast}=I=\widetilde I$, the paper notes distinct one-sided derivatives.

By contrast, creating new tasks ($N\uparrow$) raises $W/R$, employment, labor share, and the wage under the same maintained assumptions. This is the reinstatement effect. The static statements do not by themselves establish that the long-run wage falls: capital accumulation changes that conclusion.

## Lean formalization and verification

The `lean/` folder is the complete generated `papers/AR18RaceManMachine/` folder from our own [AppliedModelingLib](https://gargnikhil.com/AppliedModelingLib/) run. It was produced with `gpt-5.6-sol` at `xhigh` reasoning, then copied without reorganizing its files. Ordinary `git add lean/` respected the generated `.gitignore`, so the private source PDF and extracted text are not published.

| Checked support result | Scope |
|---|---|
| [Task threshold and allocation](lean/StaticModel.lean) | The task interval, cost cutoff, displacement, and new-task mass with an explicit fixed cutoff. |
| [Appendix B bridges](lean/ComparativeStatics.lean) | Equation (13) to (B10), and fixed-factor income to (B9), under stated differentiability and nonzero assumptions. |
| [Wage equality and sign condition](lean/MainTheorems.lean) | The automation-only wage response conditional on those model identities. |

The [build and required fast check](checks/lean-fast-check.txt) passed. The [run handoff](lean/docs/RUN_HANDOFF.md) and [status file](lean/status.json) identify the remaining proof obligations. **Status: partially formalized.** No complete named proposition or full equilibrium is claimed.

## Repository materials

- [`analysis/wage_condition.py`](analysis/wage_condition.py) checks the Proposition 3 sign inequality using illustrative comparative-static inputs.
- [`presentation.tex`](presentation.tex) and [`presentation.pdf`](presentation.pdf) provide the 23-slide, 20-minute deck, including five Lean slides.
- [`prompts.md`](prompts.md) records our raw prompts and relevant responses. The repository 4 and 5 examples informed the presentation, but their dialogue and Lean work are not claimed as ours.
- [`hand/README.md`](hand/README.md) gives the steps for the student's handwritten derivation. The required genuine photograph is still pending.

**Remaining requirement:** add a genuine photograph of the student's handwritten derivation to `hand/derivation.jpg` before the Thursday, September 24, 22:00 deadline (Lima time). The repository link must also be posted on the [course issue](https://github.com/alexanderquispe/AI-Econ-Modeling/issues/5).
