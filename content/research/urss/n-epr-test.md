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
> Given two trace distance tolerances $0 \leq \varepsilon_1 < \varepsilon_2 \leq 1$, a failure probability $\alpha \in [0, 1]$, and $N$ i.i.d. copies of an unknown $2n$-qubit global state $\varrho$ on $A^n B^n$ i.e. the source produces $\varrho^{\otimes N}$, how large must $N$ at least be so that, using only local $Z$/$X$ measurements and classical postprocessing, we can decide with at least confidence $1 - \alpha$ whether
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
the following holds:
> - **Completeness.** If $D(\rho_{AB}, \ket{\text{EPR}} \bra{\text{EPR}}_{AB}) \leq \varepsilon_1$, then the test **accepts** (outputs "close") with confidence at least $1 - \alpha$.
> - **Soundness** If $D(\rho_{AB}, \ket{\text{EPR}} \bra{\text{EPR}}_{AB}) \geq \varepsilon_2$, then the test **rejects** (outputs "far") with confidence at least $1 - \alpha$.
> - **Promise gap.** If $\varepsilon_1 < D(\rho_{AB}, \ket{\text{EPR}} \bra{\text{EPR}}_{AB}) < \varepsilon_2$, no guarantee is made on the outcome; the test may go either way (accept or reject).

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
> By proving security in each model, starting with the easiest and working up to the fully coherent setting, we obtain a hierarchy of BB84 security guarantees that mirror the increasing power of potential attack by Eve. ~From the sample complexity, we will see that a fully coherent attack (hard case) isn't too much more difficult to detect than a simple i.i.d. tensor product state (easy case)!~ `<- not sure about this yet`

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

**What about completeness?** 
We will soon see that the proof for completeness (avoiding **false rejects** of close states) is not a *deterministic* guarantee, but a *statistical* one. It's the promise that if you are given a good state, your experiment will correctly identify it with very high confidence $1 - \alpha$. This guarantee comes from the power of the Chernoff-Hoeffding concentration bound, and we will see the full reasoning below.

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

> **Convention.** For each basis, we relabel Bob's outcomes if needed so the mismatch rate is $\leq 1/2$ (i.e. replace $\delta_b$ by $\min \{\delta_b, 1 - \delta_b\}$). With this standard symmetrisation, the aggregated $\delta \in [0, 1/2]$ and the bound $F_1 \geq \sqrt{1-2\delta}$ is always meaningful.

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

After running the protocol and computing the empirical mismatch rate $\hat\delta$ on the matching-basis rounds $S$, we define the decision rule ass
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
As before, only about half of the $N$ rounds in the original protocol are matching-basis. We can do something similar for the reformulated protocol with oracle calls and classical postprocessing. Let $T := nN$ be the total number of single‑pair measurements (oracle calls). Since a call has matching bases with probability $1/2$, a Chernoff bound shows that choosing $T = 4|S|$ (equivalently, $N = 4|S|/n$ blocks) makes the event of getting fewer than $|S|$ matches have probability at most $e^{-|S|/4}$, which is negligibly small for moderate $|S|$. Taking $N = 4|S|$,
$$
N ~\geq~ \frac{32\,n}{\left( \varepsilon_2^2 - \varepsilon_1^2 \right)^2}\,\ln\!\frac{2}{\alpha} \qquad\left[= O\left(n^2\left(\varepsilon_2^2 - \varepsilon_1^2\right)^{-2}\right)\right].
$$

So it turns out that extending the test from a single pair to $n$ i.i.d. pairs is **not** free: the price is a quadratic blow-up in sample complexity, which is intuitive and expected when you consider the difference in the guarantees. Certifying that the *entire collection* of $n$ states is globally $\varepsilon$-close is a much stricter requirement than certifying a single state. This is because a tiny imperfection in each pair, when compounded over the tensor product of all $n$ states, can result in a large global deviation. To compensate for this, the required fidelity of each pair must be much higher. This in turn forces the promise gap $\Delta_\delta$ for the true error rate $\delta$ to become approximately $n$ times narrower, squeezing the thresholds for "close" and "far" states into a much smaller window near zero.

The reason for this is that our promise is about the **global state** ($\varrho$) of all $n$ pairs. For the global state to be nearly perfect (i.e. have a high global fidelity $F_n = F_1^n$), the fidelity of each **single pair** ($F_1$) must be extremely close to $1$. Since the true error rate $\delta$ is a direct measure of the imperfection in a single pair, this extremely high fidelity requirement forces $\delta$ to be (comparatively) much smaller than it would be in the single-pair test. As a result, this effectively "squeezes" the entire range of relevant error rates into a tiny window near zero, which makes the absolute gap between our $\delta_{\text{close}}$ and $\delta_{\text{far}}$ thresholds narrower.

A core principle of statistics is that the uncertainty of an estimated average is proportional to the inverse square root of the number of samples (in our case, this is $1 / \sqrt{|S|}$). To reliably measure a promise gap that is $n$ times smaller, our estimate for $\Delta_\delta$ must be $n$ times more precise. Achieving this $n$-fold increase in precision requires an $n^2$-fold increase in the number of samples, which leads directly to the $O(n^2)$ scaling in complexity we're seeing. Putting everything together succinctly:

