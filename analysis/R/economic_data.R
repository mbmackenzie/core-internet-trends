library(dotenv)

library(tidyverse)
library(blscrapeR)
library(httr)

# Economic Data

## State look up (built into blscrapeR)
states <- state_fips %>%
  transmute(state_code = fips_state, 
            state_name = state)

## Get the state level data

ACS_KEY <- Sys.getenv("ACS_KEY")
BLS_KEY <- Sys.getenv('BLS_KEY')

### ACS -- Population -- Subject S2101_C01_001E
acs_id <- "S2901_C01_001E"
acs_state_pop_url <- paste(
  'https://api.census.gov/data/2018/acs/acs1/subject?get=', acs_id,'&for=state:*&key=', sep='')

acs_state_pop_url <- paste(acs_state_pop_url, ACS_KEY, sep = '')

request <- GET(acs_state_pop_url)
state_pops <- as.data.frame(do.call(rbind, content(request))) %>%
  .[-1,] %>%
  rename(population = V1, state_code = V2) %>%
  mutate(state_code = as.character(state_code),
         population = as.integer(population)) %>%
  inner_join(states) %>%
  select(state_code, state_name, population) %>%
  arrange(state_code)


### BLS - https://www.bls.gov/help/hlpforma.htm

#### Local Area Unemployment Statistics
getBLS_LA <- function(state, value) {
  paste('LA', 'U', 'ST', state, '00000000000', value, sep = '')
}

getBLS_OE <- function(state, value) {
  paste('OE', 'U', 'S', state, '00000', '000000000000', value, sep = '')
}


getBLS_ids <- function(states, values, id_func) {
  lapply(states, id_func, values)
}

getBLS_data <- function(series_ids, api_key, var_names, 
                        state_pos, var_pos, startyear, endyear) {
  data <- bls_api(series_ids, 
                  startyear = startyear,
                  endyear = endyear,
                  registrationKey = api_key) %>%
    mutate(state_code = str_sub(seriesID, state_pos[1], state_pos[2]),
           var_code = str_sub(seriesID, var_pos[1], var_pos[2])) %>%
    group_by(year, state_code, var_code) %>%
    summarise(value = mean(value)) %>%
    spread(var_code, value) %>%
    ungroup()
  
  names(data) <- c(c('year', 'state_code'), var_names)
  data
}

getBLS_all <- function(api_key, states, vars, id_func, var_names, 
                       state_pos, var_pos, startyear = 2018, endyear = 2018) {
  ids <- getBLS_ids(states, vars, id_func)
  data <- lapply(ids, getBLS_data,
                 api_key = api_key, var_names = var_names,
                 state_pos = state_pos, var_pos = var_pos,
                 startyear = startyear, endyear = endyear)
  data <- do.call(rbind, data)
  data
}

employment_data <- getBLS_all(BLS_KEY, state_pops$state_code, c('04', '05'), getBLS_LA,
                              c('unemployed', 'employed'), c(6, 7), c(-2, -1))

wage_data <- getBLS_all(BLS_KEY, state_pops$state_code, c('08'), getBLS_OE,
                        c('med_hr_wage'), c(5, 6), c(-2, -1))

econ_data <- state_pops %>%
  full_join(employment_data) %>%
  full_join(wage_data) %>%
  as_tibble()

write_csv(econ_data, 'data/econ_data.csv')