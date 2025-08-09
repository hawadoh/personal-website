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

~Can we achieve the same sample complexity
$$
N = O\!\left(n^4\,(\varepsilon_2^2 - \varepsilon_1^2)^{-2}\right)\!.
$$
in all three cases?~ `idk`

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

* **Union bound over $n$ copies.**
  Running $n$ such tests and combining them with a union bound multiplies the sample cost by another factor $n$.

Hence the naïve strategy costs
$$
N_{\text{naïve}} ~=~ O\bigl(n^{5}(\varepsilon_2^2-\varepsilon_1^2)^{-2}\bigr),
$$
which is one full power of $n$ ($n^{5}$ vs. $n^{4}$) worse than the collective $n$-copy analysis we develop below. The lesson is that testing each pair in isolation achieves a *stronger* (per-copy) guarantee than we need and pays a steep statistical price; exploiting the product structure directly using just one global test is markedly more efficient.

### Global block test via fidelity

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

We switch to fidelity because it multiplies exactly under tensor powers: $F(\rho^{\otimes n},\Phi^{\otimes n}) = F(\rho,\Phi)^n$. This means that we can rewrite the $n$-copy test as a per-copy promise, and only at the very end convert back to trace distance via Fuchs–van de Graaf. In contrast, trace distance only obeys the looser sub-additivity bound $D(\rho^{\otimes n},\Phi^{\otimes n}) \leq n\,D(\rho,\Phi)$, which, as we've seen, would introduce an unwieldy factor of $n$ and weaken our bounds.

Our goal is to distinguish
$$
\begin{cases}
~\text{H}_0: &D_n \,\leq\,\varepsilon_1
      \quad\iff\quad \rho^{\otimes n}\text{ is “close” to }\Phi^{\otimes n},\\[6pt]
~\text{H}_1: &D_n \,\geq\,\varepsilon_2
      \quad\iff\quad \rho^{\otimes n}\text{ is “far” from }\Phi^{\otimes n},
\end{cases}
$$
with $0 \leq \varepsilon_1 < \varepsilon_2 \leq 1$. By Fuchs–van de Graaf,
$$
1 - F_n ~\leq~ D_n ~\leq~ \sqrt{1 - F_n^{2}},
$$
so controlling $F_n$ tightly leads to a corresponding control on $D_n$. Since $F_n = F_1^{n}$, we can use this and the left half of Fuchs–van de Graaf to rewrite the hypotheses as fidelity conditions per-copy:
$$
\begin{aligned}
\text{H}_0: \quad F_1^n ~\geq~ 1 - \varepsilon_1
&\quad\iff\quad
F_1 ~\geq~ (1 - \varepsilon_1)^{1/n}
~=:~1-\tilde{\varepsilon}_1,\\[4pt]
\text{H}_1: \quad F_1^n ~\leq~ 1 - \varepsilon_2
&\quad\iff\quad
F_1 ~\leq~ (1 - \varepsilon_2)^{1/n}
~=:~ 1 - \tilde{\varepsilon}_2,
\end{aligned}
$$
where $0 < \tilde{\varepsilon}_1 < \tilde{\varepsilon}_2$. For moderate $n$ one often uses the first-order approximation
$$
\tilde{\varepsilon}_j \approx \frac{\varepsilon_j}{n},
$$
but nothing in the proof requires it. In the single-copy tolerant test we set matching-basis error thresholds
$$
\delta_{\text{close}} = \frac{\varepsilon_1^2}{2},
\quad
\delta_{\text{far}} = \frac{\varepsilon_2^2}{2},
$$
and chose a cutoff
$$
c = \frac{\delta_{\text{close}} + \delta_{\text{far}}}{2} = \frac{\varepsilon_1^2 + \varepsilon_2^2}{4},
$$
then showed 
$$
|S| \geq \frac{8\,\ln(2/\alpha)}{(\varepsilon_2^2-\varepsilon_1^2)^2}
$$samples suffice. In the $n$-copy test we simply replace each $\varepsilon_j$ by its rescaled $\tilde\varepsilon_j$:
$$
\tilde{\delta}_{\text{close}}
=\frac12\,\tilde{\varepsilon}_1^{\,2},
\quad
\tilde{\delta}_{\text{far}}
=\frac12\,\tilde{\varepsilon}_2^{\,2}.
$$
Everything in the finite-sample proof *carries over verbatim*, except that the **promise gap** shrinks by a factor $n$, the number of i.i.d. copies:
$$
\varepsilon_2^2-\varepsilon_1^2 \quad\longrightarrow\quad
\tilde\varepsilon_2^{\,2}-\tilde\varepsilon_1^{\,2}
~\approx~ \frac{\varepsilon_2^{2}-\varepsilon_1^{2}}{n^{2}}.
$$
The same Chernoff-Hoeffding argument yields
$$
|S| ~\geq~ \frac{8\,\ln(2/\alpha)}{\left((\varepsilon_2^2-\varepsilon_1^2)/n^2\right)^2} ~=~ \frac{8\,n^4\,\ln(2/\alpha)}{(\varepsilon_2^2-\varepsilon_1^2)^2}
\qquad\left[=
O\bigl(n^{4}\,(\varepsilon_2^2-\varepsilon_1^2)^{-2}\bigr)\right].
$$
Taking $N=4|S|$ rounds then guarantees both completeness and soundness at the confidence level $1 - \alpha$. So the i.i.d. extension is indeed "trivial" algorithmically (exact same test), but **not** free: the price is a quartic blow-up in $n$ coming from the much narrower promise gap.

