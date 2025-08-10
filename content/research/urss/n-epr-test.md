+++
date = '2025-08-08T17:42:31+01:00'
draft = false
title = 'Classical tolerant identity test for multiple EPR states'
ShowToc = true
TocOpen = true
+++

With the [tolerant identity test](../epr-tolerant-identity-testing) for a single state $\rho_{AB}$ complete, we now turn to the problem of certifying multiple EPR pairs. For brevity we write
$$
\rho = \rho_{AB},
\qquad
\Phi = \ket{\text{EPR}}\bra{\text{EPR}}_{AB}.
$$

In particular, we will show how the same matching-outcomes protocol extends in three settings of increasing generality and difficulty:

1. **Easy (i.i.d. copies).**

   All $n$ copies are identical:
   $$
     \rho^{\otimes n}\quad\text{vs.}\quad\Phi^{\otimes n}.
   $$

2. **Medium (independent, non-identical copies).**

   Each copy may differ but remains uncorrelated:
   $$
     \rho_1\otimes\rho_2\otimes\dots\otimes\rho_n
     \quad\text{vs.}\quad
     \Phi^{\otimes n}.
   $$

3. **Hard (arbitrary adversary).**

   The most general case allows an arbitrary $2n$-qubit state $\rho$, possibly entangled across copies, against which we still wish to test closeness to $\Phi^{\otimes n}$.

We will analyse the number of protocol rounds, $N$, required to certify $n$ EPR pairs.

Can we achieve the same sample complexity
$$
N = O\!\left(n^2\,(\varepsilon_2^2 - \varepsilon_1^2)^{-2}\right)\!.
$$
in all three cases?

> **Note.** In the context of BB'84, these three scenarios correspond directly to the class of attacks that an eavesdropper (Eve) might do:
>
> - **Easy (i.i.d. copies)**:
>   Eve applies the same attack channel to each transmitted qubit independently, with no memory from one round to the next. Every round she starts from scratch, so her joint state is $\rho^{\otimes n}$.
>
> - **Medium (independent, non-identical copies)**:
>   Eve still treats each qubit independently and measures immediately, but she may choose a different attack in each round. Her overall state is the product $\rho_{1}\otimes\rho_{2}\otimes\dots\otimes\rho_{n}$.
>
> - **Hard (arbitrary adversary)**:
>   Eve may entangle her systems across rounds and defer all measurements until the end. There is no tensor-product structure, so her state is an arbitrary $2n$-qubit $\rho$.
>
> By proving security in each model, starting with the easiest and working up to the fully coherent setting, we obtain a hierarchy of BB'84 security guarantees that mirror the increasing power of potential attack by Eve. ~From the sample complexity, we will see that a fully coherent attack (hard case) isn't more difficult to detect than a simple i.i.d. tensor product state (easy case)!~ `<- not sure about this yet`

We begin with the i.i.d. case as it's both the simplest to analyse and a useful building block for the more challenging scenarios.

---

## Easy case (i.i.d. copies)

### A naïve per-copy approach using trace distance

A first idea is to ignore the joint state altogether and simply run the **single-pair** tolerant test on each of the $n$ copies **separately**, then accept only if every individual test passes. Equivalently, one could tally the per-copy mismatch indicators into a total error count and compare that sum against a scaled threshold (thanks to the i.i.d. assumption). At first glance this seems painless, but a closer look shows it is actually *worse* than the collective strategy developed below.

Recall for a single copy $\rho$:
$$
D_1 ~=~ D(\rho,\Phi),
$$
and in the $n$-copy i.i.d. case we have the bound
$$
D_n ~:=~ D\bigl(\rho^{\otimes n},\,\Phi^{\otimes n}\bigr) ~\leq~ n\,D_1.
$$
* **Per-copy tolerance must shrink.**
  To guarantee that the full product state satisfies $D(\rho^{\otimes n},\Phi^{\otimes n}) \leq \varepsilon_1$, the trace-distance of *each* copy must be at most $\varepsilon_1/n$; otherwise the sub-additivity bound $D_n\leq nD_1$ could exceed $\varepsilon_1$.
