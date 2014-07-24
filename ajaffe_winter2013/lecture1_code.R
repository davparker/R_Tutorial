
## @knitr workingDirectory, comment="", prompt=TRUE
## get the working directory
getwd()
### set the working directory
# setwd("F:/Hopkins/Lieber/Classes/WinterInstituteR/Lectures") # desktop
setwd("..")
getwd()


## @knitr directoryNav, comment="", prompt=TRUE
dir("./") # shows directory contents
dir("..")
head(dir("F:/Hopkins/Lieber"))


## @knitr calcDemo, comment="", prompt=TRUE
2+2
2*4
2^3


## @knitr calcDemo2, comment="", prompt=TRUE
2+(2*3)^2
(1+3)/2 + 45


## @knitr assign, comment="", prompt=TRUE
x=2
x
x*4
x+2


## @knitr assignClass, comment="", prompt=TRUE
class(x)
y = "hello world!"
print(y)
class(y)


## @knitr assign2, comment="", prompt=TRUE
## ?str
str(x)
str(y)


## @knitr assign3a, comment="", prompt=TRUE
x <- c(1,4,6,8)
x
str(x)


## @knitr assign3b, comment="", prompt=TRUE
length(x)
y
length(y)


## @knitr assign4, comment="", prompt=TRUE
x + 2
x * 3
x + c(1,2,3,4)


## @knitr assign5, comment="", prompt=TRUE
y = x + c(1,2,3,4)
y 


## @knitr readCSV
read.csv


## @knitr head, comment="",prompt=TRUE
z = 1:100
head(z)
tail(z)


## @knitr readCSV2, comment="",results='markup'
mon = read.csv("Monuments.csv",header=TRUE,as.is=TRUE)
head(mon)


## @knitr readCSV3, comment="", prompt=TRUE
class(mon)
str(mon)


## @knitr matrix, comment="", prompt=TRUE
n = 1:9 # sequence from first number to second number incrementing by 1
n
mat = matrix(n, nr = 3)
mat


## @knitr subset1, comment="",prompt=TRUE
x1 = 10:20
x1
length(x1)


## @knitr subset2, comment="",prompt=TRUE
x1[1] # selecting first element
x1[3:4] # selecting third and fourth elements
x1[c(1,5,7)] # selecting first, fifth, and seventh elements


## @knitr subset3, comment="", prompt=TRUE
mat[1,1] # individual entry: row 1, column 1
mat[1,] # first row
mat[,1] # first columns


## @knitr subset4, comment="", prompt=TRUE
class(mat[1,])
class(mat[,1])


## @knitr subset5, comment="", prompt=TRUE
names(mon)
head(mon$zipCode)
head(mon$neighborhood)


## @knitr subset6, comment="", prompt=TRUE
head(mon[,2])


## @knitr subset7, comment="", prompt=TRUE
mon[1:3,c("name","zipCode")]


## @knitr unique,comment="",prompt=TRUE
x = c(1,2,3,4,4,5,4,5)
unique(x)


## @knitr unique2,comment="",prompt=TRUE
unique(c(5,1,2,3,4,4,5,4,5))


## @knitr table, comment="", prompt=TRUE
table(mon$zipCode)


## @knitr q1, comment="", prompt=TRUE
names(mon)
names(mon)[6] = "location"
names(mon)


## @knitr q2, comment="", prompt=TRUE
nrow(mon)
dim(mon)
length(mon$name)


## @knitr q3a, comment="", prompt=TRUE
unique(mon$zipCode)
unique(mon$policeDistrict)
unique(mon$councilDistrict)


## @knitr q3b, comment="", prompt=TRUE
unique(mon$neighborhood)


## @knitr q3c, comment="", prompt=TRUE
length(unique(mon$zipCode))
length(unique(mon$policeDistrict))
length(unique(mon$councilDistrict))
length(unique(mon$neighborhood))


## @knitr q3d, comment="", prompt=TRUE
table(mon$zipCode)
length(table(mon$zipCode))


## @knitr q4a, comment="", prompt=TRUE
tab = table(mon$zipCode, mon$neighborhood)
# tab
tab[,"Downtown"]
length(unique(tab[,"Downtown"]))


## @knitr logical1, comment="", prompt=TRUE
z = c(TRUE,FALSE,TRUE,FALSE)
class(z)
sum(z)


## @knitr logical2, comment="", prompt=TRUE
z2 = c("TRUE","FALSE","TRUE","FALSE")
class(z2)
sum(z2)
identical(z,z2)


## @knitr q4b, comment="", prompt=TRUE
tt = tab[,"Downtown"]
tt
tt == 0 # which entries are equal to 0


## @knitr q4c, comment="", prompt=TRUE
tab[,"Downtown"] !=0
sum(tab[,"Downtown"] !=0)
sum(tab[,"Johns Hopkins Homewood"] !=0)


## @knitr q4d, comment="", prompt=TRUE
dt = mon[mon$neighborhood == "Downtown",]
head(mon$neighborhood == "Downtown",10)
dim(dt)
length(unique(dt$zipCode))


## @knitr q5, comment="", prompt=TRUE
head(mon$location)
table(mon$location != "") # FALSE=DO and TRUE=DO NOT


## @knitr q6a, comment="", prompt=TRUE
tabZ = table(mon$zipCode)
head(tabZ)
max(tabZ)
tabZ[tabZ == max(tabZ)]


## @knitr q6b, comment="", prompt=TRUE
which.max(tabZ) # this is the element number
tabZ[which.max(tabZ)] # this is the actual maximum


## @knitr q6c, comment="", prompt=TRUE
tabN = table(mon$neighborhood)
tabN[which.max(tabN)] 
tabC = table(mon$councilDistrict)
tabC[which.max(tabC)] 
tabP = table(mon$policeDistrict)
tabP[which.max(tabP)] 


## @knitr which, comment="", prompt=TRUE
mon$location != ""
which(mon$location != "")


