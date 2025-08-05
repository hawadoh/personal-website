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

Although
$$
\varepsilon \leq \sqrt{2\delta}
$$
holds exactly once we know the true mismatch rate $\delta$, in practice we only observe the empirical rate $\hat{\delta}$ from a finite number of rounds. Therefore, in the finite-sample setting we cannot hope to pinpoint the true $\delta$ exactly, so a single "hard" cutoff won't do, because using a single cutoff means we'd suffer both false-accept and false-reject errors due to statistical fluctuations and edge cases at the cutoff boundary (this is explained at the end). Instead we introduce two thresholds

$$
\delta_{\text{close}} < \frac{\varepsilon^2}{2} < \delta_{\text{far}}
$$

and proceed as follows:

* If $\hat{\delta} \leq \delta_{\text{close}}$, we safely declare "close".
* If $\hat{\delta} \geq \delta_{\text{far}}$, we safely declare "far".

By choosing $\delta_{\text{close}}$ and $\delta_{\text{far}}$ symmetrically around, and close enough to the critical true error rate $\tfrac{\varepsilon^2}{2}$, and then applying a *concentration bound* to $\hat{\delta}$, we guarantee that with high probability $\hat{\delta}$ falls on the correct side of both cutoffs whenever the true $\delta$ lies on its corresponding side of the gap. Let's make this intuition precise.

First, we establish a Bernoulli trial model. Consider $S \subseteq \{1, \dots, N\}$, the set of concordant‐basis rounds from the protocol. For each $i \in S$, define the indicator
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

The Chernoff-Hoeffding concentration bound (for Bernoulli RVs) tells us that if we average $|S|$ independent $\{ 0, 1 \}$ variables whose true mean is $\delta$, then the chance our empirical average $\hat{\delta}$ deviates from $\delta$ by more than some amount $t > 0$ is tiny:
$$
\Pr\left(|\hat{\delta} - \delta| \geq t\right) \leq 2e^{-2|S|t^2}.
$$
- The bigger $|S|$ is, the smaller this probability becomes.
- The larger we demand $t$ (a looser estimate), the fewer samples we need.

We want this failure probability to be at most $\alpha := 2e^{-2|S|t^2}$. Rearranging gives
$$
|S| = \frac{1}{2t^2}\,\ln\!\left(\frac{2}{\alpha}\right)
$$
which will be useful soon.

From the theorem above we know that $\delta = \frac{\varepsilon^2}{2}$ is the critical value of $\delta$ at which the state sits exactly $\varepsilon$-close in trace distance to the EPR pair. To decide in finite samples, we need two thresholds $\delta_{\text{close}} < \frac{\varepsilon^2}{2} < \delta_{\text{far}}$. For some margin $t > 0$, a perfectly symmetric choice around $\frac{\varepsilon^2}{2}$ is
$$
\delta_{\text{close}} = \frac{\varepsilon^2}{2} - t, \qquad \delta_{\text{far}} = \frac{\varepsilon^2}{2} + t.
$$
Choose $t = \frac{\varepsilon^2}{6}$. It follows that $\delta_{\text{close}} = \frac{\varepsilon^2}{3}$ and $\delta_{\text{far}} = \frac{2\varepsilon^2}{3}$. Pick any cutoff $c$ that satisfies $\delta_{\text{close}} < c < \delta_{\text{far}}$. For convenience, let's take
$$
c = \frac{\delta_{\text{close}} + \delta_{\text{far}}}2 = \frac{\varepsilon^2}{2}.
$$

**Decision rule.** After measuring and computing $\hat{\delta}$,
- If $\hat{\delta} \leq c$, declare "close" i.e. accept that $\rho_{AB}$ is within trace distance $\varepsilon$ of the EPR pair.
- If $\hat{\delta} > c$, declare "far" i.e. reject.
$$
\text{Decision} =
\begin{cases}
\text{“close”}, & \hat{\delta} \leq c,\\
\text{“far”},   & \hat{\delta} > c.
\end{cases}
$$