* **Promise gap narrows by a factor $n$.**
  Replacing $\varepsilon_j$ by $\varepsilon_j/n$ shrinks the gap $\varepsilon_2^2 - \varepsilon_1^2$ by $n^{2}$. For the single-pair test the sample size scales as the inverse square of that gap, so one copy now needs
$$
O\bigl(n^{4}(\varepsilon_2^2-\varepsilon_1^2)^{-2}\bigr)
$$
  samples.
* **Replicated testing scales linearly.**
  Running $n$ such tests and combining them multiplies the sample cost by $n$.

Hence by a very high-level analysis, we obtain a cost for the naïve strategy
$$
N_{\text{naïve}} ~=~ O\bigl(n^{5}(\varepsilon_2^2-\varepsilon_1^2)^{-2}\bigr),
$$
which is three full powers of $n$ ($n^{5}$ vs. $n^{2}$) worse than the collective $n$-copy analysis we develop below. The lesson is that testing each pair in isolation achieves a *stronger* (per-copy) guarantee than we need and pays a steep statistical price; exploiting the product structure directly using just one global test is markedly more efficient.

---

### Global block test using fidelity

For a single copy $\rho$:
$$
F_1 ~=~ F(\rho,\Phi),
\quad
D_1 ~=~ D(\rho,\Phi),
$$
and in the $n$-copy i.i.d. case we have the rules
$$
F_n ~:=~ F\bigl(\rho^{\otimes n},\,\Phi^{\otimes n}\bigr) ~=~ F_1^{n},
\qquad
D_n ~:=~ D\bigl(\rho^{\otimes n},\,\Phi^{\otimes n}\bigr) ~\leq~ n\,D_1.
$$
This means we can express the $n$-copy closeness conditions entirely in terms of the single-copy fidelity $F_1$, thanks to the exact tensor-product rule $F(\rho^{\otimes n},\Phi^{\otimes n}) = F(\rho,\Phi)^n$ (or equivalently $F_n = F_1^n$). Working directly with fidelity avoids the looser trace-distance bound $D(\rho^{\otimes n},\Phi^{\otimes n}) \leq n\,D(\rho,\Phi)$, which would give a much weaker bound than the tight scaling we get from fidelity.

#### Translating hypotheses

Our goal is to distinguish
$$
\begin{cases}
~\mathbf{H_0}: &D_n \,\leq\,\varepsilon_1
	\quad\iff\quad \rho^{\otimes n}\text{ is “close” to }\Phi^{\otimes n},\\[6pt]
~\mathbf{H_1}: &D_n \,\geq\,\varepsilon_2
	\quad\iff\quad \rho^{\otimes n}\text{ is “far” from }\Phi^{\otimes n},
\end{cases}
$$
with $0 \leq \varepsilon_1 < \varepsilon_2 \leq 1$. By Fuchs–van de Graaf,
$$
1 - F_n ~\leq~ D_n ~\leq~ \sqrt{1 - F_n^{2}},
$$
so controlling $F_n$ tightly leads to a corresponding control on $D_n$. Since $F_n = F_1^{n}$, we can use this and the upper bound of Fuchs–van de Graaf to rewrite the hypotheses as fidelity conditions per-copy:
$$
\begin{cases}
~\mathbf{H_0}: \quad &D_n \,\leq\,\varepsilon_1 &\impliedby &F_n^2 ~\geq~ 1 - \varepsilon_1^2
&\iff
&F_1 ~\geq~ (1 - \varepsilon_1^2)^{1/(2n)}
\\[4pt]
~\mathbf{H_1}: \quad &D_n \,\geq\,\varepsilon_2 &\implies &F_n^2 ~\leq~ 1 - \varepsilon_2^2
&\iff
&F_1 ~\leq~ (1 - \varepsilon_2^2)^{1/(2n)}
\end{cases}\quad.
$$

