Vancouver Weather Analysis
================

proj-r-van-weather
==================

A looks at weather patterns in Vancouver, BC using various data visualization approaches and stastical techniques, most for the sake of exploration and demonstration.

-   from [Govt. of Canada Historical Weather](http://climate.weather.gc.ca/historical_data/search_historic_data_e.html) Data website
-   monthly
-   precipitation, temperature

Data Collection
---------------

Data is collected from Govt of Canada website:

1.  search: <http://climate.weather.gc.ca/historical_data/search_historic_data_e.html>
2.  specify station as containing 'vancouver harbour'
3.  select 'daily', select 'year'
4.  'Go' goes to a page to access results for year

(process is automated in 'van-weather-import.R')

    ## [1] "Winter" "Spring" "Summer" "Fall"

**Earliest date:** *1988-01-01* <br /> **Most recent date:** *2020-03-07*

Precipitation
-------------

**NOTE:** precipitation data not available for 2020 so far. :(

### Daily precipitation for current month

![](README_files/figure-markdown_github/DAILY%20CURR%20MTH%20PRECIP-1.png)

Data status: Data missing.

### Monthly precipitation data: Averages

![](README_files/figure-markdown_github/MONTHLY%20PRECIP%20COMBINED-1.png)![](README_files/figure-markdown_github/MONTHLY%20PRECIP%20COMBINED-2.png)

### Monthly Preciptiation: Ranges

![](README_files/figure-markdown_github/PRECIP%20MTH%20BOX-1.png)![](README_files/figure-markdown_github/PRECIP%20MTH%20BOX-2.png)

### Current Month Precipitation

![](README_files/figure-markdown_github/CURRENT%20MTH%20Precip-1.png)![](README_files/figure-markdown_github/CURRENT%20MTH%20Precip-2.png)

### Monthly Comparison YoY

For each month, what has been the pattern in precipitation over the years?

![](README_files/figure-markdown_github/PLOT%20MONTHS%20YOY-1.png)

### Seasonal Precipitation

#### Season definitions:

-   Winter: Dec, Jan, Feb
-   Spring: Mar, Apr, May
-   Summer: Jun, Jul, Aug
-   Fall: Sep, Oct, Nov

*Note: the year for a winter season is applied to year at end of season. So winter from Dec 2018 to Feb 2019 is considered winter of 2019.*

![](README_files/figure-markdown_github/PRECIP%20SEASON%20BOX-1.png)

![](README_files/figure-markdown_github/PLOT%20SEASON%20YOY-1.png)

### Seasonal Precipitation Annual Ranking

-   Need separate charts because each season ranked individually
-   Line = median

![](README_files/figure-markdown_github/PLOT%20SEASONS%20RANKED-1.png)![](README_files/figure-markdown_github/PLOT%20SEASONS%20RANKED-2.png)![](README_files/figure-markdown_github/PLOT%20SEASONS%20RANKED-3.png)![](README_files/figure-markdown_github/PLOT%20SEASONS%20RANKED-4.png)

Temperature
-----------

### Ave. Annual Temperature

![](README_files/figure-markdown_github/ANNUAL%20TEMP%20FILTER%20YRS-1.png)

#### Years Ranked by Average Daily Temp

![](README_files/figure-markdown_github/RANK%20BY%20YEAR-1.png)

#### Linear model of annual temperature change

    ## 
    ## Call:
    ## lm(formula = mean.mean ~ ynum, data = vw.temp.yr)
    ## 
    ## Residuals:
    ##      Min       1Q   Median       3Q      Max 
    ## -1.06271 -0.44340 -0.01888  0.45964  1.06865 
    ## 
    ## Coefficients:
    ##              Estimate Std. Error t value Pr(>|t|)
    ## (Intercept) 16.560090  25.469955   0.650    0.522
    ## ynum        -0.002517   0.012706  -0.198    0.845
    ## 
    ## Residual standard error: 0.5623 on 24 degrees of freedom
    ## Multiple R-squared:  0.001632,   Adjusted R-squared:  -0.03997 
    ## F-statistic: 0.03923 on 1 and 24 DF,  p-value: 0.8447

Model interpretation: <br />

-   Average daily temperature changing -0.0025166 degrees each yr.
-   P-value for statistical significance: 0.8446646
-   Temperature change is *not statistically significant* over this period

#### Look at Average Daily Maximum and Minimums for each Year

![](README_files/figure-markdown_github/MEAN%20MIN%20MAX%20TEMP-1.png)

Linear modelling for max and min

    ## 
    ## Call:
    ## lm(formula = mean.max ~ ynum, data = vw.temp.yr)
    ## 
    ## Residuals:
    ##      Min       1Q   Median       3Q      Max 
    ## -1.22083 -0.36492 -0.06269  0.44222  1.23017 
    ## 
    ## Coefficients:
    ##              Estimate Std. Error t value Pr(>|t|)
    ## (Intercept) 17.572393  28.058085   0.626    0.537
    ## ynum        -0.001481   0.013997  -0.106    0.917
    ## 
    ## Residual standard error: 0.6195 on 24 degrees of freedom
    ## Multiple R-squared:  0.0004662,  Adjusted R-squared:  -0.04118 
    ## F-statistic: 0.01119 on 1 and 24 DF,  p-value: 0.9166

Model interpretation: <br />

-   Average daily MAX temperature changing -0.0014809 degrees each yr.
-   P-value for statistical significance: 0.9166207
-   Temperature change is *not statistically significant* over this period

<!-- -->

    ## 
    ## Call:
    ## lm(formula = mean.min ~ ynum, data = vw.temp.yr)
    ## 
    ## Residuals:
    ##      Min       1Q   Median       3Q      Max 
    ## -0.89858 -0.43410  0.00637  0.48331  0.86790 
    ## 
    ## Coefficients:
    ##              Estimate Std. Error t value Pr(>|t|)
    ## (Intercept) 13.705786  24.941836   0.550    0.588
    ## ynum        -0.002663   0.012443  -0.214    0.832
    ## 
    ## Residual standard error: 0.5507 on 24 degrees of freedom
    ## Multiple R-squared:  0.001905,   Adjusted R-squared:  -0.03968 
    ## F-statistic: 0.0458 on 1 and 24 DF,  p-value: 0.8324

Model interpretation: <br />

-   Average daily MIN temperature changing -0.0026628 degrees each yr.
-   P-value for statistical significance: 0.8323547
-   Temperature change is *not statistically significant* over this period

### Monthly average temperature

![](README_files/figure-markdown_github/MONTHLY%20TEMP%20COMBINED%20MONTHS%20ACROSS%20YEARS-1.png)![](README_files/figure-markdown_github/MONTHLY%20TEMP%20COMBINED%20MONTHS%20ACROSS%20YEARS-2.png)

### Monthly Temperatures: Ranges

![](README_files/figure-markdown_github/TEMPERATURE%20RANGES-1.png)
