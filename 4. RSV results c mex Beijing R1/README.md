# Results & Figures — Beijing

**Folder:** `4. RSV results c mex Beijing R1/`

This folder contains MATLAB scripts to process MCMC posterior samples from the Beijing model fitting, summarise epidemiological outputs, and generate all Beijing-related figures in the paper.

---

## Prerequisites

Before running these scripts, complete the model fitting step:  
→ Run `main_Beijing.m` in `4. RSV c mex Beijing R1 block update logL component copy prior/`

---

## How to Run

1. Open MATLAB and set the working directory to this folder.
2. Run the main results script:
   ```matlab
   main_Beijing_result
   ```

---

## What `main_Beijing_result.m` Does

1. **Loads MCMC posterior samples** via `mcmcRes_RSV.m`.
2. **Re-runs the SEIR model** across the posterior to produce:
   - Monthly RSV incidence by age group
   - Seroprevalence by age
   - Annual infection attack rates (IARs)
3. **Saves raw simulation outputs** to `RSV_simulation_raw_results.mat` for use by figure scripts.
4. **Generates figures** for model validation and paper reporting.

---

## Figure Scripts

| Script | Description |
|--------|-------------|
| `fig_monthly_rsv.m` | Monthly RSV detections: model fit vs. observed |
| `fig_monthly_rsv_rates.m` | Monthly RSV rates per population |
| `fig_period_rsv_by_age_groups.m` | RSV cases by epidemic period and age group |
| `fig_period_rsv_by_age_groups_rates.m` | RSV rates by period and age group |
| `fig_period_rsv_by_4age_groups.m` | RSV cases by period (4 broad age groups) |
| `fig_period_rsv_by_4age_groups_rates.m` | RSV rates by period (4 broad age groups) |
| `fig_yearly_IAR_by_age.m` | Annual infection attack rates by age group |
| `fig_serology_HK_BJ_Thailand.m` | Seroprevalence comparison across all three regions |
| `fig_serology_asia.m` | Seroprevalence vs. age — Asian data |
| `fig_serology_meta.m` | Seroprevalence vs. age — meta-analysis data |
| `fig_serology_meta_outside_asia.m` | Seroprevalence vs. age — non-Asian meta-analysis data |
| `fig_combined_3_12_7.m` | Combined multi-panel figure (Figures 3, 12, 7 in paper) |
| `ecdf_posterior.m` | Empirical CDF of posterior parameter distributions |

---

## Supporting Scripts

| Script | Description |
|--------|-------------|
| `main_posterior.m` | Processes and summarises posterior distributions |
| `mcmcRes_RSV.m` | Loads MCMC results |
| `age_SEIR_RSV.m` | SEIR model for re-running simulations |
| `age_SEIR_RSV_mex.mexw64` | Pre-compiled MEX file (Windows) |
| `age_SEIR_RSV_mex.mexmaca64` | Pre-compiled MEX file (macOS Apple Silicon) |
| `age_SEIR_initial_conditions.m` | Model initialisation |
| `loadAgeDistrCensus.m` | Census age distribution loader |
| `loadPolymodMatrix.m` | Contact matrix loader |
| `loadTotalPopulation.m` | Population size loader |
| `polymodContactMatrix.m` | Contact matrix constructor |
| `polymodHKcontactMatrix.m` | HK contact matrix constructor |
| `calcAgingRate.m` | Aging rate computation |
| `calcTotalPopulationArrOneYear.m` | Annual population array |
| `findAgeGroupSmallInterv.m` | Age group mapping utility |
| `saveIntermediateStateVariables.m` | State variable saving utility |
| `write_matrix_new.m` | CSV writing utility |
| `AddLetters2Plots.m` | Panel label utility |

---

## Output Files

| File | Description |
|------|-------------|
| `RSV_simulation_raw_results.mat` | Raw simulation outputs across posterior samples |
| `figs/` | Saved figure files |
