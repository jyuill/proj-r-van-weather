## WRAPPER TO RUN MAIN UPDATES CONVENIENTLY ##

## get fresh data
source('van-weather-import-v2.R')
## update main markdown analysis with new data
knitr::knit2html('van-weather-report.Rmd')
## update flexdashboard with new data 
rmarkdown::render("van-weather-dashboard.Rmd", output_format = flex_dashboard())
## copy examples over to portfolio website (on Macbook)
source('save-Rmd-portfolio-site.R')
