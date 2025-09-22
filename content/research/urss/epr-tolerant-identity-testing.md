+++
date = '2025-08-03T23:35:49+01:00'
draft = false
title = 'Classical tolerant identity test for the EPR state'
ShowToc = true
TocOpen = true
+++

**Goal.** Given $N$ i.i.d. copies of an unknown bipartite state $\rho_{AB}$ held by Alice and Bob, certify that $\rho_{AB}$ held by Alice and Bob is within trace‑distance $\varepsilon$ of
$$
\ket{\text{EPR}}_{AB} = \frac{1}{\sqrt2}\left(\ket{00}_{AB} + \ket{11}_{AB}\right),
$$
using only *sequential\** (one qubit at a time), local measurements in the **standard** ($\{ \ket{0}, \ket{1} \}$) or **Hadamard** ($\{ \ket{+}, \ket{-} \}$) bases, and classical communication/postprocessing. Importantly, we never perform any joint or Bell‐basis measurement on $AB$.

---

## Single-pair matching‑outcomes protocol

Suppose Alice and Bob share $N$ i.i.d. copies of an unknown bipartite state $\rho_{AB}$. They first agree publicly (over a *classical authenticated channel*, CAC) on a random basis string $\theta = (\theta_1, \dots, \theta_N)$, where each $\theta_i \in \{0, 1\}$ is chosen uniformly at random. Here $\theta_i = 0$ denotes the **standard ($Z$) basis** and $\theta_i = 1$ denotes the **Hadamard ($X$) basis**.

Then for each pair $i \in \{1, \dots, N\} = [N]$, they measure locally *in sequence\** as follows:
- Alice measures her qubit in basis $\theta_i$, obtaining outcome $x_i \in \{0, 1\}$.
- Bob measures his qubit in the same basis $\theta_i$, obtaining outcome $\tilde{x}_i \in \{0, 1\}$.

> **Note.** Apart from the one-off preparation/distribution of the shared state $\rho_{AB}$, there is no need for any further quantum channel or quantum memory; Alice and Bob simply perform immediate local measurements. In addition, since each measurement round consumes one i.i.d. copy of $\rho_{AB}$, the parameter $N$ can be viewed interchangeably as either the number of <u>rounds</u> or the number of <u>copies</u>, and I will use it in both senses throughout our single-pair analysis.

After all $N$ measurement rounds (one round for each i.i.d. copy of $\rho_{AB}$), Alice and Bob publicly reveal their outcome strings $x = (x_1, \dots, x_N)$, $\tilde{x} = (\tilde{x}_1, \dots, \tilde{x}_N)$ over the CAC.

Unlike BB84, in this context we're not interested in secrecy. We **force the bases to match** every round, so every measurement contributes to the statistic. Therefore, for each $i \in [N]$, Alice and Bob measure in the same basis and we define the observed mismatch (error) rate
$$
\hat{\delta}
~=~\frac{1}{N}\,\Big|\{\,i\in[N]: x_i \neq \tilde{x}_i\,\}\Big|,
$$
which is the fraction of rounds with disagreeing outcomes.

>**Remark.** The sequential ordering is only a hardware convenience: it removes any need for quantum memory. If you have $N$ measurement setups you may run them in parallel and then exchange classical data; the statistical analysis and bounds are identical.

---

## Asymptotic bound

**Motivating question.**
Can we really conclude that, if the *classical* matching-outcomes test in the protocol above succeeds with high probability (i.e. a small observed error $\hat{\delta}$), then the *quantum* state $\rho_{AB}$ must be close to an ideal EPR pair, *without ever* performing a joint or Bell-basis measurement? 

In other words, when given $\rho_{AB}^{\otimes N}$, what is the smallest number $N$ of i.i.d. copies required to certify that $\rho_{AB}$ lies within trace distance $\varepsilon$ of the ideal EPR state?

We'll first analyse the idealised, infinite-round/copy limit $N \to \infty$ to see theoretically why a high success rate forces high fidelity to $\ket{\text{EPR}}_{AB}$. After that, we'll return to the realistic, finite-sample setting to turn this into a practical protocol in the next section.

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

**Lemma.** Let $\rho_{AB}$ be a bipartite state where $A$ and $B$ are each systems of a single qubit, that is, $\rho_{AB}$ is a $4 \times 4$ density matrix acting on $\mathbb{C}^2 \times \mathbb{C}^2$. The probability of Alice and Bob getting matching outcomes (`00` or `11`) when they both measure in the standard basis ($Z$) is given by $\text{tr}(\Pi_Z\,\rho_{AB})$, where 
$$
\ket{\text{EPR}} = \ket{\Psi_{00}} = \frac{1}{\sqrt{2}}(\ket{00} + \ket{11}), \qquad \ket{\Psi_{01}} = \frac{1}{\sqrt{2}}(\ket{00} - \ket{11}),
$$
and
$$
\Pi_Z = \ket{\text{EPR}}\!\bra{\text{EPR}} + \ket{\Psi_{01}}\!\bra{\Psi_{01}}.
$$
Similarly, the probability of Alice and Bob getting matching outcomes (`++` or `--`) when they both measure in the Hadamard basis ($X$) is given by $\text{tr}(\Pi_X\,\rho_{AB})$, with
$$
\ket{\Psi_{10}} = \frac{1}{\sqrt{2}}(\ket{01} + \ket{10}),
$$
and
$$
\Pi_X = \ket{\text{EPR}}\!\bra{\text{EPR}} + \ket{\Psi_{10}}\!\bra{\Psi_{10}}.
$$

