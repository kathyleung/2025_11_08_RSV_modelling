# Data — `0. data/`

This folder contains all input data used in the RSV modelling study. It is shared across the model fitting and results scripts for all three regions.

---

## Folder Structure

```
0. data/
├── 2024_12_27_age_distr_HK.csv              # Hong Kong age distribution (census)
├── 2025_03_28_age_distr_Beijing.csv         # Beijing age distribution (census)
├── 2025_03_28_age_distr_Thailand.csv        # Thailand age distribution (census)
│
├── Hong_Kong_CHP/                           # Hong Kong surveillance data
├── Hong_Kong_serology_CC/                   # Hong Kong RSV seroprevalence (ELISA)
├── HK_social_contact_survey/                # Hong Kong social contact matrices
│
├── Beijing_ILI_hosp/                        # Beijing RSV surveillance data
├── Beijing_social_contact_matrix/           # Beijing social contact matrices
│
├── Thailand_ILI_hosp/                       # Thailand RSV surveillance data
├── Thailand_social_contact_matrix/          # Thailand social contact matrices
│
└── Nakajo_review_paper/                     # RSV seroprevalence meta-analysis data
```

---

## Data Sources

### Hong Kong

| File / Folder | Description | Source |
|---|---|---|
| `Hong_Kong_CHP/RSV data to HKU.xlsx` | Monthly laboratory-confirmed RSV cases by age group (0–5 months, 6–11 months, 1–4 yr, 5–64 yr, 65–74 yr, ≥75 yr), 2014–2024 | Hong Kong Centre for Health Protection (CHP), provided on request |
| `Hong_Kong_CHP/flux_data.xlsx` | Weekly ILI consultation rates and influenza/RSV laboratory data, 2014–2024 | Hong Kong CHP public website |
| `Hong_Kong_CHP/weekly_lab_2014_2024.csv` | Pre-processed weekly RSV laboratory detection data | Derived from annual CHP CSV files in the same folder |
| `Hong_Kong_CHP/detection_of_other_respiratory_viruses_*.csv` | Annual raw CSV files of weekly respiratory virus detections (2014–2024) | Hong Kong CHP public website |
| `Hong_Kong_CHP/Hong_Kong_census/` | Population census tables | Hong Kong Census and Statistics Department |
| `Hong_Kong_serology_CC/250813CC RSV-F IgG data cutoff.xlsx` | Individual-level RSV-F IgG seroprevalence data by age | Collected locally (HKU); provided with permission |
| `HK_social_contact_survey/hongkong_contact_matrix_prem_all.csv` | Overall social contact matrix for Hong Kong | Prem et al. contact data |
| `HK_social_contact_survey/hongkong_age_distribution_prem_all*.csv` | Age distribution used for contact matrix construction | Prem et al. |
| `2024_12_27_age_distr_HK.csv` | Hong Kong population by single-year age group | Hong Kong Census and Statistics Department |

### Beijing

| File / Folder | Description | Source |
|---|---|---|
| `Beijing_ILI_hosp/monthly_RSV_Beijing.xlsx` | Monthly RSV-positive ILI/hospitalisation data for Beijing | Published literature / hospital records |
| `Beijing_ILI_hosp/period_RSV_by_age_Beijing.xlsx` | RSV cases by age group and epidemic period for Beijing | Published literature |
| `Beijing_social_contact_matrix/China_subnational_Beijing_M_overall_contact_matrix_85.csv` | Social contact matrix for Beijing | Prem et al. subnational estimates |
| `Beijing_social_contact_matrix/China_subnational_Beijing_age_distribution_*.csv` | Age distribution for Beijing | Prem et al. |
| `2025_03_28_age_distr_Beijing.csv` | Beijing population by age group | National census |

### Thailand

| File / Folder | Description | Source |
|---|---|---|
| `Thailand_ILI_hosp/thailand_RSV_case_by_age.csv` | Annual RSV cases by age group for Thailand | Published literature (see references in folder) |
| `Thailand_ILI_hosp/thailand_RSV_children_case_by_age.csv` | RSV cases among children by age group | Published literature |
| `Thailand_social_contact_matrix/` | Social contact matrices for Thailand | Prem et al. |
| `2025_03_28_age_distr_Thailand.csv` | Thailand population by age group | National census |

### Seroprevalence (shared across regions)

| File / Folder | Description | Source |
|---|---|---|
| `Nakajo_review_paper/RSV_sero.xlsx` | RSV seroprevalence data compiled from a systematic review/meta-analysis | Nakajo & Nishiura (2021), *J Infect Dis* |

> **Note:** Seroprevalence data from the Thai cohort study (embedded directly in the MATLAB scripts as numeric arrays) are from: Sitthikarnkha et al. (2021), *Int J Infect Dis*. https://doi.org/10.1016/j.ijid.2022.08.014

---

## Notes

- All data files should remain in this folder relative to the model fitting scripts, which reference them via `../0. data/...` paths.
- Do not rename or move files, as the MATLAB scripts use hard-coded relative paths.
