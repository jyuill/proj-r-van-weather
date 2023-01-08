#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
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

# Define UI for application that draws a histogram
fluidPage(

    # Application title
    titlePanel("Vancouver Weather"),

    # Sidebar with a slider input for number of bins
    sidebarLayout(
        sidebarPanel(
            ## date range
          dateRangeInput(inputId="dtrng", label="Date range", start="2022-09-01", end="2022-12-31"),
            ## date grain (daily, monthly, annually)
          selectizeInput(inputId='grain',label="Date granularity",
                         choices=c('Daily','Mothly','Annually'),
                         selected='Daily')          
        , width=3), ## end sidebar
        mainPanel(
          ## plots
          plotOutput(
            outputId='precipPlot'
          ),
          plotOutput(
            outputId='tempPlot'
          )
        , width=9) ## end main panel
    ) ## end sidebar layout
)
