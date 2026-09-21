# Analytical check: the wage trap

The NBER June 2017 paper's Proposition 3, technology-constrained case $I^*=I<\widetilde I$, decomposes the response to a marginal increase in the automation frontier:

$$d\ln W=d\ln Y|_{K,L}-(1-s_L)\frac{\Lambda_I}{\widehat\sigma+\varepsilon_L}\,dI.$$

Holding $N$ fixed and dividing by $dI>0$, let $P_I=(d\ln Y|_{K,L})/dI$. Under the proposition's maintained conditions, $P_I>0$, $\Lambda_I>0$, $0<s_L<1$, $\widehat\sigma>0$, and $\varepsilon_L>0$. Thus the displaced-task term is strictly negative even though productivity rises. The exact local wage condition is

$$\operatorname{sgn}\left(\frac{d\ln W}{dI}\right)=\operatorname{sgn}\left[P_I-\frac{(1-s_L)\Lambda_I}{\widehat\sigma+\varepsilon_L}\right].$$

The relative wage-rental ratio, labor share, and employment still decline in the constrained case. One must not infer the wage sign from the labor-share sign. At a slack automation frontier, $I^*=\widetilde I<I$, marginal technological automation changes none of these outcomes. The exact kink $I^*=I=\widetilde I$ needs separate one-sided derivatives, as Proposition 2 notes.

The script in `analysis/` checks sign arithmetic with illustrative inputs only. A full equilibrium calculation would have to solve equations (6), (8)–(11) jointly and enforce all task, supply, and price-index restrictions. The simple sign check does not establish those premises.
