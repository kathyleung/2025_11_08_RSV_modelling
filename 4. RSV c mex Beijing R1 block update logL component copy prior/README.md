# Model Fitting — Beijing

**Folder:** `4. RSV c mex Beijing R1 block update logL component copy prior/`

This folder contains all MATLAB code to fit the age-structured RSV SEIR transmission model to Beijing data using Bayesian inference (MCMC). The model structure is the same as for Hong Kong, adapted with Beijing-specific surveillance data, contact matrices, and population demographics.

---

## How to Run

1. Open MATLAB and set the working directory to this folder.
2. Ensure the `../0. data/` folder is present with all required data files (see `0. data/README.md`).
3. Verify that the MEX file `age_SEIR_RSV_mex` is available:
   - Windows: `age_SEIR_RSV_mex.mexw64` (included)
   - macOS Apple Silicon: `age_SEIR_RSV_mex.mexmaca64` (included)
   - Other platforms: recompile from `age_SEIR_RSV.m` using `age_SEIR_RSV.coderprj`.
4. Run the main script:
   ```matlab
   main_Beijing
   ```

---

## What `main_Beijing.m` Does

1. **Loads Beijing input data** from `../0. data/`:
   - Monthly RSV-positive ILI/hospitalisation data (`Beijing_ILI_hosp/monthly_RSV_Beijing.xlsx`)
   - RSV cases by age group and epidemic period (`Beijing_ILI_hosp/period_RSV_by_age_Beijing.xlsx`)
   - RSV-F IgG seroprevalence data (HK ELISA cohort, used as a prior)
   - RSV seroprevalence meta-analysis data
   - Thai seroprevalence cohort data (hardcoded)
   - Beijing population census and social contact matrices

2. **Initialises the SEIR model** with 25 age groups (same structure as Hong Kong).

3. **Runs MLE** using `fmincon` (MATLAB Optimization Toolbox), saving results to `mcmc_result/beijing_mle.csv`.  
   If previous results exist, the script resumes from the last saved state.

4. **Runs MCMC** (Metropolis-within-Gibbs with block updates, 40 000 steps).
   - Posterior samples appended to `mcmc_result/beijing_mcmc_res.csv`.
   - Step sizes saved to `mcmc_result/beijing_parameter_step.csv`.

---

## Output Files

All outputs are saved to the `mcmc_result/` subfolder (created automatically):

| File | Description |
|------|-------------|
| `beijing_mle.csv` | Maximum likelihood parameter estimates |
| `beijing_mcmc_res.csv` | MCMC posterior samples |
| `beijing_parameter_step.csv` | Adaptive MCMC step sizes |

---

## File Descriptions

| File | Description |
|------|-------------|
| `main_Beijing.m` | **Main script** — loads data, runs MLE and MCMC |
| `age_SEIR_RSV.m` | SEIR ODE model (source for MEX compilation) |
| `age_SEIR_RSV_mex.mexw64` | Pre-compiled MEX file (Windows) |
| `age_SEIR_RSV_mex.mexmaca64` | Pre-compiled MEX file (macOS Apple Silicon) |
| `age_SEIR_RSV.coderprj` / `.prj` | MATLAB Coder project for recompiling MEX |
| `age_SEIR_initial_conditions.m` | Sets initial compartment values |
| `calcMCMCTotalLogLikelihood.m` | Computes total log-likelihood |
| `logLikelihood_RSV.m` | Log-likelihood for RSV surveillance data |
| `calculateSeasonalLikelihood.m` | Likelihood component for seasonal patterns |
| `logPriorDistribution.m` | Log-prior density |
| `negTotalLogLikelihood.m` | Negative log-likelihood wrapper for `fmincon` |
| `parameterConstraint.m` | Parameter constraint enforcement |
| `mcmcParallelBlock.m` | Metropolis-within-Gibbs MCMC with block updates |
| `mcmcParallel.m` | Single-parameter MCMC sampler |
| `mcmcProposal.m` | MCMC proposal distribution |
| `loadAgeDistrCensus.m` | Loads age distribution from census |
| `loadPolymodMatrix.m` | Loads social contact matrices |
| `loadTotalPopulation.m` | Loads total population size |
| `polymodContactMatrix.m` | Constructs contact matrix for model age groups |
| `polymodHKcontactMatrix.m` | HK-specific contact matrix (used as reference) |
| `calcAgingRate.m` | Computes aging rates |
| `calcTotalPopulationArrOneYear.m` | Population array over one year |
| `findAgeGroupSmallInterv.m` | Maps fine to broad age groups |
| `saveIntermediateStateVariables.m` | Saves model state variables |
| `write_matrix_new.m` | CSV writing utility |
| `main_test_age_SEIR_RSV_Beijing.m` | Test script for model setup |
