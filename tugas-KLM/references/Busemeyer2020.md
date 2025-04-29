# Application of Quantum—Markov Open System Models to Human Cognition and Decision

---

**Authors:**

- Jerome Busemeyer 1,\*,†
- Qizi Zhang 2,†
- S. N. Balakrishnan 3,†
- Zheng Wang 4,†

**Affiliations:**

1.  Department of Psychological and Brain Sciences, Indiana University, Bloomington, IN 47405, USA
2.  Department of Mechanical and Aerospace Engineering, Missiouri University of Science Technology, Rolla, MO 65401, USA; qzwtb@mst.edu
3.  Department of Mechanical Engineering, Missiouri University of Science Technology, Rolla, MO 65401, USA; bala@mst.edu
4.  Center for Brain and Cognitive, Translational Data Analytics Institute, School of Communication, The Ohio State University, Columbus, OH 43210, USA; wang.1243@osu.edu

**Correspondence:** \* jbusemey@indiana.edu
**Contribution:** † These authors contributed equally to this work.

**Journal:** Entropy 2020, 22, 990
**DOI:** doi:10.3390/e22090990
**Website:** www.mdpi.com/journal/entropy

**Received:** 16 August 2020
**Accepted:** 2 September 2020
**Published:** 4 September 2020

---

## Abstract

Markov processes, such as random walk models, have been successfully used by cognitive and neural scientists to model human choice behavior and decision time for over 50 years. Recently, quantum walk models have been introduced as an alternative way to model the dynamics of human choice and confidence across time. Empirical evidence points to the need for both types of processes, and open system models provide a way to incorporate them both into a single process. However, some of the constraints required by open system models present challenges for achieving this goal. The purpose of this article is to address these challenges and formulate open system models that have good potential to make important advancements in cognitive science.

---

## Keywords

Markov random walk; quantum walk; open system models; evidence accumulation; preference accumulation; choice behavior; decision time; confidence

---

## 1. Introduction

One of the most fundamental topics in the cognitive and neural sciences concerns the dynamic and stochastic processes that humans (as well as other animals) use to make choices and decisions. Consider the following example of what is called a signal detection task: Suppose a radiologist is examining an image of a breast and trying to decide whether or not a cancerous node is present. The process requires accumulating evidence across time (by looking at various parts of the image) until a sufficient amount of evidence has been accumulated to make a decision. However, the decision also depends on the consequences that can occur, which depend on the true state and final choice. For example, missing a cancerous node may allow a cancer to grow into a more dangerous medical problem and falsely deciding that cancer is present produces a great deal of unnecessary stress and additional medical testing. The decision process is fundamentally probabilistic in the sense that if the same radiologist is presented the same image on two different occasions (separated in time with other images in between), she might make different decisions. In addition, the decision on each occasion takes time and the time to make the decision varies across occasions too. Finally after a decision is made, the radiologist could be asked to report how confident she is about her decision. Therefore the basic measures that are collected in a signal detection task are the probability of making each choice and confidence rating, and the distribution of decision times for each choice.

For over 50 years these types of decisions have been successfully modeled by cognitive scientists (see, e.g., [1]) and more recently also by neuroscientists (see, e.g., [2]) using Markov processes, such as random walk (discrete) or diffusion (continuous) processes. The general idea is similar to a Bayesian sequential sampling decision rule [3]. Using the radiologist example, the decision maker starts with some initial state of evidence (e.g., log likelihood) for or against the cancer hypothesis, denoted L(0). During each moment in time t, the decision samples evidence, denoted X(t), which increases or decreases the current state, L(t) = L(t − 1) + X(t). This evidence continues to be accumulated in the direction of the mean evidence μ = E[X(t)] until its magnitude exceeds a threshold bound θ at which point in time, say T, the decision maker stops and decides that cancer present if L(T) > θ or decides cancer is not present if L(T) < −θ. These Markov models of evidence accumulation provide very accurate predictions for empirical distributions of choice and decision times from human decision makers [1] as well as predicting neural activation trajectories from electrophysiological recordings of neurons in primates [2].

Despite the success of Markov processes for modeling these types of signal detection tasks, there is empirical evidence that this class of model may not provide a complete picture of human decision making. Recent research suggests that an alternative way to model evidence accumulation, based on quantum walks, is also needed [4-7]. (This article is focused on applications of quantum dynamics to human decision making. There are many other applications of quantum theory to decision making that do not involve dynamics, which are not reviewed here. See [8] for a review. Quantum theory has also been applied to strategic games, see [9] for an interesting example, but this work is outside the scope of this article.)

One line of empirical evidence supporting quantum models comes from interference effects of choice on later confidence. In one experiment [5], a signal detection task was used to compare the results from two different conditions: (1) A choice-confidence condition under which participants started observing an image at t₀ and made a binary decision regarding the image at time t₁, and then continued to observe the image until they made a confidence rating at time t₂, and (2) a confidence-alone condition under which participants again started observing an image at t₀, but simply made a pre-planned button push (to control for responding while not requiring any decision about the image) at time t₁, and then continued to observe the image until they made a confidence rating at time t₂. The critical test concerns the distribution of confidence ratings observed at time t₂ (pooled across choices at time t₁ for the choice-confidence condition). A Markov random walk model predicts no difference between conditions because it satisfies the Chapman-Kolmogorov equation and the quantum walk predicts differences, because a wave function “collapse” occurs at time t₁ under the choice-confidence condition but not under the confidence-alone condition. The results of the experiment found significant interference effects, contrary to the Markov model and supporting the quantum model. A second follow-up study, again using confidence ratings, found further support for the quantum walk over the Markov random walk [6].