**Proof.**
The probability of matching outcomes,
$$
\begin{aligned}
\Pr(\text{match}_{Z}) &= \Pr(00) + \Pr(11)
\\&= \text{tr}(M_{00}\,\rho_{AB}) + \text{tr}(M_{11}\,\rho_{AB}) &\text{by Born rule}
\\&= \text{tr}(\ket{00}\!\bra{00}\,\rho_{AB}) + \text{tr}(\ket{11}\!\bra{11}\,\rho_{AB}) &\text{by def. of POVM operator}
\\&= \text{tr}(\bra{00}\,\rho_{AB}\,\ket{00}) + \text{tr}(\bra{11}\,\rho_{AB}\,\ket{11}) &\text{by cyclicity of trace}
\\&= \bra{00}\,\rho_{AB}\,\ket{00} + \bra{11}\,\rho_{AB}\,\ket{11} &\text{as trace of scalar = itself.}
\end{aligned}
$$
Expanding $\Pi_Z$ we get
$$
\begin{aligned}
\Pi_Z &= \ket{\text{EPR}}\!\bra{\text{EPR}} + \ket{\Psi_{01}}\!\bra{\Psi_{01}}
\\&=\tfrac{1}{2}(\ket{00}\!\bra{00} + \ket{00}\!\bra{11} + \ket{11}\!\bra{00} + \ket{11}\!\bra{11} 
\\&\qquad+ \ket{00}\!\bra{00} - \ket{00}\!\bra{11} - \ket{11}\!\bra{00} + \ket{11}\!\bra{11})
\\&= \tfrac{1}{2}(2\ket{00}\!\bra{00} + 2\ket{11}\!\bra{11})
\\&= \ket{00}\!\bra{00} + \ket{11}\!\bra{11}.
\end{aligned}
$$

Then
$$
\begin{aligned}
\text{tr}(\Pi_Z\,\rho_{AB}) &= \text{tr}(\,(\ket{00}\!\bra{00} + \ket{11}\!\bra{11})\,\rho_{AB}) &\text{by def. of }\Pi_Z
\\&= \text{tr}(\ket{00}\!\bra{00}\,\rho_{AB}) + \text{tr}(\ket{11}\!\bra{11}\,\rho_{AB}) &\text{by linearity of trace}
\\&= \text{tr}(\bra{00}\,\rho_{AB}\,\ket{00}) + \text{tr}(\bra{11}\,\rho_{AB}\,\ket{11}) &\text{by cyclicity of trace}
\\&= \bra{00}\,\rho_{AB}\,\ket{00} + \bra{11}\,\rho_{AB}\,\ket{11} &\text{as trace of scalar = itself.}
\end{aligned}
$$
Hence $\Pr(\text{match}_Z) = \text{tr}(\Pi_Z\,\rho_{AB})$ as required.

Similarly, for the measurement of systems $A$ and $B$ is performed in the Hadamard basis, we can first perform a change in basis and simplify $\Pi_X$. Recall that
$$
\ket{0} = \frac1{\sqrt2}(\ket{+} + \ket{-}),\qquad
\ket{1} = \frac1{\sqrt2}(\ket{+} - \ket{-}).
$$

Then
$$
\begin{aligned}
\ket{\text{EPR}} &= \frac{1}{\sqrt2}(\ket{00} + \ket{11})
\\&= \frac{1}{\sqrt2}\left(
\frac{\ket{+} + \ket{-}}{\sqrt2} \otimes \frac{\ket{+} + \ket{-}}{\sqrt2} + \frac{\ket{+} - \ket{-}}{\sqrt2} \otimes \frac{\ket{+} - \ket{-}}{\sqrt2}
\right)
\\&= \frac{1}{\sqrt2}\bigl(\ket{++} + \ket{--}\bigr).
\end{aligned}
$$

Using the same algebra, one can easily verify
$$
\ket{\Psi_{10}}
= \frac{1}{\sqrt2}(\ket{01} + \ket{10})
= \frac{1}{\sqrt2}\bigl(\ket{++} - \ket{--}\bigr).
$$

Expanding $\Pi_X$ we get
$$
\begin{aligned}
\Pi_X &= \tfrac{1}{2}(\ket{++}\!\bra{++} + \ket{++}\!\bra{--} + \ket{--}\!\bra{++} + \ket{--}\!\bra{--} 
\\&\qquad+ \ket{++}\!\bra{++} - \ket{++}\!\bra{--} - \ket{--}\!\bra{++} + \ket{--}\!\bra{--})
\\&= \tfrac{1}{2}(2\ket{++}\!\bra{++} + 2\ket{--}\!\bra{--})
\\&= \ket{++}\!\bra{++} + \ket{--}\!\bra{--}.
\end{aligned}
$$

