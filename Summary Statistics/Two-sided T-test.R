library(stats)

dta <- read_excel("/Users/roadie/Dropbox/Grad School/Independent Research/Homelessness/Projects/Thesis/Working Data/REVISED (2007 - 2020) Agg Master Minimal + Treatment Groups + Time-invariant Controls.xlsx")

# Filtering for treated groups
df_treated <- dta[dta$first_treated != 0,]

# Filtering by year
df_treated_2020 <- df_treated[df_treated$year == '2020',]

# Filtering for untreated groups
df_untreated <- dta[dta$first_treated == 0,]

# Filtering untreated by year
df_untreated_2020 <- df_untreated[df_untreated$year == '2020',]

# Pairwise two-sample t-test grouped by year level
t.test(df_treated_2020$overall_homeless_per10k, df_untreated_2020$overall_homeless_per10k,  alternative = "two.sided")

# Pairwise two-sample t-test: homelessness at aggregate
t.test(df_treated$overall_homeless_per10k, df_untreated$overall_homeless_per10k,  alternative = "two.sided")

# Pairwise two-samples t-test: climate at aggregate 
t.test(df_treated$avg_low_temp_cnty_avg, df_untreated$avg_low_temp_cnty_avg,  alternative = "two.sided")

# Pairwise two-samples t-test: poverty at aggregate
t.test(df_treated$all_ages_in_poverty_percent_cnty_avg, df_untreated$all_ages_in_poverty_percent_cnty_avg,  alternative = "two.sided")

# Pairwise two-samples t-test: rent at aggregate
t.test(df_treated$med_rent, df_untreated$med_rent,  alternative = "two.sided")

# Pairwise two-samples t-test: shelter beds at aggregate
t.test(df_treated$shelter_beds_per10k, df_untreated$shelter_beds_per10k,  alternative = "two.sided")

# Pairwise two-samples t-test: jail pop at aggregate
t.test(df_treated$total_jail_pop_per10k, df_untreated$total_jail_pop_per10k,  alternative = "two.sided")

# Pairwise two-samples t-test: total county pop at aggregate
t.test(df_treated$total_pop, df_untreated$total_pop,  alternative = "two.sided")
