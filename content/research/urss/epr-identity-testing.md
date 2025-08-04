+++
date = '2025-08-03T23:35:49+01:00'
draft = false
title = 'Classical Identity Test for the EPR State'
ShowToc = true
TocOpen = true
+++

**Goal.** Certify that an unknown bipartite state $\rho_{AB}$ held by Alice and Bob is within trace‑distance $\varepsilon$ of
$$
\ket{\text{EPR}}_{AB} = \frac1{\sqrt2}\left(\ket{00}_{AB} + \ket{11}_{AB}\right),
$$
using only sequential (one qubit at a time), local measurements in the **standard** ($\{ \ket{0}, \ket{1} \}$) or **Hadamard** ($\{ \ket{+}, \ket{-} \}$) bases, and classical communication.

---

## Sequential matching‑outcomes protocol

Alice and Bob share $N$ independent copies of an unknown state $\rho_{AB}$.  For each copy $i = 1, \dots, N$, they do the following **in sequence**:
1. **Basis choice:**
   * Alice picks $\theta_i \in \{ 0, 1 \}$ uniformly at random.
   * Bob picks $\tilde{\theta}_i \in \{ 0, 1 \}$ uniformly at random.
     Here $\theta_i = 0$ means "standard basis" and $\theta_i = 1$ means "Hadamard basis".
2. **Local measurement:**
   * Alice measures her qubit in basis $\theta_i$ to get outcome $x_i \in \{ 0, 1 \}$.
   * Bob measures his qubit in basis $\tilde\theta_i$, obtaining $\tilde x_i \in \{ 0, 1 \}$.

> **Note.** Apart from the one-off preparation/distribution of the shared state $\rho_{AB}$, there is no need for any further quantum channel or quantum memory; Alice and Bob simply perform immediate local measurements.

After all $N$ rounds, Alice and Bob publicly reveal their basis strings $\theta = (\theta_1, \dots, \theta_N)$ and $\tilde{\theta} = (\tilde{\theta}_1, \dots, \tilde{\theta}_N)$, and their outcome strings $x = (x_1, \dots, x_N)$, $\tilde{x} = (\tilde{x}_1, \dots, \tilde{x}_N)$ over a classical authenticated channel (CAC).

Define the concordant set $$S = \{i : \theta_i = \tilde\theta_i\}.$$On each $i\in S$, Alice and Bob measured in the *same* basis.

> **Remark.** If by rare chance $S = \varnothing$ (no matching bases at all), simply rerun the whole protocol as the probability of $S = \varnothing$ is $2^{-N}$, which is negligible for modest $N$.

Compute the **observed error rate**
$$
  \hat{\delta} = \frac{1}{|S|}\,\left|\{\,i\in S : x_i \neq \tilde x_i\}\right|.
$$
which represents the non-matching fraction of the results.

---

## Asymptotic bound

First, recall:
- The *fidelity* between a state $\rho$ and a pure state $\ket{\psi}$ is defined as
$$
F\left(\rho, \ket{\psi}\right) := \sqrt{\bra{\psi}~\rho~\ket{\psi}}.
$$
- The *trace distance* between two states $\rho$ and $\sigma$ is defined as
$$
D(\rho,\sigma) := \frac{1}{2}\|\rho - \sigma\|_1.
$$
From the work we've done in Exercise 8.3.1 in the textbook *Introduction to Quantum Cryptography* by Vidick and Wehner, when the number of rounds $N \to \infty$,
$$
F(\rho_{AB}, \ket{\text{EPR}}\bra{\text{EPR}}) = \sqrt{\bra{\text{EPR}}~\rho_{AB}~\ket{\text{EPR}}} \geq \sqrt{1 - 2\delta}
$$
for some *true* error rate $\delta \in [0, 1]$ where $\delta = \Pr[x_i \neq \tilde{x}_i ~|~ \theta_i = \tilde{\theta}_i]$ is the mismatch probability.

Write $F^2\geq 1-2\delta$, where $F=\sqrt{\bra{\text{EPR}}~\rho_{AB}~\ket{\text{EPR}}}$. Rearranging gives
$$
1 - F^2 \leq 2\delta.
$$
The *Fuchs–van de Graaf inequality* gives, for the trace distance $\varepsilon := D\left(\rho_{AB}, \ket{\text{EPR}}\bra{\text{EPR}}\right)$,
$$
\varepsilon \leq \sqrt{1 - F^2}.
$$
Combining the two inequalities give $\varepsilon \leq \sqrt{2\delta}$, and equivalently, $\delta \geq \frac{1}{2}\varepsilon^2$.

---

**Theorem (Asymptotic Sequential EPR Identity Bound).**

Under the i.i.d. assumption, in the asymptotic limit $N \to \infty$, let Alice and Bob share $N$ copies of an unknown state $\rho_{AB}$. Define the *true* matching-basis error rate $\delta = \Pr[x_i \neq \tilde{x}_i ~|~ \theta_i = \tilde{\theta}_i]$. Then, the trace distance $D(\rho_{AB}, \ket{\text{EPR}} \bra{\text{EPR}}_{AB}) = \varepsilon \in [0, 1]$ between $\rho_{AB}$ and the ideal EPR pair satisfies
$$
   \varepsilon \leq \sqrt{2\delta},
   \quad\iff\quad
   \delta \geq \frac{\varepsilon^2}{2}.
$$

---

