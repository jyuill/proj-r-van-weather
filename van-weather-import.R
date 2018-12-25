
library(tidyverse)
library(dplyr)
library(ggplot2)

## weather data from:
## 1. search: http://climate.weather.gc.ca/historical_data/search_historic_data_e.html
## 2. specify station as containing 'vancouver harbour'
## 3. select 'daily', select 'year'
## 4. 'Go' goes to a page to access results for year
## 5. Downoald as csv
## 6. Save with 'van-hrbr-weather-' prepended (in GDrive > Data)

## load weather data
yr_start <- 1998
yr_end <- 2018

## weather file name in form
## van-hrbr-weather-eng-daily-01012018-12312018.csv
##vw1 <- read.csv("~/../Google Drive/Data/van-hrbr-weather-eng-daily-01012018-12312018.csv", skip=25, header = TRUE)

yr_start <- 2002
yr_end <- 2018

vw.all <- data.frame()
yr_data <- yr_start

for(yr in 1:yr_end-yr_start){
fname <- paste0("~/../Google Drive/Data/van-hrbr-weather-eng-daily-0101",yr_data,"-1231",yr_data,".csv")
if(yr_data>2017){ ## starting in 2018, heading info in csv file has extra row
vw <- read.csv(fname, skip=25, header = TRUE)
} else {
  vw <- read.csv(fname, skip=24, header = TRUE)
}
vw.all <- rbind(vw.all, vw)
yr_data <- yr_data+1
}
table(vw.all$Year)

## save results
write.csv(vw.all, "input/van-hrbr-weather.csv", row.names = FALSE)
