## WRAPPER TO RUN MAIN UPDATES CONVENIENTLY ##

## get fresh data
source('van-weather-import-v2.R')
## update main markdown analysis with new data
#knitr::knit2html('van-weather-report.Rmd') # doesn't look like this produces the right html format
rmarkdown::render('van-weather-report.Rmd', output_format = "html_document") ## produces better result than above
## update flexdashboard with new data 
rmarkdown::render("van-weather-dashboard.Rmd", output_format = flex_dashboard())
## copy examples over to portfolio website (on Macbook)
source('save-Rmd-portfolio-site.R')