A second line of empirical evidence supporting quantum models comes from temporal oscillations in preference. In one experiment [7], a preference task was used to investigate how preferences evolve across deliberation time. Participants were presented a choice between two different gift coupons for restaurants, which varied according attributes including the quality of the restaurant, the distance to the restaurant, and the monetary amount of the gift card. They rated their strength of preference for one gift over the other across a series of time points. Markov random walk models used in cognitive science to model preferences (see, e.g., [10]) predict that mean preference strength should monotonically increase across time in the direction of the alternative with greater mean utility. In contrast, a quantum walk model predicts that preferences should oscillate while moving in the direction of the alternative with greater mean utility. The results of the experiment found significant oscillation effects, contrary to the Markov model and supporting the quantum model.

In addition to these lines of evidence, quantum dynamics have been used to account for violations of rational decision making [11], as well as several dynamic decision inconsistencies [12].

In sum, properties of both Markov and quantum walk models may be needed to capture the full probabilistic dynamics underlying human choice and decision making. More fundamentally, Markov and quantum models represent two different types of uncertainty in the decision process [13]. Markov models represent an epistemic type of uncertainty in which an outside observer is uncertain about the internal location of evidence of the decision maker. Quantum models represent an ontic type of uncertainty in which there is no preexisting location of evidence before a decision is made. Instead, at each moment, the decision maker is in a superposed state with several different levels of evidence having potential to be realized, so that the decision maker has internal uncertainty about the level of evidence. Open system models are ideally suited for combining these two different types of dynamics into a single unified process [11,14-17].

Open system models were developed to represent quantum systems that are described by a combination of a target system of interest coupled to a complex and uncontrolled environment [18]. The original system-plus-environment model relies on purely unitary dynamics that generate interactions between the system and environment. The open system dynamics is derived from unitary dynamics by marginalizing (partial tracing) over the environment to focus on the dynamics of the system alone. The dynamics of the resulting open system starts out in a quantum regime in a “coherent" superposition state however, the dynamics produced by the environment produce decoherence and eventually reduces the system to a classical probability mixture that evolves according to a classical Markov system.

Methods for constructing open system models for applications in physics have been very thoroughly developed. But how can this work in cognitive science? The purpose of this article is to provide some guidelines for applying open system models to cognitive science in a compelling and effective manner.

## 2. Results

Before jumping into the general open system model, it may be helpful to first review versions of Markov and quantum walk processes in isolation. Both quantum and Markov processes can be developed using any combination of discrete versus continuous state, and discrete versus continuous time assumptions. For example, a standard random walk is a discrete state and time Markov chain, and the diffusion model is a continuous state and time Markov process, and quantum models for position and momentum are continuous state and time processes, but the "coin" quantum walk (for review, see [19]) is a discrete time and state model. Furthermore, note that as the increments between states and time steps decrease in size, the discrete models converge to the continuous models (see, e.g., Ref. [20], for Markov processes and Ref. [21] for quantum processes). For ease of presentation, we will work with Markov and quantum walks that are discrete state and continuous time. We present the two different classes of models in a parallel manner to illustrate their common and distinctive features.

### 2.1. Comparison of Markov and Quantum Walk Models

Consider a model in which the decision maker represents their beliefs within a N = 101 dimensional vector space. The 101 basis vectors (eigenstates), symbolized as {|0⟩, |1⟩, . . . , |99⟩, |100⟩}, represent 101 increasing levels of evidence for one hypothesis over another. Using the radiologist example, the basis vector |0⟩ represents 0.00 likelihood that cancer is present (1.0 likelihood that there is no cancer), |35⟩ represents a 0.35 likelihood favoring cancer, |50⟩ represents equal likelihood, |65⟩ represents a 0.65 likelihood favoring the cancer, and |100⟩ represents a 1.0 likelihood favoring cancer (0.00 likelihood of no cancer). This fine grain evidence scale provides a close approximation of the finite state model to a continuous state model. (Cognitive science models, see, e.g.,[1], often use a continuous scale of evidence.)

Using the evidence basis to form a belief state, each basis vector can be assigned a coordinate value. For a Markov model, each coordinate is a probability, φⱼ, representing the probability that the system is located at that level of evidence. For a quantum model, each coordinate is a complex amplitude, ψⱼ representing the potential to observe that level of evidence. The 101 coordinate values form a 101 × 1 column matrix denoted here as φ for a Markov model and ψ for a quantum model.

Suppose ξ is an arbitrary vector in the space. A Markov model uses an L₁ norm defined by ||ξ||₁ = Σⱼ |ξⱼ|¹ to define length, and requires ||φ||₁ = Σⱼ |φⱼ|¹ = 1. In other words, the probabilities must sum to one. A quantum model uses an L₂ norm defined by ||ξ||₂ = Σⱼ |ξⱼ|² and requires ||ψ||₂ = Σⱼ |ψⱼ|² = 1. In other words the squared magnitudes of the amplitudes must sum to one.

A measurement in this space is represented by a projector. With respect to the evidence basis, the projector is simply a diagonal matrix, denoted as M<0xE1><0xB5><0xA3> for response R, with zeros everywhere except one's located at levels of evidence that represent the response. For example, a response to report a confidence rating equal to 0.65 could be represented by a diagonal matrix M₆₅ with a one located at the row 66 (corresponding to the basis vector |65⟩) and zeros elsewhere. A response to decide cancer is present could be represented by a diagonal matrix M<0xE1><0xB5><0x84> with one's located at rows 51 to 100 and zeros otherwise. For a Markov model, the probability of a response R is given by p(R) = ||M<0xE1><0xB5><0xA3> · φ||₁. For a quantum model, the probability of a response R is given by p(R) = ||M<0xE1><0xB5><0xA3> · ψ||₂.

