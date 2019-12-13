---
output: html_document
editor_options: 
  chunk_output_type: console
---

# Data Sources




 Year  Source                                                                         
-----  -------------------------------------------------------------------------------
 2018  https://www.pewresearch.org/internet/dataset/jan-3-10-2018-core-trends-survey/ 
 2019  https://www.pewresearch.org/internet/dataset/core-trends-survey/               

## Overview 
The Interent Core Trends Survey dataset is a series of questions asked by the Pew Research Center. The surevey consists of questions designed to probe a person's use of the internet, social media, and other electronic and non electronic things like books, tv, and phones. The survey also asks a number of questions about a person's demographics including their age, race, income, etc. This survey seems to be conducted every year, but we were only able to obtain data for 2018 and 2019. This is where the first major problem stems from, different questions were asked in both of these years. The 2018 survey contains a series of questions about the respondent's view on the impact of the internet on society, while 2019 does not. And in 2019, there was a series of questions asked about a persons internet service they subscibe to, while 2018 did not. Other than thsese questions, every other questions was asked. For a complete list of features in this dataset and the questions and possible answers associated with it, please see [Appendix A](#data-dictionary).
 
## Pew Reseach Center
[The Pew Research Center](https://www.pewresearch.org/about/){target="_blank} is a "nonpartisan fact tank that informs the public about the issues, attitudes and trends shaping the world." Starting in 1990,the then Times Mirror Center for the People & the Press began conducting polls on politics and other major policy of the times. In 1996, the Pew Research Center was concieved with funds from the Pew Charitable Trusts, and fully blossomed with its potential in 2004. For the next decade, the Center would combine the work of the Census Bureau and their own surveys, before moving on to becomming a pioneer in the "frontier of social science research".^[https://www.pewresearch.org/about/our-history/]

## Methodology
The 2018 Interent Core Trends Survey was conducted between Janurary 3 and 10, 2018. During this window, a sample of 2,002 respondents were called via cellphone (1,502) and landline (500) phone calls. The interviews were conducted in English and Spanish as needed. The target universe of this survey is "non-institutionalized persons age 18 and over" living in the United States. The cell phone numbers were drawn from the random digit dial (RDD) of a a set of phone numbers. The questionare was developed by the Pew Research Center in consultation with Abt Associates. The questionnaire was pretested on random repondents by experienced interview givers, and this led to some changes being made on the final questionnaire. As for calling procedures, numbers were called back up to 7 times for english speakers, and 10 times for spanish speakers. In cases where there was only slight push to refuse the survey from the repondents, the interviewrs were allowed to try and sway them to take the surevey. For landline interviews, the interviewer asked to speak with the youngest male or female at home, and cellular interviews were conducted with whoever picked up. For cellular interviews, interviewers offered respondents a post-paid cash incentive of $5 for their participation.

## Dataset Profile



The final, clean version of the Internet Core Trends data that we will be using consists of 3504 observations in 77 variables. Below is a more thorough breakdown by the raw data:


Property                  2018     2019
---------------------  -------  -------
rows                      2002     1502
columns                     70       74
all_missing_columns          0        0
total_missing_values     28026    31429
complete_rows                0        0
total_observations      140140   111148

The majority of coulumns are discrete in nature, as the possible answers are limited to specific responses allowed by the interviewer. Age is open to any value less than or equal to 97. This makes analysis particularly interesting since there only categorical values.

## Downloading the Data

The data for each year was downloaded separately from Pew Reasearch's website (links at top of page) as zip files. After extraction, both a CSV and SAS file containing the raw data were included. Also included were the questions asked, summary data files, and in 2018 the methodology document. The SAS file and CSV file only differed in the fact the SAS file used labeled data frames. 













