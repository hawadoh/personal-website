+++
date = '2025-08-03T23:35:49+01:00'
draft = false
title = 'Classical Tolerant Identity Test for the EPR State'
ShowToc = true
TocOpen = true
+++

**Goal.** Certify that an unknown bipartite state $\rho_{AB}$ held by Alice and Bob is within trace‑distance $\varepsilon$ of
$$
\ket{\text{EPR}}_{AB} = \frac1{\sqrt2}\left(\ket{00}_{AB} + \ket{11}_{AB}\right),
$$
using only *sequential\** (one qubit at a time), local measurements in the **standard** ($\{ \ket{0}, \ket{1} \}$) or **Hadamard** ($\{ \ket{+}, \ket{-} \}$) bases, and classical communication. Importantly, we never perform any joint or Bell‐basis measurement on $AB$.

---

## Matching‑outcomes protocol

Alice and Bob share $N$ independent copies of an unknown state $\rho_{AB}$.  For each copy $i = 1, \dots, N$, they do the following *in sequence\**:
1. **Basis choice:**
   * Alice picks $\theta_i \in \{ 0, 1 \}$ uniformly at random.
   * Bob picks $\tilde{\theta}_i \in \{ 0, 1 \}$ uniformly at random.

    Here $\theta_i = 0$ means "standard basis" and $\theta_i = 1$ means "Hadamard basis".
2. **Local measurement:**
   * Alice measures her qubit in basis $\theta_i$ to get outcome $x_i \in \{ 0, 1 \}$.
   * Bob measures his qubit in basis $\tilde\theta_i$, obtaining $\tilde x_i \in \{ 0, 1 \}$.

> **Remark.** The sequential ordering is purely a hardware convenience and *not* a theoretical requirement: it guarantees that no quantum memory or parallel measurement modules are ever needed. If you already have $N$ measurement setups and don't mind operating them in parallel, you may instead prepare all bases at once, measure in parallel, and only then exchange classical data. Both versions give the same statistical bound.

> **Note.** Apart from the one-off preparation/distribution of the shared state $\rho_{AB}$, there is no need for any further quantum channel or quantum memory; Alice and Bob simply perform immediate local measurements.

After all $N$ rounds, Alice and Bob publicly reveal their basis strings $\theta = (\theta_1, \dots, \theta_N)$ and $\tilde{\theta} = (\tilde{\theta}_1, \dots, \tilde{\theta}_N)$, and their outcome strings $x = (x_1, \dots, x_N)$, $\tilde{x} = (\tilde{x}_1, \dots, \tilde{x}_N)$ over a classical authenticated channel (CAC).

Define the concordant set $$S = \{i : \theta_i = \tilde\theta_i\}.$$On each $i\in S$, Alice and Bob measured in the *same* basis. If by rare chance $S = \varnothing$ (no matching bases at all), simply rerun the whole protocol as the probability of $S = \varnothing$ is $2^{-N}$, which is negligible for modest $N$.

Compute the **observed error rate**
$$
  \hat{\delta} = \frac{1}{|S|}\,\left|\{\,i\in S : x_i \neq \tilde x_i\}\right|.
$$
which represents the non-matching fraction of the results.

---

## Asymptotic bound

**Motivating question.**
Can we really conclude that, if the *classical* matching-outcomes test in the protocol above succeeds with high probability (i.e. a small observed error $\hat{\delta}$), then the *quantum* state $\rho_{AB}$ must be close to an ideal EPR pair, *without ever* performing a joint or Bell-basis measurement?

We'll first analyse the idealised, infinite-round limit $N\to\infty$ to see theoretically why a high success rate forces high fidelity to $\ket{\text{EPR}}$. After that, we'll return to the realistic, finite-sample setting to turn this into a practical protocol in the next section.

> **Remark.** For very large $N$, the observed matching and mismatch rates concentrate so tightly around the true error parameter $\delta$ (by the law of large numbers) that we can replace all finite‐sample quantities ($\hat{\delta}$) with $\delta$ itself when deriving the asymptotic bound, making our theoretical analysis easier.

Recall that:
- The *fidelity* between a state $\rho$ and a pure state $\ket{\psi}$ is defined as
$$
F\left(\rho, \ket{\psi}\right) := \sqrt{\bra{\psi}\,\rho\,\ket{\psi}}.
$$
- The *trace distance* between two states $\rho$ and $\sigma$ is defined as
$$
D(\rho,\sigma) := \frac{1}{2}\|\rho - \sigma\|_1.
$$

