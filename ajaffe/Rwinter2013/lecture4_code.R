
## @knitr plotEx, comment="",prompt=TRUE, fig.width=5.5,fig.height=5.5, fig.align='center',cache=TRUE
death = read.csv("http://biostat.jhsph.edu/~ajaffe/files/indicatordeadkids35.csv",
                 as.is=T,header=TRUE, row.names=1)
year = as.integer(gsub("X","",names(death)))
plot(as.numeric(death["Sweden",])~year)


## @knitr plotEx2, comment="",prompt=TRUE, fig.width=6,fig.height=6, fig.align='center',cache=TRUE
plot(as.numeric(death["Sweden",])~year,
      ylab="# of deaths per family", main = "Sweden")


## @knitr plotEx3, comment="",prompt=TRUE, fig.width=6,fig.height=6,fig.align='center', cache=TRUE
plot(as.numeric(death["Sweden",])~year,
      ylab="# of deaths per family", main = "Sweden",
     xlim = c(1760,2012), pch = 19, cex=1.2,col="blue")


## @knitr plotEx4, comment="",prompt=TRUE, fig.width=6,fig.height=6,fig.align='center', cache=TRUE
scatter.smooth(as.numeric(death["Sweden",])~year,span=0.2,
      ylab="# of deaths per family", main = "Sweden",lwd=3,
     xlim = c(1760,2012), pch = 19, cex=0.9,col="grey")


## @knitr plotEx5, comment="",prompt=TRUE, fig.width=10,fig.height=5,fig.align='center', cache=TRUE
par(mfrow=c(1,2))
scatter.smooth(as.numeric(death["Sweden",])~year,span=0.2,
      ylab="# of deaths per family", main = "Sweden",lwd=3,
     xlim = c(1760,2012), pch = 19, cex=0.9,col="grey")
scatter.smooth(as.numeric(death["United Kingdom",])~year,span=0.2,
      ylab="# of deaths per family", main = "United Kingdom",lwd=3,
     xlim = c(1760,2012), pch = 19, cex=0.9,col="grey")


## @knitr plotEx6, comment="",prompt=TRUE, fig.width=10,fig.height=5,fig.align='center', cache=TRUE
par(mfrow=c(1,2))
yl = range(death[c("Sweden","United Kingdom"),])
scatter.smooth(as.numeric(death["Sweden",])~year,span=0.2,ylim=yl,
      ylab="# of deaths per family", main = "Sweden",lwd=3,
     xlim = c(1760,2012), pch = 19, cex=0.9,col="grey")
scatter.smooth(as.numeric(death["United Kingdom",])~year,span=0.2,
      ylab="", main = "United Kingdom",lwd=3,ylim=yl,
     xlim = c(1760,2012), pch = 19, cex=0.9,col="grey")


## @knitr barplot2, comment="",prompt=TRUE, fig.width=5,fig.height=5,fig.align='center', cache=TRUE
## Stacked Bar Charts
cars = read.csv("http://biostat.jhsph.edu/~ajaffe/files/kaggleCarAuction.csv",as.is=T)
counts <- table(cars$IsBadBuy, cars$VehicleAge)
barplot(counts, main="Car Distribution by Age and Bad Buy Status",
  xlab="Vehicle Age", col=c("darkblue","red"),
    legend = rownames(counts))


## @knitr barplot2a, comment="",prompt=TRUE, fig.width=5,fig.height=5,fig.align='center', cache=TRUE
## Use percentages (column percentages)
barplot(prop.table(counts, 2), main="Car Distribution by Age and Bad Buy Status",
  xlab="Vehicle Age", col=c("darkblue","red"),
    legend = rownames(counts))


## @knitr barplot3, comment="",prompt=TRUE, fig.width=5,fig.height=5,fig.align='center', cache=TRUE
# Stacked Bar Plot with Colors and Legend    
barplot(counts, main="Car Distribution by Age and Bad Buy Status",
  xlab="Vehicle Age", col=c("darkblue","red"),
    legend = rownames(counts), beside=TRUE)


## @knitr pal, comment="",prompt=TRUE, fig.width=4,fig.height=4,fig.align='center', cache=TRUE
palette()
plot(1:8, 1:8, type="n")
text(1:8, 1:8, lab = palette(), col = 1:8)


## @knitr pal2, comment="",prompt=TRUE, fig.width=4,fig.height=4,fig.align='center', cache=TRUE
palette(c("darkred","orange","blue"))
plot(1:3,1:3,col=1:3,pch =19,cex=2)


