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

**Earliest date:** *1988-01-01* <br /> **Most recent date:** *2020-02-07*

Check data structure:

    ## Classes 'spec_tbl_df', 'tbl_df', 'tbl' and 'data.frame': 11723 obs. of  10 variables:
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

Earliest date: 1988-01-01 <br /> Most recent date: 2020-02-07

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

<!--html_preserve-->

<script type="application/json" data-for="htmlwidget-385f1d61fb6e7a1d4f14">{"x":{"data":[{"x":[1,2,3,4,5,6,7,8,9,10,11,12],"y":[4.71666666666667,5.48888888888889,7.37096774193548,null,null,null,null,null,null,null,null,null],"text":["Month:  1<br />ave_temp:  4.716667<br />Year: 1988","Month:  2<br />ave_temp:  5.488889<br />Year: 1988","Month:  3<br />ave_temp:  7.370968<br />Year: 1988","Month:  4<br />ave_temp:        NA<br />Year: 1988","Month:  5<br />ave_temp:        NA<br />Year: 1988","Month:  6<br />ave_temp:        NA<br />Year: 1988","Month:  7<br />ave_temp:        NA<br />Year: 1988","Month:  8<br />ave_temp:        NA<br />Year: 1988","Month:  9<br />ave_temp:        NA<br />Year: 1988","Month: 10<br />ave_temp:        NA<br />Year: 1988","Month: 11<br />ave_temp:        NA<br />Year: 1988","Month: 12<br />ave_temp:        NA<br />Year: 1988"],"type":"scatter","mode":"lines","line":{"width":1.88976377952756,"color":"rgba(248,118,109,1)","dash":"solid"},"hoveron":"points","name":"1988","legendgroup":"1988","showlegend":true,"xaxis":"x","yaxis":"y","hoverinfo":"text","frame":null},{"x":[1,2,3,4,5,6,7,8,9,10,11,12],"y":[null,null,null,null,null,null,null,null,15.44,10.7161290322581,7.25666666666667,5.60322580645161],"text":["Month:  1<br />ave_temp:        NA<br />Year: 1989","Month:  2<br />ave_temp:        NA<br />Year: 1989","Month:  3<br />ave_temp:        NA<br />Year: 1989","Month:  4<br />ave_temp:        NA<br />Year: 1989","Month:  5<br />ave_temp:        NA<br />Year: 1989","Month:  6<br />ave_temp:        NA<br />Year: 1989","Month:  7<br />ave_temp:        NA<br />Year: 1989","Month:  8<br />ave_temp:        NA<br />Year: 1989","Month:  9<br />ave_temp: 15.440000<br />Year: 1989","Month: 10<br />ave_temp: 10.716129<br />Year: 1989","Month: 11<br />ave_temp:  7.256667<br />Year: 1989","Month: 12<br />ave_temp:  5.603226<br />Year: 1989"],"type":"scatter","mode":"lines","line":{"width":1.88976377952756,"color":"rgba(240,126,77,1)","dash":"solid"},"hoveron":"points","name":"1989","legendgroup":"1989","showlegend":true,"xaxis":"x","yaxis":"y","hoverinfo":"text","frame":null},{"x":[1,2,3,4,5,6,7,8,9,10,11,12],"y":[4.74193548387097,3.16071428571429,7.0258064516129,10.5966666666667,12.7483870967742,15.1333333333333,18.758064516129,19.1935483870968,16.1133333333333,10.0516129032258,6.99333333333333,5.54545454545455],"text":["Month:  1<br />ave_temp:  4.741935<br />Year: 1990","Month:  2<br />ave_temp:  3.160714<br />Year: 1990","Month:  3<br />ave_temp:  7.025806<br />Year: 1990","Month:  4<br />ave_temp: 10.596667<br />Year: 1990","Month:  5<br />ave_temp: 12.748387<br />Year: 1990","Month:  6<br />ave_temp: 15.133333<br />Year: 1990","Month:  7<br />ave_temp: 18.758065<br />Year: 1990","Month:  8<br />ave_temp: 19.193548<br />Year: 1990","Month:  9<br />ave_temp: 16.113333<br />Year: 1990","Month: 10<br />ave_temp: 10.051613<br />Year: 1990","Month: 11<br />ave_temp:  6.993333<br />Year: 1990","Month: 12<br />ave_temp:  5.545455<br />Year: 1990"],"type":"scatter","mode":"lines","line":{"width":1.88976377952756,"color":"rgba(231,134,25,1)","dash":"solid"},"hoveron":"points","name":"1990","legendgroup":"1990","showlegend":true,"xaxis":"x","yaxis":"y","hoverinfo":"text","frame":null},{"x":[1,2,3,4,5,6,7,8,9,10,11,12],"y":[3.7,7.325,5.82903225806452,9.53448275862069,12.4129032258065,14.27,17.8193548387097,18.0064516129032,15.2366666666667,10.5645161290323,8.44137931034483,7.06774193548387],"text":["Month:  1<br />ave_temp:  3.700000<br />Year: 1991","Month:  2<br />ave_temp:  7.325000<br />Year: 1991","Month:  3<br />ave_temp:  5.829032<br />Year: 1991","Month:  4<br />ave_temp:  9.534483<br />Year: 1991","Month:  5<br />ave_temp: 12.412903<br />Year: 1991","Month:  6<br />ave_temp: 14.270000<br />Year: 1991","Month:  7<br />ave_temp: 17.819355<br />Year: 1991","Month:  8<br />ave_temp: 18.006452<br />Year: 1991","Month:  9<br />ave_temp: 15.236667<br />Year: 1991","Month: 10<br />ave_temp: 10.564516<br />Year: 1991","Month: 11<br />ave_temp:  8.441379<br />Year: 1991","Month: 12<br />ave_temp:  7.067742<br />Year: 1991"],"type":"scatter","mode":"lines","line":{"width":1.88976377952756,"color":"rgba(219,142,0,1)","dash":"solid"},"hoveron":"points","name":"1991","legendgroup":"1991","showlegend":true,"xaxis":"x","yaxis":"y","hoverinfo":"text","frame":null},{"x":[1,2,3,4,5,6,7,8,9,10,11,12],"y":[7.45666666666667,8.23103448275862,9.83666666666667,11.4689655172414,15.1225806451613,18.5933333333333,19.4709677419355,18.9483870967742,15.1433333333333,12.4612903225806,8.00666666666667,3.90967741935484],"text":["Month:  1<br />ave_temp:  7.456667<br />Year: 1992","Month:  2<br />ave_temp:  8.231034<br />Year: 1992","Month:  3<br />ave_temp:  9.836667<br />Year: 1992","Month:  4<br />ave_temp: 11.468966<br />Year: 1992","Month:  5<br />ave_temp: 15.122581<br />Year: 1992","Month:  6<br />ave_temp: 18.593333<br />Year: 1992","Month:  7<br />ave_temp: 19.470968<br />Year: 1992","Month:  8<br />ave_temp: 18.948387<br />Year: 1992","Month:  9<br />ave_temp: 15.143333<br />Year: 1992","Month: 10<br />ave_temp: 12.461290<br />Year: 1992","Month: 11<br />ave_temp:  8.006667<br />Year: 1992","Month: 12<br />ave_temp:  3.909677<br />Year: 1992"],"type":"scatter","mode":"lines","line":{"width":1.88976377952756,"color":"rgba(206,149,0,1)","dash":"solid"},"hoveron":"points","name":"1992","legendgroup":"1992","showlegend":true,"xaxis":"x","yaxis":"y","hoverinfo":"text","frame":null},{"x":[1,2,3,4,5,6,7,8,9,10,11,12],"y":[2.30967741935484,5.22142857142857,8.80645161290323,10.84,15.7064516129032,16.9466666666667,17.541935483871,18.6483870967742,16.39,12.8548387096774,6.33,6.19032258064516],"text":["Month:  1<br />ave_temp:  2.309677<br />Year: 1993","Month:  2<br />ave_temp:  5.221429<br />Year: 1993","Month:  3<br />ave_temp:  8.806452<br />Year: 1993","Month:  4<br />ave_temp: 10.840000<br />Year: 1993","Month:  5<br />ave_temp: 15.706452<br />Year: 1993","Month:  6<br />ave_temp: 16.946667<br />Year: 1993","Month:  7<br />ave_temp: 17.541935<br />Year: 1993","Month:  8<br />ave_temp: 18.648387<br />Year: 1993","Month:  9<br />ave_temp: 16.390000<br />Year: 1993","Month: 10<br />ave_temp: 12.854839<br />Year: 1993","Month: 11<br />ave_temp:  6.330000<br />Year: 1993","Month: 12<br />ave_temp:  6.190323<br />Year: 1993"],"type":"scatter","mode":"lines","line":{"width":1.88976377952756,"color":"rgba(191,156,0,1)","dash":"solid"},"hoveron":"points","name":"1993","legendgroup":"1993","showlegend":true,"xaxis":"x","yaxis":"y","hoverinfo":"text","frame":null},{"x":[1,2,3,4,5,6,7,8,9,10,11,12],"y":[7.79032258064516,5.075,8.63225806451613,11.96,15.0258064516129,16.16,19.7774193548387,19.6612903225806,16.8333333333333,11.7290322580645,6.26,5.83870967741935],"text":["Month:  1<br />ave_temp:  7.790323<br />Year: 1994","Month:  2<br />ave_temp:  5.075000<br />Year: 1994","Month:  3<br />ave_temp:  8.632258<br />Year: 1994","Month:  4<br />ave_temp: 11.960000<br />Year: 1994","Month:  5<br />ave_temp: 15.025806<br />Year: 1994","Month:  6<br />ave_temp: 16.160000<br />Year: 1994","Month:  7<br />ave_temp: 19.777419<br />Year: 1994","Month:  8<br />ave_temp: 19.661290<br />Year: 1994","Month:  9<br />ave_temp: 16.833333<br />Year: 1994","Month: 10<br />ave_temp: 11.729032<br />Year: 1994","Month: 11<br />ave_temp:  6.260000<br />Year: 1994","Month: 12<br />ave_temp:  5.838710<br />Year: 1994"],"type":"scatter","mode":"lines","line":{"width":1.88976377952756,"color":"rgba(174,162,0,1)","dash":"solid"},"hoveron":"points","name":"1994","legendgroup":"1994","showlegend":true,"xaxis":"x","yaxis":"y","hoverinfo":"text","frame":null},{"x":[1,2,3,4,5,6,7,8,9,10,11,12],"y":[6.14516129032258,6.71071428571429,8.21612903225807,10.64,15.1483870967742,17.57,19.1516129032258,17.2903225806452,17.5633333333333,11.3354838709677,9.14666666666667,6.06129032258065],"text":["Month:  1<br />ave_temp:  6.145161<br />Year: 1995","Month:  2<br />ave_temp:  6.710714<br />Year: 1995","Month:  3<br />ave_temp:  8.216129<br />Year: 1995","Month:  4<br />ave_temp: 10.640000<br />Year: 1995","Month:  5<br />ave_temp: 15.148387<br />Year: 1995","Month:  6<br />ave_temp: 17.570000<br />Year: 1995","Month:  7<br />ave_temp: 19.151613<br />Year: 1995","Month:  8<br />ave_temp: 17.290323<br />Year: 1995","Month:  9<br />ave_temp: 17.563333<br />Year: 1995","Month: 10<br />ave_temp: 11.335484<br />Year: 1995","Month: 11<br />ave_temp:  9.146667<br />Year: 1995","Month: 12<br />ave_temp:  6.061290<br />Year: 1995"],"type":"scatter","mode":"lines","line":{"width":1.88976377952756,"color":"rgba(154,168,0,1)","dash":"solid"},"hoveron":"points","name":"1995","legendgroup":"1995","showlegend":true,"xaxis":"x","yaxis":"y","hoverinfo":"text","frame":null},{"x":[1,2,3,4,5,6,7,8,9,10,11,12],"y":[4.2741935483871,5.83103448275862,7.93548387096774,10.9266666666667,12.4516129032258,16.4033333333333,18.9064516129032,18.7967741935484,14.6666666666667,10.8064516129032,6.43666666666667,3.18709677419355],"text":["Month:  1<br />ave_temp:  4.274194<br />Year: 1996","Month:  2<br />ave_temp:  5.831034<br />Year: 1996","Month:  3<br />ave_temp:  7.935484<br />Year: 1996","Month:  4<br />ave_temp: 10.926667<br />Year: 1996","Month:  5<br />ave_temp: 12.451613<br />Year: 1996","Month:  6<br />ave_temp: 16.403333<br />Year: 1996","Month:  7<br />ave_temp: 18.906452<br />Year: 1996","Month:  8<br />ave_temp: 18.796774<br />Year: 1996","Month:  9<br />ave_temp: 14.666667<br />Year: 1996","Month: 10<br />ave_temp: 10.806452<br />Year: 1996","Month: 11<br />ave_temp:  6.436667<br />Year: 1996","Month: 12<br />ave_temp:  3.187097<br />Year: 1996"],"type":"scatter","mode":"lines","line":{"width":1.88976377952756,"color":"rgba(130,173,0,1)","dash":"solid"},"hoveron":"points","name":"1996","legendgroup":"1996","showlegend":true,"xaxis":"x","yaxis":"y","hoverinfo":"text","frame":null},{"x":[1,2,3,4,5,6,7,8,9,10,11,12],"y":[5.01612903225806,6.10769230769231,6.84193548387097,9.98620689655172,14.7677419354839,16.2533333333333,18.5064516129032,19.8548387096774,16.5814814814815,10.7933333333333,8.80666666666667,5.94193548387097],"text":["Month:  1<br />ave_temp:  5.016129<br />Year: 1997","Month:  2<br />ave_temp:  6.107692<br />Year: 1997","Month:  3<br />ave_temp:  6.841935<br />Year: 1997","Month:  4<br />ave_temp:  9.986207<br />Year: 1997","Month:  5<br />ave_temp: 14.767742<br />Year: 1997","Month:  6<br />ave_temp: 16.253333<br />Year: 1997","Month:  7<br />ave_temp: 18.506452<br />Year: 1997","Month:  8<br />ave_temp: 19.854839<br />Year: 1997","Month:  9<br />ave_temp: 16.581481<br />Year: 1997","Month: 10<br />ave_temp: 10.793333<br />Year: 1997","Month: 11<br />ave_temp:  8.806667<br />Year: 1997","Month: 12<br />ave_temp:  5.941935<br />Year: 1997"],"type":"scatter","mode":"lines","line":{"width":1.88976377952756,"color":"rgba(100,178,0,1)","dash":"solid"},"hoveron":"points","name":"1997","legendgroup":"1997","showlegend":true,"xaxis":"x","yaxis":"y","hoverinfo":"text","frame":null},{"x":[1,2,3,4,5,6,7,8,9,10,11,12],"y":[5.60714285714286,7.8,8.40322580645161,11.275,14.2,17.1466666666667,19.8354838709677,20.0387096774194,17.0566666666667,11.8064516129032,8.77333333333333,4.61612903225806],"text":["Month:  1<br />ave_temp:  5.607143<br />Year: 1998","Month:  2<br />ave_temp:  7.800000<br />Year: 1998","Month:  3<br />ave_temp:  8.403226<br />Year: 1998","Month:  4<br />ave_temp: 11.275000<br />Year: 1998","Month:  5<br />ave_temp: 14.200000<br />Year: 1998","Month:  6<br />ave_temp: 17.146667<br />Year: 1998","Month:  7<br />ave_temp: 19.835484<br />Year: 1998","Month:  8<br />ave_temp: 20.038710<br />Year: 1998","Month:  9<br />ave_temp: 17.056667<br />Year: 1998","Month: 10<br />ave_temp: 11.806452<br />Year: 1998","Month: 11<br />ave_temp:  8.773333<br />Year: 1998","Month: 12<br />ave_temp:  4.616129<br />Year: 1998"],"type":"scatter","mode":"lines","line":{"width":1.88976377952756,"color":"rgba(50,182,0,1)","dash":"solid"},"hoveron":"points","name":"1998","legendgroup":"1998","showlegend":true,"xaxis":"x","yaxis":"y","hoverinfo":"text","frame":null},{"x":[1,2,3,4,5,6,7,8,9,10,11,12],"y":[5.82258064516129,6.41785714285714,7.06451612903226,9.80333333333333,11.7322580645161,14.8266666666667,17.6645161290323,19.0322580645161,15.3466666666667,10.7322580645161,8.49333333333333,5.56774193548387],"text":["Month:  1<br />ave_temp:  5.822581<br />Year: 1999","Month:  2<br />ave_temp:  6.417857<br />Year: 1999","Month:  3<br />ave_temp:  7.064516<br />Year: 1999","Month:  4<br />ave_temp:  9.803333<br />Year: 1999","Month:  5<br />ave_temp: 11.732258<br />Year: 1999","Month:  6<br />ave_temp: 14.826667<br />Year: 1999","Month:  7<br />ave_temp: 17.664516<br />Year: 1999","Month:  8<br />ave_temp: 19.032258<br />Year: 1999","Month:  9<br />ave_temp: 15.346667<br />Year: 1999","Month: 10<br />ave_temp: 10.732258<br />Year: 1999","Month: 11<br />ave_temp:  8.493333<br />Year: 1999","Month: 12<br />ave_temp:  5.567742<br />Year: 1999"],"type":"scatter","mode":"lines","line":{"width":1.88976377952756,"color":"rgba(0,186,56,1)","dash":"solid"},"hoveron":"points","name":"1999","legendgroup":"1999","showlegend":true,"xaxis":"x","yaxis":"y","hoverinfo":"text","frame":null},{"x":[1,2,3,4,5,6,7,8,9,10,11,12],"y":[4.48064516129032,6.20344827586207,7.90967741935484,10.96,12.4064516129032,16.4633333333333,18.1903225806452,18.1903225806452,15.82,11.458064516129,6.8,5.10967741935484],"text":["Month:  1<br />ave_temp:  4.480645<br />Year: 2000","Month:  2<br />ave_temp:  6.203448<br />Year: 2000","Month:  3<br />ave_temp:  7.909677<br />Year: 2000","Month:  4<br />ave_temp: 10.960000<br />Year: 2000","Month:  5<br />ave_temp: 12.406452<br />Year: 2000","Month:  6<br />ave_temp: 16.463333<br />Year: 2000","Month:  7<br />ave_temp: 18.190323<br />Year: 2000","Month:  8<br />ave_temp: 18.190323<br />Year: 2000","Month:  9<br />ave_temp: 15.820000<br />Year: 2000","Month: 10<br />ave_temp: 11.458065<br />Year: 2000","Month: 11<br />ave_temp:  6.800000<br />Year: 2000","Month: 12<br />ave_temp:  5.109677<br />Year: 2000"],"type":"scatter","mode":"lines","line":{"width":1.88976377952756,"color":"rgba(0,189,92,1)","dash":"solid"},"hoveron":"points","name":"2000","legendgroup":"2000","showlegend":true,"xaxis":"x","yaxis":"y","hoverinfo":"text","frame":null},{"x":[1,2,3,4,5,6,7,8,9,10,11,12],"y":[6.68387096774194,5.9,8.29032258064516,10.9214285714286,13.11,15.2933333333333,17.8032258064516,18.0387096774194,15.4166666666667,10.3870967741935,8.66333333333333,4.52941176470588],"text":["Month:  1<br />ave_temp:  6.683871<br />Year: 2001","Month:  2<br />ave_temp:  5.900000<br />Year: 2001","Month:  3<br />ave_temp:  8.290323<br />Year: 2001","Month:  4<br />ave_temp: 10.921429<br />Year: 2001","Month:  5<br />ave_temp: 13.110000<br />Year: 2001","Month:  6<br />ave_temp: 15.293333<br />Year: 2001","Month:  7<br />ave_temp: 17.803226<br />Year: 2001","Month:  8<br />ave_temp: 18.038710<br />Year: 2001","Month:  9<br />ave_temp: 15.416667<br />Year: 2001","Month: 10<br />ave_temp: 10.387097<br />Year: 2001","Month: 11<br />ave_temp:  8.663333<br />Year: 2001","Month: 12<br />ave_temp:  4.529412<br />Year: 2001"],"type":"scatter","mode":"lines","line":{"width":1.88976377952756,"color":"rgba(0,191,120,1)","dash":"solid"},"hoveron":"points","name":"2001","legendgroup":"2001","showlegend":true,"xaxis":"x","yaxis":"y","hoverinfo":"text","frame":null},{"x":[1,2,3,4,5,6,7,8,9,10,11,12],"y":[5.15806451612903,5.65,5.04838709677419,9.31,12.1322580645161,16.9766666666667,18.5322580645161,18.4483870967742,15.22,10.3677419354839,8.51666666666667,6.31290322580645],"text":["Month:  1<br />ave_temp:  5.158065<br />Year: 2002","Month:  2<br />ave_temp:  5.650000<br />Year: 2002","Month:  3<br />ave_temp:  5.048387<br />Year: 2002","Month:  4<br />ave_temp:  9.310000<br />Year: 2002","Month:  5<br />ave_temp: 12.132258<br />Year: 2002","Month:  6<br />ave_temp: 16.976667<br />Year: 2002","Month:  7<br />ave_temp: 18.532258<br />Year: 2002","Month:  8<br />ave_temp: 18.448387<br />Year: 2002","Month:  9<br />ave_temp: 15.220000<br />Year: 2002","Month: 10<br />ave_temp: 10.367742<br />Year: 2002","Month: 11<br />ave_temp:  8.516667<br />Year: 2002","Month: 12<br />ave_temp:  6.312903<br />Year: 2002"],"type":"scatter","mode":"lines","line":{"width":1.88976377952756,"color":"rgba(0,192,145,1)","dash":"solid"},"hoveron":"points","name":"2002","legendgroup":"2002","showlegend":true,"xaxis":"x","yaxis":"y","hoverinfo":"text","frame":null},{"x":[1,2,3,4,5,6,7,8,9,10,11,12],"y":[7.17096774193548,5.48928571428571,7.86129032258065,9.61666666666667,14.9571428571429,17.1566666666667,19.4451612903226,18.9741935483871,16.0433333333333,11.8612903225806,5.41333333333333,5.45161290322581],"text":["Month:  1<br />ave_temp:  7.170968<br />Year: 2003","Month:  2<br />ave_temp:  5.489286<br />Year: 2003","Month:  3<br />ave_temp:  7.861290<br />Year: 2003","Month:  4<br />ave_temp:  9.616667<br />Year: 2003","Month:  5<br />ave_temp: 14.957143<br />Year: 2003","Month:  6<br />ave_temp: 17.156667<br />Year: 2003","Month:  7<br />ave_temp: 19.445161<br />Year: 2003","Month:  8<br />ave_temp: 18.974194<br />Year: 2003","Month:  9<br />ave_temp: 16.043333<br />Year: 2003","Month: 10<br />ave_temp: 11.861290<br />Year: 2003","Month: 11<br />ave_temp:  5.413333<br />Year: 2003","Month: 12<br />ave_temp:  5.451613<br />Year: 2003"],"type":"scatter","mode":"lines","line":{"width":1.88976377952756,"color":"rgba(0,193,167,1)","dash":"solid"},"hoveron":"points","name":"2003","legendgroup":"2003","showlegend":true,"xaxis":"x","yaxis":"y","hoverinfo":"text","frame":null},{"x":[1,2,3,4,5,6,7,8,9,10,11,12],"y":[4.79677419354839,6.73448275862069,8.53548387096774,11.8233333333333,14.4096774193548,17.5533333333333,19.9161290322581,19.5129032258065,14.7633333333333,11.3129032258065,7.27,5.89354838709677],"text":["Month:  1<br />ave_temp:  4.796774<br />Year: 2004","Month:  2<br />ave_temp:  6.734483<br />Year: 2004","Month:  3<br />ave_temp:  8.535484<br />Year: 2004","Month:  4<br />ave_temp: 11.823333<br />Year: 2004","Month:  5<br />ave_temp: 14.409677<br />Year: 2004","Month:  6<br />ave_temp: 17.553333<br />Year: 2004","Month:  7<br />ave_temp: 19.916129<br />Year: 2004","Month:  8<br />ave_temp: 19.512903<br />Year: 2004","Month:  9<br />ave_temp: 14.763333<br />Year: 2004","Month: 10<br />ave_temp: 11.312903<br />Year: 2004","Month: 11<br />ave_temp:  7.270000<br />Year: 2004","Month: 12<br />ave_temp:  5.893548<br />Year: 2004"],"type":"scatter","mode":"lines","line":{"width":1.88976377952756,"color":"rgba(0,192,187,1)","dash":"solid"},"hoveron":"points","name":"2004","legendgroup":"2004","showlegend":true,"xaxis":"x","yaxis":"y","hoverinfo":"text","frame":null},{"x":[1,2,3,4,5,6,7,8,9,10,11,12],"y":[4.80645161290323,5.2,8.85483870967742,10.6966666666667,14.6451612903226,15.68,18.1322580645161,19.0903225806452,14.5444444444444,11.6064516129032,6.09333333333333,5.09354838709677],"text":["Month:  1<br />ave_temp:  4.806452<br />Year: 2005","Month:  2<br />ave_temp:  5.200000<br />Year: 2005","Month:  3<br />ave_temp:  8.854839<br />Year: 2005","Month:  4<br />ave_temp: 10.696667<br />Year: 2005","Month:  5<br />ave_temp: 14.645161<br />Year: 2005","Month:  6<br />ave_temp: 15.680000<br />Year: 2005","Month:  7<br />ave_temp: 18.132258<br />Year: 2005","Month:  8<br />ave_temp: 19.090323<br />Year: 2005","Month:  9<br />ave_temp: 14.544444<br />Year: 2005","Month: 10<br />ave_temp: 11.606452<br />Year: 2005","Month: 11<br />ave_temp:  6.093333<br />Year: 2005","Month: 12<br />ave_temp:  5.093548<br />Year: 2005"],"type":"scatter","mode":"lines","line":{"width":1.88976377952756,"color":"rgba(0,190,205,1)","dash":"solid"},"hoveron":"points","name":"2005","legendgroup":"2005","showlegend":true,"xaxis":"x","yaxis":"y","hoverinfo":"text","frame":null},{"x":[1,2,3,4,5,6,7,8,9,10,11,12],"y":[6.62903225806452,5,7.17142857142857,10.0103448275862,13.1258064516129,16.6066666666667,18.8032258064516,17.5193548387097,15.4533333333333,10.1516129032258,5.86333333333333,5.27096774193548],"text":["Month:  1<br />ave_temp:  6.629032<br />Year: 2006","Month:  2<br />ave_temp:  5.000000<br />Year: 2006","Month:  3<br />ave_temp:  7.171429<br />Year: 2006","Month:  4<br />ave_temp: 10.010345<br />Year: 2006","Month:  5<br />ave_temp: 13.125806<br />Year: 2006","Month:  6<br />ave_temp: 16.606667<br />Year: 2006","Month:  7<br />ave_temp: 18.803226<br />Year: 2006","Month:  8<br />ave_temp: 17.519355<br />Year: 2006","Month:  9<br />ave_temp: 15.453333<br />Year: 2006","Month: 10<br />ave_temp: 10.151613<br />Year: 2006","Month: 11<br />ave_temp:  5.863333<br />Year: 2006","Month: 12<br />ave_temp:  5.270968<br />Year: 2006"],"type":"scatter","mode":"lines","line":{"width":1.88976377952756,"color":"rgba(0,186,222,1)","dash":"solid"},"hoveron":"points","name":"2006","legendgroup":"2006","showlegend":true,"xaxis":"x","yaxis":"y","hoverinfo":"text","frame":null},{"x":[1,2,3,4,5,6,7,8,9,10,11,12],"y":[3.56451612903226,3.6,7.31612903225806,9.07931034482759,null,15.7222222222222,19.3290322580645,18.1633333333333,14.7033333333333,10.72,5.64736842105263,4.22666666666667],"text":["Month:  1<br />ave_temp:  3.564516<br />Year: 2007","Month:  2<br />ave_temp:  3.600000<br />Year: 2007","Month:  3<br />ave_temp:  7.316129<br />Year: 2007","Month:  4<br />ave_temp:  9.079310<br />Year: 2007","Month:  5<br />ave_temp:        NA<br />Year: 2007","Month:  6<br />ave_temp: 15.722222<br />Year: 2007","Month:  7<br />ave_temp: 19.329032<br />Year: 2007","Month:  8<br />ave_temp: 18.163333<br />Year: 2007","Month:  9<br />ave_temp: 14.703333<br />Year: 2007","Month: 10<br />ave_temp: 10.720000<br />Year: 2007","Month: 11<br />ave_temp:  5.647368<br />Year: 2007","Month: 12<br />ave_temp:  4.226667<br />Year: 2007"],"type":"scatter","mode":"lines","line":{"width":1.88976377952756,"color":"rgba(0,181,237,1)","dash":"solid"},"hoveron":"points","name":"2007","legendgroup":"2007","showlegend":true,"xaxis":"x","yaxis":"y","hoverinfo":"text","frame":null},{"x":[1,2,3,4,5,6,7,8,9,10,11,12],"y":[3.76451612903226,6.06206896551724,6.44838709677419,7.98333333333333,13.3129032258065,14.65,18.3806451612903,17.7903225806452,15.0366666666667,10.6225806451613,8.67666666666667,2.46451612903226],"text":["Month:  1<br />ave_temp:  3.764516<br />Year: 2008","Month:  2<br />ave_temp:  6.062069<br />Year: 2008","Month:  3<br />ave_temp:  6.448387<br />Year: 2008","Month:  4<br />ave_temp:  7.983333<br />Year: 2008","Month:  5<br />ave_temp: 13.312903<br />Year: 2008","Month:  6<br />ave_temp: 14.650000<br />Year: 2008","Month:  7<br />ave_temp: 18.380645<br />Year: 2008","Month:  8<br />ave_temp: 17.790323<br />Year: 2008","Month:  9<br />ave_temp: 15.036667<br />Year: 2008","Month: 10<br />ave_temp: 10.622581<br />Year: 2008","Month: 11<br />ave_temp:  8.676667<br />Year: 2008","Month: 12<br />ave_temp:  2.464516<br />Year: 2008"],"type":"scatter","mode":"lines","line":{"width":1.88976377952756,"color":"rgba(0,174,249,1)","dash":"solid"},"hoveron":"points","name":"2008","legendgroup":"2008","showlegend":true,"xaxis":"x","yaxis":"y","hoverinfo":"text","frame":null},{"x":[1,2,3,4,5,6,7,8,9,10,11,12],"y":[2.80322580645161,5.28928571428571,5.30322580645161,9.65,13.2838709677419,17.7166666666667,19.941935483871,18.6935483870968,16.06,10.7451612903226,7.61724137931034,4.05925925925926],"text":["Month:  1<br />ave_temp:  2.803226<br />Year: 2009","Month:  2<br />ave_temp:  5.289286<br />Year: 2009","Month:  3<br />ave_temp:  5.303226<br />Year: 2009","Month:  4<br />ave_temp:  9.650000<br />Year: 2009","Month:  5<br />ave_temp: 13.283871<br />Year: 2009","Month:  6<br />ave_temp: 17.716667<br />Year: 2009","Month:  7<br />ave_temp: 19.941935<br />Year: 2009","Month:  8<br />ave_temp: 18.693548<br />Year: 2009","Month:  9<br />ave_temp: 16.060000<br />Year: 2009","Month: 10<br />ave_temp: 10.745161<br />Year: 2009","Month: 11<br />ave_temp:  7.617241<br />Year: 2009","Month: 12<br />ave_temp:  4.059259<br />Year: 2009"],"type":"scatter","mode":"lines","line":{"width":1.88976377952756,"color":"rgba(0,166,255,1)","dash":"solid"},"hoveron":"points","name":"2009","legendgroup":"2009","showlegend":true,"xaxis":"x","yaxis":"y","hoverinfo":"text","frame":null},{"x":[1,2,3,4,5,6,7,8,9,10,11,12],"y":[7.8258064516129,8.05357142857143,8.4,9.97,12.7307692307692,15.5,18.5653846153846,18.7870967741935,15.59,11.9133333333333,5.97,5.90967741935484],"text":["Month:  1<br />ave_temp:  7.825806<br />Year: 2010","Month:  2<br />ave_temp:  8.053571<br />Year: 2010","Month:  3<br />ave_temp:  8.400000<br />Year: 2010","Month:  4<br />ave_temp:  9.970000<br />Year: 2010","Month:  5<br />ave_temp: 12.730769<br />Year: 2010","Month:  6<br />ave_temp: 15.500000<br />Year: 2010","Month:  7<br />ave_temp: 18.565385<br />Year: 2010","Month:  8<br />ave_temp: 18.787097<br />Year: 2010","Month:  9<br />ave_temp: 15.590000<br />Year: 2010","Month: 10<br />ave_temp: 11.913333<br />Year: 2010","Month: 11<br />ave_temp:  5.970000<br />Year: 2010","Month: 12<br />ave_temp:  5.909677<br />Year: 2010"],"type":"scatter","mode":"lines","line":{"width":1.88976377952756,"color":"rgba(97,156,255,1)","dash":"solid"},"hoveron":"points","name":"2010","legendgroup":"2010","showlegend":true,"xaxis":"x","yaxis":"y","hoverinfo":"text","frame":null},{"x":[1,2,3,4,5,6,7,8,9,10,11,12],"y":[4.8,4.00714285714286,6.63529411764706,null,null,null,null,18.5636363636364,16.4448275862069,10.6354838709677,6.06333333333333,4.86451612903226],"text":["Month:  1<br />ave_temp:  4.800000<br />Year: 2011","Month:  2<br />ave_temp:  4.007143<br />Year: 2011","Month:  3<br />ave_temp:  6.635294<br />Year: 2011","Month:  4<br />ave_temp:        NA<br />Year: 2011","Month:  5<br />ave_temp:        NA<br />Year: 2011","Month:  6<br />ave_temp:        NA<br />Year: 2011","Month:  7<br />ave_temp:        NA<br />Year: 2011","Month:  8<br />ave_temp: 18.563636<br />Year: 2011","Month:  9<br />ave_temp: 16.444828<br />Year: 2011","Month: 10<br />ave_temp: 10.635484<br />Year: 2011","Month: 11<br />ave_temp:  6.063333<br />Year: 2011","Month: 12<br />ave_temp:  4.864516<br />Year: 2011"],"type":"scatter","mode":"lines","line":{"width":1.88976377952756,"color":"rgba(145,145,255,1)","dash":"solid"},"hoveron":"points","name":"2011","legendgroup":"2011","showlegend":true,"xaxis":"x","yaxis":"y","hoverinfo":"text","frame":null},{"x":[1,2,3,4,5,6,7,8,9,10,11,12],"y":[4.3,5.77586206896552,6.00967741935484,10.08,12.4258064516129,14.4066666666667,18.1387096774194,19.1806451612903,15.5733333333333,10.7193548387097,7.85333333333333,5.24074074074074],"text":["Month:  1<br />ave_temp:  4.300000<br />Year: 2012","Month:  2<br />ave_temp:  5.775862<br />Year: 2012","Month:  3<br />ave_temp:  6.009677<br />Year: 2012","Month:  4<br />ave_temp: 10.080000<br />Year: 2012","Month:  5<br />ave_temp: 12.425806<br />Year: 2012","Month:  6<br />ave_temp: 14.406667<br />Year: 2012","Month:  7<br />ave_temp: 18.138710<br />Year: 2012","Month:  8<br />ave_temp: 19.180645<br />Year: 2012","Month:  9<br />ave_temp: 15.573333<br />Year: 2012","Month: 10<br />ave_temp: 10.719355<br />Year: 2012","Month: 11<br />ave_temp:  7.853333<br />Year: 2012","Month: 12<br />ave_temp:  5.240741<br />Year: 2012"],"type":"scatter","mode":"lines","line":{"width":1.88976377952756,"color":"rgba(179,133,255,1)","dash":"solid"},"hoveron":"points","name":"2012","legendgroup":"2012","showlegend":true,"xaxis":"x","yaxis":"y","hoverinfo":"text","frame":null},{"x":[1,2,3,4,5,6,7,8,9,10,11,12],"y":[3.66896551724138,5.68571428571429,7.62258064516129,9.90666666666667,13.8741935483871,16.1392857142857,19.4931034482759,19.541935483871,16.2,10.1193548387097,7.16333333333333,3.85483870967742],"text":["Month:  1<br />ave_temp:  3.668966<br />Year: 2013","Month:  2<br />ave_temp:  5.685714<br />Year: 2013","Month:  3<br />ave_temp:  7.622581<br />Year: 2013","Month:  4<br />ave_temp:  9.906667<br />Year: 2013","Month:  5<br />ave_temp: 13.874194<br />Year: 2013","Month:  6<br />ave_temp: 16.139286<br />Year: 2013","Month:  7<br />ave_temp: 19.493103<br />Year: 2013","Month:  8<br />ave_temp: 19.541935<br />Year: 2013","Month:  9<br />ave_temp: 16.200000<br />Year: 2013","Month: 10<br />ave_temp: 10.119355<br />Year: 2013","Month: 11<br />ave_temp:  7.163333<br />Year: 2013","Month: 12<br />ave_temp:  3.854839<br />Year: 2013"],"type":"scatter","mode":"lines","line":{"width":1.88976377952756,"color":"rgba(205,121,255,1)","dash":"solid"},"hoveron":"points","name":"2013","legendgroup":"2013","showlegend":true,"xaxis":"x","yaxis":"y","hoverinfo":"text","frame":null},{"x":[1,2,3,4,5,6,7,8,9,10,11,12],"y":[5.36129032258065,3.712,7.40666666666667,10.6033333333333,15.0709677419355,16.45,19.7451612903226,20.2645161290323,16.5633333333333,13.4483870967742,7.21333333333333,6.2258064516129],"text":["Month:  1<br />ave_temp:  5.361290<br />Year: 2014","Month:  2<br />ave_temp:  3.712000<br />Year: 2014","Month:  3<br />ave_temp:  7.406667<br />Year: 2014","Month:  4<br />ave_temp: 10.603333<br />Year: 2014","Month:  5<br />ave_temp: 15.070968<br />Year: 2014","Month:  6<br />ave_temp: 16.450000<br />Year: 2014","Month:  7<br />ave_temp: 19.745161<br />Year: 2014","Month:  8<br />ave_temp: 20.264516<br />Year: 2014","Month:  9<br />ave_temp: 16.563333<br />Year: 2014","Month: 10<br />ave_temp: 13.448387<br />Year: 2014","Month: 11<br />ave_temp:  7.213333<br />Year: 2014","Month: 12<br />ave_temp:  6.225806<br />Year: 2014"],"type":"scatter","mode":"lines","line":{"width":1.88976377952756,"color":"rgba(225,111,248,1)","dash":"solid"},"hoveron":"points","name":"2014","legendgroup":"2014","showlegend":true,"xaxis":"x","yaxis":"y","hoverinfo":"text","frame":null},{"x":[1,2,3,4,5,6,7,8,9,10,11,12],"y":[6.90967741935484,8.52857142857143,9.40322580645161,10.2931034482759,15.8225806451613,19.0166666666667,20.2935483870968,19.1870967741935,14.6333333333333,12.7709677419355,6.51333333333333,6.47241379310345],"text":["Month:  1<br />ave_temp:  6.909677<br />Year: 2015","Month:  2<br />ave_temp:  8.528571<br />Year: 2015","Month:  3<br />ave_temp:  9.403226<br />Year: 2015","Month:  4<br />ave_temp: 10.293103<br />Year: 2015","Month:  5<br />ave_temp: 15.822581<br />Year: 2015","Month:  6<br />ave_temp: 19.016667<br />Year: 2015","Month:  7<br />ave_temp: 20.293548<br />Year: 2015","Month:  8<br />ave_temp: 19.187097<br />Year: 2015","Month:  9<br />ave_temp: 14.633333<br />Year: 2015","Month: 10<br />ave_temp: 12.770968<br />Year: 2015","Month: 11<br />ave_temp:  6.513333<br />Year: 2015","Month: 12<br />ave_temp:  6.472414<br />Year: 2015"],"type":"scatter","mode":"lines","line":{"width":1.88976377952756,"color":"rgba(239,103,235,1)","dash":"solid"},"hoveron":"points","name":"2015","legendgroup":"2015","showlegend":true,"xaxis":"x","yaxis":"y","hoverinfo":"text","frame":null},{"x":[1,2,3,4,5,6,7,8,9,10,11,12],"y":[6.03870967741936,7.93103448275862,9.14838709677419,13.0266666666667,15.0366666666667,16.8666666666667,19.0064516129032,19.1677419354839,15.0933333333333,11.541935483871,9.74666666666667,2.62],"text":["Month:  1<br />ave_temp:  6.038710<br />Year: 2016","Month:  2<br />ave_temp:  7.931034<br />Year: 2016","Month:  3<br />ave_temp:  9.148387<br />Year: 2016","Month:  4<br />ave_temp: 13.026667<br />Year: 2016","Month:  5<br />ave_temp: 15.036667<br />Year: 2016","Month:  6<br />ave_temp: 16.866667<br />Year: 2016","Month:  7<br />ave_temp: 19.006452<br />Year: 2016","Month:  8<br />ave_temp: 19.167742<br />Year: 2016","Month:  9<br />ave_temp: 15.093333<br />Year: 2016","Month: 10<br />ave_temp: 11.541935<br />Year: 2016","Month: 11<br />ave_temp:  9.746667<br />Year: 2016","Month: 12<br />ave_temp:  2.620000<br />Year: 2016"],"type":"scatter","mode":"lines","line":{"width":1.88976377952756,"color":"rgba(249,98,219,1)","dash":"solid"},"hoveron":"points","name":"2016","legendgroup":"2016","showlegend":true,"xaxis":"x","yaxis":"y","hoverinfo":"text","frame":null},{"x":[1,2,3,4,5,6,7,8,9,10,11,12],"y":[3.66129032258065,4.36785714285714,6.98387096774194,9.98666666666667,13.8133333333333,16.62,19.4967741935484,19.9166666666667,16.7733333333333,10.841935483871,7.51,3.97741935483871],"text":["Month:  1<br />ave_temp:  3.661290<br />Year: 2017","Month:  2<br />ave_temp:  4.367857<br />Year: 2017","Month:  3<br />ave_temp:  6.983871<br />Year: 2017","Month:  4<br />ave_temp:  9.986667<br />Year: 2017","Month:  5<br />ave_temp: 13.813333<br />Year: 2017","Month:  6<br />ave_temp: 16.620000<br />Year: 2017","Month:  7<br />ave_temp: 19.496774<br />Year: 2017","Month:  8<br />ave_temp: 19.916667<br />Year: 2017","Month:  9<br />ave_temp: 16.773333<br />Year: 2017","Month: 10<br />ave_temp: 10.841935<br />Year: 2017","Month: 11<br />ave_temp:  7.510000<br />Year: 2017","Month: 12<br />ave_temp:  3.977419<br />Year: 2017"],"type":"scatter","mode":"lines","line":{"width":1.88976377952756,"color":"rgba(255,97,202,1)","dash":"solid"},"hoveron":"points","name":"2017","legendgroup":"2017","showlegend":true,"xaxis":"x","yaxis":"y","hoverinfo":"text","frame":null},{"x":[1,2,3,4,5,6,7,8,9,10,11,12],"y":[6.3,4.15714285714286,7.13870967741935,10.1066666666667,16.0806451612903,16.6233333333333,20.1451612903226,19.4741935483871,15.2407407407407,11.2033333333333,8.69666666666667,6.14444444444444],"text":["Month:  1<br />ave_temp:  6.300000<br />Year: 2018","Month:  2<br />ave_temp:  4.157143<br />Year: 2018","Month:  3<br />ave_temp:  7.138710<br />Year: 2018","Month:  4<br />ave_temp: 10.106667<br />Year: 2018","Month:  5<br />ave_temp: 16.080645<br />Year: 2018","Month:  6<br />ave_temp: 16.623333<br />Year: 2018","Month:  7<br />ave_temp: 20.145161<br />Year: 2018","Month:  8<br />ave_temp: 19.474194<br />Year: 2018","Month:  9<br />ave_temp: 15.240741<br />Year: 2018","Month: 10<br />ave_temp: 11.203333<br />Year: 2018","Month: 11<br />ave_temp:  8.696667<br />Year: 2018","Month: 12<br />ave_temp:  6.144444<br />Year: 2018"],"type":"scatter","mode":"lines","line":{"width":1.88976377952756,"color":"rgba(255,99,182,1)","dash":"solid"},"hoveron":"points","name":"2018","legendgroup":"2018","showlegend":true,"xaxis":"x","yaxis":"y","hoverinfo":"text","frame":null},{"x":[1,2,3,4,5,6,7,8,9,10,11,12],"y":[6.18,2.27142857142857,7.61612903225806,10.3333333333333,15.2548387096774,17.6034482758621,19.3967741935484,19.6193548387097,16.2034482758621,9.76451612903226,7.56206896551724,6.29354838709677],"text":["Month:  1<br />ave_temp:  6.180000<br />Year: 2019","Month:  2<br />ave_temp:  2.271429<br />Year: 2019","Month:  3<br />ave_temp:  7.616129<br />Year: 2019","Month:  4<br />ave_temp: 10.333333<br />Year: 2019","Month:  5<br />ave_temp: 15.254839<br />Year: 2019","Month:  6<br />ave_temp: 17.603448<br />Year: 2019","Month:  7<br />ave_temp: 19.396774<br />Year: 2019","Month:  8<br />ave_temp: 19.619355<br />Year: 2019","Month:  9<br />ave_temp: 16.203448<br />Year: 2019","Month: 10<br />ave_temp:  9.764516<br />Year: 2019","Month: 11<br />ave_temp:  7.562069<br />Year: 2019","Month: 12<br />ave_temp:  6.293548<br />Year: 2019"],"type":"scatter","mode":"lines","line":{"width":1.88976377952756,"color":"rgba(255,104,160,1)","dash":"solid"},"hoveron":"points","name":"2019","legendgroup":"2019","showlegend":true,"xaxis":"x","yaxis":"y","hoverinfo":"text","frame":null},{"x":[1,2],"y":[6.6,4.4],"text":["Month:  1<br />ave_temp:  6.600000<br />Year: 2020","Month:  2<br />ave_temp:  4.400000<br />Year: 2020"],"type":"scatter","mode":"lines","line":{"width":1.88976377952756,"color":"rgba(253,111,136,1)","dash":"solid"},"hoveron":"points","name":"2020","legendgroup":"2020","showlegend":true,"xaxis":"x","yaxis":"y","hoverinfo":"text","frame":null}],"layout":{"margin":{"t":43.7625570776256,"r":7.30593607305936,"b":40.1826484018265,"l":37.2602739726027},"plot_bgcolor":"rgba(255,255,255,1)","paper_bgcolor":"rgba(255,255,255,1)","font":{"color":"rgba(0,0,0,1)","family":"","size":14.6118721461187},"title":{"text":"Ave. Mthly Temps. All Years","font":{"color":"rgba(0,0,0,1)","family":"","size":17.5342465753425},"x":0,"xref":"paper"},"xaxis":{"domain":[0,1],"automargin":true,"type":"linear","autorange":false,"range":[0.45,12.55],"tickmode":"array","ticktext":["1","2","3","4","5","6","7","8","9","10","11","12"],"tickvals":[1,2,3,4,5,6,7,8,9,10,11,12],"categoryorder":"array","categoryarray":["1","2","3","4","5","6","7","8","9","10","11","12"],"nticks":null,"ticks":"outside","tickcolor":"rgba(51,51,51,1)","ticklen":3.65296803652968,"tickwidth":0.66417600664176,"showticklabels":true,"tickfont":{"color":"rgba(77,77,77,1)","family":"","size":11.689497716895},"tickangle":-0,"showline":true,"linecolor":"rgba(0,0,0,1)","linewidth":0.66417600664176,"showgrid":false,"gridcolor":null,"gridwidth":0,"zeroline":false,"anchor":"y","title":{"text":"Month","font":{"color":"rgba(0,0,0,1)","family":"","size":14.6118721461187}},"hoverformat":".2f"},"yaxis":{"domain":[0,1],"automargin":true,"type":"linear","autorange":false,"range":[1.37032258064516,21.1946543778802],"tickmode":"array","ticktext":["5","10","15","20"],"tickvals":[5,10,15,20],"categoryorder":"array","categoryarray":["5","10","15","20"],"nticks":null,"ticks":"outside","tickcolor":"rgba(51,51,51,1)","ticklen":3.65296803652968,"tickwidth":0.66417600664176,"showticklabels":true,"tickfont":{"color":"rgba(77,77,77,1)","family":"","size":11.689497716895},"tickangle":-0,"showline":true,"linecolor":"rgba(0,0,0,1)","linewidth":0.66417600664176,"showgrid":false,"gridcolor":null,"gridwidth":0,"zeroline":false,"anchor":"x","title":{"text":"ave_temp","font":{"color":"rgba(0,0,0,1)","family":"","size":14.6118721461187}},"hoverformat":".2f"},"shapes":[{"type":"rect","fillcolor":null,"line":{"color":null,"width":0,"linetype":[]},"yref":"paper","xref":"paper","x0":0,"x1":1,"y0":0,"y1":1}],"showlegend":true,"legend":{"bgcolor":"rgba(255,255,255,1)","bordercolor":"transparent","borderwidth":1.88976377952756,"font":{"color":"rgba(0,0,0,1)","family":"","size":11.689497716895},"y":0.93503937007874},"annotations":[{"text":"Year","x":1.02,"y":1,"showarrow":false,"ax":0,"ay":0,"font":{"color":"rgba(0,0,0,1)","family":"","size":14.6118721461187},"xref":"paper","yref":"paper","textangle":-0,"xanchor":"left","yanchor":"bottom","legendTitle":true}],"hovermode":"closest","barmode":"relative"},"config":{"doubleClick":"reset","showSendToCloud":false},"source":"A","attrs":{"29084ec82b44":{"x":{},"y":{},"colour":{},"type":"scatter"}},"cur_data":"29084ec82b44","visdat":{"29084ec82b44":["function (y) ","x"]},"highlight":{"on":"plotly_click","persistent":false,"dynamic":false,"selectize":false,"opacityDim":0.2,"selected":{"opacity":1},"debounce":0},"shinyEvents":["plotly_hover","plotly_click","plotly_selected","plotly_relayout","plotly_brushed","plotly_brushing","plotly_clickannotation","plotly_doubleclick","plotly_deselect","plotly_afterplot"],"base_url":"https://plot.ly"},"evals":[],"jsHooks":[]}</script>
<!--/html_preserve-->
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
