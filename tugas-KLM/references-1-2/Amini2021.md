# hhsmm: An R package for hidden hybrid Markov/semi-Markov models

## Metadata

- **Authors:** Morteza Amini¹, Afarin Bayat², Reza Salehian³
- **Affiliation:** Department of Statistics, School of Mathematics, Statistics and Computer Science, University of Tehran, Tehran, Iran
- **Date:** May 31, 2022 (arXiv version date: 29 May 2022)
- **Abstract:** This paper introduces the **hhsmm** R package, which involves functions for initializing, fitting, and predication of hidden hybrid Markov/semi-Markov models. These models are flexible models with both Markovian and semi-Markovian states, which are applied to situations where the model involves absorbing or macro-states. The left-to-right models and the models with series/parallel networks of states are two models with Markovian and semi-Markovian states. The **hhsmm** also includes Markov/semi-Markov switching regression model as well as the auto-regressive HHSMM, the nonparametric estimation of the emission distribution using penalized B-splines, prediction of future states and the residual useful lifetime estimation in the `predict` function. The commercial modular aero-propulsion system simulation (C-MAPSS) data-set is also included in the package, which is used for illustration of the application of the package features. The application of the **hhsmm** package to the analysis and prediction of the Spain’s energy demand is also presented.
- **Keywords:** Continuous time sojourn, EM algorithm, Forward-backward, Mixture of multivariate normals, Viterbi algorithm, R
- **Footnotes:**
  - ¹ morteza.amini@ut.ac.ir
  - ² aftbayat@gmail.com
  - ³ reza.salehian@ut.ac.ir

---

## Introduction

The package **hhsmm**, developed in the R language (R Development Core Team, 2010), involves new tools for modeling multivariate and multi-sample time series by hidden hybrid Markov/semi-Markov models, introduced by Guédon (2005). A hidden hybrid Markov/semi-Markov Model (HHSMM) is a model with both Markovian and semi-Markovian states. This package is available from the Comprehensive R Archive Network (CRAN) at https://cran.r-project.org/package=hhsmm.

The hidden hybrid Markov/semi-Markov models have many applications for the situations in which there are absorbing or macro-states in the model. These flexible models decrease the time complexity of the hidden semi-Markov models, preserving their prediction power. Another important application of the hidden hybrid Markov/semi-Markov models is in the genetics, where we aim to analysis of the DNA sequences including long interionic zones.

Several packages are available for modeling hidden Markov and semi-Markov models. Some of the packages developed in the R language are `depmixS4` (Visser and Speekenbrink, 2010), `HiddenMarkov` (Harte, 2006), `msm` (Jackson, 2007), `hsmm` (Bulla et al., 2010) and `mhsmm` (ÓConnel and Højsgaard, 2011). The packages `depmixS4`, `HiddenMarkov` and `msm` only consider hidden Markov models (HMM), while the two packages `hsmm` and `mhsmm` focus on hidden Markov and hidden semi-Markov (HSMM) models from single and multiple sequences, respectively. These packages do not include hidden hybrid Markov/semi-Markov models, which are included in the **hhsmm** package. The `mhsmm` package has some tools for fitting the HMM and HSMM models to the multiple sequences, while the `hsmm` package has not such a capability. Such a capability is preserved in the **hhsmm** package. Furthermore, the `mhsmm` package is equipped with the ability to define new emission distributions, by using the `mstep` functions, which is also preserved for the **hhsmm** package. In addition to all these differences, the **hhsmm** package is distinguished from `hsmm` and `mhsmm` packages in the following features:

- Some initialization tools are developed for initial clustering, parameter estimation, and model initialization;
- The left-to-right models, which are the models in which the process goes from a state to the next state and never comes back to the previous state, such as the health states of a system and the states of a phoneme in speech recognition, are considered;
- The ability to initialize, fit and predict the models based on data sets containing missing values, using the EM algorithm and imputation methods, is involved;
- The regime Markov/semi-Markov switching linear and additive regression model as well as the auto-regressive HHSMM are involved;
- The nonparametric estimation of the emission distribution using penalized B-splines is added;
- The prediction of the future states is involved;
- The estimation of the residual useful lifetime (RUL), which is the remaining time to the failure of a system (the last state of the left-to-right model, considered for the health of a system), is developed for the left-to-right models used in the reliability theory applications;
- The continuous sojourn time distributions are considered in their correct form;
- The Commercial Modular Aero-Propulsion System Simulation (CMAPSS) data set is included in the package.

There are also tools for modeling HMM in other languages. For instance, the `hmmlearn` library in Python or `hmmtrain` and `hmmestimate` functions in Statistics and Machine Learning Toolbox of Matlab are available for modeling HMM, while none of them are not suitable for modeling HSMM or HHSMM.

The remainder of the paper is organized as follows. In Section 2, we introduce the hidden hybrid Markov/semi-Markov models (HHSMM), proposed by Guédon (2005). Section 3 presents a simple example of the HHSMM model and the **hhsmm** package. Section 4 presents special features of the **hhsmm** package including tools for handling missing values, initialization tools, the nonparametric mixture of B-splines for estimation of the emission distribution, regime (Markov/semi-Markov) switching regression, and auto-regressive HHSMM, prediction of the future state sequence, residual useful lifetime (RUL) estimation for reliability applications, continuous-time sojourn distributions, and some other features of the **hhsmm** package. Finally, the analysis of two real data sets is considered in Section 5, to illustrate the application of the **hhsmm** package.

---

## Methods

### Hidden hybrid Markov/semi-Markov models

Consider a sequence of observations {_X_<sub>t</sub>}, which is observed for _t_ = 1,...,_T_. Assume that the distribution of _X_<sub>t</sub> depends on an un-observed (latent) variable _S_<sub>t</sub>, called state. If the sequence {_S_<sub>t</sub>} is a Markov chain of order 1, and for any _t_ > 1, _X_<sub>t</sub> and _X_<sub>t+1</sub> are conditionally independent, given _S_<sub>t</sub>, then the sequence {(_S_<sub>t</sub>, _X_<sub>t</sub>)} forms a hidden Markov model (HMM). A graphical representation of the dependence structure of the HMM is shown in Figure 1.

`Figure 1: A graphical representation of the dependence structure of the HMM.`

The parameters of an HMM are the _initial probabilities_ of the states, the _transition probability matrix_ of states, and the parameters of the conditional distribution of observations given states, which is called the _emission distribution_.

