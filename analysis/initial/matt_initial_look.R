df %>%
  select(age, books1) %>%
  filter(age <= 97, books1 <= 97) %>%
  ggplot(aes(age, books1)) + geom_point()


by_app <- df %>%
  select(respid, contains("web1")) %>%
  rename(Twitter = web1a,
         Instagram = web1b,
         Facebook = web1c,
         Snapchat = web1d,
         YouTube = web1e,
         WhatsApp = web1f,
         Pinterest = web1g,
         LinkedIn = web1h
  ) %>%
  gather(app, value, -respid) %>%
  filter(value <= 2) %>%
  group_by(app) %>%
  summarise(total = n(),
            Yes = sum(value == 1), 
            No = sum(value == 2), 
            pct_use = Yes / total) %>%
  arrange(desc(pct_use))

by_app %>%
  select(app, Yes, No) %>%
  mutate(app = fct_reorder(app, Yes)) %>%
  gather(used, num, -app) %>%
  ggplot(aes(app, num, fill = used)) + 
  geom_col() + 
  coord_flip() + 
  labs(title = 'How many people use and do not use certain apps?',
       x = "", 
       y = 'Number of People', 
       fill = 'Used the app')
df %>%
  ggplot(aes(age)) +
  geom_histogram(binwidth = 3)