You might be wondering why we need a <u>sufficient</u> condition for $\mathbf{H_0}$ and a <u>necessary</u> condition for $\mathbf{H_1}$. This is because our decision rule (defined later) is written in terms of the true error rate $\delta$. For the test outcome to be a reliable guarantee, our proof must rigorously connect the decision to the true state. This requires establishing two conditions:

- **Soundness of acceptance (Accept ⇒ Close; avoid false accepts).**
  Why do we use a "sufficient" $F\!\to\!D$ direction? We want "if the test accepts, the global state is close", i.e. no false accept. That needs an *upper* bound on distance from fidelity, which comes from the **right-hand** FvG:
  $$
  D_n \leq \sqrt{1 - F_n^2}.
  $$
  So we enforce $F_n \geq \sqrt{1 - \varepsilon_1^2}$ (equivalently $F_1 \geq (1 - \varepsilon_1^2)^{1/(2n)}$), which *forces* $D_n \leq \varepsilon_1$.
  If instead you used the left-hand side $1 - F_n \leq D_n$ with a threshold $F_n \geq 1-\varepsilon_1$, you could **falsely accept** a far state. Example: take $\varepsilon_1 = 0.1$ and a state with $F_n = 0.90$. The right-hand FvG still allows $D_n$ to be as high as $\sqrt{1 - 0.9^2} \approx 0.436 > 0.1$, so the state could be far from the target yet would be accepted by this flawed rule.

- **Soundness of rejection (Far ⇒ Reject; again avoid false accepts).**
  Why do we use a "necessary" $D\!\to\!F$ direction? We want every far state to be rejected, i.e. no false accept. We start from "far ⇒ small fidelity", and again consider the **right-hand** FvG:
  $$
  D_n \geq \varepsilon_2 \implies F_n \leq \sqrt{1 - \varepsilon_2^2}.
  $$
  Together with $\sqrt{1 - 2\delta} \leq F_1$, this yields $\delta \geq \delta_{\text{far}} = \frac{1}{2}[1 - (1 - \varepsilon_2^2)^{1/n}]$. Any simpler rule like "reject if $F_n \leq \tau$" with $\tau < \sqrt{1 - \varepsilon_2^2}$ will **falsely accept** some far states. Example: $\varepsilon_2 = 0.8 \implies \sqrt{1 - \varepsilon_2^2} = 0.6$; a state with $F_n = 0.55$ has $D_n = \sqrt{1 - 0.55^2} \approx 0.835 > \varepsilon_2$ yet would be accepted by $\tau = 0.4$.

**What about completeness?** 
The proof for completeness (avoiding **false rejects** of close states) is not a deterministic guarantee, but a statistical one. It's the promise that if you are given a good state, your experiment will correctly identify it with very high confidence $1 - \alpha$. This guarantee comes from the power of the Chernoff-Hoeffding concentration bound, and we will see the full reasoning below.

> **Remark.** You might notice that this explicit discussion of sufficient and necessary conditions was not needed for the single-copy test. This is because the single-copy proof is more direct - in that case, the Asymptotic EPR Identity Bound ($\delta \geq \varepsilon^2/2$) provides a single, powerful, and symmetric link between the trace distance $\varepsilon$ and the error rate $\delta$, without needing to use fidelity as an intermediary, so it implicitly contains both the necessary and sufficient logic needed to construct the test. In contrast, the multi-copy proof uses the asymmetric Fuchs-van de Graaf inequalities, forcing us to explicitly analyse the logical direction for each guarantee.

