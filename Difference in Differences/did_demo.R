library(did)
library(tidyverse)
library(readxl)


#Reading in the data
dta <- read_excel("/Users/roygbiv/Dropbox/Grad School/Independent Research/Homelessness/Projects/Thesis/Working Data/(2007 - 2020) Agg Master Minimal + Treatment Groups + Time-invariant Controls.xlsx")

# distinguish groups by year of treatment
table(dta$first_treated)

# converting the id variable to numeric
dta$CoC_number <- as.numeric(as.character(dta$CoC_number))

# estimate group-time average treatment effects using att_gt method
out1 <- att_gt(yname = "overall_homeless_per10k",
                        tname = "year",
                        gname = "first_treated",
                        idname = "CoC_number",
                        #Commenting out the control variables
                        #xformla = ~X,
                        data = dta,
                        control_group = "notyettreated"
)

# summarize the results
summary(out1)
ggdid(out1) #graphing


# aggregate the group-time average treatment effects
aggout <- aggte(
  out1,
  type = "dynamic",
  balance_e = NULL, 
  min_e = -Inf,
  max_e = Inf,
  na.rm = FALSE,
  bstrap = NULL, 
  biters = NULL, 
  cband = NULL, 
  alp = NULL,
  clustervars == "state",
)
