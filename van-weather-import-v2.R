## UPDATE WEATHER DATA FROM SOURCE
## climate.weather.gc.ca/historical-data -> details below
## SIMPLIFIED VERSION FOR QUICK UPDATING DURING CURRENT YR - van-weather-import.R has full version
## check summary on Date (code below) to ensure most recent data obtained

library(tidyverse)
library(lubridate)
library(googledrive)

## START DATA COLLECTION /////////////////////////////////////////////////////
## SET PARAMETERS ####
## STATION ####
## need station id; get from saved file
stn_info <- read_csv('input/1-van-weather-stations.csv')
stn <- "VANCOUVER INTL A" ## main current station
#stn <- "VANCOUVER INT'L A" ## for pre-2013 data
## get stn id from name
stn_id <- stn_info %>% filter(name==stn) %>% select(id)
## clean stn name for inclusion in file save name
stn_clean <- str_replace_all(stn," ","_")
stn_clean <- str_replace_all(stn_clean,"'","")
## YEAR
## year for data -> date is set to 12-31 of selected yr; will collect whatever is available
## set start and end to current yr
yr_start <- year(Sys.Date())
yr_end <- year(Sys.Date())
yr_data <- year(Sys.Date())

## 1. Generate URL that identifies station id and date range:
## data url for fetching
data_url <- paste0("http://climate.weather.gc.ca/climate_data/bulk_data_e.html?format=csv&stationID=",
stn_id[[1]],
"&Year=",
yr_data,"&Month=12&Day=31&timeframe=2&submit=Download+Data")

## destination to SAVE file
## save URL
file_save_url <- paste0("input/",
                       stn_clean,"weather-eng-daily-0101",yr_data,"-1231",yr_data,".csv")
## DOWNLOAD and SAVE data file ####
download.file(url=data_url, destfile = file_save_url)

## import file back into R - skip heading rows
vw.new <- read_csv(file_save_url)
vw.new$Month <- as.numeric(vw.new$Month)
vw.new$Day <- as.numeric(vw.new$Day)

## CLEAN-UP: SELECT columns of interest ####
## first RENAME - using col references because awkward naming/symbols
vw.new2 <- vw.new %>%
  rename(Date=`Date/Time`)
colnames(vw.new2)[10] <- "Max.Temp"
colnames(vw.new2)[12] <- "Min.Temp"
colnames(vw.new2)[14] <- "Mean.Temp"
colnames(vw.new2)[24] <- "Total.Precip"
## SELECT
vw.new.sel <- vw.new2 %>% select(Date, Year, Month, Day,
                                 Max.Temp, Min.Temp, Mean.Temp,
                                 Total.Precip)
## drop empty rows at end <- probably better way to determine this
## get latest date where key fields are not all NA
vw.new.sel.last <- vw.new.sel %>% filter(!is.na(Max.Temp), !is.na(Min.Temp), !is.na(Mean.Temp), !is.na(Total.Precip)) %>%
  filter(Date==max(Date))
vw.new.sel <- vw.new.sel %>% filter(Date<=vw.new.sel.last[[1]])
## apply season values
seasons.mth <- read_csv('input/seasons.csv')
vw.new.sel <- left_join(seasons.mth, vw.new.sel, by='Month')
## set season yr: Dec falls into Winter of following yr
vw.new.sel <- vw.new.sel %>% mutate(
  Season.Yr=ifelse(Month==12,Year+1,Year))

## add stn name
vw.new.sel$station <- stn

## SAVE yr_data ####
write_csv(vw.new.sel, paste0("output/",stn_clean,"-weather-",yr_data,".csv"))

## END NEW DATA IMPORT & CLEAN /////////////////////////////////////////////////

## check dates
summary(vw.new.sel$Date)
vw_all_yrs <- vw.new.sel %>% filter(!is.na(Date)) ## legacy df name change for code below

## SAVE all yrs data
write_csv(vw_all_yrs, paste0("output/",stn_clean,"-weather-",min(vw_all_yrs$Year),"-",max(vw_all_yrs$Year),".csv"))

## UPDATE EXISTING DATA WITH NEW ####
## if first time collecting data for stn, save file
## otherwise, append new data to existing file
if(!file.exists(paste0("output/",stn_clean,"-weather.csv"))){
  write_csv(vw_all_yrs, paste0("output/",stn_clean,"-weather.csv"))
  vw.all <- vw_all_yrs
} else {
  ## Load existing data ####
  vw.exist <- read_csv(paste0("output/",stn_clean,"-weather.csv"))
  ## compare MAX date existing with MAX date new
  vw_latest <- vw_all_yrs %>% filter(Date>max(vw.exist$Date))
  ## ADD Latest to existing ####
  vw.all <- bind_rows(vw.exist, vw_latest)
  ## compare MIN data existing with MIN date new
  vw_earliest <- vw_all_yrs %>% filter(Date<min(vw.exist$Date))
  ## ADD earliest BEFORE existing (which is now vw.all)
  vw.all <- bind_rows(vw_earliest, vw.all)
}

## SAVE ####
write_csv(vw.all, paste0("output/",stn_clean,"-weather.csv"))
write_csv(vw.all, paste0("output/",stn_clean,max(vw.all$Date),"-weather.csv"))
## save simple without station name in title
write_csv(vw.all, "output/van-weather.csv")
write_csv(vw.all, paste0("output/van-weather_",max(vw.all$Date),".csv"))

## END UPDATE ###################################

## SUMMARIZE ####
## check dates
summary(vw.all$Date)

## test for duplicated dates
table(duplicated(vw.all$Date))

