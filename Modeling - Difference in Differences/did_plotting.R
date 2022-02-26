library(did)
library(tidyverse)
library(readxl)

# Reading in the data
# Note: Testing time periods: (2007 - 2020) and (2009 - 2018) - file names reflected as such 
# 
# Laptop file path
# dta <- read_excel("/Users/roadie/Dropbox/Grad School/Independent Research/Homelessness/Projects/Thesis/Working Data/(2007 - 2020) Agg Minimal - DID Model Only.xlsx")
#
# Desktop file path
dta <- read_excel("/Users/roygbiv/Dropbox/Grad School/Independent Research/Homelessness/Projects/Thesis/Working Data/(2007 - 2020) Agg Minimal - DID Model Only.xlsx")

# Quick summary count of first_treated group
table(dta$first_treated)

# Estimate group-time average treatment effects
out1 <- att_gt(yname = "overall_homeless_per10k",
               tname = "year",
               gname = "first_treated",
               idname = "CoC_number",
               # 123456: temp|pov|pop|jail|rent|beds
               # never treated
               est_method = "reg",
               # notyettreated
               #xformla = ~1,
               #xformla  = ~ total_jail_pop_per10k,
               xformla=~ avg_low_temp_cnty_avg + all_ages_in_poverty_percent_cnty_avg + total_pop + total_jail_pop_per10k + med_rent + shelter_beds_per10k,
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

# Store the ATT results into a DataFrame

attoutput <- data.frame(cbind(out1$group,out1$t ,out1$att ,out1$se))
colname  <-  c('group','year','att', 'se')
colnames(attoutput) <- colname
attoutput$year <- as.integer(attoutput$year)
attoutput <- attoutput %>% mutate(prepost=ifelse(group>year, "pre", "post")) 

# Plot ATTgt using ggplot
ggplot(attoutput, aes(x=year, y=att, linetype=prepost, shape=prepost)) +
  geom_errorbar(aes(ymin=att-1.96*se, ymax=att+1.96*se), width=.2) +
  geom_point()+ 
  facet_wrap(~ group, ncol=1, scales = "free_y")  +
  geom_hline(aes(yintercept = 0), linetype="dotdash") +
  xlab("Year") +
  ylab("Average Treatment Effect on the Treated: By Treatment Period") +
  theme(axis.line = element_line(color = "black")  )   +
  labs(linetype = "Pre- or \nPost- \nTreatment", shape = "Pre- or \nPost- \nTreatment") +
  scale_x_continuous(breaks = 2008:2020) 

# aggregate the group-time average treatment effects

aggout <- aggte(
  out1,
  type = "dynamic",
)

# summarize the results

summary(aggout)
str(aggout)

# Store the agg results into a DataFrame

aggoutput <- data.frame(cbind(aggout$egt, aggout$att.egt, aggout$se.egt))
colname2  <-  c('event','aggatt', 'seegt')
colnames(aggoutput) <- colname2
aggoutput$event <- as.integer(aggoutput$event)
aggoutput <- aggoutput %>% mutate(prepost=ifelse(event<0, "pre", "post"))

# Plot agg using ggplot

ggplot(aggoutput, aes(x=event, y=aggatt, linetype=prepost, shape=prepost)) +
  geom_errorbar(aes(ymin=aggatt-1.96*seegt, ymax=aggatt+1.96*seegt), width=.2) +
  geom_point()+ 
  geom_hline(aes(yintercept = 0), linetype="dotdash") +
  xlab("Year") +
  ylab("Average Treatment Effect on the Treated: By Length of Exposure") +
  theme(axis.line = element_line(color = "black")  )   +
  labs(linetype = "Pre- or \nPost- \nTreatment", shape = "Pre- or \nPost- \nTreatment") +
  scale_x_continuous(breaks = -12:9)