**Lemma.** Let $\rho_{AB}$ be a bipartite state where $A$ and $B$ are each systems of a single qubit. The probability of Alice and Bob getting matching outcomes (`00` or `11`) when they both measure in the standard basis ($Z$) is given by $\text{tr}(\Pi_1\,\rho_{AB})$, where 
$$
\ket{\text{EPR}} = \ket{\Psi_{00}} = \frac{1}{\sqrt{2}}(\ket{00} + \ket{11}), \qquad \ket{\Psi_{01}} = \frac{1}{\sqrt{2}}(\ket{00} - \ket{11}),
$$
and
$$
\Pi_1 = \ket{\text{EPR}} \bra{\text{EPR}} + \ket{\Psi_{01}} \bra{\Psi_{01}}.
$$
Similarly, the probability of Alice and Bob getting matching outcomes (`++` or `--`) when they both measure in the Hadamard basis ($X$) is given by $\text{tr}(\Pi_2\,\rho_{AB})$, with
$$
\ket{\Psi_{10}} = \frac{1}{\sqrt{2}}(\ket{01} + \ket{10}),
$$
and
$$
\Pi_2 = \ket{\text{EPR}} \bra{\text{EPR}} + \ket{\Psi_{10}} \bra{\Psi_{10}}.
$$

**Proof.**
The probability of matching outcomes,
$$
\begin{aligned}
\Pr(\text{match}_{Z}) &= \Pr(00) + \Pr(11)
\\&= \text{tr}(M_{00} + M_{11}) &\text{by Born rule}
\\&= \text{tr}(\ket{00}\bra{00}\,\rho_{AB}) + \text{tr}(\ket{11}\bra{11}\,\rho_{AB}) &\text{by def. of POVM operator}
\\&= \text{tr}(\bra{00}\,\rho_{AB}\,\ket{00}) + \text{tr}(\bra{11}\,\rho_{AB}\,\ket{11}) &\text{by cyclicity of trace}
\\&= \bra{00}\,\rho_{AB}\,\ket{00} + \bra{11}\,\rho_{AB}\,\ket{11} &\text{as trace of scalar = itself.}
\end{aligned}
$$
Expanding $\Pi_1$ we get
$$
\begin{aligned}
\Pi_1 &= \ket{\text{EPR}} \bra{\text{EPR}} + \ket{\Psi_{01}} \bra{\Psi_{01}}
\\&=\tfrac{1}{2}(\ket{00}\bra{00} + \ket{00}\bra{11} + \ket{11}\bra{00} + \ket{11}\bra{11} 
\\&\qquad+ \ket{00}\bra{00} - \ket{00}\bra{11} - \ket{11}\bra{00} + \ket{11}\bra{11})
\\&= \tfrac{1}{2}(2\ket{00}\bra{00} + 2\ket{11}\bra{11})
\\&= \ket{00}\bra{00} + \ket{11}\bra{11}.
\end{aligned}
$$

Then
$$
\begin{aligned}
\text{tr}(\Pi_1\,\rho_{AB}) &= \text{tr}(\,(\ket{00}\bra{00} + \ket{11}\bra{11})\,\rho_{AB}) &\text{by def. of }\Pi_1
\\&= \text{tr}(\ket{00}\bra{00}\,\rho_{AB}) + \text{tr}(\ket{11}\bra{11}\,\rho_{AB}) &\text{by linearity of trace}
\\&= \text{tr}(\bra{00}\,\rho_{AB}\,\ket{00}) + \text{tr}(\bra{11}\,\rho_{AB}\,\ket{11}) &\text{by cyclicity of trace}
\\&= \bra{00}\,\rho_{AB}\,\ket{00} + \bra{11}\,\rho_{AB}\,\ket{11} &\text{as trace of scalar = itself.}
\end{aligned}
$$
Hence $\Pr(\text{match}_Z) = \text{tr}(\Pi_1\,\rho_{AB})$ as required.

Similarly, for the measurement of systems $A$ and $B$ is performed in the Hadamard basis, we can first perform a change in basis and simplify $\Pi_2$. Recall that
$$
\ket{0}=\frac1{\sqrt2}(\ket{+}+\ket{-}),\qquad
\ket{1}=\frac1{\sqrt2}(\ket{+}-\ket{-}).
$$

