+++
date = '2025-08-08T17:42:31+01:00'
draft = false
title = 'Classical tolerant identity test for multiple EPR states'
ShowToc = true
TocOpen = true
+++

## Change in notation
With the [tolerant identity test](../epr-tolerant-identity-testing) for a single state $\rho_{AB}$ complete, we now turn to the problem of certifying multiple ($n$) EPR pairs at once. For brevity we write $\Phi = \ket{\text{EPR}}\bra{\text{EPR}}_{AB}$ throughout. The problem statement is as follows:

> **Problem.**
>
> Given two trace distance tolerances $0 \leq \varepsilon_1 < \varepsilon_2 \leq 1$, a failure probability $\alpha \in (0, 1)$, and $N$ i.i.d. copies of an unknown $2n$-qubit global state $\varrho$ on $A^n B^n$ i.e. the source produces $\varrho^{\otimes N}$, how large must $N$ at least be so that, using only local $Z$/$X$ measurements and classical postprocessing, we can decide with at least confidence $1 - \alpha$ whether
> $$
D\!\left[\,\varrho~,~ \Phi^{\otimes n}\,\right]
$$
> is small ($\leq \varepsilon_1$) or large ($\geq \varepsilon_2$)?

> **Definition (block).**
> A *block* is one i.i.d. copy of the $2n$-qubit global state $\varrho$, where we label the qubits as $(A_j, B_j)_{j=1}^n$ for convenience. We refer to each pair $(A_j, B_j)$ as a *coordinate* for convenience.

Before analysing the multi-pair scenario, let's revisit the single-pair case first. It helps to reframe one round of the single-pair matching-outcomes protocol as a callable oracle $\mathbb{O}$ that consumes a fresh pair of $\rho_{AB}$ and outputs a classical bit when the bases match.

Suppose Alice and Bob share $N$ i.i.d. copies of an unknown pair $\rho_{AB}$. We package one measurement round into a callable **oracle** $\mathbb{O}(\rho_{AB})$ and then do simple classical post-processing. Combining $N$ oracle calls and doing the simple classical post-processing is equivalent to the $N$-round protocol!

### Single-pair oracle $\mathbb{O}(\rho_{AB})$

**Input:** one fresh pair of the bipartite state $\rho_{AB}$.

**Procedure:**
1. Pick two independent basis bits $\theta \in \{ 0, 1 \}$ and $\tilde{\theta} \in \{ 0, 1 \}$ uniformly at random. Here $\theta = 0$ means "standard basis ($Z$)" and $\theta = 1$ means "Hadamard basis ($X$)".
2. Measure the $A$ subsystem of $\rho_{AB}$ in basis $\theta$ to obtain $x \in \{0, 1\}$ and the $B$ subsystem in basis $\tilde{\theta}$ to obtain $\tilde{x} \in \{0, 1\}$. 
3. If $\theta = \tilde{\theta}$ (matching bases), set $M = 1$ and $Y = \mathbf{1}[x \neq \tilde x] \in \{0, 1\}$; otherwise $\theta \neq \tilde{\theta}$ (mismatched bases), set $M = 0$ and $Y = \bot$.

**Output:** a pair $(M, Y)$ with $M \in \{0, 1\}$ and $Y \in \{\bot, 0, 1\}$.

The oracle hides the two-party details: one call consumes one fresh pair $\rho_{AB}$. When it emits a bit (i.e. $Y \neq \bot$), that bit is a Bernoulli trial with mean $\delta$, which is the *true* matching-basis mismatch probability:
$$
\mathbb{E}[\,Y \mid M = 1\,] = \delta \in[0, \tfrac{1}{2}] \quad\text{(after the standard relabelling per basis)}.
$$

