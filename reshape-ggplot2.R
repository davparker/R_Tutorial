# example reshaping data for nice graphs using ggplot2 & ggplot2
library(ggplot2)
library(reshape2)
library(datasets)
data(iris)
# generate a unique id for each row; this let's us go back to wide format later
iris$id <- 1:nrow(iris)
# melt iris dataframe into a skinny long table
iris.lng <- melt(iris, id=c("id", "Species"))
head(iris.lng)
# cast iris dataframe into a wide table
iris.wide <- dcast(iris.lng, id + Species ~ variable)
head(iris.wide)
# plot a facet wrapped histogram
p <- ggplot(aes(x=value, fill=Species), data=iris.lng)
p + geom_histogram() + facet_wrap(~variable, scales="free")
