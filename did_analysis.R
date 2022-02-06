library(did)
library(tidyverse)
library(readxl)

# Reading in the data
# Note: Testing time periods: (2007 - 2020) and (2009 - 2018) - file names reflected as such 
# 
# Laptop file path
# dta <- read_excel("/Users/roadie/Dropbox/Grad School/Independent Research/Homelessness/Projects/Thesis/Working Data/DUP (2007 - 2020) Agg Master Minimal + Treatment Groups + Time-invariant Controls.xlsx")
#
# Desktop file path
 dta <- read_excel("/Users/roygbiv/Dropbox/Grad School/Independent Research/Homelessness/Projects/Thesis/Working Data/(2007 - 2020) Agg Master Minimal + Treatment Groups + Time-invariant Controls.xlsx")

# Quick summary count of first_treated group
table(dta$first_treated)

# converted the id variable to numeric
# dta$CoC_number <- as.numeric(as.character(dta$CoC_number))

# DIDparams(yname = "overall_homeless_per10k",
#   tname = "year",
#   gname = "first_treated",
#   idname = "CoC_number",
#   xformla=~pop_dens + avg_low_temp_cnty_avg + total_jail_pop_per10k,
#   # Commenting out additional controls for testing
#   # all_ages_in_poverty_percent_cnty_avg + avg_low_temp_cnty_avg
#   # total_jail_pop_per10k + all_ages_in_poverty_percent_cnty_avg + shelter_beds_per10k 
#   # total_jail_adm_per10k + total_jail_dis_per10k + total_prison_pop_per10k + total_prison_adm_per10k + med_rent + median_household_income,
#   data = dta,
#   control_group = "nevertreated",
#   clustervars = "state",
#   #allow_unbalanced_panel = FALSE
#   )

# Checking the parallel trends assumption
if (FALSE) {
  data(dta)
  pre.test <- conditional_did_pretest(yname="overall_homeless_per10k",
                                      tname="year",
                                      idname="CoC_number",
                                      gname="first_treated",
                                      xformla=~ avg_low_temp_cnty_avg + total_jail_pop_per10k + med_rent + shelter_beds_per10k,
                                      data=dta)
  summary(pre.test)
}

# Estimate group-time average treatment effects
out1 <- att_gt(yname = "overall_homeless_per10k",
                        tname = "year",
                        gname = "first_treated",
                        idname = "CoC_number",
                        # Group 2019 - Chicago - becomes insignificant when controlling for shelter_beds
                        xformla=~ avg_low_temp_cnty_avg + total_jail_pop_per10k + med_rent + shelter_beds_per10k,
                        # Commenting out additional controls for testing
                        # all_ages_in_poverty_percent_cnty_avg + avg_low_temp_cnty_avg
                        # total_jail_pop_per10k + all_ages_in_poverty_percent_cnty_avg + shelter_beds_per10k 
                        # total_jail_adm_per10k + total_jail_dis_per10k + med_rent,
                        data = dta,
                        control_group = "nevertreated",
                        #allow_unbalanced_panel = FALSE", 
)

# summarize the results
summary(out1)
ggdid(out1) #graphing

# aggregate the group-time average treatment effects
aggout <- aggte(
  out1,
  type = "dynamic",
  # balance_e = NULL,
  # min_e = -Inf,
  # max_e = Inf,
  # na.rm = TRUE,
  # bstrap = NULL,
  # biters = NULL,
  # cband = NULL,
  # alp = NULL,
  # the below line is returning errors 'undefined columns selected'
  # clustervars = "region_name"
)

summary(aggout)
ggdid(aggout)

# Unused DID parameters
# DIDparams(
#   anticipation = 0,
#   weightsname = NULL,
#   alp = 0.05,
#   bstrap = TRUE,
#   biters = 1000,
#   cband = TRUE,
#   print_details = TRUE,
#   pl = FALSE,
#   cores = 1,
#   est_method = "dr",
#   base_period = "varying",
#   panel = TRUE,
#   true_repeated_cross_sections,
#   n = NULL,
#   nG = NULL,
#   nT = NULL,
#   tlist = NULL,
#   glist = NULL,
#   call = NULL
# )


