## UPDATE WEATHER DATA FROM SOURCE
## climate.weather.gc.ca/historical-data -> details below
## Process ####
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
## > Get existing ####
## Get existing data to determine what date to start from
van_exist <- read_csv('output/van-weather.csv')
van_exist_maxD <- max(van_exist$Date)

## > Set station & yr ####
## Get data for selected station - using function above
stn <- 'VANCOUVER INTL A' ## currently mostly reliable station
stn_alt <- 'VANCOUVER HARBOUR CS' ## 2nd most reliable - can be used if precip data missing
yr_data <- year(Sys.Date())
## > Run data fn ####
vw.new_stn <- fStn_data(stn, yr_data)
## > Run cleaning fn ####
vw.new_stn_clean <- fVw_stn_clean(vw.new_stn, van_exist_maxD)

## NAs ####
## if there are NA check for other station
## check NAs for precip cols - focus on precip because missing data affects total; 
## - missing temperature data not as significant (probably not significantly affect averages)
#any(is.na(vw.new_stn_clean)[,c('Total.Precip')])
## see all incomplete cases
vw.new_stn_na <- vw.new_stn_clean[!complete.cases(vw.new_stn_clean),]

## SUB IN MISSING PRECIP - original
#if(any(is.na(vw.new_stn_clean)[,c('Total.Precip')])){
## SUB IN MISSING TEMP & PRECIP ####
if(any(!complete.cases(vw.new_stn_clean))){
  ## get alternate data to hopefully fill-in precip as approx
  vw.new_stn_alt <- fStn_data(stn_alt, yr_data)
  vw.new_stn_alt_clean <- fVw_stn_clean(vw.new_stn_alt, van_exist_maxD)
  ## substitute missing precip data from other station
  ## create loop based on:
  ## - rows with missing precip data
  #na_rows <- which(is.na(vw.new_stn_clean$Total.Precip))
  ## - based on any missing values
  na_rows <- which(!complete.cases(vw.new_stn_clean))
  for(r in 1:length(na_rows)){
    vw.new_stn_fill <- vw.new_stn_clean[na_rows[r],]
    r_date <- vw.new_stn_clean$Date[na_rows[r]]
    r_sub <- vw.new_stn_alt_clean %>% filter(Date==r_date) 
    ## go through each metric and replace if missing
    ## precip
    vw.new_stn_clean$Total.Precip[na_rows[r]] <- ifelse(
      is.na(vw.new_stn_clean$Total.Precip[na_rows[r]]), r_sub$Total.Precip,
      vw.new_stn_clean$Total.Precip[na_rows[r]])
    ## max temp
    #vw.new_stn_clean$Max.Temp[na_rows[r]] <- r_sub[[2]]
    vw.new_stn_clean$Max.Temp[na_rows[r]] <- ifelse(
      is.na(vw.new_stn_clean$Max.Temp[na_rows[r]]), r_sub$Max.Temp,
      vw.new_stn_clean$Max.Temp[na_rows[r]])
    ## min temp
    #vw.new_stn_clean$Min.Temp[na_rows[r]] <- r_sub[[3]]
    vw.new_stn_clean$Min.Temp[na_rows[r]] <- ifelse(
      is.na(vw.new_stn_clean$Min.Temp[na_rows[r]]), r_sub$Min.Temp,
      vw.new_stn_clean$Min.Temp[na_rows[r]])
    ## mean temp
    #vw.new_stn_clean$Mean.Temp[na_rows[r]] <- r_sub[[4]]
    vw.new_stn_clean$Mean.Temp[na_rows[r]] <- ifelse(
      is.na(vw.new_stn_clean$Mean.Temp[na_rows[r]]), r_sub$Mean.Temp,
      vw.new_stn_clean$Mean.Temp[na_rows[r]])
    ## station - how to attribute data when potentially mixed?
    vw.new_stn_filled <- vw.new_stn_clean[na_rows[r],]
    ## if there's data now where used to be NA -> should acknowledge alt station
    ## if: any NAs in pre-filled match non-NA in filled, then new data
    ##     identify alt station with '*' indicating some/all data from that station
    if(any(is.na(vw.new_stn_fill[,7:10])==!is.na(vw.new_stn_filled[,7:10]))){
      vw.new_stn_clean$Station[na_rows[r]] <- paste0(r_sub$Station,"*")
    } ## end station
  }
} else {
  print("no temp or precipitation data missing")
}
## compare na set to filled set
vw_fill_dates <- vw.new_stn_na %>% select(Date)
vw.new_stn_na
left_join(vw_fill_dates, vw.new_stn_clean, by='Date')

## APPEND NEW to OLD ####
vw_all <- bind_rows(van_exist, vw.new_stn_clean)
## > NA: recent rows ####
#vw_all %>% filter((is.na(Max.Temp)|is.na(Min.Temp)|is.na(Mean.Temp)) & Year>=2017)
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