(We relabel Bob's outcomes per basis so each per-basis mismatch rate is $\leq 1/2$; see the convention below.)

This oracle $\mathbb{O}$ encapsulates the entire procedure of basis selection, local measurement, and comparison for a single coordinate $(A_j, B_j)$ of a block. A block has $n$ coordinates, we call $\mathbb{O}$ once per coordinate so $n$ times in total (either sequentially or in parallel). We then keep only the calls where the bases matched and do simple classical post-processing (count mismatches). Over $N$ blocks, this amounts to $n \cdot N$ oracle calls in total.

> **Remark.** "Sequential" vs "parallel" only affects implementation. Equivalently one can run many calls (measure many coordinates) in parallel and reveal bases afterwards over a classical channel; the distribution of $(M, Y)$ is identical.

### Single-pair protocol (post-processing over $N$ oracle calls)

In our single-pair case, the number of coordinates $n = 1$, so trivially we would call the oracle $N$ times as we're given $N$ blocks.

1. Make $N$ independent calls to $\mathbb{O}(\rho_{AB})$. From those $N$ calls we obtain $(M_1, Y_1), \ldots, (M_N, Y_N)$.
2. Define the set of matching-basis rounds
$$
S = \bigl\{i \in \{1, \dots, N\} : M_i = 1 \bigr\} \subseteq \bigl\{ 1, \dots, N \bigr\}.
$$
If by rare chance $S = \varnothing$ (no matching bases at all), simply rerun the whole protocol as the probability of $S = \varnothing$ is $2^{-N}$, which is negligible for modest $N$.
3. Compute the **observed error rate**
$$
\hat{\delta} = \frac{1}{|S|}\sum_{i\in S} Y_i.
$$
which represents the mismatch fraction conditioned on matching-basis rounds.

> **Note.** This is exactly equivalent to the usual BB84-style "announce bases and outcomes over a classical authenticated channel (CAC) and keep only the matching bases" description; we've just folded that bookkeeping into $(M_i, Y_i)$.

With this, we can provide an alternative but mathematically equivalent tolerant identity test for one EPR state ($n = 1$).

> **Theorem (Finite-sample classical tolerant identity test for the EPR state).**
>
> Given $N$ (i.i.d.) blocks of $\varrho = \rho_{AB}$, fix two trace-distance tolerances
> $$
0 \leq \varepsilon_1 < \varepsilon_2 \leq 1,
$$
> and the desired maximum failure probability $\alpha \in (0, 1)$. Set the cutoff
> $$
c = \frac{\varepsilon_1^2 + \varepsilon_2^2}{4}.
$$
> Consider the reformulated matching protocol above where we make $N$ independent calls to $\mathbb{O}(\varrho)$ (one per block), and compute the observed error rate $\hat{\delta}$. For the test, let the decision rule be to accept ***iff*** $\hat{\delta} \leq c$:
> $$
\text{Decision} =
\begin{cases}
\text{“close”}, & \hat{\delta} \leq c,\\
\text{“far”},   & \hat{\delta} > c.
\end{cases}
$$
> Then if
> $$
N \geq \frac{32\,\ln(2/\alpha)}{(\varepsilon_2^2 - \varepsilon_1^2)^2} \qquad\left( = O\Bigl((\varepsilon_2^2 - \varepsilon_1^2)^{-2}\Bigr) \right),
$$
after running the test, the following holds:
> - **Completeness.** If $D(\varrho, \Phi) \leq \varepsilon_1$, then the test **accepts** (outputs "close") with confidence at least $1 - \alpha$.
> - **Soundness** If $D(\varrho, \Phi) \geq \varepsilon_2$, then the test **rejects** (outputs "far") with confidence at least $1 - \alpha$.
> - **Promise gap.** If $\varepsilon_1 < D(\varrho, \Phi) < \varepsilon_2$, no guarantee is made on the outcome; the test may go either way (accept or reject).

Note that we call the oracle $N$ times in this case only because $n = 1$. In general $n \geq 2$ so this is not true; the number of oracle calls is $n \cdot N$.

With the notations established and the single-pair scenario ($n = 1$) as a reference, we now turn to analysing the number of blocks needed to certify multiple EPR pairs for $n \geq 2$ as per the problem statement.

---

## do-rE-MI ♫

For brevity we write $\rho = \rho_{AB}$ throughout. In particular, we will show how the same matching-outcomes protocol extends in three settings of increasing generality and difficulty:

1. **Easy (i.i.d. pairs).**

   All $n$ pairs are identical:
   $$
     \varrho = \rho^{\otimes n}\quad\text{vs.}\quad\Phi^{\otimes n}.
   $$

2. **Medium (independent, non-identical pairs).**

   Each pair may differ but remains uncorrelated:
   $$
     \varrho = \rho_1\otimes\rho_2\otimes\dots\otimes\rho_n
     \quad\text{vs.}\quad
     \Phi^{\otimes n}.
   $$

3. **Hard (arbitrary adversary).**

   The most general case allows an arbitrary $2n$-qubit state $\varrho$, possibly entangled across pairs, against which we still wish to test closeness to $\Phi^{\otimes n}$.

We will analyse $N$, the number of blocks (i.i.d. copies) of the $2n$-qubit state $\varrho$ required to decide closeness to $\Phi^{\otimes n}$. As we've seen, each block contains $n$ pairs and therefore induces $n$ calls to the single-pair oracle $\mathbb{O}$ (once per coordinate), so the total number of oracle calls is $n \cdot N$. We state all bounds in terms of the number blocks needed, $N$, as the primary resource, and convert to total oracle calls by multiplying by $n$ when helpful. (The measurement bases match with probability $1/2$ independently per coordinate.)

Why do we count blocks? This is because the physical source hands us i.i.d. *blocks* - full $2n$-qubit copies of $\varrho$. Block complexity answers the operational question "how many copies of $\varrho$ must we request to decide 'close' vs 'far'?". Inside each block we make $n$ single‑pair measurements (one per coordinate), i.e. $n$ *oracle calls*, so the total number of calls is $T = n \cdot N$. While oracle‑call counts are useful for estimating raw measurement time or hardware throughput, **the fundamental resource is the number of i.i.d. copies of $\varrho$**, i.e. the number of blocks $N$.

> **Note.** In the context of BB84, these three scenarios correspond directly to the class of attacks that an eavesdropper (Eve) might do:
>
> - **Easy (i.i.d. pairs)**:
>   Eve applies the same attack channel to each transmitted qubit independently, with no memory from one round to the next. Every round she starts from scratch, so her joint state is $\varrho = \rho^{\otimes n}$.
>
> - **Medium (independent, non-identical pairs)**:
>   Eve still treats each qubit independently and measures immediately, but she may choose a different attack in each round. Her overall state is the product $\varrho = \rho_{1}\otimes\rho_{2}\otimes\dots\otimes\rho_{n}$.
>
> - **Hard (arbitrary adversary)**:
>   Eve may entangle her systems across rounds and defer all measurements until the end. There is no tensor-product structure, so her state is an arbitrary $2n$-qubit $\varrho$.
>
> By proving security in each model, starting with the easiest and working up to the fully coherent setting, we obtain a hierarchy of BB84 security guarantees that mirror the increasing power of potential attack by Eve.

We begin with the i.i.d. case as it's both the simplest to analyse and a useful building block for the more challenging scenarios.

---

## Easy case (i.i.d. pairs)

### A naïve per-pair approach using trace distance

A first idea is to ignore the joint state and run the **single-pair** tolerant test on each of the $n$ coordinates **separately**, then accept only if every coordinate passes. Equivalently, one could tally the per-pair/per-coordinate (which is the same under the independent assumption of i.i.d.) mismatch indicators into a total error count and compare that sum against a scaled threshold, thanks to the i.i.d. assumption.

Let $D_1 = D(\rho, \Phi)$ and $D_n = D(\rho^{\otimes n}, \Phi^{\otimes n})$. By subadditivity,
$$
D_n \leq n\,D_1.
$$

To guarantee $D_n \leq \varepsilon_1$, it suffices to enforce the **per-pair** condition $D_1 \leq \varepsilon_1/n$. Thus at the per-pair level the tolerances become $\varepsilon_1/n$ vs. $\varepsilon_2/n$. Since the single-pair sample complexity scales like $(\varepsilon_2^2 - \varepsilon_1^2)^{-2}$, replacing $\varepsilon_j \mapsto \varepsilon_j/n$ shrinks the squared gap by $n^2$, and the **per-coordinate** number of **blocks** needed inflates by $n^4$:

$$
N_{\text{per-coord}}
~\gtrsim~
\frac{32\,n^4}{(\varepsilon_2^2 - \varepsilon_1^2)^2}\,\ln\!\frac{2}{\alpha}.
$$

We need **all $n$ coordinates** to pass simultaneously with total failure probability $\alpha$. A union bound replaces $\alpha$ by $\alpha/n$, contributing an extra $\log n$ factor:

$$
N_{\text{naïve (blocks)}}
~\gtrsim~
\frac{32\,n^4}{(\varepsilon_2^2 - \varepsilon_1^2)^2}\,\ln\!\frac{2n}{\alpha}.
$$

**Takeaway.** The naïve per-pair route costs $O(n^4\log n)$ blocks, whereas the collective (fidelity-based) test from the next section needs only $O(n)$ blocks (up to the same $(\varepsilon_2^2 - \varepsilon_1^2)^{-2}$ and $\log(1/\alpha)$ factors). The huge gap in our naïve method comes from shrinking tolerances by $1/n$ at the per-pair level (which explodes sample size by $n^4$); the union bound adds only the mild $\log n$. At first glance the naïve method seems reasonably efficient, but a closer look shows it is actually markedly worse than the collective strategy developed below.

**Remark.** In the easy and medium cases, "per-coordinate" and "per-pair" are interchangeable because **within each block** the state *factorises across coordinates*: easy: $\varrho = \rho^{\otimes n}$; medium: $\varrho = \bigotimes_{i=1}^n \rho_i$. In particular, there is no cross-coordinate entanglement inside a block (pairs may be identical in the easy case and merely different in the medium case). In the hard case, $\varrho$ may be arbitrarily entangled across coordinates, so we use **per-coordinate** language exclusively there to be precise.

---

### Global block test using fidelity

Given a global state $\varrho = \rho^{\otimes n}$, for a single pair $\rho$:
$$
F_1 ~=~ F(\rho,\Phi),
\quad
D_1 ~=~ D(\rho,\Phi),
$$
and in the $n$-pair i.i.d. case we have the rules
$$
F_n ~:=~ F\bigl(\rho^{\otimes n},\,\Phi^{\otimes n}\bigr) ~=~ F_1^{n},
\qquad
D_n ~:=~ D\bigl(\rho^{\otimes n},\,\Phi^{\otimes n}\bigr) ~\leq~ n\,D_1.
$$
This means we can express the $n$-pair (block) closeness conditions entirely in terms of the single-pair fidelity $F_1$, thanks to the exact tensor-product multiplicativity rule $F(\rho^{\otimes n},\Phi^{\otimes n}) = F(\rho,\Phi)^n$ (or equivalently $F_n = F_1^n$). Working directly with fidelity avoids the looser trace-distance bound $D(\rho^{\otimes n},\Phi^{\otimes n}) \leq n\,D(\rho,\Phi)$, which would give a much weaker bound than the tight scaling we get from fidelity.

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
so controlling $F_n$ tightly leads to a corresponding control on $D_n$. Since $F_n = F_1^{n}$, we can use this and the upper bound of Fuchs–van de Graaf to rewrite the hypotheses as fidelity conditions per-pair:
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

You might be wondering why we need a <u>sufficient</u> condition for $\mathbf{H_0}$ and a <u>necessary</u> condition for $\mathbf{H_1}$. This is because we need to guarantee that accepted states are truly close (requiring a sufficient condition) and that far states are rejected (requiring a necessary condition) to prevent **false accepts**.

- **Soundness of acceptance (Accept $\Rightarrow$ Close; avoid false accepts).**
  Why do we use a "sufficient" $F\!\to\!D$ direction? We want "if the test accepts, the global state is close", i.e. no false accept. That needs an *upper* bound on distance from fidelity, which comes from the *right-hand* FvG:
  $$
  D_n \leq \sqrt{1 - F_n^2}.
  $$
  So we enforce $F_n \geq \sqrt{1 - \varepsilon_1^2}$ (equivalently $F_1 \geq (1 - \varepsilon_1^2)^{1/(2n)}$), which *forces* $D_n \leq \varepsilon_1$.
  If instead you used the left-hand side $1 - F_n \leq D_n$ with a threshold $F_n \geq 1-\varepsilon_1$, you could falsely accept a far state. Example: take $\varepsilon_1 = 0.1$ and a state with $F_n = 0.90$. The right-hand FvG still allows $D_n$ to be as high as $\sqrt{1 - 0.9^2} \approx 0.436 > 0.1$, so the state could be far from the target yet would be accepted by this flawed rule.

- **Soundness of rejection (Far $\Rightarrow$ Reject; again avoid false accepts).**
  Why do we use a "necessary" $D\!\to\!F$ direction? We want every far state to be rejected, i.e. no false accept. We start from "far $\Rightarrow$ small fidelity", and again consider the *right-hand* FvG:
  $$
  D_n \geq \varepsilon_2 \implies F_n \leq \sqrt{1 - \varepsilon_2^2}.
  $$
  Together with $\sqrt{1 - 2\delta} \leq F_1$, this yields $\delta \geq \delta_{\text{far}} = \frac{1}{2}[1 - (1 - \varepsilon_2^2)^{1/n}]$. Any simpler rule like "reject if $F_n \leq \tau$" with $\tau < \sqrt{1 - \varepsilon_2^2}$ will falsely accept some far states. Example: $\varepsilon_2 = 0.8 \implies \sqrt{1 - \varepsilon_2^2} = 0.6$; a state with $F_n = 0.55$ has $D_n = \sqrt{1 - 0.55^2} \approx 0.835 > \varepsilon_2$ yet would be accepted by $\tau = 0.4$.

**What about completeness?** We will soon see that the proof for completeness (avoiding **false rejects** of close states) is not a *deterministic* guarantee, but a *statistical* one. It's the promise that if you are given a good state, your experiment will correctly identify it with very high confidence $1 - \alpha$. This guarantee comes from the power of the Chernoff-Hoeffding concentration bound, and we will see the full reasoning below.

> **Remark.** You might notice that this explicit discussion of sufficient and necessary conditions was not needed for the single-pair test. This is because the single-pair proof is more direct - in that case, the Asymptotic EPR Identity Bound ($\delta \geq \varepsilon^2/2$) provides a single powerful link between the trace distance $\varepsilon$ and the error rate $\delta$, without needing to use fidelity as an intermediary, so it implicitly contains both the necessary and sufficient logic needed to construct the test. In contrast, the multi-pair proof uses the asymmetric Fuchs-van de Graaf inequalities, forcing us to explicitly analyse the logical direction for each guarantee.

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

**Lemma (single-pair oracle asymptotic link).** For one call to $\mathbb{O}(\rho_{AB})$, with $\delta = \Pr[Y = 1 \mid M = 1]$, we have $F(\rho_{AB}, \Phi) \geq \sqrt{1 - 2\delta}$.

**Proof sketch.** This lemma is a direct consequence of the Asymptotic EPR Identity Bound established in the single-pair analysis. Since the oracle $\mathbb{O}(\rho_{AB})$ is simply a procedural reframing of a single round of that protocol, the fundamental relationship between the true error rate $\delta$ and the fidelity $F$ remains unchanged. $\quad\square$

Using this lemma directly, the link between fidelity $F_1$ and true error rate $\delta$ is
$$
F_1 \geq \sqrt{1 - 2\delta} \quad\iff\quad \delta \geq \frac{1 - F_1^2}{2}.
$$
We will use this relation to define thresholds on $\delta$.

> **Convention.** For each basis, we relabel Bob's outcomes if needed so the mismatch rate is $\leq 1/2$ (i.e. replace $\delta_b$ by $\min \{\delta_b, 1 - \delta_b\}$). With this standard symmetrisation, the aggregated $\delta \in [0, 1/2]$ and the bound $F_1 \geq \sqrt{1 - 2\delta}$ is always meaningful.

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

- (**Close**) If $\delta \leq \delta_{\text{close}}$, then $F_1 \geq \sqrt{1 - 2\delta} \geq \sqrt{1-2\delta_{\text{close}}}$, hence
$$
F_n \geq (1 - 2\delta_{\text{close}})^{n/2} = \sqrt{1 - \varepsilon_1^{2}},
$$
so from above $D_n \leq \varepsilon_1$.

- (**Far**) If $D_n \geq \varepsilon_2$, then $F_n \leq \sqrt{1 - \varepsilon_2^{2}}$, i.e. $F_1 \leq (1 - \varepsilon_2^{2})^{1/(2n)}$. Combining with $\sqrt{1 - 2\delta} \leq F_1$ forces
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
is continuous on $[0, 1]$ for any $n \geq 2$; we only consider $n \geq 2$ since $n$ is the number of EPR pairs and so $n = 1$ reduces to the single-pair test. Indeed, $f$ is built by composing several maps on $[0, 1]$:

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
\kappa := \frac{\delta_{\text{close}} + \delta_{\text{far}}}{2} = \frac{f(\varepsilon_1) + f(\varepsilon_2)}{2}.
$$

In the easy (i.i.d.) case the true mismatch rate is identical across coordinates, so we **pool** all matching‑basis trials across all coordinates and blocks; let $S$ denote the set of all matching‑basis indices among the total $T = n \cdot N$ calls.

After running the protocol and computing the empirical mismatch rate $\hat\delta$ on the matching-basis rounds $S$, we define the decision rule as
> $$
\textbf{Decision rule (easy case)} =
\begin{cases}
\text{“close”} & \text{if } \hat\delta \leq \kappa,\\
\text{“far”}   & \text{if } \hat\delta > \kappa.
\end{cases}
$$

On matching-basis rounds, the indicators $\{ Y_i \}_{i \in S}$ are i.i.d. Bernoulli random variables with mean $\delta$. Chernoff–Hoeffding gives, for any $t > 0$,
$$
\Pr\!\left[|\hat\delta - \delta| \geq t\right] \leq 2e^{-2|S|t^2}.
$$
- **Completeness** ($\delta \leq \delta_{\text{close}}$):
  If the *good* event $|\hat\delta - \delta| < t$ holds, then
  $\hat\delta \leq \delta_{\text{close}} + t = \kappa \Rightarrow$ accept.

- **Soundness** ($\delta \geq \delta_{\text{far}}$):
  If $|\hat\delta-\delta| < t$, then
  $\hat\delta > \delta_{\text{far}} - t = \kappa \Rightarrow$ reject.

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
\Delta_\delta ~~\geq~~ \frac{\varepsilon_2^2 - \varepsilon_1^2}{2n} &{\quad\iff\quad} \Delta_\delta^2 ~~\geq~~ \left(\frac{\varepsilon_2^2 - \varepsilon_1^2}{2n}\right)^2
\\[10pt]&{\quad\iff\quad} \Delta_\delta^2 ~~\geq~~ \frac{\left(\varepsilon_2^2 - \varepsilon_1^2\right)^2}{4n^2}
\\[10pt]&{\quad\iff\quad} \frac{1}{\Delta_\delta^2} ~\leq~~ \frac{4n^2}{\left(\varepsilon_2^2 - \varepsilon_1^2\right)^2}
\\[15pt]&{\quad\iff\quad} \frac{2}{\Delta_\delta^2} \,\ln\! \frac{2}{\alpha} ~~\leq~~ \frac{8n^2}{\left( \varepsilon_2^2 - \varepsilon_1^2 \right)^2} \,\ln\! \frac{2}{\alpha} \quad[\,=: L\,].
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
|S| ~~\geq~~ \frac{8\,n^2}{\left( \varepsilon_2^2 - \varepsilon_1^2 \right)^2}\,\ln\!\frac{2}{\alpha}.
$$

Let $T := n \cdot N$ be the total number of single‑pair measurements (oracle calls). Since a call has matching bases with probability $1/2$, a Chernoff bound shows that choosing $T = 4|S|$ (equivalently, $N = 4|S|/n$ blocks) makes the event of getting fewer than $|S|$ matches have probability at most $e^{-|S|/4}$, which is negligibly small for moderate $|S|$. Therefore,
$$
N ~=~ \frac{4|S|}{n} ~~\geq~~ \frac{32\,n}{\left( \varepsilon_2^2 - \varepsilon_1^2 \right)^2}\,\ln\!\frac{2}{\alpha}
\qquad\left[= O\!\left(n\,(\varepsilon_2^2 - \varepsilon_1^2)^{-2}\right)\right],
$$
and equivalently (in terms of total oracle calls)
$$
T = n \cdot N \geq \frac{32\,n^2}{(\varepsilon_2^2 - \varepsilon_1^2)^2}\,\ln\!\frac{2}{\alpha}.
$$

So it turns out that extending the test from a single pair to $n$ i.i.d. pairs is **not** free: the sample cost grows linearly in the number of blocks (equivalently, quadratically in the total number of oracle calls). This is because certifying that the entire collection of $n$ states is globally $\varepsilon$-close is much stricter than certifying a single state. A small imperfection in each pair, when compounded over the tensor product, can cause a large global deviation.

To keep the global fidelity $F_n = F_1^n$ high, each single-pair fidelity $F_1$ must be extremely close to $1$. Since the true error rate $\delta$ measures per-pair imperfection, this requirement forces $\delta$ to be much smaller than in the single-pair case. Consequently, the promise gap $\Delta_\delta$ (the separation between the "close" and "far" thresholds) shrinks by about a factor of $n$, compressing the relevant error-rate range into a tiny window near zero.

A core principle of statistics is that the uncertainty of an estimated average is proportional to the inverse square root of the number of samples (in our case, this is $1 / \sqrt{|S|}$). To reliably measure a promise gap that is $n$ times smaller, our estimate for $\Delta_\delta$ must be $n$ times more precise. Achieving this $n$-fold increase in precision requires an $n^2$-fold increase in the **number of pooled calls** (hence $O(n^2)$ total single‑pair measurements) which, when grouped as blocks of size $n$, translates to an $O(n)$ growth in the **number of blocks** $N$.

> **Theorem (Finite-sample tolerant EPR identity test, i.i.d. product version).**
>
> Let $n \geq 2$ and suppose the global state $\rho^{\otimes n}$ for some bipartite state $\rho$.
> Fix global trace-distance tolerances $0 \leq \varepsilon_1 < \varepsilon_2 \leq 1$ and failure probability $\alpha \in (0,1)$.
> Define
> $$
\begin{aligned}
&f(\varepsilon) = \frac{1}{2}\!\left[1 - (1 - \varepsilon^2)^{1/n}\right]&,&
&\delta_{\text{close}} = f(\varepsilon_1),
\\[10pt]&\delta_{\text{far}} = f(\varepsilon_2)&,&
\qquad &\kappa = \frac{\delta_{\text{close}} + \delta_{\text{far}}}{2}.
\end{aligned}
$$
>
> **Protocol.** Prepare $N$ (i.i.d.) blocks of $\rho^{\otimes n}$.
> For each block $j \in [N]$ and coordinate $i \in [n]$, make one call to $\mathbb{O}(\rho)$, obtaining $(M_{(j,i)}, Y_{(j,i)})$.
> Let
> $$
S := \{\, (j,i) \in [N] \times [n] ~:~ M_{(j,i)} = 1 \,\}
$$
> be the set of calls with matching bases. Define the *pooled* empirical mismatch rate as
> $$
\hat{\delta} := \frac{1}{|S|} \sum_{(j,i) \in S} Y_{(j,i)},
$$
> where $Y_{(j,i)} \in \{0,1\}$ for all $(j,i) \in S$.
> 
> **Decision rule.** Accept ***iff*** $\hat{\delta} \leq \kappa$.
>
> If
> $$
N ~~\geq~~ \frac{32\,n}{(\varepsilon_2^2 - \varepsilon_1^2)^2} \,\ln\!\frac{2}{\alpha}, \qquad\left[= O\!\left(n\left(\varepsilon_2^2 - \varepsilon_1^2\right)^{-2}\right)\right]
$$
> equivalently, the number of oracle calls, 
> $$
T = n \cdot N ~~\geq~~ \frac{32\,n^2}{(\varepsilon_2^2 - \varepsilon_1^2)^2}\,\ln\!\frac{2}{\alpha}, \qquad\left[= O\!\left(n^2\left(\varepsilon_2^2 - \varepsilon_1^2\right)^{-2}\right)\right]
$$
> then the following statements are true:
> 
> - **Completeness.** If $D(\rho^{\otimes n}, \Phi^{\otimes n}) \leq \varepsilon_1$, the test accepts with probability at least $1 - \alpha$.
> - **Soundness.** If $D(\rho^{\otimes n}, \Phi^{\otimes n}) \geq \varepsilon_2$, the test rejects with probability at least $1 - \alpha$.
> - **Promise gap.** If $\varepsilon_1 < D(\rho^{\otimes n},\Phi^{\otimes n}) < \varepsilon_2$, no guarantee is made; the test may accept or reject.
> 
> *Note.* In the i.i.d. case, all coordinates $i \in [n]$ have the same true mismatch rate, so pooling over $S$ is valid. Matching bases occur with probability $1/2$ independently per coordinate; the constants above already account (via Chernoff-Hoeffding bounds) for obtaining enough matches with high probability.

That completes the "easy" i.i.d. case. Next, we'll remove the identical-pair assumption.

---

## Medium case (independent, non-identical pairs)

Here the joint state is a product of possibly different single-pair states
$$
\varrho = \rho_{1}\otimes\rho_{2}\otimes\dots\otimes\rho_{n},
\quad
\text{vs. } ~
\Phi^{\otimes n}.
$$
with no entanglement across copies but with potentially different single-pair states $\rho_i$. In the context of BB84, each copy is attacked "from scratch" (no cross-round entanglement) but Eve may prepare a different state in every round.

Exactly as before, we want a single classical test that, with failure probability at most $\alpha$, distinguishes
$$
\begin{cases}
~\text{H}_0\text{ (“close”)}  &: D_n \leq \varepsilon_1,\\[6pt]
~\text{H}_1\text{ (“far”)}    &: D_n \geq \varepsilon_2,
\end{cases}
\qquad
0 \leq \varepsilon_1 < \varepsilon_2 \leq 1,
$$
where $D_n := D(\rho_1 \otimes \dots \otimes \rho_n, \Phi^{\otimes n})$.

For each coordinate $i$ (i.e. each position in the $n$-tuple of pairs), let
$$
\delta_i := \Pr[\text{mismatch} \mid \text{matching bases on coordinate } i]
$$
be the *true* mismatch probability for that coordinate, and let
$$
\hat{\delta}_i := \frac{\#\{\text{mismatches on coordinate } i\}}{\#\{\text{matching-basis trials on coordinate } i\}}
$$
be its *empirical* mismatch rate from the data.

In the easy case, all $\delta_i$ are identical because of the i.i.d. assumption. So pooling all matching-basis trials into a single $\hat{\delta}$ is equivalent to estimating $\delta_i$ for any $i$. And as we've seen, we only need one concentration bound.

However, for our medium (independent, non-identical) case, the $\delta_i$ may differ. To certify *all* coordinates simultaneously, we need to guarantee that $|\hat{\delta}_i - \delta_i|$ is small **for every** $i$. This unfortunately forces us to run the test on each coordinate separately and then take a **union bound** over the $n$ coordinates, and we'll soon see that this adds an extra $n \log n$ factor in the sample complexity on top of the easy case.

Let's get started. First, we organise repeated i.i.d. copies of the *entire* $n$-tuple into *blocks* using the definition from near the very beginning of this post. As a reminder, in the context of the medium case, a block is one i.i.d. copy of the global product state $\varrho$. Note that in the medium case (in fact, for all three cases) we are still given i.i.d. copies of
$$
\varrho = \rho_1 \otimes \rho_2 \otimes \cdots \otimes \rho_n,
$$
but within $\varrho$, the individual $\rho_i$ may be different.

After preparing a block, we make independent calls to the single-pair oracle $\mathbb{O}$ on *each* coordinate $i = 1, \dots, n$. The block then outputs
$$
\bigl\{ (M_{(j, i)},\,Y_{(j, i)}) \bigr\}_{i=1}^n,
$$
where $j$ indexes the block. Explicitly, in block $j$ we obtain for each coordinate $i$:

- a matching indicator $M_{(j, i)} \in \{0, 1\}$, which is $1$ if Alice's and Bob's bases matched for that pair;
- and, if $M_{(j, i)} = 1$, a mismatch bit $Y_{(j, i)} \in \{0, 1\}$ with $\mathbb{E}[Y_{(j,i)} \mid M_{(j,i)} = 1] = \delta_i$.

We repeat this procedure over $N$ independent blocks. The entire dataset forms an $N \times n$ table:
$$
\begin{array}{c|cccc}
\text{block } j & i=1 & i=2 & \cdots & i=n \\ \hline
1 & (M_{(1,1)}, Y_{(1,1)}) & (M_{(1,2)}, Y_{(1,2)}) & \cdots & (M_{(1,n)}, Y_{(1,n)}) \\
2 & (M_{(2,1)}, Y_{(2,1)}) & (M_{(2,2)}, Y_{(2,2)}) & \cdots & (M_{(2,n)}, Y_{(2,n)}) \\
\vdots & \vdots & \vdots & \ddots & \vdots \\
N & (M_{(N,1)}, Y_{(N,1)}) & (M_{(N,2)}, Y_{(N,2)}) & \cdots & (M_{(N,n)}, Y_{(N,n)})
\end{array}
$$

where each cell comes from a single call to $\mathbb{O}(\rho_i)$. In total, we have made $T = n \cdot N$ calls to the oracle. In this table:

- **Rows** (fixed $j$): contain all $n$ coordinates in the same block, prepared together as one copy of $\varrho$. The $\rho_i$ can be different, so entries in the same row are generally *not* identically distributed.
- **Columns** (fixed $i$): contain the same coordinate across $N$ i.i.d. blocks. These entries *are* i.i.d. samples from $\rho_i$, since each block contains a fresh copy of it in position $i$.

Therefore, when analysing each coordinate ($i$) separately, the $N$ entries in a column are independent and identically distributed. The union bound will later account for all $n$ coordinates at once.

### A pipeline for the decision rule

For our decision rule, we must reason directly with the **product fidelity**
$$
F_n^2 ~=~ \prod_{i=1}^n F_i^2,
$$
since this is what determines the global trace distance in $\mathbf{H_0}$ and $\mathbf{H_1}$. Any aggregate statistic of the per-coordinate error rates (such as $\max_i\hat\delta_i$ or an average) can misclassify states: even if one coordinate has a relatively large mismatch rate $\delta_i$ (and thus a lower $F_i$), the remaining coordinates may have fidelities close to $1$, so that the product fidelity $F_n$ still satisfies the global acceptance condition. In this case, a per‐coordinate max rule would incorrectly reject such a state. To align the test with the global criterion, we instead construct **upper confidence bounds** $U_i$ such that, with high probability, $\delta_i \leq U_i$ for all $i$ simultaneously. These bounds give
$$
F_i^2 ~\geq~ 1 - 2U_i
$$
and hence a **lower confidence bound** on the product fidelity,
$$
\widehat{F}_{\text{LCB}}^{\,2} := \prod_{i=1}^n (1 - 2U_i) ~\leq~ F_n^2.
$$

We then accept iff $\widehat{F}_{\text{LCB}}^{\,2}$ exceeds a threshold, so the decision rule targets the global fidelity condition directly.

In short, we would first establish a per-coordinate UCB on $\delta_i$, use that to establish a LCB on the global fidelity $F_n$, then we can derive a decision rule. Let's break down the pipeline step by step.

#### Per-coordinate UCB on $\delta_i$

For each coordinate $i \in [n]$, define the matching-basis index set across blocks (columns)
$$
S_i := \{\, j \in [N] : M_{(j, i)} = 1 \,\}.
$$

The empirical mismatch rate on coordinate $i$ is
$$
\hat\delta_i ~=~ \frac{1}{|S_i|} \sum_{j \in S_i} Y_{(j, i)} \quad\text{(defined when }|S_i| > 0\text{)}.
$$

Recall the per-coordinate true error rate $\delta_i = \Pr[Y = 1 \mid M = 1]$.

The random variables $\{Y_{(j,i)}\}_{j\in S_i}$ are i.i.d. Bernoulli with mean $\delta_i$. For any $t > 0$, we have the one-sided Hoeffding bound
$$
\Pr\!\left[\delta_i - \hat\delta_i \geq t\right] \leq e^{-2|S_i|t^2}.
$$

Compared to the two-sided Hoeffding bound used earlier, the absolute value on the left-hand side has been dropped. Intuitively, the two-sided version accounts for both deviations above and below the mean, each equally likely, which introduces the extra factor of $2$ in front of the exponential. In the one-sided case, we only consider one direction of deviation, so this factor disappears.

To turn the Hoeffding bound into a high-confidence margin, we pick $t$ so that the bad event $\delta_i > \hat{\delta}_i + t$ occurs with probability at most a chosen budget $\beta$:
$$
e^{-2|S_i|t^2} \leq \beta.
$$

Taking logarithms and rearranging gives
$$
t^2 \geq \frac{\ln(1/\beta)}{2|S_i|} 
\quad\implies\quad
t \geq \sqrt{\frac{\ln(1/\beta)}{2|S_i|}}.
$$

Since $|S_i|$ can be different for each coordinate, the margin for $t$ will in general depend on $i$. Therefore, we write it as $t_i$. In practice, choosing $t_i$ larger than necessary would make the bound looser by increasing the UCB $U_i$.
To keep the bound as tight as possible, we take the smallest $t_i$ that satisfies the inequality (i.e. set it by taking the equality) and set
$$
t_i = \sqrt{\frac{\ln(1/\beta)}{2|S_i|}}.
$$

This choice guarantees that
$$
\Pr[\delta_i > \hat{\delta}_i + t_i]  \leq \beta
$$
for the given coordinate $i$.

By the union bound, for any events $E_1, \dots, E_n$,
$$
\Pr\!\left[ ~\bigcup_{i = 1}^{n} E_i~ \right] ~\leq~ \sum_{i = 1}^n \Pr[E_i].
$$
In our context, we want all $n$ coordinates to have valid upper bounds simultaneously. Let $E_i$ be the event that the UCB for coordinate $i$ fails,
$$
E_i := \left\{\delta_i > \hat{\delta}_i + t_i\right\},
$$
applying the union bound gives
$$
\Pr\!\left[\,\exists i: \delta_i > \hat\delta_i + t_i\,\right] ~\leq~ \sum_{i=1}^n \Pr[\delta_i > \hat\delta_i + t_i].
$$

In words: the probability that at least one coordinate's bound fails is no more than the sum of the individual failure probabilities.

If each coordinate's bound fails with probability at most $\beta$, then by the union bound the probability that *any* coordinate's bound fails is at most $n\beta$. If (by choice) we allocate half of the total error budget $\alpha$ to this step, then we require
$$
n\beta \leq \frac{\alpha}{2} \quad\implies\quad \beta \leq \frac{\alpha}{2n}.
$$

Substituting this $\beta$ into the expression for $t_i$ gives
$$
t_i = \sqrt{\frac{\ln(1/\beta)}{2|S_i|}} = \sqrt{\frac{\ln\!\left(\frac{2n}{\alpha}\right)}{2|S_i|}}.
$$

From the one-sided Hoeffding bound earlier, we can construct a valid UCB on $\delta_i$ by taking the empirical rate and adding the margin:
$$
U_i := \hat\delta_i + t_i.
$$

To enforce our relabeling convention $\delta_i \in [0, \tfrac{1}{2}]$, we take
$$
U_i := \min\left\{ \tfrac{1}{2}, \hat\delta_i + t_i \right\}.
$$
This cap at $\tfrac{1}{2}$ reflects our per-basis relabeling convention: for each basis, we flip Bob's outcomes if necessary so that the mismatch probability is at most $\tfrac{1}{2}$; values above $\tfrac{1}{2}$ are operationally equivalent to their complement and therefore replaced by $\tfrac{1}{2}$.

Therefore, for all coordinates $i \in [n]$, we have established a upper confidence bound on the per-coordinate true error rate $\delta_i$, and by the union bound all $n$ inequalities $\delta_i \leq U_i$ hold *simultaneously* with probability at least $1 - \tfrac{\alpha}{2}$. Let's now translate this into a lower confidence bound on the global fidelity.

#### LCB on the global fidelity $F_n$
By the single-pair fidelity-error relation, for each coordinate $i \in [N]$ we have
$$
F(\rho_i, \Phi) \geq \sqrt{1 - 2\delta_i}.
$$

Squaring both sides and substituting the upper confidence bound $U_i$ for $\delta_i$ yields
$$
F(\rho_i, \Phi)^2 \geq 1 - 2\delta_i \geq 1 - 2U_i.
$$

Multiplying over all coordinates,
$$
F(\varrho, \Phi^{\otimes n})^2
~=~ \prod_{i=1}^n F(\rho_i, \Phi)^2
~\geq~ \prod_{i=1}^n \bigl(1 - 2U_i\bigr).
$$

We define the lower confidence bound (LCB) on the global fidelity as
$$
\widehat{F}_{\text{LCB}}^{\,2} := \prod_{i=1}^n \bigl(1 - 2U_i\bigr),
$$
which is non-negative by construction, since $U_i \leq \tfrac{1}{2}$ from our definition. 


Therefore, from the union bound construction above, all $n$ inequalities $\delta_i \leq U_i$ hold simultaneously with probability at least $1 - \tfrac{\alpha}{2}$. On this event,
$$
\widehat{F}_{\text{LCB}}^{\,2} \leq F(\varrho, \Phi^{\otimes n})^2,
$$

so $\widehat{F}_{\text{LCB}}^{\,2}$ is a valid lower confidence bound on the global fidelity $F_n^2$ with probability at least $1 - \tfrac{\alpha}{2}$.

(In the final theorem, this will combine with the separate high-probability guarantee from the "enough matches" step to give an overall probability of at least $1 - \alpha$.)

With this LCB on the global fidelity established, we now need to define a decision rule for the test.

#### Decision rule and correctness proof

Define the cutoff
$$
\tau := 1 - \frac{\varepsilon_1^2 + \varepsilon_2^2}{2}.
$$
Then we accept ***iff*** $\widehat{F}_{\text{LCB}}^{\,2} \geq \tau$:
> $$
\textbf{Decision rule (medium case)} =
\begin{cases}
\text{“close”} & \text{if } \widehat{F}_{\text{LCB}}^{\,2} \geq \tau,\\[4pt]
\text{“far”} & \text{if } \widehat{F}_{\text{LCB}}^{\,2} < \tau.
\end{cases}
$$

We need to prove the correctness of our decision rule, conditioned on the *good event* $\mathcal{G}$. Correctness includes completeness (close $\Rightarrow$ accept) and soundness (far $\Rightarrow$ reject). But before we get into that, what exactly is the good event in the medium case?

[write what the good event is]

---

After this line, everything below is not fully correct

---



As in the i.i.d. case, define the function 
$$
f(\varepsilon) := \tfrac{1}{2}\!\left[1 - (1 - \varepsilon^2)^{1/n}\right],
$$
the thresholds
$$
\delta_{\text{close}} := f(\varepsilon_1), \quad \delta_{\text{far}} := f(\varepsilon_2),
$$
the (midpoint) cutoff
$$
\kappa := \tfrac{1}{2}(\delta_{\text{close}} + \delta_{\text{far}}),
$$
and set the margin
$$
t := \tfrac{1}{2}(\delta_{\text{far}} - \delta_{\text{close}}).
$$
(As before, $\delta_{\text{far}} - \delta_{\text{close}} = \Delta_\delta \geq \frac{\varepsilon_2^2-\varepsilon_1^2}{2n}$.)

> $$
\textbf{Decision rule (medium case)} =
\begin{cases}
\text{“close”} & \text{if } \max_{i \in [n]} \hat\delta_i < \kappa,\\
\text{“far”}   & \text{if } \max_{i \in [n]} \hat\delta_i \geq \kappa.
\end{cases}
$$

In other words, we accept if and only if the worst-case error rate is strictly less than our cutoff $\kappa$, meaning all our error rates $\hat\delta_i$ has to pass the cutoff test.

Define the **good event**
$$
\mathcal G ~:=~ \bigcap_{i=1}^n \left\{\,|\hat\delta_i - \delta_i| < t\,\right\},
$$
i.e. *every* column concentrates within the margin $t$. We will set the number of blocks $N$ so that $\Pr[\mathcal G] \geq 1 - \alpha$ using concentration bounds.

Let's quickly show completeness and soundness of our decision rule.

**Completeness (close $\Rightarrow$ accept).** If every coordinate is close i.e. $\delta_i \leq \delta_{\text{close}}$ for all $i$, then on the *good* event $\mathcal{G}$,
$$
\hat\delta_i < \delta_i + t ~\le~ \delta_{\text{close}} + t ~=~ \kappa
\quad\implies\quad
\max_i \hat\delta_i < \kappa,
$$
so we accept.

**Soundness (far $\Rightarrow$ reject).** This requires some work. If the global state $\varrho = \otimes_{i=1}^n \rho_i$ is far i.e. $D(\varrho, \Phi^{\otimes n}) \geq \varepsilon_2$, then by the (right-hand) Fuchs–van de Graaf inequality, the global fidelity, $F_n$, satisfies
$$
F_n := F(\varrho, \Phi^{\otimes n}) \leq \sqrt{1 - \varepsilon_2^2}.
$$
Fidelity is multiplicative even for *heterogeneous* products:
$$
F_n = \prod_{i=1}^n F_i, \quad\text{where } F_i := F(\rho_i,\Phi).
$$
Let $\tau := (1 - \varepsilon_2^2)^{1/(2n)}$, so $\tau^n = \sqrt{1 - \varepsilon_2^2}$. If **every** coordinate satisfied $F_i > \tau$, then
$$
F_n ~=~ \prod_{i=1}^n F_i ~>~ \tau^n ~=~ \sqrt{1 - \varepsilon_2^2},
$$
contradicting the bound for $F_n$ above. Therefore, there has to exist some coordinate $i^\star$ with
$$
F_{i^\star} ~\leq~ \tau ~=~ (1 - \varepsilon_2^2)^{1/(2n)}.
$$
Now use the single-pair link $F_i \geq \sqrt{1 - 2\delta_i}$ from the lemma above. Rearranging
$$
1 - 2\delta_{i^\star} ~\leq~ F_{i^\star}^2 ~\leq~ \tau^2 = (1 - \varepsilon_2^2)^{1/n}
$$
gives
$$
\delta_{i^\star} ~\geq~ \frac{1 - (1 - \varepsilon_2^2)^{1/n}}{2} ~=~ f(\varepsilon_2) ~=~ \delta_{\text{far}}.
$$
On the good event $\mathcal{G}$,
$$
\hat\delta_{i^\star} ~>~ \delta_{i^\star} - t ~\geq~ \delta_{\text{far}} - t ~=~ \kappa,
$$
so
$$
\max_i \hat\delta_i ~\geq~ \hat\delta_{i^\star} ~>~ \kappa,
$$
and we reject.

So all we owe now is to make the *good event* $\mathcal{G}$ hold with probability at least $1 - \alpha$ using a concentration bound.

---

### Concentration: all coordinates at once
`Complete writeup`


---

> **Theorem (Finite-sample tolerant EPR identity test, independent, non-identical pairs).**
>
> Let $n \geq 2$ and suppose the global state is $\varrho = \rho_1 \otimes \rho_2 \otimes \dots \otimes \rho_n$ for bipartite states $\rho_i$.
> Fix global trace-distance tolerances $0 \leq \varepsilon_1 < \varepsilon_2 \leq 1$ and failure probability $\alpha \in (0,1)$. 
> Define
> $$
\begin{aligned}
&f(\varepsilon) = \frac{1}{2}\!\left[1 - (1 - \varepsilon^2)^{1/n}\right], & &
\delta_{\text{close}} = f(\varepsilon_1), \\[6pt]
&\delta_{\text{far}} = f(\varepsilon_2), & &
\kappa = \frac{\delta_{\text{close}} + \delta_{\text{far}}}{2}.
\end{aligned}
$$
>
> **Protocol.** Prepare $N$ (i.i.d.) blocks of $\varrho$.
> For each block $j \in [N]$ and coordinate $i \in [n]$, make one call to $\mathbb{O}(\rho_i)$, obtaining $(M_{(j,i)}, Y_{(j,i)})$.
> For each coordinate $i$, define
> $$
S_i := \{\, j \in [N] ~:~ M_{(j,i)} = 1 \,\}
$$
> and compute
> $$
\hat{\delta}_i := \frac{1}{|S_i|} \sum_{j \in S_i} Y_{(j,i)},
$$
> where $Y_{(j,i)} \in \{0,1\}$ for all $(j,i) \in S_i$.
>
> **Decision rule.** Accept ***iff*** $\max_{i \in [n]} \hat{\delta}_i < \kappa$.
>
> If
> $$
N ~~\geq~~ \frac{32\,n^2}{(\varepsilon_2^2 - \varepsilon_1^2)^2}\,\ln\!\frac{4n}{\alpha}, \qquad\left[= O\!\left(n^2 \log n \left(\varepsilon_2^2 - \varepsilon_1^2\right)^{-2}\right)\right]
$$
> equivalently, the number of oracle calls,
> $$
T = n \cdot N ~~\geq~~ \frac{32\,n^3}{(\varepsilon_2^2 - \varepsilon_1^2)^2}\,\ln\!\frac{4n}{\alpha}, \qquad\left[= O\!\left(n^3 \log n \left(\varepsilon_2^2 - \varepsilon_1^2\right)^{-2}\right)\right]
$$
> then the following statements are true:
>
> - **Completeness.** If $D(\bigotimes_{i=1}^n \rho_i, \Phi^{\otimes n}) \leq \varepsilon_1$, the test accepts with probability at least $1 - \alpha$.
> - **Soundness.** If $D(\bigotimes_{i=1}^n \rho_i, \Phi^{\otimes n}) \geq \varepsilon_2$, the test rejects with probability at least $1 - \alpha$.
> - **Promise gap.** If $\varepsilon_1 < D(\bigotimes_{i=1}^n \rho_i, \Phi^{\otimes n}) < \varepsilon_2$, no guarantee is made; the test may accept or reject.
>
> *Note.* In the medium case, the $\delta_i$ may differ across coordinates, so each $\hat{\delta}_i$ must be estimated separately. The union bound over all $n$ coordinates yields the $\log(n)$ factor in the sample complexity.

## Hard case (arbitrary $2n$-qubit state)

We first prove this lemma.

**Lemma (n-pair all-match projector in $Z$ and $X$)**

Let $\varrho$ be any $2n$-qubit state on $A^nB^n$ (no product/separability assumed).
For each pair $i$ define the single-pair "match" effects
$$
\Pi_Z^{(i)}=\ket{00}\!\bra{00}_{A_iB_i}+\ket{11}\!\bra{11}_{A_iB_i},
\qquad
\Pi_X^{(i)}=\ket{++}\!\bra{++}_{A_iB_i}+\ket{--}\!\bra{--}_{A_iB_i}.
$$
Then the probability that **all $n$ pairs match** when **all** pairs are measured in the $Z$ (or $X$) basis is
$$
\Pr(\text{all match in }Z)=\operatorname{tr}\!\Big(\Pi_Z^{(n)}\,\varrho\Big),\quad
\Pr(\text{all match in }X)=\operatorname{tr}\!\Big(\Pi_X^{(n)}\,\varrho\Big),
$$
where
$$
\Pi_Z^{(n)}:=\bigotimes_{i=1}^n \Pi_Z^{(i)},\qquad
\Pi_X^{(n)}:=\bigotimes_{i=1}^n \Pi_X^{(i)}.
$$
**Proof.**

Let's look at the standard basis ($Z$) first since the algebra for the Hadamard basis ($X$) will be analogous.

We start by expanding the tensor product $\Pi_Z^{(n)}$:
$$
\Pi_Z^{(n)} \;=\; \bigotimes_{i=1}^n \Pi_Z^{(i)}
\;=\; \bigotimes_{i=1}^n\!\big(\ket{00}\!\bra{00} + \ket{11}\!\bra{11}\big).
$$
When $n = 1$ (trivial):
$$
\Pi_Z^{(1)} = \ket{00}\!\bra{00} + \ket{11}\!\bra{11}.
$$
When $n = 2$ (write every multiplication out):
$$
\begin{aligned}
\Pi_Z^{(2)}
&= \big(\ket{00}\!\bra{00} + \ket{11}\!\bra{11}\big)
   \otimes \big(\ket{00}\!\bra{00} + \ket{11}\!\bra{11}\big)\\[6pt]
&= \ket{00}\!\bra{00}\otimes\ket{00}\!\bra{00}
  +\ket{00}\!\bra{00}\otimes\ket{11}\!\bra{11}\\[4pt]
&\quad+\ket{11}\!\bra{11}\otimes\ket{00}\!\bra{00}
  +\ket{11}\!\bra{11}\otimes\ket{11}\!\bra{11}.
\end{aligned}
$$
So for $n=2$ you have exactly the sum over the four strings
$$
\{ (00,00),(00,11),(11,00),(11,11) \} = \{ 00, 11 \}^2.
$$
Claim (inductive hypothesis):
$$
\bigotimes_{i=1}^n\!\big(\ket{00}\!\bra{00} + \ket{11}\!\bra{11}\big)
= \sum_{(s_1,\dots,s_n)\in\{00, 11\}^n}
\big(\ket{s_1}\!\bra{s_1}\big)\otimes\cdots\otimes\big(\ket{s_n}\!\bra{s_n}\big).
$$
Proof by induction on $n$.

* Base $n = 1$ holds (first line above).
* Assume true for $n = k$:
$$
\bigotimes_{i=1}^k\!\big(\ket{00}\!\bra{00} + \ket{11}\!\bra{11}\big)
= \sum_{(s_1,\dots,s_k)\in\{00,11\}^k}
\bigotimes_{i=1}^k \ket{s_i}\!\bra{s_i}.
$$
* Multiply both sides by the $(k + 1)$-th factor:
$$
\begin{aligned}
&\left(\sum_{(s_1,\dots,s_k)\in\{00,11\}^k}
\bigotimes_{i=1}^k \ket{s_i}\!\bra{s_i}\right)
\otimes\left(\ket{00}\!\bra{00}+\ket{11}\!\bra{11}\right)\\[6pt]
&\qquad= \sum_{(s_1,\dots,s_k)\in\{00,11\}^k}
\left(\bigotimes_{i=1}^k \ket{s_i}\!\bra{s_i}\right)\otimes\ket{00}\!\bra{00}\\[4pt]
&\qquad\qquad+\sum_{(s_1,\dots,s_k)\in\{00,11\}^k}
\left(\bigotimes_{i=1}^k \ket{s_i}\!\bra{s_i}\right)\otimes\ket{11}\!\bra{11}.
\end{aligned}
$$
- Combine the two sums into a single sum over all $(s_1,\dots,s_k,s_{k+1})\in\{00,11\}^{k+1}$, which yields exactly
$$
\sum_{(s_1,\dots,s_{k+1})\in\{00,11\}^{k+1}}
\bigotimes_{i=1}^{k+1}\ket{s_i}\!\bra{s_i}.
$$
- This proves the statement for $n = k + 1$. By induction the expansion holds for all $n$; tensor product distributes over finite sums.

So the full expansion is
$$
\Pi_Z^{(n)}
=\sum_{(s_1,\dots,s_n)\in\{00,11\}^n}
\big(\ket{s_1}\!\bra{s_1}\big)\otimes\cdots\otimes\big(\ket{s_n}\!\bra{s_n}\big).
$$
Each term
$$
\big(\ket{s_1}\!\bra{s_1}\big)\otimes\cdots\otimes\big(\ket{s_n}\!\bra{s_n}\big)
$$
is the projector onto the product basis vector $\ket{s_1}\otimes\cdots\otimes\ket{s_n}$. By the Born rule, its trace with $\varrho$ equals the probability that, when measuring all pairs in the $Z$-basis, the outcomes are exactly $s_1,\dots,s_n$. Therefore summing those traces gives the probability that every pair's outcome is either `00` or `11`, i.e. every pair matched (they're disjoint events). Hence
$$
\begin{aligned}
\Pr(\text{all match in }Z)
&= \sum_{(s_1,\dots,s_n)\in\{00,11\}^n}
    \operatorname{tr}\!\Big(\big(\ket{s_1}\!\bra{s_1}\big)\otimes\cdots\otimes\big(\ket{s_n}\!\bra{s_n}\big)\,\varrho\Big)
&&\text{[Born rule]}\\[4pt]
&= \operatorname{tr}\!\Bigg(\Bigg[\sum_{(s_1,\dots,s_n)\in\{00,11\}^n}
    \big(\ket{s_1}\!\bra{s_1}\big)\otimes\cdots\otimes\big(\ket{s_n}\!\bra{s_n}\big)\Bigg]\;\varrho\Bigg)
&&\text{[linearity of trace]}\\[6pt]
&= \operatorname{tr}\!\Bigg(\Bigg[\bigotimes_{i=1}^n\big(\ket{00}\!\bra{00}+\ket{11}\!\bra{11}\big)\Bigg]\;\varrho\Bigg)
&&\text{[tensor distributes over finite sums]}\\[6pt]
&= \operatorname{tr}\!\Big(\Pi_Z^{(n)}\,\varrho\Big)
.
&&\text{[definition of }\Pi_Z^{(n)}\text{]}
\end{aligned}
$$

The $X$ case is identical with $\ket0,\ket1$ replaced by $\ket+,\ket-$:
$$
\begin{aligned}
\Pr(\text{all match in }X)
&= \sum_{(t_1,\dots,t_n)\in\{++,--\}^n}
    \operatorname{tr}\!\Big(\big(\ket{t_1}\!\bra{t_1}\big)\otimes\cdots\otimes\big(\ket{t_n}\!\bra{t_n}\big)\,\varrho\Big)\\[4pt]
&= \operatorname{tr}\!\Bigg(\Bigg[\sum_{(t_1,\dots,t_n)\in\{++,--\}^n}
    \big(\ket{t_1}\!\bra{t_1}\big)\otimes\cdots\otimes\big(\ket{t_n}\!\bra{t_n}\big)\Bigg]\;\varrho\Bigg)\\[6pt]
&= \operatorname{tr}\!\Bigg(\Bigg[\bigotimes_{i=1}^n\big(\ket{++}\!\bra{++}+\ket{--}\!\bra{--}\big)\Bigg]\;\varrho\Bigg)\\[6pt]
&= \operatorname{tr}\!\Big(\Pi_X^{(n)}\,\varrho\Big).
\end{aligned}
$$
The proof is complete. $\quad\square$

Using this lemma, let the *global all-match test* pick $Z$ or $X$ for **all** pairs (each with prob. $1/2$) and accept ***iff*** all $n$ pairs match. Then
$$
1 - \delta_\star ~=~ \frac{1}{2}\,\operatorname{tr}\!\left[\left(\bigotimes_{i=1}^{n}\Pi_Z^{(i)}\right)\varrho\right] + \frac{1}{2}\,\operatorname{tr}\!\left[\left(\bigotimes_{i=1}^n\Pi_X^{(i)}\right)\varrho\right],
$$
where $\delta_\star$ is the *true* error rate across the entire $2n$-qubit block $\varrho$. Recall the single-pair identities
$$
\Pi_Z^{(i)}=\ket{\Psi_{00}}\!\bra{\Psi_{00}}+\ket{\Psi_{01}}\!\bra{\Psi_{01}},\qquad
\Pi_X^{(i)}=\ket{\Psi_{00}}\!\bra{\Psi_{00}}+\ket{\Psi_{10}}\!\bra{\Psi_{10}}.
$$
Take tensor products and expand, using the fact that tensor product distributes over finite sums:
$$
\Pi_Z^{(n)}=\sum_{j_1,\dots,j_n\in\{00,01\}}
\bigotimes_{i=1}^n \ket{\Psi_{j_i}}\!\bra{\Psi_{j_i}},
\qquad
\Pi_X^{(n)}=\sum_{j_1,\dots,j_n\in\{00,10\}}
\bigotimes_{i=1}^n \ket{\Psi_{j_i}}\!\bra{\Psi_{j_i}}.
$$
For each Bell string $(j_1,\dots,j_n)$,
$$
\ket{\Psi_{j_1\cdots j_n}}\!\bra{\Psi_{j_1\cdots j_n}} = \bigotimes_{i=1}^n \ket{\Psi_{j_i}}\!\bra{\Psi_{j_i}},
$$
the product Bell state with the $i$-th pair in Bell state $\ket{\Psi_{j_i}}$. By the Born rule, the corresponding probability weight is
$$
p_{j_1\cdots j_n} := \bra{\Psi_{j_1\cdots j_n}}\,\varrho\,\ket{\Psi_{j_1\cdots j_n}},
$$
i.e. the probability of obtaining the Bell outcome $(j_1,\dots,j_n)$ if the block were measured in the Bell basis. Using the expansions above,
$$
\Pi_Z^{(n)}=\sum_{j_1,\dots,j_n\in\{00,01\}}
\ket{\Psi_{j_1\cdots j_n}}\!\bra{\Psi_{j_1\cdots j_n}}.
$$
Then
$$
\begin{aligned}
\operatorname{tr}\!\big(\Pi_Z^{(n)}\varrho\big)
&=\operatorname{tr}\!\Bigg(\sum_{j_1,\dots,j_n\in\{00,01\}}
\ket{\Psi_{j_1\cdots j_n}}\!\bra{\Psi_{j_1\cdots j_n}}\;\varrho\Bigg)\\[6pt]
&=\sum_{j_1,\dots,j_n\in\{00,01\}}
\operatorname{tr}\!\big(\ket{\Psi_{j_1\cdots j_n}}\!\bra{\Psi_{j_1\cdots j_n}}\;\varrho\,\big)&&\text{[linearity of trace]}\\[6pt]
&=\sum_{j_1,\dots,j_n\in\{00,01\}}
\operatorname{tr}\!\big(\bra{\Psi_{j_1\cdots j_n}}\,\varrho\,\ket{\Psi_{j_1\cdots j_n}}\big)
&&\text{[cyclicity of trace]}\\[6pt]
&=\sum_{j_1,\dots,j_n\in\{00,01\}}
\bra{\Psi_{j_1\cdots j_n}}\,\varrho\,\ket{\Psi_{j_1\cdots j_n}}
&&\text{[trace of scalar = itself]}\\[6pt]
&=\sum_{j_1,\dots,j_n\in\{00,01\}} p_{j_1\cdots j_n}. &&\text{[Born rule]}
\end{aligned}
$$
The same steps with $\{00,10\}^n$ give
$$
\operatorname{tr}\!\big(\Pi_X^{(n)}\varrho\big)=\sum_{j_1,\dots,j_n\in\{00,10\}} p_{j_1\cdots j_n}.
$$
So we have
$$
\operatorname{tr}\!\big(\Pi_Z^{(n)}\varrho\big)=\sum_{j_1,\dots,j_n\in\{00,01\}} p_{j_1\cdots j_n},
\qquad
\operatorname{tr}\!\big(\Pi_X^{(n)}\varrho\big)=\sum_{j_1,\dots,j_n\in\{00,10\}} p_{j_1\cdots j_n}.
$$
Plug into
$$
1 - \delta_\star=\frac12\,\operatorname{tr}\!\big(\Pi_Z^{(n)}\varrho\big)+\frac12\,\operatorname{tr}\!\big(\Pi_X^{(n)}\varrho\big),
$$
we get
$$
1-\delta_\star
=\frac12\sum_{j_1,\dots,j_n\in\{00,01\}} p_{j_1\cdots j_n}
+\frac12\sum_{j_1,\dots,j_n\in\{00,10\}} p_{j_1\cdots j_n}.
$$
One key observation is that the two index sets intersect only at the single string $\mathbf{0} := (00,\dots,00)$ where there are $n$ copies of `00`s; in other words, at each coordinate $i \in [n]$, the only allowed choice is $j_i=00$. Set
$$
U:=\{00,01,10,11\}^n,\qquad
S_Z:=\{00,01\}^n,\qquad
S_X:=\{00,10\}^n.
$$
Note that $S_Z \cap S_X = \{\mathbf{0}\}$ because $\{00,01\}\cap\{00,10\}=\{00\}$ coordinate-wise. Let
$$
R:=\sum_{\mathbf j\in\,U\setminus(S_Z \cup S_X)} p_{\mathbf{j}} \quad(\geq 0)
$$
be the total probability mass on the Bell strings outside $S_Z \cup S_X$.  Since $\sum_{\mathbf{j} \in U}p_{\mathbf{j}} = 1$, we have
$$
\sum_{\mathbf{j} \in S_Z \cup S_X} p_{\mathbf{j}} = 1 - R.
$$
By the [inclusion–exclusion principle](https://en.wikipedia.org/wiki/Inclusion%E2%80%93exclusion_principle),
$$
\sum_{\mathbf j\in S_Z} p_{\mathbf j}+\sum_{\mathbf j\in S_X} p_{\mathbf j}
=\sum_{\mathbf j\in S_Z \cup S_X} p_{\mathbf j}+\sum_{\mathbf j\in S_Z\cap S_X} p_{\mathbf j}
=(1-R)+p_{\mathbf 0}.
$$
Therefore
$$
1-\delta_\star=\tfrac12\sum_{\mathbf j\in S_Z} p_{\mathbf j}+\tfrac12\sum_{\mathbf j\in S_X} p_{\mathbf j}
=\tfrac12\big((1-R)+p_{\mathbf0}\big)
=\tfrac12+\tfrac12 p_{\mathbf0}-\tfrac12 R.
$$
Rearranging gives
$$
p_{\mathbf{0}} - R = 1 - 2\delta_\star.
$$
Since $R$ is a sum of probabilities, $R \geq 0$. Hence we can drop it to obtain the bound
$$
p_{\mathbf{0}} \geq 1 - 2\delta_\star.
$$
Recalling $p_{\mathbf{0}} = p_{00\cdots0} = \bra{\Psi_{00}}^{\otimes n}\,\varrho\,\ket{\Psi_{00}}^{\otimes n} = F^2(\varrho,\text{EPR}^{\otimes n})$, this yields
$$
F(\varrho,\text{EPR}^{\otimes n})\ge\sqrt{1-2\delta_\star}.
$$
For trace distance $D(\varrho,\text{EPR}^{\otimes n})$, Fuchs–van de Graaf gives
$$
D(\varrho,\text{EPR}^{\otimes n})\le\sqrt{2\delta_\star}.
$$
This argument already works without assuming any product structure, separability, or i.i.d. property inside the block. It therefore provides a valid bound in the fully general hard case. However, the analysis above relied on using the same basis for all coordinates. Can we do better? A natural next step is to consider a more general test where the basis choice is made independently per coordinate. 

Precisely, we choose a basis string $b = (b_1, \dots, b_n)$ uniformly at random such that $b_i \in \{Z, X\}$. For each coordinate $i \in [n]$, measure in $b_i$. Accept *iff* **every pair matches its own basis $b_i$**. Define $\Pi_b = \bigotimes_{i=1}^n \Pi_{b_i}^{(i)}$. Then the acceptance probability:
$$
1 - \delta_\star = \frac{1}{2^n}\sum_{b \in \{Z, X\}^n} \text{tr}(\Pi_b\,\varrho), \qquad(1)
$$
where $\delta_\star$ is the *true* error rate across the entire $2n$-qubit block $\varrho$. Let $\mathbf{j} = (j_1, \dots, j_n) \in \{00, 01, 10, 11\}^n$ denote a Bell string and the probability
$$
p_\mathbf{j} = \bra{\Psi_\mathbf{j}} \varrho \ket{\Psi_\mathbf{j}} \qquad \text{and}\qquad \sum_{\mathbf{j} \in \{ 00, 01, 10, 11 \}^n} p_\mathbf{j} = 1,
$$
similar to what we've done in the simpler case earlier. As a reminder, for one coordinate,
$$
\Pi_Z = \ket{\Psi_{00}}\!\bra{\Psi_{00}} + \ket{\Psi_{01}}\!\bra{\Psi_{01}}, \quad \Pi_X = \ket{\Psi_{00}}\!\bra{\Psi_{00}} + \ket{\Psi_{10}}\!\bra{\Psi_{10}}.
$$
For a basis pattern $b \in \{Z, X\}^n$, a Bell string $\mathbf{j} = (j_1, \dots, j_n)$ is accepted *iff* for every $i$,
$$
j_i \in \begin{cases}
S_Z = \{00, 01\},~ b_i = Z,\\
S_X = \{00, 10\},~ b_i = X.
\end{cases}
$$
In words, each coordinate is accepted in its chosen basis. Note that $j_i = 11$ is never accepted in neither basis.

Define the set of Bell strings accepted by $b$:
$$
B_b := \left\{~ \mathbf{j} \in \{ 00, 01, 10, 11 \}^n \mid j_i \in S_{b_i} ~\forall i \in [n] ~\right\} = \{~ \mathbf{j} : \mathbf{j} \text{ passes under } b ~\}.
$$
Then
$$
\text{tr}(\Pi_b \,\varrho) = \sum_{\mathbf{j} \in B_b} p_\mathbf{j}.
$$
Plugging into $(1)$, we get
$$
1 - \delta_\star = \frac{1}{2^n} \sum_{b \in \{Z, X\}^n}\ \sum_{\mathbf{j} \in B_b} p_\mathbf{j}. \qquad(\text{A})
$$
To analyse this expression, we want to know, for each Bell string $\mathbf j$, how much it contributes to the acceptance probability. Right now, that contribution is hidden inside the sets $B_b$, which vary with the basis pattern $b$. To expose it, we first rewrite the inner sum over a fixed universal set $U$ using an indicator function. This lets us safely interchange the two sums (since both are finite), and after doing so the coefficient of each $\mathbf j$ (the fraction of basis patterns $b$ that accept it) appears explicitly.

Precisely, let
$$
U:=\{00,01,10,11\}^n,\qquad \mathbf 1_{\{\mathbf j\in B_b\}}=
\begin{cases}
1,&\mathbf j\in B_b,\\
0,&\text{otherwise.}
\end{cases}
$$
Then for each $b$,
$$
\sum_{\mathbf j\in B_b} p_{\mathbf j}
=\sum_{\mathbf j\in U}\mathbf 1_{\{\mathbf j\in B_b\}}\,p_{\mathbf j}.
\qquad(\text{B})
$$
(We’ve just replaced “sum over a moving set $B_b$” by “sum over a fixed set $U$ with a 0/1 mask”.)

Substitute $(\text{B})$ into $(\text{A})$:

$$
1-\delta_\star
=\frac{1}{2^n}\sum_{b\in\{Z,X\}^n}\ \sum_{\mathbf j\in U}\mathbf 1_{\{\mathbf j\in B_b\}}\,p_{\mathbf j}.
$$
Now both sums are **finite**, so we can swap them (this is just re-indexing a finite double sum):
$$
1-\delta_\star
=\sum_{\mathbf j\in U}\left(\frac{1}{2^n}\sum_{b\in\{Z,X\}^n}\mathbf 1_{\{\mathbf j\in B_b\}}\right)p_{\mathbf j}.
\qquad(\text{C})
$$
The term in parentheses is the **coefficient** of $\mathbf j$: the fraction of basis patterns that accept it. Denote this coefficient by $c_{\mathbf j}$; define
$$
\begin{aligned}
c_{\mathbf j} :=~ &\frac{1}{2^n}\,\big|\{\,b\in\{Z,X\}^n:\mathbf j\in B_b\,\}\big|\\
=~ &\frac{1}{2^n}\sum_{b\in\{Z,X\}^n}\mathbf 1_{\{\mathbf j\in B_b\}}.
\end{aligned}
$$
Then $(\text{C})$ becomes
$$
1-\delta_\star = \sum_{\mathbf j\in U} c_{\mathbf j}\,p_{\mathbf j}
\qquad(2)
$$
We now determine the coefficients $c_\mathbf{j}$ by a direct counting argument. For a fixed $\mathbf{j} = (j_1, \dots, j_n)$,
- If $j_i = 00$: both $Z$ and $X$ accept $\Rightarrow$ two basis choices for $b_i$,
- If $j_i = 01$ or $10$: exactly one choice,
- If $j_i = 11$: zero choices.

Multiplying across coordinates $[n]$ gives
$$
\big|\{b:\mathbf j\in B_b\}\big| = 2^{\#00(\mathbf j)} \cdot 1^{\#01(\mathbf j) + \#10(\mathbf j)} \cdot 0^{\#11(\mathbf j)}.
$$
Hence
$$
c_\mathbf{j} = 
\begin{cases}
2^{\#00(\mathbf j) - n}&, &\text{if no } j_i = 11,\\
0&, &\text{otherwise}.
\end{cases}
$$
So
$$
1 - \delta_\star = \sum_{\mathbf{j} \in \{ 00, 01, 10 \}^n} 2^{\#00(\mathbf j) - n} \;p_\mathbf{j}.
$$
We now isolate the $p_\mathbf{0}$ term by splitting out the $\mathbf 0 = (00, \ldots, 00)$ term (note that $c_{\mathbf 0} = 2^{n-n} = 1$; the all-$00$ string is accepted by every $b \in \{ Z, X \}^n$):
$$
1-\delta_\star
~=~ p_{\mathbf 0} + \sum_{\mathbf j\neq \mathbf 0} c_{\mathbf j}\,p_{\mathbf j},
\qquad\implies\qquad
p_{\mathbf 0}
~=~ (1-\delta_\star) - \sum_{\mathbf j\neq \mathbf 0} c_{\mathbf j}\,p_{\mathbf j}.
\qquad(3)
$$

Bounding the tail: For any $\mathbf j\neq\mathbf 0$ with *no* $11$, we have $\#00(\mathbf j) \leq n-1$, hence
$$
c_{\mathbf j} = 2^{\#00(\mathbf j)-n} \leq 2^{(n-1)-n} = \tfrac{1}{2}.
$$
If $\mathbf j$ contains a $11$, then $c_{\mathbf j}=0$ by definition. Therefore
$$
\sum_{\mathbf j\neq \mathbf 0} c_{\mathbf j}\,p_{\mathbf j} \;=\; \sum_{\substack{\mathbf j\neq \mathbf 0\\ \text{no }11}} c_{\mathbf j}\,p_{\mathbf j}
\;\leq\; \sum_{\substack{\mathbf j\neq \mathbf 0\\ \text{no }11}} \tfrac{1}{2}\,p_{\mathbf j} \;=\; \tfrac{1}{2} \sum_{\substack{\mathbf j\neq \mathbf 0\\ \text{no }11}} p_{\mathbf j}.
\qquad(4)
$$
Let
$$
r \;:=\; \sum_{\mathbf j:\,\exists i\ j_i=11} p_{\mathbf j}\ \ (\geq 0)
$$
denote the total probability mass on Bell strings containing at least one $11$. As we've seen just now, these strings never contribute to acceptance since $c_\mathbf{j} = 0$ in that case. Since probabilities sum to $1$,
$$
\sum_{\substack{\mathbf j\neq \mathbf 0\\ \text{no }11}} p_{\mathbf j}
= 1 - p_{\mathbf 0} - r.
\qquad(5)
$$
Plug $(5)$ into $(4)$:
$$
\sum_{\mathbf j\neq \mathbf 0} c_{\mathbf j}\,p_{\mathbf j}
\;\leq\; \tfrac{1}{2} (1 - p_{\mathbf 0} - r).
\qquad(6)
$$
To conclude a bound, we insert $(6)$ into $(3)$ and rearrange:

$$
p_{\mathbf 0} \;\ge\; (1-\delta_\star) - \tfrac{1}{2}(1 - p_{\mathbf 0} - r)
\;\implies\;
p_{\mathbf 0} \;\ge\; 1 - 2\delta_\star + r
\;\ge\; 1 - 2\delta_\star,
\qquad(7)
$$
since $r \geq 0$. Let's put everything together succinctly.

> **Theorem (Per-coordinate all-match test).**
>
> Let $\varrho$ be any $2n$-qubit state on $A^nB^n$ (no product/separability/i.i.d. assumption). For each pair $i$ define the single-pair match projectors
> $$
\Pi_Z^{(i)}=\ket{00}\!\bra{00}_{A_iB_i}+\ket{11}\!\bra{11}_{A_iB_i},\qquad
\Pi_X^{(i)}=\ket{++}\!\bra{++}_{A_iB_i}+\ket{--}\!\bra{--}_{A_iB_i}.
$$
> Consider the test that chooses a basis string $b = (b_1, \dots, b_n) \in \{ Z, X \}^n$ uniformly at random, measures pair $i$ in basis $b_i$, and accepts *iff* all $n$ pairs match in their respective bases. Let
> $$
\Pi_b=\bigotimes_{i=1}^n \Pi_{b_i}^{(i)},\qquad
1-\delta_\star = \frac{1}{2^n}\sum_{b\in\{Z,X\}^n}\operatorname{tr}(\Pi_b\,\varrho).
$$
> Then, writing $p_{\mathbf j}=\bra{\Psi_{\mathbf j}}\,\varrho\,\ket{\Psi_{\mathbf j}}$ for the Bell basis probabilities, the acceptance probability can be expressed as
> $$
1-\delta_\star=\sum_{\mathbf j\in\{00,01,10,11\}^n} c_{\mathbf j}\,p_{\mathbf j},\qquad
c_{\mathbf j}=
\begin{cases}
2^{\,\#00(\mathbf j)-n}, & \text{if $\mathbf j$ contains no $11$,}\\
0, & \text{otherwise.}
\end{cases}
$$
> In particular,
> $$
p_{\mathbf 0} \;\geq\; 1-2\delta_\star,
$$
> where $\mathbf{0} = (00, \dots, 00)$. The Bell string $\mathbf{0}$ corresponds to the state $\ket{\Psi_{\mathbf 0}} = \ket{\Psi_{00}}^{\otimes n} = \ket{\text{EPR}}^{\otimes n}$, so the probability weight $p_{\mathbf 0}$ is
> $$
p_{\mathbf 0} = \bra{\Psi_{\mathbf 0}}\,\varrho\,\ket{\Psi_{\mathbf 0}}
= \bra{\text{EPR}^{\otimes n}}\,\varrho\,\ket{\text{EPR}^{\otimes n}}
= F(\varrho,\text{EPR}^{\otimes n})^2.
$$
> Therefore, by Fuchs-van de Graaf,
> $$
F(\varrho,\text{EPR}^{\otimes n}) \;\geq\; \sqrt{1-2\delta_\star},\qquad
D(\varrho,\text{EPR}^{\otimes n}) \;\leq\; \sqrt{2\delta_\star}.
$$

### Block oracle $\mathbb{O}_\star(\varrho)$ (per‑coordinate all‑match)

**Input:** one fresh block $\varrho$ on $A^nB^n$.

**Procedure (single block):**

1. Pick a basis string $b=(b_1,\dots,b_n)\in\{Z,X\}^n$ uniformly at random.
2. For each coordinate $i$, measure $(A_i,B_i)$ in basis $b_i$.
3. Output the **failure bit**
   $$
   Y_\star = \mathbf{1}[\text{not all \(n\) pairs match their own basis}],
   $$
   i.e. $Y_\star=0$ *iff* every pair matched.

**Distribution:** $Y_\star\sim\text{Bernoulli}(\delta_\star)$, where
$$
1-\delta_\star=\frac{1}{2^n}\sum_{b\in\{Z,X\}^n}\operatorname{tr}(\Pi_b\,\varrho)
\quad\text{with}\quad
\Pi_b=\bigotimes_{i=1}^n\Pi_{b_i}^{(i)}.
$$
We will call $\mathbb{O}_\star$ once per block. Over $N$ i.i.d. blocks we get i.i.d. bits $Y_{\star,1},\dots,Y_{\star,N}$ with mean $\delta_\star$, and we estimate
$$
\hat\delta_\star=\frac{1}{N}\sum_{j=1}^N Y_{\star,j}.
$$
### Translate global promises $\bigl(D(\varrho,\Phi^{\otimes n})\bigr)$ into a gap on $\delta_\star$

We want to distinguish
$$
\mathbf H_0:\ D(\varrho,\Phi^{\otimes n}) \leq \varepsilon_1
\qquad\text{vs.}\qquad
\mathbf H_1:\ D(\varrho,\Phi^{\otimes n}) \geq \varepsilon_2,
$$
using only the block oracle above.

Two directions:
* **Soundness direction (far $\Rightarrow$ large $\delta_\star$).**
  From $D(\varrho,\Phi^{\otimes n})\le\sqrt{2\delta_\star}$ we get
  $$
  D(\varrho,\Phi^{\otimes n})\ge \varepsilon_2\ \Longrightarrow\ \delta_\star\ \ge\ \underbrace{\varepsilon_2^2/2}_{:=\ \delta^\text{far}_\star}. \quad\text{(necessary)}
  $$
* **Completeness direction (close $\Rightarrow$ small $\delta_\star$).**
  The acceptance POVM element for a block is $\overline\Pi := 2^{-n}\sum_b\Pi_b$, and $\operatorname{tr}(\overline\Pi\,\Phi^{\otimes n})=1$ (EPR matches in either basis at every coordinate). The variational/POVM inequality gives
  $$
  \bigl|\,\operatorname{tr}(\overline\Pi\,\varrho)-1\,\bigr| \le D(\varrho,\Phi^{\otimes n})
  \quad\Rightarrow\quad
  \delta_\star = 1-\operatorname{tr}(\overline\Pi\,\varrho)\ \le\ D(\varrho,\Phi^{\otimes n}).
  $$
  Hence
  $$
  D(\varrho,\Phi^{\otimes n})\le \varepsilon_1\ \Longrightarrow\ \delta_\star\ \le\ \underbrace{\varepsilon_1}_{:=\ \delta^\text{close}_\star}. \quad\text{(sufficient)}
  $$
  (Same logic we used in the single‑pair finite‑sample proof; here we just plug the block acceptance operator. )

So the promise gap is
$$
\Delta_\star := \delta^\text{far}_\star-\delta^\text{close}_\star
= \frac{\varepsilon_2^2}{2}-\varepsilon_1,
$$
and we require the condition
$$
\varepsilon_1 < \varepsilon_2^2/2 \quad(\text{or there's no gap to separate}).
$$
### Decision rule

Set
$$
t := \frac{\Delta_\star}{2}=\frac{\varepsilon_2^2-2\varepsilon_1}{4},
\qquad
c_\star := \frac{\delta^\text{close}_\star+\delta^\text{far}_\star}{2}
= \frac{2\varepsilon_1+\varepsilon_2^2}{4}.
$$

> **Rule.** After $N$ blocks, compute $\hat\delta_\star$.
> Accept “**close**” iff $\hat\delta_\star \leq c_\star$; otherwise say “**far**”.

This mirrors our cutoff $c = \frac{2\varepsilon_1+\varepsilon_2^2}{4}$ in the single-pair case.

### Correctness (conditioned on the good event)

By Hoeffding, for any $t>0$,
$$
\Pr\!\left(\,|\hat\delta_\star-\delta_\star|\geq t\,\right)\leq 2e^{-2Nt^2}.
$$
On the good event $\mathcal{G} = \left\{ |\hat\delta_\star - \delta_\star| < t \right\}$:

* If $D\le \varepsilon_1$ then $\delta_\star\le\delta^\text{close}_\star=c_\star-t$, hence $\hat\delta_\star \leq c_\star$ $\Rightarrow$ **accept**.
* If $D\ge \varepsilon_2$ then $\delta_\star\ge\delta^\text{far}_\star=c_\star+t$, hence $\hat\delta_\star > c_\star$ $\Rightarrow$ **reject**.

Thus each error happens only if the good event $\mathcal{G}$ fails.

Pick $t=(\varepsilon_2^2-2\varepsilon_1)/4$ and demand the tail $\le\alpha$:

$$
2e^{-2Nt^2}\le \alpha
\quad\Longleftrightarrow\quad
\boxed{\ N\ \ge\ \frac{8}{(\varepsilon_2^2-2\varepsilon_1)^2}\,\ln\!\frac{2}{\alpha}\ }.
$$

As a reminder, this result is fully adversarial within each block (the realistic lab setting), but assumes the source provides i.i.d. blocks across runs, so that we can estimate the block-level error rate from many independent samples. Let's package everything together cleanly.

> **Theorem.**
> 
> Let $n \geq 1$ and let $\varrho$ be any $2n$-qubit state on $A^nB^n$ (arbitrary correlations across coordinates). Fix tolerances $0 \leq \varepsilon_1 < \varepsilon_2 \leq 1$ and failure probability $\alpha \in (0,1)$ with $\varepsilon_1 < \varepsilon_2^2/2$.
> 
> Run the per‑coordinate all‑match block oracle $\mathbb{O}_\star$ on $N$ i.i.d. blocks, yielding $\hat\delta_\star$. With cutoff
> $$
c_\star = \frac{2\varepsilon_1 + \varepsilon_2^2}{4},
$$
> accept “close” iff $\hat\delta_\star \leq c_\star$.
> 
> If
> $$
N\ \geq\ \frac{8}{(\varepsilon_2^2-2\varepsilon_1)^2}\,\ln\!\frac{2}{\alpha} \qquad\Bigl(=O\bigl((\varepsilon_2^2-2\varepsilon_1)^{-2}\bigr)\Bigr),
$$
> then:
> * **Completeness.** If $D(\varrho, \Phi^{\otimes n}) \leq \varepsilon_1$, the test accepts with probability $\geq 1 - \alpha$.
> * **Soundness.** If $D(\varrho, \Phi^{\otimes n}) \geq \varepsilon_2$, the test rejects with probability $\geq 1 - \alpha$.
> * **Promise gap.** If $\varepsilon_1 < D(\varrho, \Phi^{\otimes n}) < \varepsilon_2$, no guarantee is made on the outcome; the test may go either way (accept or reject).

---

> **Corollary (hard case, non‑tolerant)**
> 
> For hypotheses $\mathbf H_0:\varrho=\Phi^{\otimes n}$ vs. $\mathbf H_1:D(\varrho,\Phi^{\otimes n}) \geq \varepsilon$, accept iff **no** block fails (i.e. $\hat\delta_\star=0$). If
> $$
N\ \geq\ \frac{2}{\varepsilon^2}\,\ln\!\frac{1}{\alpha},
$$
> then completeness is trivial and soundness holds since $\delta_\star \geq \varepsilon^2/2\Rightarrow \Pr[\text{no fail}]\leq e^{-N\varepsilon^2/2} \leq \alpha$. (Same algebra as the single‑pair corollary; we just swap in $\delta_\star$.)

---

**Extension (non-i.i.d. blocks).**

So far we assumed $N$ independent blocks of the $2n$-qubit state $\varrho$. In reality, an adversary (or a noisy source with memory) could prepare one **arbitrary joint state** across all blocks. Fortunately, our test is *non-adaptive* and *incoherent* (local $Z/X$ measurements chosen up-front), so we can apply the general reduction of Fawzi–Kueng–Markham–Oufkir (FKMO) (Theorem 2.3, arXiv:2401.16922). Their result upgrades any such i.i.d. analysis to the fully non-i.i.d. setting with only a **polylogarithmic** overhead in sample complexity. This means our clean block-level theorem remains valid even when the $N$ blocks come from a single adversarial global state, so the protocol certifies $\Phi^{\otimes n}$ under the strongest model of cross-block correlations, not just in the i.i.d. case.

> **Note.**
> * **Adaptive vs. non-adaptive** is about *when you choose the measurement*.
>
>   *Adaptive*: you let early outcomes influence later measurement choices.
>
>   *Non-adaptive*: you fix the measurement pattern up front.
> 
> * **Coherent vs. incoherent** is about *how you measure across copies*.
>
>   *Coherent*: you could apply a joint entangled measurement across several copies of the state at once (like a collective Bell measurement).
>
>   *Incoherent*: you restrict yourself to local, single-copy measurements, run independently on each copy, and then do all the combining in *classical postprocessing*.

Concretely, we appeal to FKMO Theorem 2.3, which shows that the additional overhead for dealing with across-block correlations scales only in $\log d$, where $d$ is the Hilbert space dimension of a single block. Since one block contains $2n$ qubits we have $d = 2^{2n}$ and therefore $\log d = 2n$. FKMO also give a more general reduction that works for arbitrary measurement strategies, but in that case the cost can scale polynomially in $d$. For us this would translate into a cost scaling like $2^{2n}$, which is far too large. Because our procedure is non-adaptive and incoherent, we are in the special case where the dependence collapses to $\log d$ (the overhead is only polylogarithmic in the block dimension), giving only a linear factor in $n$ rather than exponential as a result.

Let
$$
k_A \;=\; \left\lceil\, \frac{8}{(\varepsilon_2^2 - 2\varepsilon_1)^2}\,\ln \frac{12}{\alpha} \,\right\rceil
$$
denote the block complexity of our i.i.d. test (Theorem above). Note that instead of $2/\alpha$ we have $12/\alpha$; the extra factor of $6$ comes from FKMO Remark 4.10.

The reduction of FKMO (Theorem 2.3 together with the explicit constants of Remark 4.10) then guarantees that, in the fully non-i.i.d. setting, it suffices to take
$$
N \;\geq\; \frac{18^2\,\log d}{\alpha^2\,\varepsilon^2}\;k_A^2\;\log^2\left(\frac{6k_A}{\alpha}\right),
\qquad d=2^{2n},
$$

for any $\varepsilon$ chosen inside the trace-distance gap $\Delta = \varepsilon_2^2 - 2\varepsilon_1$ (e.g. $\varepsilon = \Delta/2$). Substituting $\log d = 2n$ and simplifying gives
$$
N = O\!\left[\, \frac{n}{\alpha^2\,\Delta^6}\,\Bigl(\ln\frac{1}{\alpha}\Bigr)^2\,\log^2\Bigl(\frac{1}{\alpha\,\Delta^2}\ln\frac{1}{\alpha}\Bigr) \,\right].
$$

Therefore, our tolerant identity test remains sound even against a single adversarial global source, with only a linear dependence on the block size $n$ and polylogarithmic factors in $1/\alpha$ and $1/\Delta$. The i.i.d. guarantees lift cleanly to the strongest non-i.i.d. model.