Finally, by exactly the same Born-rule steps as above (now applied in the Hadamard basis), we have:
$$
\Pr(\text{match}_X) = \text{tr}(\ket{++}\!\bra{++}\,\rho_{AB}) + \text{tr}(\ket{--}\!\bra{--}\,\rho_{AB}) = \text{tr}(\Pi_X\,\rho_{AB}),$$
so the proof is complete.

Now suppose that $\rho_{AB}$ is any state such that
$$
\underbrace{\frac{1}{2}\,\text{tr}\bigl(\Pi_Z\,\rho_{AB}\bigr)}_{\substack{\text{matching outcomes}\\\text{in standard (Z) basis}}}
~+~
\underbrace{\frac{1}{2}\,\text{tr}\bigl(\Pi_X\,\rho_{AB}\bigr)}_{\substack{\text{matching outcomes}\\\text{in Hadamard (X) basis}}}
~=~
\underbrace{1 - \delta}_{\substack{\text{overall success}\\\text{probability}}} \qquad (*)
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
p_{00} + p_{01} + p_{10} + p_{11} = 1. \qquad \text{(Norm)}
$$
Also, expanding $\ket{\Psi_{00}}\!\bra{\Psi_{00}}$ and $\ket{\Psi_{01}}\!\bra{\Psi_{01}}$ gives
$$
\begin{aligned}
\ket{\Psi_{00}}\!\bra{\Psi_{00}}
&= \tfrac{1}{2}\bigl(\ket{00}+\ket{11}\bigr)\bigl(\bra{00}+\bra{11}\bigr)
\\&= \tfrac{1}{2}\bigl(\ket{00}\!\bra{00}+\ket{00}\!\bra{11}+\ket{11}\!\bra{00}+\ket{11}\!\bra{11}\bigr),
\\
\ket{\Psi_{01}}\!\bra{\Psi_{01}}
&= \tfrac{1}{2}\bigl(\ket{00}-\ket{11}\bigr)\bigl(\bra{00}-\bra{11}\bigr)
\\&= \tfrac{1}{2}\bigl(\ket{00}\!\bra{00}-\ket{00}\!\bra{11}-\ket{11}\!\bra{00}+\ket{11}\!\bra{11}\bigr).
\end{aligned}
$$

Adding them gives
$$
\begin{aligned}
\ket{\Psi_{00}}\!\bra{\Psi_{00}} + \ket{\Psi_{01}}\!\bra{\Psi_{01}}
&= \tfrac{1}{2}\bigl(2\ket{00}\!\bra{00} + 2\ket{11}\!\bra{11}\bigr)
\\
&= \ket{00}\!\bra{00} + \ket{11}\!\bra{11}
\\&= \Pi_Z.
\end{aligned}
$$
Similarly, expanding $\ket{\Psi_{00}}\!\bra{\Psi_{00}}$ and $\ket{\Psi_{10}}\!\bra{\Psi_{10}}$ gives
$$
\begin{aligned}
\ket{\Psi_{00}}\!\bra{\Psi_{00}}
&= \tfrac{1}{2}\bigl(\ket{++}+\ket{--}\bigr)\bigl(\bra{++}+\bra{--}\bigr)
\\&=\tfrac{1}{2}\bigl(\ket{++}\!\bra{++} + \ket{++}\!\bra{--} + \ket{--}\!\bra{++} + \ket{--}\!\bra{--}\bigr),
\\\ket{\Psi_{10}}\!\bra{\Psi_{10}}
&= \tfrac{1}{2}\bigl(\ket{++}-\ket{--}\bigr)\bigl(\bra{++}-\bra{--}\bigr)\\
&=\tfrac{1}{2}\bigl(\ket{++}\!\bra{++} - \ket{++}\!\bra{--} - \ket{--}\!\bra{++} + \ket{--}\!\bra{--}\bigr).
\end{aligned}
$$

Adding these two lines gives
$$
\begin{aligned}
\ket{\Psi_{00}}\!\bra{\Psi_{00}} + \ket{\Psi_{10}}\!\bra{\Psi_{10}} &= \tfrac{1}{2}\bigl(2\ket{++}\!\bra{++} + 2\ket{--}\!\bra{--}\bigr)\\
&= \ket{++}\!\bra{++} + \ket{--}\!\bra{--}
\\&= \Pi_X.
\end{aligned}
$$
Using the definitions of $\Pi_Z$ and $\Pi_X$ in terms of Bell states, Born rule, and properties of the trace, we can rewrite the average test success probability using these new terms.

