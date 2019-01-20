
library(tidyverse)
library(readxl)
library(lubridate)

df.soc.sent <- read_excel('input/SocSent.xlsx')
df.soc.sent$dateid <- as.Date(as.character(df.soc.sent$dateid), format='%Y%m%d')

df.soc.sent <- df.soc.sent %>% mutate(
  nps.scale = scale(NPS),
  salt.scale = scale(SALT),
  bfv.scale=scale(BFV)
)
