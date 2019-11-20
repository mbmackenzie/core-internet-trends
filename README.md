[![Build Status](https://travis-ci.org/mbmackenzie/edav-f19-final.svg?branch=master)](https://travis-ci.org/mbmackenzie/edav-f19-final)

# Analysis of the Core Trends Survey

Exploratory Data Analysis and Visualization - Fall 2019

## File Structure

```
.
├── DESCRIPTION
├── README.md
├── analysis
│   ├── R
│   └── initial
├── data
│   ├── core_trends_2018_survey.docx
│   ├── core_trends_2019_survey.docx
│   ├── data_dictionary
│   ├── raw
│   │   ├── core_trends_2018.csv
│   │   ├── core_trends_2018.sav
│   │   ├── core_trends_2019.csv
│   │   └── core_trends_2019.sav
│   └── tidy
│       ├── core_trends.csv
│       └── econ_data.csv
└── BOOKDOWN_STUFF

```

| Folder/File Name             | Description                                            |
|------------------------------|--------------------------------------------------------|
| analysis                     | Folder for all R code used during analysis             |
| R                            | Folder for any scripts used during analysis            |
| initial                      | Folder for initial exploration of the data             |
| data                         | Folder for storing raw and tidy data                   |
| core_trends_XXXX_survey.docx | The questions by year that were asked to respondents   |
| core_trends_XXXX.csv/sav     | RAW Core trends data by year (csv or sav)              |
| core_trends.csv              | Combined 2018/19 data with renamed columns             |
| econ_data.csv                | State level population, employment, wage data          |
| BOOKDOWN_STUFF               | Represents other files needed to run and deploy report |

