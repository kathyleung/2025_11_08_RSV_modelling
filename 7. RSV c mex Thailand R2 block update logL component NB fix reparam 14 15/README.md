# Thailand Fitting Folder

This folder contains the Thailand RSV model-fitting workflow for the R2 revision and the saved MCMC outputs used in the results folder.

## Entry point

- `main_Thailand.m`: main fitting script. It loads Thailand surveillance inputs from `../0. data`, defines the model, and writes outputs into `mcmc_result/`.

## Key supporting files

- `logLikelihood_RSV.m`, `negTotalLogLikelihood.m`, `logPriorDistribution.m`: posterior objective components.
- `mcmcParallelBlock.m`, `mcmcProposal.m`, `proposeBoundedPair.m`, `proposeBoundedPairCov.m`, `proposeBoundedBlockCov.m`: MCMC update steps.
- `age_SEIR_RSV_mex.mexw64`, `age_SEIR_RSV_mex.mexmaca64`: prebuilt accelerated simulator binaries.
- `age_SEIR_RSV.m`: MATLAB source version retained for reference.

## Outputs

- `mcmc_result/thailand_mcmc_res.csv`: posterior samples.
- `mcmc_result/thailand_mle.csv`: fitted parameter summary.
- `mcmc_result/thailand_log_likelihood*.csv`: likelihood traces and component summaries.
- `mcmc_result/thailand_parameter_step.csv`: proposal step sizes.

## Notes

- The script now resets its own working directory before reading or writing files.
- This folder includes the bounded-parameter proposal helpers specific to the Thailand fit.