For the standard basis part:
$$
\begin{aligned}
\text{tr}\bigl(\Pi_Z\,\rho_{AB}\bigr) &= \bra{00}\,\rho_{AB}\,\ket{00} + \bra{11}\,\rho_{AB}\,\ket{11}
\\&= \bra{\Psi_{00}}\,\rho_{AB}\,\ket{\Psi_{00}} + \bra{\Psi_{01}}\,\rho_{AB}\,\ket{\Psi_{01}}
\\&= p_{00} + p_{01},
\end{aligned}
$$
and similarly for the Hadamard basis part:
$$
\begin{aligned}
\text{tr}\bigl(\Pi_X\,\rho_{AB}\bigr) &= \bra{++}\,\rho_{AB}\,\ket{++} + \bra{--}\,\rho_{AB}\,\ket{--}
\\&= \bra{\Psi_{00}}\,\rho_{AB}\,\ket{\Psi_{00}} + \bra{\Psi_{10}}\,\rho_{AB}\,\ket{\Psi_{10}}
\\&= p_{00} + p_{10}.
\end{aligned}
$$
Hence,
$$
\begin{aligned}
\tfrac{1}{2}\,\text{tr}\bigl(\Pi_Z\,\rho_{AB}\bigr) + \tfrac{1}{2}\,\text{tr}\bigl(\Pi_X\,\rho_{AB}\bigr) &= 1 - \delta &\text{from $(*)$ above}
\\[6pt]\tfrac{1}{2}(p_{00} + p_{01}) + \tfrac{1}{2}(p_{00} + p_{10}) &= 1 - \delta
\\[6pt]p_{00} + \tfrac{1}{2}(p_{01} + p_{10}) &= 1 - \delta
\\[6pt]p_{00} + \tfrac{1}{2}(1 - p_{00} - p_{11}) &= 1 - \delta &\text{by (Norm)}
\\[6pt]\tfrac{1}{2}p_{00} - \tfrac{1}{2}p_{11} &= \tfrac{1}{2} - \delta
\\[6pt]p_{00} - p_{11} &= 1 - 2\delta.
\end{aligned}
$$
We don't know the exact value for $p_{11}$, but since $p_{11}$ is a probability, $p_{11} \geq 0$. Hence we can remove it and get the inequality
$$
p_{00} \geq 1 - 2\delta.
$$

Therefore, the fidelity, as the number of rounds $N \to \infty$,
$$
\begin{aligned}
F &:= F(\rho_{AB}, \ket{\text{EPR}}\!\bra{\text{EPR}})\\
&= \sqrt{\bra{\text{EPR}}\,\rho_{AB}\,\ket{\text{EPR}}}\\
&= \sqrt{p_{00}}\\
&\geq \sqrt{1 - 2\delta}
\end{aligned}
$$
for some *true* error rate $\delta \in [0, 1]$ where $\delta = \Pr[x_i \neq \tilde{x}_i]$ is the mismatch probability.

From $(*)$, we've derived that if the average success probability of the classical outcomes test above is high ($\geq 1 - \delta$), then the fidelity (a measure of overlap between two states) of the shared quantum state $\rho_{AB}$ with a perfect EPR pair between Alice and Bob must also be high ($\geq \sqrt{1 - 2\delta}$), provided $\delta$ is sufficiently small.

Rearranging $F^2\geq 1-2\delta$ gives
$$
1 - F^2 \leq 2\delta.
$$
The *Fuchs–van de Graaf inequality* gives, for the trace distance $\varepsilon := D\left(\rho_{AB}, \ket{\text{EPR}}\!\bra{\text{EPR}}\right)$,
$$
\varepsilon \leq \sqrt{1 - F^2}.
$$
Combining the two inequalities give $\varepsilon \leq \sqrt{2\delta}$, and equivalently, $\delta \geq \frac{1}{2}\varepsilon^2$.

> **Theorem (Asymptotic EPR Identity Bound).**
>
> In the asymptotic limit $N \to \infty$, let Alice and Bob share $N$ i.i.d. copies of an unknown state $\rho_{AB}$. Define the *true* error rate $\delta = \Pr[x_i \neq \tilde{x}_i]$. Then, the trace distance $D(\rho_{AB}, \ket{\text{EPR}}\!\bra{\text{EPR}}_{AB}) = \varepsilon \in [0, 1]$ between $\rho_{AB}$ and the ideal EPR pair satisfies
> $$
   \varepsilon \leq \sqrt{2\delta},
   \quad\iff\quad
   \delta \geq \frac{\varepsilon^2}{2}.
$$

---

## Finite-sample analysis

With the asymptotic bound in hand, our task becomes a practical one: from a finite sample we must decide "close" or "far" while keeping the probability of error below some small target, say $\alpha$.

Although
$$
\varepsilon \leq \sqrt{2\delta}
$$
holds exactly once we know the true mismatch rate $\delta$, in practice we only observe the empirical rate $\hat{\delta}$ from a finite number of rounds (as defined in the protocol); in the finite-sample setting we cannot hope to pinpoint the true $\delta$ exactly.

If we tried to draw a single "hard" cutoff line at
$$
\delta_* = \frac{\varepsilon^2}{2},
$$
then sadly we would suffer both false-accept and false-reject errors because the statistical fluctuations would cause the measured error rate $\hat{\delta}$ to frequently land on the wrong side of the cutoff line whenever the true value $\delta$ is too close to $\delta_*$.

