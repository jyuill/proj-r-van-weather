Vancouver Weather Analysis
================

# proj-r-van-weather

A look at weather patterns in Vancouver, BC using various data
visualization approaches and stastical techniques, most for the sake of
exploration and demonstration.

- from [Govt. of Canada Historical
  Weather](http://climate.weather.gc.ca/historical_data/search_historic_data_e.html)
  Data website
- monthly
- precipitation, temperature

## Data Presentation

Data is shown below in various charts. Also available in other forms in
this repo:

1.  **van-weather-report**: deep-dive into weather stats, with some
    light modeling.
2.  **van-weather-dashboard**: flexdashboard showing 30d, 90d, annual
    weather patterns

Both of these:

- leverage the same data collection, described below
- available online at [jyuill.github.io](https://jyuill.github.io)
- use the **two “gtm-…”** files to include gtm code for GA4

van-weather-report.Rmd also uses \_navbar.html for navigation bar.

## Data Collection

Data is collected from Govt of Canada website:

1.  search:
    <http://climate.weather.gc.ca/historical_data/search_historic_data_e.html>
2.  specify station as containing ‘vancouver’; best is VANCOUVER INTL A
3.  select ‘daily’, select ‘year’
4.  ‘Go’ goes to a page to access results for year

## Automated Data Collection

**van-weather-import-v2.R** is used to update data

Convenient update process:

- Run **01-update-wrapper.R** to:
  - update data
  - run Rmd files to update report and dashboard
  - copy files to jyuill.github.io site repo for push/publish

<!-- -->

    ## [1] "Winter" "Spring" "Summer" "Fall"

**Earliest date:** *1970-01-01* <br /> **Most recent date:**
*2023-01-03*

## Precipitation

**NOTE:** precipitation data not available for 2020 so far. :(

### Daily precipitation for current month

![](README_files/figure-gfm/DAILY%20CURR%20MTH%20PRECIP-1.png)<!-- -->

Data status: Data missing.

### Monthly precipitation data: Averages

![](README_files/figure-gfm/MONTHLY%20PRECIP%20COMBINED-1.png)<!-- -->![](README_files/figure-gfm/MONTHLY%20PRECIP%20COMBINED-2.png)<!-- -->

### Monthly Preciptiation: Ranges

![](README_files/figure-gfm/PRECIP%20MTH%20BOX-1.png)<!-- -->![](README_files/figure-gfm/PRECIP%20MTH%20BOX-2.png)<!-- -->

### Current Month Precipitation

![](README_files/figure-gfm/CURRENT%20MTH%20Precip-1.png)<!-- -->![](README_files/figure-gfm/CURRENT%20MTH%20Precip-2.png)<!-- -->

### Monthly Comparison YoY

For each month, what has been the pattern in precipitation over the
years?

![](README_files/figure-gfm/PLOT%20MONTHS%20YOY-1.png)<!-- -->

### Seasonal Precipitation

#### Season definitions:

- Winter: Dec, Jan, Feb
- Spring: Mar, Apr, May
- Summer: Jun, Jul, Aug
- Fall: Sep, Oct, Nov

*Note: the year for a winter season is applied to year at end of season.
So winter from Dec 2018 to Feb 2019 is considered winter of 2019.*

![](README_files/figure-gfm/PRECIP%20SEASON%20BOX-1.png)<!-- -->

![](README_files/figure-gfm/PLOT%20SEASON%20YOY-1.png)<!-- -->

### Seasonal Precipitation Annual Ranking

- Need separate charts because each season ranked individually
- Line = median

![](README_files/figure-gfm/PLOT%20SEASONS%20RANKED-1.png)<!-- -->![](README_files/figure-gfm/PLOT%20SEASONS%20RANKED-2.png)<!-- -->![](README_files/figure-gfm/PLOT%20SEASONS%20RANKED-3.png)<!-- -->![](README_files/figure-gfm/PLOT%20SEASONS%20RANKED-4.png)<!-- -->

## Temperature

### Ave. Annual Temperature

![](README_files/figure-gfm/ANNUAL%20TEMP%20FILTER%20YRS-1.png)<!-- -->

#### Years Ranked by Average Daily Temp

![](README_files/figure-gfm/RANK%20BY%20YEAR-1.png)<!-- -->

#### Linear model of annual temperature change

    ## 
    ## Call:
    ## lm(formula = mean.mean ~ ynum, data = vw.temp.yr)
    ## 
    ## Residuals:
    ##     Min      1Q  Median      3Q     Max 
    ## -6.7143 -0.2150  0.0445  0.4307  1.2039 
    ## 
    ## Coefficients:
    ##              Estimate Std. Error t value Pr(>|t|)
    ## (Intercept) -7.320268  18.914123  -0.387    0.700
    ## ynum         0.008766   0.009473   0.925    0.359
    ## 
    ## Residual standard error: 1.085 on 52 degrees of freedom
    ## Multiple R-squared:  0.0162, Adjusted R-squared:  -0.002718 
    ## F-statistic: 0.8563 on 1 and 52 DF,  p-value: 0.359

Model interpretation: <br />

- Average daily temperature changing 0.0087665 degrees each yr.
- P-value for statistical significance: 0.3590427
- Temperature change is *not statistically significant* over this period

#### Look at Average Daily Maximum and Minimums for each Year

![](README_files/figure-gfm/MEAN%20MIN%20MAX%20TEMP-1.png)<!-- -->

Linear modelling for max and min

    ## 
    ## Call:
    ## lm(formula = mean.max ~ ynum, data = vw.temp.yr)
    ## 
    ## Residuals:
    ##     Min      1Q  Median      3Q     Max 
    ## -7.3767 -0.2920  0.1145  0.5380  1.2141 
    ## 
    ## Coefficients:
    ##              Estimate Std. Error t value Pr(>|t|)
    ## (Intercept)  8.462636  20.467904   0.413    0.681
    ## ynum         0.002627   0.010252   0.256    0.799
    ## 
    ## Residual standard error: 1.174 on 52 degrees of freedom
    ## Multiple R-squared:  0.001261,   Adjusted R-squared:  -0.01795 
    ## F-statistic: 0.06566 on 1 and 52 DF,  p-value: 0.7988

Model interpretation: <br />

- Average daily MAX temperature changing 0.0026268 degrees each yr.
- P-value for statistical significance: 0.7987801
- Temperature change is *not statistically significant* over this period

<!-- -->

    ## 
    ## Call:
    ## lm(formula = mean.min ~ ynum, data = vw.temp.yr)
    ## 
    ## Residuals:
    ##     Min      1Q  Median      3Q     Max 
    ## -6.0084 -0.2810  0.1046  0.5114  1.2831 
    ## 
    ## Coefficients:
    ##               Estimate Std. Error t value Pr(>|t|)  
    ## (Intercept) -23.292438  17.556524  -1.327   0.1904  
    ## ynum          0.014978   0.008793   1.703   0.0945 .
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
    ## 
    ## Residual standard error: 1.007 on 52 degrees of freedom
    ## Multiple R-squared:  0.05285,    Adjusted R-squared:  0.03463 
    ## F-statistic: 2.901 on 1 and 52 DF,  p-value: 0.09447

Model interpretation: <br />

- Average daily MIN temperature changing 0.0149782 degrees each yr.
- P-value for statistical significance: 0.0944742
- Temperature change is *not statistically significant* over this period

### Monthly average temperature

![](README_files/figure-gfm/MONTHLY%20TEMP%20COMBINED%20MONTHS%20ACROSS%20YEARS-1.png)<!-- -->![](README_files/figure-gfm/MONTHLY%20TEMP%20COMBINED%20MONTHS%20ACROSS%20YEARS-2.png)<!-- -->

### Monthly Temperatures: Ranges

![](README_files/figure-gfm/TEMPERATURE%20RANGES-1.png)<!-- -->
