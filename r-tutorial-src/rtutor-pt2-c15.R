###########################################################
#
# Copyright (C) 2012 by Chi Yau
# All rights reserved
#
# http://www.r-tutor.com
#


################################
# c15-s01
df1 = read.table("fastfood-1.txt", header=TRUE)
r = c(t(as.matrix(df1))) # response data 
r

f = c("Item1", "Item2", "Item3") # treatment levels 
k = 3                  # number of treatment levels
n = 6                  # observations per treatment

tm = gl(k, 1, n*k, factor(f)) # matching treatments 
tm

av = aov(r ~ tm) 
summary(av)


# Ex
df1 = read.table("fastfood-1.txt", header=TRUE)
r = c(as.matrix(df1))  # response data 
r

f = c("Item1", "Item2", "Item3") # treatment levels 
k = 3                  # number of treatment levels
n = 6                  # observations per treatment
tm = gl(k, n, n*k, factor(f))
tm

av = aov(r ~ tm)
summary(av)


################################
# c15-s02
df2 = read.table("fastfood-2.txt", header=TRUE)
r = c(t(as.matrix(df2)))         # response data
r

f = c("Item1", "Item2", "Item3") # treatment levels 
k = 3                  # number of treatment levels
n = 6                  # observations per treatment

tm = gl(k, 1, n*k, factor(f)) # matching treatments 
tm

blk = gl(n, k, k*n)           # blocking factor
blk

av = aov(r ~ tm + blk) 
summary(av)


# Ex
df2 = read.table("fastfood-2.txt", header=TRUE)
r = c(as.matrix(df2))            # response data 
r

f = c("Item1", "Item2", "Item3") # treatment levels 
k = 3                  # number of treatment levels
n = 6                  # observations per treatment

tm = gl(k, n, n*k, factor(f)) # matching treatments 
tm

blk = gl(n, 1, k*n)           # blocking factor
blk

av = aov(r ~ tm + blk) 
summary(av)



################################
# c15-s03
df3 = read.csv("fastfood-3.csv") 
r = c(t(as.matrix(df3)))       # response data 
r

f1 = c("Item1", "Item2", "Item3") # 1st factor
f2 = c("East", "West")            # 2nd factor
k1 = length(f1) 
k2 = length(f2)  
n = 4             # observations per treatment 


tm1 = gl(k1, 1, n*k1*k2, factor(f1)) 
tm1 

tm2 = gl(k2, n*k1, n*k1*k2, factor(f2)) 
tm2 

av = aov(r ~ tm1 * tm2)  # include interaction 
summary(av) 


# Ex
df3 = read.csv("fastfood-3.csv") 
r = c(as.matrix(df3))          # response data 
r

f1 = c("Item1", "Item2", "Item3") # 1st factor
f2 = c("East", "West")            # 2nd factor
k1 = length(f1) 
k2 = length(f2) 
n = 4             # observations per treatment 

tm1 = gl(k1, n*k2, n*k1*k2, factor(f1)) 
tm1 

tm2 = gl(k2, n, n*k1*k2, factor(f2)) 
tm2

av = aov(r ~ tm1 * tm2)  # include interaction 
summary(av) 

