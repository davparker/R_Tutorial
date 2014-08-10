#################
# Data Cleaning and Plotting
##############


## Download the "Real Property Taxes" Data from OpenBaltimore:
## https://data.baltimorecity.gov/Property/Real-Property-Taxes/27w9-urtv
## as a .csv file

tax2 = read.csv("~/../Downloads/Real_Property_Taxes.csv",as.is=TRUE)
yr = sapply(strsplit(tax$asOfDate,"/"), "[",3)
tax = tax[yr == "2012",]

# 1. Read the Property Tax data into R and call it the variable `tax`
# tax = read.csv("Real_Property_Taxes.csv", as.is=TRUE)
load("C:/Users/Andrew/Downloads/propertyTaxes.rda")
tax = taxes

table(tax$resCode)
library(stringr)
tax$resCode = str_trim(tax$resCode)
table(tax$resCode)

# convert to numeric $$
tax$cityTax = as.numeric(gsub("$","",tax$cityTax,fixed=TRUE))
tax$stateTax = as.numeric(gsub("$","",tax$stateTax,fixed=TRUE))
tax$amountDue = as.numeric(gsub("$","",tax$amountDue,fixed=TRUE))

# 2. How many addresses pay property taxes? 
dim(tax) # ? all homes in dataset
length(unique(tax$propertyAddress)) # those with unique address
length(unique(tax$propertyAddress[tax$cityTax > 0]))
# and those that have non-zero city
length(unique(tax$propertyAddress[tax$cityTax >0  & tax$stateTax >  0]))
table(tax$amountDue > 0)
table(tax$amountDue > tax$cityTax+tax$stateTax)

# 3. What is the total city and state tax charged?
colSums(tax[,c("cityTax","stateTax")])
sum(tax$cityTax)
sum(tax$stateTax)
sum(colSums(tax[,c("cityTax","stateTax")]))
sum(tax$cityTax) + sum(tax$stateTax)
sum(tax$cityTax, tax$stateTax)/1e6

sum(tax$amountDue)/1e6

# 4. What is the 75th percentile of city and state tax paid by ward?
tapply(tax$cityTax, tax$ward, quantile, prob=0.75, na.rm=TRUE)
tapply(tax$stateTax, tax$ward, quantile, prob=0.75, na.rm=TRUE)


# 5. Using `tapply()` and/or `table()`

wardList =split(tax,tax$ward)

#	a. how many observations are in each ward?
table(tax$ward)
sapply(wardList, nrow)

#	b. what is the mean state tax per ward
tapply(tax$stateTax, tax$ward, mean)
sapply(wardList, function(x) mean(x$stateTax))

#	c. what is the maximum amount still due?
tapply(tax$amountDue, tax$ward, max)
sapply(wardList, function(x) max(x$amountDue))

# 6. Make boxplots using a) default and b) ggplot2 graphics showing cityTax 
#	 	by whether the property	is a principal residence or not.

boxplot(cityTax ~ resCode, data=tax,ylab="city tax")
ct10 = log10(tax$cityTax+1) # try log10
boxplot(ct10 ~ tax$resCode,ylab="log10(city tax+1)",
          cex.axis=.6)
boxplot(ct10 ~ tax$resCode,names = c("Not", "Is"),
          ylab="log10(city tax+1)")
boxplot(ct10 ~ tax$resCode,ylab="log10(city tax+1)",
        yaxt="n")
axis(2, at = 0:6, labels = paste0("$",10^(0:6)))

## ggplot2
library(ggplot2)
qplot(factor(resCode), cityTax, data = tax, geom = "boxplot")
qplot(factor(resCode), log10(cityTax+1),data = tax, geom = "boxplot")


# 7. Subset the data to only retain those houses that are principal residences. 
#	a) How many such houses are there?
tax2 = tax[tax$resCode=="PRINCIPAL RESIDENCE",]
nrow(tax2)

#	b) Describe the distribution of property taxes on these residences.
hist(log10(tax2$cityTax+1))
quantile(tax2$cityTax)
hist(log10(tax2$stateTax+1))
quantile(tax2$stateTax)

# 8. Convert the 'lotSize' variable to a numeric square feet variable. 
#	Tips: - Assume hyphens represent decimal places within measurements. 
#		  - 1 acre = 43560 square feet
# 		  - Don't spend more than 5-10 minutes on this; stop and move on
tax2$lotSize = str_trim(tax2$lotSize) # trim white space
lot = tax2$lotSize # i want to check later

