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
vw_data <- read_csv(here('Van-weather-app','van-weather.csv'))
#vw_data <- read_csv("van-weather.csv") 
## convert Year, Month to factors for better charting
vw_data$Year <- as.factor(vw_data$Year)
vw_data$Month <- as.factor(vw_data$Month)
vw_data$Season <- as.factor(vw_data$Season)
## set Season order
vw_data$Season <- factor(vw_data$Season, levels=c("Winter","Spring","Summer","Fall"))
## aggregate data by month for monthly view
vw_mth <- vw_data %>% group_by(Year, Month) %>% summarize(
  precip=sum(Total.Precip, na.rm=TRUE),
  meanTemp=mean(Mean.Temp, na.rm=TRUE),
  maxTemp=max(Max.Temp, na.rm=TRUE),
  minTemp=min(Min.Temp, na.rm=TRUE)
) %>% mutate(
  yrmthdt = ifelse(as.character(Month)<10, paste0(Year,"-0",Month,"-01"), paste0(Year,"-",Month,"-01")),
)
vw_mth$yrmthdt <- ymd(vw_mth$yrmthdt)
## aggregrate data by year for annual view
vw_yr <- vw_data %>% group_by(Year) %>% summarize(
  precip=sum(Total.Precip, na.rm=TRUE),
  meanTemp=mean(Mean.Temp, na.rm=TRUE),
  maxTemp=max(Max.Temp, na.rm=TRUE),
  minTemp=min(Min.Temp, na.rm=TRUE)
) %>% mutate(
  yrdt = ymd(paste(Year,"-01-01"))
)

# Define server logic required to show weather data
function(input, output, session) {
  ## get summary data for top boxes, reacting to date range inputs
  smry <- reactive({vw_data %>% filter(Date >= input$dtrng[1] & Date <= input$dtrng[2]) %>%
          summarize(ttl_precip=sum(Total.Precip, na.rm=TRUE),
                    mean_temp=mean(Mean.Temp, na.rm=TRUE),
                    max_temp=max(Max.Temp, na.rm=TRUE),
                    min_temp=min(Min.Temp, na.rm=TRUE))
          
  })
  ## send specified data to UI for text boxes  
    output$ttlPrecip <- renderText({smry()[[1]]})
    output$meanTemp <- renderText(round({smry()[[2]]},1))
    output$maxTemp <- renderText({smry()[[3]]})
    output$minTemp <- renderText({smry()[[4]]})
    
    ## main precip plot ======
    output$precipPlot <- renderPlot({
        # draw the precip bar chart
      if(input$grain=='Daily'){
        vw_data %>% filter(Date >= input$dtrng[1] & Date <= input$dtrng[2]) %>%
        ggplot(aes(x=Date, y=Total.Precip))+geom_col()+
        labs(x="", y="Precip. (cm)")
      } else if(input$grain == 'Monthly'){ ## mthly precip
        vw_mth %>% filter(yrmthdt >= input$dtrng[1] & yrmthdt <= input$dtrng[2]) %>%
          ggplot(aes(x=yrmthdt, y=precip))+geom_col()+
          labs(x="", y="Precip. (cm)")
      } else if(input$grain == 'Annually'){ ## annual precip
        vw_yr %>% filter(yrdt >= input$dtrng[1] & yrdt <= input$dtrng[2]) %>%
          ggplot(aes(x=yrdt, y=precip))+geom_col()+
          labs(x="", y="Precip. (cm)")
      } ## end annual precip
    })
    ## main temp chart ======
    output$tempPlot <- renderPlot({
      # draw the temp line chart for daily data
      if(input$grain=='Daily'){
        vw_data %>% filter(Date >= input$dtrng[1] & Date <= input$dtrng[2]) %>%
          ggplot(aes(x=Date, y=Mean.Temp))+
          geom_ribbon(aes(ymin=Min.Temp, ymax=Max.Temp), fill='grey80')+
          geom_line()+
          geom_point()+
          geom_hline(yintercept=0)+
          labs(x="", y="Temp. (c): Mean w/Min-Max shadow")
      } else if(input$grain == 'Monthly'){
        vw_mth %>% filter(yrmthdt >= input$dtrng[1] & yrmthdt <= input$dtrng[2]) %>%
          ggplot(aes(x=yrmthdt, y=meanTemp))+
          geom_ribbon(aes(ymin=minTemp, ymax=maxTemp), fill='grey80')+
          geom_line()+
          geom_point()+
          geom_hline(yintercept=0)+
          labs(x="", y="Temp. (c): Mean w/Min-Max shadow")
      } else if(input$grain == 'Annually'){
        vw_yr %>% filter(yrdt >= input$dtrng[1] & yrdt <= input$dtrng[2]) %>%
          ggplot(aes(x=yrdt, y=meanTemp))+
          geom_ribbon(aes(ymin=minTemp, ymax=maxTemp), fill='grey80')+
          geom_line()+
          geom_point()+
          geom_hline(yintercept=0)+
          labs(x="", y="Temp. (c): Mean w/Min-Max shadow")
      }
    }) ## end temp plot
}