In other words, with a finite number of samples, it is **impossible** to reliably distinguish between two scenarios that are infinitesimally close but on opposite sides of a sharp boundary. The statistical "noise" from finite sampling is larger than the tiny difference we are trying to measure. This means that an identity test that distinguishes states that are $\varepsilon$-close from those that are more than $\varepsilon$-far is not robust! The solution is to adopt a *tolerant* testing framework. 

Instead of a single distance threshold $\varepsilon$, we define two: an acceptance tolerance $\varepsilon_1$ and a rejection tolerance $\varepsilon_2$, where $0 \leq \varepsilon_1 < \varepsilon_2 \leq 1$. Our goal is no longer to pinpoint a single boundary, but to reliably distinguish states that are "close" ($D(\rho_{AB}, \ket{\text{EPR}}) \leq \varepsilon_1$) from those that are "far" ($D(\rho_{AB}, \ket{\text{EPR}}) \geq \varepsilon_2$).

This framework creates a small "promise gap" around $\delta_*$. By translating our trace distance tolerances ($\varepsilon_1$ and $\varepsilon_2$) into error rate thresholds, $\delta_{\text{close}}$ and $\delta_{\text{far}}$, which are functions of $\varepsilon_1$ and $\varepsilon_2$ respectively, we establish a "buffer zone" that can absorb those statistical fluctuations.

By making this "promise gap" just large enough and then applying a *concentration bound* to $\hat{\delta}$, we can guarantee that, with probability at least $1 - \alpha$, the empirical error rate $\hat{\delta}$ stays on the correct side of its respective cutoff - so we will correctly declare "close" whenever $\hat{\delta} \leq \delta_{\text{close}}$ and "far" whenever $\hat{\delta} \geq \delta_{\text{far}}$, each with error at most $\alpha$.

For simplicity, write $\rho := \rho_{AB}$ and $\Phi := \ket{\text{EPR}}\!\bra{\text{EPR}}$. We need to define the hypotheses $\mathbf{H_0}$ ($\varepsilon_1$-close) and $\mathbf{H_1}$ ($\varepsilon_2$-far) for our test:
$$
\begin{cases}
~\mathbf{H_0}: &D(\rho, \Phi) \,\leq\,\varepsilon_1 \quad\iff\quad \rho \text{ is “close” to }\Phi,
\\ ~\mathbf{H_1}: &D(\rho, \Phi) \,\geq\,\varepsilon_2 \quad\iff\quad \rho \text{ is “far” from }\Phi,
\end{cases}
$$

Also, recall that the asymptotic inequality
$$
D(\rho, \Phi) \leq \sqrt{2\delta}
$$
was derived from the Fuchs–van de Graaf bound and the matching-outcomes success rate. This is the *soundness direction*: it tells us that if the true mismatch rate $\delta$ is small, then the state is also close in trace distance. It applies directly to the "far" case ($\mathbf{H_1}$), where $D(\rho, \Phi) \geq \varepsilon_2$ forces a lower bound $\delta \geq \varepsilon_2^2/2$ on the mismatch rate from the following inequality chain:
$$
\sqrt{2\delta} \,\geq\, D(\rho, \Phi) \,\geq\, \varepsilon_2 \quad\implies\quad \delta \,\geq\, \tfrac{\varepsilon_2^2}{2}.
$$

For the "close" case ($H_0$), we cannot run this implication backwards: $D(\rho, \Phi) \leq \sqrt{2\delta}$ does not give an *upper bound* on $\delta$ in terms of $D(\rho, \Phi)$. Instead, we use a standard variational/POVM bound: for any projector $\Pi$,
$$
\bigl| \text{tr}(\Pi\rho) - \text{tr}(\Pi\Phi) \bigr| = \bigl| \text{tr}[\Pi(\rho - \Phi)] \bigr| \,\leq\, D(\rho, \Phi).
$$
Choosing $\Pi$ as the mismatch projector for matching-basis rounds:
$$
\Pi_{\text{mis}}^{Z} = \ket{01}\!\bra{01} + \ket{10}\!\bra{10},\qquad
\Pi_{\text{mis}}^{X} = \ket{+-}\!\bra{+-} + \ket{-+}\!\bra{-+},
$$
the overall mismatch rate is $\delta = \tfrac{1}{2}\bigl(\text{tr}[\Pi_{\text{mis}}^{Z}\rho] + \text{tr}[\Pi_{\text{mis}}^{X}\rho]\bigr)$, which occurs with probability zero for the ideal EPR state:
$$
\text{tr}[\Pi_{\text{mis}}^{Z}\Phi] = \text{tr}[\Pi_{\text{mis}}^{X}\Phi] = 0.
$$
Since each $\Pi_{\text{mis}}^{B}$ ($B \in \{Z, X\}$) is a positive projector and $\text{tr}[\Pi_{\text{mis}}^{B}\rho] \geq 0$, we have
$$
\bigl| \text{tr}[\Pi_{\text{mis}}^{B}(\rho - \Phi)] \bigr|
= \bigl| \text{tr}[\Pi_{\text{mis}}^{B}\rho] - 0 \bigr|
= \text{tr}[\Pi_{\text{mis}}^{B}\rho].
$$