The state φ(t) of a Markov model evolves across time according to the Kolmogorov forward equation dφ(t)/dt = K · φ(t) (assuming time invariance), where K is the generator or intensity matrix. The solution to this differential equation is φ(t) = e^(K·t) · φ(0), where T(t) = e^(K·t) is the transition matrix for time t. The generator K must have positive off diagonal entries and columns that sum to zero in order to produce a transition matrix T(t). The transition matrix T(t) must contain transition probabilities that sum to unity within each column to generate a new state φ(t) containing probabilities that sum to unity.

The state ψ(t) of a quantum model evolves across time according to the Schrödinger equation dψ(t)/dt = −i · H · ψ(t) (assuming time invariance), where H is the Hamiltonian matrix. The solution to this differential equation is ψ(t) = e^(−i·H·t) · ψ(0), where U(t) = e^(−i·H·t) is a unitary matrix for time t. The Hamiltonian matrix H must be Hermitian in order to produce a unitary operator U(t). The unitary matrix U(t) must be an orthonormal matrix in order to generate a new state ψ(t) containing amplitudes with squared magnitudes that sum to unity.

For example, according to a Markov model, the probability of deciding cancer is present at time t₁ and then giving a confidence rating equal to 65 at time t₂ equals: p(R(t₁) = R<0xE1><0xB5><0x84>, R(t₂) = R₆₅) = ||M₆₅ · T(t₂ - t₁) · M<0xE1><0xB5><0x84> · T(t₁ - t₀) · φ(0)||₁ and according to a quantum model, p(R(t₁) = R<0xE1><0xB5><0x84>, R(t₂) = R₆₅) = ||M₆₅ · U(t₂ - t₁) · M<0xE1><0xB5><0x84> · U(t₁ − t₀) · ψ(0)||₂. Essentially, a Markov model operates with a transition matrix on probabilities and uses the L₁ norm, but a quantum model operates on amplitudes with a unitary operator and uses the L₂ norm.

### 2.2. Representation of States by Density Operators

We can reformulate a pure quantum process using states described by a density operator instead of a state vector. A state vector ψ can be turned into a density matrix ρ by forming the projector ρ = ψ · ψ†. The quantum evolution of the density matrix is then given by dρ(t)/dt = −i · [H · ρ(t) − ρ(t) · H] = −i · [H, ρ(t)] with solution ρ(t) = U(t) · ρ(0) · U(t)†. The advantage of this state representation is that it provides a more general formulation of the state by encompassing a probability mixture across pure states, ρ(t) = Σⱼ pⱼ · ψⱼ · ψ†ⱼ. By linearity, this more general density matrix continues to follow the same quantum evolution equation dρ(t)/dt = −i · [H, ρ(t)]. The density matrix thus contains two different types of uncertainty: Epistemic uncertainty in which an outside observer is uncertain about the state of the decision maker, and ontic uncertainty in which the decision maker is in a superposition state over evidence.

The diagonal entries of the density matrix contain the probabilities of observing the N = 101 evidence levels. The probability of a response R is now computed by the trace p(R) = Tr [M<0xE1><0xB5><0xA3> · ρ · M†<0xE1><0xB5><0xA3>]. For example, p(R(t₁) = R<0xE1><0xB5><0x84>, R(t₂) = R₆₅) = Tr[M₆₅ · U(t₂ - t₁) · M<0xE1><0xB5><0x84> · U(t₁ – t₀) · ρ(0) · U†(t₁ − t₀) · M†<0xE1><0xB5><0x84> · U†(t₂ – t₁) · M†₆₅]. Now we turn to the more general open system process that contains both quantum and Markov components.

### 2.3. The Open System Model

An open system model operates on a density matrix operating within the vector space rather than a state vector. The open system model describes the evolution of the density matrix using the following master equation:

```
dρ(t)/dt = -i · (1 - w) · [H, ρ(t)] + w · Σᵢⱼ γᵢⱼ · ( Lᵢⱼ · ρ(t) · L†ᵢⱼ − 0.5 · {L†ᵢⱼ · Lᵢⱼ, ρ(t)} )   (1)
```

The master equation is a weighted sum of two components: The first component represents the contribution from the quantum evolution and the second component contains what are called the Lindblad operators that generate the Markov contribution. The weight 0 ≤ w ≤ 1 determines the relative importance of each contribution. The coefficients γᵢⱼ form a matrix G, which is required to be positive semi definite to guarantee that the master equation generates a density matrix. The matrices Lᵢⱼ are the Lindblad operators that are discussed below in Section 2.4, and {L†ᵢⱼ · Lᵢⱼ, ρ} = (L†ᵢⱼ · Lᵢⱼ) · ρ + ρ · (L†ᵢⱼ · Lᵢⱼ). The trace of dρ(t)/dt must equal zero so that the trace of the density ρ(t) continues to equal to one across time. This implies that when w = 1, the trace of the Lindblad component must be zero.

There are at least two different ways to solve Equation (1). One way is to directly solve the differential equation, perhaps using numerical methods. A second way, described by [11,22], is to vectorize the statevarrho = Vec [ρ] by stacking each column of ρ on top of each other to form a N² × 1 vector. (Note that Vec is a linear operation.) Equation (1) is linear with respect to ρ, which implies that we can rewrite Equation (1) as a linear differential equation in the form dvarrho/dt = L · varrho, with:

```
L · varrho = −i · (1 – w) · Vec ([H,ρ]) + w · Σᵢⱼ γᵢⱼ · (Vec (Lᵢⱼ · ρ · L†ᵢⱼ) − 0.5 · Vec({L†ᵢⱼ · Lᵢⱼ, ρ}))
```

