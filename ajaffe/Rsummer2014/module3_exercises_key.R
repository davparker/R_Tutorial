####################
# Module 3 - Lab
# 1/6/14
####################

## In this lab you can use the interactive console to explore but please record your commands here.  
# Remember anything you type here can be "sent" to the console with Cmd-Enter (OS-X) or Cntr-Enter (Windows/Linux).

# 1. Load in the `CO2` dataset (which is included like the `iris` dataset
data(CO2)

# 2. What class is `CO2`?
class(CO2)

# 3. How many observations (rows) and variables (columns) are in the `CO2` dataset?
dim(CO2)
nrow(CO2)
ncol(CO2)

# 4. How many different "plants" are in the data? (hint: `length` and `unique`)
unique(CO2$Plant)
length(unique(CO2$Plant))
levels(CO2$Plant)
length(levels(CO2$Plant))
length(table(CO2$Plant))

# 5. How many different "types" are in the data?
length(unique(CO2$Type))

# 6. Tabulate "type" and "treatment" - what are the dimensions of the resulting table?
#		hint: you can assign tables to variables
tab = table(CO2$Type, CO2$Treatment)
dim(tab)
tab

# 7. Create a new `data.frame` named `CO2.even` that contains the even rows of `CO2`
#		hint: subsetting and `seq` (note the `by` argument)
seq(2,nrow(CO2),2)

CO2.even = CO2[seq(2,nrow(CO2),by=2),]

# 8. How many observations are in `CO2.even`?
dim(CO2.even)

# 9. What are the sums of the a) concentrations and b) uptake values in the `CO2.even` dataset?
#		And what are their means?
sum(CO2.even$conc)
sum(CO2.even$uptake)
mean(CO2.even$conc)
mean(CO2.even$uptake)