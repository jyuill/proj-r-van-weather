
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

## Test weather file name in form ####
## van-hrbr-weather-eng-daily-01012018-12312018.csv
##vw1 <- read.csv("~/../Google Drive/Data/van-hrbr-weather-eng-daily-01012018-12312018.csv", skip=25, header = TRUE)

## UPDATE EXISTING DATA WITH NEW ####
## Load existing data
vw.exist <- read_csv("input/van-hrbr-weather.csv")
## determine most recent data for existing data
vw.recent <- vw.exist %>% filter(!is.na(Max.Temp)) %>% filter(Date==max(Date))

## Get new, updated data
## 
yr_data <- 2018
fname <- paste0("~/../Google Drive/Data/van-hrbr-weather-eng-daily-0101",yr_data,"-1231",yr_data,".csv")
vw.new <- read.csv(fname, skip=25)

## CLEAN Dates
vw.new <- vw.new %>% mutate(Date=paste(Year, Month, Day, sep="-"))
vw.new$Date <- as.Date(vw.new$Date)

## SELECT columns of interest ####
vw.data.sel <- vw.new[,c(28,2,3,4,6,8,10,20)]
colnames(vw.data.sel)[c(5,6,7,8)] <- c('Max.Temp', 'Min.Temp', 'Mean.Temp', 'Total.Precip.mm')


## CLEAN up names ####
vw1 <- vw.data.sel %>% rename(
  Max.Temp=`Max.Temp..<c2>.C.`,
  Min.Temp = `Min.Temp..<c2>.C.`,
  Mean.Temp = `Mean.Temp..<c2>.C.`,
  Total.Precip=`Total.Precip..mm.`
)
## specify data frame to keep things clean
vw1 <- data.frame(vw1)

## SELECT dates past existing ####

## BIND NEW to existing ####

## SAVE ####

###\\\\\\\\\\\\\\\\\\\\
## LOOP FOR MULTIPLE YEARS OF HISTORICAL DATA ####
# yr_start <- 2002
# yr_end <- 2018
# 
# vw.all <- data.frame()
# yr_data <- yr_start
# 
# for(yr in 1:yr_end-yr_start){
# fname <- paste0("~/../Google Drive/Data/van-hrbr-weather-eng-daily-0101",yr_data,"-1231",yr_data,".csv")
# if(yr_data>2017){ ## starting in 2018, heading info in csv file has extra row
# vw <- read.csv(fname, skip=25, header = TRUE)
# } else {
#   vw <- read.csv(fname, skip=24, header = TRUE)
# }
# vw.all <- rbind(vw.all, vw)
# yr_data <- yr_data+1
# }
# table(vw.all$Year)

## CLEAN up Dates
# vw.all <- vw.all %>% mutate(Date=paste(Year, Month, Day, sep="-"))
# vw.all$Date <- as.Date(vw.all$Date)
# 
# ## SELECT columns of interest ####
# vw.data.sel <- vw.all %>% select(
#   Date,
#   Year,
#   Month,
#   Day,
#   `Max.Temp..<c2>.C.`,
#   `Min.Temp..<c2>.C.`,
#   `Mean.Temp..<c2>.C.`,
#   `Total.Precip..mm.`
# )
# ## CLEAN up names ####
# vw1 <- vw.data.sel %>% rename(
#   Max.Temp=`Max.Temp..<c2>.C.`,
#   Min.Temp = `Min.Temp..<c2>.C.`,
#   Mean.Temp = `Mean.Temp..<c2>.C.`,
#   Total.Precip=`Total.Precip..mm.`
# )
# ## specify data frame to keep things clean
# vw1 <- data.frame(vw1)
# # 
# # ## save results
# write.csv(vw1, "input/van-hrbr-weather.csv", row.names = FALSE)
