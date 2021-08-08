## WRAPPER TO RUN MAIN UPDATES CONVENIENTLY ##

## get fresh data
source('van-weather-import-v2.R')
## update main markdown analysis with new data
knitr::knit2html('van-weather-report.Rmd')
## update flexdashboard with new data -> doesn't work because flexdashboard - need to run directly
knitr::knit("van-weather-dashboard.Rmd")
## copy examples over to portfolio website (on Macbook)
source('save-Rmd-portfolio-site.R')