## @knitr pal3, comment="",prompt=TRUE, fig.width=6.5,fig.height=6.5,fig.align='center', cache=FALSE
palette("default")
with(ChickWeight, plot(weight ~ Time, pch = 19, col = Diet))


## @knitr pal4, comment="",prompt=TRUE, fig.width=6.5,fig.height=6.5,fig.align='center', cache=FALSE
library(RColorBrewer)
palette(brewer.pal(5,"Dark2"))
with(ChickWeight, plot(weight ~ Time, pch = 19,  col = Diet))


## @knitr pal5, comment="",prompt=TRUE, fig.width=6.5,fig.height=6.5,fig.align='center', cache=FALSE
library(RColorBrewer)
palette(brewer.pal(5,"Dark2"))
with(ChickWeight, plot(weight ~ jitter(Time,amount=0.2),
                        pch = 19,  col = Diet),xlab="Time")


## @knitr leg1, comment="",prompt=TRUE, fig.width=6.5,fig.height=6.5,fig.align='center', cache=FALSE
palette(brewer.pal(5,"Dark2"))
with(ChickWeight, plot(weight ~ jitter(Time,amount=0.2),
                        pch = 19,  col = Diet),xlab="Time")
legend("topleft", paste("Diet",levels(ChickWeight$Diet)), 
        col = 1:length(levels(ChickWeight$Diet)),
       lwd = 3, ncol = 2)


## @knitr boxplots, comment="",prompt=TRUE, fig.width=6,fig.height=6,fig.align='center', cache=FALSE
with(ChickWeight, boxplot(weight ~ Diet, outline=FALSE))
points(ChickWeight$weight ~ jitter(as.numeric(ChickWeight$Diet),0.5))


## @knitr circ, comment="",prompt=TRUE, fig.width=6,fig.height=6,fig.align='center', cache=FALSE
load("../lecture2/charmcirc.rda")
palette(brewer.pal(7,"Dark2"))
dd = factor(dat$day)
with(dat, plot(orangeAverage ~ greenAverage, pch=19, col = as.numeric(dd)))
legend("bottomright", levels(dd), col=1:length(dd), pch = 19)


## @knitr circ2, comment="",prompt=TRUE, fig.width=6,fig.height=6,fig.align='center', cache=FALSE
dd = factor(dat$day, levels=c("Monday","Tuesday","Wednesday","Thursday",
                              "Friday","Saturday","Sunday"))
with(dat, plot(orangeAverage ~ greenAverage, pch=19, col = as.numeric(dd)))
legend("bottomright", levels(dd), col=1:length(dd), pch = 19)


## @knitr lattice1, comment="",prompt=TRUE, fig.width=6,fig.height=6,fig.align='center', cache=FALSE
library(lattice)
xyplot(weight ~ Time | Diet, data = ChickWeight)


## @knitr lattice2, comment="",prompt=TRUE, fig.width=6,fig.height=6,fig.align='center', cache=FALSE
densityplot(~weight | Diet, data = ChickWeight)


## @knitr levelplot1, comment="",prompt=TRUE, fig.width=6,fig.height=6,fig.align='center', cache=FALSE
rownames(dat2) = dat2$date
mat = as.matrix(dat2[975:nrow(dat2),3:6])
levelplot(t(mat), aspect = "fill")


## @knitr levelplot2, comment="",prompt=TRUE, fig.width=6,fig.height=6,fig.align='center', cache=FALSE
theSeq = seq(0,max(mat), by=50)
my.col <- colorRampPalette(brewer.pal(5,"Greens"))(length(theSeq))
levelplot(t(mat), aspect = "fill",at = theSeq,col.regions = my.col,xlab="Route",ylab="Date")


## @knitr levelplot3, comment="",prompt=TRUE, fig.width=10,fig.height=6,fig.align='center', cache=TRUE
tmp=death[grep("s$", rownames(death)), 200:251]
yr = gsub("X","",names(tmp))
theSeq = seq(0,max(tmp,na.rm=TRUE), by=0.05)
my.col <- colorRampPalette(brewer.pal(5,"Reds"))(length(theSeq))
levelplot(t(tmp), aspect = "fill",at = theSeq,col.regions = my.col,
           scales=list(x=list(label=yr, rot=90, cex=0.7)))


## @knitr cloud1, comment="",prompt=TRUE, fig.width=6,fig.height=6,fig.align='center', cache=TRUE
cloud(weight ~ weight*Chick | Diet, data=ChickWeight)


