# =======================================================================
# Read raw data, clean it and save it out to `dir_data_processed()` here
# before moving to analysis. If run from `run.R`, all variables generated
# in this file will be wiped after completion to keep the environment
# clean. If your process step is complex, you can break it into several
# files like so: `source(dir_src('process_files', 'process_step_1.R'))`
# =======================================================================

band_populations.raw <- read_xlsx(band_populations.raw.file) %>%
  clean_names() %>%
  mutate(
    percentage_u19 = round(u19_population / total_population * 100, digits=2)
  ) %>%
  select(
    first_nation,
    band_number,
    u19_population,
    total_population,
    percentage_u19,
    source_url
  ) %>%
  mutate(
    first_nation_key = 'FOO',
    first_nation_key = case_when(
      first_nation == 'Fox Lake' ~ 'Fox Lake',
      first_nation == 'Lake Manitoba' ~ 'Lake Manitoba',
      first_nation == 'Lake St. Martin' ~ 'Lake St. Martin',
      first_nation == 'Pinaymootang First Nation' ~ 'Pinaymootang',
      first_nation == 'Roseau River Anishinabe First Nation Government' ~ 'Roseau River',
      first_nation == 'York Factory First Nation' ~ 'York Factory',
      first_nation == 'Brokenhead Ojibway Nation' ~ 'Brokenhead',
      first_nation == 'Bloodvein' ~ 'Bloodvein',
      first_nation == 'Dakota Plains' ~ 'Dakota Plains',
      first_nation == 'Dakota Tipi' ~ 'Dakota Tipi',
      first_nation == 'Keeseekoowenin' ~ 'Keeseekoowenin',
      .default = "other"
    )
  )


indigenous_students_regular_school_programs.raw <- read_csv(indigenous_students_regular_school_programs.raw.file) %>%
  clean_names() %>%
  filter(grade == 'Total, grade') %>%
  filter(sex == 'Total, sex') %>%
  select(
    ref_date,
    geo,
    indigenous_identity,
    grade,
    sex,
    value
  )


remote_index.raw <- read_csv(remote_index.raw.file) %>%
  clean_names() %>%
  select(
    -x1, -dguid
  ) %>%
  mutate(
    first_nation_key = case_when(
      cs_dname == 'Bloodvein 12' ~ 'Bloodvein',
      cs_dname == 'Dakota Tipi 1' ~ 'Dakota Tipi',
      cs_dname == 'Dakota Plains 6A' ~ 'Dakota Plains',
      cs_dname == 'Brokenhead 4' ~ 'Brokenhead',
      cs_dname == 'Roseau River 2' ~ 'Roseau River',
      cs_dname == 'Fox Lake 2' ~ 'Fox Lake',
      cs_dname == 'Keeseekoowenin 61' ~ 'Keeseekoowenin',
      cs_dname == 'Brokenhead 4' ~ 'Brokenhead',
      cs_dname == 'Grahamdale' ~ 'Lake St. Martin',

      # cs_dname == 'Brokenhead Ojibway First Nation' ~ 'Brokenhead',
      # cs_dname == 'Dakota Plains Wahpeton Nation' ~ 'Dakota Plains',
      # cs_dname == 'Fox Lake Cree Nation' ~ 'Fox Lake',
      # cs_dname == 'Lake Manitoba First Nation' ~ 'Lake Manitoba',
      # cs_dname == 'Pinaymootang First Nation' ~ 'Pinaymootang',
      # cs_dname == 'Roseau River Anishinabe First Nation' ~ 'Roseau River',
      # cs_dname == 'York Factory Cree Nation' ~ 'York Factory',
      # cs_dname == 'Dakota Tipi' ~ 'Dakota Tipi',
      .default = NA
    )
  )


mb_fn_schools.raw <- read_xlsx(mb_fn_schools.raw.file) %>%
  clean_names() %>%
  mutate(
    first_nation_key = case_when(
      first_nation == 'Bloodvein First Nation' ~ 'Bloodvein',
      first_nation == 'Brokenhead Ojibway First Nation' ~ 'Brokenhead',
      first_nation == 'Dakota Plains Wahpeton Nation' ~ 'Dakota Plains',
      first_nation == 'Fox Lake Cree Nation' ~ 'Fox Lake',
      first_nation == 'Lake Manitoba First Nation' ~ 'Lake Manitoba',
      first_nation == 'Lake St. Martin First Nation' ~ 'Lake St. Martin',
      first_nation == 'Pinaymootang First Nation' ~ 'Pinaymootang',
      first_nation == 'Keeseekoowenin Ojibway First Nation' ~ 'Keeseekoowenin',
      first_nation == 'Roseau River Anishinabe First Nation' ~ 'Roseau River',
      first_nation == 'York Factory Cree Nation' ~ 'York Factory',
      first_nation == 'Keeseekoowenin' ~ 'Keeseekoowenin',
      first_nation == 'Dakota Tipi' ~ 'Dakota Tipi',
      .default = NA
    )
  )

amc_regional_funding_model.raw <- read_xlsx(amc_regional_funding_model.raw.file,
                sheet = '-B11-',
                skip=23) %>%
      clean_names() %>%
  filter(band_number != 'Total')



amc_regional_funding_model_nopercap.raw <- read_xlsx(amc_regional_funding_model_nopercap.raw.file,
                                                     sheet = 'FNSS SUMMARY',
                                                     skip=58
) %>%
  clean_names() %>%
  select(
    -x1, -x2, -x3, -x4
  ) %>%
  rename(
    first_nation = x5
  ) %>%
  filter(first_nation != 'Total')


