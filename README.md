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
2.  specify station as containing 'vancouver'; best is VANCOUVER INTL A
3.  select 'daily', select 'year'
4.  'Go' goes to a page to access results for year

(process is automated in 'van-weather-import.R')

    ## [1] "Winter" "Spring" "Summer" "Fall"

**Earliest date:** *1970-01-01* <br /> **Most recent date:** *2021-01-08*

Precipitation
-------------

**NOTE:** precipitation data not available for 2020 so far. :(

### Daily precipitation for current month

![](README_files/figure-markdown_github/DAILY%20CURR%20MTH%20PRECIP-1.png)

Data status: No data missing

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
    ##     Min      1Q  Median      3Q     Max 
    ## -4.3887 -0.2271  0.0146  0.4724  1.0994 
    ## 
    ## Coefficients:
    ##               Estimate Std. Error t value Pr(>|t|)  
    ## (Intercept) -20.472692  14.954661  -1.369   0.1771  
    ## ynum          0.015382   0.007494   2.053   0.0454 *
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
    ## 
    ## Residual standard error: 0.811 on 50 degrees of freedom
    ## Multiple R-squared:  0.07771,    Adjusted R-squared:  0.05926 
    ## F-statistic: 4.213 on 1 and 50 DF,  p-value: 0.04537

Model interpretation: <br />

-   Average daily temperature changing 0.0153817 degrees each yr.
-   P-value for statistical significance: 0.0453698
-   Temperature change is *statistically significant* over this period

#### Look at Average Daily Maximum and Minimums for each Year

![](README_files/figure-markdown_github/MEAN%20MIN%20MAX%20TEMP-1.png)

Linear modelling for max and min

    ## 
    ## Call:
    ## lm(formula = mean.max ~ ynum, data = vw.temp.yr)
    ## 
    ## Residuals:
    ##     Min      1Q  Median      3Q     Max 
    ## -5.1920 -0.2736  0.0399  0.4654  1.0775 
    ## 
    ## Coefficients:
    ##              Estimate Std. Error t value Pr(>|t|)
    ## (Intercept) -2.778343  16.866586  -0.165    0.870
    ## ynum         0.008279   0.008452   0.980    0.332
    ## 
    ## Residual standard error: 0.9147 on 50 degrees of freedom
    ## Multiple R-squared:  0.01883,    Adjusted R-squared:  -0.0007932 
    ## F-statistic: 0.9596 on 1 and 50 DF,  p-value: 0.332

Model interpretation: <br />

-   Average daily MAX temperature changing 0.0082795 degrees each yr.
-   P-value for statistical significance: 0.3320093
-   Temperature change is *not statistically significant* over this period

<!-- -->

    ## 
    ## Call:
    ## lm(formula = mean.min ~ ynum, data = vw.temp.yr)
    ## 
    ## Residuals:
    ##     Min      1Q  Median      3Q     Max 
    ## -3.5647 -0.3271  0.0135  0.4832  1.2072 
    ## 
    ## Coefficients:
    ##               Estimate Std. Error t value Pr(>|t|)   
    ## (Intercept) -38.230592  13.485235  -2.835  0.00660 **
    ## ynum          0.022493   0.006758   3.328  0.00164 **
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
    ## 
    ## Residual standard error: 0.7314 on 50 degrees of freedom
    ## Multiple R-squared:  0.1814, Adjusted R-squared:  0.165 
    ## F-statistic: 11.08 on 1 and 50 DF,  p-value: 0.001645

Model interpretation: <br />

-   Average daily MIN temperature changing 0.0224927 degrees each yr.
-   P-value for statistical significance: 0.0016445
-   Temperature change is *statistically significant* over this period

### Monthly average temperature

![](README_files/figure-markdown_github/MONTHLY%20TEMP%20COMBINED%20MONTHS%20ACROSS%20YEARS-1.png)![](README_files/figure-markdown_github/MONTHLY%20TEMP%20COMBINED%20MONTHS%20ACROSS%20YEARS-2.png)

### Monthly Temperatures: Ranges

![](README_files/figure-markdown_github/TEMPERATURE%20RANGES-1.png)
