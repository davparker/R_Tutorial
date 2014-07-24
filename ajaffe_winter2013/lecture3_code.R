
## @knitr loadData, comment="", prompt=TRUE, echo=FALSE, cache=TRUE
load("~/Dropbox/WinterRClass/Datasets/saved_datasets_list.rda")


## @knitr assignData, comment="", prompt=TRUE, echo=FALSE, cache=TRUE
Sal <- fileList[["Salaries2011"]]
mon <- fileList$Monuments
circ <- fileList$CirculatorRidership
bike <- fileList$BikeLanes
rest <- fileList$Restaurants
xx=runif(1)


# sapply(Sal$Agency, function(x) {
#   dat <- Sal[Sal == x, ]
#   write.csv(x=dat, file=paste("~/Dropbox/WinterRClass/Datasets/Salary_", x, ".csv", sep=""))
#   })


## @knitr makeList, comment="", prompt=TRUE
mylist <- list(letters=c("A", "b", "c"), numbers=1:3, matrix(1:25, ncol=5))


## @knitr Lists, comment="", prompt=TRUE
head(mylist)


## @knitr Listsref1, comment="", prompt=TRUE
mylist[1] # returns a list
mylist["letters"] # returns a list


## @knitr Listsrefvec, comment="", prompt=TRUE
mylist[[1]] # returns the vector 'letters'
mylist$letters # returns vector
mylist[["letters"]] # returns the vector 'letters'


## @knitr Listsref2, comment="", prompt=TRUE
mylist[1:2] # returns a list


## @knitr Listsref3, comment="", prompt=TRUE
mylist$letters[1]
mylist[[2]][1]
mylist[[3]][1:2,1:2]


## @knitr table, comment="", prompt=TRUE
table(c(0, 1, 2, 3, NA, 3, 3, 2,2, 3), useNA="ifany")
table(c(0, 1, 2, 3, 2, 3, 3, 2,2, 3), useNA="always")
tab <- table(c(0, 1, 2, 3, 2, 3, 3, 2,2, 3), c(0, 1, 2, 3, 2, 3, 3, 4, 4, 3), useNA="always")
margin.table(tab, 2)
prop.table(tab, 2) # tab x y, col in stata (1 for row), neither for cell


## @knitr isna, comment="", prompt=TRUE
any(is.na(Sal$Name))
# remove leading $ off money amount
sals <- as.numeric(gsub(pattern="$",  replacement="", 
                          Sal$AnnualSalary, ,fixed=TRUE))
quantile(sals)


## @knitr xtab, comment="", prompt=TRUE
warpbreaks$replicate <- rep(1:9, len = nrow(warpbreaks))
print(xt <- xtabs(breaks ~ wool + tension + replicate, data = warpbreaks))


## @knitr ftab, comment="", prompt=TRUE
ftable(xt)


## @knitr gender, comment="", prompt=TRUE, echo=FALSE
set.seed(4)
gender <- sample(c("Male", "mAle", "MaLe", "M", "MALE", "Ma", "FeMAle", "F", "Woman", "Man", "Fm", "FEMALE"), 1000, replace =TRUE)


## @knitr gentab, comment="", prompt=TRUE
table(gender)


## @knitr RawlMatch, comment="", prompt=TRUE
grep("Rawlings",Sal$Name) # These are the indices/elements where the pattern match occurs


## @knitr grepl, comment="", prompt=TRUE
head(grep("Rawlings",Sal$Name))
head(grepl("Rawlings",Sal$Name))
head(Rawlings <- Sal[grepl("Rawlings",Sal$Name), c("Name", "JobTitle")], 2)


## @knitr greppers, comment="", prompt=TRUE
head(grep("Tajhgh",Sal$Name, value=TRUE))
grep("Jaffe",Sal$Name)
length(grep("Jaffe",Sal$Name))


