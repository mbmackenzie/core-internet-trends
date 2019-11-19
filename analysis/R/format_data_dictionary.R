library(tidyverse)
library(glue)
library(knitr)


dd <- read_csv('data/data_dictionary/data_dictionary.csv')

dd$name_id <- dd %>% 
  group_indices(new_name) 

years_present <- dd %>%
  distinct(year, new_name, name_id) %>%
  spread(year, 1) %>%
  mutate(p18 = as.integer(!is.na(`2018`)),
         p19 = as.integer(!is.na(`2019`))) %>%
  select(new_name, p18, p19) %>%
  arrange(new_name)

sub_tables <- dd %>%
  left_join(years_present, by = 'new_name') %>%
  select(category, new_name, p18, p19, original_name, question, value, meaning) %>%
  group_by(new_name) %>%
  group_split()

category_counts <- dd %>% 
  distinct(category, new_name) %>%
  count(category)
  

tagit <- function(x, tag) {
  paste('<', tag, '>', x, '</', tag, '>', sep = '')
}


categories <- c("Identifier", "Demographic", "Devices", "Internet", "Social Media", "Dependency", "Society", "Books", "Other")


for (c in categories) {
  html <- paste(c('<table><tr>',
                  '<th>Feature</th>',
                  '<th>Years</th>', 
                  '<th>Question/Description</th>',
                  '<th>Values</th></tr>'), collapse = '')
  
  for (t in sub_tables) {
    category <- t$category[1]
    if (category == c) {

      name <- t$new_name[1]
      original_name <- t$original_name[1]

      if (name != original_name) {
        name <- glue("{ name } <br>({ original_name })")
      }
      
      html <- paste(html, tagit(name, 'td'))

      if (t$p18[1] & t$p19[1]) {
        yp <- 'Both'
      } else if (t$p18[1] & !t$p19[1]) {
        yp <- '2018'
      } else {
        yp <- '2019'
      }
      
      html <- paste(html, tagit(yp, 'td'))
      html <- paste(html, tagit(t$question[1], 'td'))
      
      list_elems <- t %>%
        distinct(value, meaning) %>%
        arrange(value) %>%
        mutate(elem = glue("{ value } ({ meaning })")) %>%
        pull(elem) %>%
        paste(collapse = '; ')
      
      html <- paste(html, tagit(tagit(list_elems, 'ul'), 'td'), '</tr>')
    }
  }
  
  html <- paste(html, '</table>')
  fileConn<-file(paste("data/data_dictionary/", c, ".html", sep=''))
  writeLines(html, fileConn)
  close(fileConn)
  
}


