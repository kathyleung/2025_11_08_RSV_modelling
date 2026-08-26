# Hong Kong Fitting Folder

This folder contains the Hong Kong RSV model-fitting workflow for the R2 revision, together with the saved MCMC outputs used by the downstream results scripts.

## Entry point

- `main_HK.m`: main fitting script. It loads data from `../0. data`, defines the Hong Kong model, and writes outputs into `mcmc_result/`.

## Key supporting files

- `logLikelihood_RSV.m`, `negTotalLogLikelihood.m`, `logPriorDistribution.m`: posterior objective components.
- `mcmcParallelBlock.m`, `mcmcProposal.m`, `proposeBoundedPair.m`, `proposePair1415.m`: MCMC update steps.
- `age_SEIR_RSV_mex.mexw64`, `age_SEIR_RSV_mex.mexmaca64`: prebuilt accelerated simulator binaries.
- `age_SEIR_RSV.m`: MATLAB source version of the simulator kept for transparency/reference.

## Outputs

- `mcmc_result/hongkong_mcmc_res.csv`: posterior samples.
- `mcmc_result/hongkong_mle.csv`: starting point / fitted parameter summary.
- `mcmc_result/hongkong_log_likelihood*.csv`: likelihood traces and component summaries.
- `mcmc_result/hongkong_parameter_step.csv`: proposal step sizes.

## Notes

- The script now resets its own working directory, so it can be launched from outside this folder.
- Re-running the MCMC workflow can take substantial time.
