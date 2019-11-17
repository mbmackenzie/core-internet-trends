library(tidyverse)
library(haven)

# Load in data

df2018 <- read.csv("data/raw/core_trends_2018.csv")
df2019 <- read.csv("data/raw/core_trends_2019.csv")

# Append year column
df2018$year <- 2018
df2019$year <- 2019

### DO SOMETHING
### DO SOMETHING
### DO SOMETHING


write_csv(df2018, "data/tidy/core_trends.csv")
