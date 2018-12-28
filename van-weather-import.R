
library(tidyverse)
#library(httr)


### FULL VERSION - skip to SHORTCUT section below for DIRECT DOWNLOAD ####
## weather data from: (skip 4a below to go straight to Van harbour download page)
## 1. search: http://climate.weather.gc.ca/historical_data/search_historic_data_e.html
## 2. specify station as containing 'vancouver harbour'
## 3. select 'daily', select 'year'
## 4. 'Go' goes to a page to access results for year
## 4a. SHORTCUT TO VANCOUVER HARBOUR FOR GIVE YEAR
yr <- 2018
paste0("http://climate.weather.gc.ca/climate_data/daily_data_e.html?hlyRange=1976-01-20%7C2018-12-27&dlyRange=1925-11-01%7C2018-12-27&mlyRange=1925-01-01%7C2007-02-01&StationID=888&Prov=BC&urlExtension=_e.html&searchType=stnName&optLimit=yearRange&StartYear=1840&EndYear=2018&selRowPerPage=25&Line=0&searchMethod=contains&Month=12&Day=27&txtStationName=vancouver+harbour&timeframe=2&Year=",yr)
## Copy from console into browser
## 5. Download as csv
## 6. Save with 'van-hrbr-weather-' prepended (in GDrive > Data)

### SHORTCUT VERSION -> DIRECT DOWNLOAD ####
## 1. Generate URL that matches Vancouver Harbour download page for specified year:
## year for data
yr <- 2018
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

## SELECT columns of interest ####
vw.new.sel <- vw.new[,c(1,2,3,4,6,8,10,20)]
## CLEAN up col names ####
colnames(vw.new.sel)[c(1,5,6,7,8)] <- c('Date','Max.Temp', 'Min.Temp', 'Mean.Temp', 'Total.Precip.mm')
## drop empty rows at end
vw.new.sel.last <- vw.new.sel %>% filter(!is.na(Max.Temp), !is.na(Min.Temp), !is.na(Mean.Temp)) %>%
  filter(Date==max(Date))
vw.new.sel <- vw.new.sel %>% filter(Date<=vw.new.sel.last[[1]])

## UPDATE EXISTING DATA WITH NEW ####
## Load existing data
vw.exist <- read_csv("input/van-hrbr-weather.csv")
## determine most recent data for existing data
vw.recent <- vw.exist %>% filter(!is.na(Max.Temp)) %>% filter(Date==max(Date))
vw.exist <- vw.exist %>% filter(Date<=vw.recent[[1]])

## SELECT dates past existing from new data set####
vw.latest <- vw.new.sel %>% filter(Date>vw.recent[[1]])

## BIND NEW to existing ####
vw.all <- bind_rows(vw.exist, vw.latest)
summary(vw.all$Date)

## SAVE ####
write.csv(vw.all, "input/van-hrbr-weather.csv", row.names = FALSE)

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
