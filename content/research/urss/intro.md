+++
title = 'URSS introduction'
date = 2025-06-24T16:10:31+01:00
ShowBreadCrumbs = true
draft = false
+++

Hello and welcome to my URSS blog! Over the coming weeks, I'll be sharing my journey into the fascinating field of quantum cryptography. There are two parts to this: "quantum", the strange and powerful world of quantum physics; and "cryptography", the science of securing information via encryption and decryption.

Let's start simple. Take this number:
$$
1984909
$$
Looks random right? Here's the challenge: can you figure out which two numbers, when multiplied together, give you this result?

Try doing it by hand - or even with a calculator. It's not so easy. This task is known as *factoring*.

Now look at this problem: What's $1117 \times 1777$?

Much easier, right? This is just *multiplication* - a basic operation every computer can do almost instantly.

This imbalance in difficulty is the core idea behind a "one-way function", and it forms the backbone of most modern classical cryptography. Your online banking, secure messaging apps, even Bitcoin, rely on this very principle: **easy to compute in one direction**, **hard to reverse**.

State-of-the-art classical cryptographic schemes, such as [RSA](https://en.wikipedia.org/wiki/RSA_cryptosystem) and [elliptic-curve cryptography](https://en.wikipedia.org/wiki/Elliptic-curve_cryptography), are built on one-way functions involving extremely large numbers that are hundreds or even thousands of digits long. The security comes from the fact that, with today's classical computers, reversing these operations (like factoring large numbers or solving the elliptic-curve discrete logarithm problem) would take an impractically long time (millions of years in some cases).

Another critical tool in modern cryptography is the *[hash function](https://en.wikipedia.org/wiki/Hash_function)*, such as [SHA-256](https://en.wikipedia.org/wiki/SHA-2). Hashing is not used for encryption, but for verifying data integrity by ensuring that files, passwords, or messages haven't been tampered with. You'll find it everywhere from password storage to blockchain mining.

All of these tools come together in the protocols that protect your data online - like [HTTPS](https://en.wikipedia.org/wiki/HTTPS), which secures your connection when you visit websites. It's what keeps others from intercepting your data on public Wi-Fi, stealing your credit card details during online shopping, or spying on your messages and personal information. Without it, everyday activities like logging into your bank, checking your email, or even just browsing would be dangerously exposed.

But that's only true in a classical world. What happens when this imbalance - the fact that some problems are easy to do, but hard to undo - no longer holds?

Enter quantum computers - machines that operate on principles of *quantum mechanics* rather than classical physics. Unlike regular bits that are either `0` or `1`, quantum bits (or **qubits**) can exist in *superpositions* of both. This gives quantum computers access to computational shortcuts that classical machines simply can't exploit.

One of the most famous quantum algorithms - [Shor's algorithm](https://en.wikipedia.org/wiki/Shor%27s_algorithm) - can factor large numbers *exponentially* faster than any known classical method. That means our "hard to reverse" assumption breaks down entirely. A powerful enough quantum computer could crack many classical encryption systems in hours or even minutes.

That's where my research comes in. A natural response to the quantum threat is to use even harder mathematical problems. But this quickly turns into an endless arms race where quantum computers may eventually win.

Instead of relying on increasingly complex maths that could still be broken, I'm exploring a fundamentally different approach:

What if we build security from the laws of quantum physics themselves?

This is the central idea of quantum cryptography. It protects data not with mathematical difficulty, but with the unbreakable principles of *how reality works*.

This project is supervised by [Dr Matthias C. Caro](https://sites.google.com/view/matthiasccaro), whose insight and support have been invaluable as I explore the intersection of quantum theory and cryptographic security.

I'm focusing on quantum-native protocols that assume quantum physics is fundamentally correct (which, based on decades of experiments, is a very safe bet).

If we can harness these principles properly, we could build cryptographic systems that remain secure no matter how powerful future computers become.

---

If you've made it this far, thank you for reading.

From this point on, I'll assume familiarity with undergraduate-level mathematics. We'll mostly be working with *linear algebra* and basic *probability theory*, which form the language of quantum mechanics.

As I've come to realise, trying to fully understand the ideas behind quantum cryptography without engaging with the maths often ends up more confusing than helpful. The maths isn't just technical detail; it is the *anchor* for intuition.

That said, I'll do my best to include clear numerical examples so you don't drown in a sea of Greek letters.

In the next posts, I'll walk through the core building blocks of quantum cryptography, starting from the mathematical and physical foundations and building up to real protocols:
- Qubits and measurement: Pure states, superposition, the Hadamard basis, standard basis measurements, post-measurement states, and the no-cloning theorem
- Quantum formalism: Mixed states, density matrices, partial trace, POVMs, Kraus operators, and the Bloch sphere
- Information and security: Trace distance, fidelity, entropy (Shannon, min-, conditional, smoothed), and the uncertainty principle via guessing games
- Entanglement and its power: EPR pairs, Schmidt decomposition, purifications, Bell nonlocality (using the CHSH game), and the monogamy of entanglement
- Quantum cryptographic primitives: Quantum one-time pad (OTP) and secret sharing
- Privacy amplification: Extracting uniform randomness using two-universal hash functions and strong seeded extractors
- Key distribution theory: $\varepsilon$-correctness, $\varepsilon$-secrecy, information reconciliation, and classical authenticated channels (CAC)
- Quantum key distribution protocols: BB'84 and its purified variant, along with a sketch of their security and correctness proofs
- `More coming soon...`

These posts will be based on Chapters 1 to 8 (excluding Chapter 3: Quantum Money) from the textbook *[Introduction to Quantum Cryptography](https://www.cambridge.org/highereducation/books/introduction-to-quantum-cryptography/1D3D1FAE02AB40BE3780EBF9E461896B#overview)*, and my own understanding. I'll aim to make each concept as intuitive and self-contained as possible while gradually building toward more advanced ideas. All credit for the textbook content goes to [Thomas Vidick](https://users.cms.caltech.edu/~vidick/) and [Stephanie Wehner](https://qutech.nl/person/stephanie-wehner/), the authors of the textbook.

After that, if time allows, I'll also explore how these quantum cryptographic protocols could be applied in real-world systems, using blockchain platforms like Bitcoin and Ethereum as a case study.

Let's build trust from the laws of the universe.
