## Set up data frame with seasons for merging with main data

library(tidyverse)

## match month with season -> my personal assessment ;)
## Winter = Dec, Jan, Feb
## Sprint = Mar, Apr, May
## Summer = Jun, Jul, Aug
## Fall = Sep, Oct, Nov
df.seasons <- data.frame(Month=c(1,2,3,4,5,6,7,8,9,10,11,12),
                         Season=c("Winter","Winter",
                                  "Spring","Spring","Spring",
                                  "Summer","Summer","Summer",
                                  "Fall","Fall","Fall",
                                  "Winter"))
## save result for merging with collected data in van-weather-import.R
write_csv(df.seasons, 'input/seasons.csv')
