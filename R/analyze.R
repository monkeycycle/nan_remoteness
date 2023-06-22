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
  left_join(FNSS_regional_funding_model_summary %>% select(first_nation, enrollment, first_nation_key), by = c('first_nation' = 'first_nation_key')) %>%
    mutate(
      population_ratio_staff = staff_population / enrollment,
      population_ratio_teachers = classroom_teachers / enrollment
  ) %>%
  select(

    first_nation,
    band_number,
    u19_population,
    total_population,
    percentage_u19,
    school,
    grades,
    enrollment,
    classroom_teachers,
    staff_population,
    population_ratio_staff,
    population_ratio_teachers,
    data_year,

    non_fte_no_per_capita,
    fte_no_per_capita,
    non_fte_with_per_capita,
    fte_with_per_capita,
    index_of_remoteness,

    cs_dname,
    cs_dtype,
    cs_dpop2021
  )

# Split Apply Combine to deal with multiple Brokenhead rows and missing data in some.
df_for_cost_ratio_model_no_brokenhead <- df_for_cost_ratio_model %>% filter(first_nation != 'Brokenhead')
df_for_cost_ratio_model_brokenhead <- df_for_cost_ratio_model %>% filter(first_nation == 'Brokenhead') %>%
  filter(complete.cases(.)) %>%
  head(1)

df_for_cost_ratio_model <- rbind(df_for_cost_ratio_model_no_brokenhead,
                                 df_for_cost_ratio_model_brokenhead)


write_xlsx(df_for_cost_ratio_model, dir_data_out('df_for_cost_ratio_model.xlsx'))