Let's quickly verify that $F_n^2 \geq 1 - \varepsilon_1^2$ is a sufficient condition for $D_n \leq \varepsilon_1$ ($\mathbf{H_0}$):
$$
F_n^2 \geq 1 - \varepsilon_1^2 \quad\iff\quad 1 - F_n^2 \leq \varepsilon_1^2
$$
by rearranging. Substituting this into the upper bound of Fuchs–van de Graaf yields
$$
D_n ~\leq~ \sqrt{1 - F_n^2} ~\leq~ \sqrt{\varepsilon_1^2} ~=~ \varepsilon_1
$$
so indeed $[F_n^2 \geq 1 - \varepsilon_1^2] \implies [D_n \leq \varepsilon_1]$. Similarly we can verify that $F_n^2 \leq 1 - \varepsilon_2^2$ is a necessary condition for $D_n \geq \varepsilon_2$ ($\mathbf{H_1}$) by plugging $\mathbf{H_1}$ into the upper bound of Fuchs–van de Graaf:
$$
\varepsilon_2 \leq D_n \quad\implies\quad \varepsilon_2 ~\leq~ D_n ~\leq~ \sqrt{1 - F_n^2}.
$$
Rearranging
$$
\varepsilon_2 \leq \sqrt{1 - F_n^2} \quad\iff\quad F_n^2 \leq 1 - \varepsilon_2^2
$$
immediately shows that $[D_n \geq \varepsilon_2] \implies [F_n^2 \leq 1 - \varepsilon_2^2]$ as required.

#### Defining the error rate thresholds

The link between fidelity $F_1$ and true error rate $\delta$ from the single-copy asymptotic bound analysis is
$$
F_1 \geq \sqrt{1 - 2\delta} \quad\iff\quad \delta \geq \frac{1 - F_1^2}{2}.
$$
We will use this relation to define thresholds on $\delta$.

> **Convention.** For each basis, we relabel Bob's outcomes if needed so the mismatch rate is $\leq 1/2$ (i.e., replace $\delta_b$ by $\min \{\delta_b, 1 - \delta_b\}$). With this standard symmetrisation, the aggregated $\delta \in [0, 1/2]$ and the bound $F_1 \geq \sqrt{1-2\delta}$ is always meaningful.

Concretely, let
$$
f(\varepsilon) := \frac{1 - (1 - \varepsilon^2)^{1/n}}{2},
$$
and
$$
\qquad \delta_{\text{close}} := \frac{1 - (1 - \varepsilon_1^2)^{1/n}}{2} = f(\varepsilon_1),
\qquad \delta_{\text{far}} := \frac{1 - (1 - \varepsilon_2^2)^{1/n}}{2} = f(\varepsilon_2).
$$

These choices are justified as follows:

* (**Close**) If $\delta \leq \delta_{\text{close}}$, then $F_1 \geq \sqrt{1 - 2\delta} \geq \sqrt{1-2\delta_{\text{close}}}$, hence
$$
F_n \geq (1 - 2\delta_{\text{close}})^{n/2} = \sqrt{1 - \varepsilon_1^{2}},
$$
so from above $D_n \leq \varepsilon_1$.

* (**Far**) If $D_n \geq \varepsilon_2$, then $F_n \leq \sqrt{1 - \varepsilon_2^{2}}$, i.e. $F_1 \leq (1 - \varepsilon_2^{2})^{1/(2n)}$. Combining with $\sqrt{1 - 2\delta} \leq F_1$ forces
$$
1 - 2\delta \leq (1 - \varepsilon_2^{2})^{1/n} \quad\implies\quad \delta \geq \delta_{\text{far}}.
$$

#### Bounding the promise gap