> **Theorem (Finite-sample tolerant EPR identity test, i.i.d. product version).**
> 
> For brevity, write
> $$
\rho = \rho_{AB},\qquad \Phi = \ket{\text{EPR}}\bra{\text{EPR}}_{AB}.
$$
> Fix $n \geq 2$. There are two i.i.d. notions here, and we use both:
> 1. Within-state (coordinate-wise) i.i.d. - the global hypotheses are tensor powers $\rho^{\otimes n}$ vs. $\Phi^{\otimes n}$ (identical across the $n$ coordinates);
> 2. Across-trials (time-wise) i.i.d. - each call to the oracle $\mathbb{O}(\rho)$ uses a fresh, independent preparation of $\rho$.
>
> Fix global trace-distance tolerances $0 \leq \varepsilon_1 < \varepsilon_2 \leq 1$ and confidence $1 - \alpha$. Define
> $$
\begin{aligned}
&f(\varepsilon) = \frac{1}{2}\!\left[1 - (1 - \varepsilon^2)^{1/n}\right]&,&
&\delta_{\text{close}} = f(\varepsilon_1),
\\[10pt]&\delta_{\text{far}} = f(\varepsilon_2)&,&
\qquad &\kappa = \frac{\delta_{\text{close}} + \delta_{\text{far}}}{2}.
\end{aligned}
$$
> Make
> $$
N ~\geq~ \frac{32\,n^2}{\left( \varepsilon_2^2 - \varepsilon_1^2 \right)^2}\,\ln\!\frac{2}{\alpha}
\qquad\left[= O\left(n^2\left(\varepsilon_2^2 - \varepsilon_1^2\right)^{-2}\right)\right]
$$
> independent calls to $\mathbb{O}(\rho)$, and compute the observed error rate $\hat{\delta}$. Let the decision rule be to accept ***iff*** $\hat{\delta} \leq \kappa$. Then, with sample cost $N$:
> - If $D(\rho^{\otimes n},\Phi^{\otimes n}) \leq \varepsilon_1$, the test accepts with probability $\geq 1 - \alpha$.
> - If $D(\rho^{\otimes n},\Phi^{\otimes n}) \geq \varepsilon_2$, the test rejects with probability $\geq 1 - \alpha$.
> - If $\varepsilon_1 < D(\rho^{\otimes n},\Phi^{\otimes n}) < \varepsilon_2$, no guarantee is provided; the test may accept or reject.

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

Let's get started. First, we organise repeated i.i.d. copies of the *entire* $n$-tuple into *blocks*. Note that in the medium case (in fact, for all three cases) we are still given i.i.d. copies of
$$
\varrho = \rho_1 \otimes \rho_2 \otimes \cdots \otimes \rho_n,
$$
but within $\varrho$, the individual $\rho_i$ may be different.

> **Definition (block).**
> A *block* is one i.i.d. copy of the product state
> $$
\varrho = \rho_1 \otimes \rho_2 \otimes \cdots \otimes \rho_n.
$$

In other words, a block is the basic unit of data for the $n$-pair test: after preparing a block, we make independent calls to the single-pair oracle $\mathbb{O}$ on *each* coordinate $i = 1, \dots, n$. The block then outputs
$$
\bigl\{ (M_{(j, i)},\,Y_{(j, i)}) \bigr\}_{i=1}^n,
$$
where $j$ indexes the block. Explicitly, in block $j$ we obtain for each coordinate $i$:

- a matching indicator $M_{(j, i)} \in \{0, 1\}$, which is $1$ if Alice's and Bob's bases matched for that pair;
- and, if $M_{(j, i)} = 1$, a mismatch bit $Y_{(j, i)} \in \{0, 1\}$ with $\mathbb{E}[Y_{(j,i)} \mid M_{(j,i)} = 1] = \delta_i$.

We repeat this procedure over $R$ independent blocks. The entire dataset forms an $R \times n$ table:
$$
\begin{array}{c|cccc}
\text{block } j & i=1 & i=2 & \cdots & i=n \\ \hline
1 & (M_{(1,1)}, Y_{(1,1)}) & (M_{(1,2)}, Y_{(1,2)}) & \cdots & (M_{(1,n)}, Y_{(1,n)}) \\
2 & (M_{(2,1)}, Y_{(2,1)}) & (M_{(2,2)}, Y_{(2,2)}) & \cdots & (M_{(2,n)}, Y_{(2,n)}) \\
\vdots & \vdots & \vdots & \ddots & \vdots \\
R & (M_{(R,1)}, Y_{(R,1)}) & (M_{(R,2)}, Y_{(R,2)}) & \cdots & (M_{(R,n)}, Y_{(R,n)})
\end{array}
$$

where each cell comes from a single call to $\mathbb{O}(\rho_i)$. In total, we have made $N = n \cdot R$ calls to the oracle. In this table:

