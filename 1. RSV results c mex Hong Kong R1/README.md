# Results & Figures — Hong Kong

**Folder:** `1. RSV results c mex Hong Kong R1/`

This folder contains MATLAB scripts to process MCMC posterior samples from the Hong Kong model fitting, summarise key epidemiological outputs, and generate all figures related to Hong Kong in the paper.

---

## Prerequisites

Before running these scripts, complete the model fitting step:  
→ Run `main_HK.m` in `1. RSV c mex Hong Kong R1 rev block update logL component rev/`  
→ This produces the MCMC posterior file used here (loaded via `mcmcRes_RSV.m`).

---

## How to Run

1. Open MATLAB and set the working directory to this folder.
2. Ensure `../0. data/` is in place and MCMC results from the model fitting step are available.
3. Run the main results script:
   ```matlab
   main_HK_result
   ```

---

## What `main_HK_result.m` Does

1. **Loads MCMC posterior samples** (via `mcmcRes_RSV.m`, which points to the saved posterior CSV from the model fitting step).
2. **Re-runs the SEIR model** across the posterior to obtain posterior predictive distributions of:
   - Weekly/monthly RSV incidence by age group
   - Seroprevalence by age
   - Annual infection attack rates (IARs) by age group
3. **Generates figures** for model validation and results reporting (see figure scripts below).

---

## Figure Scripts

| Script | Description |
|--------|-------------|
| `fig_weekly_rsv.m` | Time series of weekly RSV detections: model fit vs. observed data |
| `fig_monthly_rsv_by_age_groups.m` | Monthly RSV cases by age group: model fit vs. data |
| `fig_monthly_rsv_by_age_groups_rates.m` | Monthly RSV rates per population by age group |
| `fig_yearly_rsv_by_age_groups_rates.m` | Annual RSV rates by age group |
| `fig_period_rsv_by_age_groups_rates.m` | RSV rates by epidemic period and age group |
| `fig_yearly_IAR_by_age.m` | Annual infection attack rates (IARs) by age group |
| `fig_serology.m` | Model-predicted vs. observed seroprevalence (HK data) |
| `fig_serology_HK_BJ_Thailand.m` | Seroprevalence comparison across Hong Kong, Beijing, and Thailand |
| `fig_serology_asia.m` | Seroprevalence vs. age — Asian data sources |
| `fig_serology_meta.m` | Seroprevalence vs. age — meta-analysis data |
| `fig_serology_meta_outside_asia.m` | Seroprevalence vs. age — non-Asian meta-analysis data |
| `fig_combined_5_10_12.m` | Combined multi-panel figure (Figures 5, 10, 12 in paper) |
| `ecdf_posterior.m` | Empirical CDF plots of posterior parameter distributions |

---

## Supporting Scripts

| Script | Description |
|--------|-------------|
| `main_posterior.m` | Processes and summarises posterior distributions |
| `main_posterior_reporting.m` | Formats posterior summaries for reporting |
| `mcmcRes_RSV.m` | Loads MCMC results and defines the posterior sample set |
| `age_SEIR_RSV.m` | SEIR model (used to re-run simulations over posterior) |
| `age_SEIR_RSV_mex.mexw64` | Pre-compiled MEX file (Windows) |
| `age_SEIR_RSV_mex.mexmaca64` | Pre-compiled MEX file (macOS Apple Silicon) |
| `age_SEIR_initial_conditions.m` | Initialises model state variables |
| `loadAgeDistrCensus.m` | Loads census age distribution |
| `loadPolymodMatrix.m` | Loads social contact matrices |
| `loadTotalPopulation.m` | Loads population size |
| `polymodContactMatrix.m` | Constructs contact matrix for model age groups |
| `polymodHKcontactMatrix.m` | HK-specific contact matrix construction |
| `calcAgingRate.m` | Computes aging rates |
| `calcTotalPopulationArrOneYear.m` | Population array over one year |
| `findAgeGroupSmallInterv.m` | Maps fine age groups to broader intervention groups |
| `saveIntermediateStateVariables.m` | Saves intermediate model states |
| `write_matrix_new.m` | CSV writing utility |
| `AddLetters2Plots.m` | Adds panel labels (A, B, C…) to multi-panel figures |
