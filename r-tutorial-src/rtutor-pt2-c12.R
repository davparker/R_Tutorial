###########################################################
#
# Copyright (C) 2012 by Chi Yau
# All rights reserved
#
# http://www.r-tutor.com
#


################################
# c12-s01
n = 30                # sample size
sigma = 120           # population standard deviation 
sem = sigma/sqrt(n); sem   # standard error

alpha = .05           # significance level
mu0 = 10000           # hypothetical lower bound
q = qnorm(alpha, mean=mu0, sd=sem); q

mu = 9950             # assumed population mean
pnorm(q, mean=mu, sd=sem, lower.tail=FALSE)

# Ex
mu = 9965             # assumed population mean
pnorm(q, mean=mu, sd=sem, lower.tail=FALSE)


################################
# c12-s02
n = 35                # sample size
sigma = 0.25          # population standard deviation 
sem = sigma/sqrt(n); sem   # standard error

alpha = .05           # significance level
mu0 = 2               # hypothetical upper bound
q = qnorm(alpha, mean=mu0, sd=sem, lower.tail=FALSE)
q

mu = 2.09             # assumed population mean
pnorm(q, mean=mu, sd=sem)

# Ex
mu = 2.075            # assumed population mean
pnorm(q, mean=mu, sd=sem)


################################
# c12-s03
n = 35                # sample size
sigma = 2.5           # population standard deviation 
sem = sigma/sqrt(n); sem   # standard error

alpha = .05           # significance level
mu0 = 15.4            # hypothetical mean
I = c(alpha/2, 1-alpha/2)
q = qnorm(I, mean=mu0, sd=sem); q

mu = 15.1             # assumed population mean
p = pnorm(q, mean=mu, sd=sem); p

diff(p)               # p[2]-p[1]

# Ex
mu = 14.9             # assumed population mean
p = pnorm(q, mean=mu, sd=sem); p

diff(p)               # p[2]-p[1]



################################
# c12-s04
n = 30                # sample size
s = 125               # sample standard deviation 
SE = s/sqrt(n); SE    # standard error estimate

alpha = .05           # significance level
mu0 = 10000           # hypothetical lower bound
q = mu0 + qt(alpha, df=n-1)*SE; q

mu = 9950             # assumed population mean
pt((q - mu)/SE, df=n-1, lower.tail=FALSE)

# Ex
mu = 9965             # assumed population mean
pt((q - mu)/SE, df=n-1, lower.tail=FALSE)


################################
# c12-s05
n = 35                # sample size
s = 0.3               # sample standard deviation 
SE = s/sqrt(n); SE    # standard error estimate

alpha = .05           # significance level
mu0 = 2               # hypothetical upper bound
q = mu0 + qt(alpha, df=n-1, lower.tail=FALSE)*SE
q

mu = 2.09             # assumed population mean
pt((q - mu)/SE, df=n-1)

# Ex
mu = 2.075            # assumed population mean
pt((q - mu)/SE, df=n-1)


################################
# c12-s06
n = 35                # sample size
s = 2.5               # sample standard deviation 
SE = s/sqrt(n); SE    # standard error estimate

alpha = .05           # significance level
mu0 = 15.4            # hypothetical mean
I = c(alpha/2, 1-alpha/2)
q = mu0 + qt(I, df=n-1)*SE; q

mu = 15.1             # assumed population mean
p = pt((q - mu)/SE, df=n-1); p

diff(p)               # p[2]-p[1]

# Ex
mu = 14.9             # assumed population mean
p = pt((q - mu)/SE, df=n-1); p

diff(p)               # p[2]-p[1]


