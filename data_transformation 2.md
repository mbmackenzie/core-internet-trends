# Data Transformation

## Creating the Data Dictionary
To begin the transformation process, we found it most usefull to create a data dictionary since there were many variables each with many different possible values. To do this, we went through each survey document as well as the data to keep track of variable names, question, and possible values. After this, we recorded each in a CSV file the we could then use in later scripts. 

The first script (format_data_dictionary.R) was used to parse the CSV file and format the tables seen in Appendix A. The next script (replace_levels.R)  contains functions that allow us to replace the numerical values of a column with the textual representation with ease. Throughout the analysis process, we found it easiser to filter based on the numerical values, and then transform the levels. 

## Renaming the Variables

Many of the names used in the raw data were quite cryptic. We used the tidying process to rename variables to be grouped by what they were discussing, and be easily selectable if we wanted to look at a group of varibles. We settled on 9 groups: Identifiers, Demographics, Devices, Internet, Social Media, Depenence, Society, Books, and Other. These groups are reflected in the Data Dictionary in Appendix A. The variables were manually changed in our preprocessing script, tidy_data.R. 

The second reason for renaming the varibles was to ensure that we could properly overlap the data from 2018 and 2019. As some variable did or didn't exist from year to year, or the varible names might change, we dealt with this before it became a problem. 

## Keeing the Data Wide

We decided to keep the data in a "wide" format. There were so many features that it was actually easier to just filter by column as we needed it, and then perform any gathering that we may need to do. 

## Preprocessing Age

Much of the time, the actual age of repondents was to granular to work with. We tried binning the age in different ways, but eventually settled on the age groups 18 to 34, 35 to 64, and 65 over 65 (inclusive). We felt this was enough to show anything interesting relating to differences in age. It also captures much of the generational differeneces we see today, mainly millenials, generation X, and baby boomers. 