FNSS_regional_funding_model_summary.raw <- read_xlsx(FNSS_regional_funding_model_summary.raw.file,
                                                     skip=2) %>%
  clean_names() %>%
  select(
    -x31, -x32, -x37, -x38, -x40, -x41
  )


FNSS_regional_funding_model_summary_per_capita <- FNSS_regional_funding_model_summary.raw %>%

  mutate(
    instructional_support_percap  = instructional_support / enrollment,
    additional_support_for_small_schools_percap  = additional_support_for_small_schools / enrollment,
    sparsity_support_percap  = sparsity_support / enrollment,
    curricular_materials_percap  = curricular_materials / enrollment,
    information_technology_percap  = information_technology / enrollment,
    library_services_percap  = library_services / enrollment,
    student_services_grant_percap  = student_services_grant / enrollment,
    counselling_and_guidance_percap  = counselling_and_guidance / enrollment,
    professional_development_percap  = professional_development / enrollment,
    physical_education_percap  = physical_education / enrollment,
    occupancy_percap  = occupancy / enrollment,
    special_needs_percap  = special_needs / enrollment,
    senior_years_technology_percap  = senior_years_technology / enrollment,
    english_an_additional_language_percap  = english_an_additional_language / enrollment,
    aboriginal_academic_achievement_percap  = aboriginal_academic_achievement / enrollment,
    enhanced_aboriginal_and_international_languages_percap  = enhanced_aboriginal_and_international_languages / enrollment,
    french_language_education_percap  = french_language_education / enrollment,
    small_schools_percap  = small_schools / enrollment,
    enrolment_change_support_percap  = enrolment_change_support / enrollment,
    northern_allowance_percap  = northern_allowance / enrollment,
    literacy_and_numeracy_percap  = literacy_and_numeracy / enrollment,
    education_for_sustainable_development_percap  = education_for_sustainable_development / enrollment,
    first_nation_student_stpports_percap  = first_nation_student_stpports / enrollment,
    minor_capital_school_infrastructure_percap  = minor_capital_school_infrastructure / enrollment,
    employer_contribution_to_pensions_current_service_teachers_percap  = employer_contribution_to_pensions_current_service_teachers / enrollment,
    second_level_services_percap  = second_level_services / enrollment,
    school_administration_percap  = school_administration / enrollment,
    total_30_percap  = total_30 / enrollment,
    tuition_funding_percap  = tuition_funding / enrollment,
    supports_for_students_attending_provincial_private_schools_percap  = supports_for_students_attending_provincial_private_schools / enrollment,
    x5_percent_tuition_administration_support_percap  = x5_percent_tuition_administration_support / enrollment,
    total_36_percap  = total_36 / enrollment,
    x3_transportation_percap  = x3_transportation / enrollment,
    x4_enhance_accommodation_private_home_placement_funding_percap = x4_enhance_accommodation_private_home_placement_funding / enrollment

  ) %>%
  select(
    first_nation,
    enrollment,
    instructional_support_percap,
    additional_support_for_small_schools_percap,
    sparsity_support_percap,
    curricular_materials_percap,
    information_technology_percap,
    library_services_percap,
    student_services_grant_percap,
    counselling_and_guidance_percap,
    professional_development_percap,
    physical_education_percap,
    occupancy_percap,
    special_needs_percap,
    senior_years_technology_percap,
    english_an_additional_language_percap,
    aboriginal_academic_achievement_percap,
    enhanced_aboriginal_and_international_languages_percap,
    french_language_education_percap,
    small_schools_percap,
    enrolment_change_support_percap,
    northern_allowance_percap,
    literacy_and_numeracy_percap,
    education_for_sustainable_development_percap,
    first_nation_student_stpports_percap,
    minor_capital_school_infrastructure_percap,
    employer_contribution_to_pensions_current_service_teachers_percap,
    second_level_services_percap,
    school_administration_percap,
    total_30_percap,
    tuition_funding_percap,
    supports_for_students_attending_provincial_private_schools_percap,
    x5_percent_tuition_administration_support_percap,
    total_36_percap,
    x3_transportation_percap,
    x4_enhance_accommodation_private_home_placement_funding_percap
  )

cost_ratio.raw <- read_xlsx(cost_ratio.xlsx.raw.file) %>%
  clean_names()


write_feather(band_populations.raw, dir_data_processed('band_populations.feather'))
write_feather(indigenous_students_regular_school_programs.raw, dir_data_processed('indigenous_students_regular_school_programs.feather'))
write_feather(remote_index.raw, dir_data_processed('remote_index.feather'))
write_feather(mb_fn_schools.raw, dir_data_processed('mb_fn_schools.feather'))

write_feather(FNSS_regional_funding_model_summary.raw, dir_data_processed('FNSS_regional_funding_model_summary.feather'))
write_feather(FNSS_regional_funding_model_summary_per_capita, dir_data_processed('FNSS_regional_funding_model_summary_per_capita.feather'))

write_feather(cost_ratio.raw, dir_data_processed('cost_ratio.feather'))
write_feather(amc_regional_funding_model.raw, dir_data_processed('amc_regional_funding_model.feather'))
write_feather(amc_regional_funding_model_nopercap.raw, dir_data_processed('amc_regional_funding_model_nopercap.feather'))
