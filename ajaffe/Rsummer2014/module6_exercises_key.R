####################
# Module 6 - Lab
# 1/8/14
####################

## Part A

# Bike Lanes Dataset: BikeBaltimore is the Department of Transportation's bike program. 
# https://data.baltimorecity.gov/Transportation/Bike-Lanes/xzfj-gyms
# 	Download as a CSV (like the Monuments dataset) in your current working directory
bike2 = read.csv("data/Bike_Lanes.csv",as.is=FALSE)
class(bike2$length)
head(as.numeric(bike2$length))
head(as.character(bike2$length))
head(as.numeric(as.character(bike2$length)))

bike = read.csv("data/Bike_Lanes.csv",as.is=TRUE)
bike[bike == " "] = NA

bike = read.csv("data/Bike_Lanes.csv",as.is=TRUE,na.strings=" ")

bike$length = as.numeric(bike$length)

# 1. How many bike "lanes" are currently in Baltimore?
nrow(bike)

# 2. How many (a) feet and (b) miles of bike "lanes" are currently in Baltimore?
sum(bike$length)
sum(bike$length)/5280
sum(bike$length/5280)

# 3. How many types of bike lanes are there? 
# Which type has (a) the most number of and (b) longest average bike lane length?
length(unique(bike$type))
tab=table(bike$type)
tab[which.max(tab)]

meanByType = c(mean(bike$length[bike$type == names(tab)[1]], na.rm=TRUE),
  mean(bike$length[bike$type == names(tab)[2]], na.rm=TRUE),
  mean(bike$length[bike$type == names(tab)[3]], na.rm=TRUE),
  mean(bike$length[bike$type == names(tab)[4]], na.rm=TRUE),
  mean(bike$length[bike$type == names(tab)[5]], na.rm=TRUE),
  mean(bike$length[bike$type == names(tab)[6]], na.rm=TRUE),
  mean(bike$length[bike$type == names(tab)[7]], na.rm=TRUE))
names(meanByType) = names(tab)
meanByType[which.max(meanByType)]

# tab = tapply(bike$length, bike$type ,mean)
# tab[which.max(tab)]

# 4. How many different projects do the "bike" lanes fall into? 
# Which project category has the longest average bike lane? 
length(unique(bike$project))
# tab = tapply(bike$length,bike$project,mean,na.rm=TRUE)
tab[which.max(tab)]