# first lets take care of acres
aIndex= grep("ACRE.*", tax2$lotSize)
acre = tax2$lotSize[aIndex]

acre = gsub(" ACRE.*","",acre)
acre[is.na(as.numeric(acre))]

acre = gsub("-",".",acre,fixed=TRUE)
acre[is.na(as.numeric(acre))]

acre = gsub("ACRES","", acre, fixed=TRUE)
acre[is.na(as.numeric(acre))]

acre = gsub("O","0", acre, fixed=TRUE)
acre = gsub("Q","", acre, fixed=TRUE)
acre2 = as.numeric(acre)*43560

### now feet
fIndex = grep("X", tax2$lotSize)
ft = tax2$lotSize[fIndex]
ft = gsub("-",".",ft,fixed=TRUE)
width = as.numeric(sapply(strsplit(ft,"X"),"[", 1))
width = as.numeric(sapply(strsplit(ft,"X"),function(x) x[1]))

length = as.numeric(sapply(strsplit(ft,"X"),"[", 2))
sqft = width*length

# now add column
tax2$sqft = rep(NA)
tax2$sqft[aIndex] = acre2
tax2$sqft[fIndex] = sqft
mean(!is.na(tax2$sqft))

# some are already sq ft
sIndex=c(grep("FT", tax2$lotSize), grep("S.*F.", tax2$lotSize))
sf = tax2$lotSize[sIndex]
sqft2 = as.numeric(sapply(strsplit(sf," "),function(x) x[1]))
tax2$sqft[sIndex] = sqft2
table(is.na(tax2$sqft)) # 50

## progress!
lot[is.na(tax2$sqft)]


# 9.a) Plot your numeric lotSize versus cityTax on principal residences. 
#	b) How many values of lot size were missing?

plot(log10(tax2$cityTax+1), log10(tax2$sqft))

#  b) How many values of lot size were missing?
sum(is.na(tax2$sqft)) # 50!!


################################
## Read in the Salary FY2012 dataset

# 10. Make an object called health.sal using the salaries data set, 
#		with only agencies of those with "fire" (or any forms), if any, in the name

Sal = read.csv("data/Baltimore_City_Employee_Salaries_FY2012.csv",
               as.is=TRUE)
Sal$AnnualSalary = as.numeric(gsub("$","",Sal$AnnualSalary,fixed=TRUE))
Sal$GrossPay = as.numeric(gsub("$","",Sal$GrossPay, fixed=TRUE))

health.sal = Sal[grep("fire", Sal$Agency, ignore.case=TRUE),]

# 11. Make a data set called trans which contains only agencies that contain "TRANS".
trans = Sal[grep("trans", Sal$Agency,ignore.case=TRUE),]

# 12. What is/are the profession(s) of people who have "abra" in their name for Baltimore's Salaries?
table(Sal$JobTitle[grep("abra", Sal$name)])

# 13. What is the distribution of annual salaries look like? What is the IQR?
hist(Sal$AnnualSalary)
quantile(Sal$AnnualSalary)

# 14. Convert HireDate to the `Date` class - plot Annual Salary vs Hire Date
Sal$HireDate = as.Date(Sal$HireDate, "%m/%d/%Y")

# 15. Plot annual salary versus hire date. 
#		Hint: first convert to numeric and date respectively
plot(AnnualSalary ~ HireDate, data=Sal)
plot(Sal$HireDate, Sal$AnnualSalary)

# 16. Create a smaller dataset that only includes the
# 	Police Department,  Fire Department and Sheriff's Office.
Sal$Agency = str_trim(Sal$Agency)

Sal2 = Sal[Sal$Agency %in% c("Police Department",
                            "Fire Department", 
                             "Sheriff's Office"),]

#  a. How many employees are in this new dataset?
dim(Sal2)
nrow(Sal2)

# 17. Replot annual salary versus hire date, color by Agency using
#	i) regular plotting and ii) ggplot2
plot(AnnualSalary ~ HireDate, data=Sal2, 
      col = as.numeric(factor(Agency)))
legend("topleft", levels(factor(Sal2$Agency)),
       col = 1:3, pch = 15)

yl = quantile(Sal2$AnnualSalary, c(0,0.995))

qplot(x=HireDate, y=AnnualSalary, data=Sal2, geom=c("point", "smooth"), 
        color=Agency, ylim = yl)

ggplot(Sal2, aes(x=HireDate, y=AnnualSalary, color=Agency)) +
  geom_point(shape=19) +  ylim(yl) +
  geom_smooth(method=loess, se=TRUE, fullrange=TRUE,size=3,n=150)


