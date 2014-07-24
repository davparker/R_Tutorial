##Sal Data from https://data.baltimorecity.gov/Financial/Baltimore-City-Employee-Salaries-2011/ijfz-2v3c
## Salary Data
## rest <- restaurant data from

Sal <- read.csv(file="Baltimore_City_Employee_Salaries_2011.csv", header=TRUE, as.is=TRUE)
rest <- read.csv(file="Restaurants.csv", header=TRUE, as.is=TRUE)
mon <- read.csv(file="Monuments.csv", header=TRUE, as.is=TRUE)
## Question 1 - Finding strings
  
# Make an object called health.sal using the salaries data set, with only agencies of those with "fire" (or any forms), if any, in the name:
unique(Sal$Agency[grep(x=toupper(Sal$Agency), pattern="FIRE")])

## Question 2 - Finding strings
# Make a data set called trans which contains only agencies that contain "TRANS".
trans <- Sal[ grepl( x=Sal$Agency, pattern="TRANS"), ]
table(trans$Agency)

## What TRANS Agency has the most employees?

## Take out the $ - somewhat like destring, ignore("$")
trans$AnnualSalary <- gsub(pattern="$", replacement="", x=trans$AnnualSalary, fixed=TRUE)
## make it a numeric variable
trans$AnnualSalary <- as.numeric(trans$AnnualSalary)
## take means
tapply(trans$AnnualSalary, trans$Agency, mean)

## What TRANS Agency has the highest paid employees (Annual Salary) on average?

# 3 What is/are the profession(s) of people who have "abra" in their 
#   name for Baltimore's Salaries?
abras <- grep(pattern="abra", x=Sal$Name)
Sal$JobTitle[abras]


## Question 4
# Reshape the restaurants data set to wide, on council district.  
#    You may need to create an id variable by the code: 
#    <code>rest$id <- 1:nrow(rest)</code> 
  
rest$id <- 1:nrow(rest)
wide.rest <- reshape(rest, idvar="id", timevar="councilDistrict", direction="wide")
dim(rest)
dim(wide.rest)

## Using the wide data set, find the maximum number of restaurants by 
sort(unique(rest$councilDistrict))
name.cols <- paste("name", sort(unique(rest$councilDistrict)), sep=".")
colSums(!is.na(wide.rest[, name.cols]))
## and confirm with 
table(rest$councilDistrict)

# Q5
length(grep("Monument",mon$name))
sum(grepl("Monument",mon$name))

## For the most common memorial name, what police districts are they in?
tab <- table(mon$name)
which.max(tab)
max.mon <- names(which.max(tab))
table(mon$policeDistrict[mon$name %in% max.mon])

