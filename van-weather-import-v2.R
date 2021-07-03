## UPDATE WEATHER DATA FROM SOURCE
## climate.weather.gc.ca/historical-data -> details below
## SIMPLIFIED VERSION FOR QUICK UPDATING DURING CURRENT YR - van-weather-import.R has full version
## 1. Fetch existing data for date reference and appending later
## 2. Fetch new data, clean, filter for recent dates not in existing data
##    - based on specified weather station
## 3. Check for Total Precip NAs and if exist, replace with alternate station
## 4. Append new to existing data 
## 5. Save
## check summary on Date (code below) to confirm most recent data obtained

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
  vw.new_stn$Station <- stn
  return(vw.new_stn)
}

## clean up station data
fVw_stn_clean <- function(vw.new_stn, maxD){
  ## first RENAME - using col references because awkward naming/symbols
  vw.new2 <- vw.new_stn %>%
    rename(Date=`Date/Time`)
  colnames(vw.new2)[10] <- "Max.Temp"
  colnames(vw.new2)[12] <- "Min.Temp"
  colnames(vw.new2)[14] <- "Mean.Temp"
  colnames(vw.new2)[24] <- "Total.Precip"
  ## SELECT relevant rows
  vw.new.sel <- vw.new2 %>% select(Date, Year, Month, Day,
                                   Max.Temp, Min.Temp, Mean.Temp,
                                   Total.Precip, Station)
  
  ## apply season values
  seasons.mth <- read_csv('input/seasons.csv')
  vw.new.sel <- left_join(seasons.mth, vw.new.sel, by='Month')
  ## set season yr: Dec falls into Winter of following yr
  vw.new.sel <- vw.new.sel %>% mutate(
    Season.Yr=ifelse(Month==12,Year+1,Year))
  
  ## drop empty rows after most recent date
  ## NEXT!!! -> setup to filter by AFTER existing data BEFORE today
  vw.new.sel.backup <- vw.new.sel
  vw.new.sel <- vw.new.sel %>% filter(Date>maxD & Date<=Sys.Date()-1)
  ## Reorder cols to more intuitive
  vw.new.sel <- vw.new.sel %>% select(Date, Year, Month, Day, Season, Season.Yr,
                                      Max.Temp,
                                      Min.Temp,
                                      Mean.Temp,
                                      Total.Precip,
                                      Station)
  ## return
  return(vw.new.sel)
}

## START DATA COLLECTION ####
## Get existing data to determine what date to start from
van_exist <- read_csv('output/van-weather.csv')
van_exist_maxD <- max(van_exist$Date)

## Get data for selected station - using function above
stn <- 'VANCOUVER INTL A' ## currently mostly reliable station
stn_alt <- 'VANCOUVER HARBOUR CS' ## 2nd most reliable - can be used if precip data missing
yr_data <- year(Sys.Date())
## run data function
vw.new_stn <- fStn_data(stn, yr_data)
## run cleaning function
vw.new_stn_clean <- fVw_stn_clean(vw.new_stn, van_exist_maxD)

## NAs ####
## if there are NA check for other station
## check NAs for precip cols - focus on precip because missing data affects total; 
## - missing temperature data not as significant (probably not significantly affect averages)
any(is.na(vw.new_stn_clean)[,c('Total.Precip')])
## if you want to see all incomplete cases
#vw.new_stn_clean[!complete.cases(vw.new_stn_clean),]
## SUB IN MISSING PRECIP ####
if(any(is.na(vw.new_stn_clean)[,c('Total.Precip')])){
  vw.new_stn_clean[is.na(vw.new_stn_clean$Total.Precip),]
  ## get alternate data to hopefully fill-in precip as approx
  vw.new_stn_alt <- fStn_data(stn_alt, yr_data)
  vw.new_stn_alt_clean <- fVw_stn_clean(vw.new_stn_alt, van_exist_maxD)
  ## substitute missing precip data from other station
  ## create loop based on rows with missing precip data
  na_rows <- which(is.na(vw.new_stn_clean$Total.Precip))
  for(r in 1:length(na_rows)){
    r_date <- vw.new_stn_clean$Date[na_rows[r]]
    r_sub <- vw.new_stn_alt_clean %>% filter(Date==r_date) %>% select(Total.Precip, Station)
    vw.new_stn_clean$Total.Precip[na_rows[r]] <- r_sub[[1]]
    vw.new_stn_clean$Station[na_rows[r]] <- r_sub[[2]]
  }
} else {
  print("no precipitation data missing")
}

## APPEND NEW to OLD ####
vw_all <- bind_rows(van_exist, vw.new_stn_clean)
## SAVE ####
write_csv(vw_all, 'output/van-weather.csv')
write_csv(vw_all, paste0('output/van-weather_',max(vw_all$Date),'.csv'))

## SUMMARIZE/CHECK ####
## check dates
summary(vw_all$Date)

## test for duplicated dates
table(duplicated(vw_all$Date))

## check incomplete cases
#vw_all[!complete.cases(vw_all),]




