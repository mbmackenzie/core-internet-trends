library(tidyverse)
dd <- read_csv('data/data_dictionary/data_dictionary.csv')

get_levels <- function(name) {
  df <- dd %>%
    distinct(new_name, category, value, meaning) %>%
    group_by(category, new_name) %>%
    summarize(levels = list(meaning)) %>%
    filter(new_name %in% name) %>%
    rename(name = new_name)
  
  if (length(name) == 1) {
    return(df$levels[[1]])
  } else {
    return(df)
  }
}

change_levels <- function(x, levels, na_explicit = FALSE, na_level = NA) {
  x <- as.factor(x)
  levels(x) <- levels
  
  if (!is.na(na_level) | na_explicit) {
    if (!is.na(na_level)) {
      x <- fct_explicit_na(x, na_level = na_level)
    } else {
      x <- fct_explicit_na(x)
    }
  }
  
  return(x)
}

replace_levels <- function(x, use_col = NA, na_explicit = FALSE, na_level = NA) {
  if (is.na(use_col)) {
    name <- deparse(substitute(x))
  } else {
    name <- use_col
  }
  levels <- get_levels(name)
  change_levels(x, levels, na_explicit, na_level)
}
