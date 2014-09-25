library('plyr')
detach(package:plyr)
library('dplyr')
library('ggplot2')
library('magrittr')
table(diamonds$cut)
t1.table <- ddply(diamonds, c("clarity", "cut"), "nrow")
# dkp dplyr equivalent
diamonds %>% group_by(clarity, cut) %>% select(clarity, cut) %>%
    summarise(count=n()) -> t2.table
t2.table <- group_by(diamonds, clarity, cut) %>% summarise(nrow=n()) 
t3.table <- diamonds %>% group_by(clarity, cut) %>% summarise(nrow=n()) 
mutate(diamonds, clarity, cut, nrow=n())
head(t2.table)
# detach(package:dplyr)
# dkp dplyr equivalent

head(t2.table)
head(t1.table)
qplot(cut, nrow, data=t1.table, geom="bar")
qplot(cut, nrow, data=t1.table, geom="bar", stat="identity")
qplot(cut, nrow, data=t1.table, geom="bar", stat="identity", fill=clarity)
qplot(cut, data=diamonds, geom="bar", weight=carat)
qplot(cut, data=diamonds, geom="bar", weight=carat, ylab="carat")

t1.table <- diamonds %>% group_by(clarity, cut) %>% summarize(nrow=n())
head(t1.table)

t1.table <- diamonds %>% group_by(clarity, cut) %>% summarize(nrow=n())
