# dplyr-intro
David Parker  
Wednesday, September 24, 2014  

tutorial from [R Bloggers](http://rpubs.com/justmarkham/dplyr-tutorial)



```r
# library(plyr)
# detach(package:plyr)
suppressMessages( library(dplyr) )
library(hflights)
data(hflights)
head(hflights)
```

```
##      Year Month DayofMonth DayOfWeek DepTime ArrTime UniqueCarrier
## 5424 2011     1          1         6    1400    1500            AA
## 5425 2011     1          2         7    1401    1501            AA
## 5426 2011     1          3         1    1352    1502            AA
## 5427 2011     1          4         2    1403    1513            AA
## 5428 2011     1          5         3    1405    1507            AA
## 5429 2011     1          6         4    1359    1503            AA
##      FlightNum TailNum ActualElapsedTime AirTime ArrDelay DepDelay Origin
## 5424       428  N576AA                60      40      -10        0    IAH
## 5425       428  N557AA                60      45       -9        1    IAH
## 5426       428  N541AA                70      48       -8       -8    IAH
## 5427       428  N403AA                70      39        3        3    IAH
## 5428       428  N492AA                62      44       -3        5    IAH
## 5429       428  N262AA                64      45       -7       -1    IAH
##      Dest Distance TaxiIn TaxiOut Cancelled CancellationCode Diverted
## 5424  DFW      224      7      13         0                         0
## 5425  DFW      224      6       9         0                         0
## 5426  DFW      224      5      17         0                         0
## 5427  DFW      224      9      22         0                         0
## 5428  DFW      224      9       9         0                         0
## 5429  DFW      224      6      13         0                         0
```

* `tbl_df` creates a local data frame
* This is a wrapper for data frame, prevents accidental printing


```r
flights <- tbl_df(hflights)

# samply table data frame prnting
flights
```

```
## Source: local data frame [227,496 x 21]
## 
##      Year Month DayofMonth DayOfWeek DepTime ArrTime UniqueCarrier
## 5424 2011     1          1         6    1400    1500            AA
## 5425 2011     1          2         7    1401    1501            AA
## 5426 2011     1          3         1    1352    1502            AA
## 5427 2011     1          4         2    1403    1513            AA
## 5428 2011     1          5         3    1405    1507            AA
## 5429 2011     1          6         4    1359    1503            AA
## 5430 2011     1          7         5    1359    1509            AA
## 5431 2011     1          8         6    1355    1454            AA
## 5432 2011     1          9         7    1443    1554            AA
## 5433 2011     1         10         1    1443    1553            AA
## ..    ...   ...        ...       ...     ...     ...           ...
## Variables not shown: FlightNum (int), TailNum (chr), ActualElapsedTime
##   (int), AirTime (int), ArrDelay (int), DepDelay (int), Origin (chr), Dest
##   (chr), Distance (int), TaxiIn (int), TaxiOut (int), Cancelled (int),
##   CancellationCode (chr), Diverted (int)
```

```r
print(flights, n=20)
```

```
## Source: local data frame [227,496 x 21]
## 
##      Year Month DayofMonth DayOfWeek DepTime ArrTime UniqueCarrier
## 5424 2011     1          1         6    1400    1500            AA
## 5425 2011     1          2         7    1401    1501            AA
## 5426 2011     1          3         1    1352    1502            AA
## 5427 2011     1          4         2    1403    1513            AA
## 5428 2011     1          5         3    1405    1507            AA
## 5429 2011     1          6         4    1359    1503            AA
## 5430 2011     1          7         5    1359    1509            AA
## 5431 2011     1          8         6    1355    1454            AA
## 5432 2011     1          9         7    1443    1554            AA
## 5433 2011     1         10         1    1443    1553            AA
## 5434 2011     1         11         2    1429    1539            AA
## 5435 2011     1         12         3    1419    1515            AA
## 5436 2011     1         13         4    1358    1501            AA
## 5437 2011     1         14         5    1357    1504            AA
## 5438 2011     1         15         6    1359    1459            AA
## 5439 2011     1         16         7    1359    1509            AA
## 5440 2011     1         17         1    1530    1634            AA
## 5441 2011     1         18         2    1408    1508            AA
## 5442 2011     1         19         3    1356    1503            AA
## 5443 2011     1         20         4    1507    1622            AA
## ..    ...   ...        ...       ...     ...     ...           ...
## Variables not shown: FlightNum (int), TailNum (chr), ActualElapsedTime
##   (int), AirTime (int), ArrDelay (int), DepDelay (int), Origin (chr), Dest
##   (chr), Distance (int), TaxiIn (int), TaxiOut (int), Cancelled (int),
##   CancellationCode (chr), Diverted (int)
```

```r
data.frame(head(flights))
```

```
##      Year Month DayofMonth DayOfWeek DepTime ArrTime UniqueCarrier
## 5424 2011     1          1         6    1400    1500            AA
## 5425 2011     1          2         7    1401    1501            AA
## 5426 2011     1          3         1    1352    1502            AA
## 5427 2011     1          4         2    1403    1513            AA
## 5428 2011     1          5         3    1405    1507            AA
## 5429 2011     1          6         4    1359    1503            AA
##      FlightNum TailNum ActualElapsedTime AirTime ArrDelay DepDelay Origin
## 5424       428  N576AA                60      40      -10        0    IAH
## 5425       428  N557AA                60      45       -9        1    IAH
## 5426       428  N541AA                70      48       -8       -8    IAH
## 5427       428  N403AA                70      39        3        3    IAH
## 5428       428  N492AA                62      44       -3        5    IAH
## 5429       428  N262AA                64      45       -7       -1    IAH
##      Dest Distance TaxiIn TaxiOut Cancelled CancellationCode Diverted
## 5424  DFW      224      7      13         0                         0
## 5425  DFW      224      6       9         0                         0
## 5426  DFW      224      5      17         0                         0
## 5427  DFW      224      9      22         0                         0
## 5428  DFW      224      9       9         0                         0
## 5429  DFW      224      6      13         0                         0
```

```r
# or
head(hflights)
```

```
##      Year Month DayofMonth DayOfWeek DepTime ArrTime UniqueCarrier
## 5424 2011     1          1         6    1400    1500            AA
## 5425 2011     1          2         7    1401    1501            AA
## 5426 2011     1          3         1    1352    1502            AA
## 5427 2011     1          4         2    1403    1513            AA
## 5428 2011     1          5         3    1405    1507            AA
## 5429 2011     1          6         4    1359    1503            AA
##      FlightNum TailNum ActualElapsedTime AirTime ArrDelay DepDelay Origin
## 5424       428  N576AA                60      40      -10        0    IAH
## 5425       428  N557AA                60      45       -9        1    IAH
## 5426       428  N541AA                70      48       -8       -8    IAH
## 5427       428  N403AA                70      39        3        3    IAH
## 5428       428  N492AA                62      44       -3        5    IAH
## 5429       428  N262AA                64      45       -7       -1    IAH
##      Dest Distance TaxiIn TaxiOut Cancelled CancellationCode Diverted
## 5424  DFW      224      7      13         0                         0
## 5425  DFW      224      6       9         0                         0
## 5426  DFW      224      5      17         0                         0
## 5427  DFW      224      9      22         0                         0
## 5428  DFW      224      9       9         0                         0
## 5429  DFW      224      6      13         0                         0
```

## verb 1  
## filter: Keep matching critera


```r
# First, base R approach
flights[flights$Month == 1 & flights$DayofMonth == 1, ]
```

```
## Source: local data frame [552 x 21]
## 
##       Year Month DayofMonth DayOfWeek DepTime ArrTime UniqueCarrier
## 5424  2011     1          1         6    1400    1500            AA
## 6343  2011     1          1         6     728     840            AA
## 19266 2011     1          1         6    1631    1736            AA
## 23655 2011     1          1         6    1756    2112            AA
## 33051 2011     1          1         6    1012    1347            AA
## 35256 2011     1          1         6    1211    1325            AA
## 39453 2011     1          1         6     557     906            AA
## 46433 2011     1          1         6    1824    2106            AS
## 57719 2011     1          1         6     654    1124            B6
## 57720 2011     1          1         6    1639    2110            B6
## ..     ...   ...        ...       ...     ...     ...           ...
## Variables not shown: FlightNum (int), TailNum (chr), ActualElapsedTime
##   (int), AirTime (int), ArrDelay (int), DepDelay (int), Origin (chr), Dest
##   (chr), Distance (int), TaxiIn (int), TaxiOut (int), Cancelled (int),
##   CancellationCode (chr), Diverted (int)
```

Dplyr filter


```r
# dplyr approach
# comma defaults to &
filter(flights, Month == 1 & DayofMonth == 1)
```

```
## Source: local data frame [552 x 21]
## 
##    Year Month DayofMonth DayOfWeek DepTime ArrTime UniqueCarrier FlightNum
## 1  2011     1          1         6    1400    1500            AA       428
## 2  2011     1          1         6     728     840            AA       460
## 3  2011     1          1         6    1631    1736            AA      1121
## 4  2011     1          1         6    1756    2112            AA      1294
## 5  2011     1          1         6    1012    1347            AA      1700
## 6  2011     1          1         6    1211    1325            AA      1820
## 7  2011     1          1         6     557     906            AA      1994
## 8  2011     1          1         6    1824    2106            AS       731
## 9  2011     1          1         6     654    1124            B6       620
## 10 2011     1          1         6    1639    2110            B6       622
## ..  ...   ...        ...       ...     ...     ...           ...       ...
## Variables not shown: TailNum (chr), ActualElapsedTime (int), AirTime
##   (int), ArrDelay (int), DepDelay (int), Origin (chr), Dest (chr),
##   Distance (int), TaxiIn (int), TaxiOut (int), Cancelled (int),
##   CancellationCode (chr), Diverted (int)
```

```r
# use | for or
filter(flights, UniqueCarrier == "AA" | UniqueCarrier == "UA")
```

```
## Source: local data frame [5,316 x 21]
## 
##    Year Month DayofMonth DayOfWeek DepTime ArrTime UniqueCarrier FlightNum
## 1  2011     1          1         6    1400    1500            AA       428
## 2  2011     1          2         7    1401    1501            AA       428
## 3  2011     1          3         1    1352    1502            AA       428
## 4  2011     1          4         2    1403    1513            AA       428
## 5  2011     1          5         3    1405    1507            AA       428
## 6  2011     1          6         4    1359    1503            AA       428
## 7  2011     1          7         5    1359    1509            AA       428
## 8  2011     1          8         6    1355    1454            AA       428
## 9  2011     1          9         7    1443    1554            AA       428
## 10 2011     1         10         1    1443    1553            AA       428
## ..  ...   ...        ...       ...     ...     ...           ...       ...
## Variables not shown: TailNum (chr), ActualElapsedTime (int), AirTime
##   (int), ArrDelay (int), DepDelay (int), Origin (chr), Dest (chr),
##   Distance (int), TaxiIn (int), TaxiOut (int), Cancelled (int),
##   CancellationCode (chr), Diverted (int)
```

```r
# %in% works as well
filter(flights, UniqueCarrier %in% c("AA", "UA") )
```

```
## Source: local data frame [5,316 x 21]
## 
##    Year Month DayofMonth DayOfWeek DepTime ArrTime UniqueCarrier FlightNum
## 1  2011     1          1         6    1400    1500            AA       428
## 2  2011     1          2         7    1401    1501            AA       428
## 3  2011     1          3         1    1352    1502            AA       428
## 4  2011     1          4         2    1403    1513            AA       428
## 5  2011     1          5         3    1405    1507            AA       428
## 6  2011     1          6         4    1359    1503            AA       428
## 7  2011     1          7         5    1359    1509            AA       428
## 8  2011     1          8         6    1355    1454            AA       428
## 9  2011     1          9         7    1443    1554            AA       428
## 10 2011     1         10         1    1443    1553            AA       428
## ..  ...   ...        ...       ...     ...     ...           ...       ...
## Variables not shown: TailNum (chr), ActualElapsedTime (int), AirTime
##   (int), ArrDelay (int), DepDelay (int), Origin (chr), Dest (chr),
##   Distance (int), TaxiIn (int), TaxiOut (int), Cancelled (int),
##   CancellationCode (chr), Diverted (int)
```

## Verb 2  
## select: Pck columns by name  


```r
# base R
flights[, c("DepTime", "ArrTime", "FlightNum")]
```

```
## Source: local data frame [227,496 x 3]
## 
##      DepTime ArrTime FlightNum
## 5424    1400    1500       428
## 5425    1401    1501       428
## 5426    1352    1502       428
## 5427    1403    1513       428
## 5428    1405    1507       428
## 5429    1359    1503       428
## 5430    1359    1509       428
## 5431    1355    1454       428
## 5432    1443    1554       428
## 5433    1443    1553       428
## ..       ...     ...       ...
```


```r
# dplyr
select(flights, DepTime, ArrTime, FlightNum)
```

```
## Source: local data frame [227,496 x 3]
## 
##      DepTime ArrTime FlightNum
## 5424    1400    1500       428
## 5425    1401    1501       428
## 5426    1352    1502       428
## 5427    1403    1513       428
## 5428    1405    1507       428
## 5429    1359    1503       428
## 5430    1359    1509       428
## 5431    1355    1454       428
## 5432    1443    1554       428
## 5433    1443    1553       428
## ..       ...     ...       ...
```


```r
# use colon ro select range of cols, and use `contains` to match by partial name
# can use `starts_with`, `ends_with`, and `matches` (regex)
select(flights, Year:DayofMonth, contains("Taxi"), contains("Delay"))
```

```
## Source: local data frame [227,496 x 7]
## 
##      Year Month DayofMonth TaxiIn TaxiOut ArrDelay DepDelay
## 5424 2011     1          1      7      13      -10        0
## 5425 2011     1          2      6       9       -9        1
## 5426 2011     1          3      5      17       -8       -8
## 5427 2011     1          4      9      22        3        3
## 5428 2011     1          5      9       9       -3        5
## 5429 2011     1          6      6      13       -7       -1
## 5430 2011     1          7     12      15       -1       -1
## 5431 2011     1          8      7      12      -16       -5
## 5432 2011     1          9      8      22       44       43
## 5433 2011     1         10      6      19       43       43
## ..    ...   ...        ...    ...     ...      ...      ...
```

## "Chaining" or "Pipelining"  
* Normal method is nesting operations
* With %>% can write commands in natural order


```r
# nesting method
# select UniqueCarrier and DeDelay cols and filter for delays > 60 mins
filter(select(flights, UniqueCarrier, DepDelay), DepDelay > 60)
```

```
## Source: local data frame [10,242 x 2]
## 
##    UniqueCarrier DepDelay
## 1             AA       90
## 2             AA       67
## 3             AA       74
## 4             AA      125
## 5             AA       82
## 6             AA       99
## 7             AA       70
## 8             AA       61
## 9             AA       74
## 10            AS       73
## ..           ...      ...
```


```r
# chaining method 
flights %>% 
    select(UniqueCarrier, DepDelay) %>% 
    filter(DepDelay > 60)
```

```
## Source: local data frame [10,242 x 2]
## 
##    UniqueCarrier DepDelay
## 1             AA       90
## 2             AA       67
## 3             AA       74
## 4             AA      125
## 5             AA       82
## 6             AA       99
## 7             AA       70
## 8             AA       61
## 9             AA       74
## 10            AS       73
## ..           ...      ...
```


```r
# %>% comes from magrittr, used with other commands
# create 2 vectors and calc Euclidean dist between them
(x1 <- 1:5); (x2 <- 2:6)
```

```
## [1] 1 2 3 4 5
```

```
## [1] 2 3 4 5 6
```

```r
sqrt(sum( (x1 - x2)^2 ) )
```

```
## [1] 2.236
```


```r
# chaining method
(x1 - x2)^2 %>% sum() %>% sqrt()
```

```
## [1] 2.236
```

## verb 3
## arrange: Reorder rows (sort)


```r
# base R: select UniqueCarrier and DepDelay, sort by DepDelay
flights[order(flights$DepDelay), c("UniqueCarrier", "DepDelay")]
```

```
## Source: local data frame [227,496 x 2]
## 
##         UniqueCarrier DepDelay
## 5996719            OO      -33
## 927973             MQ      -23
## 1694833            XE      -19
## 3814017            XE      -19
## 83407              CO      -18
## 5035285            EV      -18
## 457114             XE      -17
## 1043606            CO      -17
## 1442181            XE      -17
## 1965737            MQ      -17
## ..                ...      ...
```


```r
# dplyr approach
flights %>% 
    select(UniqueCarrier, DepDelay) %>%
    arrange(DepDelay)
```

```
## Source: local data frame [227,496 x 2]
## 
##    UniqueCarrier DepDelay
## 1             OO      -33
## 2             MQ      -23
## 3             XE      -19
## 4             XE      -19
## 5             CO      -18
## 6             EV      -18
## 7             XE      -17
## 8             CO      -17
## 9             XE      -17
## 10            MQ      -17
## ..           ...      ...
```


```r
# use `desc` for descending
flights %>% 
    select(UniqueCarrier, DepDelay) %>%
    arrange(desc(DepDelay) )
```

```
## Source: local data frame [227,496 x 2]
## 
##    UniqueCarrier DepDelay
## 1             CO      981
## 2             AA      970
## 3             MQ      931
## 4             UA      869
## 5             MQ      814
## 6             MQ      803
## 7             CO      780
## 8             CO      758
## 9             DL      730
## 10            MQ      691
## ..           ...      ...
```

## verb 4
## mutate: Add new variables (transform)
* Create new variables from functions of existing
  

```r
# base R approach to create  a new variable, Speed
flights$Speed <- flights$Distance / flights$AirTime*60
flights[, c("Distance", "AirTime", "Speed")]
```

```
## Source: local data frame [227,496 x 3]
## 
##      Distance AirTime Speed
## 5424      224      40 336.0
## 5425      224      45 298.7
## 5426      224      48 280.0
## 5427      224      39 344.6
## 5428      224      44 305.5
## 5429      224      45 298.7
## 5430      224      43 312.6
## 5431      224      40 336.0
## 5432      224      41 327.8
## 5433      224      45 298.7
## ..        ...     ...   ...
```


```r
# dplyr approach (prints but does not modify flights ldf)
flights %>%
    select(Distance, AirTime) %>%
    mutate(Speed = Distance / AirTime*60)
```

```
## Source: local data frame [227,496 x 3]
## 
##    Distance AirTime Speed
## 1       224      40 336.0
## 2       224      45 298.7
## 3       224      48 280.0
## 4       224      39 344.6
## 5       224      44 305.5
## 6       224      45 298.7
## 7       224      43 312.6
## 8       224      40 336.0
## 9       224      41 327.8
## 10      224      45 298.7
## ..      ...     ...   ...
```


```r
# to store new variable
flights2 <- flights %>%
    select(Distance, AirTime) %>%
    mutate(Speed = Distance / AirTime*60)

flights <- tbl_df(hflights)
```

## verb 5
## summarise: Reduce variables to values  
* Primarily useful with data that has been grouped by
* `group_by` creates the groups to be operated on
* `summarise` uses the provided aggregation function to summarise each group


```r
# base R approach to calc avg arrival delay to each dest
head(with(flights, tapply(ArrDelay, Dest, mean, na.rm = TRUE)))
```

```
##    ABQ    AEX    AGS    AMA    ANC    ASE 
##  7.226  5.839  4.000  6.840 26.081  6.795
```

```r
head(aggregate(ArrDelay ~ Dest, flights, mean))
```

```
##   Dest ArrDelay
## 1  ABQ    7.226
## 2  AEX    5.839
## 3  AGS    4.000
## 4  AMA    6.840
## 5  ANC   26.081
## 6  ASE    6.795
```


```r
# dplyr approach
flights %>%
    group_by(Dest) %>%
    summarise(avg_delay = mean(ArrDelay, na.rm = TRUE))
```

```
## Source: local data frame [116 x 2]
## 
##    Dest avg_delay
## 1   ABQ     7.226
## 2   AEX     5.839
## 3   AGS     4.000
## 4   AMA     6.840
## 5   ANC    26.081
## 6   ASE     6.795
## 7   ATL     8.233
## 8   AUS     7.449
## 9   AVL     9.974
## 10  BFL   -13.199
## ..  ...       ...
```

```r
# same as
flights %>%
    select(ArrDelay, Dest) %>%
    group_by(Dest) %>%
    summarise(avg_delay = mean(ArrDelay, na.rm = TRUE))
```

```
## Source: local data frame [116 x 2]
## 
##    Dest avg_delay
## 1   ABQ     7.226
## 2   AEX     5.839
## 3   AGS     4.000
## 4   AMA     6.840
## 5   ANC    26.081
## 6   ASE     6.795
## 7   ATL     8.233
## 8   AUS     7.449
## 9   AVL     9.974
## 10  BFL   -13.199
## ..  ...       ...
```
* `summarise_each` allows for performing same summary function to mult cols
* Note: `mutate_each` is also available

```r
# for each carrier, cal pct of flights cancelled or diverted
# Cancelled & Diverted are binary, 0 or 1
flights %>%
    group_by(UniqueCarrier) %>%
    summarise_each(funs(mean), Cancelled, Diverted)
```

```
## Source: local data frame [15 x 3]
## 
##    UniqueCarrier Cancelled Diverted
## 1             AA  0.018496 0.001850
## 2             AS  0.000000 0.002740
## 3             B6  0.025899 0.005755
## 4             CO  0.006783 0.002627
## 5             DL  0.015903 0.003029
## 6             EV  0.034483 0.003176
## 7             F9  0.007160 0.000000
## 8             FL  0.009818 0.003273
## 9             MQ  0.029045 0.001936
## 10            OO  0.013947 0.003487
## 11            UA  0.016409 0.002413
## 12            US  0.011269 0.001470
## 13            WN  0.015504 0.002294
## 14            XE  0.015496 0.003450
## 15            YV  0.012658 0.000000
```


```r
# for each carrier, calc min & max arrival & departure delays
flights %>%
    group_by(UniqueCarrier) %>%
    summarise_each(funs (min(., na.rm=T), max(., na.rm=T) ), matches("Delay"))
```

```
## Source: local data frame [15 x 5]
## 
##    UniqueCarrier ArrDelay_min DepDelay_min ArrDelay_max DepDelay_max
## 1             AA          -39          -15          978          970
## 2             AS          -43          -15          183          172
## 3             B6          -44          -14          335          310
## 4             CO          -55          -18          957          981
## 5             DL          -32          -17          701          730
## 6             EV          -40          -18          469          479
## 7             F9          -24          -15          277          275
## 8             FL          -30          -14          500          507
## 9             MQ          -38          -23          918          931
## 10            OO          -57          -33          380          360
## 11            UA          -47          -11          861          869
## 12            US          -42          -17          433          425
## 13            WN          -44          -10          499          548
## 14            XE          -70          -19          634          628
## 15            YV          -32          -11           72           54
```
* Helper function `n()` counts number of rows in a  group
* Helper function `n_distinct()` counts unique items in vector

```r
# for each day in year, count tot number of flights, sort in desc order
flights %>%
    group_by(Month, DayofMonth) %>%
    summarise(flight_count = n()) %>%
    arrange(desc(flight_count))
```

```
## Source: local data frame [365 x 3]
## Groups: Month
## 
##    Month DayofMonth flight_count
## 1      8          4          706
## 2      8         11          706
## 3      8         12          706
## 4      8          5          705
## 5      8          3          704
## 6      8         10          704
## 7      1          3          702
## 8      7          7          702
## 9      7         14          702
## 10     7         28          701
## ..   ...        ...          ...
```


```r
# rewrite above more simply with `tally()`
flights %>%
    group_by(Month, DayofMonth) %>%
    tally(sort = TRUE)
```

```
## Source: local data frame [365 x 3]
## Groups: Month
## 
##    Month DayofMonth   n
## 1      8          4 706
## 2      8         11 706
## 3      8         12 706
## 4      8          5 705
## 5      8          3 704
## 6      8         10 704
## 7      1          3 702
## 8      7          7 702
## 9      7         14 702
## 10     7         28 701
## ..   ...        ... ...
```
* Grouping can be useful without summarising

```r
# for each dest, show the number of cancelled and notcancelled flights
flights %>%
    group_by(Dest) %>%
    select(Cancelled) %>%
    table() %>%
    head()
```

```
##      Cancelled
## Dest     0  1
##   ABQ 2787 25
##   AEX  712 12
##   AGS    1  0
##   AMA 1265 32
##   ANC  125  0
##   ASE  120  5
```

## Window Functions
* Aggregation function, like `mean`, takes n inputs and returns 1 value
* [Window function](http://cran.r-project.org/web/packages/dplyr/vignettes/window-functions.html) returns n values

```r
# for each carrier, alculate which two days of the year they had their longest departure delays
#  note: smallest (not largest) value is ranked as 1, so you have to use `desc` to rank by largest value
flights %>%
    group_by(UniqueCarrier) %>%
    select(Month, DayofMonth, DepDelay) %>%
    filter(min_rank(desc(DepDelay) ) <= 2 ) %>%
    arrange(UniqueCarrier, desc(DepDelay))
```

```
## Source: local data frame [30 x 4]
## Groups: UniqueCarrier
## 
##    UniqueCarrier Month DayofMonth DepDelay
## 1             AA    12         12      970
## 2             AA    11         19      677
## 3             AS     2         28      172
## 4             AS     7          6      138
## 5             B6    10         29      310
## 6             B6     8         19      283
## 7             CO     8          1      981
## 8             CO     1         20      780
## 9             DL    10         25      730
## 10            DL     4          5      497
## 11            EV     6         25      479
## 12            EV     1          5      465
## 13            F9     5         12      275
## 14            F9     5         20      240
## 15            FL     2         19      507
## 16            FL     3         14      493
## 17            MQ    11          8      931
## 18            MQ     6          9      814
## 19            OO     2         27      360
## 20            OO     4          4      343
## 21            UA     6         21      869
## 22            UA     9         18      588
## 23            US     4         19      425
## 24            US     8         26      277
## 25            WN     4          8      548
## 26            WN     9         29      503
## 27            XE    12         29      628
## 28            XE    12         29      511
## 29            YV     4         22       54
## 30            YV     4         30       46
```


```r
# rewrite more simply with the `top_n` function
flights %>%
    group_by(UniqueCarrier) %>%
    select(Month, DayofMonth, DepDelay) %>%
    top_n(2) %>%
    arrange(UniqueCarrier, desc(DepDelay))
```

```
## Selecting by DepDelay
```

```
## Source: local data frame [30 x 4]
## Groups: UniqueCarrier
## 
##    UniqueCarrier Month DayofMonth DepDelay
## 1             AA    12         12      970
## 2             AA    11         19      677
## 3             AS     2         28      172
## 4             AS     7          6      138
## 5             B6    10         29      310
## 6             B6     8         19      283
## 7             CO     8          1      981
## 8             CO     1         20      780
## 9             DL    10         25      730
## 10            DL     4          5      497
## 11            EV     6         25      479
## 12            EV     1          5      465
## 13            F9     5         12      275
## 14            F9     5         20      240
## 15            FL     2         19      507
## 16            FL     3         14      493
## 17            MQ    11          8      931
## 18            MQ     6          9      814
## 19            OO     2         27      360
## 20            OO     4          4      343
## 21            UA     6         21      869
## 22            UA     9         18      588
## 23            US     4         19      425
## 24            US     8         26      277
## 25            WN     4          8      548
## 26            WN     9         29      503
## 27            XE    12         29      628
## 28            XE    12         29      511
## 29            YV     4         22       54
## 30            YV     4         30       46
```


```r
# for each month, calculate the number of flights and the change from the previous month
flights %>%
    group_by(Month) %>%
    summarise(flight_count = n()) %>%
    mutate(change = flight_count - lag(flight_count))
```

```
## Source: local data frame [12 x 3]
## 
##    Month flight_count change
## 1      1        18910     NA
## 2      2        17128  -1782
## 3      3        19470   2342
## 4      4        18593   -877
## 5      5        19172    579
## 6      6        19600    428
## 7      7        20548    948
## 8      8        20176   -372
## 9      9        18065  -2111
## 10    10        18696    631
## 11    11        18021   -675
## 12    12        19117   1096
```


```r
# rewrite more simply with the `tally` function
flights %>%
    group_by(Month) %>%
    tally() %>%
    mutate(change = n - lag(n))
```

```
## Source: local data frame [12 x 3]
## 
##    Month     n change
## 1      1 18910     NA
## 2      2 17128  -1782
## 3      3 19470   2342
## 4      4 18593   -877
## 5      5 19172    579
## 6      6 19600    428
## 7      7 20548    948
## 8      8 20176   -372
## 9      9 18065  -2111
## 10    10 18696    631
## 11    11 18021   -675
## 12    12 19117   1096
```

## Other Useful Convenience Function


```r
# randomly sample a fixed number of rows, without replacement
flights %>% sample_n(5)
```

```
## Source: local data frame [5 x 21]
## 
##         Year Month DayofMonth DayOfWeek DepTime ArrTime UniqueCarrier
## 3562845 2011     7          1         5    1301    1402            WN
## 2206438 2011     5         11         3    1259    1443            XE
## 1692490 2011     4         29         5    1038    1427            XE
## 3091592 2011     7         27         3    1906    2118            AS
## 2723792 2011     6         26         7    1527    1837            XE
## Variables not shown: FlightNum (int), TailNum (chr), ActualElapsedTime
##   (int), AirTime (int), ArrDelay (int), DepDelay (int), Origin (chr), Dest
##   (chr), Distance (int), TaxiIn (int), TaxiOut (int), Cancelled (int),
##   CancellationCode (chr), Diverted (int)
```


```r
# randomly sample a fraction of rows, with replacement
flights %>% sample_frac(0.25, replace = TRUE)
```

```
## Source: local data frame [56,874 x 21]
## 
##         Year Month DayofMonth DayOfWeek DepTime ArrTime UniqueCarrier
## 3380509 2011     7          6         3    1918    2217            FL
## 3266212 2011     7         16         6    2008    2316            XE
## 5875409 2011    12         19         1    2142    2251            WN
## 5860642 2011    12         14         3     709     853            WN
## 1038732 2011     3         15         2    1806    2205            CO
## 3759392 2011     8         19         5    1707    1805            WN
## 5186434 2011    11         27         7    1803    2016            CO
## 1653235 2011     4         22         5      NA      NA            WN
## 1211979 2011     3         18         5    2058    2207            OO
## 2598409 2011     6          6         1    1702    2115            CO
## ..       ...   ...        ...       ...     ...     ...           ...
## Variables not shown: FlightNum (int), TailNum (chr), ActualElapsedTime
##   (int), AirTime (int), ArrDelay (int), DepDelay (int), Origin (chr), Dest
##   (chr), Distance (int), TaxiIn (int), TaxiOut (int), Cancelled (int),
##   CancellationCode (chr), Diverted (int)
```


```r
# base R approach to view the structure of an object
str(flights)
```

```
## Classes 'tbl_df', 'tbl' and 'data.frame':	227496 obs. of  21 variables:
##  $ Year             : int  2011 2011 2011 2011 2011 2011 2011 2011 2011 2011 ...
##  $ Month            : int  1 1 1 1 1 1 1 1 1 1 ...
##  $ DayofMonth       : int  1 2 3 4 5 6 7 8 9 10 ...
##  $ DayOfWeek        : int  6 7 1 2 3 4 5 6 7 1 ...
##  $ DepTime          : int  1400 1401 1352 1403 1405 1359 1359 1355 1443 1443 ...
##  $ ArrTime          : int  1500 1501 1502 1513 1507 1503 1509 1454 1554 1553 ...
##  $ UniqueCarrier    : chr  "AA" "AA" "AA" "AA" ...
##  $ FlightNum        : int  428 428 428 428 428 428 428 428 428 428 ...
##  $ TailNum          : chr  "N576AA" "N557AA" "N541AA" "N403AA" ...
##  $ ActualElapsedTime: int  60 60 70 70 62 64 70 59 71 70 ...
##  $ AirTime          : int  40 45 48 39 44 45 43 40 41 45 ...
##  $ ArrDelay         : int  -10 -9 -8 3 -3 -7 -1 -16 44 43 ...
##  $ DepDelay         : int  0 1 -8 3 5 -1 -1 -5 43 43 ...
##  $ Origin           : chr  "IAH" "IAH" "IAH" "IAH" ...
##  $ Dest             : chr  "DFW" "DFW" "DFW" "DFW" ...
##  $ Distance         : int  224 224 224 224 224 224 224 224 224 224 ...
##  $ TaxiIn           : int  7 6 5 9 9 6 12 7 8 6 ...
##  $ TaxiOut          : int  13 9 17 22 9 13 15 12 22 19 ...
##  $ Cancelled        : int  0 0 0 0 0 0 0 0 0 0 ...
##  $ CancellationCode : chr  "" "" "" "" ...
##  $ Diverted         : int  0 0 0 0 0 0 0 0 0 0 ...
```


```r
# dplyr approach, better formatting and adapts for screen width
glimpse(flights)
```

```
## Variables:
## $ Year              (int) 2011, 2011, 2011, 2011, 2011, 2011, 2011, 20...
## $ Month             (int) 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,...
## $ DayofMonth        (int) 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 1...
## $ DayOfWeek         (int) 6, 7, 1, 2, 3, 4, 5, 6, 7, 1, 2, 3, 4, 5, 6,...
## $ DepTime           (int) 1400, 1401, 1352, 1403, 1405, 1359, 1359, 13...
## $ ArrTime           (int) 1500, 1501, 1502, 1513, 1507, 1503, 1509, 14...
## $ UniqueCarrier     (chr) "AA", "AA", "AA", "AA", "AA", "AA", "AA", "A...
## $ FlightNum         (int) 428, 428, 428, 428, 428, 428, 428, 428, 428,...
## $ TailNum           (chr) "N576AA", "N557AA", "N541AA", "N403AA", "N49...
## $ ActualElapsedTime (int) 60, 60, 70, 70, 62, 64, 70, 59, 71, 70, 70, ...
## $ AirTime           (int) 40, 45, 48, 39, 44, 45, 43, 40, 41, 45, 42, ...
## $ ArrDelay          (int) -10, -9, -8, 3, -3, -7, -1, -16, 44, 43, 29,...
## $ DepDelay          (int) 0, 1, -8, 3, 5, -1, -1, -5, 43, 43, 29, 19, ...
## $ Origin            (chr) "IAH", "IAH", "IAH", "IAH", "IAH", "IAH", "I...
## $ Dest              (chr) "DFW", "DFW", "DFW", "DFW", "DFW", "DFW", "D...
## $ Distance          (int) 224, 224, 224, 224, 224, 224, 224, 224, 224,...
## $ TaxiIn            (int) 7, 6, 5, 9, 9, 6, 12, 7, 8, 6, 8, 4, 6, 5, 6...
## $ TaxiOut           (int) 13, 9, 17, 22, 9, 13, 15, 12, 22, 19, 20, 11...
## $ Cancelled         (int) 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,...
## $ CancellationCode  (chr) "", "", "", "", "", "", "", "", "", "", "", ...
## $ Diverted          (int) 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,...
```