Then
$$
\begin{aligned}
\ket{\text{EPR}} &= \frac{1}{\sqrt2}(\ket{00}+\ket{11})
\\&= \frac{1}{\sqrt2}\left(
\frac{\ket{+}+\ket{-}}{\sqrt2}\otimes\frac{\ket{+}+\ket{-}}{\sqrt2} + \frac{\ket{+}-\ket{-}}{\sqrt2}\otimes\frac{\ket{+}-\ket{-}}{\sqrt2}
\right)
\\&= \frac{1}{\sqrt2}\bigl(\ket{++}+\ket{--}\bigr).
\end{aligned}
$$

Similarly one can easily verify
$$
\ket{\Psi_{10}}
= \frac{1}{\sqrt2}(\ket{01} + \ket{10})
= \frac{1}{\sqrt2}\bigl(\ket{++} - \ket{--}\bigr).
$$

Expanding $\Pi_2$ we get
$$
\begin{aligned}
\Pi_2 &= \tfrac{1}{2}(\ket{++}\bra{++} + \ket{++}\bra{--} + \ket{--}\bra{++} + \ket{--}\bra{--} 
\\&\qquad+ \ket{++}\bra{++} - \ket{++}\bra{--} - \ket{--}\bra{++} + \ket{--}\bra{--})
\\&= \tfrac{1}{2}(2\ket{++}\bra{++} + 2\ket{--}\bra{--})
\\&= \ket{++}\bra{++} + \ket{--}\bra{--}.
\end{aligned}
$$

Finally, by exactly the same Born-rule steps as above (now applied in the Hadamard basis), we have:
$$
\Pr(\text{match}_X) = \text{tr}(\ket{++}\bra{++}\,\rho_{AB}) + \text{tr}(\ket{--}\bra{--}\,\rho_{AB}) = \text{tr}(\Pi_2\,\rho_{AB}). \tag*{$\square$} $$

Now suppose that $\rho_{AB}$ is any state such that
$$
\underbrace{\frac{1}{2}\,\text{tr}\bigl(\Pi_1\,\rho_{AB}\bigr)}_{\substack{\text{matching outcomes}\\\text{in standard (Z) basis}}}
\;+\;
\underbrace{\frac{1}{2}\,\text{tr}\bigl(\Pi_2\,\rho_{AB}\bigr)}_{\substack{\text{matching outcomes}\\\text{in Hadamard (X) basis}}}
\;\geq\;
\underbrace{1 - \delta}_{\substack{\text{overall success}\\\text{probability}}}
\tag{$*$}
$$
for some $\delta \geq 0$.

Imagine we're measuring $\rho_{AB}$ in the Bell basis $\{ \ket{\Psi_{00}}, \ket{\Psi_{01}}, \ket{\Psi_{10}}, \ket{\Psi_{11}} \}$ (where $\ket{\text{EPR}} = \ket{\Psi_{00}}$). The measurement has four possible outcomes, corresponding to the four Bell states. Using Born rule and properties of trace, we can deduce the probability of getting each outcome:
$$
\begin{aligned}
&p_{00} = \bra{\Psi_{00}}\,\rho_{AB}\,\ket{\Psi_{00}}, &p_{01} = \bra{\Psi_{01}}\,\rho_{AB}\,\ket{\Psi_{01}},
\\&p_{10} = \bra{\Psi_{10}}\,\rho_{AB}\,\ket{\Psi_{10}}, &p_{11} = \bra{\Psi_{11}}\,\rho_{AB}\,\ket{\Psi_{11}}.
\end{aligned}
$$

Since these are all the possible outcomes,
$$
p_{00} + p_{01} + p_{10} + p_{11} = 1. \tag{norm}
$$
Also, expanding $\ket{\Psi_{00}}\bra{\Psi_{00}}$ and $\ket{\Psi_{01}}\bra{\Psi_{01}}$ gives
$$
\begin{aligned}
\ket{\Psi_{00}}\bra{\Psi_{00}}
&= \tfrac{1}{2}\bigl(\ket{00}+\ket{11}\bigr)\bigl(\bra{00}+\bra{11}\bigr)
\\&= \tfrac{1}{2}\bigl(\ket{00}\bra{00}+\ket{00}\bra{11}+\ket{11}\bra{00}+\ket{11}\bra{11}\bigr),
\\
\ket{\Psi_{01}}\bra{\Psi_{01}}
&= \tfrac{1}{2}\bigl(\ket{00}-\ket{11}\bigr)\bigl(\bra{00}-\bra{11}\bigr)
\\&= \tfrac{1}{2}\bigl(\ket{00}\bra{00}-\ket{00}\bra{11}-\ket{11}\bra{00}+\ket{11}\bra{11}\bigr).
\end{aligned}
$$

