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
library(bslib)

# Define UI for application that draws a histogram
fluidPage(
  theme=bs_theme(bootswatch='darkly'),
  tags$head(
    tags$style(HTML("
      div.toptile {
        border: 1px solid white;
        padding: 5px;
        margin: 5px;
        background-color: grey;
        text-align: center
      }
    ")),
  ),
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
          fluidRow(
            column(width=3,
                   tags$div("Total Precip.",
                   tags$h3(textOutput(outputId='ttlPrecip')), class="toptile")),
            column(width=3, 
                   tags$div("Mean Temp.",
                   h3(textOutput(outputId='meanTemp')), class="toptile")),
            column(width=3, 
                  tags$div("Max Temp.",
                      h3(textOutput(outputId='maxTemp')), class="toptile")),
            column(width=3, 
                   tags$div("Min Temp.",
                   h3(textOutput(outputId='minTemp')), class='toptile'))
          ), ## end top row
          ## plots
          fluidRow(
            column(width=6,
          plotOutput(
            outputId='precipPlot'
          )),
          column(width=6,
          plotOutput(
            outputId='tempPlot'
          ))
        ) # end lower row
        , width=9) ## end main panel
    ) ## end sidebar layout
)
