# RSV Transmission Modelling — Hong Kong, Beijing, and Thailand

This repository contains all code and data associated with the paper:

> **Estimating the impact of vaccination and long-acting monoclonal antibodies for RSV epidemics across Hong Kong, Beijing, and Thailand: a modelling study**  
> *medRxiv* 2025. https://doi.org/10.1101/2025.11.06.25339729

---

## Overview

We developed age-structured SEIR transmission models for RSV (Respiratory Syncytial Virus) calibrated to region-specific surveillance and seroprevalence data from 2014–2019 for three Asian settings. Using Bayesian inference (Markov Chain Monte Carlo), we estimated RSV transmission dynamics and simulated intervention scenarios involving:

- Long-acting monoclonal antibodies (mAbs) for high-risk infants
- Maternal vaccination
- Older adult vaccination

The modelling framework is adapted from [Hodgson et al. (BMC Medicine)](https://bmcmedicine.biomedcentral.com/articles/10.1186/s12916-020-01802-8).

---

## Software Requirements

- **MATLAB** (R2022b or later recommended)
- **MATLAB Optimization Toolbox** (for `fmincon`)
- Pre-compiled MEX files are included for Windows (`.mexw64`) and macOS Apple Silicon (`.mexmaca64`). If you are on a different platform, recompile `age_SEIR_RSV.m` (or `age_SEIR_RSV_intervention.m`) using the provided `.coderprj` / `.prj` MATLAB Coder project file.

---

## Repository Structure

```
2025_11_08_RSV_modelling/
│
├── 0. data/                          # All input data
│
├── 1. RSV c mex Hong Kong R1 .../    # Model fitting (MCMC) — Hong Kong
├── 1. RSV results c mex Hong Kong R1/# Results & figures — Hong Kong
│
├── 4. RSV c mex Beijing R1 .../      # Model fitting (MCMC) — Beijing
├── 4. RSV results c mex Beijing R1/  # Results & figures — Beijing
│
├── 7. RSV c mex Thailand R1 .../     # Model fitting (MCMC) — Thailand
├── 7. RSV result c mex Thailand R1/  # Results & figures — Thailand
│
├── a1. RSV simulation ... HK/        # Intervention simulations — Hong Kong
├── a2. RSV simulation ... BJ/        # Intervention simulations — Beijing
└── a3. RSV simulation ... Thailand/  # Intervention simulations — Thailand
```

See each subfolder's own `README.md` for detailed instructions.

---

## Recommended Workflow

The analysis should be run in the following order:

### Step 1 — Model fitting (one per region)
Run the MCMC calibration for each region independently. Each calibration is self-contained:

| Region      | Folder                                                              | Main file        |
|-------------|---------------------------------------------------------------------|------------------|
| Hong Kong   | `1. RSV c mex Hong Kong R1 rev block update logL component rev/`   | `main_HK.m`      |
| Beijing     | `4. RSV c mex Beijing R1 block update logL component copy prior/`  | `main_Beijing.m` |
| Thailand    | `7. RSV c mex Thailand R1 block update logL component/`            | `main_Thailand.m`|

Each script loads data from `../0. data/`, fits the model using `fmincon` (MLE) followed by Metropolis-within-Gibbs MCMC, and saves posterior samples to a `mcmc_result/` subfolder.

### Step 2 — Summarise results and generate figures
After MCMC is complete, run the results scripts, which read the posterior samples and produce model-fit figures and infection attack rate estimates:

| Region      | Folder                                  | Main file               |
|-------------|-----------------------------------------|-------------------------|
| Hong Kong   | `1. RSV results c mex Hong Kong R1/`    | `main_HK_result.m`      |
| Beijing     | `4. RSV results c mex Beijing R1/`      | `main_Beijing_result.m` |
| Thailand    | `7. RSV result c mex Thailand R1/`      | `main_Thailand_result.m`|

### Step 3 — Intervention simulations
Using calibrated posterior samples, simulate the impact of mAb and vaccination strategies:

| Region      | Folder                                             | Main file(s)                                    |
|-------------|----------------------------------------------------|-------------------------------------------------|
| Hong Kong   | `a1. RSV simulation only with mAb and vaccination HK/` | `main_HK_result.m`, `main_HK_result_plot_impact.m` |
| Beijing     | `a2. RSV simulation only with mAb and vaccination BJ/` | `main_BJ_result.m`, `main_BJ_result_plot_impact.m` |
| Thailand    | `a3. RSV simulation only with mAb and vaccination Thailand/` | `main_TL_result.m`, `main_TL_result_plot_impact.m` |

---

## Data Availability

Publicly available data sources are included in the `0. data/` folder. Hong Kong RSV surveillance data (from the Centre for Health Protection) and Hong Kong seroprevalence data were provided by the data owners; these files are included with permission. See `0. data/README.md` for full details of each data source.

---

## Citation

If you use this code, please cite:

> Leung K, *et al*. Estimating the impact of vaccination and long-acting monoclonal antibodies for RSV epidemics across Hong Kong, Beijing, and Thailand: a modelling study. *medRxiv* 2025 (preprint; under review at *Nature Communications*). https://doi.org/10.1101/2025.11.06.25339729

> **Note:** This citation will be updated to the peer-reviewed journal article upon publication. The code in this repository corresponds to the revised version submitted in response to reviewers' comments.

---

## Funding

This research was supported by the MSD Investigator Studies Program (MISP 101875), General Research Fund (17111524), Health and Medical Research Fund (CID-HKU2, 21200122), and the AIR@InnoHK administered by the Innovation and Technology Commission of the Hong Kong SAR Government.

---

## Contact

For questions regarding the code or data, please contact the corresponding author or open a GitHub Issue.
