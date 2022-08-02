library(tidyverse)
library(ghibli)

theme_set(theme_minimal())

setwd("Documents/thesis1830s/22_02_poetry_collections_biblio/github_main/")

##########################################
#### basic stats #########################

dat <- read.csv("data/biblio_poetry_1834_1850.csv")
glimpse(dat)
dat <- dat[,-1]

#### labels for genres ####

dat %>% 
  count(group, sort = T)

# create a column with group labels
dat <- dat %>% 
  mutate(group_lable = recode(group, 
                              "col_lyr" = "Сборники", 
                              "sep_lyr" = "Отд. стихотворения", 
                              "sep_nar" = "Поэмы", 
                              "alm_" = "Альманахи и коллективное",
                              "sep_drama" = "Драма в стихах",
                              "col_nar" = "Сб. повестей в стихах"))

glimpse(dat)

as.vector(ghibli_palettes$MarnieMedium1)
as.vector(ghibli_palettes$MarnieLight1)
as.vector(ghibli_palettes$MononokeMedium)

# number of books found in each library collection
dat %>% 
  select(nlr_1:fi_sl) %>% 
  summarise(across(where(is.numeric), ~ sum(.x, na.rm = T)))
  
#### Plot: n books in each group on a timeline ####

dat %>% 
  #filter(group %in% c("col_lyr", "sep_lyr", "sep_nar", "alm_")) %>% 
  group_by(group_lable, year) %>% 
  count() %>% 
  ggplot(aes(x = year, y = n, fill = group_lable)) + 
  geom_col() + 
  geom_smooth(alpha = 0.2, size = 0.7, color = "#E48C2AFF", linetype = 2) + 
  scale_fill_manual(values = as.vector(ghibli_palettes$MarnieMedium1)) + 
  scale_y_continuous(limits = c(0, NA)) + 
  facet_wrap(~group_lable, scales = "fixed") + 
  labs(fill = "",
       x = "", 
       y = "Количество изданий") + 
  theme(legend.position = "None", 
        axis.text = element_text(size = 12), 
        strip.text = element_text(size = 12), # facet lable size
        legend.text = element_text(size = 12),
        panel.spacing = unit(2, "lines"))

ggsave(filename = "plots/01_plot_1.png", plot = last_plot(), width = 8, height = 5, 
       bg = "white")

#### pages ####

# find modes

dat %>% 
  filter(!is.na(pages)) %>% 
  #filter(group %in% c("col_lyr", "sep_lyr", "sep_nar", "alm_")) %>% 
  group_by(pages, group_lable) %>% 
  select(pages, group_lable) %>% 
  ggplot(aes(x = pages, color = group_lable)) + 
  geom_density(size = 2, fill = "#8EBBD2FF", alpha = 0.5) + 
  facet_wrap(~group_lable, scales = "free", nrow = 2) + 
  scale_color_manual(values = as.vector(ghibli_palettes$MarnieMedium1)) + 
  labs(x = "Количество страниц",
       y = "Плотность распределения количества страниц", 
       color = ""
       ) + 
  theme(axis.text.y = element_blank(),
        legend.position = "None", 
        axis.text = element_text(size = 12), 
        strip.text = element_text(size = 12))

ggsave(filename = "plots/01_plot_2.png", plot = last_plot(), width = 8, height = 4, 
       bg = "white")



which.min(dat %>% filter(group == "col_lyr") %>% pull(pages))
which.min(dat %>% filter(group == "sep_nar") %>% pull(pages))



#### size in cm ####

glimpse(dat)

dat %>% 
  filter(group %in% c("col_lyr", "sep_lyr", "sep_nar"))

dat %>% 
  filter(!is.na(size)) %>% 
  #filter(group %in% c("col_lyr", "sep_lyr", "sep_nar", "alm_")) %>% 
  group_by(size, group_lable) %>% 
  select(size, group_lable) %>% 
  ggplot(aes(x = size, color = group_lable)) + 
  geom_density(size = 2, fill = "#8EBBD2FF", alpha = 0.5) + 
  facet_wrap(~group_lable, scales = "fixed", nrow = 2) + 
  scale_color_manual(values = as.vector(ghibli_palettes$MarnieMedium1)) + 
  labs(x = "Размер в см",
       y = "Плотность распределения размеров", 
       color = "") + 
  theme(axis.text.y = element_blank(),
        legend.position = "None", 
        axis.text = element_text(size = 12), 
        strip.text = element_text(size = 12))

ggsave(filename = "plots/01_plot_3.png", plot = last_plot(), width = 7, height = 5,
       bg = "white")


#### n pages in groups ####

dat %>% 
  filter(!is.na(pages)) %>% 
  #filter(group %in% c("col_lyr", "sep_lyr", "sep_nar", "alm_")) %>% 
  filter(group != "alm_") %>% 
  group_by(year, group_lable, pages) %>% 
  count() %>% 
  ungroup() %>% 
  group_by(year, group_lable) %>% 
  summarise(total_pages1 = pages*n) %>% 
  summarise(total_all = sum(total_pages1)) %>% 
  ggplot(aes(x = year, y = total_all, fill = group_lable)) + 
  geom_bar(position = "fill", stat = "identity") + 
  scale_fill_manual(values = as.vector(ghibli_palettes$MarnieMedium1)[2:6]) + 
  theme(#axis.text.y = element_blank(),
        axis.text.x = element_text(size = 12),
        axis.title.x = element_text(size = 14),
        legend.position = "top",
        legend.text = element_text(size = 12)) + 
  labs(x = "Распределение количества страниц по группам\n(1 столбец = 100% страниц, учтенных за год)",
       y = "", 
       fill = "")

ggsave(filename = "plots/01_plot_4.png", plot = last_plot(), width = 8, height = 5,
       bg = "white")

