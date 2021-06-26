## chunks of code previously used in van-weather-import files - needs cleanup

## SUMMARY: check imported data ####
summary(vw.new)
str(vw.new)
head(vw.new)

## CHECK NA ####
## check NAs for key cols ()
vw.new.check <- vw.new %>% filter(`Date/Time`<Sys.Date())
any(is.na(vw.new.check)[,c(5,10,12,14,20,24)])
if(any(is.na(vw.new.check)[,c(5,10,12,14,20,24)])){
  print("missing max temp")
  print(vw.new.check[which(is.na(vw.new.check[10])),c(5,10,12,14,20,24)])
  print("missing min temp")
  print(vw.new.check[which(is.na(vw.new.check[12])),c(5,10,12,14,20,24)])
  print("missing total precip")
  print(vw.new.check[which(is.na(vw.new.check[24])),c(5,10,12,14,20,24)])
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

## full current year to date: maxtemp
vw.new2 %>% filter(date<=Sys.Date()) %>% ggplot(aes(x=date, y=maxtemp))+geom_col()
## full yr to date: precip
vw.new2 %>% filter(date<=Sys.Date()) %>% ggplot(aes(x=date, y=`Total Precip (mm)`))+geom_col()

## most recent week
vw.latest.wk <- vw.new2 %>% filter(date>Sys.Date()-15 & date<Sys.Date())
## bar chart max temp
ggplot(vw.latest.wk, aes(x=date, y=maxtemp))+
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
  theme(axis.text.x = element_text(angle=35, vjust=1, hjust=1))
