library(tidyverse)
library(glue)
library(stringr)

# load data
econ_data <- readr::read_csv("~/data/economic_data.csv") %>%
  dplyr::select(-X1)
housing_data <- readr::read_csv("~/data/housing_data.csv") %>%
  dplyr::select(-X1)
supp_data <- readr::read_csv("~/data/supplement_data_t.csv")  # this data has been tranposed in Excel first


# join data by geography and period
# convert period quarters from strings to lubridate date objects
combined_data_quarter <- inner_join(
  econ_data,
  housing_data,
  on=c("Geography","Period")
) %>% inner_join(
  supp_data,
  on=c("Geography","Period")
) %>%
  mutate(
    Period=str_replace(Period, "Q","."),
    quarter=lubridate::yq(Period),
    year=lubridate::year(quarter)
  ) %>%
  dplyr::select(-c("Period")) # remove "Period" column


write_csv(combined_data_quarter, "~/data/combined_data_quarter.csv")