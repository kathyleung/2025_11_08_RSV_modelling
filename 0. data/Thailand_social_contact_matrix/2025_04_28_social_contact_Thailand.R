
# 2025-04-28
# Thailand social contact matrix

library(contactdata)

rm(list = ls());

thaiAgeDef = age_df_countries("Thailand");

thaiContactDef = contact_df_countries("Thailand");

thaiContactMatr = contact_matrix("Thailand",location = "all");
write.csv(thaiContactMatr,'thailand_contact_matrix_prem_all.csv',row.names = FALSE);

thaiAgeDefTable = data.frame(age = thaiAgeDef$age,
                             population = thaiAgeDef$population);
write.csv(thaiAgeDefTable,'thailand_age_distribution_prem_all.csv',row.names = FALSE);