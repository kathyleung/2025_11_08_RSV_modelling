# Intervention Simulations — Beijing

**Folder:** `a2. RSV simulation only with mAb and vaccination BJ/`

This folder simulates the population-level impact of RSV intervention strategies in Beijing using the calibrated SEIR model. Three intervention types are modelled:

- **Long-acting monoclonal antibodies (mAbs)** for newborns / high-risk infants
- **Maternal vaccination** protecting infants through maternally derived immunity
- **Older adult vaccination** (ages 60–74 and ≥75 years)

Interventions are simulated individually and in combination, drawing uncertainty from the MCMC posterior.

---

## Prerequisites

Before running these scripts, complete the model fitting step:

→ Run `main_Beijing.m` in `4. RSV c mex Beijing R1 block update logL component copy prior/`  
  → Produces `mcmc_result/beijing_mcmc_res.csv`

---

## How to Run

### Step 1 — Run intervention simulations

```matlab
main_BJ_result
```

Reads the MCMC posterior, simulates intervention scenarios, and saves results to `RSV_simulation.mat`.

### Step 2 — Generate impact figures

```matlab
main_BJ_result_plot_impact
```

Reads `RSV_simulation.mat` and generates figures showing percentage reduction in RSV outcomes by age group and intervention scenario.

---

## Intervention Parameters Assumed

| Intervention | Coverage | Effectiveness |
|---|---|---|
| mAb (nirsevimab) | 25% of newborns | 77.3% (95% CI: 50.3–89.7%) |
| Maternal vaccination | 38.5% of pregnant women | 69.4% (95% CI: 44.3–84.1%) |
| Older adult vaccination | 15.7% / 31.4% / 39.7% of 60+ | 80% (95% CI: 71–85%) |

Coverage and effectiveness are sampled stochastically across 300 Monte Carlo iterations, each paired with a draw from the MCMC posterior.

---

## File Descriptions

| File | Description |
|------|-------------|
| `main_BJ_result.m` | **Main simulation script** — runs intervention scenarios, saves `RSV_simulation.mat` |
| `main_BJ_result_plot_impact.m` | Generates intervention impact figures |
| `age_SEIR_RSV_intervention.m` | Extended SEIR model with intervention compartments |
| `age_SEIR_RSV_intervention_mex.mexw64` | Pre-compiled MEX file (Windows) |
| `age_SEIR_RSV_intervention.coderprj` | MATLAB Coder project for recompiling intervention MEX |
| `age_SEIR_RSV.m` | Baseline SEIR model |
| `age_SEIR_RSV_mex.mexw64` | Pre-compiled baseline MEX file (Windows) |
| `age_SEIR_initial_conditions.m` | Standard model initialisation |
| `age_SEIR_initial_conditions_intervention.m` | Intervention model initialisation |
| `mcmcRes_RSV.m` | Loads MCMC results and runs model over posterior |
| `mcmcRes_RSV_intervention.m` | Loads results and runs intervention model over posterior |
| `fig_reduction_by_age_group_errorbar.m` | Reduction plots with uncertainty intervals |
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
| `main_test_age_SEIR_RSV_intervention.m` | Test script for intervention model |

---

## Output Files

| File | Description |
|------|-------------|
| `RSV_simulation.mat` | Raw intervention simulation results |
| `figs/` | Saved figure files |
