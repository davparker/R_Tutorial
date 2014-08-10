# http://blog.rstudio.org/2014/07/22/introducing-tidyr/
# Introducing tidyr

# The two most important properties of tidy data are:
# 1) Each column is a variable.
# 2) Each row is an observation.

# To tidy messy data, you first identify the variables in your dataset, then use
# the tools provided by tidyr to move them into columns. tidyr provides three
# main functions for tidying your messy data: gather(), separate() and spread().

# gather() takes multiple columns, and gathers them into key-value pairs: it
# makes “wide” data longer. Other names for gather include melt (reshape2),
# pivot (spreadsheets) and fold (databases). Here’s an example how you might use
# gather() on a made-up dataset. In this experiment we’ve given three people two
# different drugs and recorded their heart rate:

library(tidyr)
library(dplyr)

messy <- data.frame(
    name = c("Wilbur", "Petunia", "Gregory"),
    a = c(67, 80, 64),
    b = c(56, 90, 50)
)
messy
#      name  a  b
# 1  Wilbur 67 56
# 2 Petunia 80 90
# 3 Gregory 64 50

# We have three variables (name, drug and heartrate), but only name is currently
# in a column. We use gather() to gather the a and b columns into key-value
# pairs of drug and heartrate:

str(gather)
# function (data, key, value, ..., na.rm = FALSE, convert = FALSE)
messy %>% 
    gather(drug, heartrate, a:b)

# Sometimes two variables are clumped together in one column. separate() allows
# you to tease them apart (extract() works similarly but uses regexp groups
# instead of a splitting pattern or position). Take this example from
# stackoverflow (modified slightly for brevity). We have some measurements of
# how much time people spend on their phones, measured at two locations (work
# and home), at two times. Each person has been randomly assigned to either
# treatment or control.

set.seed(10)
messy <- data.frame(
    id = 1:4,
    trt = sample(rep(c('control', 'treatment'), each = 2)),
    work.T1 = runif(4),
    home.T1 = runif(4),
    work.T2 = runif(4),
    home.T2 = runif(4)
)
messy
#   id       trt    work.T1   home.T1   work.T2    home.T2
# 1  1 treatment 0.08513597 0.6158293 0.1135090 0.05190332
# 2  2   control 0.22543662 0.4296715 0.5959253 0.26417767
# 3  3 treatment 0.27453052 0.6516557 0.3580500 0.39879073
# 4  4   control 0.27230507 0.5677378 0.4288094 0.83613414

# To tidy this data, we first use gather() to turn columns work.T1, home.T1,
# work.T2 and home.T2 into a key-value pair of key and time. (Only the first
# eight rows are shown to save space.)

tidier <- messy %>%
    gather(key, time, -id, -trt)
tidier
#    id       trt     key       time
# 1   1 treatment work.T1 0.08513597
# 2   2   control work.T1 0.22543662
# 3   3 treatment work.T1 0.27453052
# 4   4   control work.T1 0.27230507
# 5   1 treatment home.T1 0.61582931
# 6   2   control home.T1 0.42967153
# 7   3 treatment home.T1 0.65165567
# 8   4   control home.T1 0.56773775

# Next we use separate() to split the key into location and time, using a
# regular expression to describe the character that separates them.

str(separate)
# function (data, col, into, sep = "[^[:alnum:]]+", remove = TRUE, convert = FALSE, ...) 

tidy <- tidier %>%
    separate(key, into = c("location", "time"), sep = "\\.")

tidy %>% head(8)
#   id       trt location time       time
# 1  1 treatment     work   T1 0.08513597
# 2  2   control     work   T1 0.22543662
# 3  3 treatment     work   T1 0.27453052
# 4  4   control     work   T1 0.27230507
# 5  1 treatment     home   T1 0.61582931
# 6  2   control     home   T1 0.42967153
# 7  3 treatment     home   T1 0.65165567
# 8  4   control     home   T1 0.56773775

# The last tool, spread(), takes two columns (a key-value pair) and spreads them
# in to multiple columns, making “long” data wider. Spread is known by other
# names in other places: it’s cast in reshape2, unpivot in spreadsheets and
# unfold in databases. spread() is used when you have variables that form rows
# instead of columns. You need spread() less frequently than gather() or
# separate() so to learn more, check out the documentation and the demos.

# Just as reshape2 did less than reshape, tidyr does less than reshape2. It’s
# designed specifically for tidying data, not general reshaping. In particular,
# existing methods only work for data frames, and tidyr never aggregates. This
# makes each function in tidyr simpler: each function does one thing well. For
# more complicated operations you can string together multiple simple tidyr and
# dplyr functions with %>%.

# You can learn more about the underlying principles in my tidy data paper. To
# see more examples of data tidying, read the vignette, vignette("tidy-data"),
# or check out the demos, demo(package = "tidyr").
