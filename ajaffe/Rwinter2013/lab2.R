## Lab 2

##### Part A
bike = read.csv("Bike_Lanes.csv",header=TRUE,as.is=TRUE,na.strings="")

# q1
nrow(bike)

# q2, assume the length is in feet now
sum(bike$length)
sum(bike$length)/5280

# q3
table(bike$type)
length(table(bike$type))

# q4 
tab1 = tapply(bike$length, bike$type, length)
tab1[which.max(tab1)]

tab2=tapply(bike$length, bike$type, sum)
tab2[which.max(tab2)]

# q5
table(bike$project)
length(table(bike$project))
tab3 = tapply(bike$length, bike$project, mean)
tab3[which.max(tab3)]

# q6
quantile(bike$length)
quantile(bike$length, seq(0,1,by=0.1))
hist(bike$length)
hist(log2(bike$length))

boxplot(length ~ type, data=bike)
boxplot(log2(length) ~ type, data=bike)

boxplot(length ~ numLanes, data=bike)
boxplot(log2(length) ~ numLanes, data=bike)

boxplot(length ~ numLanes, data=bike, varwidth=TRUE,
          xlab="Number of Lanes", ylab="Length")
boxplot(log2(length) ~ numLanes, data=bike, varwidth=TRUE,
        xlab="Number of Lanes", ylab="log2(Length)")


##### Part B

## Lab B

death = read.csv("http://biostat.jhsph.edu/~ajaffe/files/indicatordeadkids35.csv",
                 as.is=T,header=TRUE, row.names=1)

# q1
dim(death)
check = rowSums(is.na(death)) < ncol(death)
table(check) # all have at least 1 non-missing entry

# q2
usIndex = which(!is.na(death["United States",]))[1]
colnames(death)[usIndex] # 1800

# q3
firstIndex=which(!is.na(death[,1]))
length(firstIndex)
rownames(death)[firstIndex]

# q4
head(colnames(death))
tail(colnames(death))
yr = c(1760:2010,2030,2050,2099)

Index=which(yr %in% 1760:2010)

death2 = death[,Index]
yr2 = yr[Index]

mm = colMeans(death2, na.rm=T)
plot(mm~yr2,ylab="Average Number Lost", xlab="Year")

## q5
mm2 = rowMeans(death2,na.rm=TRUE)
hist(mm2)
hist(mm2,breaks=50)
plot(density(mm2))

## q6
sum(death2 < 1,na.rm=TRUE)
Index=which(death2 < 1, arr.ind=TRUE)
head(Index)
Index[,1] = rownames(death2)[Index[,1]]
Index[,2] = yr2[as.integer(Index[,2])]
head(Index)

## q7
matplot(yr2,t(death2),type="l", lty=1,lwd=0.5,col="grey",
          xlab="Year",ylab="Death Rate")