Adding them gives
$$
\begin{aligned}
\ket{\Psi_{00}}\bra{\Psi_{00}} + \ket{\Psi_{01}}\bra{\Psi_{01}}
&= \tfrac{1}{2}\bigl(2\ket{00}\bra{00} + 2\ket{11}\bra{11}\bigr)
\\
&= \ket{00}\bra{00} + \ket{11}\bra{11}
\\&= \Pi_1.
\end{aligned}
$$
Similarly, expanding $\ket{\Psi_{00}}\bra{\Psi_{00}}$ and $\ket{\Psi_{10}}\bra{\Psi_{10}}$ gives
$$
\begin{aligned}
\ket{\Psi_{00}}\bra{\Psi_{00}}
&= \tfrac{1}{2}\bigl(\ket{++}+\ket{--}\bigr)\bigl(\bra{++}+\bra{--}\bigr)
\\&=\tfrac12\bigl(\ket{++}\bra{++} + \ket{++}\bra{--} + \ket{--}\bra{++} + \ket{--}\bra{--}\bigr),
\\\ket{\Psi_{10}}\bra{\Psi_{10}}
&= \tfrac{1}{2}\bigl(\ket{++}-\ket{--}\bigr)\bigl(\bra{++}-\bra{--}\bigr)\\
&=\tfrac12\bigl(\ket{++}\bra{++} - \ket{++}\bra{--} - \ket{--}\bra{++} + \ket{--}\bra{--}\bigr).
\end{aligned}
$$

Adding these two lines gives
$$
\begin{aligned}
\ket{\Psi_{00}}\bra{\Psi_{00}} + \ket{\Psi_{10}}\bra{\Psi_{10}} &= \tfrac12\bigl(2\ket{++}\bra{++} + 2\ket{--}\bra{--}\bigr)\\
&= \ket{++}\bra{++} + \ket{--}\bra{--}
\\&= \Pi_2.
\end{aligned}
$$
Using the definitions of $\Pi_1$ and $\Pi_2$ in terms of Bell states, Born rule, and properties of the trace, we can rewrite the average test success probability using these new terms.

For the standard basis part:
$$
\begin{aligned}
\text{tr}\bigl(\Pi_1\,\rho_{AB}\bigr) &= \bra{00}\,\rho_{AB}\,\ket{00} + \bra{11}\,\rho_{AB}\,\ket{11}
\\&= \bra{\Psi_{00}}\,\rho_{AB}\,\ket{\Psi_{00}} + \bra{\Psi_{01}}\,\rho_{AB}\,\ket{\Psi_{01}}
\\&= p_{00} + p_{01},
\end{aligned}
$$
and similarly for the Hadamard basis part:
$$
\begin{aligned}
\text{tr}\bigl(\Pi_2\,\rho_{AB}\bigr) &= \bra{++}\,\rho_{AB}\,\ket{++} + \bra{--}\,\rho_{AB}\,\ket{--}
\\&= \bra{\Psi_{00}}\,\rho_{AB}\,\ket{\Psi_{00}} + \bra{\Psi_{10}}\,\rho_{AB}\,\ket{\Psi_{10}}
\\&= p_{00} + p_{10}.
\end{aligned}
$$
Hence,
$$
\begin{aligned}
\tfrac{1}{2}\,\text{tr}\bigl(\Pi_1\,\rho_{AB}\bigr) + \tfrac{1}{2}\,\text{tr}\bigl(\Pi_2\,\rho_{AB}\bigr) &\geq 1 - \delta &\text{from $(*)$ above}
\\\tfrac{1}{2}(p_{00} + p_{01}) + \tfrac{1}{2}(p_{00} + p_{10}) &\geq 1 - \delta
\\p_{00} + \tfrac{1}{2}(p_{01} + p_{10}) &\geq 1 - \delta
\\p_{00} + \tfrac{1}{2}(1 - p_{00} - p_{11}) &\geq 1 - \delta &\text{by (norm)}
\\\tfrac{1}{2}p_{00} - \tfrac{1}{2}p_{11} &\geq \tfrac{1}{2} - \delta
\\p_{00} - p_{11} &\geq 1 - 2\delta.
\end{aligned}
$$
Since $p_{11}$ is a probability, $p_{11} \geq 0$. Hence we can remove it without affecting the inequality and get
$$
p_{00} \geq 1 - 2\delta.
$$

