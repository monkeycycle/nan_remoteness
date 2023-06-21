# =================================================================
# This file configures the project by specifying filenames, loading
# packages and setting up some project-specific variables.
# =================================================================

initialize_startr(
  title = 'nan_remoteness',
  author = 'Michael Pereira <mpereira@waapihk.com>',
  timezone = 'America/Winnipeg',
  should_render_notebook = TRUE,
  should_process_data = TRUE,
  should_timestamp_output_files = FALSE,
  packages = c(
    'tidyverse', 'glue', 'lubridate', 'readxl',
    'xlsx',
    'feather', 'scales', 'knitr', 'writexl',
    'janitor', 'zoo', 'DT',
    'ggplot2', 'stargazer', 'modelsummary',
    'gtsummary', 'huxtable', 'tidymodels'
    # 'sf',
    # 'rvest',
    # 'gganimate', 'tgamtheme',
    # 'cansim', 'cancensus'
  )
)


# Source data files and URLs
# https://fnp-ppn.aadnc-aandc.gc.ca/fnp/Main/Search/FNPopulation.aspx?BAND_NUMBER=###&lang=eng
band_populations.raw.file <- dir_data_raw('band_populations.xlsx')

# https://www.statcan.gc.ca/en/census/census-engagement/community-supporter/indigenous-peoples
# https://www150.statcan.gc.ca/t1/tbl1/en/cv.action?pid=3710021301
indigenous_students_regular_school_programs.raw.file <- dir_data_raw('37100213.csv')

# https://www150.statcan.gc.ca/n1/pub/17-26-0001/172600012020001-eng.htm
remote_index.raw.file <- dir_data_raw('2021IR_DATABASE.csv')


amc_regional_funding_model.raw.file <- dir_data_raw('1  Mfnss2022 - Regional Funding Model - 2021-22 School Year To AMC Dec 2022)__nopassword.xlsx')
amc_regional_funding_model_nopercap.raw.file <- dir_data_raw('1  Mfnss2022 - Regional Funding Model - 2021-22 School Year To AMC Dec 2022(with per cap costs removed)__nopassword.xlsx')

# amc_regional_funding_model.raw.file <- dir_data_raw('1  Mfnss2022 - Regional Funding Model - 2021-22 School Year To AMC Dec 2022.xlsb')
# amc_regional_funding_model.password <- 'Mfnss2022'

FNSS_regional_funding_model_summary.raw.file <- dir_data_raw('FNSS-regional-funding-model-summary.xlsx')


mb_fn_schools.raw.file <- dir_data_raw('mb-fn-schools.xlsx')


