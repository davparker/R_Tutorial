# Intro to dplyr
library('dplyr')
library('hflights', 'Lahman')
vignette("introduction", package = "dplyr")

dim(hflights)
head(hflights)
hflights_df <- tbl_df(hflights)
hflights_df

filter(hflights_df, Month == 1, DayofMonth == 1)

filter(hflights_df, Month == 1 | Month == 2)

arrange(hflights_df, DayofMonth, Month, Year)

arrange(hflights_df, desc(ArrDelay))

# Select columns by name
select(hflights_df, Year, Month, DayOfWeek)

# Select all columns between Year and DayOfWeek (inclusive)
select(hflights_df, Year:DayOfWeek)

# Select all columns except those from Year to DayOfWeek (inclusive)
select(hflights_df, -(Year:DayOfWeek))

mutate(hflights_df,
       gain = ArrDelay - DepDelay,
       speed = Distance / AirTime * 60)

summarise(hflights_df,
          delay = mean(DepDelay, na.rm = TRUE))

planes <- group_by(hflights_df, TailNum)
delay <- summarise(planes,
                   count = n(),
                   dist = mean(Distance, na.rm = TRUE),
                   delay = mean(ArrDelay, na.rm = TRUE))
delay <- filter(delay, count > 20, dist < 2000)

# Interestingly, the average delay is only slightly related to the
# average distance flown a plane.
ggplot(delay, aes(dist, delay)) +
    geom_point(aes(size = count), alpha = 1/2) +
    geom_smooth() +
    scale_size_area()

destinations <- group_by(hflights_df, Dest)
summarise(destinations,
          planes = n_distinct(TailNum),
          flights = n()
)

daily <- group_by(hflights_df, Year, Month, DayofMonth)
(per_day   <- summarise(daily, flights = n()))
(per_month <- summarise(per_day, flights = sum(flights)))

# Chaining
# The dplyr API is functional in the sense that function calls don't have
# side-effects, and you must always save their results. This doesn't lead to
# particularly elegant code if you want to do many operations at once. You
# either have to do it step-by-step:
    
a1 <- group_by(hflights, Year, Month, DayofMonth)
a2 <- select(a1, Year:DayofMonth, ArrDelay, DepDelay)
a3 <- summarise(a2,
                arr = mean(ArrDelay, na.rm = TRUE),
                dep = mean(DepDelay, na.rm = TRUE))
a4 <- filter(a3, arr > 30 | dep > 30)

# Or if you don't want to save the intermediate results, you need to wrap the
# function calls inside each other:

filter(
  summarise(
    select(
      group_by(hflights, Year, Month, DayofMonth),
      Year:DayofMonth, ArrDelay, DepDelay
    ),
    arr = mean(ArrDelay, na.rm = TRUE),
    dep = mean(DepDelay, na.rm = TRUE)
  ),
  arr > 30 | dep > 30
)

# equivalent
hflights %>%
    group_by(Year, Month, DayofMonth) %>%
    select(Year:DayofMonth, ArrDelay, DepDelay) %>%
    summarise(
        arr = mean(ArrDelay, na.rm = TRUE),
        dep = mean(DepDelay, na.rm = TRUE)
    ) %>%
    filter(arr > 30 | dep > 30)

