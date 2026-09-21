# Analysis and joint task extension

The NBER June 2017 paper's Proposition 3, with a binding technology frontier $I^{\ast}=I<\widetilde I$, decomposes the response to a marginal increase in the automation frontier:

$$d\ln W=d\ln Y|_{K,L}-(1-s_L)\frac{\Lambda_I}{\widehat\sigma+\varepsilon_L}\,dI.$$

This follows directly from the two equations in Appendix B. Equation (B9) is $s_L x+(1-s_L)z=p$, where $x=d\ln W$, $z=d\ln R$, and $p=d\ln Y|_{K,L}$. Equation (B10), for $dN=0$, is $x-z=-\Lambda_I dI/(\widehat\sigma+\varepsilon_L)$. Substituting $z=x-(x-z)$ into (B9) yields $x=p+(1-s_L)(x-z)$, hence the displayed formula. Here $s_L=WL/(WL+RK)=WL/[(1-\eta)Y]$ is the share of **net** output paid to labor.

Holding $N$ fixed and dividing by $dI>0$, let $P_I=(d\ln Y|_{K,L})/dI$. Under the proposition's maintained conditions, $P_I>0$, $\Lambda_I>0$, $0<s_L<1$, $\widehat\sigma>0$, and $\varepsilon_L>0$. Thus the displacement term is strictly negative even though productivity rises. The exact local wage condition is

$$\operatorname{sgn}\left(\frac{d\ln W}{dI}\right)=\operatorname{sgn}\left[P_I-\frac{(1-s_L)\Lambda_I}{\widehat\sigma+\varepsilon_L}\right].$$

The relative wage to rental ratio, labor share, and employment still decline in the constrained case. One must not infer the wage sign from the labor share sign. At a slack automation frontier, $I^{\ast}=\widetilde I<I$, marginal technological automation changes none of these outcomes. The exact kink $I^{\ast}=I=\widetilde I$ needs separate derivatives from each side, as Proposition 2 notes.

The script in `analysis/` checks sign arithmetic with illustrative inputs only. A full equilibrium calculation would have to solve equations (6), (8), (9), (10), and (11) jointly and enforce all task, supply, and price index restrictions. The simple sign check does not establish those premises.

## Own extension: automation and new tasks change together

Let the initial task interval be $[N-1,N]$ and the new interval be $[N+\Delta N-1,N+\Delta N]$. The automation frontier moves from $I$ to $I+\Delta I$. Suppose the technological frontier determines actual allocation in both states, meaning $I\le\widetilde I_0$ and $I+\Delta I\le\widetilde I_1$. Both frontiers must lie inside their corresponding task intervals. The cost cutoff may change between states.

Under these explicit conditions, the measure of tasks assigned to labor is $m_0=N-I$ initially and $m_1=N+\Delta N-I-\Delta I$ afterward. Therefore

$$m_1-m_0=\Delta N-\Delta I,\qquad m_1>m_0\iff\Delta N>\Delta I.$$

![Phase diagram of joint task changes](assets/joint-task-extension.svg)

For example, $N=1$, $I=0.4$, both cost cutoffs equal to $0.8$, $\Delta I=0.15$, and $\Delta N=0.25$ satisfy the stated conditions. Labor task mass rises from $0.6$ to $0.7$. Replacing $\Delta N$ with $0.08$ gives a fall to $0.53$. The [Python example](analysis/joint_task_extension.py) and its [recorded output](checks/joint_task_extension.txt) reproduce these numbers. They illustrate task allocation only.

The exact identity, strict comparison, and nonnegative capital and labor task masses are proved in [JointTaskExtension.lean](lean/JointTaskExtension.lean). Its [run note](lean/docs/EXTENSION_NOTE.md) states the hypotheses and proof scope. A larger labor task mass does not by itself prove that employment, labor share, or wages rise. Those outcomes require the equilibrium response of factor prices and supplies. The [Lean build and required check](checks/lean-fast-check.txt) verify the code in the generated AppliedModelingLib folder.
