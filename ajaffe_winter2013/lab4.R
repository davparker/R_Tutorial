load("http://biostat.jhsph.edu/~ajaffe/files/propertyTaxes.rda")

# 1
nrow(taxes)

# 2
library(stringr)
taxes$resCode = str_trim(taxes$resCode)

pr = ifelse(taxes$resCode == "PRINCIPAL RESIDENCE", 1, 0)
val = as.numeric(gsub("$","",taxes$cityTax, fixed=TRUE))
boxplot(val ~ pr)
boxplot(log10(val) ~ pr)

library(ggplot2)
qplot(factor(pr), val, geom = "boxplot")
qplot(factor(pr), log10(val), geom = "boxplot")

# 3
taxes2 = taxes[taxes$resCode=="PRINCIPAL RESIDENCE",]
val2 = as.numeric(gsub("$","",taxes2$cityTax, fixed=TRUE))

hist(log10(val2))
plot(density(log10(val2)))

library(lattice)
densityplot(log10(val2))

# 4
taxes2 = taxes[taxes$resCode=="PRINCIPAL RESIDENCE",]

taxes2$lotSize = str_trim(taxes2$lotSize)

# first lets take care of acres
aIndex=  grep("ACRES", taxes2$lotSize)
acre = taxes2$lotSize[aIndex]
acre = gsub(" ACRES","",acre)
acre = gsub("-",".",acre,fixed=TRUE)
acre2 = as.numeric(acre)*43560

# oh well.
acre[is.na(acre2)]

### now feet
fIndex = grep("X", taxes2$lotSize)
ft = taxes2$lotSize[fIndex]
ft = gsub("-",".",ft,fixed=TRUE)
width = as.numeric(sapply(strsplit(ft,"X"),function(x) x[1]))
length = as.numeric(sapply(strsplit(ft,"X"),function(x) x[2]))
sqft = width*length

# now add column
taxes2$sqft = rep(NA)
taxes2$sqft[aIndex] = acre2
taxes2$sqft[fIndex] = sqft
table(is.na(taxes2$sqft))

# some are already sq ft
sIndex=grep("FT", taxes2$lotSize)
sf = taxes2$lotSize[sIndex]
sqft2 = as.numeric(sapply(strsplit(sf," "),function(x) x[1]))
taxes2$sqft[sIndex] = sqft2
table(is.na(taxes2$sqft))