The promise gap in $\delta$ is
$$
\Delta_{\delta} ~=~ \delta_{\text{far}} - \delta_{\text{close}} ~=~ f(\varepsilon_2) - f(\varepsilon_1).
$$
To get a lower bound on the promise gap, we first note that
$$
f(\varepsilon) = \frac{1 - (1 - \varepsilon^2)^{1/n}}{2}
$$
is continuous on $[0, 1]$ for any $n \geq 2$; we only consider $n \geq 2$ since $n$ is the number of EPR pairs and so $n = 1$ reduces to the single-copy test. Indeed, $f$ is built by composing several maps on $[0, 1]$:
- $\varepsilon \mapsto \varepsilon^2$ (continuous),
- $x \mapsto 1 - x$ (continuous),
- $y \mapsto y^{1/n}$ (continuous for $y \geq 0$).
Each of these components is continuous on the domain $[0, 1]$. Hence their composition, $f$, is also continuous on the closed interval $[0, 1]$.

By the fundamental theorem of calculus,
$$
\Delta_\delta
= f(\varepsilon_2)-f(\varepsilon_1)
= \int_{\varepsilon_1}^{\varepsilon_2} f'(\varepsilon)\,d\varepsilon.
$$
For $n\ge2$, differentiating $f(\varepsilon)$ gives
$$
f'(\varepsilon) = \frac{\varepsilon}{n}(1 - \varepsilon^2)^{\frac{1}{n} - 1}.
$$
Since $0 \leq \varepsilon < 1$ implies $1 - \varepsilon^2 \in (0, 1]$ and $\frac{1}{n} - 1 \leq 0$ as $n \geq 2$, we have
$$
(1 - \varepsilon^2)^{\frac{1}{n} - 1} \geq 1 \qquad\left[\,\forall \varepsilon \in [0, 1)\,\right].
$$
Multiplying through by $\varepsilon/n$ we get
$$
f'(\varepsilon) \geq \frac{\varepsilon}{n}.
$$
Therefore,
$$
\Delta_\delta = \int_{\varepsilon_1}^{\varepsilon_2} f'(\varepsilon)\,d\varepsilon
~\geq~ \int_{\varepsilon_1}^{\varepsilon_2}\frac{\varepsilon}{n}\,d\varepsilon
=\frac{\varepsilon_2^2 - \varepsilon_1^2}{2n}.
$$

Taking $\varepsilon_2\to 1^{-}$ (and using continuity of $f$) shows the same bound holds when $\varepsilon_2 = 1$. Hence, for all $0 \leq \varepsilon_1 < \varepsilon_2 \leq 1$,
$$
\Delta_\delta \geq \frac{\varepsilon_2^2 - \varepsilon_1^2}{2n}.
$$
> **Note.** At $\varepsilon=1$, the factor $(1 - \varepsilon^2)^{\frac{1}{n} - 1}$ diverges (for $n > 2$), which only strengthens $(1 - \varepsilon^2)^{\frac{1}{n} - 1} \geq 1$ and $f'(\varepsilon) \geq \varepsilon/n$. The integral is interpreted as a limit *from below* when the upper limit is $1$.

#### Decision rule and sample complexity

Define a margin 
$$
t := \frac{\Delta_{\delta}}{2} = \frac{\delta_{\text{far}} - \delta_{\text{close}}}{2}.
$$
Pick a single cutoff inside the gap (the midpoint):
$$
c := \frac{\delta_{\text{close}} + \delta_{\text{far}}}{2} = \frac{f(\varepsilon_1) + f(\varepsilon_2)}{2}.
$$
After running the protocol and computing the empirical mismatch rate $\hat\delta$ on the matching‑basis rounds $S$, we define the decision rule as
$$
\text{Decision} =
\begin{cases}
\text{“close”} & \text{if } \hat\delta \leq c,\\
\text{“far”}   & \text{if } \hat\delta > c.
\end{cases}
$$
On matching‑basis rounds, the indicators $\{ Y_i \}_{i \in S}$ are i.i.d. Bernoulli random variables with mean $\delta$. Chernoff–Hoeffding gives, for any $t > 0$,
$$
\Pr\!\left[|\hat\delta - \delta| \geq t\right] \leq 2e^{-2|S|t^2}.
$$
- **Completeness** ($\delta \leq \delta_{\text{close}}$):
  If the *good* event $|\hat\delta - \delta| < t$ holds, then
  $\hat\delta \leq \delta_{\text{close}} + t = c \Rightarrow$ accept.

