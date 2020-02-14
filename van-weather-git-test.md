Vancouver Weather Analysis
================

Intro
=====

Basic analysis of Vancouver weather patterns:

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

**Earliest date:** *1988-01-01* <br /> **Most recent date:** *2020-02-13*

Check data structure:

    ## Classes 'spec_tbl_df', 'tbl_df', 'tbl' and 'data.frame': 11729 obs. of  10 variables:
    ##  $ Month       : Factor w/ 12 levels "1","2","3","4",..: 1 1 1 1 1 1 1 1 1 1 ...
    ##  $ Season      : Factor w/ 4 levels "Winter","Spring",..: 1 1 1 1 1 1 1 1 1 1 ...
    ##  $ Date        : Date, format: "1988-01-01" "1988-01-02" ...
    ##  $ Year        : Factor w/ 33 levels "1988","1989",..: 1 1 1 1 1 1 1 1 1 1 ...
    ##  $ Day         : num  1 2 3 4 5 6 7 8 9 10 ...
    ##  $ Max.Temp    : num  3.2 2.5 5.2 3.3 4.3 4.5 5.7 5 6.8 7 ...
    ##  $ Min.Temp    : num  -0.9 -2 -1.5 0 1.7 1.7 2.7 1.2 2.1 4.7 ...
    ##  $ Mean.Temp   : num  1.2 0.3 1.9 1.7 3 3.1 4.2 3.1 4.5 5.9 ...
    ##  $ Total.Precip: num  0 0 0 0 0 0 0 5.6 2.4 0 ...
    ##  $ Season.Yr   : num  1988 1988 1988 1988 1988 ...
    ##  - attr(*, "spec")=
    ##   .. cols(
    ##   ..   Month = col_double(),
    ##   ..   Season = col_character(),
    ##   ..   Date = col_date(format = ""),
    ##   ..   Year = col_double(),
    ##   ..   Day = col_double(),
    ##   ..   Max.Temp = col_double(),
    ##   ..   Min.Temp = col_double(),
    ##   ..   Mean.Temp = col_double(),
    ##   ..   Total.Precip = col_double(),
    ##   ..   Season.Yr = col_double()
    ##   .. )

Earliest date: 1988-01-01 <br /> Most recent date: 2020-02-13

Check Data Relationships

-   uses PerformanceAnalytics package

![](van-weather-git-test_files/figure-markdown_github/DATA%20RELATIONSHIPS-1.png)

Precipitation
-------------

### Monthly precipitation data: Averages

![](van-weather-git-test_files/figure-markdown_github/MONTHLY%20PRECIP%20COMBINED-1.png)![](van-weather-git-test_files/figure-markdown_github/MONTHLY%20PRECIP%20COMBINED-2.png)

#### Data by Month - ranked in order of highest precipitation

    ## # A tibble: 12 x 5
    ##    Month ave_precip pc_rank     pc  rank
    ##    <fct>      <dbl>   <dbl>  <dbl> <dbl>
    ##  1 11         232.   1.     0.167      1
    ##  2 1          205.   0.909  0.148      2
    ##  3 12         183.   0.818  0.132      3
    ##  4 3          150.   0.727  0.108      4
    ##  5 10         145.   0.636  0.104      5
    ##  6 2          112.   0.545  0.0805     6
    ##  7 4           99.7  0.455  0.0717     7
    ##  8 5           66.5  0.364  0.0479     8
    ##  9 9           66.0  0.273  0.0475     9
    ## 10 6           56.4  0.182  0.0406    10
    ## 11 8           40.9  0.0909 0.0295    11
    ## 12 7           32.5  0      0.0234    12

### Monthly Preciptiation: Ranges

![](van-weather-git-test_files/figure-markdown_github/PRECIP%20MTH%20BOX-1.png)![](van-weather-git-test_files/figure-markdown_github/PRECIP%20MTH%20BOX-2.png)

### Current Month Precipitation

![](van-weather-git-test_files/figure-markdown_github/CURRENT%20MTH%20Precip-1.png)![](van-weather-git-test_files/figure-markdown_github/CURRENT%20MTH%20Precip-2.png)

### Monthly Comparison YoY

For each month, what has been the pattern in precipitation over the years?

![](van-weather-git-test_files/figure-markdown_github/PLOT%20MONTHS%20YOY-1.png)

### Seasonal Precipitation

#### Season definitions:

-   Winter: Dec, Jan, Feb
-   Spring: Mar, Apr, May
-   Summer: Jun, Jul, Aug
-   Fall: Sep, Oct, Nov

*Note: the year for a winter season is applied to year at end of season. So winter from Dec 2018 to Feb 2019 is considered winter of 2019.*

![](van-weather-git-test_files/figure-markdown_github/PRECIP%20SEASON%20BOX-1.png)

![](van-weather-git-test_files/figure-markdown_github/PLOT%20SEASON%20YOY-1.png)

### Seasonal Precipitation Annual Ranking

-   Need separate charts because each season ranked individually
-   Line = median

![](van-weather-git-test_files/figure-markdown_github/PLOT%20SEASONS%20RANKED-1.png)![](van-weather-git-test_files/figure-markdown_github/PLOT%20SEASONS%20RANKED-2.png)![](van-weather-git-test_files/figure-markdown_github/PLOT%20SEASONS%20RANKED-3.png)![](van-weather-git-test_files/figure-markdown_github/PLOT%20SEASONS%20RANKED-4.png)

Temperature
-----------

### Ave. Annual Temperature

![](van-weather-git-test_files/figure-markdown_github/ANNUAL%20TEMP-1.png)

-   Obvious outliers 1988, 1989, 2011: shown down below, temperature data is missing for multiple months, bringing ave. temp way down. Best to discard.
-   Could use more sophisticated imputation of missing values, such as using averages, to preserve data for other months in those years

![](van-weather-git-test_files/figure-markdown_github/FILTER%20YRS-1.png)

#### Years Ranked by Average Daily Temp

![](van-weather-git-test_files/figure-markdown_github/RANK%20BY%20YEAR-1.png)

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

![](van-weather-git-test_files/figure-markdown_github/MEAN%20MIN%20MAX%20TEMP-1.png)

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

![](van-weather-git-test_files/figure-markdown_github/MONTHLY%20TEMP%20COMBINED%20MONTHS%20ACROSS%20YEARS-1.png)![](van-weather-git-test_files/figure-markdown_github/MONTHLY%20TEMP%20COMBINED%20MONTHS%20ACROSS%20YEARS-2.png)

### Monthly Temperatures: Ranges

![](van-weather-git-test_files/figure-markdown_github/TEMPERATURE%20RANGES-1.png)

### Monthly Temperature Trends over Years

![](van-weather-git-test_files/figure-markdown_github/MONTHLY%20TEMP%20TRENDS-1.png)

### Monthly Temp. Comparison YoY

For each month, what has been the pattern in ave. temperature over the years?

![](van-weather-git-test_files/figure-markdown_github/PLOT%20MONTHS%20YOY%20TEMP-1.png)

### Seasonal Temperatures

#### Season definitions:

-   Winter: Dec, Jan, Feb
-   Spring: Mar, Apr, May
-   Summer: Jun, Jul, Aug
-   Fall: Sep, Oct, Nov

*Note: the year for a winter season is applied to year at end of season. So winter from Dec 2018 to Feb 2019 is considered winter of 2019.*