Therefore, the fidelity, as the number of rounds $N \to \infty$,
$$
\begin{aligned}
F &:= F(\rho_{AB}, \ket{\text{EPR}}\bra{\text{EPR}})\\
&= \sqrt{\bra{\text{EPR}}\,\rho_{AB}\,\ket{\text{EPR}}}\\
&= \sqrt{p_{00}}\\
&\geq \sqrt{1 - 2\delta}
\end{aligned}
$$
for some *true* error rate $\delta \in [0, 1]$ where $\delta = \Pr[x_i \neq \tilde{x}_i ~|~ \theta_i = \tilde{\theta}_i]$ is the mismatch probability.

From $(*)$, we've derived that if the average success probability of the classical outcomes test above is high ($\geq 1 - \delta$), then the fidelity (a measure of overlap between two states) of the shared quantum state $\rho_{AB}$ with a perfect EPR pair between Alice and Bob must also be high ($\geq \sqrt{1 - 2\delta}$), provided $\delta$ is sufficiently small.

Rearranging $F^2\geq 1-2\delta$ gives
$$
1 - F^2 \leq 2\delta.
$$
The *Fuchs–van de Graaf inequality* gives, for the trace distance $\varepsilon := D\left(\rho_{AB}, \ket{\text{EPR}}\bra{\text{EPR}}\right)$,
$$
\varepsilon \leq \sqrt{1 - F^2}.
$$
Combining the two inequalities give $\varepsilon \leq \sqrt{2\delta}$, and equivalently, $\delta \geq \frac{1}{2}\varepsilon^2$.

---

**Theorem (Asymptotic EPR Identity Bound).**

Under the i.i.d. assumption, in the asymptotic limit $N \to \infty$, let Alice and Bob share $N$ copies of an unknown state $\rho_{AB}$. Define the *true* matching-basis error rate $\delta = \Pr[x_i \neq \tilde{x}_i ~|~ \theta_i = \tilde{\theta}_i]$. Then, the trace distance $D(\rho_{AB}, \ket{\text{EPR}} \bra{\text{EPR}}_{AB}) = \varepsilon \in [0, 1]$ between $\rho_{AB}$ and the ideal EPR pair satisfies
$$
   \varepsilon \leq \sqrt{2\delta},
   \quad\iff\quad
   \delta \geq \frac{\varepsilon^2}{2}.
$$

---

## Finite-sample analysis

With the asymptotic bound in hand, our task becomes a practical one: we must decide, from a finite sample, whether to declare "close" or "far" while keeping the probability of error below some small threshold.

With the asymptotic bound in hand, our task becomes a practical one: from a finite sample we must decide "close" or "far" while keeping the error probability below some target, say $\alpha$.

Although
$$
\varepsilon \leq \sqrt{2\delta}
$$
holds exactly once we know the true mismatch rate $\delta$, in practice we only observe the empirical rate $\hat{\delta}$ from a finite number of rounds; in the finite-sample setting we cannot hope to pinpoint the true $\delta$ exactly. If we tried to draw a single "hard" cutoff line at
$$
\delta_* = \frac{\varepsilon^2}{2},
$$
then sadly we would suffer both false-accept and false-reject errors due to statistical fluctuations at non-negligible rates whenever $\delta$ sits near $\hat{\delta}$. 

Instead, we tolerantly introduce a small gap around $\delta_*$ and build in a buffer zone to absorb those fluctuations. 

Intuitively, we choose two cut-points - one just below $\delta_*$ and one just above:
$$
\delta_{\text{close}} < \delta_* < \delta_{\text{far}}.
$$
By making this gap just large enough and then applying a *concentration bound* to $\hat{\delta}$, we can guarantee that, with probability at least $1 - \alpha$, the empirical error rate $\hat{\delta}$ stays on the correct side of its respective cutoff - so we will correctly declare "close" whenever $\hat{\delta} \leq \delta_{\text{close}}$ and "far" whenever $\hat{\delta} \geq \delta_{\text{far}}$, each with error at most $\alpha$.

Let's make this intuition precise.

