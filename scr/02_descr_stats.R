library(tidyverse)
library(ghibli)

theme_set(theme_minimal())

##########################################
#### basic stats #########################

dat2 <- read.csv("scripts/data/biblio_fin_2402.csv")
dat2 <- dat2[,-1]

# create a column with group labels
dat2 <- dat2 %>% 
  mutate(group_lable = recode(group, 
                              "col_lyr" = "Сборники", 
                              "sep_lyr" = "Отд. стихотворения", 
                              "sep_nar" = "Поэмы", 
                              "alm_" = "Альманахи и коллективное"))

glimpse(dat2)

as.vector(ghibli_palettes$MarnieMedium1)
as.vector(ghibli_palettes$MarnieLight1)

sum(dat2$nlr_1)
sum(dat2$rsl)

#### Plot: n books in each group on a timeline ####

dat2 %>% 
  filter(group %in% c("col_lyr", "sep_lyr", "sep_nar", "alm_")) %>% 
  group_by(group_lable, year) %>% 
  count() %>% 
  ggplot(aes(x = year, y = n, fill = group_lable)) + geom_col() + 
  scale_fill_manual(values = as.vector(ghibli_palettes$MarnieMedium1)
                    # ,
                    # labels = c("Альманахи", "Сборники", "Отд. изд.", "Поэмы")
  ) + 
  facet_wrap(~group_lable, scales = "fixed") + 
  labs(fill = "",
       x = "", 
       y = "Количество изданий") + 
  theme(legend.position = "bottom", 
        axis.text = element_text(size = 12), 
        strip.text = element_text(size = 12), # facet lable size
        legend.text = element_text(size = 12))

ggsave(filename = "plot_1.png", plot = last_plot(), width = 8, height = 5, 
       bg = "white")

#### pages ####

dat2 %>% 
  filter(!is.na(pages)) %>% 
  filter(group %in% c("col_lyr", "sep_lyr", "sep_nar", "alm_")) %>% 
  group_by(pages, group_lable) %>% 
  select(pages, group_lable) %>% 
  ggplot(aes(x = pages, color = group_lable)) + 
  geom_density(size = 2, fill = "#8EBBD2FF", alpha = 0.5) + 
  facet_wrap(~group_lable, scales = "free", nrow = 1) + 
  scale_color_manual(values = as.vector(ghibli_palettes$MarnieMedium1)) + 
  labs(x = "Количество страниц",
       y = "", 
       color = "", 
       title = "Распределение количества страниц") + 
  theme(axis.text.y = element_blank(),
        legend.position = "None", 
        axis.text = element_text(size = 12), 
        strip.text = element_text(size = 12))

ggsave(filename = "plot_2.png", plot = last_plot(), width = 8, height = 4, 
       bg = "white")



which.min(dat2 %>% filter(group == "col_lyr") %>% pull(pages))
which.min(dat2 %>% filter(group == "sep_nar") %>% pull(pages))



#### size in cm ####

glimpse(dat2)

dat2 %>% 
  filter(group %in% c("col_lyr", "sep_lyr", "sep_nar"))

dat2 %>% 
  filter(!is.na(size)) %>% 
  filter(group %in% c("col_lyr", "sep_lyr", "sep_nar", "alm_")) %>% 
  group_by(size, group_lable) %>% 
  select(size, group_lable) %>% 
  ggplot(aes(x = size, color = group_lable)) + 
  geom_density(size = 2, fill = "#8EBBD2FF", alpha = 0.5) + 
  facet_wrap(~group_lable, scales = "fixed", nrow = 1) + 
  scale_color_manual(values = as.vector(ghibli_palettes$MarnieMedium1)) + 
  labs(x = "Размер в см",
       y = "", 
       color = "") + 
  theme(axis.text.y = element_blank(),
        legend.position = "None", 
        axis.text = element_text(size = 12), 
        strip.text = element_text(size = 12))

ggsave(filename = "plot_3.png", plot = last_plot(), width = 7, height = 5)


dat2 %>% 
  filter(!is.na(pages)) %>% 
  filter(group %in% c("col_lyr", "sep_lyr", "sep_nar", "alm_")) %>% 
  group_by(year, group, pages) %>% 
  count() %>% 
  ungroup() %>% 
  group_by(year, group) %>% 
  summarise(total_pages1 = pages*n) %>% 
  summarise(total_all = sum(total_pages1)) %>% 
  ggplot(aes(x = year, y = total_all, fill = group)) + 
  geom_bar(position = "fill", stat = "identity") + 
  scale_fill_manual(values = as.vector(ghibli_palettes$MarnieMedium1),
                    labels = c("Альманахи", "Сборники", "Отд. изд.", "Поэмы")) + 
  theme(axis.text.y = element_blank(),
        axis.text.x = element_text(size = 12)) + 
  labs(x = "",
       y = "", 
       fill = "")

ggsave(filename = "plot_4.png", plot = last_plot(), width = 8, height = 5)

