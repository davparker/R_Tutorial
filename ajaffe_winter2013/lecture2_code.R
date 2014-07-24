
## @knitr writecsv, comment="",prompt=TRUE
dat = read.csv("C:/Users/Andrew/Dropbox/WinterRClass/Datasets/OpenBaltimore/Charm_City_Circulator_Ridership.csv", header=T,as.is=T)
dat2 = dat[,c("day","date", "orangeAverage","purpleAverage","greenAverage",
                "bannerAverage","daily")]
write.csv(dat2, file="charmcitycirc_reduced.csv", row.names=FALSE)


## @knitr save1, comment="",prompt=TRUE
save(dat,dat2,file="charmcirc.rda")


## @knitr ls, comment="",prompt=TRUE
ls()


## @knitr loadData, comment="",prompt=TRUE
tmp=load("charmcirc.rda")
tmp
ls()


## @knitr negativeIndex, comment="",prompt=TRUE
x = c(1,3,77,54,23,7,76,5)
x[1:3] # first 3
x[-2] # all but the second


## @knitr negativeIndex2, comment="",prompt=TRUE
x[-c(1,2,3)] # drop first 3
x[-1:3] # shorthand
x[-(1:3)] # needs parentheses


## @knitr seq1, comment="",prompt=TRUE
seq(1,10,by=2) # odds
seq(2,10,by=2) # evens
seq(1,10,length.out=3)


## @knitr seq_along, comment="",prompt=TRUE
x
seq(along=x)


## @knitr seq2, comment="",prompt=TRUE
seq(1,10,by=-2) # odds
seq(10,1,by=-2) # odds
seq(10,1,by=2) # evens


## @knitr seq3, comment="",prompt=TRUE
head(dat2,2) # only the first 2 rows
head(dat2[seq(2,nrow(dat2),by=2),],2)


## @knitr inEx, comment="",prompt=TRUE
(dat$day %in% c("Monday","Tuesday"))[1:20] # select entries that are monday or tuesday
which(dat$day %in% c("Monday","Tuesday"))[1:20] # which indices are true?


## @knitr andEx, comment="",prompt=TRUE
# which Mondays had more than 3000 average riders?
which(dat$day =="Monday" & dat$daily > 3000)[1:20] 


## @knitr andEx2, comment="",prompt=TRUE
Index=which(dat$daily > 10000 & dat$purpleAverage > 3000)
length(Index) # the number of days
head(dat2[Index,],2) # first 2 rows


## @knitr orEx1, comment="",prompt=TRUE
Index=which(dat$daily > 10000 | dat$purpleAverage > 3000)
length(Index) # the number of days
head(dat2[Index,],2) # first 2 rows


## @knitr naEval, comment="",prompt=TRUE
dat$purpleAverage[1:10] > 0
which(dat$purpleBoardings > 0)[1:10]


## @knitr colSelect, comment="",prompt=TRUE
dat[1:3, c("purpleAverage","orangeAverage")]
dat[1:3, c(8,5)]


## @knitr colRemove, comment="",prompt=TRUE
tmp = dat2
tmp$daily=NULL
tmp[1:3,]


## @knitr sortVorder, comment="",prompt=TRUE
x = c(1,4,7,6,4,12,9,3)
sort(x)
order(x)


## @knitr sortVorder1, comment="",prompt=TRUE
head(order(dat2$daily,decreasing=TRUE))
head(sort(dat2$daily,decreasing=TRUE))


## @knitr sortVorder2, comment="",prompt=TRUE
datSorted = dat2[order(dat2$daily,decreasing=TRUE),]
datSorted[1:5,]


## @knitr sortVorder3, comment="",prompt=TRUE
rownames(datSorted)=NULL
datSorted[1:5,]


## @knitr ifelse1, comment="",prompt=TRUE
hi_rider = ifelse(dat$daily > 10000, 1, 0)
head(hi_rider)
table(hi_rider)


## @knitr ifelse2, comment="",prompt=TRUE
riderLevels = ifelse(dat$daily < 10000, "low", 
                      ifelse(dat$daily > 20000, "high", "med"))
head(riderLevels)
table(riderLevels)


## @knitr factor1, comment="", prompt=TRUE
cc = factor(c("case","case","case","control","control","control"))
cc
levels(cc) = c("control","case")
cc


## @knitr factor2, comment="", prompt=TRUE
factor(c("case","case","case","control","control","control"), labels =c("control","case") )
factor(c("case","case","case","control","control","control"), labels =c("control","case"), ordered=TRUE)


## @knitr factor3, comment="", prompt=TRUE
x = factor(c("case","case","case","control","control","control"), labels =c("control","case") )
as.character(x)
as.numeric(x)


## @knitr cut1, comment="", prompt=TRUE
x = 1:100
cx = cut(x, breaks=c(0,10,25,50,100))
head(cx)  
table(cx)


## @knitr cut2, comment="", prompt=TRUE
cx = cut(x, breaks=c(0,10,25,50,100), labels=FALSE)
head(cx)  
table(cx)


## @knitr cut3, comment="", prompt=TRUE
cx = cut(x, breaks=c(10,25,50), labels=FALSE)
head(cx)  
table(cx)


## @knitr addingVar, comment="",prompt=TRUE
dat2$riderLevels = cut(dat2$daily, breaks = c(0,10000,20000,100000))
dat2[1:2,]
table(dat2$riderLevels, useNA="always")


## @knitr mat1, comment="",prompt=TRUE
m1 = matrix(1:9, nrow = 3, ncol = 3, byrow = FALSE)
m1
m2 = matrix(1:9, nrow = 3, ncol = 3, byrow = TRUE)
m2


## @knitr mat2, comment="",prompt=TRUE
cbind(m1,m2)


## @knitr mat3, comment="",prompt=TRUE
rbind(m1,m2)


## @knitr cbind, comment="",prompt=TRUE
dat2$riderLevels = NULL
rider = cut(dat2$daily, breaks = c(0,10000,20000,100000))
dat2 = cbind(dat2,rider)
dat2[1:2,]


## @knitr dfBuild, comment="",prompt=TRUE
df = data.frame(Date = dat$day, orangeLine=dat$orangeAverage, purpleLine=dat$purpleAverage)
df[1:5,]


## @knitr colMeans, prompt=TRUE,comment=""
tmp = dat2[,3:6]
colMeans(tmp,na.rm=TRUE)
head(rowMeans(tmp,na.rm=TRUE))


## @knitr apply1, prompt=TRUE,comment=""
tmp = dat2[,3:6]
apply(tmp,2,mean,na.rm=TRUE) # column means
apply(tmp,2,sd,na.rm=TRUE) # columns sds
head(apply(tmp,2,max,na.rm=TRUE)) # row maxs


## @knitr , comment="",prompt=TRUE
tapply(dat$daily, dat$day, max, na.rm=TRUE)


