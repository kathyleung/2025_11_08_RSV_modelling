
# 2025-04-28
# Thailand social contact matrix

library(contactdata)

rm(list = ls());

list_countries(geographic_setting = c("all", "rural", "urban"),
               data_source = c("2020", "2017"))

thaiAgeDef = age_df_countries("Hong Kong");

thaiContactDef = contact_df_countries("Hong Kong");

thaiContactMatr = contact_matrix("Hong Kong",location = "all");
write.csv(thaiContactMatr,'hongkong_contact_matrix_prem_all.csv',row.names = FALSE);

thaiAgeDefTable = data.frame(age = thaiAgeDef$age,
                             population = thaiAgeDef$population);
write.csv(thaiAgeDefTable,'hongkong_age_distribution_prem_all.csv',row.names = FALSE);