- **Soundness** ($\delta \geq \delta_{\text{far}}$):
  If $|\hat\delta-\delta| < t$, then
  $\hat\delta > \delta_{\text{far}} - t = c \Rightarrow$ reject.

Therefore, each error (completeness or soundness) occurs only if $|\hat\delta-\delta|\geq t$ (the bad event). To make this probability $\leq \alpha$, it suffices that
$$
2e^{-2|S|t^2} \leq \alpha
\quad\iff\quad
|S| \geq \frac{2}{\Delta_\delta^{2}}\,\ln\!\frac{2}{\alpha} \qquad (t = \Delta_\delta/2).
$$
The bound on $\Delta_\delta$ from the integral earlier states that
$$
\Delta_\delta \geq \frac{\varepsilon_2^2 - \varepsilon_1^2}{2n}.
$$
From this, we can derive that
$$
\begin{aligned}
\Delta_\delta ~\geq~ \frac{\varepsilon_2^2 - \varepsilon_1^2}{2n} &{\quad\iff\quad} \Delta_\delta^2 ~\geq~ \left(\frac{\varepsilon_2^2 - \varepsilon_1^2}{2n}\right)^2
\\[10pt]&{\quad\iff\quad} \Delta_\delta^2 ~\geq~ \frac{\left(\varepsilon_2^2 - \varepsilon_1^2\right)^2}{4n^2}
\\[10pt]&{\quad\iff\quad} \frac{1}{\Delta_\delta^2} ~\leq~ \frac{4n^2}{\left(\varepsilon_2^2 - \varepsilon_1^2\right)^2}
\\[15pt]&{\quad\iff\quad} \frac{2}{\Delta_\delta^2} \ln \frac{2}{\alpha} ~\leq~ \frac{8n^2}{\left( \varepsilon_2^2 - \varepsilon_1^2 \right)^2} \ln \frac{2}{\alpha} \quad[\,=: L\,].
\end{aligned}
$$
Since $\Delta_\delta \geq (\varepsilon_2^2 - \varepsilon_1^2)/(2n)$ and $\frac{2}{\Delta_\delta^2}\,\ln\!\frac{2}{\alpha}$ is strictly decreasing in $\Delta_\delta$, the true requirement is always at most $L$. Therefore, choosing $|S| \geq L$ guarantees the condition is satisfied for all admissible $\Delta_\delta$:
$$
|S| \geq \underbrace{\frac{8\,n^2}{\left( \varepsilon_2^2 - \varepsilon_1^2 \right)^2}\,\ln\!\frac{2}{\alpha}}_{\text{Our choice (worst-case }L\text{)}}
\quad\geq\quad
\underbrace{\frac{2}{\Delta_\delta^{2}}\,\ln\!\frac{2}{\alpha}}_{\text{What we actually need}}.
$$
In other words, a sufficient condition for $|S|$ is:
$$
|S| ~\geq~ \frac{8\,n^2}{\left( \varepsilon_2^2 - \varepsilon_1^2 \right)^2}\,\ln\!\frac{2}{\alpha}.
$$
As before, only about half of the $N$ rounds are matching-basis. Taking $N = 4|S|$ (by the same argument from the single-copy case),
$$
N ~\geq~ \frac{32\,n^2}{\left( \varepsilon_2^2 - \varepsilon_1^2 \right)^2}\,\ln\!\frac{2}{\alpha} \qquad\left[= O\left(n^2\left(\varepsilon_2^2 - \varepsilon_1^2\right)^{-2}\right)\right].
$$