The time spent in a state is called the sojourn time. In the HMM model, the sojourn time distribution is simply proved to be geometric distribution. The hidden semi-Markov model (HSMM) is similar to HMM, while the sojourn time distribution can be any other distribution, including discrete and continuous distributions with positive support, such as Poisson, negative binomial, logarithmic, nonparametric, gamma, Weibull, log-normal, etc.

The hidden hybrid Markov/semi-Markov model (HHSMM), introduced by Guédon (2005), is a combination of the HMM and HSMM models. It is defined, for _t_ = 0,...,τ − 1 and _j_ = 1, ..., _J_, by the following parameters:

1.  initial probabilities _π_<sub>j</sub> = P(_S_<sub>0</sub> = _j_), Σ<sub>j</sub> _π_<sub>j</sub> = 1,
2.  transition probabilities, which are
    - for a semi-Markovian state _j_,
      _p_<sub>jk</sub> = P(_S_<sub>t+1</sub> = _k_|_S_<sub>t+1</sub> ≠ _j_, _S_<sub>t</sub> = _j_), ∀*k* ≠ _j_; Σ<sub>k≠j</sub> _p_<sub>jk</sub> = 1; _p_<sub>jj</sub> = 0
    - for a Markovian state _j_,
      _p̃_<sub>jk</sub> = P(_S_<sub>t+1</sub> = _k_|_S_<sub>t</sub> = _j_); Σ<sub>k</sub> _p̃_<sub>jk</sub> = 1
      By the above definition, any _absorbing state_, which is a state _j_ with _p_<sub>jj</sub> = 1, is Markovian. This means that if we want to conclude an absorbing state along with some semi-Markovian states in the model, we need to use the HHSMM model.
3.  emission distribution parameters, _θ_, for the following distribution function
    _f_<sub>j</sub>(_x_<sub>t</sub>) = _f_(_x_<sub>t</sub>|_S_<sub>t</sub> = _j_; _θ_)
4.  the sojourn time distribution is defined for semi-Markovian state _j_, as follows
    _d_<sub>j</sub>(_u_) = P(_S_<sub>t+u+1</sub> ≠ _j_, _S_<sub>t+u-v</sub> = _j_, _v_ = 0, ..., _u_ − 2|_S_<sub>t+1</sub> = _j_, _S_<sub>t</sub> ≠ _j_), _u_ = 1, ..., _M_<sub>j</sub>,
    where _M_<sub>j</sub> stands for an upper bound to the time spent in state _j_. Also, the survival function of the sojourn time distribution is defined as _D_<sub>j</sub>(_u_) = Σ<sub>v≥u</sub> _d_<sub>j</sub>(_v_).
    For a Markovian state _j_, the sojourn time distribution is the geometric distribution with the following probability mass function
    _d̃_<sub>j</sub>(_u_) = (1 - _p̃_<sub>jj</sub>)_p̃_<sub>jj</sub><sup>u-1</sup>, _u_ = 1, 2,...

The parameter estimation of the model is performed via the EM algorithm (Dempster et al., 1977). The EM algorithm consists of two steps. In the first step, which is called the _E-step_, the conditional expectation of the unobserved variables (states) is computed given the observations, which are called the E-step probabilities. This step utilizes the forward-backward algorithm to calculate the E-step probabilities. The second step is the maximization step (_M-step_). In this step the parameters of the model are updated by maximizing the expectation of the logarithm of the joint probability density/mass function of the observed and unobserved data. A brief description of the EM and forward-backward algorithms, as well as the Viterbi algorithm, is given in the Appendix. The Viterbi algorithm obtains the most likely state sequence, for the HHSMM model.

### Examples of hidden hybrid Markov/semi-Markov models

Some examples of HHSMM models are as follows:

- **Models with macro-states:** The macro-states are series or parallel networks of states with common emission distribution. A semi-Markovian model can not be used for macro-states and a hybrid Markov/semi-Markov model is a good choice in such situations (see Cook and Russell, 1986; Durbin et al., 1998; Guédon, 2005).
- **Models with absorbing states:** An absorbing state is Markovian by definition. Thus, a model with an absorbing state can not be fully semi-Markovian.
- **Left to right models:** The left-to-right models are useful tools in the reliability analysis of failure systems. Another application of these models is in speech recognition, where the feature sequence extracted from a voice is modeled by a left to right model of states. The transition matrix of a left to right model is an upper triangle matrix with its final diagonal element equal to one, since the last state of a left-to-right model is absorbing. Thus, a hidden hybrid Markov/semi-Markov model might be used in such cases, instead of a hidden fully semi-Markov model.
- **Analysis of DNA sequences:** It is observed that the length of some interionic zones in DNA sequences are approximately, geometrically distributed, while the length of other zones might deviate from the geometric distribution (Guédon, 2005).

### Special features of the package

#### Handling missing values

The **hhsmm** package is equipped with tools for handling data sets with missing values. A special imputation algorithm is used in the `initial_cluster` function. This algorithm, imputes a completely missed row of the data with the average of its previous and next rows, while if some columns are missed, the predictive mean matching method of the function `mice` from package `mice` (Van Buuren and Groothuis-Oudshoorn, 2011), with _m_ = 1, is used to initially impute the missing values. After performing the initial clustering and initial estimation of the parameters of the model, the `miss_mixmvnorm_mstep` function is considered, as the M-step function of the EM algorithm, for initializing and fitting the model. The function `miss_mixmvnorm_mstep` includes computation of the conditional means and conditional second moments of the missing values given observed values in each iteration of the EM algorithm and updating the parameters of the Gaussian mixture emission distribution, using the `cov.miss.mix.wt` function. Furthermore, an approximation of the mixture component weights using the observed values and conditional means of the missing values given observed values is used in each iteration. The values of the emission density function, used in the E-step of the EM algorithm are computed by replacing the missing values with their conditional means given the observed values.

#### Tools and methods for initializing model

To initialize the HHSMM model, we need to obtain an initial clustering for the train data set. For a left to right model (option `ltr = TRUE` of the `initial_cluster` function), we propose Algorithm 2, which uses Algorithm 1, for a left to right initial clustering, which are included in the function `ltr_clus` of the **hhsmm** package. These algorithms use Hotelling's T-squared test statistic as the distance measure for clustering. The simulations and real data analysis show that the starting values obtained by the proposed algorithm perform well for a left to right model (see Section 5 for a real data application). If the model is not a left to right model, then the usual K-means algorithm is used for clustering. Furthermore, the K-means algorithm is used within each initial state to cluster data for mixture components. The number of mixture components can be determined automatically, using the option `nmix = "auto"`, by analysis of the within sum of squares obtained from the `kmeans` function. The number of starting values of the `kmeans` is set to 10, for the stability of the results. The initial clustering is performed using the `initial_cluster` function.

