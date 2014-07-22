###########################################################
#
# Copyright (C) 2012 by Chi Yau
# All rights reserved
#
# http://www.r-tutor.com
#


################################
# c01-s01
x = 10.5
x

k = 1
k
is.integer(k) 


################################
# c01-s02
y = as.integer(3)
y

as.integer(3.14)
as.integer("5.27")
as.integer("Joe")

as.integer(TRUE) 
as.integer(FALSE)


################################
# c01-s03
z = 1 + 2i
z

sqrt(-1)
sqrt(-1+0i)
sqrt(as.complex(-1))


################################
# c01-s04
x = 1; y = 2
z = x > y
z

u = TRUE; v = FALSE
u & v
u | v
!u


################################
# c01-s05
s = "Brevity is the soul of wit."
nchar(s)

x = as.character(3.14)
x

fname = "Joe"; lname ="Smith"
paste(fname, lname)

sprintf("%s has %d dollars", "Sam", 100)

substr("Mary has a little lamb.", start=3, stop=12)
sub("little", "big", "Mary has a little lamb.")


################################
# c01-s06
a = factor("A")

class(a)

x = factor(1)
y = factor(2)
x + y

