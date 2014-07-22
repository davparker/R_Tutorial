###########################################################
#
# Copyright (C) 2012 by Chi Yau
# All rights reserved
#
# http://www.r-tutor.com
#


################################
# c02
c(2, 3, 5)
c(TRUE, FALSE, TRUE, FALSE, FALSE)
c("aa", "bb", "cc", "dd", "ee") 
length(c("aa", "bb", "cc", "dd", "ee"))


################################
# c02-s01
n = c(2, 3, 5)
s = c("aa", "bb", "cc", "dd", "ee")
c(n, s) 


################################
# c02-s02
a = c(1, 3, 5, 7) 
b = c(1, 2, 4, 8)

5 * a 
a + b 
a - b
a * b
a / b

u = c(10, 20, 30)
v = c(1, 2, 3, 4, 5, 6, 7, 8, 9)
u + v 

w = c(10, 20, 30, 40)
w + v


################################
# c02-s03
s = c("aa", "bb", "cc", "dd", "ee") 
s[3] 

s[-3] 
s[10]


################################
# c02-s04
s = c("aa", "bb", "cc", "dd", "ee") 
s[c(2, 3)] 
s[c(2, 3, 3)]
s[c(2, 1, 3)] 
s[2:4] 


################################
# c02-s05
s = c("aa", "bb", "cc", "dd", "ee")
L = c(FALSE, TRUE, FALSE, TRUE, FALSE)
s[L] 
s[c(FALSE, TRUE, FALSE, TRUE, FALSE)]


################################
# c02-s06
v = c("Mary", "Sue") 
v

names(v) = c("First", "Last") 
v

v["First"]
v[c("Last", "First")]







