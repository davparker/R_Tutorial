###########################################################
#
# Copyright (C) 2012 by Chi Yau
# All rights reserved
#
# http://www.r-tutor.com
#


################################
# c05
n = c(2, 3, 5)
s = c("aa", "bb", "cc")
b = c(TRUE, FALSE, TRUE)
f = data.frame(n, s, b) 

mtcars[1, 2]
mtcars["Mazda RX4", "cyl"]

nrow(mtcars)    # number of data rows
ncol(mtcars)    # number of columns

head(mtcars)


################################
# c05-s01
mtcars[[9]]
mtcars[["am"]]
mtcars$am
mtcars[,"am"]


################################
# c05-s02
mtcars[1]
mtcars["mpg"]
mtcars[c("mpg", "hp")]


################################
# c05-s03
mtcars[24,]
mtcars[c(3, 24),]

mtcars["Camaro Z28",]
mtcars[c("Datsun 710", "Camaro Z28"),]

L = mtcars$am == 0
L
mtcars[L,]
mtcars[L,]$mpg


################################
# c05-s04
mydata = read.table("mydata.txt")  # read text file
mydata                             # print data frame

mydata = read.csv("mydata.csv")  # read csv file
mydata





