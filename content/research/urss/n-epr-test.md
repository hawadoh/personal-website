+++
date = '2025-08-08T17:42:31+01:00'
draft = false
title = 'Classical tolerant identity test for multiple EPR states'
ShowToc = true
TocOpen = true
+++

## Change in notation
With the [tolerant identity test](../epr-tolerant-identity-testing) for a single state $\rho_{AB}$ complete, we now turn to the problem of certifying multiple ($n$) EPR pairs at once. For brevity we write $\Phi = \ket{\text{EPR}}\bra{\text{EPR}}_{AB}$ throughout, where $\ket{\text{EPR}} = \tfrac{1}{\sqrt{2}}(\ket{00} + \ket{11})$. The problem statement is as follows:

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

> **Convention.** For each basis, we relabel Bob's outcomes if needed so the mismatch rate is $\leq 1/2$ (i.e. replace $\delta_b$ by $\min \{\delta_b, 1 - \delta_b\}$). With this standard symmetrisation, the aggregated $\delta \in [0, 1/2]$ and the fidelity bound $F \geq \sqrt{1 - 2\delta}$ is always meaningful. For instance, if $\delta_Z = 0.3$ and $\delta_X = 0.7$, we relabel Bob's $X$ outcomes so $\delta_X \to 0.3$.

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
> where the constraint $\varepsilon_1 < \varepsilon_2^2 / 2$ holds. Fix the desired maximum failure probability $\alpha \in (0, 1)$. Set the cutoff
> $$
c = \frac{2\varepsilon_1 + \varepsilon_2^2}{4}.
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
N \geq \frac{8\,\ln(2/\alpha)}{(\varepsilon_2^2 - 2\varepsilon_1)^2} \qquad\left( = O\Bigl((\varepsilon_2^2 - 2\varepsilon_1)^{-2}\Bigr) \right),
$$
after running the test, the following holds:
> - **Completeness.** If $D(\varrho, \Phi) \leq \varepsilon_1$, then the test **accepts** (outputs "close") with confidence at least $1 - \alpha$.
> - **Soundness** If $D(\varrho, \Phi) \geq \varepsilon_2$, then the test **rejects** (outputs "far") with confidence at least $1 - \alpha$.
> - **Promise gap.** If $\varepsilon_1 < D(\varrho, \Phi) < \varepsilon_2$, no guarantee is made on the outcome; the test may go either way (accept or reject).

Note that we call the oracle $N$ times in this case only because $n = 1$. In general $n \geq 2$ so this is not true; the number of oracle calls is $n \cdot N$.

With the notations established and the single-pair scenario ($n = 1$) as a reference, we now turn to analysing the number of blocks needed to certify multiple EPR pairs for $n \geq 2$ as per the problem statement.

---

## do-rE-MI ♫

For brevity we write $\rho = \rho_{AB}$ throughout. When extending the single-pair protocol to $n$ pairs, it is helpful to think about the problem in terms of increasing generality:

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
   In general, $\rho_j \neq \rho_k ~\forall (j, k) \in [n]^2$ where $j < k$.

3. **Hard (arbitrary adversary).**

   The most general case allows an arbitrary $2n$-qubit state $\varrho$, possibly entangled across pairs, against which we still wish to test closeness to $\Phi^{\otimes n}$.

We will analyse $N$, the number of blocks required to decide closeness to $\Phi^{\otimes n}$, where each block is one i.i.d. copy of the $2n$-qubit state $\varrho$ that the physical source produces.

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

Our goal is to solve the hard case: testing an arbitrary $2n$-qubit state $\varrho$ that may be entangled across all pairs. A natural starting point is to begin with the easy case (where all $n$ pairs are i.i.d.), as it's both the simplest to analyse and may serve as a useful building block for more general scenarios. However, after exploring potential approaches for the easy and medium cases for a few weeks, it became clear that the most direct solution is to tackle the general (hard) case from the start. The key insight is to extend the single-pair matching projector approach to work with $n$ pairs simultaneously. This handles arbitrary adversarial entanglement without requiring product structure assumptions. We present only this general case below.

---

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

**Output:** $Y_\star \in \{ 0, 1 \}$.

---

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
  D(\varrho,\Phi^{\otimes n})\ge \varepsilon_2\ \quad\implies\quad \delta_\star\ \ge\ \underbrace{\varepsilon_2^2/2}_{=:\ \delta^\text{far}_\star}. \quad\text{(necessary)}
  $$
