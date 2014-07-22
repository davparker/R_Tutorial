###########################################################
#
# Copyright (C) 2012 by Chi Yau
# All rights reserved
#
# http://www.r-tutor.com
#


################################
# c04-s01
n = c(2, 3, 5)
s = c("aa", "bb", "cc", "dd", "ee")
b = c(TRUE, FALSE, TRUE, FALSE, FALSE)
x = list(n, s, b, 3)   # x contains copies of n, s, b

x[2] 
x[c(2, 4)] 

x[[2]] 
x[[2]][1] = "ta"
x[[2]]
s


################################
# c04-s02
v = list(bob=c(2, 3, 5), john=c("aa", "bb")) 
v 

v["bob"] 
v[c("john", "bob")] 

v[["bob"]] 
v$bob 

attach(v)
bob 
detach(v)
