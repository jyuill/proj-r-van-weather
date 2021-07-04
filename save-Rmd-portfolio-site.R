## SAVE markdown in portfolio site folder for push to github

library(here)

local <- here('van-weather-report.html')
copy_to <- '/Users/jy/Documents/my-web/jyuill.github.io'
file.copy(from=local, to=copy_to, overwrite = TRUE)