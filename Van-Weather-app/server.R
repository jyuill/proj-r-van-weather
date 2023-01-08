#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(tidyverse)
library(lubridate)
library(here)
library(scales)
library(plotly)
theme_set(theme_light())

## import data
vw_data <- read_csv("van-weather.csv") 
## convert Year, Month to factors for better charting
vw_data$Year <- as.factor(vw_data$Year)
vw_data$Month <- as.factor(vw_data$Month)
vw_data$Season <- as.factor(vw_data$Season)
## set Season order
vw_data$Season <- factor(vw_data$Season, levels=c("Winter","Spring","Summer","Fall"))


# Define server logic required to draw a histogram
function(input, output, session) {

    output$precipPlot <- renderPlot({
        # draw the precip bar chart
        vw_data %>% filter(Date >= input$dtrng[1] & Date <= input$dtrng[2]) %>%
        ggplot(aes(x=Date, y=Total.Precip))+geom_col()+
        labs(x="", y="Precip. (cm)")
    })
    output$tempPlot <- renderPlot({
      # draw the precip bar chart
      vw_data %>% filter(Date >= input$dtrng[1] & Date <= input$dtrng[2]) %>%
        ggplot(aes(x=Date, y=Mean.Temp))+
        geom_ribbon(aes(ymin=Min.Temp, ymax=Max.Temp), fill='grey80')+
        geom_line()+
        geom_point()+
        geom_hline(yintercept=0)+
        labs(x="", y="Temp. (c): Mean w/Min-Max shadow")
    })

}
