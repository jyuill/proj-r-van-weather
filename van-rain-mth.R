
library(tidyverse)

## import saved data
vw.data <- read_csv(
  "input/van-hrbr-weather.csv"
)


str(vw.data)
table(vw.data$Total.Rain.Flag)
head(vw.data$Total.Rain.Flag)
vw.data %>% distinct(Total.Rain.Flag)

## monthly precipitation
vw.precip.mth <- vw.data %>% group_by(Month) %>%
  summarize(ave_precip=mean(Total.Precip..mm., na.rm=TRUE))

ggplot(vw.precip.mth, aes(x=Month, y=ave_precip))+geom_col()

vw.precip.mth.yr <- vw.data %>% group_by(Year, Month) %>%
  summarize(ttl_precip=sum(Total.Precip..mm., na.rm=TRUE))
vw.precip.mth.yr$Month <- as.factor(vw.precip.mth.yr$Month)

ggplot(vw.precip.mth.yr, aes(x=Month, y=ttl_precip))+geom_boxplot()

## add ref line for Nov 2018 and Dec 2018
vw.precip.11.2018 <- vw.precip.mth.yr %>% filter(Year==2018 & Month==11)
vw.11 <- vw.precip.11.2018['Year'==2018 & 'Month'=='11',]
vw.precip.12.2018 <- vw.precip.mth.yr %>% filter(Year==2018 & Month==12)
ggplot(vw.precip.mth.yr, aes(x=Month, y=ttl_precip))+geom_boxplot()+
  geom_hline(yintercept=vw.precip.11.2018[[3]])

## rank novembers
vw.precip.11 <- vw.precip.mth.yr %>% filter(Month=='11') %>%
  arrange(desc(ttl_precip))
vw.precip.11.top <- vw.precip.11[1:10,]
ggplot(vw.precip.11.top, aes(x=Year, y=ttl_precip))+geom_bar(stat='identity')

# vw.precip.11.2 <- vw.precip.mth.yr %>% filter(Month=='11') %>%
#  top_n(10)
  
ggplot(vw.precip.11, aes(x=))

## average daily rain in each month

## number of days with rain>0 mm

