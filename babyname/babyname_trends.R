# http://www.r-bloggers.com/the-rise-and-fall-of-the-name-jennifer/
require(plyr)
require(ggplot2)
require(scales)

# Download data from:
# http://www.ssa.gov/oact/babynames/names.zip
setwd("~/GitHub/R Tutorial/babyname/data")
files<-list.files()
files<-files[grepl(".txt",files)]

###### Reading files
namedata <- matrix(0,ncol=4,nrow=0)

for (i in 1:length(files))
    namedata<-rbind(namedata,
                    cbind(read.csv(files[i],header=F), substr(files[i],4,7)))

colnames(namedata)<-c("name","gender","count", "year")

setwd("~/GitHub/R Tutorial/babyname")

dim(namedata)
# 1.8 million rows

Mdata<-namedata[namedata$gender=="M",]
Fdata<-namedata[namedata$gender=="F",]

Msums <- ddply(Mdata, .(name), summarize, sum=sum(count))
Fsums <- ddply(Fdata, .(name), summarize, sum=sum(count))

nrow(Msums); nrow(Fsums)
# There are 38601 male names and 64089 female names

Morder <- Msums[order(Msums[,2], decreasing = TRUE),]
Forder <- Fsums[order(Fsums[,2], decreasing = TRUE),]

c <- ggplot(Morder[1:20,], aes(x = name, y = sum, size=sum))
c + geom_point() + coord_flip() + theme(legend.position="none")+
    ggtitle("20 Most Popular Male Names Since 1880")+
    xlab("")+scale_y_continuous(name="Names Recorded With Social Security Administration", labels = comma)
# Figure 1

c <- ggplot(Forder[1:20,], aes(x = name, y = sum, size=sum))
c + geom_point() + coord_flip() + theme(legend.position="none")+
    ggtitle("20 Most Popular Female Names Since 1880")+
    xlab("")+scale_y_continuous(name="Names Recorded With Social Security Administration", labels = comma)
# Figure 2

Mdata$order <- Fdata$order <- NA # Create a variable for 
Mdata$prop <- Fdata$prop <- NA

for (i in 1880:2013) {
    Mdata[Mdata$year==i, "order"] <- 
        order(-Mdata[Mdata$year==i, "count"])
    Mdata[Mdata$year==i, "prop"] <- 
        (Mdata[Mdata$year==i, "count"])/
        sum((Mdata[Mdata$year==i, "count"]))
    Fdata[Fdata$year==i, "order"] <- 
        order(-Fdata[Fdata$year==i, "count"])
    Fdata[Fdata$year==i, "prop"] <- 
        (Fdata[Fdata$year==i, "count"])/
        sum((Fdata[Fdata$year==i, "count"]))  
}

top <- 7

Mrestricted <- Mdata[Mdata$name%in%Morder[1:top,1],]
Frestricted <- Fdata[Fdata$name%in%Forder[1:top,1],]

ggplot(Mrestricted, aes(x=year, y=count, group=name, color=name))+
    geom_line(size=1)+scale_x_discrete(breaks=seq(1880,2010,20))

ggplot(Mrestricted, aes(x=year, y=prop, group=name, color=name))+
    geom_line(size=1)+scale_x_discrete(breaks=seq(1880,2010,20))+
    ylab("Proportion of Total Names")

ggplot(Mrestricted, 
       aes(x=year, y=order, group=name, color=name, size=order))+
    geom_line()+scale_x_discrete(breaks=seq(1880,2010,20))+
    ylab("Order of Total Names That Year (log10)")+scale_y_log10()

ggplot(Frestricted, aes(x=year, y=count, group=name, color=name))+
    geom_line(size=1)+scale_x_discrete(breaks=seq(1880,2010,20))

ggplot(Frestricted, aes(x=year, y=prop, group=name, color=name))+
    geom_line(size=1)+scale_x_discrete(breaks=seq(1880,2010,20))+
    ylab("Proportion of Total Names")

ggplot(Frestricted, 
       aes(x=year, y=order, group=name, color=name, size=order))+
    geom_line()+scale_x_discrete(breaks=seq(1880,2010,20))+
    ylab("Order of Total Names That Year (log10)")+scale_y_log10()
