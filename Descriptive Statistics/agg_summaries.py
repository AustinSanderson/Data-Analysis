#!/usr/bin/env python
# coding: utf-8

# In[83]:


import pandas as pd


# In[84]:


df = pd.read_excel("/Users/roadie/Dropbox/Grad School/Independent Research/Homelessness/Projects/Thesis/Working Data/(2007 - 2020) Agg Master Minimal + Treatment Groups + Time-invariant Controls.xlsx")


# In[85]:


df_CoC = df.groupby("CoC_id").agg(
    {
        "overall_homeless_per10k": ["min", "max", "median",  "mean"],
        "avg_low_temp_cnty_avg": ["min", "max", "median",  "mean"],
        "shelter_beds_per10k": ["min", "max", "median",  "mean"],
        "all_ages_in_poverty_percent_cnty_avg": ["min", "max", "median",  "mean"],
        "median_household_income": ["min", "max", "median",  "mean"],
        "total_jail_pop_per10k": ["min", "max", "median",  "mean"],
        "total_prison_pop_per10k": ["min", "max", "median",  "mean"],
        "med_rent": ["min", "max", "median",  "mean"],   
    }  
)
df_CoC.to_excel('summary_agg_CoC.xlsx')


# In[86]:


df_national = df.agg(
    {
        "overall_homeless_per10k": ["min", "max", "median",  "mean"],
        "avg_low_temp_cnty_avg": ["min", "max", "median",  "mean"],
        "shelter_beds_per10k": ["min", "max", "median",  "mean"],
        "all_ages_in_poverty_percent_cnty_avg": ["min", "max", "median",  "mean"],
        "median_household_income": ["min", "max", "median",  "mean"],
        "total_jail_pop_per10k": ["min", "max", "median",  "mean"],
        "total_prison_pop_per10k": ["min", "max", "median",  "mean"],
        "med_rent": ["min", "max", "median",  "mean"],   
    }  
)
df_national.to_excel('summary_agg_natl.xlsx')


# In[87]:


df_national_by_year = df.groupby('year').agg(
    {
        "overall_homeless_per10k": ["min", "max", "median",  "mean"],
        "avg_low_temp_cnty_avg": ["min", "max", "median",  "mean"],
        "shelter_beds_per10k": ["min", "max", "median",  "mean"],
        "all_ages_in_poverty_percent_cnty_avg": ["min", "max", "median",  "mean"],
        "median_household_income": ["min", "max", "median",  "mean"],
        "total_jail_pop_per10k": ["min", "max", "median",  "mean"],
        "total_prison_pop_per10k": ["min", "max", "median",  "mean"],
        "med_rent": ["min", "max", "median",  "mean"],   
    }  
)
df_national_by_year.to_excel('summary_natl_year.xlsx')


# In[88]:


df_state = df.groupby("state").agg(
    {
        "overall_homeless_per10k": ["min", "max", "median",  "mean"],
        "avg_low_temp_cnty_avg": ["min", "max", "median",  "mean"],
        "shelter_beds_per10k": ["min", "max", "median",  "mean"],
        "all_ages_in_poverty_percent_cnty_avg": ["min", "max", "median",  "mean"],
        "median_household_income": ["min", "max", "median",  "mean"],
        "total_jail_pop_per10k": ["min", "max", "median",  "mean"],
        "total_prison_pop_per10k": ["min", "max", "median",  "mean"],
        "med_rent": ["min", "max", "median",  "mean"],   
    }  
)
df_state.to_excel('summary_agg_state.xlsx')


# In[89]:


df_state_year = df.groupby(['state', 'year']).agg(
    {
        "overall_homeless_per10k": ["min", "max", "median",  "mean"],
        "avg_low_temp_cnty_avg": ["min", "max", "median",  "mean"],
        "shelter_beds_per10k": ["min", "max", "median",  "mean"],
        "all_ages_in_poverty_percent_cnty_avg": ["min", "max", "median",  "mean"],
        "median_household_income": ["min", "max", "median",  "mean"],
        "total_jail_pop_per10k": ["min", "max", "median",  "mean"],
        "total_prison_pop_per10k": ["min", "max", "median",  "mean"],
        "med_rent": ["min", "max", "median",  "mean"],   
    }  
)
df_state_year.to_excel('summary_agg_state_byyear.xlsx')


# In[90]:


df5 = df.groupby('state').last()
pd.crosstab(index=df5['cannabis_legal_rec'], columns='count')


# In[91]:


df_dropped = df[df.first_treated != 0]


# In[92]:


df_treated_states = df_dropped.groupby(['state', 'year']).agg(
    {
        "overall_homeless_per10k": ["min", "max", "median",  "mean"],
        "avg_low_temp_cnty_avg": ["min", "max", "median",  "mean"],
        "shelter_beds_per10k": ["min", "max", "median",  "mean"],
        "all_ages_in_poverty_percent_cnty_avg": ["min", "max", "median",  "mean"],
        "median_household_income": ["min", "max", "median",  "mean"],
        "total_jail_pop_per10k": ["min", "max", "median",  "mean"],
        "total_prison_pop_per10k": ["min", "max", "median",  "mean"],
        "med_rent": ["min", "max", "median",  "mean"],   
    }  
)
df_treated_states.to_excel('summary_state_byyear_treated.xlsx')


# In[93]:


df_treated_natl = df_dropped.agg(
    {
        "overall_homeless_per10k": ["min", "max", "median",  "mean"],
        "avg_low_temp_cnty_avg": ["min", "max", "median",  "mean"],
        "shelter_beds_per10k": ["min", "max", "median",  "mean"],
        "all_ages_in_poverty_percent_cnty_avg": ["min", "max", "median",  "mean"],
        "median_household_income": ["min", "max", "median",  "mean"],
        "total_jail_pop_per10k": ["min", "max", "median",  "mean"],
        "total_prison_pop_per10k": ["min", "max", "median",  "mean"],
        "med_rent": ["min", "max", "median",  "mean"],   
    }  
)
df_treated_natl.to_excel('summary_natl_treated.xlsx')


# In[ ]:




