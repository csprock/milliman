library(tidyverse)
library(glue)
library(stringr)

econ_data <- readr::read_csv("~/data/economic_data.csv") %>%
  dplyr::select(-X1)
housing_data <- readr::read_csv("~/data/housing_data.csv") %>%
  dplyr::select(-X1)
supp_data <- readr::read_csv("~/data/supplement_data_t.csv")


combined_data <- inner_join(
  econ_data,
  housing_data,
  on=c("Geography","Period")
) %>% inner_join(
  supp_data,
  on=c("Geography","Period")
) %>%
  mutate(
    Period=str_replace(Period, "Q","."),
    Period_d=lubridate::yq(Period)
  )


write_csv(combined_data, "~/data/combined_data.csv")

