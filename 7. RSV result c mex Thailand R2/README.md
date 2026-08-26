# Thailand Results Folder

This folder contains the Thailand post-processing scripts used to regenerate posterior diagnostics, disease-burden summaries, and figures from the saved Thailand MCMC chain.

## Main scripts

- `main_Thailand_result.m`: reproduces the main Thailand simulation summaries from the saved chain.
- `main_posterior.m`: plots posterior distributions and diagnostics.

## Additional figure scripts

- `fig_monthly_rsv_by_age_groups.m`
- `fig_monthly_rsv_by_age_groups_rates.m`
- `fig_yearly_rsv_by_age_groups_rates.m`
- `fig_serology_*.m`
- `fig_combined_4_7_13.m`

## Included outputs

- `figs/`: exported figure files kept for convenience.
- `RSV_simulation_raw_results.mat`: cached simulation results used by some figure workflows.

## Notes

- The scripts read the saved chain from `../7. RSV c mex Thailand R2 block update logL component NB fix reparam 14 15/mcmc_result/`.
- The result script now checks for the required MEX binary before starting the simulation loop.
