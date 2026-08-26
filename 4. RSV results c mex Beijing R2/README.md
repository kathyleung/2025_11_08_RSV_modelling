# Beijing Results Folder

This folder contains the Beijing post-processing scripts used to regenerate posterior diagnostics, burden summaries, and manuscript-style plots from the saved Beijing MCMC chain.

## Main scripts

- `main_Beijing_result.m`: reproduces the main Beijing simulation summaries from the saved chain.
- `main_posterior.m`: plots posterior distributions and diagnostics.

## Additional figure scripts

- `fig_monthly_rsv.m`
- `fig_monthly_rsv_rates.m`
- `fig_period_rsv_by_age_groups.m`
- `fig_period_rsv_by_age_groups_rates.m`
- `fig_period_rsv_by_4age_groups.m`
- `fig_period_rsv_by_4age_groups_rates.m`
- `fig_serology_*.m`
- `fig_combined_3_12_7.m`

## Included outputs

- `figs/`: exported figure files kept for convenience.
- `RSV_simulation_raw_results.mat`: cached simulation results used by some figure workflows.

## Notes

- The scripts read the saved chain from `../4. RSV c mex Beijing R2 block update logL component NB fix reparam 14 15/mcmc_result/`.
- The bundled result script now checks for the required MEX binary before running long simulations.
