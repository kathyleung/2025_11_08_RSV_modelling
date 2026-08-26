# Hong Kong Results Folder

This folder contains the Hong Kong post-processing scripts used to summarize posterior samples and generate figures from the bundled MCMC outputs.

## Main scripts

- `main_HK_result.m`: reproduces the main Hong Kong simulation summaries and disease-burden outputs from the saved chain.
- `main_posterior.m`: plots posterior distributions and MCMC diagnostics.
- `main_posterior_reporting.m`: compares/reporting-related posterior quantities across Hong Kong, Beijing, and Thailand.

## Additional figure scripts

- `fig_weekly_rsv.m`
- `fig_monthly_rsv_by_age_groups.m`
- `fig_monthly_rsv_by_age_groups_rates.m`
- `fig_period_rsv_by_age_groups_rates.m`
- `fig_yearly_rsv_by_age_groups_rates.m`
- `fig_serology_*.m`
- `fig_combined_5_10_12.m`

## Included outputs

- `figs/`: exported figure files kept for convenience.
- `RSV_simulation_raw_results.mat`: cached simulation results used by some plotting workflows.

## Notes

- The scripts read the saved chain from `../1. RSV c mex Hong Kong R2 rev block update logL component rev NB fix reparam 14 15/mcmc_result/`.
- The folder contains the required MEX binaries so the main results script can be run directly.
