## UPDATE WEATHER DATA FROM SOURCE
## climate.weather.gc.ca/historical-data -> details below
## if previous update was in same year as current, can run Source
## check summary on Date (code below) to ensure most recent data obtained

library(tidyverse)
#library(httr)

### FULL MANUAL VERSION - skip to SHORTCUT section below for DIRECT DOWNLOAD ####
## weather data from: (skip 4a below to go straight to Van harbour download page)
## 1. search: http://climate.weather.gc.ca/historical_data/search_historic_data_e.html
## 2. specify station as containing 'vancouver harbour'
## 3. select 'daily', select 'year'
## 4. 'Go' goes to a page to access results for year
## 4a. SHORTCUT TO VANCOUVER HARBOUR FOR GIVEN YEAR
#yr <- 2018
#paste0("http://climate.weather.gc.ca/climate_data/daily_data_e.html?hlyRange=1976-01-20%7C2018-12-27&dlyRange=1925-11-01%7C2018-12-27&mlyRange=1925-01-01%7C2007-02-01&StationID=888&Prov=BC&urlExtension=_e.html&searchType=stnName&optLimit=yearRange&StartYear=1840&EndYear=2018&selRowPerPage=25&Line=0&searchMethod=contains&Month=12&Day=27&txtStationName=vancouver+harbour&timeframe=2&Year=",yr)
## Copy from console into browser
## 5. Download as csv
## 6. Save with 'van-hrbr-weather-' prepended (in GDrive > Data)

### SHORTCUT VERSION -> DIRECT DOWNLOAD ####
## 1. Generate URL that matches Vancouver Harbour download page for specified year:
## year for data
yr <- 2019
## data url
data_url <- paste0("http://climate.weather.gc.ca/climate_data/bulk_data_e.html?format=csv&stationID=888&Year=",yr,"&Month=12&Day=1&timeframe=2&submit=Download+Data")
## destination to save file
file_save_url <- paste0("~/../Google Drive/Data/van-hrbr-weather-eng-daily-0101",yr,"-1231",yr,".csv")
## download and save file
download.file(url=data_url, destfile = file_save_url)
## import file into R - skip heading rows
vw.new <- read_csv(file_save_url, skip=25)
vw.new$Month <- as.numeric(vw.new$Month)
vw.new$Day <- as.numeric(vw.new$Day)

## SUMMARY: check imported data ####
summary(vw.new)
str(vw.new)
head(vw.new)

## CHARTS: check imported data ####
## bar chart of max temp (colnames changed to be easier to work with)
vw.new2 <- vw.new %>%
  rename(date=`Date/Time`)
colnames(vw.new2)[6] <- "maxtemp"
colnames(vw.new2)[8] <- 'mintemp'
colnames(vw.new2)[10] <- 'meantemp'
## full current year: maxtemp
ggplot(vw.new2, aes_string(x="date", y="maxtemp"))+geom_bar(stat='identity')

## most recent week
vw.latest.wk <- vw.new2 %>% filter(date>Sys.Date()-8 & date<Sys.Date())
## bar chart max temp
ggplot(vw.latest.wk, aes_string(x="date", y="maxtemp"))+
  geom_bar(stat='identity')+
  scale_y_continuous(expand=c(0,0))+
  scale_x_date(date_breaks='1 day')+
  theme_classic()+
  theme(axis.text.x = element_text(angle=25, vjust=1, hjust=1))
## line chart
ggplot(vw.latest.wk, aes(x=date, y=mintemp, color='min'))+geom_line()+
  geom_line(aes(y=meantemp, color='mean'), size=1.2)+
  geom_line(aes(y=maxtemp, color='max'))+
  scale_x_date(date_breaks='1 day')+
  theme_classic()+
  theme(axis.text.x = element_text(angle=25, vjust=1, hjust=1))

## SELECT columns of interest ####
vw.new.sel <- vw.new[,c(1,2,3,4,6,8,10,20)]
## CLEAN up col names ####
colnames(vw.new.sel)[c(1,5,6,7,8)] <- c('Date','Max.Temp', 'Min.Temp', 'Mean.Temp', 'Total.Precip')
## drop empty rows at end
vw.new.sel.last <- vw.new.sel %>% filter(!is.na(Max.Temp), !is.na(Min.Temp), !is.na(Mean.Temp)) %>%
  filter(Date==max(Date))