So it turns out that extending the test from a single copy to $n$ i.i.d. copies is **not** free: the price is a quadratic blow-up in sample complexity, which is intuitive and expected when you consider the difference in the guarantees. Certifying that the *entire collection* of $n$ states is globally $\varepsilon$-close is a much stricter requirement than certifying a single state. This is because a tiny imperfection in each copy, when compounded over the tensor product of all $n$ states, can result in a large global deviation. To compensate for this, the required fidelity of each copy must be much higher. This in turn forces the promise gap $\Delta_\delta$ for the true error rate $\delta$ to become approximately $n$ times narrower, squeezing the thresholds for "close" and "far" states into a much smaller window near zero.

The reason for this is that our promise is about the **global state** of all $n$ copies. For the global state to be nearly perfect (i.e., have a high global fidelity $F_n = F_1^n$), the fidelity of each **single copy** ($F_1$) must be extremely close to $1$. Since the true error rate $\delta$ is a direct measure of the imperfection in a single copy, this extremely high fidelity requirement forces $\delta$ to be (comparatively) much smaller than it would be in the single-copy test. As a result, this effectively "squeezes" the entire range of relevant error rates into a tiny window near zero, which makes the absolute gap between our $\delta_{\text{close}}$ and $\delta_{\text{far}}$ thresholds narrower.

A core principle of statistics is that the uncertainty of an estimated average is proportional to the inverse square root of the number of samples (in our case, this is $1 / \sqrt{|S|}$). To reliably measure a promise gap that is $n$ times smaller, our estimate for $\Delta_\delta$ must be $n$ times more precise. Achieving this $n$-fold increase in precision requires an $n^2$-fold increase in the number of samples, which leads directly to the $O(n^2)$ scaling in complexity we're seeing. Putting everything together succinctly:

> **Theorem (Finite-sample tolerant EPR identity test, i.i.d. product version).**
> 
> Let $n \geq 2$ be the number of i.i.d. copies of $\rho_{AB}$ held by Alice and Bob. For brevity, write
> $$
\rho = \rho_{AB},\qquad \Phi=\ket{\mathrm{EPR}}\bra{\mathrm{EPR}}_{AB}.
$$
> Fix global trace-distance tolerances $0 \leq \varepsilon_1 < \varepsilon_2 \leq 1$ and confidence $1 - \alpha$. Define
> $$
\begin{aligned}
&f(\varepsilon) = \frac{1}{2}\!\left[1 - (1 - \varepsilon^2)^{1/n}\right]&,&
&\delta_{\text{close}} = f(\varepsilon_1),
\\[10pt]&\delta_{\text{far}} = f(\varepsilon_2)&,&
\qquad &c = \frac{\delta_{\text{close}} + \delta_{\text{far}}}{2}.
\end{aligned}
$$
> Run the matching-outcomes protocol for
> $$
N ~\geq~ \frac{32\,n^2}{\left( \varepsilon_2^2 - \varepsilon_1^2 \right)^2}\,\ln\!\frac{2}{\alpha}
\qquad\left[= O\left(n^2\left(\varepsilon_2^2 - \varepsilon_1^2\right)^{-2}\right)\right]
$$
> rounds, and accept *if and only if* the observed error $\hat{\delta} \leq c$. Then:
> - If $D(\rho^{\otimes n},\Phi^{\otimes n}) \leq \varepsilon_1$, the test accepts with probability $\geq 1 - \alpha$.
> - If $D(\rho^{\otimes n},\Phi^{\otimes n}) \geq \varepsilon_2$, the test rejects with probability $\geq 1 - \alpha$.
> - If $\varepsilon_1 < D(\rho^{\otimes n},\Phi^{\otimes n}) < \varepsilon_2$, no guarantee is provided; the test may accept or reject.

That completes the "easy" i.i.d. case. Next, we'll remove the identical-copy assumption.

---

## Medium case (independent, non-identical copies)
`copy from obsidian`
`todo: maybe now we can use the same sufficiency/necessity argument and we can finish off the closeness part of the medium case`