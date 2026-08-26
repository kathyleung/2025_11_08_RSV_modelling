# RSV Modelling Nature Communications R2

This repository is a MATLAB package for the RSV modelling analyses used in the manuscript revision. It contains the cleaned model-fitting folders, post-processing folders, and the supporting data needed to reproduce the main country-specific analyses for Hong Kong, Beijing, and Thailand.

## Repository structure

- `0. data`: input datasets and reference material used by the model and plotting scripts.
- `1. RSV c mex Hong Kong R2 rev block update logL component rev NB fix reparam 14 15`: Hong Kong model fitting code and saved MCMC outputs.
- `1. RSV results c mex Hong Kong R2`: Hong Kong post-processing and figure scripts.
- `4. RSV c mex Beijing R2 block update logL component NB fix reparam 14 15`: Beijing model fitting code and saved MCMC outputs.
- `4. RSV results c mex Beijing R2`: Beijing post-processing and figure scripts.
- `7. RSV c mex Thailand R2 block update logL component NB fix reparam 14 15`: Thailand model fitting code and saved MCMC outputs.
- `7. RSV result c mex Thailand R2`: Thailand post-processing and figure scripts.

## Requirements

- MATLAB with Statistics and Machine Learning Toolbox.
- Parallel Computing Toolbox is used by some `parfor` sections but is not required for simple inspection.
- Prebuilt MEX binaries for `age_SEIR_RSV_mex` are included for Windows (`.mexw64`) and macOS (`.mexmaca64`).

## Recommended usage

1. Open MATLAB anywhere; the main scripts now reset their own working directory internally.
2. For each region, use the fitting folder if you want to rerun the MCMC workflow.
3. Use the corresponding results folder to regenerate posterior summaries and manuscript-style figures from the bundled MCMC outputs.

## Notes

- The `mcmc_result` folders already contain saved posterior samples and likelihood summaries.
- The `figs` folders contain pre-generated exports kept for convenience.
- Each subfolder contains its own `README.md` with script-level details.