## @knitr grepstar, comment="", prompt=TRUE
grep("Payne.*", x=Sal$Name, value=TRUE)
grep("Leonard.?S", x=Sal$Name, value=TRUE)[1:5]
grep("Spence.*C.*", x=Sal$Name, value=TRUE)


## @knitr classSal, comment="", prompt=TRUE
class(Sal$AnnualSalary)


## @knitr orderstring, comment="", prompt=TRUE
sort(c("1", "2", "10")) #  not sort correctly (order simply ranks the data)
order(c("1", "2", "10"))


## @knitr destringSal, comment="", prompt=TRUE
head(as.numeric(Sal$AnnualSalary), 4)


## @knitr orderSal, comment="", prompt=TRUE
Sal$AnnualSalary <- as.numeric(gsub(pattern="$", replacement="", Sal$AnnualSalary, fixed=TRUE))
Sal <- Sal[order(-Sal$AnnualSalary), ] # use negative to sort descending
head(Sal[, c("Name", "AnnualSalary", "JobTitle")])


## @knitr Paste, comment="", prompt=TRUE
paste("Visit", 1:5, sep="_")
paste("Visit", 1:5, sep="_", collapse=" ")
paste("To", "is going be the ", "we go to the store!", sep="day ")


## @knitr return2, comment="",prompt=TRUE
return2 = function(x) {
  return(x[2])
}
return2(c(1,4,5,76))


## @knitr return2a, comment="",prompt=TRUE
return2a = function(x) {
  x[2]
}
return2a(c(1,4,5,76))


## @knitr return2b, comment="",prompt=TRUE
return2b = function(x) x[2]
return2b(c(1,4,5,76))


## @knitr strsplit, comment="", prompt=TRUE
x <- c("I really", "like writing", "R code")
ss <- strsplit(x, split=" ")
ss[[2]]
sapply(ss, return2b) # use your own function
sapply(ss, function(x) x[2]) # on the fly


## @knitr sapply2, comment="",prompt=TRUE
x = ss[[1]]
x[2]
x = ss[[2]]
x[2]


## @knitr merging, comment="", prompt=TRUE
base <- data.frame(id=1:10, Age= rnorm(10, mean=65, sd=5))
visits <- data.frame(id=rep(1:8, 3), visit= rep(1:3, 8), Outcome= rnorm(2*3, mean=4, sd=2))
merged.data <- merge(base, visits, by="id")
table(merged.data$id)


## @knitr mergeall, comment="", prompt=TRUE
all.data <- merge(base, visits, by="id", all=TRUE)
table(all.data$id)


## @knitr NAmerge, comment="", prompt=TRUE
all.data[all.data$id %in% c(9, 10),]


## @knitr mergevar, comment="", prompt=TRUE
base$base <- 1
visits$visits <- 1
all.data <- merge(base, visits, by="id", all=TRUE)
all.data[is.na(all.data$visits), ]


## @knitr dftab, comment="", prompt=TRUE
tab <- table(Agency=Sal$Agency, useNA="ifany")
head(tab <- as.data.frame(tab, responseName = "N_Employees", stringsAsFactors=FALSE), 2)
Sal <- merge(Sal, tab, by="Agency")
head(Sal[, c("Name", "Agency", "N_Employees")], 2)


## @knitr binding, comment="", prompt=TRUE
head(all.data, 2)
head(t(all.data)[, 1:2]) # data is transposed
head(cbind(all.data, c("hey", "ho"))) #it will repeat to fill in the column
tail(rbind(all.data, c(11, 59.34232, 1, 4.2223))) #adding a row


## @knitr badbind, comment="", prompt=TRUE
cbind(c(0, 1, 2), c(3, 4))


## @knitr bind, comment="", prompt=TRUE
cbind(c(0, 1, 2), c(3, 4, 5))
cbind(c(1:10), c(1:5))[3:7, ]


