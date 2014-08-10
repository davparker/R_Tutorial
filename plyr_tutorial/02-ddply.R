# Examples - from ?transform

transform(airquality, Ozone = -Ozone)
transform(airquality, new = -Ozone, Temp = (Temp-32)/1.8)

attach(airquality)
transform(Ozone, logOzone = log(Ozone)) # marginally interesting ...
detach(airquality)

# summarise(.data, ...)

# Be careful when using existing variable names; the corresponding columns will
# be immediately updated with the new data and this can affect subsequent
# operations referring to those variables.

# Let's extract the number of teams and total period of time
# covered by the baseball dataframe
summarise(baseball,
          duration = max(year) - min(year),
          nteams = length(unique(team)))
#   duration nteams
# 1      136    132

# Combine with ddply to do that for each separate id
sumbb <- ddply(baseball, "id", summarise,
      duration = max(year) - min(year),
      nteams = length(unique(team)))
head(sumbb)
#          id duration nteams
# 1 aaronha01       22      3
# 2 abernte02       17      7
# 3 adairje01       12      4
# 4 adamsba01       20      2
# 5 adamsbo03       13      4
# 6 adcocjo01       16      5


