library(did)
library(tidyverse)
library(readxl)


# Reading in the data
# Note: Testing time periods: (2007 - 2020) and (2009 - 2018) - file names reflected as such 
# 
# Laptop file path
 dta <- read_excel("/Users/roadie/Dropbox/Grad School/Independent Research/Homelessness/Projects/Thesis/Working Data/(2007 - 2020) Agg Minimal - DID Model Only.xlsx")
#
# Desktop file path
# dta <- read_excel("/Users/roygbiv/Dropbox/Grad School/Independent Research/Homelessness/Projects/Thesis/Working Data/(2007 - 2020) Agg Minimal - DID Model Only.xlsx")

# Quick summary count of first_treated group
table(dta$first_treated)

# converted the id variable to numeric
# dta$CoC_number <- as.numeric(as.character(dta$CoC_number))

# Estimate group-time average treatment effects
out1 <- att_gt(yname = "overall_homeless_per10k",
                        tname = "year",
                        gname = "first_treated",
                        idname = "CoC_number",
                        # 123456: temp|pov|pop|jail|rent|beds
                        # Group 2020 is signif with 1235 and 12345 but not 123
                        est_method = "reg",
                        #xformla = ~1,
                        xformla=~ avg_low_temp_cnty_avg +  total_pop + all_ages_in_poverty_percent_cnty_avg + total_jail_pop_per10k + med_rent +  shelter_beds_per10k, #med_rent, # +  shelter_beds_per10k,+ total_jail_pop_per10k 
                        # Commenting out additional controls for testing
                        # all_ages_in_poverty_percent_cnty_avg + avg_low_temp_cnty_avg + med_rent
                        # all_ages_in_poverty_percent_cnty_avg
                        # shelter_beds_per10k
                        # total_jail_adm_per10k + total_jail_dis_per10k + total_prison_pop_per10k + total_prison_adm_per10k
                        data = dta,
                        control_group = "nevertreated",
)

# summarize the results
summary(out1)
ggdid(out1, title = "Group-time Average Treatment Effects") 


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
)

summary(aggout)
ggdid(aggout, theming = FALSE)
