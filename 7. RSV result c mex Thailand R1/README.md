# Results & Figures — Thailand

**Folder:** `7. RSV result c mex Thailand R1/`

This folder contains MATLAB scripts to process MCMC posterior samples from the Thailand model fitting, summarise epidemiological outputs, and generate all Thailand-related figures in the paper.

---

## Prerequisites

Before running these scripts, complete the model fitting step:  
→ Run `main_Thailand.m` in `7. RSV c mex Thailand R1 block update logL component/`

---

## How to Run

1. Open MATLAB and set the working directory to this folder.
2. Run the main results script:
   ```matlab
   main_Thailand_result
   ```

---

## What `main_Thailand_result.m` Does

1. **Loads MCMC posterior samples** via `mcmcRes_RSV.m`.
2. **Re-runs the SEIR model** across the posterior to produce:
   - Monthly/annual RSV incidence by age group
   - Seroprevalence by age
   - Annual infection attack rates (IARs)
3. **Saves raw simulation outputs** to `RSV_simulation_raw_results.mat`.
4. **Generates figures** for paper reporting.

---

## Figure Scripts

| Script | Description |
|--------|-------------|
| `fig_monthly_rsv_by_age_groups.m` | Monthly RSV incidence by age group: model vs. data |
| `fig_monthly_rsv_by_age_groups_rates.m` | Monthly RSV rates per population by age group |
| `fig_yearly_rsv_by_age_groups_rates.m` | Annual RSV rates by age group |
| `fig_yearly_IAR_by_age.m` | Annual infection attack rates by age group |
| `fig_serology_HK_BJ_Thailand.m` | Seroprevalence comparison across all three regions |
| `fig_serology_asia.m` | Seroprevalence vs. age — Asian data |
| `fig_serology_meta.m` | Seroprevalence vs. age — meta-analysis data |
| `fig_serology_meta_outside_asia.m` | Seroprevalence vs. age — non-Asian meta-analysis data |
| `fig_combined_4_7_13.m` | Combined multi-panel figure (Figures 4, 7, 13 in paper) |
| `ecdf_posterior.m` | Empirical CDF of posterior parameter distributions |

---

## Supporting Scripts

| Script | Description |
|--------|-------------|
| `main_posterior.m` | Processes and summarises posterior distributions |
| `mcmcRes_RSV.m` | Loads MCMC results |
| `age_SEIR_initial_conditions.m` | Model initialisation |
| `loadAgeDistrCensus.m` | Census age distribution loader |
| `loadPolymodMatrix.m` | Contact matrix loader |
| `loadTotalPopulation.m` | Population size loader |
| `polymodContactMatrix.m` | Contact matrix constructor |
| `polymodHKcontactMatrix.m` | HK contact matrix constructor |
| `calcAgingRate.m` | Aging rate computation |
| `calcTotalPopulationArrOneYear.m` | Annual population array |
| `findAgeGroupSmallInterv.m` | Age group mapping utility |
| `saveIntermediateStateVariables.m` | State variable saving |
| `write_matrix_new.m` | CSV writing utility |

---

## Output Files

| File | Description |
|------|-------------|
| `RSV_simulation_raw_results.mat` | Raw simulation outputs across posterior samples |
