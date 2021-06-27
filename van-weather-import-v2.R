## UPDATE WEATHER DATA FROM SOURCE
## climate.weather.gc.ca/historical-data -> details below
## SIMPLIFIED VERSION FOR QUICK UPDATING DURING CURRENT YR - van-weather-import.R has full version
## check summary on Date (code below) to ensure most recent data obtained

library(tidyverse)
library(lubridate)
library(googledrive)

## SETUP FUNCTIONS ####

## fetch station data based on station name and year, save, return
fStn_data <- function(stn, yr_data){
  ## get stn info
  stn_info <- read_csv('input/1-van-weather-stations.csv')
  ## get stn id from name
  stn_id <- stn_info %>% filter(name==stn) %>% select(id)
  ## clean stn name for inclusion in file save name
  stn_clean <- str_replace_all(stn," ","_")
  stn_clean <- str_replace_all(stn_clean,"'","")
  ## year for data -> get data for entire yr specified (will include dates in future to end of yr)
  data_url <- paste0("http://climate.weather.gc.ca/climate_data/bulk_data_e.html?format=csv&stationID=",
                     stn_id[[1]],
                     "&Year=",
                     yr_data,"&Month=12&Day=31&timeframe=2&submit=Download+Data")
  ## DOWNLOAD and SAVE data file 
  ## 1. specify save location/name 
  file_save_url <- paste0("input/",
                          stn_clean,"_weather-eng-daily-0101",yr_data,"-1231",yr_data,".csv")
  ## 2. download/save
  download.file(url=data_url, destfile = file_save_url)
  
  ## 3. import file back into R - skip heading rows
  vw.new_stn <- read_csv(file_save_url)
  vw.new_stn$Month <- as.numeric(vw.new_stn$Month)
  vw.new_stn$Day <- as.numeric(vw.new_stn$Day)
  vw.new_stn$Stn <- stn
  return(vw.new_stn)
}



## clean up station data
fVw_stn_clean <- function(vw.new_stn){
  ## first RENAME - using col references because awkward naming/symbols
  vw.new2 <- vw.new_stn %>%
    rename(Date=`Date/Time`)
  colnames(vw.new2)[10] <- "Max.Temp"
  colnames(vw.new2)[12] <- "Min.Temp"
  colnames(vw.new2)[14] <- "Mean.Temp"
  colnames(vw.new2)[24] <- "Total.Precip"
  ## SELECT
  vw.new.sel <- vw.new2 %>% select(Stn, Date, Year, Month, Day,
                                   Max.Temp, Min.Temp, Mean.Temp,
                                   Total.Precip)
  ## drop empty rows after most recent date
  vw.new.sel.backup <- vw.new.sel
  vw.new.sel <- vw.new.sel %>% filter(Date<=Sys.Date()-1)
  ## return
  return(vw.new.sel)
}

## START DATA COLLECTION ####

## Get data for selected station - using function above
stn <- 'VANCOUVER HARBOUR CS'
yr_data <- year(Sys.Date())
## run data function
vw.new_stn <- fStn_data(stn, yr_data)
## run cleaning function
vw.new_stn_clean <- fVw_stn_clean(vw.new_stn)

## NAs ####
## if there are NA check for other station
## check NAs for key cols ()
any(is.na(vw.new_stn_clean)[,c('Max.Temp', 'Min.Temp', 'Mean.Temp', 'Total.Precip')])
if(any(is.na(vw.new_stn_clean)[,c('Max.Temp', 'Min.Temp', 'Mean.Temp', 'Total.Precip')])){
  vw.new_stn_clean[!complete.cases(vw.new_stn_clean),]
} else {
  print("no key data missing")
}

## old ////// ####
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
## drop empty rows after most recent date
vw.new.sel.backup <- vw.new.sel
vw.new.sel <- vw.new.sel %>% filter(Date<=Sys.Date())



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

