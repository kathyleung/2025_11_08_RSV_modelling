# Model Fitting — Thailand

**Folder:** `7. RSV c mex Thailand R1 block update logL component/`

This folder contains all MATLAB code to fit the age-structured RSV SEIR transmission model to Thailand data using Bayesian inference (MCMC). The model structure mirrors the Hong Kong and Beijing models, with Thailand-specific surveillance data, contact matrices, and population demographics.

---

## How to Run

1. Open MATLAB and set the working directory to this folder.
2. Ensure the `../0. data/` folder is present (see `0. data/README.md`).
3. Verify that the MEX file `age_SEIR_RSV_mex` is available:
   - Windows: `age_SEIR_RSV_mex.mexw64` (included)
   - macOS Apple Silicon: `age_SEIR_RSV_mex.mexmaca64` (included)
   - Other platforms: recompile from `age_SEIR_RSV.m` using `age_SEIR_RSV.coderprj` or `age_SEIR_RSV_mac.coderprj`.
4. Run the main script:
   ```matlab
   main_Thailand
   ```

---

## What `main_Thailand.m` Does

1. **Loads Thailand input data** from `../0. data/`:
   - Annual RSV cases by age group (`Thailand_ILI_hosp/thailand_RSV_case_by_age.csv`)
   - RSV-F IgG seroprevalence data (HK ELISA cohort, used as a prior)
   - RSV seroprevalence meta-analysis data
   - Thai seroprevalence cohort data (hardcoded; Sitthikarnkha et al., 2022)
   - Thailand population census and social contact matrices

2. **Initialises the SEIR model** with 25 age groups (same structure as HK and Beijing).

3. **Runs MLE** using `fmincon`, saving results to `mcmc_result/thailand_mle.csv`.

4. **Runs MCMC** (Metropolis-within-Gibbs with block updates, 40 000 steps).
   - Posterior samples appended to `mcmc_result/thailand_mcmc_res.csv`.
   - Step sizes saved to `mcmc_result/thailand_parameter_step.csv`.
   - The run is resumable: if output files already exist, the script continues from the last state.

---

## Output Files

All outputs are saved to the `mcmc_result/` subfolder (created automatically):

| File | Description |
|------|-------------|
| `thailand_mle.csv` | Maximum likelihood parameter estimates |
| `thailand_mcmc_res.csv` | MCMC posterior samples |
| `thailand_parameter_step.csv` | Adaptive MCMC step sizes |

---

## File Descriptions

| File | Description |
|------|-------------|
| `main_Thailand.m` | **Main script** — loads data, runs MLE and MCMC |
| `age_SEIR_RSV.m` | SEIR ODE model (source for MEX compilation) |
| `age_SEIR_RSV_mex.mexw64` | Pre-compiled MEX file (Windows) |
| `age_SEIR_RSV_mex.mexmaca64` | Pre-compiled MEX file (macOS Apple Silicon) |
| `age_SEIR_RSV.coderprj` | MATLAB Coder project (Windows) |
| `age_SEIR_RSV_mac.coderprj` | MATLAB Coder project (macOS) |
| `age_SEIR_initial_conditions.m` | Sets initial compartment values |
| `calcMCMCTotalLogLikelihood.m` | Total log-likelihood computation |
| `logLikelihood_RSV.m` | Log-likelihood for RSV surveillance data |
| `calculateSeasonalLikelihood.m` | Seasonal likelihood component |
| `logPriorDistribution.m` | Log-prior density |
| `negTotalLogLikelihood.m` | Negative log-likelihood for `fmincon` |
| `parameterConstraint.m` | Parameter constraint enforcement |
| `mcmcParallelBlock.m` | Metropolis-within-Gibbs MCMC with block updates |
| `mcmcParallel.m` | Single-parameter MCMC sampler |
| `mcmcProposal.m` | MCMC proposal distribution |
| `loadAgeDistrCensus.m` | Census age distribution loader |
| `loadPolymodMatrix.m` | Contact matrix loader |
| `loadTotalPopulation.m` | Population loader |
| `polymodContactMatrix.m` | Contact matrix constructor |
| `polymodHKcontactMatrix.m` | HK contact matrix (reference) |
| `calcAgingRate.m` | Aging rate computation |
| `calcTotalPopulationArrOneYear.m` | Annual population array |
| `findAgeGroupSmallInterv.m` | Age group mapping |
| `saveIntermediateStateVariables.m` | State variable saving |
| `write_matrix_new.m` | CSV writing utility |
| `main_test_age_SEIR_RSV_Thailand.m` | Test script for model setup |