## Finite-sample analysis

We now turn the protocol into a binary decision ("close" vs. "far") with bounded error probability.

We have $\varepsilon \leq \sqrt{2\delta}$, so *if* we somehow knew the exact error rate $\delta$, we could immediately conclude a bound on $\varepsilon$. But in the lab we don't know $\delta$, so the goal is just to estimate $\delta$ with $\hat{\delta}$ by measuring a finite number of copies as described in the protocol.

First we establish a Bernoulli trial model. Consider $S$, the set of concordant‐basis rounds from the protocol. Let $m = |S|$. For each $i \in S$, define the indicator
$$
Y_i := 
\begin{cases}
1 &\text{if } x_i \neq \tilde x_i\\
0 &\text{if } x_i = \tilde x_i
\end{cases}
$$
so each $Y_i \in \{0, 1\}$. Under the i.i.d. assumption, $\{ Y_i \}_{i=1}^m$ is a set of independent Bernoulli random variables each with parameter $\delta = \Pr[x_i \neq \tilde{x}_i ~|~ \theta_i = \tilde{\theta}_i]$, the *true* error rate (mismatch probability) conditioned on matching bases. 

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
|S| = \frac{1}{2t^2}~\ln\!\left(\frac{2}{\alpha}\right)
$$
which will be useful soon.

From the theorem above we know that $\delta = \frac{\varepsilon^2}{2}$ is the critical value of $\delta$ at which the state sits exactly $\varepsilon$-close in trace distance to the EPR pair. To decide in finite samples, we need two thresholds $\delta_{\text{close}} < \frac{\varepsilon^2}{2} < \delta_{\text{far}}$. For some margin $t > 0$, a perfectly symmetric choice around $\frac{\varepsilon^2}{2}$ is
$$
\delta_{\text{close}} = \frac{\varepsilon^2}{2} - t, \qquad \delta_{\text{far}} = \frac{\varepsilon^2}{2} + t.
$$
Choose $t = \frac{\varepsilon^2}{6}$. It follows that $\delta_{\text{close}} = \frac{\varepsilon^2}{6}$ and $\delta_{\text{far}} = \frac{2\varepsilon^2}{3}$. Pick any cutoff $c$ that satisfies $\delta_{\text{close}} < c < \delta_{\text{far}}$. For convenience, let's take
$$
c = \frac{\delta_{\text{close}} + \delta_{\text{far}}}2 = \frac{5\varepsilon^2}{12}.
$$

**Decision rule.** After measuring and computing $\hat{\delta}$,
- If $\hat{\delta} \leq c$, declare "close" i.e. accept that $\rho_{AB}$ is within trace distance $\varepsilon$ of the EPR pair.
- If $\hat{\delta} > c$, declare "far" i.e. reject.
$$
\text{Decision} =
\begin{cases}
\text{“close”}, & \hat\delta \leq c,\\
\text{“far”},   & \hat\delta > c.
\end{cases}
$$

1. **Completeness** ("close" case).
   If $\delta \leq \delta_{\text{close}} = \frac{\varepsilon^2}{6}$, then on the event $|\hat{\delta}-\delta|< t = \frac{\varepsilon^2}{6}$ we have $\hat{\delta} - \delta < t$, hence
   $$
   \hat{\delta} < \delta + t \quad\leq \frac{\varepsilon^2}{6} + \frac{\varepsilon^2}{6} = \frac{\varepsilon^2}{3} \leq\quad \frac{5\varepsilon^2}{12} = c.
   $$
   As $\hat{\delta} \leq c$, we declare "close" correctly.

2. **Soundness** ("far" case).
   If $\delta \geq \delta_{\text{far}} = \frac{2\varepsilon^2}{3}$, then on the same event $|\hat{\delta}-\delta|< t = \frac{\varepsilon^2}{6}$ we have $-t < \hat{\delta} - \delta$, hence
   $$
   \hat{\delta} > \delta - t \quad\geq \frac{2\varepsilon^2}{3} - \frac{\varepsilon^2}{6} = \frac{\varepsilon^2}{2} >\quad \frac{5\varepsilon^2}{12} = c.
   $$
   As $\hat{\delta} > c$, we declare "far" correctly.

Completeness ($\delta \leq \delta_{\text{close}}$) and soundness ($\delta \geq \delta_{\text{far}}$) each fail only if $|\hat{\delta} - \delta| \geq t$, which occurs with probability at most $\alpha$.

Now, fix the failure probability to a conventional choice $\frac{1}{3}$. Substituting the values $\alpha = \frac{1}{3}$ and $t = \frac{\varepsilon^2}{6}$ into the $|S|$ equation from earlier gives
$$
\begin{align*}
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
\end{align*}
$$

Therefore, if we collect $|S| = O(\varepsilon^{-4})$ concordant‐basis samples, then with probability $\geq 1-\alpha=2/3$ we have $|\hat{\delta} - \delta| < t$, which guarantees both completeness and soundness as shown above.

Since matching bases occur uniformly at random with probability $1/2$, we need to run
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
- If $D(\rho_{AB},\ket{\text{EPR}} \bra{\text{EPR}}_{AB}) \leq \varepsilon$, then the protocol **accepts** (outputs "close").
- If $D(\rho_{AB},\ket{\text{EPR}} \bra{\text{EPR}}_{AB}) > \varepsilon$, then the protocol **rejects** (outputs "far").

