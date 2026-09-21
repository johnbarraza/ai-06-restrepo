# Repository 6 — Acemoglu & Restrepo (2018)

**The Race between Man and Machine: Implications of Technology for Growth, Factor Shares, and Employment.** *American Economic Review* 108(6), 1488–1542. [DOI](https://doi.org/10.1257/aer.20160696) · [NBER working paper 22252](https://www.nber.org/papers/w22252) · [course issue](https://github.com/alexanderquispe/AI-Econ-Modeling/issues/5)

This repository reads the **87-page NBER version revised in June 2017**. The pinned PDF has SHA-256 `441d01202afd56ef8002fc24ffc2beb51191741c0b5acbd2534620dd616b7`. Result and page numbering below refer to that version.

## Question and economic mechanism

When does automation reduce labor's share, employment, or the real wage, and when can new tasks reverse those effects? A unit measure of tasks occupies $[N-1,N]$. Tasks up to the technological frontier $I$ *can* use capital; those above it require labor. Because labor productivity $\gamma(i)$ rises with task complexity, competitive firms allocate lower-index tasks to capital up to $I^*=\min\{I,\widetilde I\}$, where $W/R=\gamma(\widetilde I)$. Raising $I$ displaces labor from existing tasks. Raising $N$ introduces new labor-intensive tasks and replaces the least complex old tasks, reinstating labor.

## The agents' problems

Firms minimize the *effective factor cost* task by task: for $i\le I$, they compare $R$ with $W/\gamma(i)$; for $i>I$, only labor is feasible (equation 5). The full unit price also reflects the intermediate-input share $\eta$, so it is not generally just that effective factor cost. A representative household chooses consumption $C$ and labor $L$ subject to $C=WL+RK$, maximizing the utility in equation (4), with increasing convex labor disutility $\nu(L)$. Its interior labor-supply condition is $\nu'(L)=W/C$. Capital $K$ and technology $(I,N)$ are fixed in the static model; factor prices, output, and the actual task threshold clear competitively.

## Main results and conditions

Propositions 1–3 assume: **(1)** $\gamma(i)$ is strictly increasing; **(2)** either the intermediate-input share $\eta\to0$ or its substitution elasticity $\zeta=1$; and **(3)** $K<\bar K$ as defined in the paper, so the newest task is used. The task elasticity $\sigma>0$, effective elasticity $\widehat\sigma=\sigma(1-\eta)+\zeta\eta>0$, and labor-supply elasticity $\varepsilon_L>0$ enter the comparative statics. In the base environment $\eta\in(0,1)$, $\zeta>0$, $K>0$, and $\nu$ is continuously differentiable, increasing, convex, and satisfies the paper's extra concavity restriction $\nu''(L)+(\theta-1)(\nu'(L))^2/\theta>0$.

When automation is **technology constrained**, $I^*=I<\widetilde I$, Proposition 2 gives

$$\frac{d\ln(W/R)}{dI}=\frac{d\ln\omega}{dI}=-\frac{\Lambda_I}{\widehat\sigma+\varepsilon_L}<0,\qquad \Lambda_I>0.$$

The labor share $s_L=WL/(WL+RK)=WL/[(1-\eta)Y]$ and employment move with $\omega=W/(RK)$, so both fall. Proposition 3 separates the **positive productivity effect** $P_I=d\ln Y|_{K,L}/dI$ from **displacement**:

$$\frac{d\ln W}{dI}=P_I-\frac{(1-s_L)\Lambda_I}{\widehat\sigma+\varepsilon_L}.$$

Thus the real wage **rises precisely when** $P_I>(1-s_L)\Lambda_I/(\widehat\sigma+\varepsilon_L)$, falls when the inequality reverses, and is locally unchanged at equality. Automation does **not** necessarily reduce wages. If $I^*=\widetilde I<I$, the automation constraint is slack and a marginal rise in $I$ has **no effect** on factor prices or the labor share. At $I^*=I=\widetilde I$, the paper notes distinct one-sided derivatives.

By contrast, creating new tasks ($N\uparrow$) raises $W/R$, employment, labor share, and the wage under the same maintained assumptions. This is the reinstatement effect. The static statements do not by themselves establish that the long-run wage falls: capital accumulation changes that conclusion.

## What this run checks

- [`analysis/wage_condition.py`](analysis/wage_condition.py) evaluates the exact Proposition 3 sign condition and checks that the implied wage and rental-rate responses satisfy Appendix B's (B9) and (B10). Its transparent values are **comparative-static inputs**, not a calibrated equilibrium or a replication of the paper's full model.
- [`hand/README.md`](hand/README.md) identifies the algebra to verify by hand. The required photograph must be taken from the student's actual handwritten derivation; a typeset derivation is not a substitute.
- [`lean/`](lean/) is the complete generated `papers/AR18RaceManMachine/` folder, copied byte for byte after the local run. Its [handoff](lean/docs/RUN_HANDOFF.md) identifies three checked *support* theorems deriving the wage identity and strict sign condition from (B9) and (B10). No full named result or continuum equilibrium is proved. The required `--fast` check passed; see [`checks/lean-fast-check.txt`](checks/lean-fast-check.txt). The configured GPT-5.6 Sol `xhigh` agent performed source intake but hit its usage limit before coding; the later Lean work was completed through local tools, so strict model provenance remains open.
- [`presentation.tex`](presentation.tex) and [`presentation.pdf`](presentation.pdf) form the 23-slide, 20-minute deck, including five slides that show the actual Lean statements, proof step, checks, and boundary. [`prompts.md`](prompts.md) records the actual prompt and relevant answers without borrowing a friend's dialogue.

**Submission status:** draft PR on the `analysis` branch. Before the Thursday, September 24, 22:00 deadline (Lima time), add the genuine handwritten photo, resolve the model-provenance gap if required, merge the PR, and comment with the repository URL on the [course issue](https://github.com/alexanderquispe/AI-Econ-Modeling/issues/5).
