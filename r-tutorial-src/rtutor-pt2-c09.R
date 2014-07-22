###########################################################
#
# Copyright (C) 2012 by Chi Yau
# All rights reserved
#
# http://www.r-tutor.com
#


################################
# c09-s01
dbinom(4, size=12, prob=0.2)

dbinom(0, size=12, prob=0.2) +
dbinom(1, size=12, prob=0.2) +
dbinom(2, size=12, prob=0.2) +
dbinom(3, size=12, prob=0.2) +
dbinom(4, size=12, prob=0.2)

pbinom(4, size=12, prob=0.2)


################################
# c09-s02
ppois(16, lambda=12)

ppois(16, lambda=12, lower=FALSE)


################################
# c09-s03
runif(10, min=1, max=3)


################################
# c09-s04
pexp(2, rate=1/3)


################################
# c09-s05
pnorm(84, mean=72, sd=15.2, lower.tail=FALSE)


################################
# c09-s06
qchisq(.95, df=7)


################################
# c09-s07
qt(c(.025, .975), df=5)


################################
# c09-s08
qf(.95, df1=5, df2=2)


################################
# c09-s09
a = 5
b = 12
c = a+b

mu = a/c; mu
s2 = a*b/(c*c*(c+1)); s2


################################
# c09-s10
a = 2
b = 1

mu = a/b; mu
s2 = a/(b*b); s2



################################
# figures

# probability-dist-unif
png(file="probability-distributions3x.png", width=450, height=450)
curve(dunif(x, 1, 3), 0, 5, xlab='x', ylab='unif(x)')
dev.off()


# probability-dist-exp
png(file="probability-distributions5x.png", width=450, height=450)
curve(dexp(x), 0, 5, xlab='x', ylab='exp(x)')
dev.off()


# probability-dist-norm
png(file="probability-distributions8x.png", width=450, height=450)
curve(dnorm(x), -5, 5, xlab='x', ylab='norm(x)')
dev.off()


# probability-dist-chisq
png(file="probability-distributions12x.png", width=450, height=450)
curve(dchisq(x,df=7), 0, 20, xlab='x', ylab='chisq(x; df=7)')
dev.off()


# probability-dist-t
png(file="probability-distributions14x.png", width=450, height=450)
curve(dt(x, df=5), -5, 5, xlab='x', ylab='t(x; df=5)')
dev.off()


# probability-dist-f
png(file="probability-distributions16x.png", width=450, height=450)
curve(df(x,df1=5,df2=2), 0, 5, xlab='x', ylab='f(x; df1=5, df2=2)')
dev.off()


# probability-dist-beta
png(file="probability-distributions21x.png", width=450, height=450)
curve(dbeta(x,5,12), 0, 1, xlab='x', ylab='beta(x;a=5, b=12)')
dev.off()


# probability-dist-gamma
png(file="probability-distributions26x.png", width=450, height=450)
curve(dgamma(x,2,1), 0, 10, xlab='x', ylab='gamma(x;a=2, b=1)')
dev.off()