Apply the variational bound $\bigl|\text{tr}[\Pi(\rho - \sigma)]\bigr| \leq D(\rho, \sigma)$ with $\Pi = \Pi_{\text{mis}}^{B}$ and $\sigma = \Phi$:
$$
\text{tr}[\Pi_{\text{mis}}^{B}\rho] \leq D(\rho, \Phi).
$$

Thus
$$
\delta_Z = \text{tr}[\Pi_{\text{mis}}^{Z}\rho] \leq D(\rho, \Phi),\qquad
\delta_X = \text{tr}[\Pi_{\text{mis}}^{X}\rho] \leq D(\rho, \Phi).
$$

Averaging gives
$$
\delta = \tfrac{1}{2}(\delta_Z + \delta_X) \leq D(\rho, \Phi),
$$
so we have the bound $\delta \leq D(\rho, \Phi)$. Therefore, under $\mathbf{H_0}$ with $D(\rho, \Phi) \leq \varepsilon_1$, the mismatch rate satisfies $\delta \leq \varepsilon_1$.

Let's make this intuition precise.

First, starting from the matching-outcomes protocol, we establish a Bernoulli trial model. For each $i \in [N]$, define the indicator
$$
Y_i := 
\begin{cases}
1 &\text{if } x_i \neq \tilde x_i\\
0 &\text{if } x_i = \tilde x_i
\end{cases}
$$
so each $Y_i \in \{0, 1\}$. Under the i.i.d. assumption, $\{ Y_i \}_{i \in [N]}$ is a set of independent Bernoulli random variables each with parameter $\delta = \Pr[x_i \neq \tilde{x}_i]$, the *true* error rate (mismatch probability):
$$
Y_i \sim \text{Bernoulli}(\delta) \quad\forall i \in [N].
$$
The *empirical* error rate is the observable:
$$
\hat{\delta} = \frac{1}{N}\sum_{i \in [N]} Y_i.
$$
This is the sample mean of $N$ independent bounded variables in $[0, 1]$.

The Chernoff-Hoeffding concentration bound (for Bernoulli RVs) tells us that if we average $N$ independent $\{ 0, 1 \}$ variables whose true mean is $\delta$, then the chance our empirical average $\hat{\delta}$ deviates from $\delta$ by more than some amount $t > 0$ (the *bad* event) is tiny:
$$
\Pr\left(|\hat{\delta} - \delta| \geq t\right) \leq 2e^{-2Nt^2}.
$$
- The bigger $N$ is, the smaller this probability becomes.
- The larger we demand $t$ (a looser estimate), the fewer samples we need.

To make this failure probability to be at most $\alpha$, it suffices that (by rearranging)
$$
N = \frac{1}{2t^2}\,\ln\!\left(\frac{2}{\alpha}\right)
$$
which will be useful soon.

As we've discussed, in a tolerant test, instead of a single decision point $\varepsilon$, we have to fix two trace-distance tolerances
$$
0 \leq \varepsilon_1 < \varepsilon_2 \leq 1,
$$
where
- $\varepsilon_1$ is the acceptance tolerance for $\mathbf{H_0}$; $D(\rho, \Phi) \leq \varepsilon_1$ implies "close", and
- $\varepsilon_2$ is the rejection tolerance for $\mathbf{H_1}$; $D(\rho, \Phi) \geq \varepsilon_2$ implies "far".

We translate these trace distance parameters into error rate thresholds by
$$
\delta_{\text{close}} := \varepsilon_1,
\qquad
\delta_{\text{far}} := \frac{\varepsilon_2^2}{2}.
$$

For the promise gap to be non-trivial, we need $\delta_{\text{far}} > \delta_{\text{close}}$, which translates to
$$
\varepsilon_1 < \frac{\varepsilon_2^2}{2}.
$$
Unfortunately, this introduces an extra constraint beyond the generic condition $0 \leq \varepsilon_1 < \varepsilon_2 \leq 1$.

Now let's look at a natural proposal for the decision rule...

> **Decision rule *(flawed)*.** After measuring and computing the empirical error rate $\hat{\delta}$:
> - If $\hat{\delta} \leq \delta_{\text{close}}$, declare **"close"** (accept).
> - If $\hat{\delta} \geq \delta_{\text{far}}$, declare **"far"** (reject).
> - If $\delta_{\text{close}} < \hat{\delta} < \delta_{\text{far}}$, declare the result **inconclusive**.

It looks promising and intuitive. But is this viable? Unfortunately, no. The reason this rule is flawed is the same reason a single hard cutoff $\delta_*$ is flawed! So this rule fails to provide a high-confidence guarantee for the very states it's supposed to certify.