* **Completeness direction (close $\Rightarrow$ small $\delta_\star$).**
  The acceptance POVM element for a block is $\overline\Pi := 2^{-n}\sum_b\Pi_b$, and $\operatorname{tr}(\overline\Pi\,\Phi^{\otimes n})=1$ (EPR matches in either basis at every coordinate). The variational/POVM inequality gives
  $$
  \bigl|\,\operatorname{tr}(\overline\Pi\,\varrho)-1\,\bigr| \le D(\varrho,\Phi^{\otimes n})
  \quad\implies\quad
  \delta_\star = 1-\operatorname{tr}(\overline\Pi\,\varrho)\ \le\ D(\varrho,\Phi^{\otimes n}).
  $$
  Hence
  $$
  D(\varrho,\Phi^{\otimes n})\le \varepsilon_1\ \quad\implies\quad \delta_\star\ \le\ \underbrace{\varepsilon_1}_{=:\ \delta^\text{close}_\star}. \quad\text{(sufficient)}
  $$
  (Same logic we used in the single‑pair finite‑sample proof; here we just plug the block acceptance operator.)

So the promise gap is
$$
\Delta_\star := \delta^\text{far}_\star-\delta^\text{close}_\star
= \frac{\varepsilon_2^2}{2}-\varepsilon_1,
$$
and we require the condition
$$
\varepsilon_1 < \varepsilon_2^2/2.
$$
This condition is essential; without it, the promise gap collapses.
### Decision rule

Set
$$
t := \frac{\Delta_\star}{2}=\frac{\varepsilon_2^2-2\varepsilon_1}{4},
\qquad
c_\star := \frac{\delta^\text{close}_\star+\delta^\text{far}_\star}{2}
= \frac{2\varepsilon_1+\varepsilon_2^2}{4}.
$$

> **Rule.** After running $\mathbb{O}_\star$ on each of the $N$ blocks, compute $\hat\delta_\star$.
> Accept “**close**” ***iff*** $\hat\delta_\star \leq c_\star$; otherwise say “**far**”.

This mirrors our cutoff $c = \frac{2\varepsilon_1+\varepsilon_2^2}{4}$ in the single-pair case.

### Correctness (conditioned on the good event)

By Hoeffding, for any $t>0$,
$$
\Pr\!\left(\,|\hat\delta_\star-\delta_\star|\geq t\,\right)\leq 2e^{-2Nt^2}.
$$
On the good event $\mathcal{G} = \left\{ |\hat\delta_\star - \delta_\star| < t \right\}$:

* If $D \leq \varepsilon_1$ then $\delta_\star \leq\delta^\text{close}_\star = c_\star-t$, hence $\hat\delta_\star \leq c_\star$ $\Rightarrow$ **accept**.
* If $D \geq \varepsilon_2$ then $\delta_\star \geq\delta^\text{far}_\star = c_\star+t$, hence $\hat\delta_\star > c_\star$ $\Rightarrow$ **reject**.

Thus each error happens only if the good event $\mathcal{G}$ fails.

Pick $t = (\varepsilon_2^2-2\varepsilon_1) / 4$ and demand the tail $\leq \alpha$:

$$
2e^{-2Nt^2} \leq \alpha
\quad\Longleftrightarrow\quad
\boxed{\ N\ \geq\ \frac{8\,\ln(2/\alpha)}{(\varepsilon_2^2 - 2\varepsilon_1)^2}\ }.
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
> accept “close” ***iff*** $\hat\delta_\star \leq c_\star$.
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

## Extensions/implications

### Non-i.i.d. blocks

