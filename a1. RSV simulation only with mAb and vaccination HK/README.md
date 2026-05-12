# Intervention Simulations — Hong Kong

**Folder:** `a1. RSV simulation only with mAb and vaccination HK/`

This folder simulates the population-level impact of RSV intervention strategies in Hong Kong using the calibrated SEIR model. Three intervention types are modelled:

- **Long-acting monoclonal antibodies (mAbs)** for newborns / high-risk infants
- **Maternal vaccination** protecting infants through maternally derived immunity
- **Older adult vaccination** (ages 60–74 and ≥75 years)

Interventions are simulated individually and in combination, drawing uncertainty from the MCMC posterior.

---

## Prerequisites

Before running these scripts, complete the model fitting and results steps:

1. Run `main_HK.m` in `1. RSV c mex Hong Kong R1 rev block update logL component rev/`  
   → Produces `mcmc_result/hongkong_mcmc_res.csv`
2. *(Optional)* Run `main_HK_result.m` in `1. RSV results c mex Hong Kong R1/`  
   → Produces `RSV_simulation.mat` used by the plot script

---

## How to Run

### Step 1 — Run intervention simulations

```matlab
main_HK_result
```

This reads the MCMC posterior from the model fitting folder and simulates intervention scenarios, saving results to `RSV_simulation.mat`.

For infant-only and elderly-only intervention scenarios, additional scripts are available:

```matlab
main_HK_result_infant_only     % mAb and maternal vaccination only
main_HK_result_elderly_only    % Older adult vaccination only
```

### Step 2 — Generate impact figures

```matlab
main_HK_result_plot_impact
```

This reads `RSV_simulation.mat` and produces figures showing the percentage reduction in RSV outcomes by age group and intervention scenario.

### Step 3 — Combined impact figure (across all regions)

```matlab
main_plot_combined_impact
```

Generates a combined figure comparing intervention impacts across Hong Kong, Beijing, and Thailand (requires equivalent `.mat` files from `a2` and `a3` folders).

---

## Intervention Parameters Assumed

| Intervention | Coverage | Effectiveness |
|---|---|---|
| mAb (nirsevimab) | 25% of newborns | 77.3% (95% CI: 50.3–89.7%) |
| Maternal vaccination | 38.5% of pregnant women | 69.4% (95% CI: 44.3–84.1%) |
| Older adult vaccination | 15.7% / 31.4% / 39.7% of 60+ | 80% (95% CI: 71–85%) |

Coverage and effectiveness are sampled stochastically across `numRnd = 300` Monte Carlo iterations, each paired with a draw from the MCMC posterior.

---

## File Descriptions

| File | Description |
|------|-------------|
| `main_HK_result.m` | **Main simulation script** — runs intervention scenarios, saves `RSV_simulation.mat` |
| `main_HK_result_infant_only.m` | Infant-targeted interventions only (mAb + maternal vaccination) |
| `main_HK_result_elderly_only.m` | Older adult vaccination only |
| `main_HK_result_plot_impact.m` | Generates intervention impact figures from `RSV_simulation.mat` |
| `main_plot_combined_impact.m` | Combined cross-region impact figure |
| `main_vax_effectiveness_waning.m` | Sensitivity analysis: vaccine effectiveness waning |
| `age_SEIR_RSV_intervention.m` | Extended SEIR model with intervention compartments (mAb, maternal vax, older adult vax) |
| `age_SEIR_RSV_intervention_mex.mexw64` | Pre-compiled MEX file of intervention model (Windows) |
| `age_SEIR_RSV_intervention.coderprj` | MATLAB Coder project for recompiling intervention MEX |
| `age_SEIR_RSV.m` | Baseline SEIR model (without interventions) |
| `age_SEIR_initial_conditions.m` | Standard model initialisation |
| `age_SEIR_initial_conditions_intervention.m` | Initialisation for intervention model (adds vaccine compartments) |
| `mcmcRes_RSV.m` | Loads MCMC results and runs model over posterior |
| `mcmcRes_RSV_intervention.m` | Loads results and runs intervention model over posterior |
| `fig_reduction_by_age_group.m` | Bar plots of % reduction in RSV by age group |
| `fig_reduction_by_age_group_errorbar.m` | Reduction plots with uncertainty intervals |
| `loadAgeDistrCensus.m` | Census age distribution loader |
| `loadPolymodMatrix.m` | Contact matrix loader |
| `loadTotalPopulation.m` | Population loader |
| `polymodContactMatrix.m` | Contact matrix constructor |
| `polymodHKcontactMatrix.m` | HK-specific contact matrix |
| `calcAgingRate.m` | Aging rate computation |
| `calcTotalPopulationArrOneYear.m` | Annual population array |
| `findAgeGroupSmallInterv.m` | Age group mapping |
| `saveIntermediateStateVariables.m` | State variable saving |
| `write_matrix_new.m` | CSV writing utility |
| `main_test_age_SEIR_RSV_intervention.m` | Test script for intervention model |

---

## Output Files

| File | Description |
|------|-------------|
| `RSV_simulation.mat` | Raw intervention simulation results (posterior × scenario) |
| `figs/` | Saved figure files |
