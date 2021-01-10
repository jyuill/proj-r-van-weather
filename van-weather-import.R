## UPDATE WEATHER DATA FROM SOURCE
## climate.weather.gc.ca/historical-data -> details below
## if previous update was in same year as current, can run Source
## check summary on Date (code below) to ensure most recent data obtained

library(tidyverse)
library(googledrive)
#library(httr)

### FULL MANUAL VERSION - skip to SHORTCUT section below for DIRECT DOWNLOAD ####
## weather data from: (skip 4a below to go straight to Van harbour download page)
## 1. search: http://climate.weather.gc.ca/historical_data/search_historic_data_e.html
## 2. specify desired station:
###   - originally used 'vancouver harbour' but issues cropped up
###   - can enter 'vancouver' in form to find stations -> many attractive-looking options BUT
###   - only VANCOUVER INTL A has reliable data (preceded by VANCOUVER INT'L A in 2013)
###   - info in 'input/1-van-weather-stations.csv'
## 3. select 'daily', select 'year'
## 4. 'Go' goes to a page to access results for year
## 4a. SHORTCUT TO VANCOUVER HARBOUR FOR GIVEN YEAR
#yr <- 2018
#paste0("http://climate.weather.gc.ca/climate_data/daily_data_e.html?hlyRange=1976-01-20%7C2018-12-27&dlyRange=1925-11-01%7C2018-12-27&mlyRange=1925-01-01%7C2007-02-01&StationID=888&Prov=BC&urlExtension=_e.html&searchType=stnName&optLimit=yearRange&StartYear=1840&EndYear=2018&selRowPerPage=25&Line=0&searchMethod=contains&Month=12&Day=27&txtStationName=vancouver+harbour&timeframe=2&Year=",yr)
## Copy from console into browser
## 5. Download as csv
## 6. Save with 'van-hrbr-weather-' prepended (in GDrive > Data)

## START DATA COLLECTION /////////////////////////////////////////////////////
## SET PARAMETERS ####
## STATION 
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
## if current yr (or any single yr) set start and end to current yr
yr_start <- 2021
yr_end <- 2021

## DATA COLLECTION LOOP #### 
## empty data frame to hold data from each loop cycle
vw_all_yrs <- data.frame()
yr_data <- yr_start

## LOOP ####
## - loop through each yr, get all available data for SPECIFIED YR, one yr at a time
## - should probably be WHILE but this works ;)
for(y in 1:(yr_end-yr_start+1)){
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
## FILE STRUCTURE CHG OCT 2019
#vw.new <- read_csv(file_save_url, skip=25)
## NEW DATA STRUCTURE DOESN'T NEED SKIP
vw.new <- read_csv(file_save_url)
vw.new$Month <- as.numeric(vw.new$Month)
vw.new$Day <- as.numeric(vw.new$Day)

## SUMMARY: check imported data ####
summary(vw.new)
str(vw.new)
head(vw.new)

## CHECK NA ####
## check NAs for key cols ()
any(is.na(vw.new)[,c(5,10,12,14,20,24)])
if(any(is.na(vw.new)[,c(5,10,12,14,20,24)])){
  print("missing max temp")
  print(vw.new[which(is.na(vw.new[10])),c(5,10,12,14,20,24)])
  print("missing min temp")
  print(vw.new[which(is.na(vw.new[12])),c(5,10,12,14,20,24)])
  print("missing total precip")
  print(vw.new[which(is.na(vw.new[24])),c(5,10,12,14,20,24)])
} else {
  print("no key data missing")
}

## CHARTS: check imported data ####
## bar chart of max temp (colnames changed to be easier to work with)
vw.new2 <- vw.new %>%
  rename(date=`Date/Time`)
colnames(vw.new2)[10] <- "maxtemp"
colnames(vw.new2)[12] <- 'mintemp'
colnames(vw.new2)[14] <- 'meantemp'

## full current year: maxtemp
ggplot(vw.new2, aes_string(x="date", y="maxtemp"))+geom_bar(stat='identity')
## full yr: precip
ggplot(vw.new2, aes(x=date, y=`Total Precip (mm)`))+geom_bar(stat='identity')

## most recent week
vw.latest.wk <- vw.new2 %>% filter(date>Sys.Date()-8 & date<Sys.Date())
vw.latest.wk <- tail(vw.new2, n=7)
## bar chart max temp
ggplot(vw.latest.wk, aes_string(x="date", y="maxtemp"))+
  geom_bar(stat='identity')+
  scale_y_continuous(expand=c(0,0))+
  scale_x_date(date_breaks='1 day')+
  theme_classic()+
  theme(axis.text.x = element_text(angle=25, vjust=1, hjust=1))
## precip
ggplot(vw.latest.wk, aes(x=date, y=`Total Precip (mm)`))+
  geom_bar(stat='identity')+
  scale_y_continuous(expand=c(0,0))+
  scale_x_date(date_breaks='1 day')+
  theme_classic()+
  theme(axis.text.x = element_text(angle=25, vjust=1, hjust=1))

## line chart
## temp
ggplot(vw.latest.wk, aes(x=date, y=mintemp, color='min'))+geom_line()+
  geom_line(aes(y=meantemp, color='mean'), size=1.2)+
  geom_line(aes(y=maxtemp, color='max'))+
  scale_x_date(date_breaks='1 day')+
  theme_classic()+
  theme(axis.text.x = element_text(angle=25, vjust=1, hjust=1))
## SELECT columns of interest ####
#vw.new.sel <- vw.new[,c(1,2,3,4,6,8,10,20)]
vw.new.sel <- vw.new2 %>% select(date, Year, Month, Day,
                                 maxtemp, mintemp, meantemp,
                                 `Total Precip (mm)`)
## CLEAN up col names ####
#colnames(vw.new.sel)[c(1,5,6,7,8)] <- c('Date','Max.Temp', 'Min.Temp', 'Mean.Temp', 'Total.Precip')
vw.new.sel <- vw.new.sel %>% rename(
  Date=date,
  Max.Temp=maxtemp,
  Min.Temp=mintemp,
  Mean.Temp=meantemp,
  Total.Precip=`Total Precip (mm)`
)
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

## SAVE yr_data from loop ####
write_csv(vw.new.sel, paste0("output/",stn_clean,"-weather-",yr_data,".csv"))

## BIND with prev data in loop####
vw_all_yrs <- bind_rows(vw_all_yrs, vw.new.sel)

## indicate yr completed for progress/debugging
cat(paste0("Collected: ", yr_data,"\n"))

## add to yr var for next yr 
yr_data <- yr_data+1

} ## END DATA COLLECTION LOOP ####
## /////////////////////////////////////////////////

## check dates
summary(vw_all_yrs$Date)
vw_all_yrs <- vw_all_yrs %>% filter(!is.na(Date))

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

## check dates
summary(vw.all$Date)

## test for duplicated dates
table(duplicated(vw.all$Date))

## SAVE ####
write_csv(vw.all, paste0("output/",stn_clean,"-weather.csv"))
write_csv(vw.all, paste0("output/",stn_clean,max(vw.all$Date),"-weather.csv"))
## save simple without station name in title
write_csv(vw.all, "output/van-weather.csv")
write_csv(vw.all, paste0("output/van-weather_",max(vw.all$Date),".csv"))

## END UPDATE ###################################
