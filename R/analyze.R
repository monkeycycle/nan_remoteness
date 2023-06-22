# =======================================================================
# This file handles the primary analysis using the tidied  data as input.
# Should never read from `dir_data_raw()`, only `dir_data_processed()`.
# =======================================================================

band_populations <- read_feather(dir_data_processed('band_populations.feather'))

indigenous_students_regular_school_programs <- read_feather(dir_data_processed('indigenous_students_regular_school_programs.feather'))

remote_index <- read_feather(dir_data_processed('remote_index.feather'))

amc_regional_funding_model <- read_feather(dir_data_processed('amc_regional_funding_model.feather'))

amc_regional_funding_model_nopercap <- read_feather(dir_data_processed('amc_regional_funding_model_nopercap.feather'))

FNSS_regional_funding_model_summary <- read_feather(dir_data_processed('FNSS_regional_funding_model_summary.feather'))
FNSS_regional_funding_model_summary_per_capita <- read_feather(dir_data_processed('FNSS_regional_funding_model_summary_per_capita.feather'))

mb_fn_schools <- read_feather(dir_data_processed('mb_fn_schools.feather'))

cost_ratio <- read_feather(dir_data_processed('cost_ratio.feather'))


# Pull the variables into a single DF for modelling purposes
df_for_cost_ratio_model <- cost_ratio %>%
  left_join(band_populations, by = c('first_nation' = 'first_nation_key')) %>%
  left_join(mb_fn_schools, by = c('first_nation' = 'first_nation_key')) %>%
  left_join(remote_index, by = c('first_nation' = 'first_nation_key')) %>%
  select(
    -first_nation.y,
    -first_nation.y.y,
    -source_url
  )

write_xlsx(df_for_cost_ratio_model, dir_data_out('df_for_cost_ratio_model.xlsx'))