## @knitr longwide, comment="", prompt=TRUE, echo=FALSE
wide <- data.frame(id=1, visit1="Good", visit2="Good", visit3 = "Bad")
long <- data.frame(id=rep(1, 3), visit=c(1, 2, 3), Outcome=c("Good", "Good", "Bad"))


## @knitr showlong, comment="", prompt=TRUE, echo=TRUE
head(wide)
head(long)


## @knitr reshape, comment="", prompt=TRUE
times <- c("purple", "green", "orange", "banner")
v.names <- c("Boardings", "Alightings", "Average")
print(varying <- c(sapply(times, paste, sep="", v.names)))


## @knitr reshape2, comment="", prompt=TRUE
circ$date <- as.Date(circ$date, "%m/%d/%Y") # creating a date for sorting
## important - varying, times, and v.names need to be in a correct order
long <- reshape(data=circ, direction="long", varying=varying, times=times, v.names=v.names, timevar="line", idvar=c("date"))
rownames(long) <- NULL # taking out row names
long <- long[order(long$date), ]
head(long)


## @knitr dropNAlong, comment="", prompt=TRUE
dim(long)
long <- long[!is.na(long$Boardings) & !is.na(long$Alightings) & !is.na(long$Average),]
dim(long)


## @knitr newlong, comment="", prompt=TRUE
head(long)


## @knitr rewide, comment="", prompt=TRUE
head(reshape(long, direction="wide"), 2)


## @knitr TB, comment="", prompt=TRUE, cache=TRUE
library(xlsx,verbose=FALSE)
TB <- read.xlsx(file="~/Dropbox/WinterRClass/Datasets/indicator_estimatedincidencealltbper100000.xlsx", sheetName="Data")
head(TB, 1)
TB$NA. <- NULL
head(TB, 1)


## @knitr TB.hd, comment="", prompt=TRUE, cache=FALSE
colnames(TB) <- c("Country", paste("Year", 1990:2007, sep="."))
head(TB,1)


## @knitr TB.long, comment="", prompt=TRUE
TB.long <- reshape(TB, idvar="Country", v.names="Cases", times=1990:2007, direction="long", timevar="Year", varying = paste("Year", 1990:2007, sep="."))

head(TB.long, 4)
rownames(TB.long) <- NULL
head(TB.long, 4)


## @knitr TB.long2, comment="", prompt=TRUE
TB.long2 <- reshape(TB, idvar="Country", direction="long", timevar="Year", varying = paste("Year", 1990:2007, sep="."))
head(TB.long2, 3) ### what happened?
TB.long2 <- reshape(TB, idvar="Country", direction="long", timevar="Blah", varying = paste("Year", 1990:2007, sep="."))
head(TB.long2, 3) ## Timevar can't be the stub of the original variable


## @knitr spag, comment="", prompt=TRUE, cache=TRUE
library(lattice)
xyplot(Cases ~ Year, groups= Country, data=TB.long, type="l")


## @knitr spag_short, comment="", prompt=TRUE, cache=TRUE
## Only keep a  few countries
xyplot(Cases ~ Year, groups= Country, data=TB.long, subset=Country %in% c("United States of America", "United Kingdom", "Zimbabwe"), type="l")


## @knitr spag_short2, comment="", prompt=TRUE, cache=TRUE,fig.width=4,fig.height=4
## plot things "by" Country
# xyplot(Cases ~ Year | Country, data=TB.long, subset=Country %in% c("United States of America", "United Kingdom", "Zimbabwe"), type="l")
TBC <- TB.long[TB.long$Country %in% c("United States of America", "United Kingdom", "Zimbabwe"),]
TBC$Country <- factor(TBC$Country)
xyplot(Cases ~ Year, groups= Country, data=TBC, type="l", key = simpleKey(levels(TBC$Country), lines=TRUE, points=FALSE))


## @knitr rewide2, comment="", prompt=TRUE
head(Indometh, 2)
wide <- reshape(Indometh, v.names = "conc", idvar = "Subject",
                timevar = "time", direction = "wide")
head(Indometh, 2)


