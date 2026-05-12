# Model Fitting — Hong Kong

**Folder:** `1. RSV c mex Hong Kong R1 rev block update logL component rev/`

This folder contains all MATLAB code to fit the age-structured RSV SEIR transmission model to Hong Kong data using Bayesian inference (MCMC). The model is adapted from [Hodgson et al. (BMC Medicine, 2020)](https://bmcmedicine.biomedcentral.com/articles/10.1186/s12916-020-01802-8).

---

## How to Run

1. Open MATLAB and set the working directory to this folder.
2. Ensure the `../0. data/` folder is present with all required data files (see `0. data/README.md`).
3. Verify that the MEX file `age_SEIR_RSV_mex` is available:
   - Windows: `age_SEIR_RSV_mex.mexw64` (included)
   - macOS Apple Silicon: `age_SEIR_RSV_mex.mexmaca64` (included)
   - Other platforms: recompile from `age_SEIR_RSV.m` using the provided `age_SEIR_RSV.coderprj` MATLAB Coder project.
4. Run the main script:
   ```matlab
   main_HK
   ```

---

## What `main_HK.m` Does

1. **Loads input data** from `../0. data/`:
   - Monthly laboratory-confirmed RSV cases by age group (Hong Kong CHP)
   - Weekly ILI and RSV laboratory detection data (Hong Kong CHP)
   - RSV-F IgG seroprevalence data (local HK ELISA cohort)
   - RSV seroprevalence from a systematic review meta-analysis
   - Thai seroprevalence cohort data (hardcoded)
   - Population census and social contact matrices for Hong Kong

2. **Initialises the SEIR model** with 25 age groups:
   - Monthly groups: <1, 1, 2, …, 11 months
   - Annual/multi-year groups: 1, 2, 3, 4, 5, 5–9, 10–14, 15–24, 25–34, 35–44, 45–54, 55–64, 65–74, ≥75 years

3. **Computes an MLE estimate** using `fmincon` (MATLAB Optimization Toolbox).  
   - MLE result is saved to `mcmc_result/hongkong_mle.csv`.
   - If a previous MLE or MCMC result exists, it is loaded as the starting point.

4. **Runs MCMC** (Metropolis-within-Gibbs with block updates, 40 000 steps) via `mcmcParallelBlock.m`.
   - Posterior samples are appended to `mcmc_result/hongkong_mcmc_res.csv`.
   - Step sizes are saved to `mcmc_result/hongkong_parameter_step.csv`.
   - The MCMC can be interrupted and resumed: if `hongkong_mcmc_res.csv` already exists, the run continues from the last saved state.

---

## Key Parameters Estimated

| Parameter | Description |
|-----------|-------------|
| `xiMaternalImmunity` | Rate of waning maternally derived immunity |
| `omegaInfectionImmunity` | Rate of waning post-infection immunity |
| `sigmaExposure` | Rate of progression from exposed to infectious |
| `gammaZeroPrimaryInfection` | Recovery rate from primary infection |
| `g1`, `g2` | Relative reduction in infectious duration for repeat infections |
| `delta1`, `delta2`, `delta3` | Relative susceptibility for repeat infections |
| `pAsym` | Proportion asymptomatic by age group |
| `alphaReductionInfectiousness` | Relative infectiousness of asymptomatic cases |
| `qTransmissPhysical` | Transmission probability per physical contact |
| `b1AmpTransmissPeak` | Amplitude of seasonal forcing |
| `phiSeasonalShift` | Phase shift of seasonal forcing |
| `psiSeasonalWavelength` | Wavelength of seasonal forcing |
| `expReport`, `epsilonReport*` | Reporting rate parameters |
| `probSeropos` | Seroconversion probability |

---

## Output Files

All outputs are saved to the `mcmc_result/` subfolder (created automatically):

| File | Description |
|------|-------------|
| `hongkong_mle.csv` | Maximum likelihood parameter estimates |
| `hongkong_mcmc_res.csv` | MCMC posterior samples (each row = one iteration) |
| `hongkong_parameter_step.csv` | Adaptive MCMC step sizes |

---

## File Descriptions

| File | Description |
|------|-------------|
| `main_HK.m` | **Main script** — loads data, runs MLE and MCMC |
| `age_SEIR_RSV.m` | SEIR ODE model (source for MEX compilation) |
| `age_SEIR_RSV_mex.mexw64` | Pre-compiled MEX file (Windows) |
| `age_SEIR_RSV_mex.mexmaca64` | Pre-compiled MEX file (macOS Apple Silicon) |
| `age_SEIR_RSV.coderprj` / `.prj` | MATLAB Coder project for recompiling MEX |
| `age_SEIR_initial_conditions.m` | Sets initial compartment values |
| `calcMCMCTotalLogLikelihood.m` | Computes total log-likelihood (all data sources) |
| `logLikelihood_RSV.m` | Log-likelihood for RSV surveillance data |
| `calculateSeasonalLikelihood.m` | Likelihood component for seasonal patterns |
| `logPriorDistribution.m` | Log-prior density for all parameters |
| `negTotalLogLikelihood.m` | Wrapper returning negative log-likelihood for `fmincon` |
| `parameterConstraint.m` | Enforces parameter constraints |
| `mcmcParallelBlock.m` | Metropolis-within-Gibbs MCMC with block updates |
| `mcmcParallel.m` | Alternative MCMC sampler (single-parameter updates) |
| `mcmcProposal.m` | Proposal distribution for MCMC |
| `loadAgeDistrCensus.m` | Loads age distribution from census data |
| `loadPolymodMatrix.m` | Loads social contact matrices |
| `loadTotalPopulation.m` | Loads total population size |
| `polymodContactMatrix.m` | Constructs contact matrix for model age groups |
| `polymodHKcontactMatrix.m` | Constructs HK-specific contact matrix |
| `calcAgingRate.m` | Computes aging rates between age groups |
| `calcTotalPopulationArrOneYear.m` | Computes population array over one year |
| `findAgeGroupSmallInterv.m` | Maps fine age groups to intervention age groups |
| `saveIntermediateStateVariables.m` | Saves model state variables during simulation |
| `write_matrix_new.m` | Utility for writing matrices to CSV |
| `main_data_HK_serology.m` | Auxiliary script for processing HK serology data |
| `main_test_age_SEIR_RSV.m` | Test script for checking model setup |
