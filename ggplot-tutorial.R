# http://www.ceb-institute.org/bbs/wp-content/uploads/2011/09/handout_ggplot2.pdf
# Basel Institute for Clinical Epidemiology and Biostatistics
# Tutorial: ggplot2
#### Sample code for the illustration of ggplot2
#### Ramon Saccilotto, 2010-12-08
library('ggplot2')

### show info about the data
head(diamonds)
head(mtcars)
### comparison qplot vs ggplot
# qplot histogram
qplot(clarity, data=diamonds, fill=cut, geom="bar")
# ggplot histogram -> same output
ggplot(diamonds, aes(clarity, fill=cut)) + geom_bar()

### how to use qplot
# scatterplot
qplot(wt, mpg, data=mtcars)
# transform input data with functions
qplot(log(wt), mpg - 10, data=mtcars)

# add aesthetic mapping (hint: how does mapping work)
qplot(wt, mpg, data=mtcars, color=qsec)
# change size of points (hint: color/colour, hint: set aesthetic/mapping)
qplot(wt, mpg, data=mtcars, color=qsec, size=3)
qplot(wt, mpg, data=mtcars, colour=qsec, size=I(3))

# use alpha blending
qplot(wt, mpg, data=mtcars, alpha=qsec)

# continuous scale vs. discrete scale
head(mtcars)
qplot(wt, mpg, data=mtcars, colour=cyl)
levels(mtcars$cyl)
qplot(wt, mpg, data=mtcars, colour=factor(cyl))

# use different aesthetic mappings
qplot(wt, mpg, data=mtcars, shape=factor(cyl))
qplot(wt, mpg, data=mtcars, size=qsec)

# combine mappings (hint: hollow points, geom-concept, legend combination)
qplot(wt, mpg, data=mtcars, size=qsec, color=factor(carb))
qplot(wt, mpg, data=mtcars, size=qsec, color=factor(carb), shape=I(1))
qplot(wt, mpg, data=mtcars, size=qsec, shape=factor(cyl), geom="point")
qplot(wt, mpg, data=mtcars, size=factor(cyl), geom="point")

# bar-plot
qplot(factor(cyl), data=mtcars, geom="bar")
# flip plot by 90°
qplot(factor(cyl), data=mtcars, geom="bar") + coord_flip()
# difference between fill/color bars
qplot(factor(cyl), data=mtcars, geom="bar", fill=factor(cyl))
qplot(factor(cyl), data=mtcars, geom="bar", colour=factor(cyl))
# fill by variable
qplot(factor(cyl), data=mtcars, geom="bar", fill=factor(gear))

# use different display of bars (stacked, dodged, identity)
head(diamonds)
qplot(clarity, data=diamonds, geom="bar", fill=cut, position="stack")
qplot(clarity, data=diamonds, geom="bar", fill=cut, position="dodge")
qplot(clarity, data=diamonds, geom="bar", fill=cut, position="fill")
qplot(clarity, data=diamonds, geom="bar", fill=cut, position="identity")

qplot(clarity, data=diamonds, geom="freqpoly", group=cut, colour=cut, position="identity")
qplot(clarity, data=diamonds, geom="freqpoly", group=cut, colour=cut, position="stack")

# using pre-calculated tables or weights (hint: usage of ddply in package plyr)
library('plyr')
library('dplyr')
table(diamonds$cut)
t.table <- ddply(diamonds, c("clarity", "cut"), "nrow")
# dkp dplyr equivalent
diamonds %>% group_by(clarity, cut) %>% select(clarity, cut) %>%
    summarise(count=n()) -> t2.table
diamonds %>% select(clarity, cut) %>% group_by(clarity, cut) %>% 
    summarise(count=n()) -> t2.table
detach(package:dplyr)
# dkp dplyr equivalent

head(t2.table)
head(t.table)
qplot(cut, nrow, data=t.table, geom="bar")
qplot(cut, nrow, data=t.table, geom="bar", stat="identity")
qplot(cut, nrow, data=t.table, geom="bar", stat="identity", fill=clarity)
qplot(cut, data=diamonds, geom="bar", weight=carat)
qplot(cut, data=diamonds, geom="bar", weight=carat, ylab="carat")

### excursion ddply (split data.frame in subframes and apply functions)
ddply(diamonds, "cut", "nrow")
ddply(diamonds, c("cut", "clarity"), "nrow")
ddply(diamonds, "cut", mean)
ddply(diamonds, "cut", summarise, meanDepth = mean(depth))
ddply(diamonds, "cut", summarise, lower = quantile(depth, 0.25, na.rm=TRUE), median = median(depth, na.rm=TRUE), 
      upper = quantile(depth, 0.75, na.rm=TRUE))
t.function <- function(x,y){
    z = sum(x) / sum(x+y)
    return(z)
}
ddply(diamonds, "cut", summarise, custom = t.function(depth, price))
ddply(diamonds, "cut", summarise, custom = sum(depth) / sum(depth + price))
### back to ggplot

# histogram
qplot(carat, data=diamonds, geom="histogram")
# change binwidth
qplot(carat, data=diamonds, geom="histogram", binwidth=0.1)
qplot(carat, data=diamonds, geom="histogram", binwidth=0.01)
# use geom to combine plots (hint: order of layers)
qplot(wt, mpg, data=mtcars, geom=c("point", "smooth"))
qplot(wt, mpg, data=mtcars, geom=c("smooth", "point"))
qplot(wt, mpg, data=mtcars, color=factor(cyl), geom=c("point", "smooth"))

# tweeking the smooth plot ("loess"-method: polynomial surface using local fitting)
qplot(wt, mpg, data=mtcars, geom=c("point", "smooth"))
# removing standard error
qplot(wt, mpg, data=mtcars, geom=c("point", "smooth"), se=FALSE)
# making line more or less wiggly (span: 0-1)
qplot(wt, mpg, data=mtcars, geom=c("point", "smooth"), span=0.6)
qplot(wt, mpg, data=mtcars, geom=c("point", "smooth"), span=1)
# using linear modelling
qplot(wt, mpg, data=mtcars, geom=c("point", "smooth"), method="lm")
# using a custom formula for fitting
library(splines)
qplot(wt, mpg, data=mtcars, geom=c("point", "smooth"), method="lm", formula = y ~ ns(x,5))
# illustrate flip versus changing of variable allocation
qplot(mpg, wt, data=mtcars, facets=cyl~., geom=c("point", "smooth"))
qplot(mpg, wt, data=mtcars, facets=cyl~., geom=c("point", "smooth")) + coord_flip()
qplot(wt, mpg, data=mtcars, facets=cyl~., geom=c("point", "smooth"))
# save plot in variable (hint: data is saved in plot, changes in data do not change plot-data)
p.tmp <- qplot(factor(cyl), wt, data=mtcars, geom="boxplot")
p.tmp
# save mtcars in tmp-var
t.mtcars <- mtcars
# change mtcars
mtcars <- transform(mtcars, wt=wt^2)


### create a pie-chart, radar-chart (hint: not recommended)
# map a barchart to a polar coordinate system
p.tmp <- ggplot(mtcars, aes(x=factor(1), fill=factor(cyl))) + geom_bar(width=1)
p.tmp
p.tmp + coord_polar(theta="y")
p.tmp + coord_polar()
ggplot(mtcars, aes(factor(cyl), fill=factor(cyl))) + geom_bar(width=1) + coord_polar()