So far we assumed $N$ independent blocks of the $2n$-qubit state $\varrho$. In reality, an adversary (or a noisy source with memory) could prepare one **arbitrary joint state** across all blocks. Fortunately, our test is *non-adaptive* and *incoherent* (local $Z/X$ measurements chosen up-front), so we can apply the general reduction of [Fawzi–Kueng–Markham–Oufkir (2024)](https://arxiv.org/pdf/2401.16922) (FKMO) (Theorem 2.3). Their result upgrades any such i.i.d. analysis to the fully non-i.i.d. setting with only a **polylogarithmic** overhead in sample complexity. This means our clean block-level theorem remains valid even when the $N$ blocks come from a single adversarial global state, so the protocol certifies $\Phi^{\otimes n}$ under the strongest model of cross-block correlations, not just in the i.i.d. case.

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

Therefore, our tolerant identity test remains sound even against a single adversarial global source, with only a linear dependence on the block size $n$ and polylogarithmic factors in $1/\alpha$ and $1/\Delta$. The i.i.d. guarantees lift cleanly to the strongest non-i.i.d. model. Next, we analyse whether our test is *noise-tolerant*.

### Noise tolerance

In realistic experiments, the shared state between Alice and Bob will never be perfectly maximally entangled. Each EPR pair may suffer small local imperfections due to imperfect gates, decoherence, or misaligned measurements. Intuitively, we say the source is *noisy* when every pair is slightly "off" from the ideal EPR state by a small, fixed amount.

Formally, we can model this by assuming that each pair is described by a mixed state
$$
\rho = (1-\nu)\,\Phi + \nu\,\tau,
$$
where $\Phi = \ket{\text{EPR}}\!\bra{\text{EPR}}$ is the ideal state, $\tau$ is an arbitrary bipartite noise state, and $\nu\in[0,1]$ quantifies the *noise rate*.

A source producing $n$ such pairs therefore prepares
$$
\rho^{\otimes n} = ((1-\nu)\,\Phi + \nu\,\tau)^{\otimes n},
$$
representing an *independent*, constant per-copy noise rate.

A sound and noise-tolerant test should meet two conditions:

1. (**Soundness**) Passing the test should imply that the underlying shared state contains *non-trivial entanglement* - for example, that the total entanglement scales linearly with $n$, or that each pair is on average close to $\Phi$.
2. (**Noise tolerance**) The test should still accept imperfect sources that are consistent and *locally noisy* (with fixed $\nu > 0$), rather than rejecting them exponentially fast as the number of pairs $n$ increases.

In other words, noise tolerance means that the test shouldn't become useless just because every supposedly-EPR pair in $\rho^{\otimes n}$ is 99% good instead of 100%. The acceptance probability should remain high under such constant local imperfections, instead of dropping off exponentially with system size.

In this 2018 [paper](https://drops.dagstuhl.de/storage/00lipics/lipics-vol107-icalp2018/LIPIcs.ICALP.2018.11/LIPIcs.ICALP.2018.11.pdf) by Rotem Arnon-Friedman and Henry Yuen, they pointed out that many robust self-tests guarantee soundness but fail the second property (they are not noise-tolerant). This is because traditional self-testing results express closeness in fidelity, and fidelity is multiplicative under tensor products:
$$
F(\rho^{\otimes n}, \Phi^{\otimes n}) = F(\rho, \Phi)^n,
$$
meaning that if each pair has fidelity $F(\rho, \Phi) = 1 - \nu$, then
$$
F(\rho^{\otimes n}, \Phi^{\otimes n}) = (1 - \nu)^n \approx e^{-\nu n}.
$$
Even for a modest $\nu = 0.01$ (only a 1% noise per pair), the total fidelity drops below $0.05$ when $n \approx 300$.
This exponential decay means that self-tests based on global fidelity will reject any state with constant local noise, no matter how large $n$ is. In other words, for a test, **robustness in fidelity does not imply noise-tolerance**.

Arnon-Friedman and Yuen proposed a solution in the paper by shifting from fidelity to **threshold acceptance**; instead of requiring global fidelity close to one, they design tests that accept if the average win rate exceeds a fixed threshold.

Formally, for **any** two-player game $G$ with a classical-quantum value gap $\Delta > 0$ (the advantage in winning probability that quantum strategies achieve over all classical ones, i.e. $\Delta = \text{qval}(G) - \text{cval}(G)$), the verifier plays $n$ independent copies and accepts if the observed win fraction is at least
$$
\text{qval}(G) - \nu,
$$
for some noise parameter $0 \leq \nu < \Delta$. A key result presented was Theorem 1, where they showed:

* (**Noise tolerance**) If the provers' per-copy success probability is $\text{qval}(G) - \eta$ (for $\eta < \nu)$, then they pass the threshold test with probability $1 - \exp(-\Omega((\nu - \eta)^2 n))$. Constant per-copy noise only reduces the acceptance probability by an exponentially small amount.
* (**Soundness**) Any strategy passing with non-negligible probability must share a state whose *entanglement of formation* (a measure of entanglement) scales as $\Omega(n)$ (linear in $n$).

This shows that a classical test **can** be both sound and noise-tolerant, provided acceptance is defined in terms of an *additive* threshold rather than a global multiplicative metric.

This additive viewpoint aligns naturally with our tolerant identity test, which is expressed in trace distance. As a reminder, it is *subadditive* under tensor products:
$$
\bigl\|\rho^{\otimes n} - \Phi^{\otimes n}\bigr\|_1 ~\leq~ n\,\bigl\|\rho - \Phi\bigr\|_1,
$$
meaning that small, constant per-copy imperfections accumulate linearly rather than exponentially. So one might hope our test inherits noise tolerance from this property. There are two problems though.

Firstly, AFY's theorem is stated for games with a classical-quantum gap $\Delta = \mathrm{qval}(G) - \mathrm{cval}(G) > 0$. In our setting we are running a classical sequential test (no entangled provers/game), so there is no such gap parameter to even define! (Effectively $\Delta = 0$ for us.)

Moreover, although our analysis uses trace distance, which is subadditive, what matters for noise tolerance is the *acceptance criterion*, not just the distance measure. Our current oracle $\mathbb{O}_\star$ uses a *multiplicative* acceptance rule within each block:

> $Y_\star = 0$ if and only if <u>***all***</u> $n$ pairs within the block match their respective bases.

Under the noise model $\rho = (1-\nu)\Phi + \nu\tau$ per pair, each pair independently matches with probability $1-\nu$. The probability that all $n$ pairs match is therefore $(1-\nu)^n \approx e^{-n\nu}$.

The problem is that requiring **all** $n$ pairs within each block to match means
$$
\Pr[\text{block passes}] = (1-\nu)^n \xrightarrow{n \to \infty} 0.
$$
Even if each pair matches with high probability (say $1-\nu = 0.9999$), for large $n$ we have $(0.9999)^n \to 0$. This means almost every block will fail ($Y_\star = 1$), driving $\hat{\delta}_\star \to 1$. As the block size $n$ grows, the test will reject regardless of the threshold $c_\star < 1$. This is exactly the multiplicative collapse that plagues fidelity-based tests! Unfortunately, the test as currently stated is **NOT** noise-tolerant.

So, while the state $\rho^{\otimes n}$ remains reasonably close to $\Phi^{\otimes n}$ as trace distance grows at most linearly with $n$, our all-or-nothing acceptance rule causes the test to reject it as acceptance probability decays exponentially with $n$. To make our test noise-tolerant, we can modify the acceptance criterion n the block oracle $\mathbb{O}_\star$ to tolerate some fraction of failing pairs:

> Accept a block if at least $(1 - \gamma)n$ pairs match, for some $0 < \gamma \ll 1$.

This is the only change needed. Our test procedure remains the same:
- run the modified oracle $\mathbb{O}'_\star$ on each of the $N$ blocks,
- compute $\hat\delta_\star = \tfrac{1}{N} \sum_{j=1}^N Y_{\star, j}$,
- accept ***iff*** $\hat\delta_\star \leq c_\star$.

**Choosing $\gamma$ for noise tolerance.** To tolerate noise rate $\nu$, we set $\gamma > \nu$ with a sufficient gap. Let $M$ denote the number of matching pairs in a block. Under the noise model, $\mathbb{E}[M] = n(1-\nu)$. By Hoeffding's inequality,
$$
\Pr[M < (1-\gamma)n] = \Pr\left[\frac{M}{n} < \mathbb{E}[M/n] - (\gamma - \nu)\right] \leq \exp\bigl(-2n(\gamma-\nu)^2\bigr).
$$
Thus, if $\gamma > \nu$, the probability that a block fails decays **exponentially** with $n$. For large $n$, each block passes with probability $\approx 1 - \exp(-2n(\gamma-\nu)^2) \approx 1$. This **additive** threshold condition requires only a $(1-\gamma)$ fraction of pairs to match rather than all pairs, so we've broken out of the multiplicative collapse. The concentration ensures that as $n$ grows, blocks become *more* reliable, not less, achieving noise tolerance.

### Future work

Our protocol currently tests whether $\varrho$ is close to the **specific** maximally entangled state $\Phi^{\otimes n} = \ket{\text{EPR}}\!\bra{\text{EPR}}^{\otimes n}$. A straightforward extension is to test closeness to any **specified** maximally entangled state $\Phi_U^{\otimes n}$, where $\Phi_U = (\mathbb{I} \otimes U)\ket{\Phi}\!\bra{\Phi}(\mathbb{I} \otimes U^\dagger)$ for some <u>known</u> unitary $U \in U(2)$. This is trivial because
$$
D\big(\varrho,\Phi_U^{\otimes n}\big)
= D\big((\mathbb{I} \otimes U^\dagger)^{\otimes n}\varrho\,(\mathbb{I} \otimes U)^{\otimes n}\ ,\ \Phi^{\otimes n}\big),
$$
so Bob can simply apply $U^\dagger$ locally before running the original protocol.

However, one might ask the more general question: *How close is $\varrho$ to being maximally entangled?* That is, what is the distance to its **closest** maximally entangled state
$$
\min_{U \in U(2)} \left[\,D(\varrho, \Phi_U^{\otimes n})\,\right]
$$
where $U$ is not known? To test this tolerantly against thresholds $0 \leq \varepsilon_1 < \varepsilon_2 \leq 1$, one approach would use an $\epsilon$-covering net $\mathcal{U} \subseteq U(2)$ and run our protocol for each $U \in \mathcal{U}$. However, whether this can be done efficiently, i.e., in parallel (and while preserving noise-tolerance), requires more work. :)
