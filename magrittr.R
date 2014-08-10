# http://cran.r-project.org/web/packages/magrittr/vignettes/magrittr.html

library(magrittr)

head(airquality)

weekly <-
    airquality %>% 
    transform(Date = paste(1973, Month, Day, sep = "-") %>% as.Date) %>% 
    aggregate(. ~ Date %>% format("%W"), ., mean)

weekly %>% head(3)
# 
# Date %>% format("%W")    Ozone  Solar.R     Wind     Temp Month  Day   Date
# 1                    18 26.75000 192.5000  9.87500 68.75000     5  2.5 1217.5
# 2                    19 15.40000 192.6000 12.28000 64.00000     5  9.8 1224.8
# 3                    20 18.14286 203.4286 12.45714 63.28571     5 17.0 1232.0

# We start with the value airquality (a data.frame). Then based on this, we make
# the “transformation” of adding a Date column using month, day and year (the
# year can be found in the dataset's documentation). Then we aggregate the data
# by week (which is a “format” of the date) using mean as aggregator. Note how
# the code is arranged in the logical order of how you think about the task:
# data->transform->aggregate. A horrific alternative would be to write

weekly <- aggregate(. ~ format(Date, "%W"), transform(airquality, 
  Date = as.Date(paste(1973, Month, Day, sep = "-"))), mean)

head(weekly, 3)

# There is a lot more clutter with parentheses, and the mental task of
# deciphering the code is more challenging—in particular if you did not write it
# yourself. Note how even the extraction of few rows has a semantic appeal in
# the first example over the second, even though none of them are hard to
# understand. Granted: you may make the second example better, perhaps throw in
# a few temporary variables (which is often avoided to some degree when using
# magrittr), but one often sees cluttered lines like the ones presented.

# And here is another selling point. Suppose I want to quickly go a step further
# and extract a subset somewhere in the process. Simply add a few steps to the
# chain:
    
windy.weeks <-
    airquality %>% 
    transform(Date = paste(1973, Month, Day, sep = "-") %>% as.Date) %>% 
    aggregate(. ~ Date %>% format("%W"), ., mean) %>%
    subset(Wind > 12, c(Ozone, Solar.R, Wind)) %>% 
    print

# I will refrain from making the alternative code even messier, but it should be
# clear that adding steps in a magrittr chain is simpler than working ones way
# through a labyrinth of parentheses.
 
# The combined example shows a few neat features of the pipe (which it is not):
 
# 1. By default the left-hand side (LHS) will be piped in as the first argument of the function appearing on the right-hand side (RHS). This is the case in the transform expression.
# 2. It may be used in a nested fashion, e.g. appearing in expressions within arguments. This is used in the date conversion (Note how the “pronunciation” of e.g. "2014-02-01" %>% as.Date is more pleasant than is as.Date("2014-02-01")).
# 3. When the LHS is needed at a position other than the first, one can use the dot,'.', as placeholder. This is used in the aggregate expression.
# 4. The dot in e.g. a formula is not confused with a placeholder, which is utilized in the aggregate expression.
# 5. Whenever only one argument is needed, the LHS, then one can omit the empty parentheses. This is used in the call to print (which also returns its argument). Here, LHS %>% print(), or even LHS %>% print(.) would also work.

# One feature, which was not utilized above is piping into anonymous functions. This is also possible, e.g.

windy.weeks %>%
    (function(x) rbind(x %>% head(1), x %>% tail(1)))

# Here the right-hand side is enclosed in parentheses, which is not strictly
# necessary, but advised. Whenever the RHS is parenthesized, is evaluated before
# the piping operation is carried out, i.e., one could do:
    
1:10 %>% (substitute(f(), list(f = sum)))
# [1] 55

# To summarize the important features:
    
# 1. Piping defaults to first-argument placement.
# 2. Using a dot as placeholder allows you to use the LHS anywhere on the right-hand side.
# 3. You may omit parentheses when only the LHS is needed as argument.
# 4. You can use anonymous functions.
# 5. You can parenthesize the right-hand side if this itself evaluates to the relevant call or function.

# In addition to the %>%-operator, magrittr provides some aliases for other
# operators which make operations such as addition or multiplication fit well
# into the magrittr-syntax. As an example, consider:

rnorm(1000)    %>%
    multiply_by(5) %>%
    add(5)         %>%
    function(x) 
        cat("Mean:",     x %>% mean, 
            "Variance:", x %>% var,  "\n")

# Which could be written in more compact form as

rnorm(100) %>% `*`(5) %>% `+`(5) %>% 
    function(x) cat("Mean:", x %>% mean, "Variance:", x %>% var,  "\n")

# To see a list of the aliases, execute e.g. ?multiply_by. For more examples of
# %>% in use, see the development page: http://github.com/smbache/magrittr


# http://www.r-bloggers.com/simpler-r-coding-with-pipes-the-present-and-future-of-the-magrittr-package/

library(babynames) # data package
library(dplyr)     # provides data manipulating functions.
library(magrittr)  # ceci n'est pas un pipe
library(ggplot2)   # for graphics

babynames %>% 
    filter(name %>% substr(1, 3) %>% equals("Ste")) %>% 
    group_by(year, sex) %>% 
    summarize(total = sum(n)) %>%
    qplot(year, total, color = sex, data = ., geom = "line") %>%
    add(ggtitle('Names starting with "Ste"')) %>% 
    print

babynames %>% 
    filter(name %>% substr(1, 3) %>% equals("Dav")) %>% 
    group_by(year, sex) %>% 
    summarize(total = sum(n)) %>%
    qplot(year, total, color = sex, data = ., geom = "line") %>%
    add(ggtitle('Names starting with "Dav"')) %>% 
    print