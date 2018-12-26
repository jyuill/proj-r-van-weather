## VANCOUVER WEATHER ANALYSIS

library(tidyverse)

## IMPORT saved data ####
vw.data <- read_csv(
  "input/van-hrbr-weather.csv"
)

## CHECK out data structure ####
str(vw.data)

## SELECT columns of interest ####
vw.data.sel <- vw.data %>% select(
  Year,
  Month,
  Day,
  `Max.Temp..<c2>.C.`,
  `Min.Temp..<c2>.C.`,
  `Mean.Temp..<c2>.C.`,
  `Total.Precip..mm.`
)
## CLEAN up names ####
vw1 <- vw.data.sel %>% rename(
  Max.Temp=`Max.Temp..<c2>.C.`,
  Min.Temp = `Min.Temp..<c2>.C.`,
  Mean.Temp = `Mean.Temp..<c2>.C.`,
  Total.Precip=`Total.Precip..mm.`
)
## specify data frame to keep things clean
vw1 <- data.frame(vw1)

## Change Year, Month, Day to Factors
vw1$Year <- as.factor(vw1$Year)
vw1$Month <- as.factor(vw1$Month)
vw1$Day <- as.factor(vw1$Day)

## Xmas: December 25 analysis ####
vw1.x <- vw1 %>% filter(Month==12, Day==25)

## warmest Xmas days
top_n(vw1.x, 5, Max.Temp) %>% arrange(desc(Max.Temp))
#vw1.x %>% arrange(desc(Max.Temp))
## coldest days
top_n(vw1.x, -5, Min.Temp) %>% arrange(Min.Temp)

ggplot(vw1.x, aes(x=Year, y=Mean.Temp))+geom_col()

ggplot(vw1.x, aes(x=Year, y=Mean.Temp, group=1, color="Mean"))+geom_line()+
  geom_line(aes(y=Max.Temp, color="Max"))+
  geom_line(aes(y=Min.Temp, color="Min"))

## MONTHLY precipitation ####
## Monthly precipitation data
vw.precip.mth <- vw1 %>% group_by(Month) %>%
  summarize(ave_precip=mean(Total.Precip, na.rm=TRUE))
## Ave precip by month ####
ggplot(vw.precip.mth, aes(x=Month, y=ave_precip))+geom_col()
## Ave precip by month in order
ggplot(vw.precip.mth, aes(x=reorder(Month, -ave_precip), y=ave_precip))+geom_col()

## Distribution of precipitation by month
## Monthly precipitation for each month, each year
vw.precip.mth.yr <- vw1 %>% group_by(Year, Month) %>%
  summarize(ttl_precip=sum(Total.Precip, na.rm=TRUE))
## Range in precipitation by month ####
ggplot(vw.precip.mth.yr, aes(x=Month, y=ttl_precip))+geom_boxplot()

## add ref line for Nov 2018 and Dec 2018 ####
vw.precip.11.2018 <- vw.precip.mth.yr %>% filter(Year==2018 & Month==11)
vw.11 <- vw.precip.11.2018['Year'==2018 & 'Month'=='11',]
vw.precip.12.2018 <- vw.precip.mth.yr %>% filter(Year==2018 & Month==12)
## Range by month with Nov 2018 ref line
ggplot(vw.precip.mth.yr, aes(x=Month, y=ttl_precip))+geom_boxplot()+
  geom_hline(yintercept=vw.precip.11.2018[[3]])

### NOVEMBER RAIN ####
## rank novembers
vw.precip.11 <- vw.precip.mth.yr %>% filter(Month=='11') %>%
  arrange(desc(ttl_precip))
vw.precip.11.top <- vw.precip.11[1:10,]
ggplot(vw.precip.11.top, aes(x=Year, y=ttl_precip))+geom_bar(stat='identity')

## distribution of nov rain
ggplot(vw.precip.11, aes(x=ttl_precip))+geom_histogram(binwidth=100)+
  geom_vline(xintercept=vw.precip.11.2018[[3]]) ## add ref line for Nov 2018

## get percentiles for Novembers
vw.precip.11.pc <- vw.precip.11 %>% ungroup() %>% arrange(ttl_precip) %>%
  #mutate(precip.pc=quantile(ttl_precip))
  mutate(precip.rank=rank(ttl_precip),
         precip.pc=precip.rank/max(precip.rank))


# vw.precip.11.2 <- vw.precip.mth.yr %>% filter(Month=='11') %>%
#  top_n(10)
  
ggplot(vw.precip.11, aes(x=))

## average daily rain in each month

## number of days with rain>0 mm