## @knitr cloud2, comment="",prompt=TRUE, fig.width=6,fig.height=6,fig.align='center', cache=TRUE
cloud(weight ~ weight*Chick | Diet, data=ChickWeight, 
        screen = list(z = 40, x = -70, y=60))


## @knitr geoboxplot, comment="",prompt=TRUE, fig.width=6,fig.height=6,fig.align='center', cache=TRUE
library(ggplot2)
qplot(factor(Diet), weight, data = ChickWeight, geom = "boxplot")


## @knitr geoboxplot2, comment="",prompt=TRUE, fig.width=6,fig.height=6,fig.align='center', cache=TRUE
p = ggplot(ChickWeight, aes(Diet, weight))
p + geom_boxplot(notch=TRUE, aes(fill=Diet)) + geom_jitter() + coord_flip()


## @knitr cor1, comment="",prompt=TRUE
cor(dat2$orangeAverage, dat2$purpleAverage)
cor(dat2$orangeAverage, dat2$purpleAverage, use="complete.obs")


## @knitr cor2, comment="",prompt=TRUE
signif(cor(dat2[,grep("Average",names(dat2))], use="complete.obs"),3)


## @knitr cor3, comment="",prompt=TRUE
signif(cor(dat2[,3:4],dat2[,5:6], use="complete.obs"),3)


## @knitr cor4, comment="",prompt=TRUE
ct= cor.test(dat2$orangeAverage, dat2$purpleAverage, use="complete.obs")
ct


## @knitr cor4a, comment="",prompt=TRUE, fig.height=6,fig.width=6
plot(dat2$orangeAverage, dat2$purpleAverage, xlab="Orange Line", ylab="Purple Line",main="Average Ridership",cex.axis=1.5, cex.lab=1.5,cex.main=2)
legend("topleft", paste("r =", signif(ct$estimate,3)), bty="n",cex=1.5)


## @knitr cor5, comment="",prompt=TRUE
# str(ct)
names(ct)
ct$statistic
ct$p.value


## @knitr tt1, comment="",prompt=TRUE
tt = t.test(dat2$orangeAverage, dat2$purpleAverage)
tt
names(tt)


## @knitr tt2, comment="",prompt=TRUE
tt2 = t.test(VehBCost~IsBadBuy, data=cars)
tt2$estimate


## @knitr tt3, comment="",prompt=TRUE, fig.height=5.5,fig.width=5.5
boxplot(VehBCost~IsBadBuy, data=cars, xlab="Bad Buy",ylab="Value")
leg = paste("t=", signif(tt$statistic,3), " (p=",signif(tt$p.value,3),")",sep="")
legend("topleft", leg, cex=1.2, bty="n")


## @knitr prop1, comment="",prompt=TRUE
prop.test(x=15, n =32)


## @knitr chisq1, comment="",prompt=TRUE
tab = table(cars$IsBadBuy, cars$IsOnlineSale)
tab


## @knitr chisq2, comment="",prompt=TRUE
cq=chisq.test(tab)
cq
names(cq)
cq$p.value


## @knitr chisq3, comment="",prompt=TRUE
chisq.test(tab)
prop.test(tab)


## @knitr regress1, comment="",prompt=TRUE
fit = lm(VehOdo ~ VehicleAge, data=cars)
fit


## @knitr regress2, comment="",prompt=TRUE
summary(fit)


## @knitr regress3, comment="",prompt=TRUE
summary(fit)$coef


## @knitr regress4, comment="",prompt=TRUE, fig.height=5,fig.width=10,cache=TRUE
library(scales)
par(mfrow=c(1,2))
plot(VehOdo ~ jitter(VehicleAge,amount=0.2), data=cars, pch = 19,
     col = alpha("black",0.05), xlab="Vehicle Age (Yrs)")
abline(fit, col="red",lwd=2)
legend("topleft", paste("p =",summary(fit)$coef[2,4]))
boxplot(VehOdo ~ VehicleAge, data=cars, varwidth=TRUE)
abline(fit, col="red",lwd=2)


## @knitr regress5, comment="",prompt=TRUE, fig.height=5,fig.width=10,cache=TRUE
fit2 = lm(VehOdo ~ VehicleAge + WarrantyCost, data=cars)
summary(fit2)  


## @knitr regress6, comment="",prompt=TRUE, fig.height=5,fig.width=10,cache=TRUE
fit3 = lm(VehOdo ~ factor(TopThreeAmericanName), data=cars)
summary(fit3)  