1. **Completeness** ("close" case).
   If $\delta \leq \delta_{\text{close}} = \frac{\varepsilon^2}{3}$, then conditioned on the *good* event $|\hat{\delta}-\delta|< t = \frac{\varepsilon^2}{6}$ we have $\hat{\delta} - \delta < t$, hence
   $$
   \hat{\delta} < \delta + t \quad\leq \frac{\varepsilon^2}{3} + \frac{\varepsilon^2}{6} = \frac{\varepsilon^2}{2} \quad = c.
   $$
   As $\hat{\delta} \leq c$, we declare "close" correctly.

2. **Soundness** ("far" case).
   If $\delta \geq \delta_{\text{far}} = \frac{2\varepsilon^2}{3}$, then conditioned on the same event $|\hat{\delta}-\delta|< t = \frac{\varepsilon^2}{6}$ we have $-t < \hat{\delta} - \delta$, hence
   $$
   \hat{\delta} > \delta - t \quad\geq \frac{2\varepsilon^2}{3} - \frac{\varepsilon^2}{6} = \frac{\varepsilon^2}{2} \quad = c.
   $$
   As $\hat{\delta} > c$, we declare "far" correctly.

Completeness ($\delta \leq \delta_{\text{close}}$) and soundness ($\delta \geq \delta_{\text{far}}$) each fail only if $|\hat{\delta} - \delta| \geq t$ (the *bad* event), which occurs with probability at most $\alpha$.

Now, fix the failure probability to a conventional choice $\frac{1}{3}$. Substituting the values $\alpha = \frac{1}{3}$ and $t = \frac{\varepsilon^2}{6}$ into the $|S|$ equation from earlier gives
$$
\begin{aligned}
|S|
~&=~
\frac{1}{2t^2}\,\ln\!\left(\frac{2}{\alpha}\right)
~=~
\frac{1}{2(\varepsilon^2/6)^2}\,\ln\!\left(\frac{2}{1/3}\right)
\\\\~&=~
\frac{36}{2\varepsilon^4}\,\ln(6)
~=~
\frac{18}{\varepsilon^4}\,\ln(6)
~=~
O\!\left(\frac1{\varepsilon^4}\right).
\end{aligned}
$$

Therefore, if we collect $|S| = O(\varepsilon^{-4})$ concordant‐basis samples, then with probability $\geq 1-\alpha=2/3$ we have $|\hat{\delta} - \delta| < t$, which guarantees both completeness and soundness as shown above.

`Need more formality here, technically we need to do another concentration bound, maybe do that, maybe just say 'using standard calculations one can claim we need let's say 3|S| (the specific factor k may differ)' but then just do the concentration bound` Since matching bases occur uniformly at random with probability $1/2$, we need to run
$$
N ~\approx~ 2|S|
~=~
O\!\left(\frac{1}{\varepsilon^4}\right).
$$
expected total rounds to be correct with probability $\geq 2/3$.

---

**Theorem (Sample Complexity with Confidence).**
Fix a target trace‐distance $\varepsilon>0$. By running the sequential matching‐outcomes protocol for
$$
N = O(\varepsilon^{-4})
$$
rounds, accepting if $\hat{\delta} \leq 5\varepsilon^2/12$ and rejecting otherwise, one obtains the following guarantee with confidence at least $2/3$:
- If $D(\rho_{AB},\ket{\text{EPR}} \bra{\text{EPR}}_{AB}) \leq \varepsilon_1$, then the protocol **accepts** (outputs "close").
- If $D(\rho_{AB},\ket{\text{EPR}} \bra{\text{EPR}}_{AB}) > \varepsilon_2$, then the protocol **rejects** (outputs "far").

**Remark.** `explain why it isn't possible to have just epsilon in the above bounds using the blackboard, we need a \delta_close (epsilon_1) and \delta_far (epsilon_2).`