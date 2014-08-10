# Analyzing Baby Names by state
# Data provided by Social Security Adminiistration
# sample code originated from R-Bloggers
#
# http://www.r-bloggers.com/us-names-by-state-part-i-mary-is-everywhere/
# http://www.ssa.gov/oact/babynames/limits.html
###### Settings
rm(list=ls())
library(plyr)
library(maps)
setwd("~/GitHub/R Tutorial/babyname")
if(!file.exists("./data")){
    dir.create("./data")
    file_url <- data_file <- vector("character",2)
    file_url[1] <- "http://www.ssa.gov/oact/babynames/names.zip"
    file_url[2] <- "http://www.ssa.gov/oact/babynames/state/namesbystate.zip"
    data_file[1] <- "names.zip"
    data_file[2] <- "namesbystate.zip"
    for (i in seq_along(file_url)) {
        download.file(file_url[i], paste("./data/",data_file[i], sep = "", collapse = "TRUE"))
    }
    work_dir <- getwd()
    setwd(paste(getwd(),"data",sep = "/"))
    for (i in seq_along(data_file)) {
        unzip(data_file[i])
    }
    setwd(work_dir)
}
files<-list.files("./data", pattern = ".TXT", full.names = TRUE)
files<-files[files!="./data/DC.TXT"]

###### State structure
regions=c("alabama","arizona","arkansas","california","colorado","connecticut","delaware",
           "florida","georgia","idaho","illinois","indiana","iowa","kansas",
           "kentucky","louisiana","maine","maryland","massachusetts:main","michigan:south","minnesota",
           "mississippi","missouri","montana","nebraska","nevada","new hampshire","new jersey",
           "new mexico","new york:main","north carolina:main","north dakota","ohio","oklahoma",
           "oregon","pennsylvania","rhode island","south carolina","south dakota","tennessee",
           "texas","utah","vermont","virginia:main","washington:main","west virginia",
           "wisconsin","wyoming")

# (typo) mat<-as.data.frame(cbind(regions1,NA,NA))
mat<-as.data.frame(cbind(regions,NA,NA))
mat$V2<-as.character(mat$V2)
mat$V3<-as.character(mat$V3)

###### Reading files
# dkp added us_data for complete dataset
for (i in 1:length(files))
{
    data <- read.csv(files[i],header=F)
    colnames(data)<-c("State","Gender","Year","Name","People")
    if (i == 1) {
        us_data <- data
    } else {
        us_data <- rbind(us_data, data)    
    }

    data1<-ddply(data,.(Name,Gender),summarise,SUM=sum(People))
    male1<-data1[data1$Gender=="M",]
    female1<-data1[data1$Gender=="F",]
    male1<-male1[order(male1$SUM,decreasing=TRUE),]
    female1<-female1[order(female1$SUM,decreasing=TRUE),]
    
    mat$V2[grep(tolower(state.name[grep(data$State[1], state.abb)]),mat$regions)]<-as.character(male1$Name[1])
    mat$V3[grep(tolower(state.name[grep(data$State[1], state.abb)]),mat$regions)]<-as.character(female1$Name[1])
}

jpeg("Male.jpeg",width=1200,height=800,quality=100)
map("state",fill=TRUE,col="skyblue")
map.text(add=TRUE,"state",regions=regions,labels=mat$V2)
title("Most Popular Male Name (since 1910) by State")
dev.off()

jpeg("Female.jpeg",width=1200,height=800,quality=100)
map("state",fill=TRUE,col="pink")
map.text(add=TRUE,"state",regions=regions,labels=mat$V3)
title("Most Popular Female Name (since 1910) by State")
dev.off()
###### End sample 1

