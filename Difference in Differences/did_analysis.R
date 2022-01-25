library(did)
library(tidyverse)
library(readxl)

# Reading in the data
# Note: Testing two time periods: (2007 - 2020) and (2009 - 2018) - file names reflected as such 
# 
# Laptop file path
 dta <- read_excel("/Users/roadie/Dropbox/Grad School/Independent Research/Homelessness/Projects/Thesis/Working Data/(2007 - 2020) Agg Master Minimal + Treatment Groups + Time-invariant Controls.xlsx")
#
# Desktop file path
# dta <- read_excel("/Users/roygbiv/Dropbox/Grad School/Independent Research/Homelessness/Projects/Thesis/Working Data/(2007 - 2020) Agg Master Minimal + Treatment Groups + Time-invariant Controls.xlsx")

# Quick summary count of first_treated group
table(dta$first_treated)

# converting the id variable to numeric
dta$CoC_number <- as.numeric(as.character(dta$CoC_number))

# Checking the parallel trends assumption
if (FALSE) {
data(dta)
pre.test <- conditional_did_pretest(yname="overall_homeless_per10k",
                                    tname="year",
                                    idname="CoC_number",
                                    gname="first_treated",
                                    xformla=~pop_dens + avg_low_temp_cnty_avg,
                                    # Commenting out additional controls for testing
                                    # total_jail_adm_per10k + total_jail_dis_per10k + total_prison_pop_per10k + total_prison_adm_per10k + med_rent+median_household_income,
                                    data=dta)
summary(pre.test)
}

# estimate group-time average treatment effects using att_gt method
out1 <- att_gt(yname = "overall_homeless_per10k",
                        tname = "year",
                        gname = "first_treated",
                        idname = "CoC_number",
                        xformla=~pop_dens + avg_low_temp_cnty_avg,
                        # Commenting out additional controls for testing
                        # total_jail_pop_per10k + all_ages_in_poverty_percent_cnty_avg + shelter_beds_per10k 
                        # total_jail_adm_per10k + total_jail_dis_per10k + total_prison_pop_per10k + total_prison_adm_per10k + med_rent + median_household_income,
                        data = dta,
                        control_group = "nevertreated",
                        allow_unbalanced_panel = FALSE, 
)

# summarize the results
summary(out1)
ggdid(out1) #graphing

# Storing DID parameters
# DIDparams(
#   yname,
#   tname,
#   idname = NULL,
#   gname,
#   xformla = NULL,
#   data,
#   control_group,
#   anticipation = 0,
#   weightsname = NULL,
#   alp = 0.05,
#   bstrap = TRUE,
#   biters = 1000,
#   clustervars = NULL,
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



# # More details on pretest parameters below
# conditional_did_pretest(
#   yname,
#   tname,
#   idname = NULL,
#   gname,
#   xformla = NULL,
#   data,
#   panel = TRUE,
#   allow_unbalanced_panel = FALSE,
#   control_group = c("nevertreated", "notyettreated"),
#   weightsname = NULL,
#   alp = 0.05,
#   bstrap = TRUE,
#   cband = TRUE,
#   biters = 1000,
#   clustervars = NULL,
#   est_method = "ipw",
#   print_details = FALSE,
#   pl = FALSE,
#   cores = 1
# )

# # aggregate the group-time average treatment effects
# aggout <- aggte(
#   out1,
#   type = "dynamic",
#   balance_e = NULL, 
#   min_e = -Inf,
#   max_e = Inf,
#   na.rm = FALSE,
#   bstrap = NULL, 
#   biters = NULL, 
#   cband = NULL, 
#   alp = NULL,
#   clustervars == "state",
# )
