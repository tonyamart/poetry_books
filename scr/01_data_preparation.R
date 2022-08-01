library(tidyverse)
library(ghibli)

theme_set(theme_minimal())

setwd("Documents/thesis1830s/22_02_poetry_collections_biblio/")

## Data preparation for the experiment with copia ##

##### upload raw data #####
dat <- read_tsv("data/poetic_books_1834_1850_230222.tsv")

glimpse(dat)


##### cleaning tags #####

dat <- dat %>% 
  mutate(id = row_number()) %>% 
  select(id, poetry_prose,  book_type, genre, special_tag, Author_sign, 
         Author_Initials, Author_full_name, Title, 
         City, Printing_house, Year, pages, size_cm, 
         RNL, RSL,
         Rosanov, `US_Harvard n=1629`, `SLK_CZ n=3346`, `VUL n=3894`, PL_BUW,
         `PL_BN n=1273`, `ester n = 2690`, fin)

colnames(dat) <- c("id", "poetry_prose", "book_type", "genre", "special_tag",
                   "author_sign", "author", "author_full_name", "title", 
                   "city", "printing_h", "year", 
                   "pages", "size", 
                   "nlr", "rsl", 
                   "rozanov", "us_harvard", "cz_slk", "lt_vul", "pl_buw", 
                   "pl_bn", "ee_ester", "fi_sl")

#### drop unknown & NA

glimpse(dat)

unique(dat$poetry_prose)
dat <- dat %>% 
  filter(poetry_prose != "NO")

unique(dat$book_type)

unique(dat$genre)
dat %>% 
  filter(is.na(genre))

unique(dat$special_tag)
# NA for special tag is ok
dat %>% 
  filter(is.na(special_tag)) # number of trusted books -- 736

# leave "ortho" & "songs"
tags_to_cln <- c("unknown", "det; transl", "det", "double", "transl", "posthum", "det; double", "ukr")

dat <- dat %>% 
  filter(!special_tag %in% tags_to_cln) %>% 
  mutate(genre = ifelse(book_type == "alm", "", genre)) %>% 
  mutate(genre = ifelse(str_detect(genre, ";|:"), "nar", genre)) %>% # nar for non-lyrical collections
  mutate(group = paste0(book_type, "_", genre))

dat %>% 
  group_by(group) %>% 
  count()

glimpse(dat)

dat %>% 
  group_by(year, group) %>% 
  count() %>% 
  ggplot(aes(x = year, y = n, fill = group)) + geom_col() 

#### Counts ####

glimpse(dat)

unique(dat$nlr) # nlr contains "нет" & NAs
unique(dat$rsl)
unique(dat$rozanov)
unique(dat$us_harvard)
unique(dat$cz_slk)
unique(dat$pl_bn)
unique(dat$pl_buw)
unique(dat$lt_vul)
unique(dat$ee_ester)
unique(dat$fi_sl)



dat <- dat %>% 
  mutate(nlr_1 = ifelse(is.na(nlr), 0, nlr)) %>% 
  mutate(nlr_1 = ifelse(str_detect(nlr_1, "^0.*"), 1, 0)) %>% # "нет" would go away as not 0.*
  mutate(rsl = ifelse(is.na(rsl), 0, rsl)) %>% 
  mutate(rsl = ifelse(rsl == "да", 1, 0)) %>% 
  
  # other cols are all either yes or NA
  mutate(roz_1 = ifelse(!is.na(rozanov), 1, 0)) %>% 
  mutate(us_harvard = ifelse(!is.na(us_harvard), 1, 0)) %>% 
  mutate(cz_slk = ifelse(!is.na(cz_slk), 1, 0)) %>% 
  mutate(lt_vul = ifelse(!is.na(lt_vul), 1, 0)) %>% 
  mutate(pl_bn = ifelse(!is.na(pl_bn), 1, 0)) %>% 
  mutate(pl_buw = ifelse(!is.na(pl_buw), 1, 0)) %>% 
  mutate(ee_ester = ifelse(!is.na(ee_ester), 1, 0)) %>% 
  mutate(fi_sl = ifelse(!is.na(fi_sl), 1, 0))

# n books found in each collection
glimpse(dat)
unique(dat$us_harvard)
unique(dat$nlr_1)
unique(dat$roz_1)

#write.csv(dat, file = "biblio_full_cln_24022022.csv")

dat2 <- dat %>% 
  select(id, group, author_sign, author_full_name, title, 
         city, printing_h, year, pages, size, 
         nlr_1, rsl, roz_1, us_harvard, cz_slk, lt_vul, pl_bn, pl_buw, ee_ester, fi_sl)

glimpse(dat2)

#write.csv(dat2, file = "biblio_for_experiment_short.csv")


counts <- dat2 %>% 
  summarise_at(vars(nlr_1:fi_sl), sum)


total <- list(47000, 28000, 1914, 1629, 3346, 3894, 1273, 700, 2690, 2916)
counts[nrow(counts) + 1,] = total



dat2 <- dat2 %>% 
  rowwise() %>% mutate(n_total = sum(c_across(11:20)))

glimpse(dat2)

dat2 %>% 
  filter(n_total == 0)

