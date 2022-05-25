Currently Submitting for Publication - please reach out for more information jsande3@g.clemson.edu

Methods:

To analyze this time-series data, a difference-in-differences (DID) Model with Multiple Time Periods (DID-MTP) is employed to estimate the group-specific average treatment effects on homelessness where the group treatment (i.e., recreational cannabis legalization) was adopted at different times. The DID-MTP model will also estimate the treatment effects over time for all groups in the aggregate.

Source CRAN: https://cran.r-project.org/web/packages/did/index.html

Source package:

Callaway, B., & Sant'Anna, P. (2020). did: Difference in Differences. R package. In (Version
  2.0.0) https://bcallaway11.github.io/did/

Method research:

Callaway, B., & Sant’Anna, P. H. C. (2021). Difference-in-Differences with multiple time
  periods. Journal of Econometrics, 225(2), 200-230.
  https://doi.org/https://doi.org/10.1016/j.jeconom.2020.12.001

Note: The uploaded 'Example Data.xlsx' is a truncated data set provided to demonstrate the data structure. If you are interested in possible projects or collaboration on the full data set, or would like more information about the data, please feel free to reach out (I have collected additional macro-economic, political, and social data that has been similarly aggregated). A codebook and the preliminary DID-MTP results have been uploaded under Appendix.docx.

Analytic Sample Criterion and Data Aggregation:

All variables are aggregated at the Continuum-of-Care (CoC) level. All population variables have been recoded to per 10,000 residents based on the summed population data for all county populations in a corresponding CoC region (U.S. Census 2019). All non-population variables for the counties in each CoC are aggregated by mean, median, or sum. As some U.S. Census population data was not available for all years, total county populations have been imputed using a mean. Finally, all control variables will be recoded as time-invariant using its respective statistical type; for example, population rates will be time-invariant means and median rent will be a time-invariant median. In cases where there are three or more years of missing data for the dependent variable, those CoCs are deleted from the data set. All other missing data for time-invariant control variables are imputed using the same time-invariant value from its CoC group. Additional details on variables can be found in Appendix A: Table 1.1

There are CoCs that are Statewide, and there are CoCs for a Balance of State (BoS). Both statewide and BoS CoCs have been removed from the sample as they do not include county-level data to aggregate with the independent and control variables; this therefore excludes regions of the country with extremely low per capita homelessness. The states excluded as statewide CoC-only are: Delaware, Maine, Montana, North Dakota, Rhode Island, and Wyoming. Aggregating only the CoCs providing services at a county level, the analytic sample includes 307 CoC.s from 44 states.

Given that CoCs contain one or more counties, all CoCs are matched to a list of counties so that datasets can be merged. To accomplish this, a dictionary of CoCs and corresponding counties has been created and are merged using Python 3.8 (see my Data-Wrangling repo here: https://github.com/AustinSanderson/Data-Wrangling). This allowed data sets previously without common IDs to be merged.  The common, unique IDs on which the datasets are merged are FIPS state-county codes and years. Note that the FIPs State County Codes, county names, and area names, come from Department of Housing and Urban Development (HUD) Fair Market Rent (FMR) rent data. Note: If you are interested in working on a similar project, please contact me if you would be interested in this dictionary of CoCs and county FIPS codes.

**To account for potentially confounding attributes in the model, a set of six control variables is included. These are listed, along with the descriptive statistics, in Appendix A: Table 1.1 and Appendix B: Table 2.1.

-Austin Sanderson
j.austin.sanderson@gmail.com
https://linkedin.com/in/austinsanderson
--currently seeking employment upon graduation in May 2022--