which has the solution varrho(t) = e^(t·L) · varrho(0). To identify the operator L, the following tensor identity is useful (see [23], p. 333): Vec [XYZ] = (Zᵀ ⊗ X) · Vec(Y) where X, Y, Z are matrices, and Zᵀ is the matrix transpose (without conjugation). Then we can write L · varrho using the following identities:

```
Vec (H · ρ · I - I · ρ · H) = (I ⊗ H − Hᵀ ⊗ I) · varrho
Vec (Lᵢⱼ · ρ · L†ᵢⱼ) = (Lᵢⱼ* ⊗ Lᵢⱼ) · varrho
Vec ((L†ᵢⱼ · Lᵢⱼ) · ρ · I) = (I ⊗ (L†ᵢⱼ · Lᵢⱼ)) · varrho
Vec (I · ρ · (L†ᵢⱼ · Lᵢⱼ)) = ((L†ᵢⱼ · Lᵢⱼ)ᵀ ⊗ I) · varrho
```

_(Note: Lᵢⱼ_ denotes complex conjugate, which wasn't explicitly mentioned but implied by L† notation in tensor products)\*

Collecting these terms together produces:

```
L = −i · (1 − w) · (I ⊗ H − Hᵀ ⊗ I)
    + w · Σᵢⱼ γᵢⱼ ( (Lᵢⱼ* ⊗ Lᵢⱼ) − 0.5 · (I ⊗ (L†ᵢⱼ · Lᵢⱼ) + ((L†ᵢⱼ · Lᵢⱼ)ᵀ ⊗ I) )
```

### 2.4. Application to Cognitive Science

The first main challenge that a cognitive scientist must face when trying to apply this open system model is to define the Lindblad operators Lᵢⱼ. We recommend following [11,22], and define Lᵢⱼ = |i⟩ ⟨j|, where |i⟩ is a column vector with zeros everywhere except for a one located in the row corresponding to the basis vector |i⟩, and ⟨j| is a row vector with zeros everywhere except for a one located in the column corresponding to ⟨j|. Then the operator Lᵢⱼ represents the transition to |i⟩ from |j⟩.

The second main challenge is to select the coefficients γᵢⱼ that form the matrix G. Using Lᵢⱼ = |i⟩ ⟨j|, these coefficients can be set equal to the transition probabilities Tᵢⱼ(τ) of a Markov chain model. This method provides a direct connection to Markov models familiar to cognitive scientists. The coefficients γᵢⱼ can be set equal to the transition probabilities Tᵢⱼ(τ) of a Markov chain model.

Obviously, if we set w = 0, then we obtain exactly the original quantum dynamics for the density matrix. To see how the second (Lindblad) component of Equation (1) is related to a Markov process, we assume w = 1.

Using Equation (1) with w = 1, first we examine the contributions to the ρ<0xE2><0x82><0x96><0xE2><0x82><0x96> diagonal element of the density matrix ρ (the following analysis was provided by [11]):

```
⟨k| Σᵢⱼ γᵢⱼ · Lᵢⱼ · ρ · L†ᵢⱼ |k⟩ = ⟨k| Σᵢⱼ γᵢⱼ · |i⟩ ⟨j| · ρ · |j⟩ ⟨i| |k⟩
                         = Σⱼ ρ<0xE1><0xB5><0xBB><0xE1><0xB5><0xBB> · Σᵢ γᵢⱼ · ⟨k|i⟩ ⟨i|k⟩  (should be ⟨k|i⟩ ⟨j|ρ|j⟩ ⟨i|k⟩?)
                         = Σⱼ ρ<0xE1><0xB5><0xBB><0xE1><0xB5><0xBB> · γ<0xE2><0x82><0x96>ⱼ,  (assuming ⟨k|i⟩=δki, ⟨i|k⟩=δik, Σᵢ γᵢⱼ δ<0xE2><0x82><0x96>ᵢ δᵢ<0xE2><0x82><0x96> = γ<0xE2><0x82><0x96>ⱼ )

⟨k| Σᵢⱼ γᵢⱼ · L†ᵢⱼ · Lᵢⱼ · ρ |k⟩ = ⟨k| Σᵢⱼ γᵢⱼ · |j⟩ ⟨i|i⟩ ⟨j| ρ |k⟩
                            = Σᵢ γᵢ<0xE2><0x82><0x96> · ρ<0xE1><0xB5><0xBB><0xE2><0x82><0x96>,  (assuming ⟨i|i⟩=1, ⟨k|j⟩=δkj, ⟨j|ρ|k⟩=ρjk)

⟨k| Σᵢⱼ γᵢⱼ · ρ · L†ᵢⱼ · Lᵢⱼ |k⟩ = Σᵢⱼ γᵢⱼ · ⟨k| ρ |j⟩ ⟨i|i⟩ ⟨j|k⟩
                            = Σᵢ γᵢ<0xE2><0x82><0x96> · ρ<0xE2><0x82><0x96><0xE2><0x82><0x96>.  (assuming ⟨i|i⟩=1, ⟨j|k⟩=δjk)
```

_(Note: The derivations in the text seem slightly simplified/potentially contain typos, especially the first one. The final result is likely correct under standard assumptions)_

Therefore we obtain the final result:

```
dρ<0xE2><0x82><0x96><0xE2><0x82><0x96>(t)/dt = Σⱼ ρ<0xE1><0xB5><0xBB><0xE1><0xB5><0xBB> γ<0xE2><0x82><0x96>ⱼ - Σᵢ γᵢ<0xE2><0x82><0x96> · ρ<0xE2><0x82><0x96><0xE2><0x82><0x96>
```

If we set G = T(τ), then Σᵢ γᵢ<0xE2><0x82><0x96> = 1, because the columns of the transition matrix must sum to one. Assuming G = T(τ), if we define φ(t) as the diagonal of ρ then:

```
dφ(t)/dt = T(τ) · φ(t) - I · φ(t)
         = (T(τ) – I) · φ(t).
```

Note that if G = T(τ) then as required 1ᵀ · (T(τ) − I) · φ(t) = 1ᵀ · (T(τ) · φ(t)) – 1ᵀ · φ(t) = 1 - 1 = 0 (where 1ᵀ is a row vector containing all one's).

Recall that the continuous time Markov process is based on a generator K = lim<0xE1><0xB5><0x8F>→₀ (T(τ)−I)/τ, and obeys the equation dφ(t)/dt = K · φ(t). Comparing this to the final form of the Lindblad equation, dφ(t)/dt = (T(τ) – I) · φ(t), we see that they are not quite the same.

If instead we set G = K, then Σᵢ γᵢ<0xE2><0x82><0x96> = 0, and the Lindblad component becomes identical to the Markov process on the diagonal elements of ρ. When w = 1, this is not a problem because the diagonals exactly follow the Markov process. But if 0 ≤ w < 1, then this could become a problem because K is negative definite (the columns of K sum to zero) and the open system involving both the quantum and Lindblad components are no longer guaranteed to maintain a density matrix across time.

One possible bridge between the two is obtained by setting G = (T(τ)/τ) for a very small value of 0 < τ ≤ 1. Using this assignment, the Lindblad component produces: dφ(t)/dt = ((T(τ)−I)/τ) · φ(t). This could be used to approximate K but at the same time maintain a positive semi-definite G. However, this proposal runs into trouble when we examine the off diagonals.

Returning to Equation (1) with w = 1, next we examine the contributions to the ρ<0xE2><0x82><0x96>l off diagonal element of the density matrix ρ (the following analysis was provided by the second author):

```
⟨k| Σᵢⱼ γᵢⱼ · Lᵢⱼ · ρ · L†ᵢⱼ |l⟩ = ⟨k| Σᵢⱼ γᵢⱼ · |i⟩ ⟨j| · ρ · |j⟩ ⟨i| |l⟩
                         = Σⱼ ρ<0xE1><0xB5><0xBB><0xE1><0xB5><0xBB> · Σᵢ γᵢⱼ · ⟨k|i⟩ ⟨i|l⟩ = 0  (since ⟨k|i⟩ and ⟨i|l⟩ require i=k and i=l simultaneously, impossible if k≠l)

⟨k| Σᵢⱼ γᵢⱼ · L†ᵢⱼ · Lᵢⱼ · ρ |l⟩ = ⟨k| Σᵢⱼ γᵢⱼ · |j⟩ ⟨i|i⟩ ⟨j| ρ |l⟩
                            = Σᵢ γᵢ<0xE2><0x82><0x96> · ρ<0xE2><0x82><0x96>l

⟨k| Σᵢⱼ γᵢⱼ · ρ · L†ᵢⱼ · Lᵢⱼ |l⟩ = Σᵢⱼ γᵢⱼ · ⟨k| ρ |j⟩ ⟨i|i⟩ ⟨j|l⟩
                            = Σᵢ γᵢl · ρ<0xE2><0x82><0x96>l
```

_(Note: Again, slight index confusion in the original derivations. The final result seems correct under standard interpretation)_

Therefore we obtain the final result:

```
dρ<0xE2><0x82><0x96>l(t)/dt = - ρ<0xE2><0x82><0x96>l ( Σᵢ γᵢ<0xE2><0x82><0x96> + Σᵢ γᵢl ) / 2  (The paper shows: - ρ<0xE2><0x82><0x96>l (Σᵢ γᵢ<0xE2><0x82><0x96>))
```

_(Note: Standard Lindblad form leads to decay rate related to sum of rates out of k and l. The paper's result seems simplified.)_

If we set G = T(τ), then Σᵢ γᵢ<0xE2><0x82><0x96> = 1 and dρ<0xE2><0x82><0x96>l(t)/dt = -ρ<0xE2><0x82><0x96>l producing exponential decay of the off diagonals. Alternatively, if we set G = K, then Σᵢ γᵢ<0xE2><0x82><0x96> = 0 and dρ<0xE2><0x82><0x96>l(t)/dt = 0 with no decay of the off diagonals. Finally, if we set G = (T(τ)/τ), then dρ<0xE2><0x82><0x96>l(t)/dt = -ρ<0xE2><0x82><0x96>l/τ, which very rapidly reduces the off diagonals when τ is very small.

A different way to compare models is to examine the probability distributions over time produced by a Markov process versus the Lindblad process. For small τ, the Markov process can be approximated by the equation dφ(t)/dt = ((T(τ)−I)/τ) · φ(t) with solution φ(t) = e^((T(τ)−I)·(t/τ)) · φ(0). The Lindblad component obeys the equation dφ(t)/dt = (T(τ) – I) · φ(t) with solution φ(t) = e^((T(τ)−I)·t) · φ(0). This comparison shows that both models produce the same probability distributions, but over different time scales: t/τ for the Markov process and a slower time t for the Lindblad component.

## 3. Examples

A couple of examples are presented to illustrate the predictions from the open system model, Equation (1), with Lᵢⱼ = |i⟩ ⟨j|.

Consider a simple N = 2 dimensional open system with two possible responses: An up (e.g., no) state represented by ρ₁₁ and a down (e.g., yes) state represented by ρ₂₂. Suppose w = 0.5, H = [[0, 1], [1, 1]] and K = [[-β, α], [β, -α]] and we set G = K. Then Equation (1) reduces to:
(Equation shown involves derivatives of ρ₁₁, ρ₁₂, ρ₂₁, ρ₂₂ based on H and K components)

```
dρ/dt = -i * 0.5 * ([H, ρ]) + 0.5 * (Kρ + ρKᵀ - {KᵀK, ρ})  <- Simplified representation of the Lindblad term with G=K
```

_(The explicit matrix form from the paper is more detailed)_

This model starts out oscillating like a quantum process, but eventually converges to the equilibrium of a Markov process. Figure 1 shows the probability of the down state (e.g., yes response) as a function of time. The black curve represents the probabilities generated by the 2-dimensional process with G = K. The equilibrium state is obtained as follows. First, dρ₂₁/dt = 0 implies that (2ρ₁₁ – 1) + ρ₂₁ = 0, which implies ρ₂₁ = 1 – 2ρ₁₁, and also (because ρ is Hermitian) that ρ₂₁ − ρ₁₂ = 0. Next dρ₂₂/dt = 0 implies ρ₁₁ · (α + β) - α = 0 so that ρ₁₁ = α/(α+β) and ρ₂₂ = β/(α+β), which exactly matches the asymptotic result obtained when w = 1, which produces a pure Markov process (see Figure 1, red curve). Note also that the asymptotic off diagonal element ρ₂₁ = 1 − 2 · ρ₁₁ = (β−α)/(α+β) = ρ₂₂ − ρ₁₁. Thus the system converges to a coherent density matrix. Without the Lindblad contribution, convergence to an equilibrium state, independent of the initial state, would not be possible. If ρ₂₁ = 1 – 2ρ₁₁ in the density matrix, then the density is generated by an eigen state of H, and the initial and final states remain the same.

**[Figure 1 Description]** Figure 1 plots the probability of the 'yes' state (ρ₂₂) over time for four models: Open-K (black, oscillates then converges to Markov equilibrium), Open-T (green, oscillates then converges to slightly lower equilibrium), Pure Markov (red, monotonic increase to equilibrium), Pure Quantum (blue, persistent oscillations). The x-axis is Time in arbitrary units, y-axis is Probability of state down response. Open-K and Pure Markov converge to β/(α+β).

Alternatively, suppose w = 0.5, H = [[0, 1], [1, 1]] and T = e^(K·τ), with τ sufficiently large to reach the equilibrium transition matrix T = (1/(α+β)) \* [[α, α], [β, β]] and we set G = T. The green curve in Figure 1 shows the probability of the down state (e.g., the yes response) as a function of time for the 2-dimensional process with G = T(τ). Then Equation (1) reduces to:
(Equation shown involves derivatives of ρ₁₁, ρ₁₂, ρ₂₁, ρ₂₂ based on H and T components)

In this case, the equilibrium state is obtained as follows. First, dρ₂₁/dt = 0 implies that ρ₂₁ = -0.5 · (1 + i) · (2 · ρ₁₁ – 1). Note that i· (ρ₂₁ − ρ₁₂) = 1 − 2 · ρ₁₁. Then, dρ₁₁/dt = 0 implies that ρ₁₁ = α/(α+β), and ρ₂₂ = β/(α+β), and the latter falls below the asymptote β/(α+β) of a pure Markov process. Finally, ρ₂₁ = (-0.5)(1+i) · (1 - 2 _ α/(α+β)).
_(Note: There seems to be a contradiction or complexity here; dρ₁₁/dt = 0 suggests equilibrium ρ₁₁ = α/(α+β), but the text says the result "falls below" the Markov asymptote. The green curve in Fig 1 confirms it converges _lower_ than the red/black curves.)\*

Now consider another example with a large (N = 101) number of levels of evidence. For a pure Markov process, we use a generator K that has the following tridiagonal form to produce a Markov random walk:
K = (tridiagonal matrix with -β, α on super/sub-diagonals, adjusting at boundaries)
The mean drift rate for this Markov random walk is defined by μ = (β − α) /2 and the diffusion rate is defined by σ² = (β + α)/2. In this example, we used a positive mean drift rate μ > 0 that pushes the probability distribution to the right (high evidence levels). This generator uses reflecting bounds, which produces a unique invariant distribution [20].

For a pure quantum process, we use a Hamiltonian H that has the following tridiagonal form to produce a quantum walk:
H = (tridiagonal matrix with potential μᵢ on diagonal, coupling σ on sub/super-diagonals)
The diagonal contains the potential function, μ(x), which can be defined by a quadratic potential μ(x) = a + b·x + c·x². In this example, we simply used a linearly increasing potential, b > 0, a = 0, c = 0, that pushes the distribution of squared amplitudes toward the right (high levels of evidence). Once the wave hits the reflecting bound, it bounces back producing oscillation and interference. This pure quantum process never reaches an invariant state [19].

Below we compare four different models (see https://jbusemey.pages.iu.edu/quantum/ HilbertSpaceModelPrograms.htm for the Matlab program used to make these computations). A pure Markov model, a pure quantum model, an open system model with G = K (the generator for the pure Markov process), and an open system model with G = T(τ). To match the time scales of the pure Markov process and the open system model with G = T(τ), we set the time scale of the latter to t/τ. The initial distribution, φ(0), was a discrete approximation to a Gaussian distribution centered at the middle of the evidence scale for a pure Markov process and the square root of this distribution was used for the initial state ψ(0) of the quantum and open system models.

First we examine the open system model when w = 1. This should reduce the two open system models to a pure Markov process. (For the open system with G = T(τ), we set τ = 10⁻³ to obtain a good approximation to the pure Markov process.) The left panel of Figure 2, shows the probability distribution over evidence levels produced at a moderately short time interval. Only two curves can be seen. One is the bell-shaped curve produced by the pure quantum model. The potential function moved the distribution of squared amplitudes from the initial state in the middle, 0.50, up toward the right with a mode around 0.70. The other curve actually includes three overlapping curves produced by the pure Markov model and the two open system models with w = 1. This simply shows that the open system does indeed reproduce the Markov model when the quantum component is eliminated.

**[Figure 2 Left Panel Description]** Left panel plots probability distribution across evidence levels (x-axis 0 to 1) for w=1 at a fixed time. Shows two distinct curves: Pure Quantum (bell shape shifted right, mode ~0.7) and three overlapping curves for Pure Markov, Open System (G=K), and Open System (G=T) appearing as one curve peaking earlier (~0.6) than quantum but shifted right from the initial center (0.5).

Next we examine the open system model when w = 0.5. The right panel of Figure 2 shows the mean evidence across time produced by the pure quantum model, the pure Markov model, the open system model with G = K, and the open system model with G = T(1). As can be seen in the right panel, the pure quantum process oscillates between 0.5 and 0.75 indefinitely. The pure Markov process monotonically increases to an asymptote equal to 0.86. The open system model with G = K starts out oscillating like the quantum model, but then converges to the same equilibrium, 0.86, of the Markov model. The open system model with G = T(1) starts out oscillating like the quantum model, but then converges to a lower equilibrium 0.82 than the Markov model. The supplement provides the first order equations that need to be satisfied for equilibrium (see Supplementary Materials).

**[Figure 2 Right Panel Description]** Right panel plots mean evidence (y-axis 0.3 to 0.9) versus time (x-axis 0 to 5). Shows four curves: Pure Quantum (blue, oscillates between 0.5 and ~0.75), Pure Markov (red, monotonically increases to asymptote ~0.86), Open System G=K (black, oscillates initially like quantum then converges to Markov asymptote ~0.86), Open System G=T (green, oscillates initially like quantum then converges to a lower asymptote ~0.82).

## 4. Summary and Concluding Comments

For over 50 years cognitive scientists have successfully modeled choice probability and distribution of choice times for human decision making using Markov random walk or diffusion processes. However, there is new empirical evidence that these models may not be sufficient and quantum walks may be needed to capture some behavior that can not easily be explained by Markov processes. This new evidence includes interference effects of choice on later confidence and temporal oscillations in preference. Thus both types of processes may be needed and a promising way to combine the two processes is by using open system models. An open system combines quantum and Markov components into a single dynamic process.

One might argue that a simpler way to combine Markov and quantum processes together is simply to form a weighted average of the two separate probability distributions produced by the two separate processes. This is quite different from an open system, which computes a single probability distribution from a single unified process containing both quantum and Markov components. We think the open system is preferred for two important reasons. One is that open systems provide the proper dynamics by starting out in a quantum oscillatory regime and later converge to a Markov regime that reaches an equilibrium. Simply averaging the two processes would create dynamics in which both processes are always operating and present. In particular, a weighted average would continue oscillating indefinitely and never converge to an equilibrium. A second reason is the interpretation of the systems. An open system describes the dynamics of two different types of uncertainty: Epistemic uncertainty in which an outside observer is uncertain about the state of the decision maker, and ontic uncertainty in which the decision maker is in a superposition state over evidence. A simple weighted average would imply that a person's state is somehow switching from time to time from an epistemic type of uncertainty about the state to an ontic uncertainty about the state.

In this article we reviewed pure Markov random walks, quantum walks, and open systems. We also reviewed two different methods for computing the predictions of an open system: One is to numerically solve the differential equations, and the second is to vectorize the matrix system. We recommend that latter because it provides predictions that can be computed directly from a matrix exponential function.

We also covered important challenges toward applications of open systems to cognitive science. One is the choice of Lindblad operators that form the Lindblad or Markov component of the open system. We recommend following the suggestion by [11] to use the basic transition operators Lᵢⱼ = |i⟩ ⟨j| which describe the transitions to state i from state j, making the model similar to Markov chains that are familiar to cognitive scientists.

A second challenge is to define the Lindblad coefficients that form the matrix G. This turned out to be a bit more complicated. On the one hand, one could set G = K, where K is the generator of a continuous time Markov process. This has the advantage of reducing as a special case directly to a continuous time Markov process when the full weight is applied to the Lindblad component. The disadvantage is that it is no longer guaranteed to produce a density matrix across time. The trace always sums to unity but the diagonals could go negative. In all the examples that we have examined, this has not been a major problem, but it could happen. On the other hand, one could set G = T(τ), where T(τ) is the transition matrix produce by the generator K. This has the advantage of guaranteeing the system always generates a density matrix. However, it has the disadvantage of requiring one to estimate an additional parameter τ, and it does not reduce to a continuous time Markov process when the full weight is applied to the Lindblad operator. Instead it operates on a time scale inversely related to τ. It is too early to say which choice of G is best. We recommend trying both ways at this stage. That way one can try G = K and check to see if this causes problems with the density and also try G = T(τ) and check to see if the time scale becomes a problem. Furthermore, because the predictions from the two choices for G will not be the same, one can check to see which one actually accounts for the behavioral data best.

Finally one advantage of using the open system as opposed to only the Markov system or only the quantum system is that the fit of the model to data can be used to determine the weight w on each component. If the quantum system is not needed, this weight will reduce to one. However, in applications so far, substantial weight (w ≈ 0.7 on the Lindblad) has been needed to account for the findings [7,11].

---

**Supplementary Materials:** The following are available online at http://www.mdpi.com/1099-4300/22/9/990/s1.

**Author Contributions:** Conceptualization, J.B. and S.N.B.; formal analysis, Q.Z. and J.B.; writing—original draft preparation, J.B., Q.Z., and Z.W.; writing—review and editing, Z.W.; funding acquisition, J.B. All authors have read and agreed to the published version of the manuscript.

**Funding:** This research was funded by Air Force Office of Scientific Research grant FA9550-20-1-0027.

**Acknowledgments:** We thank Jan Broekaert for comments and suggestions.

**Conflicts of Interest:** The authors declare no conflict of interest.

---

## References

1.  Ratcliff, R.; Smith, P.L.; Brown, S.L.; McCoon, G. Diffusion decision model: Current history and issues. Trends Cogn. Sci. **2016**, _20_, 260–281. [CrossRef] [PubMed]
2.  Shadlen, M.N.; Kiani, R. Decision making as a window on congnition. Neuron **2013**, _80_, 791–806. [CrossRef] [PubMed]
3.  DeGroot, M.H. Optimal Statistical Decisons; John Wiley & Sons: Hoboken, NJ, USA, 2004.
4.  Busemeyer, J.R.; Wang, Z.; Townsend, J. Quantum Dynamics of Human Decision Making. J. Math. Psychol. **2006**, _50_, 220–241. [CrossRef]
5.  Kvam, P.D.; Pleskac, T.J.; Yu, S.; Busemeyer, J.R. Interference Effects of Choice on Confidence. Proc. Natl. Acad. Sci. USA **2015**, _112_, 10645–10650. [CrossRef] [PubMed]
6.  Busemeyer, J.R.; Kvam, P.D.; Pleskac, T.J. Markov versus quantum dynamic models of belief change during evidence monitoring. Sci. Rep. **2019**, _9_, 18025. [CrossRef] [PubMed]
7.  Kvam, P.D.; Busemeyer, J.R.; Pleskac, T.J. Temporal Oscillations in Preference Strength: Evidence for an Open System Model of Constructed Preference. 2020. Available online: https://psyarxiv.com/cb26p/ (accessed on 13 May 2020).
8.  Ashtiani, M.; Azgomi, M.A. A survey of quantum-like approaches to decision making and cognition. Math. Soc. Sci. **2015**, _75_, 49–80. [CrossRef]
9.  Makowski, M.; Piotrowski, E.W.; Sładkowski, J. Do transitive preferences always result in indifferent divisions? Entropy **2015**, _17_, 968–983. [CrossRef]
10. Busemeyer, J.R.; Gluth, S.; Rieskamp, J.; Turner, B.M. Cognitive and neural bases of multi-attribute, multi-alternative, value-based decisions. Trends Cogn. Sci. **2019**, _23_, 251–263. [CrossRef] [PubMed]
11. Martínez-Martínez, I.; Sánchez-Burillo, E. Quantum stochastic walks on networks for decision-making. Sci. Rep. **2016**, _6_, 23812. [CrossRef] [PubMed]
12. Yukalov, V.I. Evolutionary Processes in Quantum Decision Theory. Entropy **2020**, _22_, 681. [CrossRef]
13. Busemeyer, J.R.; Kvam, P.D.; Pleskac, T.J. Comparison of Markov versus quantum dynamical models of human decision making. WIREs **2020**, _11_, e1576. [CrossRef]
14. Accardi, L.; Khrennikov, A.; Ohya, M. Quantum Markov model for data from Shafir-Tversky experiments in cognitive psychology. Open Syst. Inf. Dyn. **2009**, _16_, 371–385. [CrossRef]
15. Asano, M.; Ohya, M.; Tanaka, Y.; Khrennikov, A.; Basieva, I. On application of Gorini-Kossakowski- Sudarshan-Lindblad equation in cognitive psychology. Open Syst. Inf. Dyn. **2011**, _18_, 55–69. [CrossRef]
16. Asano, M.; Ohya, M.; Tanaka, Y.; Basieva, I.; Khrennikov, A. Quantum-like model of brain’s functioning: Decision making from decoherence. J. Theor. Biol. **2011**, _281_, 56–64. [CrossRef] [PubMed]
17. Fuss, I.G.; Navarro, D.J. Open parallel cooperative and competitive decsision processes: A potential provenance for quantum probability decision models. Top. Cogn. Sci. **2013**, _5_, 818–843.
18. Rivas, A.; Huelga, S.F. Open Quantum Systems; Springer: Berlin/Heidelberg, Germany, 2012; Volume 13.
19. Kempe, J. Quantum random walks: An introductory overview. Contemp. Phys. **2003**, _44_, 307–327. [CrossRef]
20. Bhattacharya, R.N.; Waymire, E.C. Stochastic Processes with Applications; Wiley: Hoboken, NJ, USA, 1990.
21. Feynman, R.; Hibbs, A. Quantum Mechanics and Path Integrals; McGraw-Hill: New York, NY, USA, 1965.
22. Sanchez-Burillo, E.; Duch, J.; Gomez-Gardenes, J.; Zueco, D. Quantum navigation and ranking in complex networks. Sci. Rep. **2012**, _2_, 605. [CrossRef] [PubMed]
23. Searle, S.R. Matrix Algebra Usful for Statistics; John Wiley & Sons: Hoboken, NJ, USA, 1982.

---

© 2020 by the authors. Licensee MDPI, Basel, Switzerland. This article is an open access article distributed under the terms and conditions of the Creative Commons Attribution (CC BY) license (http://creativecommons.org/licenses/by/4.0/).
