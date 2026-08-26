# Data Folder

This folder stores the input datasets and supporting reference material used by the RSV model-fitting and results scripts.

## Main contents

- `Hong_Kong_CHP`: Hong Kong RSV surveillance, ILI, and census-linked inputs.
- `Beijing_ILI_hosp`: Beijing RSV and hospitalization inputs.
- `Thailand_ILI_hosp`: Thailand RSV and hospitalization inputs.
- `HK_social_contact_survey`: Hong Kong social-contact data and supporting analysis scripts.
- `Beijing_social_contact_matrix`: Beijing contact matrix and age distribution files.
- `Thailand_social_contact_matrix`: Thailand contact matrix and age distribution files.
- `Hong_Kong_serology_CC`: Hong Kong ELISA serology data.
- `Nakajo_review_paper`: external serology compilation used for meta-analysis comparisons.
- `2024_12_27_age_distr_HK.csv`, `2025_03_28_age_distr_Beijing.csv`, `2025_03_28_age_distr_Thailand.csv`: compact age-distribution inputs used directly by model scripts.

## Notes

- The modelling folders read these files by relative paths such as `../0. data/...`.
- Filenames were preserved to avoid breaking manuscript scripts and saved analysis pipelines.
- Some subfolders contain reference PDFs or auxiliary preprocessing scripts that document how derived inputs were assembled.