###### DKP Working with Texas
library(data.table)
# us_sort <- as.data.table(us_data[order(us_data$Year,us_data$People,us_data$Gender,us_data$Name, decreasing = TRUE), ])
us_sort <- as.data.table(us_data)
setkey(us_sort,State, Gender, Year, Name, People)
get_top_st <- function(dt = us_sort, year = as.numeric(format.Date(Sys.Date(), "%Y")) -1, top_number = 5) {
    cnames <- names(dt)
    dt_summary <- NULL
    for(i in seq_along(year)) {
        dt_tmp <- head(dt[dt$Year == year[i] & dt$Gender == "F",],top_number)
        dt_summary <- rbind(dt_summary, dt_tmp)
        dt_tmp <- head(dt[dt$Year == year[i] & dt$Gender == "M",],top_number)
        dt_summary <- rbind(dt_summary, dt_tmp)
    }
    dt_summary
}
get_top_us <- function(dt = us_sort, year = as.numeric(format.Date(Sys.Date(), "%Y")) -1, top_number = 5) {
    cnames <- names(dt)
    for(i in seq_along(year)) {
        dt_tmp <- dt[dt$Year == year[i] & dt$Gender == "F",]
        setkey(dt_tmp, Name, Gender)
        dt_tmp <- head(dt_tmp[, list(SUM=sum(People)), by=key(dt)], top_number)
        if(!exists("dt_sum")) {
            dt_sum <- as.data.table(matrix(0, nrow = nrow(dt_tmp), ncol = ncol(dt_tmp)))
            cname2 <- colnames(dt_tmp)
            setnames(dt_sum,cname2)
            setkey(Name,Gender)
        }
        dt_sum <- rbind(dt_sum, dt_tmp)
    }
    setcolorder(dt_sum,-SUM,Name,Gender)
    dt_sum
}
get_top_us <- function(dt = us_sort, year = as.numeric(format.Date(Sys.Date(), "%Y")) -1, top_number = 5) {
    cnames <- names(dt)
    for(i in seq_along(year)) {
        dt_tmp <- dt[dt$Year == year[i] & dt$Gender == "F",]
        setkey(dt_tmp, Name, Gender)
        dt_tmp <- dt_tmp[, list(SUM=sum(People)), by=key(dt_tmp)]
        dt_tmp <- dt_tmp[order(-SUM, Name), ]
#   Pre-allocate dt_sum
        if(!exists("dt_sum")) {
            dt_sum <- as.data.table(matrix(0, nrow = nrow(dt_tmp), ncol = ncol(dt_tmp)))
            cname2 <- colnames(dt_tmp)
            setnames(dt_sum,cname2)
            setkey(dt_sum, Name, Gender)
        }
        dt_sum <- rbind(dt_sum, dt_tmp)
        setkey(dt_sum, Name, Gender)
    }
    for(i in seq_along(year)) {
        dt_tmp <- dt[dt$Year == year[i] & dt$Gender == "M",]
        setkey(dt_tmp, Name, Gender)
        dt_tmp <- dt_tmp[, list(SUM=sum(People)), by=key(dt_tmp)]
        dt_tmp <- dt_tmp[order(-SUM, Name), ]
        dt_sum <- rbind(dt_sum, dt_tmp)
        setkey(dt_sum, Name, Gender)
    }
    dt_sum <- dt_sum[, list(SUM=sum(SUM)), by=key(dt_sum)]
    dt_sum <- dt_sum[order(-SUM, Name), ]
    dt_F <- head(dt_sum[Gender == "F"], top_number)
    dt_M <- head(dt_sum[Gender == "M"], top_number)
    dt_sum <- rbind(dt_M, dt_F)
    dt_sum
}
data1 <- as.data.table(ddply(us_sort,.(Name,Gender),summarise,SUM=sum(People)))
head(data1[order(-SUM,Name,Gender)],5)
names(data1)
dt <- us_sort
dt1 <- dt[, list(SUM=sum(People)), by=key(dt)]
dt1 <- dt1[order(-SUM,Name), ]
tables()
dt1_M <- head(dt1[Gender == "M",], 10)
dt1_F <- head(dt1[Gender == "F",], 10)
dt1_MF <- rbind(dt1_F, dt1_M)
dt1_MF

top_10_us <- get_top_us(us_sort,2000:2013,10)
top_10_us_08 <- get_top_us(us_sort,2008:2013,10)
top_10_us_08
nrow(top_10_us)