Consider a state whose true error rate is exactly on the boundary, $\delta = \delta_{\text{close}}$. The measured value $\hat{\delta}$ is a random variable centred on this true value. Due to statistical noise, there is roughly a $50\%$ chance that the measurement will yield $\hat{\delta} > \delta_{\text{close}}$. According to this rule, we would declare the result "inconclusive" i.e. fail to accept about half the time! An error rate of $\sim\!50\%$ is unacceptably high and provides no meaningful confidence. If $\delta = \delta_{\text{far}}$ exactly, then again we suffer from the same problem.

To fix this, we need to relax the decision boundary: instead of testing directly at the promise thresholds $\delta_{\text{close}}$ and $\delta_{\text{far}}$, we introduce a "buffer zone" to absorb statistical fluctuations. 

To implement this we introduce a *margin* $t > 0$, which:
- widens our decision zone so random fluctuations don't flip us at the boundary, and
- serves as the deviation parameter in our Chernoff–Hoeffding bound, which tells us that with very high probability we have $|\hat{\delta} - \delta| < t$, meaning the measured value $\hat{\delta}$ won't fluctuate upwards or downwards by more than $t$.

By choosing our single cutoff
$$
c = \delta_{\text{close}} + t,
$$
we build in exactly enough "slack" so that even if the *true* rate sits at the lower promise boundary, $\delta = \delta_{\text{close}}$, then by the Chernoff-Hoeffding bound
$$
\Pr\bigl[\hat{\delta} \geq c\bigr]
~\leq~\Pr\bigl[\hat{\delta} - \delta \geq t\bigr]
~\leq~2e^{-2Nt^2}\,,
$$
i.e. the completeness error is only the exponentially small Chernoff tail and not the horrible $50\%$ we were getting. By the same choice $c = \delta_{\text{far}} - t$ on the upper side, we get a *symmetric* buffer $(c, \delta_{\text{far}})$ that makes the soundness error equally tiny.

So the correct solution, counter-intuitive as it may seem, is to place one decision cutoff $c$ inside the promise gap $(\delta_{\text{close}}, \delta_{\text{far}})$. We've come full circle!

A very natural way to pick the margin $t > 0$ is to split the gap between $\delta_{\text{close}}$ and $\delta_{\text{far}}$ in half:
$$
t = \frac{\delta_{\text{far}} - \delta_{\text{close}}}{2} = \frac{\varepsilon_2^2}{4} - \frac{\varepsilon_1}{2} = \frac{\varepsilon_2^2 - 2\varepsilon_1}{4}.
$$
As $\delta_{\text{far}} > \delta_{\text{close}}$ under our restriction $\varepsilon_1 < \varepsilon_2^2/2$, the requirement $t > 0$ is satisfied. Then
$$
c 
= \frac{\delta_{\text{close}} + \delta_{\text{far}}}{2}
= \frac{\varepsilon_1}{2} + \frac{\varepsilon_2^2}{4}
= \frac{2\varepsilon_1 + \varepsilon_2^2}{4}
= \delta_{\text{close}} + t 
= \delta_{\text{far}} - t
$$
would conveniently place our decision boundary exactly in the middle for perfect symmetry.

> **Decision rule.** After measuring and computing $\hat{\delta}$,
> - If $\hat{\delta} \leq c$, accept $\mathbf{H_0}$ ("close").
> - If $\hat{\delta} > c$, accept $\mathbf{H_1}$ ("far").
$$
\text{Decision} =
\begin{cases}
\text{“close”}, & \hat{\delta} \leq c,\\
\text{“far”},   & \hat{\delta} > c.
\end{cases}
$$

Let's quickly prove correctness under the *good event*
$$
\mathcal{G} = \left\{\, |\hat{\delta} - \delta| < t \,\right\}.
$$
Correctness includes completeness ($\mathbf{H_0}$: "close" $\Rightarrow$ "accept") and soundness ($\mathbf{H_1}$: "far" $\Rightarrow$ "reject").

1. **Completeness** ("close" case).  
   If the true $\delta \leq \delta_{\text{close}} = c - t$, then conditioned on $\mathcal{G}$ we have
   $$
   -t < \hat{\delta} - \delta < t.
   $$
   Using the right inequality ($\hat{\delta} - \delta < t$),
   $$
   \hat{\delta} < \delta + t ~\leq~ (c - t) + t ~=~ c,
   $$
   hence $\hat{\delta} \leq c$ and we accept as expected ("close").

2. **Soundness** ("far" case).  
   If the true $\delta \geq \delta_{\text{far}} = c + t$, then conditioned on $\mathcal{G}$ the left inequality ($-t < \hat{\delta} - \delta$) gives
   $$
   \hat{\delta} > \delta - t ~\geq~ (c + t) - t ~=~ c,
   $$
   hence $\hat{\delta} > c$ and we reject as expected ("far").

Both completeness ($\delta \leq \delta_{\text{close}}$) and soundness ($\delta \geq \delta_{\text{far}}$) can fail only if $|\hat{\delta} - \delta| \geq t$ (the *bad* event), which the concentration bound guarantees occurs with probability at most $\alpha/2$. All that remains is to choose the sample size $N$ so that $\Pr[\mathcal{G}] \geq 1 - \alpha$.