**Algorithm 1 The left to right clustering algorithm for two clusters.**
0: For _s_ = 2, ..., _k_ − 2 consider partitions {1, ..., _k_} = {1, ..., _s_}∪{_s_ + 1,..., _k_} and compute the means
`X̄₁s = (1/s) Σᵢ<0xE2><0x82><0x8D>₁ˢ Xᵢ`, `X̄₂s = (1/(k-s)) Σᵢ<0xE2><0x82><0x8D>s+₁ᵏ Xᵢ`
the variance-covariance matrices
`Σ̂₁s = (1/(s-1)) Σᵢ<0xE2><0x82><0x8D>₁ˢ (Xᵢ - X̄₁s)(Xᵢ - X̄₁s)ᵀ`, `Σ̂₂s = (1/(k-s-1)) Σᵢ<0xE2><0x82><0x8D>s+₁ᵏ (Xᵢ - X̄₂s)(Xᵢ - X̄₂s)ᵀ`
and the standardized distances (Hotelling's T-squared test statistic)
`ds = (s(k-s)/k)(k-p-1) / ((k-2)p) * (X̄₁s - X̄₂s)ᵀ Σ̂ps⁻¹ (X̄₁s - X̄₂s)`
where `Σ̂ps = ((s − 1)Σ̂₁s + (k − s − 1)Σ̂₂s) / (k − 2)`
0: Let _s_\* = arg max<sub>s</sub> _d_<sub>s</sub>.
0: If _d_<sub>s*</sub> > *F*<sub>(0.05;p,k−1−p)</sub>, the clusters would be {1,...,*s*\* } and {*s*\* + 1,...,*k*}, otherwise, no clustering will be done, where *F*<sub>(0.05;p,k−1−p)</sub> stands for the 95th percentile of the F distribution with *p* and *k* - 1 - *p\* degrees of freedom.

After obtaining the initial clustering, the initial estimates of the parameters of the mixture of multivariate normal emission distribution are obtained. Furthermore, the parameters of the sojourn time distribution is obtained by running the method of moments estimation algorithms on the time duration observations of the initial clustering of each state. If we set `sojourn = "auto"` in the `initialize_model` function, the best sojourn time distribution is selected from the list of available sojourn time distributions, using the Chi-square goodness of fit testing on the initial cluster data of all states.

**Algorithm 2 The left to right clustering algorithm for K > 2 clusters.**
0: Let Nclust = 1. While Nclust < _K_ and the clusters change, do

- for all clusters run Algorithm 1 to obtain two clusters
  0: If Nclust > _K_, while Nclust = _K_ do
- merge clusters with minimum _d_<sub>s\*</sub> values its closest neighbour on its right or left.

#### Nonparametric mixture of B-splines emission

Usually, the emission distribution belongs to a parametric family of distributions. Although the mixture of multivariate normals is shown to be a good choice in many practical situations, there are also examples in which this class of emission distribution fails to model the skewness and tail weight of the data set. Furthermore, the choice of the number of components of the mixture distribution in each state is a challenge of using mixture of multivariate normals as the emission distribution. As an alternative to parametric emission distribution, HMMs and HSMMs with non-parametric estimates of state-dependent distributions are shown to be more parsimonious in terms of the number of states, easier to interpret, and well fitted to the data (Adam et al., 2019; Langrock et al., 2015). The proposed nonparametric estimation approach of Langrock et al. (2015) and Adam et al. (2019) is based on the idea of representing the densities of the emission distributions as linear combinations of B-spline basis functions, by adding a smoothing penalty term to the quasi-log-likelihood function. In this model, the emission distribution is defined as follows
_f_<sub>j</sub>(_x_) = Σ<sub>k=-K</sub><sup>K</sup> _a_<sub>j,k</sub> _ϕ_<sub>k</sub>(_x_), _j_ = 1,..., _J_, (1)
where {_ϕ_<sub>-K</sub>(·),...,_ϕ_<sub>K</sub>(·)} is a sequences of B-splines and {_a_<sub>j,k</sub>} is the sequences of unknown coefficients to be estimated. These parameters are estimated in the M-step of the EM algorithm, by maximizing the following penalized quasi-log-likelihood function
_l_<sub>p</sub><sup>HHSMM</sup>(_θ_, _λ_) = log(_L_<sup>HHSMM</sup>(_θ_)) - (1/2) Σ<sub>j=1</sub><sup>J</sup> _λ_<sub>j</sub> Σ<sub>k=-K+2</sub><sup>K</sup> (Δ²*a*<sub>j,k</sub>)², (2)
in which _L_<sup>HHSMM</sup>(_θ_) the quasi-likelihood of the HHSMM model, _θ_ is the parameters of the model, Δ*a*<sub>k</sub> = _a_<sub>k</sub> - _a_<sub>k−1</sub>, Δ²*a*<sub>k</sub> = Δ(Δ*a*<sub>k</sub>), and _λ_<sub>1</sub>, ..., _λ_<sub>J</sub> are the smoothing parameters, which are estimated as follows (Schellhase and Kauermann, 2012)
_λ_<sub>j</sub> = (_df_(_λ_<sub>j</sub>) - _p_) / Σ<sub>k=-K+2</sub><sup>K</sup>(Δ²*a*<sub>j,k</sub>)²
where _p_ is the dimension of the data,
_df_(_λ_<sub>j</sub>) = tr (*H*⁻¹(_a_<sub>j</sub>; _λ_<sub>j</sub> = _λ̃_<sub>j</sub>)_H_(_a_<sub>j</sub>; _λ_<sub>j</sub> = 0)),
and _H_(_â_; _λ_) is the hessian matrix of the log-quasi-likelihood at _â_ with the specified value of _λ_.

#### Regime (Markov/semi-Markov) switching regression model

`Figure 5: Graphical representation of the regime-switching model.`

Kim et al. (2008) considered the following Gaussian regime-switching model
_Y_<sub>t</sub> = _x_<sub>t</sub>ᵀ _β_<sub>st</sub> + _σ_<sub>st</sub> _e_<sub>t</sub>, (3)
where _y_<sub>t</sub> is the response variable, _x_<sub>t</sub> is a vector of covariates, which may include lagged values of _y_<sub>t</sub> (auto-regressive HHSMM, see the next subsection), _s_<sub>t</sub> is the state, and _e_<sub>t</sub> is the regression error, which is assumed to be distributed as standard normal distribution, for _t_ = 1,...,_T_. Model (3) can easily be extended to the case of multivariate responses and also to the case of mixture of multivariate normals. The difference between the regime-switching model (3) and the HHSMM model is that, instead of using the density of _y_<sub>t</sub> given _s_<sub>t</sub> in the likelihood function, we use the conditional density of _y_<sub>t</sub> given _x_<sub>t</sub> and _s_<sub>t</sub>. A graphical representation of the regime-switching model is presented in Figure 5. The parameters of the regime switching regression model can be estimated using the EM algorithm.

Langrock et al. (2018) considered an extension of the model (3) to the following additive regime-switching model
_Y_<sub>t</sub> = _μ_<sub>st</sub> + Σ<sub>j=1</sub><sup>p</sup> _f_<sub>j,st</sub>(_x_<sub>j,t</sub>) + _σ_<sub>st</sub> _e_<sub>t</sub>, (4)
where _f_<sub>j,st</sub>(·), _j_ = 1, ..., _p_ are unknown regression functions for _p_ covariates. They utilized the penalized B-splines for estimation of the regression functions.

The estimation of extensions of models (3) and (4) is considered in **hhsmm** package, using the `mixlm_mstep` and `additive_reg_mstep` functions, respectively, as the M-step estimation and `dmixlm` and `dnorm_additive_reg` functions, respectively, which define mixture of multivariate normals and multivariate normal densities, respectively, as the conditional density of the responses given the covariates. The response variables are determined using the argument `resp.ind` in all of these functions, with its default value equal to one, which means that the first column of the input matrix `x`, is the univariate response variable.

#### Auto-regressive HHSMM

A special case of the regime-switching regression models (3) and (4) is the auto-regressive HHSMM model, in which we take _x_<sub>t</sub> = (_y_<sub>t−1</sub>,..., _y_<sub>t-l</sub>), for a specified lag _l_ ≥ 1.

#### Prediction of the future state sequence

To predict the future state sequence at times _T_+1,...,_T_+_h_, first, we use viterbi (smoothing) algorithm (see the Appendix) to estimate the probabilities of the most likely path _α_<sub>j</sub>(_t_) (_L_<sub>j</sub>(_t_)) for _j_ = 1, . . ., _J_ and _t_ = 0, . . ., τ − 1, as well as the current most likely state _ŝ_<sub>τ</sub> = arg max<sub>1≤j≤J</sub> _α_<sub>j</sub>(τ) (_ŝ_<sub>τ</sub> = arg max<sub>1≤j≤J</sub> _L_<sub>j</sub>(τ)). Also, we might compute the probabilities
_δ_<sub>t</sub>(_j_) = _α_<sub>j</sub>(_t_) / Σ<sub>k=1</sub><sup>J</sup> _α_<sub>k</sub>(_t_) (_δ_<sub>t</sub>(_j_) = _L_<sub>j</sub>(_t_) / Σ<sub>k=1</sub><sup>J</sup> _L_<sub>k</sub>(_t_)). (5)
Next, for _j_ = 1, . . ., _h_, we compute the probability of the next state, by multiplying the transition matrix by the current state probability as follows
_δ_<sub>next</sub> = (_P_)ᵀ _δ_<sub>current</sub> (6)
Then, the *j*th future state is predicted as
_ŝ_<sub>next</sub> = arg max<sub>1≤j≤J</sub> _δ_<sub>next</sub>(_j_) (7)
This process continues until the required time _T_+_h_. The prediction of the future state sequence is done using the function `predict.hhsmm` function in the **hhsmm** package, by determining the argument `future`, which is equal to zero by default.

#### Residual useful lifetime (RUL) estimation, for reliability applications

The residual useful lifetime (RUL) is defined as the remaining lifetime of a system at a specified time point. If we analyse a reliable system with a hidden Markov or semi-Markov model, a suitable choice would be a left to right model, with the final state as the failure state. The RUL of such model is defined at time _t_ as
RUL<sub>t</sub> = _D̃_ : _S_<sub>t+D̃</sub> = _J_, _S_<sub>t+D̃−1</sub> = _i_; 1 ≤ _i_ < _k_ ≤ _J_. (8)

We describe a method of RUL estimation (see Cartella et al., 2015), which is used in **hhsmm** package. First, we should compute the probabilities in (5), using the Viterbi or smoothing algorithm.

Two different methods are used to obtain point and interval estimates of the RUL in the **hhsmm** package.

1.  **Mean Confidence Method (`confidence = "mean"`)**: Based on the method described in Cartella et al. (2015).

    - Computes the average time in the current state: _d_<sub>avg</sub>(_δ_<sub>t</sub>) = Σ<sub>j=1</sub><sup>J</sup> (_μ_<sub>dj</sub> – _d_<sub>t</sub>(_j_))_δ_<sub>t</sub>(_j_), (9) where _μ_<sub>dj</sub> = Σ<sub>u=1</sub><sup>Mj</sup> _u_ _d_<sub>j</sub>(_u_) is the expected duration, and _d_<sub>t</sub>(_j_) is the estimated duration in state _j_ at time _t_ (Azimi, 2004): _d_<sub>t</sub>(_j_) = _d_<sub>t-1</sub>(_j_)_δ_<sub>t</sub>(_j_), _t_ = 2,..., _M_<sub>j</sub>, _d_<sub>1</sub>(_j_) = 1.
    - Computes bounds using standard deviation _σ_<sub>dj</sub>. The **hhsmm** package uses corrected bounds with standard normal quantiles _z_<sub>1-γ/2</sub>:
      _d_<sub>low</sub>(_δ_<sub>t</sub>) = Σ<sub>j=1</sub><sup>J</sup> (_μ_<sub>dj</sub> - _d_<sub>t</sub>(_j_) – _z_<sub>1-γ/2</sub>_σ_<sub>dj</sub>)_δ_<sub>t</sub>(_j_), (12)
      _d_<sub>up</sub>(_δ_<sub>t</sub>) = Σ<sub>j=1</sub><sup>J</sup> (_μ_<sub>dj</sub> – _d_<sub>t</sub>(_j_) + _z_<sub>1-γ/2</sub>_σ_<sub>dj</sub>)_δ_<sub>t</sub>(_j_), (13)
    - Predicts next state probability _δ_<sub>next</sub> (14) and state _ŝ_<sub>next</sub> (15).
    - Iterates: If _ŝ_<sub>t+d</sub>(_j_) is not the failure state _J_, calculate the sojourn time for the next state using expected values (_μ_<sub>dj</sub>) and bounds derived from _σ_<sub>dj</sub> (Equations 16-18 similar to 9, 12, 13 but without _d_<sub>t</sub>(_j_) term and using _δ_<sub>t+d</sub>).
    - Sums estimates until failure state _J_ is reached (Equation 19).

2.  **Max Confidence Method (`confidence = "max"`)**: Relaxes normality assumption.
    - Uses the mode _m_<sub>dj</sub> = arg max<sub>1≤u≤Mj</sub> _d_<sub>j</sub>(_u_) instead of the mean _μ_<sub>dj</sub>.
    - Uses quantiles derived from the sojourn distribution _d_<sub>j</sub>(_u_) for bounds instead of _z_<sub>1-γ/2</sub>_σ_<sub>dj</sub>. Specifically, replaces `-z*<sub>1-γ/2</sub>*σ*<sub>dj</sub>` with min{_v_; Σ<sub>u=1</sub><sup>v</sup> _d_<sub>j</sub>(_u_) ≤ γ/2} and `+z*<sub>1-γ/2</sub>*σ*<sub>dj</sub>` with _M_<sub>j</sub> – min{_v_; Σ<sub>u=v</sub><sup>Mj</sup> _d_<sub>j</sub>(_u_) ≤ γ/2} in equations (10), (12), (13), (16), (17) and (18).

#### Continuous time sojourn distributions

Since the measurements of the observations are always preformed on discrete time units (assumed to be positive integers), the sojourn time probabilities of the sojourn time distribution with probability density function _g_<sub>j</sub>, in state _j_, is obtained as follows
_d_<sub>j</sub>(_u_) = P(_S_<sub>t+u+1</sub> ≠ _j_, _S_<sub>t+u−v</sub> = _j_, _v_ = 0, ..., _u_ − 2|_S_<sub>t+1</sub> = _j_, _S_<sub>t</sub> ≠ _j_)
= ∫<sub>u-1</sub><sup>u</sup> _g_<sub>j</sub>(_y_) dy / ∫<sub>0</sub><sup>Mj</sup> _g_<sub>j</sub>(_y_) dy, _j_ = 1, ..., _J_, _u_ = 1, ..., _M_<sub>j</sub>. (20)

Almost all flexible continuous distributions with positive domain might be used. Some included in **hhsmm**:

- **Gamma sojourn:** Density _g_<sub>j</sub>(_y_) = (_y_<sup>αj-1</sup> _e_<sup>-y/βj</sup>) / (_β_<sub>j</sub><sup>αj</sup> Γ(_α_<sub>j</sub>)). Discrete prob _d_<sub>j</sub>(_u_) = ∫<sub>u-1</sub><sup>u</sup> _g_<sub>j</sub>(_y_) dy / ∫<sub>0</sub><sup>Mj</sup> _g_<sub>j</sub>(_y_) dy.
- **Weibull sojourn:** Density _g_<sub>j</sub>(_y_) = (_α_<sub>j</sub>/_β_<sub>j</sub>) (_y_/_β_<sub>j</sub>)<sup>αj-1</sup> exp{-(_y_/_β_<sub>j</sub>)<sup>αj</sup>}. Discrete prob _d_<sub>j</sub>(_u_) calculated via integration.
- **log-normal sojourn:** Density _g_<sub>j</sub>(_y_) = (1 / (*y*√2π*σ*<sub>j</sub>²)) exp{-(log _y_ - _μ_<sub>j</sub>)² / (2*σ*<sub>j</sub>²)}. Discrete prob _d_<sub>j</sub>(_u_) calculated via integration.

#### Other features of the package

- `dmixmvnorm`: Computes the probability density function of a mixture of multivariate normals.
- `mixmvnorm_mstep`: The M step function of the EM algorithm for the mixture of multivariate normals emission.
- `rmixmvnorm`: Generates observations from mixture multivariate normal distribution.
- `train_test_split`: Splits data sets to train and test subsets with an option to right trim sequences.
- `lagdata`: Creates lagged time series of a data.
- `score`: Computes the score (log-likelihood) of new observations using a trained model.
- `homogeneity`: Computes maximum homogeneity of two state sequences.
- `hhsmmdata`: Converts a matrix of data and its associated vector of sequence lengths to a data list of class "hhsmmdata".

#### Appendix: Algorithms

- **Forward-backward algorithm for the HHSMM model:**
  - Computes probabilities _L_<sub>j</sub>(_t_) = P(_S_<sub>t</sub> = _j_|_X_<sub>0:τ−1</sub> = _x_<sub>0:τ−1</sub>).
  - Forward recursion (semi-Markovian _j_): _F_<sub>j</sub>(_t_) defined in (A.21), _F_<sub>j</sub>(τ - 1) in (A.22).
  - Forward recursion (Markovian _j_): _F̃_<sub>j</sub>(_t_) defined in (A.23).
  - Normalizing factor _N_<sub>t</sub> = P(_X_<sub>t</sub> = _x_<sub>t</sub>|_X_<sub>0:t-1</sub> = _x_<sub>0:t-1</sub>).
  - Log-likelihood = Σ<sub>t=0</sub><sup>τ-1</sup> log _N_<sub>t</sub>.
  - Backward recursion initialization: _L_<sub>j</sub>(τ − 1) = _F_<sub>j</sub>(τ − 1) or _F̃_<sub>j</sub>(τ − 1).
  - Backward recursion (semi-Markovian _j_): _L_<sub>j</sub>(_t_) defined in (A.24), uses _L_<sub>1j</sub>(_t_) (A.25), _G_<sub>j</sub>(_t_ + 1).
  - Backward recursion (Markovian _j_): _L_<sub>j</sub>(_t_) = _L_<sub>1j</sub>(_t_) (A.26).
  - Mixture emission: Compute _γ_<sup>(s+1)</sup><sub>kj</sub>(_t_) (A.28).
- **The M-step of the EM algorithm:**
  - Update initial probabilities _π_<sup>(s+1)</sup><sub>j</sub> = _L_<sub>j</sub>(0).
  - Update semi-Markovian transitions _p_<sup>(s+1)</sup><sub>ij</sub> (A.29).
  - Update Markovian transitions _p̃_<sup>(s+1)</sup><sub>ij</sub> (A.30).
  - Update mixture parameters _λ_<sup>(s+1)</sup><sub>kj</sub>, _μ_<sup>(s+1)</sup><sub>kj</sub>, _Σ_<sup>(s+1)</sup><sub>kj</sub>.
  - Update sojourn parameters by maximizing quasi-log-likelihood _Q_<sub>d</sub>.
- **Viterbi algorithm:**
  - Computes most likely state sequence probability _α_<sub>j</sub>(_t_).
  - Recursion (semi-Markovian _j_): _α_<sub>j</sub>(_t_) (A.31), _α_<sub>j</sub>(τ − 1) (A.32).
  - Recursion (Markovian _j_): _α̃_<sub>j</sub>(0) initialization, _α̃_<sub>j</sub>(_t_) (A.33, A.34).
  - Most likely state: _ŝ_<sub>t</sub> = arg max<sub>j</sub> _α_<sub>j</sub>(_t_).
  - Smoothing alternative uses _L_<sub>j</sub>(_t_).

---

## Results / Applications

### A simple example

This example illustrates initializing, fitting, and prediction using **hhsmm**. Model: 3 states (J=3), states 1 & 3 Markovian, state 2 semi-Markovian (`semi = c(FALSE, TRUE, FALSE)`). Mixture components: 2, 3, 2 for states 1-3. Sojourn for state 2: Gamma.

`Figure 2: The plots for 4 sequences of train data set.`
`Figure 3: The plots for 4 sequences of test data set.`
`Figure 4: The log-likelihood trend during the model fitting.`

- **Model Definition and Simulation:**

  ```r
  J <- 3
  initial <- c(1, 0, 0)
  semi <- c(FALSE, TRUE, FALSE)
  P <- matrix(c(0.8, 0.1, 0.1, 0.5, 0, 0.5, 0.1, 0.2, 0.7),
              nrow = J, byrow=TRUE)
  par <- list(mu = list(list(7, 8), list(10, 9, 11), list(12, 14)),
              sigma = list(list(list(3.8, 4.9), list(4.3, 4.2, 5.4)), list(list(4.5, 6.1))), # Error in OCR noted/corrected
              mix.p = list(c(0.3, 0.7), c(0.2, 0.3, 0.5), c(0.5, 0.5)))
  sojourn <- list(shape = c(0, 3, 0), scale = c(0, 10, 0), type = "gamma")
  model <- hhsmmspec(init = initial, transition = P, parms.emis = par,
                     dens.emis = dmixmvnorm, sojourn = sojourn, semi = semi)

  train <- simulate(model, nsim = c(50, 40, 30, 70), seed = 1234, remission = rmixmvnorm)
  test <- simulate(model, nsim = c(80, 45, 20, 35), seed = 1234, remission = rmixmvnorm)
  # plot(train) # See Figure 2
  # plot(test)  # See Figure 3
  ```

- **Initialization and Fitting (HHSMM):**
  ```r
  clus <- initial_cluster(train, nstate = 3, nmix = c(2, 2, 2),
                         ltr = FALSE, final.absorb = FALSE, verbose = FALSE)
  initmodel1 <- initialize_model(clus = clus, sojourn = "gamma",
                                M = max(train$N), semi = semi)
  fit1 <- hhsmmfit(x = train, model = initmodel1, M = max(train$N),
                   par = list(verbose = FALSE))
  # plot(fit1$loglik[-1], type = "b", ylab = "Log-likelihood", xlab = "Iteration") # See Figure 4
  ```
  _Estimated parameters output shown in paper._
- **Prediction (HHSMM):**
  ```r
  yhat1 <- predict(fit1, test)
  homogeneity(yhat1$s, test$s)
  # [1] 0.9191686 0.8564920 0.7553957
  ```
- **Comparison with HMM:**
  ```r
  semi_hmm <- c(FALSE, FALSE, FALSE)
  initmodel2 <- initialize_model(clus = clus, M = max(train$N), semi = semi_hmm)
  fit2 <- hhsmmfit(x = train, model = initmodel2, M = max(train$N),
                   par = list(lock.init = TRUE, verbose = FALSE))
  yhat2 <- predict(fit2, test)
  homogeneity(yhat2$s, test$s)
  # [1] 0.9237875 0.8609272 0.8400000
  ```
- **Comparison with HSMM:**
  ```r
  semi_hsmm <- c(TRUE, TRUE, TRUE)
  initmodel3 <- initialize_model(clus=clus, sojourn = "gamma",
                                 M = max(train$N), semi = semi_hsmm)
  fit3 <- hhsmmfit(x = train, model = initmodel3, M = max(train$N),
                   par = list(verbose = FALSE))
  yhat3 <- predict(fit3, test)
  homogeneity(yhat3$s, test$s)
  # [1] 0.9232737 0.8069414 0.7358491
  ```

### Handling missing values example

Demonstrates fitting with missing data.

- Model setup and simulation (complete data) done first.
- Missing data introduced randomly.
- **Clustering, Initialization, Fitting (Incomplete Data):**
  ```r
  # ... (code to introduce NA values) ...
  clus_miss <- initial_cluster(train_miss, nstate = 3, nmix = c(2, 2, 2),
                              ltr = FALSE, final.absorb = FALSE, verbose = FALSE)
  # clus_miss$miss # TRUE
  initmodel_miss <- initialize_model(clus = clus_miss, sojourn = "gamma",
                                     M = max(train_miss$N), semi = semi) # Assuming train_miss has NAs
  # Need miss_mixmvnorm_mstep here for fitting
  # fit_miss <- hhsmmfit(x = train_miss, model = initmodel_miss, M = max(train_miss$N),
  #                     mstep = miss_mixmvnorm_mstep, ...) # Pseudocode - fitting part not fully shown for miss_*
  # Instead, paper reuses non-missing initialization/fitting for comparison point
  initmodel2 <- initialize_model(clus = clus_miss, sojourn = "gamma", M = max(train$N), semi = semi) # Using clus_miss
  fit2_miss <- hhsmmfit(x = train, model = initmodel2, # Fit on original train using miss-informed init
                       M = max(train$N), par = list(lock.init = TRUE, verbose = FALSE))
  yhat2_miss <- predict(fit2_miss, test) # Predict on original test
  ```
- **Homogeneity Comparison:**
  ```r
  # homogeneity(yhat1$s, test$s) # Complete data result from previous section
  # [1] 0.8487395 0.9793814 0.0000000 # Using the 2-variable model from 4.1
  # homogeneity(yhat2_miss$s, test$s) # 'Incomplete' data result (using miss-informed init)
  # [1] 0.9830508 0.8595041 0.0000000 # Using the 2-variable model from 4.1
  ```
  _Note: The paper's description focuses on the functions `miss_mixmvnorm_mstep` etc., but the code example compares predictions based on initial clustering derived from complete vs incomplete data, rather than fitting directly with the specialized M-step._

### Nonparametric B-splines emission example

- Model setup and simulation done first.
- **Initialization and Fitting:**
  ```r
  clus_np <- initial_cluster(train, nstate = 3, nmix = NULL, # nmix=NULL for nonparametric
                            ltr = FALSE, final.absorb = FALSE, verbose = FALSE)
  initmodel_np <- initialize_model(clus = clus_np, mstep = nonpar_mstep,
                                   dens.emission = dnonpar, sojourn = "gamma",
                                   M = max(train$N), semi = semi)
  fit_np <- hhsmmfit(x = train, model = initmodel_np, M = max(train$N),
                     par = list(verbose = FALSE)) # Uses nonpar_mstep by default if dens.emission=dnonpar
  ```
- **Prediction:**
  ```r
  yhat_np <- predict(fit_np, test)
  homogeneity(yhat_np$s, test$s)
  # [1] 0.9210526 0.8508772 0.8750000
  ```

### Regime switching regression example

`Figure 6: The regime Markov switching example.`
`Figure 7: The Markov regime-switching additive regression fit.`

- **Linear Regime Switching:**
  - Model setup and simulation (`remission = rmixlm`).
  - Initialization (`initial_cluster` with `regress = TRUE`).
  - Fitting (`hhsmmfit` with `mstep = mixlm_mstep`).
  - Plotting results (Figure 6).
- **Additive Regime Switching:**
  - Initialization (`initial_cluster` with `regress = TRUE`, `nmix = NULL`).
  - Fitting (`hhsmmfit` with `mstep = additive_reg_mstep`).
  - Prediction (`addreg_hhsmm_predict`).
  - Plotting results (Figure 7).

### Auto-regressive HHSMM example

`Figure 8: The ARHMM example simulated train data set.`
`Figure 9: Trimmed test data set and the predicted values.` (Linear AR-HMM)
`Figure 10: The predicted values using AR-HMM model, using the regime switching additive regression.` (Additive AR-HMM)

- **Linear AR-HMM:**
  - Model setup and simulation (`emission.control = list(autoregress = TRUE)`).
  - Data preparation (`lagdata`).
  - Initialization (`initial_cluster` with `regress = TRUE`, `resp.ind = 2`).
  - Fitting (`hhsmmfit` with `mstep = mixlm_mstep`, `resp.ind = 2`).
  - Prediction of future values (iterative loop using model coefficients, `predict.hhsmm` for states).
  - Plotting predictions (Figure 9).
- **Additive AR-HMM:**
  - Initialization (`initial_cluster` with `regress = TRUE`, `resp.ind = 2`, `nmix = NULL`).
  - Fitting (`hhsmmfit` with `mstep = additive_reg_mstep`, `control=list(resp.ind=2, K=7)`).
  - Prediction (`addreg_hhsmm_predict`).
  - Plotting predictions (Figure 10). Comparison shows better fit for additive model here.

### Future state prediction example

Uses model from Section 3.

- Fits HHSMM model (`fit1`).
- Splits `test` data using `train_test_split` (`trim.ratio = 0.9`).
- Predicts states for trimmed sequences with (`future=tc[i]`) and without (`future=0`) future prediction.
- Compares homogeneity against full `test$s` (for future) and `trimmed$s` (without future).
  _Output shows high homogeneity, indicating good prediction._

### Real data Analysis 1: Spain energy market data set

`Figure 11: Spain energy data and its estimated states.`
`Figure 12: Two-state prediction of the energy price based on the other variables.`
`Figure 13: Prediction curves for regime swithching nonparametric regression model of energy price on oil price.`
`Figure 14: Comparision with simple additive regression.`

- **Objective:** Predict energy Price using other variables as covariates.
- **Model:** 2-state additive Markov switching regression (`semi = rep(FALSE, J)`), B-spline degree K=20.
- **Steps:** Load data (`MSwM::energy`), convert (`hhsmmdata`), cluster (`initial_cluster` with `regress=TRUE, nmix=NULL`), initialize (`initialize_model` with `mstep=additive_reg_mstep`), fit (`hhsmmfit`).
- **Results:**
  - Plot response with estimated states (Figure 11).
  - Plot response vs time with predicted values for each state (Figure 12).
  - Analyze Price vs Oil Price only: Fit 2-state additive model. Plot prediction curves (Figure 13). Shows good fit.
  - Compare 2-state additive model vs 1-state additive model. Calculate SSE. Plot comparison (Figure 14). 2-state model much better (SSE 210 vs 680).

### Real data Analysis 2: RUL estimation for the C-MAPSS data set

`Table 1: C-MAPSS data set overview.`
`Table 2: Sensor description of the C-MAPSS data set.`
`Figure 15: The time series plot of 14 variables of the first sequence of the train set for the CMAPSS data set.`
`Figure 16: Graphical representation of the reliability left to right model.`
`Figure 17: The estimated gamma sojourn time density functions.`
`Figure 18: RUL estimates (solid blue lines) and RUL bounds (dashed red lines) using four different methods for the CMAPSS test data set.`

- **Objective:** Estimate RUL for turbofan engines.
- **Data:** CMAPSS dataset (14 selected variables).
- **Model (HHSMM):** 5-state Left-to-Right HHSMM (1 healthy, 3 damage, 1 failure/absorbing). `ltr=TRUE`, `final.absorb=TRUE`. Automatic mixture components (`nmix="auto"`). Gamma sojourn distribution assumed after initialization.
- **Steps:** Load data (`CMAPSS`), cluster (`initial_cluster`), initialize (`initialize_model`), fit (`hhsmmfit` with `lock.init=TRUE`).
- **Results (HHSMM):**
  - Fit model, plot sojourn densities (Figure 17).
  - Estimate RULs using 4 methods (`predict` with `viterbi`/`smoothing` x `mean`/`max`).
- **Model (HMM):** 5-state Left-to-Right HMM (`semi=rep(FALSE,J)`). Fit for comparison.
- **Results (HMM):**
  - Estimate RULs using 4 methods.
- **Comparison:**
  - Calculate coverage probabilities of RUL confidence intervals for both HHSMM and HMM against true `test$RUL`. HHSMM coverage is significantly better (e.g., ~79% for viterbi/mean HHSMM vs 0% for HMM).
  - Plot RUL estimates and bounds for HHSMM (Figure 18). "Smoothing" and "max" methods appear better in this example visually and based on coverage.

---

## Discussion / Concluding remarks

This paper presents several examples of the R package **hhsmm**. The scope of application of this package covers simulation, initialization, fitting, and prediction of HMM, HSMM, and HHSMM models, for different types of discrete and continuous sojourn distribution, including shifted Poisson, negative binomial, logarithmic, gamma, Weibull, and log-normal. This package contains density and M-step function for estimation of the emission distribution for different types of emission distribution, including the mixture of multivariate normals and penalized B-spline estimator of the emission distribution, the mixture of linear and additive regression (conditional multivariate normal distributions of the response given the covariates; regime-switching regression models) as well as the ability to define another emission distributions by the user. As a special case of the regime-switching regression models, the auto-regressive HHSMM models can be modeled by the **hhsmm** package. The left to right models are considered in the **hhsmm** package, especially in the initialization functions.

The **hhsmm** package uses the EM algorithm to handle the missing values when the mixture of multivariate normals is considered as the emission distribution. The ability to predict the future states, residual useful lifetime estimation for the left to right models, computation of the score of new observations, computing the homogeneity of two sequences of states, and splitting the data to train and test sequences by the ability to right-trim the test sequences, are other useful features of the **hhsmm** package. The current version 0.3.2 of this package is now available on CRAN (https://cran.r-project.org/package=hhsmm), while the future improvements of this package are also considered by the authors. Any report of the possible bugs of the **hhsmm** package are welcome through https://github.com/mortamini/hhsmm/issues and we welcome the users' offers for any needed feature of the package in the future.

### Acknowledgements

The authors would like to thank the two anonymous referees and the associate editor for their useful comments and suggestions, which improved an earlier version of the **hhsmm** package and this paper.

---

## References

(List of references as provided in the paper, Pages 48-49)

- Adam, T., Langrock, R., & Weiß, C. H. (2019). Penalized estimation of flexible hidden Markov models for time series of counts. Metron, 77(2), 87-104.
- Azimi, M. (2004). Data transmission schemes for a new generation of interactive digital television (Doctoral dissertation, University of British Columbia).
- Bulla J, Bulla I, Nenadic O (2010). hsmm An R Package for Analyzing Hidden Semi-Markov Models. Computational Statistics & Data Analysis, 54(3), 611-619.
- Cartella, F., Lemeire, J., Dimiccoli, L., & Sahli, H. (2015). Hidden semi-Markov models for predictive maintenance. Mathematical Problems in Engineering, 2015.
- Cook, A. E., & Russell, M. J. (1986). Improved duration modeling in hidden markov models using series-parallel configurations of states. Proc. Inst. Acoust, 8, 299-306.
- Dempster, A. P., Laird, N. M., & Rubin, D. B. (1977). Maximum likelihood from incomplete data via the EM algorithm. Journal of the Royal Statistical Society: Series B (Methodological), 39(1), 1-22.
- Durbin, R., Eddy, S. R., Krogh, A., & Mitchison, G. (1998). Biological sequence analysis: probabilistic models of proteins and nucleic acids. Cambridge university press.
- Fontdecaba, S., Muñoz, M. P., & Sànchez, J. A. (2009). Estimating Markovian Switching Regression Models in An application to model energy price in Spain. In The R User Conference, France.
- Frederick, D. K., DeCastro, J. A., & Litt, J. S. (2007). User's guide for the commercial modular aero-propulsion system simulation (C-MAPSS).
- Guédon, Y. (2005). Hidden hybrid Markov/semi-Markov chains. Computational Statistics and Data Analysis, 49(3), 663-688.
- Harte, D. (2006). Mathematical background notes for package "HiddenMarkov”. Statistics Re.
- Jackson, C. (2007). Multi-state modelling with R: the msm package. Cambridge, UK, 1-53.
- Kim, C. J., Piger, J., & Startz, R. (2008). Estimation of Markov regime-switching regression models with endogenous switching. Journal of Econometrics, 143(2), 263-273.
- Langrock, R., Kneib, T., Sohn, A., & DeRuiter, S. L. (2015). Nonparametric inference in hidden Markov models using P-splines. Biometrics, 71(2), 520-528.
- Langrock, R., Adam, T., Leos-Barajas, V., Mews, S., Miller, D. L., & Papastamatiou, Y. P. (2018). Spline-based nonparametric inference in general state-switching models. Statistica Neerlandica, 72(3), 179-200.
- Li, J., Li, X., & He, D. (2019). A directed acyclic graph network combined with CNN and LSTM for remaining useful life prediction. IEEE Access, 7, 75464-75475.
- Lloyd, S. (1982). Least squares quantization in PCM. IEEE transactions on information theory, 28(2), 129-137.
- ÓConnell, J., & Højsgaard, S. (2011). Hidden semi markov models for multiple observation sequences: The mhsmm package for R. Journal of Statistical Software, 39(4), 1-22.
- R Development Core Team (2010). R: A Language and Environment for Statistical Computing. R Foundation for Statistical Computing, Vienna, Austria. ISBN 3-900051-07-0, URL http://www.R-project.org/.
- Saxena, A., Goebel, K., Simon, D., & Eklund, N. (2008, October). Damage propagation modeling for aircraft engine run-to-failure simulation. In 2008 international conference on prognostics and health management (pp. 1-9). IEEE.
- Schellhase, C. & Kauermann, G. (2012). Density estimation and comparison with a penalized mixture approach. Computational Statistics, 27, 757-777.
- Van Buuren, S., & Groothuis-Oudshoorn, K. (2011). mice: Multivariate imputation by chained equations in R. Journal of statistical software, 45, 1-67.
- Visser, I., & Speekenbrink, M. (2010). depmixS4: an R package for hidden Markov models. Journal of statistical Software, 36(7), 1-21.
- Viterbi, A. (1967). Error bounds for convolutional codes and an asymptotically optimum decoding algorithm. IEEE transactions on Information Theory, 13(2), 260-269.