First, starting from the matching-outcomes protocol, we establish a Bernoulli trial model. Consider $S \subseteq \{1, \dots, N\}$, the set of matching‐basis rounds. For each $i \in S$, define the indicator
$$
Y_i := 
\begin{cases}
1 &\text{if } x_i \neq \tilde x_i\\
0 &\text{if } x_i = \tilde x_i
\end{cases}
$$
so each $Y_i \in \{0, 1\}$. Under the i.i.d. assumption, $\{ Y_i \}_{i \in S}$ is a set of independent Bernoulli random variables each with parameter $\delta = \Pr[x_i \neq \tilde{x}_i ~|~ \theta_i = \tilde{\theta}_i]$, the *true* error rate (mismatch probability) conditioned on matching bases:

$$
Y_i \sim \text{Bernoulli}(\delta) \quad\forall i \in S.
$$

The *empirical* error rate (the observable) is
$$
\hat{\delta} = \frac{1}{|S|}\sum_{i \in S} Y_i.
$$
This is the sample mean of $|S|$ independent bounded variables in $[0, 1]$.

The Chernoff-Hoeffding concentration bound (for Bernoulli RVs) tells us that if we average $|S|$ independent $\{ 0, 1 \}$ variables whose true mean is $\delta$, then the chance our empirical average $\hat{\delta}$ deviates from $\delta$ by more than some amount $t > 0$ (the *bad* event) is tiny:
$$
\Pr\left(|\hat{\delta} - \delta| \geq t\right) \leq 2e^{-2|S|t^2}.
$$
- The bigger $|S|$ is, the smaller this probability becomes.
- The larger we demand $t$ (a looser estimate), the fewer samples we need.

To make this failure probability to be at most $\alpha$, it suffices that (by rearranging)
$$
|S| = \frac{1}{2t^2}\,\ln\!\left(\frac{2}{\alpha}\right)
$$
which will be useful soon.

From the theorem above we know that the critical value of the true mismatch rate at which the state $\rho_{AB}$ sits exactly $\varepsilon$-close in trace distance to the perfect EPR state is
$$
\delta_* = \frac{\varepsilon^2}{2}.
$$

In a tolerant test, instead of a single decision point $\varepsilon$, we have to fix two trace-distance tolerances
$$
0 \leq \varepsilon_1 < \varepsilon_2 \leq 1.
$$
where
- $\varepsilon_1$ is the acceptance tolerance ($D(\rho_{AB}, \ket{\text{EPR}}\bra{\text{EPR}})\leq \varepsilon_1$ implies "close"), and
- $\varepsilon_2$ is the rejection threshold ($D(\rho_{AB}, \ket{\text{EPR}}\bra{\text{EPR}}) \geq \varepsilon_2$ implies "far").

We translate these into *matching‐basis* thresholds by
$$
\delta_{\text{close}} := \frac{\varepsilon_1^2}{2},
\qquad
\delta_{\text{far}} := \frac{\varepsilon_2^2}{2}.
$$

Now let's look at a natural proposal for the decision rule...

> **Decision rule *(flawed)*.** After measuring and computing the empirical error rate $\hat{\delta}$:
> - If $\hat{\delta} \leq \delta_{\text{close}}$, declare **"close"** (accept).
> - If $\hat{\delta} \geq \delta_{\text{far}}$, declare **"far"** (reject).
> - If $\delta_{\text{close}} < \hat{\delta} < \delta_{\text{far}}$, declare the result **inconclusive**.

It looks promising and intuitive. But is this viable? Unfortunately, no. The reason is that this rule fails to provide a high-confidence guarantee for the very states it's supposed to certify.

Consider a state whose true error rate is exactly on the boundary, $\delta = \delta_{\text{close}}$. The measured value $\hat{\delta}$ is a random variable centred on this true value. Due to statistical noise, there is roughly a $50\%$ chance that the measurement will yield $\hat{\delta} > \delta_{\text{close}}$. According to this rule, we would declare the result "inconclusive" i.e. fail to accept about half the time! An error rate of $\sim\!50\%$ is unacceptably high and provides no meaningful confidence. If $\delta = \delta_{\text{far}}$ exactly then we suffer from the same problem.

To fix this, we need to relax the decision boundary: instead of testing directly at the promise thresholds $\delta_{\text{close}}$ and $\delta_{\text{far}}$, we introduce a "buffer zone" to absorb statistical fluctuations. 