- **Rows** (fixed $j$): contain all $n$ coordinates in the same block, prepared together as one copy of $\varrho$. The $\rho_i$ can be different, so entries in the same row are generally *not* identically distributed.
- **Columns** (fixed $i$): contain the same coordinate across $R$ i.i.d. blocks. These entries *are* i.i.d. samples from $\rho_i$, since each block contains a fresh copy of it in position $i$.

Therefore, when analysing each coordinate ($i$) separately, the $R$ entries in a column are independent and identically distributed. The union bound will later account for all $n$ coordinates at once.

### Per-coordinate estimator and decision rule

For each coordinate $i$, define the set of matching-basis rounds across blocks (columns)
$$
S_i := \{\, j \in \{1, \dots, R\} : M_{(j, i)} = 1 \,\}.
$$

The empirical mismatch rate on coordinate $i$ is
$$
\hat\delta_i ~=~ \frac{1}{|S_i|} \sum_{j \in S_i} Y_{(j, i)} \quad\text{(defined when }|S_i| > 0\text{)}.
$$

Recall the per-coordinate true parameters $\delta_i = \Pr[\text{mismatch} \mid \text{match on }i]$.

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

> **Decision rule (medium case).**
>
> Accept ***iff***
> $$
\max_{i \in [n]} \hat\delta_i < \kappa.
$$

In other words, we accept if and only if the worst-case error rate is strictly less than our cutoff $\kappa$, meaning all our error rates $\hat\delta_i$ has to pass the cutoff test.

Define the **good event**
$$
\mathcal G ~:=~ \bigcap_{i=1}^n \left\{\,|\hat\delta_i - \delta_i| < t\,\right\},
$$
i.e. *every* column concentrates within the margin $t$. We will set $R$ (hence total oracle calls $N = nR$) so that $\Pr[\mathcal G] \geq 1 - \alpha$ using concentration bounds.

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
\max_i \hat\delta_i \geq \hat\delta_{i^\star} > \kappa,
$$
and we reject.

So all we owe now is to make the *good event* $\mathcal{G}$ hold with probability at least $1 - \alpha$ using a concentration bound.

---

### Concentration: all coordinates at once
`Complete writeup`


---

> **Theorem (Finite-sample tolerant test, medium case)**
> 
> Let $\varrho = \rho_1 \otimes \cdots \otimes \rho_n$. Fix $0 \leq \varepsilon_1 < \varepsilon_2 \leq 1$ and failure probability $\alpha \in (0, 1)$.
> Define
> $$
\begin{aligned}
&f(\varepsilon) = \frac{1}{2}\!\left[1 - (1 - \varepsilon^2)^{1/n}\right]&,&
&\delta_{\text{close}} = f(\varepsilon_1),
\\[10pt]&\delta_{\text{far}} = f(\varepsilon_2)&,&
\qquad &\kappa = \frac{\delta_{\text{close}} + \delta_{\text{far}}}{2}.
\end{aligned}
$$
> Repeat $R$ times: prepare one block (index $j$), and for each coordinate $i \in [n]$ make one call to $\mathbb{O}(\rho_i)$, yielding $(M_{(j,i)},Y_{(j,i)})$.
> For each $i$, let $S_i = \{j: M_{(j, i)} = 1\}$ and compute
> $$
\hat\delta_i = \frac{1}{|S_i|} \sum_{j\ in S_i} Y_{(j, i)} \qquad(|S_i| > 0).
$$
> In total we have called the oracle $N$ times. For the test, accept ***iff***
$$
\max_{i \in [n]} \hat\delta_i < \kappa.
$$
> 
> If the sample complexity
> $$
R ~=~ \frac{32\,n^{2}}{(\varepsilon_2^2 - \varepsilon_1^2)^2}\,\ln\!\frac{4n}{\alpha}
\quad\iff\quad
N = nR ~\geq~ \frac{32\,n^3}{(\varepsilon_2^2-\varepsilon_1^2)^2}\,\ln\!\frac{4n}{\alpha},
$$
> then:
>
> - (**Completeness**) If $D(\varrho, \Phi^{\otimes n}) \leq \varepsilon_1$, then the test accepts with probability at least $1 - \alpha$.
> - (**Soundness**) If $D(\varrho, \Phi^{\otimes n}) \geq \varepsilon_2$, the test rejects with probability at least $1 - \alpha$.
> - No guarantee can be made in the promise gap $\varepsilon_1 < D(\varrho, \Phi^{\otimes n}) < \varepsilon_2$; the test may accept or reject.

---

**A quick sanity check (why it’s costlier than the i.i.d. case):**
The global closeness promise forces *every* coordinate’s fidelity to be extremely high. That squeezes each per-coordinate mismatch threshold to a gap of width $\Delta_\delta=\Theta\big((\varepsilon_2^2-\varepsilon_1^2)/n\big)$. Estimating $n$ such parameters *uniformly* within that tiny gap costs $\tilde\Theta(n^2)$ matching samples **per coordinate** (hence $R=\tilde\Theta(n^2)$ blocks) and therefore $N=nR=\tilde\Theta(n^3)$ total oracle calls, with the extra $\ln n$ from the union bound across coordinates.