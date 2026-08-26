# Beijing Fitting Folder

This folder contains the Beijing RSV model-fitting workflow for the R2 revision and the saved MCMC outputs used in the results folder.

## Entry point

- `main_Beijing.m`: main fitting script. It loads the Beijing surveillance inputs from `../0. data`, defines the model, and writes outputs into `mcmc_result/`.

## Key supporting files

- `logLikelihood_RSV.m`, `negTotalLogLikelihood.m`, `logPriorDistribution.m`: posterior objective components.
- `mcmcParallelBlock.m`, `mcmcProposal.m`, `proposePair1415.m`: MCMC update steps.
- `age_SEIR_RSV_mex.mexw64`, `age_SEIR_RSV_mex.mexmaca64`: prebuilt accelerated simulator binaries.
- `age_SEIR_RSV.m`: MATLAB source version retained for reference.

## Outputs

- `mcmc_result/China_subnational_Beijing_mcmc_res.csv`: posterior samples.
- `mcmc_result/China_subnational_Beijing_mle.csv`: fitted parameter summary.
- `mcmc_result/China_subnational_Beijing_log_likelihood*.csv`: likelihood traces and component summaries.
- `mcmc_result/China_subnational_Beijing_parameter_step.csv`: proposal step sizes.

## Notes

- The script now resets its own working directory before loading files.
- The Beijing period-age data are filtered internally to remove overlapping aggregate periods before fitting.
