## copying data into Shiny folder for access
## - only needs to be done once after each data update
## processed data
library(here)
local <- here('output','van-weather.csv')
copy_to <- here('Van-weather-app')
file.copy(from=local, to=copy_to, overwrite = TRUE)
