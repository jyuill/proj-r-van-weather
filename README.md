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

## Data Collection

Data is collected from Govt of Canada website:

1.  search:
    <http://climate.weather.gc.ca/historical_data/search_historic_data_e.html>
2.  specify station as containing ‘vancouver’; best is VANCOUVER INTL A
3.  select ‘daily’, select ‘year’
4.  ‘Go’ goes to a page to access results for year

(process is automated in ‘van-weather-import.R’)

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
    ## -6.8160 -0.2156  0.0475  0.5497  1.3914 
    ## 
    ## Coefficients:
    ##               Estimate Std. Error t value Pr(>|t|)
    ## (Intercept) -12.877831  19.917208  -0.647    0.521
    ## ynum          0.011564   0.009978   1.159    0.252
    ## 
    ## Residual standard error: 1.114 on 51 degrees of freedom
    ## Multiple R-squared:  0.02566,    Adjusted R-squared:  0.006555 
    ## F-statistic: 1.343 on 1 and 51 DF,  p-value: 0.2519

Model interpretation: <br />

- Average daily temperature changing 0.0115639 degrees each yr.
- P-value for statistical significance: 0.2518856
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
    ## -7.4846 -0.2770  0.1015  0.5272  1.7984 
    ## 
    ## Coefficients:
    ##             Estimate Std. Error t value Pr(>|t|)
    ## (Intercept)  2.57638   21.69296   0.119    0.906
    ## ynum         0.00559    0.01087   0.514    0.609
    ## 
    ## Residual standard error: 1.213 on 51 degrees of freedom
    ## Multiple R-squared:  0.005161,   Adjusted R-squared:  -0.01435 
    ## F-statistic: 0.2646 on 1 and 51 DF,  p-value: 0.6092

Model interpretation: <br />

- Average daily MAX temperature changing 0.0055898 degrees each yr.
- P-value for statistical significance: 0.6092315
- Temperature change is *not statistically significant* over this period

<!-- -->

    ## 
    ## Call:
    ## lm(formula = mean.min ~ ynum, data = vw.temp.yr)
    ## 
    ## Residuals:
    ##     Min      1Q  Median      3Q     Max 
    ## -6.1042 -0.2773  0.0998  0.5736  1.2532 
    ## 
    ## Coefficients:
    ##               Estimate Std. Error t value Pr(>|t|)  
    ## (Intercept) -28.538230  18.353404  -1.555    0.126  
    ## ynum          0.017619   0.009195   1.916    0.061 .
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
    ## 
    ## Residual standard error: 1.026 on 51 degrees of freedom
    ## Multiple R-squared:  0.06716,    Adjusted R-squared:  0.04887 
    ## F-statistic: 3.672 on 1 and 51 DF,  p-value: 0.06096

Model interpretation: <br />

- Average daily MIN temperature changing 0.0176186 degrees each yr.
- P-value for statistical significance: 0.0609573
- Temperature change is *not statistically significant* over this period

### Monthly average temperature

![](README_files/figure-gfm/MONTHLY%20TEMP%20COMBINED%20MONTHS%20ACROSS%20YEARS-1.png)<!-- -->![](README_files/figure-gfm/MONTHLY%20TEMP%20COMBINED%20MONTHS%20ACROSS%20YEARS-2.png)<!-- -->

### Monthly Temperatures: Ranges

![](README_files/figure-gfm/TEMPERATURE%20RANGES-1.png)<!-- -->
