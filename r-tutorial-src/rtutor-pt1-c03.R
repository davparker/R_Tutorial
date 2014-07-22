###########################################################
#
# Copyright (C) 2012 by Chi Yau
# All rights reserved
#
# http://www.r-tutor.com
#


################################
# c03-s01
A = matrix(
     c(2, 1, 4, 5, 3, 7),  # data elements
     nrow=2)               # number of rows
A

B = matrix(
     c(2, 1, 4, 5, 3, 7), # data elements
     nrow=2,              # number of rows
     byrow=TRUE)          # fill matrix by rows
B


A[2, 3]
A[2, ]      # the 2nd row of A

A[ ,3]      # the 3rd column of A
A[ ,3, drop=FALSE]  # do not drop dimension

A[ ,c(1,3)]     # the 1st and 3rd columns

dimnames(A) = list(
     c("row1", "row2"),         # row names
     c("col1", "col2", "col3")) # column names
A

A["row2", "col3"] # element at 2nd row, 3rd column


################################
# c03-s02
B = matrix(
     c(2, 4, 3, 1, 5, 7),
     nrow=3)
B 

t(B)          # transpose of B


C = matrix(
     c(7, 4, 2),
     nrow=3)
C 

cbind(B, C)

D = matrix(
     c(6, 2),
     nrow=1)
D   # D has 2 columns and 1 row

rbind(B, D)


################################
# c03-s03
C <- matrix(1:12, nrow=3); C
D <- matrix(-4:15, nrow=4); D

C %*% D







