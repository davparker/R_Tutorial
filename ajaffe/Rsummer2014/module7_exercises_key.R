####################
# Module 7 - Lab
# 1/8/2014
####################

## Part A

# Bike Lanes Dataset: BikeBaltimore is the Department of Transportation's bike program.
# https://data.baltimorecity.gov/Transportation/Bike-Lanes/xzfj-gyms
# Download as a CSV (like the Monuments dataset) in your current working directory

# 1. Using tapply():
# 	(a) Which project category has the longest average bike lane?
tab=tapply(bike$length,bike$project, mean,na.rm=TRUE)
tab[which.max(tab)]

#	(b) What was the average bike lane length per year that they were installed?
bike$dateInstalled[bike$dateInstalled==0] = NA
tapply(bike$length,bike$dateInstalled,mean,na.rm=TRUE)

# 2. (a) Numerically [hint: `quantile()`] and (b) graphically [hint: `hist()` or `plot(density())`]
#	describe the distribution of bike "lane" lengths.
quantile(bike$length)
mean(bike$length)
sd(bike$length)

hist(bike$length)
hist(bike$length,breaks=100)

# 3. Then describe as above, after stratifying by i) type then ii) number of lanes
boxplot(bike$length~bike$type)
boxplot(log2(bike$length+1)~bike$type)

levels(factor(bike$type)) # this is the order of boxes
boxplot(bike$length~bike$numLanes)

tapply(bike$length,bike$type, quantile,na.rm=TRUE)
tapply(bike$length,bike$numLanes, quantile,na.rm=TRUE)

tapply(bike$length,bike$type, quantile, prob=.1)


## Part B

# Download the CSV: http://biostat.jhsph.edu/~ajaffe/files/indicatordeadkids35.csv
# Via: http://www.gapminder.org/data/
# Definition of indicator: How many children the average couple had that die before the age 35.

death = read.csv("http://biostat.jhsph.edu/~ajaffe/files/indicatordeadkids35.csv",
                  as.is=TRUE,row.names=1)
death2 = read.csv("http://biostat.jhsph.edu/~ajaffe/files/indicatordeadkids35.csv",
                 as.is=TRUE)
rownames(death2) = death2$X
death2$X=NULL
rownames(death2)

# 5. How many countries have data in any year?
dim(death)
!is.na(death)[1:5,1:5]
table(rowSums(!is.na(death)))

# 6. When did measurements in the US start?
death["United States",]
# death[death$X=="United States",]
!is.na(death["United States",])
allIndex=  which(!is.na(death["United States",]))
allIndex[1]
i= which(!is.na(death["United States",]))[1]
colnames(death)[i]

## one line version
colnames(death)[which(!is.na(death["United States",]))[1]]

# 7. How many countries, and which, had data the first year of measuring?
!is.na(death[,1])
which(!is.na(death[,1]))
rownames(death)[which(!is.na(death[,1]))]

# 4. Plot the distribution of average country's count across all year.
rowMeans(death,na.rm=TRUE)
hist(rowMeans(death,na.rm=TRUE))

# 5.(a) How many entries are less than 1?
death < 1
sum(death < 1,na.rm=TRUE)
mean(death < 1,na.rm=TRUE)

#	(b) Which array indices do they correspond to? [hint: `arr.ind` argument in `which()`]
head(which(death<1,arr.ind=FALSE))
head(which(death<1,arr.ind=TRUE))
ind =which(death<1,arr.ind=TRUE) 

# 6. Plot the count for each country across year in a line plot [hint: `matplot()`]
matplot(death,type="l")