To implement this we introduce a *margin* $t > 0$, which:
- widens our decision zone so random fluctuations don't flip us at the boundary, and
- serves as the deviation parameter in our Chernoff–Hoeffding bound, which tells us that with very high probability we have $|\hat{\delta} - \delta| < t$, meaning the measured value $\hat{\delta}$ won't fluctuate upwards or downwards by more than $t$.

By choosing our single cutoff
$$
c = \delta_{\text{close}} + t
$$
we build in exactly enough "slack" so that even if the *true* rate sits at the lower promise boundary, $\delta = \delta_{\text{close}}$, then
$$
\Pr\bigl[\hat{\delta} \geq c\bigr]
\;\leq\;\Pr\bigl[\hat{\delta} - \delta \geq t\bigr]
\;\leq\;2e^{-2|S|t^2}\,,
$$
i.e. the completeness error is only the exponentially small Chernoff tail and not the horrible $50\%$ we were getting.  By the same choice $c = \delta_{\text{far}} - t$ on the upper side, we get a *symmetric* buffer $(c, \delta_{\text{far}})$ that makes the soundness error equally tiny.

A very natural way to pick the margin $t > 0$ is to split the gap between $\delta_{\text{close}}$ and $\delta_{\text{far}}$ in half:

$$
t = \frac{\delta_{\text{far}} - \delta_{\text{close}}}{2} = \frac{\varepsilon_2^2 - \varepsilon_1^2}{4}.
$$
As $\varepsilon_2 > \varepsilon_1$ by definition, we have $\delta_{\text{far}} > \delta_{\text{close}}$, satisfying the requirement $t > 0$. Then
$$
c 
= \frac{\delta_{\text{close}} + \delta_{\text{far}}}{2}
= \frac{\varepsilon_1^2 + \varepsilon_2^2}{4}
= \delta_{\text{close}} + t 
= \delta_{\text{far}} - t
$$
would conveniently place our decision boundary exactly in the middle for perfect symmetry.

> **Decision rule.** After measuring and computing $\hat{\delta}$,
> - If $\hat{\delta} \leq c$, declare "close" i.e. accept that $\rho_{AB}$ is within trace distance $\varepsilon$ of the EPR pair.
> - If $\hat{\delta} > c$, declare "far" i.e. reject.
$$
\text{Decision} =
\begin{cases}
\text{“close”}, & \hat{\delta} \leq c,\\
\text{“far”},   & \hat{\delta} > c.
\end{cases}
$$

1. **Completeness** ("close" case).  
   If the true $\delta \leq \delta_{\text{close}} = c - t$, then conditioned on the *good* event $|\hat{\delta} - \delta| < t$ we can unpack the inequality and get 
   $$
   -t < \hat{\delta} - \delta < t.
   $$
	Using the right half of the inequality ($\hat{\delta} - \delta < t$), we have
   $$\hat{\delta} <\quad \delta + t 
   ~~\leq~~ (c - t) + t 
   \quad= c,
   $$
   and hence $\hat{\delta} \leq c$, so we correctly declare "close".

2. **Soundness** ("far" case).  
   If the true $\delta \geq \delta_{\text{far}} = c + t$, then conditioned on the same good event, using the left half of the inequality ($-t < \hat{\delta} - \delta$), we have
   $$
   \hat{\delta} >\quad \delta - t
   ~~\geq~~ (c + t) - t
   \quad= c,
   $$
   and hence $\hat{\delta} > c$, so we correctly declare "far".

Both completeness ($\delta \leq \delta_{\text{close}}$) and soundness ($\delta \geq \delta_{\text{far}}$) can fail only if $|\hat{\delta} - \delta| \geq t$ (i.e., the *bad* event), which the concentration bound guarantees occurs with probability at most $\alpha$.

Now, fix the failure probability to a conventional choice $\frac{1}{3}$. Substituting the values $\alpha = \frac{1}{3}$ and $t = \frac{\varepsilon_2^2 - \varepsilon_1^2}{4}$ into the $|S|$ equation from earlier gives
$$
\begin{aligned}
|S|
~&=~
\frac{1}{2t^2}\,\ln\!\left(\frac{2}{\alpha}\right)
~=~
\frac{1}{2\bigl( \,(\varepsilon_2^2 - \varepsilon_1^2)/4\, \bigr)^2}\,\ln\!\left(\frac{2}{1/3}\right)
\\\\~&=~
\frac{8\,\ln(6)}{(\varepsilon_2^2 - \varepsilon_1^2)^2}
~=~
O\!\left(\frac{1}{(\varepsilon_2^2 - \varepsilon_1^2)^2}\right).
\end{aligned}
$$

