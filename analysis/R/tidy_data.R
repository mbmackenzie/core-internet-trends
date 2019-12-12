library(tidyverse)
library(haven)
library(plyr)

# Load in data

df2018 <- haven::read_sav("data/raw/core_trends_2018.sav")
df2019 <- haven::read_sav("data/raw/core_trends_2019.sav")

# Append year column
df2018$year <- 2018
df2019$year <- 2019

# Rename 2018 data
df2018_renamed <- df2018 %>%
  transmute(
    year = year,
    respid = respid,
    comp = comp,
    cregion = cregion,
    int_date = int_date,
    lang = lang,
    sample = sample,
    state = state,
    age = age,
    birth_place = birth_hisp,
    density = density,
    education = educ2,
    employment = emplnw,
    house.num_people = hh1,
    house.num_adults = hh3,
    hispanic = hisp,
    house.income = inc,
    marital = marital,
    pol.party = party,
    pol.lean = partyln,
    sex = sex,
    usr = usr,
    race = racem1,
    device.cellphone = device1a,
    device.tablet = device1b,
    device.pc = device1c,
    device.game = device1d,
    working_cell = ql1,
    house.working_cell = ql1a,
    device.cellphone.smart = smart2,
    house.not_cell = qc1,
    service.speed = bbhome1,
    service.confirm = bbhome2,
    internet.use = eminuse,
    service.subscribe = home4nw,
    internet.freq = intfreq,
    internet.mobile = intmob,
    sm.freq.twitter = sns2a,
    sm.freq.instagram = sns2b,
    sm.freq.facebook = sns2c,
    sm.freq.snapchat = sns2d,
    sm.freq.youtube = sns2e,
    sm.use = snsint2,
    sm.use.twitter = web1a,
    sm.use.instagram = web1b,
    sm.use.facebook = web1c,
    sm.use.snapchat = web1d,
    sm.use.youtube = web1e,
    sm.use.whatsapp = web1f,
    sm.use.pintrest = web1g,
    sm.use.linkedin = web1h,
    society.overall = pial11,
    society.text.exists = pial11a,
    society.personal = pial12,
    society.text = `pial11ao@`,
    depend.television = pial5a,
    depend.cellphone = pial5b,
    depend.internet = pial5c,
    depend.sm = pial5d,
    books.read = books1,
    books.printed = books2a,
    books.audio = books2b,
    books.ebook = books2c,
    weight = weight) %>%
  as_tibble() %>%
  zap_label()

df2019_renamed <- df2019 %>%
  transmute(
    year = year,
    respid = respid,
    comp = comp,
    cregion = cregion,
    int_date = int_date,
    lang = lang,
    sample = sample,
    state = state,
    age = age,
    birth_place = birth_hisp,
    density = density,
    education = educ2,
    employment = emplnw,
    house.num_people = hh1,
    house.num_adults = hh3,
    hispanic = hisp,
    house.income = inc,
    marital = marital,
    pol.party = party,
    pol.lean = partyln,
    sex = sex,
    usr = usr,
    race = racecmb,
    device.cellphone = device1a,
    device.tablet = device1b,
    device.pc = device1c,
    device.game = device1d,
    working_cell = ql1,
    house.working_cell = ql1a,
    device.cellphone.smart = smart2,
    house.not_cell = qc1,
    service.speed = bbhome1,
    service.confirm = bbhome2,
    internet.use = eminuse,
    service.subscribe = home4nw,
    internet.freq = intfreq,
    internet.mobile = intmob,
    internet.method = q20,
    service.past = bbsmart1,
    service.want = bbsmart2,
    service.reason.subscription = bbsmart3a,
    service.reason.computer = bbsmart3b,
    service.reason.smartphone = bbsmart3c,
    service.reason.options = bbsmart3d,
    service.reason.availability = bbsmart3e,
    service.reason.other = bbsmart3f,
    service.reason.other.text = `bbsmart3foe@`,
    service.reason.biggest = bbsmart4,
    sm.freq.twitter = sns2a,
    sm.freq.instagram = sns2b,
    sm.freq.facebook = sns2c,
    sm.freq.snapchat = sns2d,
    sm.freq.youtube = sns2e,
    sm.use.twitter = web1a,
    sm.use.instagram = web1b,
    sm.use.facebook = web1c,
    sm.use.snapchat = web1d,
    sm.use.youtube = web1e,
    sm.use.whatsapp = web1f,
    sm.use.pintrest = web1g,
    sm.use.linkedin = web1h,
    sm.use.reddit = web1i,
    books.read = books1,
    books.printed = books2a,
    books.audio = books2b,
    books.ebook = books2c,
    weight = weight) %>%
  as_tibble() %>%
  zap_label()

combined_data <- rbind.fill(df2018_renamed, df2019_renamed)

# bin ages
age_breaks <- c(18, 35, 65, 98)
combined_data$age_bin = cut(combined_data$age, breaks = age_breaks, right = FALSE)
levels(combined_data$age_bin) <- c(levels(combined_data$age_bin), c('Don\'t Know', 'Refused'))
combined_data$age_bin[combined_data$age == 98] = 'Don\'t Know'
combined_data$age_bin[combined_data$age == 99] = 'Refused'
combined_data$age_bin = fct_recode(combined_data$age_bin, 
                                   "Under 35" = "[18,35)",
                                   "35 to under 65" = "[35,65)",
                                   "Over 65" = "[65,98)")


write_csv(combined_data, "data/tidy/core_trends.csv")
