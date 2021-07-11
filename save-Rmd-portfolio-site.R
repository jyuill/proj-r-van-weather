## SAVE markdown in portfolio site folder for push to github

library(here)

## main markdown
local <- here('van-weather-report.html')
copy_to <- '/Users/jy/Documents/my-web/jyuill.github.io'
file.copy(from=local, to=copy_to, overwrite = TRUE)

## processed data
local <- here('output','van-weather.csv')
copy_to <- '/Users/jy/Documents/my-web/jyuill.github.io/data'
file.copy(from=local, to=copy_to, overwrite = TRUE)

## flexdashboard
local <- here('van-weather-dashboard.html')
copy_to <- '/Users/jy/Documents/my-web/jyuill.github.io'
file.copy(from=local, to=copy_to, overwrite = TRUE)