Therefore, if we collect $|S| = O\Bigl((\varepsilon_2^2 - \varepsilon_1^2)^{-2}\Bigr)$ concordant‐basis samples, then with probability $\geq 1 - \alpha = 2/3$ we have $|\hat{\delta} - \delta| < t$, which guarantees both completeness and soundness as shown above.

Finally, we need to determine a bound on $N$, the actual number of rounds we'll run the protocol for. Our overall success requires guarding against two distinct types of errors: estimation failure ($E_{\text{estimation}}$), for which we already know $\Pr(E_{\text{estimation}}) = \alpha \leq 1/3$, and sampling failure ($E_{\text{sample}}$), where we fail to collect enough data in the first place. The total failure probability is bounded by their sum using the *union bound*.

Since the probability of the measurement bases matching in any given round is $1/2$, as it occurs uniformly at random, the expected number of concordant samples is $\mathbb{E}[|S|] = N/2$. To safeguard against statistical fluctuations, we should choose $N$ to be larger than the simple estimate of $2|S|$. A robust and standard choice is $N = 4|S|$. With this choice, the probability of obtaining fewer than $|S|$ concordant samples - the event $E_{\text{sample}}$ - can be shown via a standard Chernoff bound to be less than $e^{-|S|/4}$. Let the random variable for the number of concordant-basis rounds from a total of $N$ trials be $X$. Then
$$
X \sim \text{Binomial}\!\left(N, \tfrac{1}{2}\right).
$$
As we have chosen $N = 4|S|$, note that
$$
\mathbb{E}[X] = \frac{N}{2} = 2|S|.
$$
The multiplicative Chernoff bound gives, for any $0 < \delta < 1$,
$$
\Pr\bigl[X < (1-\delta)\,\mathbb{E}[X]\bigr]
\;\leq\;\exp\Bigl(-\tfrac{\delta^2}{2}\,\mathbb{E}[X]\Bigr).
$$

Setting $\delta = \tfrac{1}{2}$ so that $(1 - \delta)\,\mathbb{E}[X]=|S|$ yields
$$
\Pr\bigl[X < |S|\bigr]
\;\leq\;
\exp\Bigl(-\tfrac{(1/2)^2}{2}\cdot 2|S|\Bigr)
\;=\;
e^{-|S|/4}.
$$

With this, we can now use the union bound to find the total probability of failure:
$$
\Pr(\text{Total Failure}) = \Pr(E_{\text{sample}}) + \Pr(E_{\text{estimation}}) \leq e^{-|S|/4} + \frac{1}{3}
$$

Since the $e^{-|S|/4}$ term is negligibly small for any reasonably large $|S|$ (comparing to $1/3$), our overall failure probability is still robustly bounded by approximately $1/3$. Therefore, the choice of $N = 4|S|$ is sufficient. The total number of rounds required for the protocol is:

$$
N = 4|S| = \frac{32 \ln(6)}{(\varepsilon_2^2 - \varepsilon_1^2)^2} = O\Bigl((\varepsilon_2^2 - \varepsilon_1^2)^{-2}\Bigr).
$$

---

**Theorem (Finite-Sample Tolerant EPR Test).**
Fix two trace-distance tolerances $0 \leq \varepsilon_1 < \varepsilon_2 \leq 1$, and set a cutoff $c = (\varepsilon_1^2 + \varepsilon_2^2)/4$. By running the sequential matching-outcomes protocol for
$$
N = O\Bigl((\varepsilon_2^2 - \varepsilon_1^2)^{-2}\Bigr)
$$
rounds, computing the empirical mismatch rate $\hat{\delta}$, and then accepting if $\hat{\delta} \leq c$ and rejecting otherwise, one obtains the following guarantee with confidence at least $2/3$ for this test in both directions:
- If $D(\rho_{AB},\ket{\text{EPR}} \bra{\text{EPR}}_{AB}) \leq \varepsilon_1$, then the test **accepts** (outputs "close").
- If $D(\rho_{AB},\ket{\text{EPR}} \bra{\text{EPR}}_{AB}) > \varepsilon_2$, then the test **rejects** (outputs "far").