dat2 <- dat2 %>% 
  filter(!n_total == 0)

head(dat2$n_total)

#### sizes ####

unique(dat2$pages)

which(dat2$pages == "90, 104, 26")
dat2$pages[325] <- 220

which(dat2$pages == "[2], X, III")
dat2$pages[19] <- 15

dat2$pages <- as.numeric(dat2$pages)

#write.csv(dat2, file = "biblio_fin_2402.csv")

############################
#### data to sep tables ####
############################

glimpse(dat2)

#### basic genres distinction ####

to_exp <- dat2 %>% 
  mutate(work = paste0(group, "____", year, "_", id, "_", author_sign, "_", title)) %>% 
  select(work,
         nlr_1:fi_sl)

glimpse(to_exp)

to_exp_u <- to_exp %>% 
  pivot_longer(!work, names_to = "signature", values_to = "count") %>% 
  filter(count != 0) %>% 
  separate(work, into = c("group", "work"), sep = "____") %>% 
  select(group, work, signature)

unique(dat2$group)

dat2 %>% 
  group_by(group) %>% 
  count()

col_lyr <- to_exp_u %>% 
  filter(group == "col_lyr") %>% 
  select(work, signature)

col_lyr %>% 
  group_by(work) %>% 
  count(sort = T)

length(unique(col_lyr$work))

write.csv(col_lyr, file = "scripts/data/col_lyr.csv")

sep_lyr <- to_exp_u %>% 
  filter(group == "sep_lyr") %>% 
  select(work, signature)

length(unique(sep_lyr$work))

write.csv(sep_lyr, file = "scripts/data/sep_lyr.csv")


sep_nar <- to_exp_u %>% 
  filter(group == "sep_nar") %>% 
  select(work, signature)

write.csv(sep_nar, file = "scripts/data/sep_nar.csv")


alm_ <- to_exp_u %>% 
  filter(str_detect(group, "^alm.*?")) %>% 
  select(work, signature)

write.csv(alm_, file = "scripts/data/alm_.csv")


col_nar <- to_exp_u %>% 
  filter(group == "col_nar") %>% 
  select(work, signature)

write.csv(col_nar, file = "scripts/data/col_nar.csv")

sep_drama <- to_exp_u %>% 
  filter(group == "sep_drama") %>% 
  select(work, signature)

write.csv(sep_drama, file = "scripts/data/sep_drama.csv")



#### year + genre grouping ####

glimpse(to_exp_u)

to_exp_years <- dat2 %>% 
  mutate(year_group = ifelse(year < 1840, 1830, year)) %>% 
  mutate(year_group = ifelse(year > 1840, 1840, year_group)) %>% 
  mutate(year_group = ifelse(year > 1845, 1845, year_group)) %>% 
  mutate(work = paste0(group, "_", year_group, "____", id, "_", author_sign, "_", title)) %>% 
  select(work,
         nlr_1:fi_sl)

glimpse(to_exp_years)

to_exp_u_years <- to_exp_years %>% 
  pivot_longer(!work, names_to = "signature", values_to = "count") %>% 
  filter(count != 0) %>% 
  separate(work, into = c("group", "work"), sep = "____") %>% 
  select(group, work, signature)

glimpse(to_exp_u_years)

to_exp_u_years %>% 
  group_by(group) %>% 
  count()

col_lyr_1845 <- to_exp_u_years %>% 
  filter(group == "col_lyr_1845") %>% 
  select(work, signature)

col_lyr %>% 
  group_by(work) %>% 
  count(sort = T)

length(unique(col_lyr$work))

write.csv(col_lyr_1845, file = "scripts/data/col_lyr_1845.csv")

sep_lyr <- to_exp_u %>% 
  filter(group == "sep_lyr") %>% 
  select(work, signature)

length(unique(sep_lyr$work))

write.csv(sep_lyr, file = "scripts/data/sep_lyr.csv")


sep_nar_1845 <- to_exp_u_years %>% 
  filter(group == "sep_nar_1845") %>% 
  select(work, signature)

write.csv(sep_nar_1845, file = "scripts/data/sep_nar_1845.csv")


alm_ <- to_exp_u %>% 
  filter(str_detect(group, "^alm.*?")) %>% 
  select(work, signature)

write.csv(alm_, file = "scripts/data/alm_.csv")


##### authors as species #####

glimpse(dat2)

unique(dat2$author_full_name)
dat2 %>% 
  count(author_full_name, sort = T)
# 198 NA out of 330 unique 

to_exp_names <- dat2 %>% 
  mutate(name = str_remove_all(author_full_name, "[[:punct:]]|[[:space:]]")) %>% 
  mutate(work = paste0(name, "____", year, "_", id, "_", author_sign, "_", title)) %>% 
  select(work,
         nlr_1:fi_sl)

glimpse(to_exp_names)
head(to_exp_names)

to_exp_u_names <- to_exp_names %>% 
  pivot_longer(!work, names_to = "signature", values_to = "count") %>% 
  filter(count != 0) %>% 
  separate(work, into = c("name", "work"), sep = "____") %>% 
  select(name, work, signature)

glimpse(to_exp_u_names)

write.csv(to_exp_u_names, "scripts/data/2_exp_authors.csv")