vw.new.sel <- vw.new.sel %>% filter(Date<=vw.new.sel.last[[1]])
## apply season values
seasons.mth <- read_csv('input/seasons.csv')
vw.new.sel <- left_join(seasons.mth, vw.new.sel, by='Month')
## set season yr: Dec falls into Winter of following yr
vw.new.sel <- vw.new.sel %>% mutate(
  Season.Yr=ifelse(Month==12,Year+1,Year))

## UPDATE EXISTING DATA WITH NEW ####
## Load existing data
vw.exist <- read_csv("input/van-hrbr-weather.csv")
# vw.exist <- vw.exist %>% mutate(
#   Season.Yr=ifelse(Month==12,Year+1,Year))
#vw.exist.ws <- vw.exist %>% filter(Month==1, Season=='Winter')
#vw.exist <- vw.exist %>% select(1,2,Season.Yr,3:9)
## determine most recent data for existing data
## this looks circular: determine most recent date then filter for
## everything before most recent date? maybe some cleanup?
vw.recent <- vw.exist %>% filter(!is.na(Max.Temp)) %>% 
  filter(Date==max(Date))
vw.exist <- vw.exist %>% filter(Date<=vw.recent$Date[1])

## SELECT dates past existing from new data set####
vw.latest <- vw.new.sel %>% filter(Date>vw.recent$Date[1])

## BIND NEW to existing ####
vw.all <- bind_rows(vw.exist, vw.latest)
summary(vw.all$Date)

## test for duplicated dates
table(duplicated(vw.all$Date))

## huge bar chart of number of observations by month and by year
# ggplot(vw.all, aes(x=Month))+
#   geom_bar()+
#   facet_grid(Year~.)

## SAVE ####
write.csv(vw.all, "input/van-hrbr-weather.csv", row.names = FALSE)
write_csv(vw.all, paste0("input/van-hrbr-weather_",Sys.Date(),".csv"))


###\\\\\\\\\\\\\\\\\\\\
## LOOP FOR MULTIPLE YEARS OF HISTORICAL DATA ####
yr_start <- 1988
yr_end <- 1998

vw.all <- data.frame()
yr_data <- yr_start

for(y in 1:(yr_end-yr_start)){
#fname <- paste0("~/../Google Drive/Data/van-hrbr-weather-eng-daily-0101",yr_data,"-1231",yr_data,".csv")
  data_url <- paste0("http://climate.weather.gc.ca/climate_data/bulk_data_e.html?format=csv&stationID=888&Year=",yr_data,"&Month=12&Day=1&timeframe=2&submit=Download+Data")
  ## destination to save file
  file_save_url <- paste0("~/../Google Drive/Data/van-hrbr-weather-eng-daily-0101",yr_data,"-1231",yr_data,".csv")
  ## download and save file
  download.file(url=data_url, destfile = file_save_url)
  
if(yr_data>2017){ ## starting in 2018, heading info in csv file has extra row
vw <- read_csv(file_save_url, skip=25)
} else {
  vw <- read.csv(file_save_url, skip=24, header = TRUE)
}
vw.all <- rbind(vw.all, vw)
yr_data <- yr_data+1
}
table(vw.all$Year)

## SELECT columns of interest ####
vw.all.sel <- vw.all[,c(1,2,3,4,6,8,10,20)]
## CLEAN up col names ####
colnames(vw.all.sel)[c(1,5,6,7,8)] <- c('Date','Max.Temp', 'Min.Temp', 'Mean.Temp', 'Total.Precip')
## Set Date format
vw.all.sel$Date <- as.Date(vw.all.sel$Date)
## drop empty rows at end
vw.all.sel.last <- vw.all.sel %>% filter(!is.na(Max.Temp), !is.na(Min.Temp), !is.na(Mean.Temp)) %>%
  filter(Date==max(Date))
vw.all.sel <- vw.all.sel %>% filter(Date<=vw.all.sel.last[[1]])
## apply season values
seasons.mth <- read_csv('input/seasons.csv')
vw.all.sel <- left_join(seasons.mth, vw.all.sel, by='Month')
## set season yr: Dec falls into Winter of following yr
vw.all.sel <- vw.all.sel %>% mutate(
  Season.Yr=ifelse(Month==12,Year+1,Year))

## Import existing data
vw.exist <- read_csv("input/van-hrbr-weather.csv")

## BIND to existing ####
vw.all.exist <- bind_rows(vw.all.sel, vw.exist)

# ## specify data frame to keep things clean
vw1 <- data.frame(vw.all.exist)

## check data
#summary(vw1)
#ggplot(vw1, aes(x=Date, y=Mean.Temp))+geom_line()

# # ## save results
#write.csv(vw1, "input/van-hrbr-weather.csv", row.names = FALSE)

