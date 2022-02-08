## ---------------------------
##
## Script name: Summary Statistics
##
## Purpose of script: Generating clean summmary table output
##
## Author: Austin Sanderson
##
## Date Created: 2022-01-22
##
## ---------------------------
##
## Notes:
##   
##
## ---------------------------


library(vtable)
library(readxl)


#Reading in the data
dta <- read_excel("/Users/roadie/Dropbox/Grad School/Independent Research/Homelessness/Projects/Thesis/Working Data/(2007 - 2020) Agg Master Minimal + Treatment Groups + Time-invariant Controls.xlsx")


var_list <- list('overall_homeless_per10k', 'pop_dens', 'all_ages_in_poverty_percent_cnty_avg', 'shelter_beds_per10k', 'total_jail_pop_per10k', 'total_jail_adm_per10k', 'total_jail_dis_per10k', 'total_prison_pop_per10k', 'total_prison_adm_per10k', 'avg_low_temp_cnty_avg', 'med_rent', 'median_household_income')


st(
  dta,
  vars = c('overall_homeless_per10k', 'pop_dens', 'all_ages_in_poverty_percent_cnty_avg', 'shelter_beds_per10k', 'total_jail_pop_per10k', 'total_jail_adm_per10k', 'total_jail_dis_per10k', 'total_prison_pop_per10k', 'total_prison_adm_per10k', 'avg_low_temp_cnty_avg', 'med_rent', 'median_household_income'), 
  # Test with other output methods
  out = "browser",
  file = NA,
  summ = NA,
  summ.names = NA,
  add.median = FALSE,
  group = "first_treated",
  group.long = FALSE,
  group.test = FALSE,
  group.weights = NA,
  col.breaks = NA,
  digits = NA,
  fixed.digits = FALSE,
  factor.percent = TRUE,
  factor.counts = TRUE,
  factor.numeric = FALSE,
  logical.numeric = FALSE,
  logical.labels = c("No", "Yes"),
  labels = NA,
  title = "Summary Statistics",
  note = NA,
  anchor = NA,
  col.width = NA,
  col.align = NA,
  align = NA,
  note.align = "l",
  fit.page = "\\textwidth",
  simple.kable = FALSE,
  opts = list()
)

# Trying another summary method
library(summarytools)

dfSummary(dta)
help(dfSummary)


# Trying skim() method
library(skimr)
library(dplyr)

# Simarly here, you can get some statistics for treated and comparison states
dta2 <- group_by(dta, state) %>%
  skim()
head(dta2)

# Trying a tableone() method
# demonstration shows separation of dummy vars and factor vars
library(tableone)
library(desctable)

# Trying the compareGroups() method
# there is more optionality here that needs to be reviewed, 
# but it may allow for publication ready tables
library(compareGroups)

# Also take a look at arsenal()
library(arsenal)