> **Back-of-envelope**: if your original single-pair tolerances were some $\varepsilon_1 < \varepsilon_2$ and you move to $n = 10$ copies with the same global promises, the denominator in the $O\bigl((\Delta)^{{-2}}\bigr)$ scaling shrinks by $n^{2}=100$, so you need roughly $10^{4}$ times as many matching-basis samples.

Put succinctly:

---

**Theorem (Finite-sample tolerant EPR identity test, i.i.d. product version).**

Let $n \in \mathbb{N}$ be the number of i.i.d. copies of $\rho_{AB}$ held by Alice and Bob. For brevity write
$$
\rho = \rho_{AB},
\qquad
\Phi = \ket{\text{EPR}}\bra{\text{EPR}}_{AB}.
$$
Fix global trace distance tolerances $0\leq \varepsilon_1<\varepsilon_2\le1$ and confidence $1-\alpha$. Define the cutoff
$$
c = \frac{\tilde{\varepsilon}_1^{\,2}+\tilde{\varepsilon}_2^{\,2}}{4},
\quad\text{where}\quad \tilde{\varepsilon}_j=(1-\varepsilon_j)^{1/n} ~~\text{ for } j \in \{1, 2\}.
$$
Run the matching-outcomes protocol for
$$
N ~\geq~ \frac{32\,n^4\,\ln(2/\alpha)}{\left(\varepsilon_2^2 - \varepsilon_1^2\right)^{2}}
\qquad\left[= O\left(n^4\,\left(\varepsilon_2^2 - \varepsilon_1^2\right)^{-2}\right)\right]
$$
rounds, and accept *if and only if* the observed error $\hat{\delta} \leq c$. Then with probability $\geq 1 - \alpha$:
- If $D(\rho^{\otimes n},\Phi^{\otimes n}) \leq \varepsilon_1$, the test accepts.
- If $D(\rho^{\otimes n},\Phi^{\otimes n}) \geq \varepsilon_2$, the test rejects.
- If $\varepsilon_1 < D(\rho^{\otimes n},\Phi^{\otimes n}) < \varepsilon_2$, no guarantee is provided; the test may accept or reject.

---

That completes the "easy" i.i.d. case. Next, we'll remove the identical-copy assumption.
`maybe add the more specific case here that requires a stricter choice for \varepsilon_1 and \varepsilon_2`

## Medium case (independent, non-identical copies)
`copy from obsidian`
