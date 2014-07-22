###########################################################
#
# Copyright (C) 2012 by Chi Yau
# All rights reserved
#
# http://www.r-tutor.com
#


################################
# c13-s01
library(MASS)

t.test(immer$Y1, immer$Y2, paired=TRUE)


# Ex
X = immer$Y1 - immer$Y2
n = length(X)

alpha = .05
t.alpha = qt(1-alpha/2, df=n-1); t.alpha

E = t.alpha * sqrt(var(X)/n)
mean(X) + c(-E, E)


################################
# c13-s02
L = mtcars$am == 0
mpg.auto = mtcars[L,]$mpg
mpg.auto       # automatic transmission mileages

mpg.manual = mtcars[!L,]$mpg
mpg.manual     # manual transmission mileages

t.test(mpg.auto, mpg.manual)

t.test(mpg ~ am, data=mtcars)


# Ex
n1 = length(mpg.auto)
n2 = length(mpg.manual)

q1 = var(mpg.auto)/n1
q2 = var(mpg.manual)/n2
u = q1+q2

v1 = q1*q1/(n1-1)
v2 = q2*q2/(n2-1)
df = u*u/(v1+v2); df

alpha = .05
t.alpha = qt(1-alpha/2, df=df)
E = t.alpha * sqrt(q1+q2); E

xbar1 = mean(mpg.auto)
xbar2 = mean(mpg.manual)
xbar1 - xbar2 + c(-E, E)



################################
# c13-s03
library(MASS)
head(quine)
table(quine$Eth, quine$Sex)

prop.test(table(quine$Eth, quine$Sex), correct=FALSE)


# Ex
table(quine$Eth, quine$Sex)

n1 = 38+31; n1
p1 = 38/n1; p1

n2 = 42+35; n2
p2 = 42/n2; p2

q1 = p1*(1-p1)/n1
q2 = p2*(1-p2)/n2

alpha = 0.05
z.alpha = qnorm(1-alpha/2)
E = z.alpha*sqrt(q1+q2)

p1 - p2 + c(-E, E)