Fix a target failure probability $\alpha \in (0,1)$. Substituting $t = \frac{\varepsilon_2^2 - 2\varepsilon_1}{4}$ into the $N$ equation from earlier gives
$$
\begin{aligned}
N
~&=~
\frac{1}{2t^2}\,\ln\!\left(\frac{2}{\alpha}\right)
~=~
\frac{1}{2\bigl( \,(\varepsilon_2^2 - 2\varepsilon_1)/4\, \bigr)^2}\,\ln\!\left(\frac{2}{\alpha}\right)
\\\\~&=~
\frac{8\,\ln(2/\alpha)}{(\varepsilon_2^2 - 2\varepsilon_1)^2}
~=~
O\!\left(\frac{1}{(\varepsilon_2^2 - 2\varepsilon_1)^2}\right).
\end{aligned}
$$

Therefore, if we manage to collect $N = O\Bigl((\varepsilon_2^2 - 2\varepsilon_1)^{-2}\Bigr)$ samples, then with probability $\geq 1 - \alpha$ we have $|\hat{\delta} - \delta| < t$ (the good event $\mathcal{G}$), which guarantees both completeness and soundness as shown above. The key takeaway is that the required sample complexity scales as $N = O\bigl((\varepsilon_2^2 - 2\varepsilon_1)^{-2}\bigr)$, so the closer the gap between $\varepsilon_1$ and $\varepsilon_2$, the number of samples needed grows extremely rapidly. Putting everything together, we arrive at our main result:

> **Theorem (Finite-Sample Tolerant EPR Identity Test).**
>
> Given $N$ i.i.d. copies of $\rho_{AB}$, fix two trace-distance tolerances
> $$
0 \leq \varepsilon_1 < \varepsilon_2 \leq 1,
$$
> where the constraint $\varepsilon_1 < \varepsilon_2^2/2$ holds. Fix the desired maximum failure probability $\alpha \in (0, 1)$.
> Set the cutoff
> $$
c = \frac{2\varepsilon_1 + \varepsilon_2^2}{4}.
$$
> Consider the matching-outcomes protocol executed for a total of $N$ rounds, consuming $N$ i.i.d. copies in total. Let the decision rule be to accept ***if and only if*** the observed error rate, $\hat{\delta}$, is less than or equal to the cutoff, $c$:
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
the test provides the following guarantees:
> - If $D(\rho_{AB}, \ket{\text{EPR}}\!\bra{\text{EPR}}_{AB}) \leq \varepsilon_1$, then the test **accepts** (outputs "close") with confidence at least $1 - \alpha$.
> - If $D(\rho_{AB}, \ket{\text{EPR}}\!\bra{\text{EPR}}_{AB}) \geq \varepsilon_2$, then the test **rejects** (outputs "far") with confidence at least $1 - \alpha$.
> - If $\varepsilon_1 < D(\rho_{AB}, \ket{\text{EPR}}\!\bra{\text{EPR}}_{AB}) < \varepsilon_2$, **no guarantee** is made on the outcome; the test may go either way (accept or reject).

We can quickly give a corollary for the exact, non-tolerant identity test as well. Recall that we write $\rho = \rho_{AB}$ and $\Phi = \ket{\text{EPR}}\!\bra{\text{EPR}}_{AB}$.

> **Corollary (Non-tolerant identity test for the EPR state).**
>
> Fix $\varepsilon \in (0,1]$ and failure probability $\alpha \in (0,1)$. Consider the hypotheses
> $$
\begin{cases}
~\mathbf{H_0}:~ & \rho = \Phi \quad\text{(exact identity)},\\[4pt]
~\mathbf{H_1}:~ & D(\rho,\Phi) \,\geq\, \varepsilon \quad\text{($\varepsilon$-far)}.
\end{cases}
$$
> Run the matching-outcomes protocol for a total of $N$ rounds, with
> $$
N ~\geq~ \frac{2}{\varepsilon^2}\,\ln\!\frac{1}{\alpha}.
$$
> **Decision:** accept $\mathbf{H_0}$ ***iff*** no mismatches are observed (i.e. $\hat{\delta} = 0$).
>
> **Guarantee.** Completeness holds with probability $1$ and soundness holds with probability at least $1 - \alpha$:
> - If $\rho = \Phi$, then $\delta = 0$ and hence $\hat{\delta} = 0$ [almost surely](https://en.wikipedia.org/wiki/Almost_surely), so the test accepts.
> - If $D(\rho,\Phi) \geq \varepsilon$, then by the asymptotic identity bound $D \leq \sqrt{2\delta}$ we have $\delta \geq \varepsilon^2/2$. Over $N$ rounds, since $\delta\ge \varepsilon^2/2$, the probability of *no mismatch* is
> $$
\Pr[\hat\delta = 0] \leq (1 - \delta)^N \leq \bigl(1 - \tfrac{\varepsilon^2}{2}\bigr)^N \leq e^{-N\varepsilon^2/2} \leq \alpha,
$$
> so the test rejects with probability at least $1 - \alpha$.
