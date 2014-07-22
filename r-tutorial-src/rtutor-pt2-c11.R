###########################################################
#
# Copyright (C) 2012 by Chi Yau
# All rights reserved
#
# http://www.r-tutor.com
#


################################
# c11-s01
xbar = 9900            # sample mean
mu0 = 10000            # hypothesized value
sigma = 120            # population standard deviation
n = 30                 # sample size
z = (xbar-mu0)/(sigma/sqrt(n))
z                      # test statistic

alpha = .05
z.alpha = qnorm(1-alpha)
-z.alpha               # critical value

pval = pnorm(z)
pval


# Ex 1
alpha = .01
z.alpha = qnorm(1-alpha)
-z.alpha               # critical value


# Ex 2
#set.seed(17)
#x = as.integer(rnorm(30, mean = 9900, sd = 120)); x
x = scan("lightbulbs.txt")

xbar = mean(x)         # sample mean
mu0 = 10000            # hypothesized value
sigma = 120            # population standard deviation
n = length(x)          # sample size
z = (xbar-mu0)/(sigma/sqrt(n))
pval = pnorm(z)
pval

library(TeachingDemos)
test = z.test(x, mu=mu0, stdev=sigma, 
  alternative="less")
test$p.value


################################
# c11-s02
xbar = 2.1             # sample mean
mu0 = 2                # hypothesized value
sigma = 0.25           # population standard deviation
n = 35                 # sample size
z = (xbar-mu0)/(sigma/sqrt(n))
z                      # test statistic

alpha = .05
z.alpha = qnorm(1-alpha)
z.alpha                # critical value

pval = pnorm(z, lower.tail=FALSE)
pval


# Ex 1
alpha = .01
z.alpha = qnorm(1-alpha)
z.alpha                # critical value


# Ex 2
#set.seed(17)
#x = rnorm(35, mean = 2, sd = 0.25); x
x = scan("cookies.txt")

xbar = mean(x)         # sample mean
mu0 = 2                # hypothesized value
sigma = 0.25           # population standard deviation
n = length(x)          # sample size
z = (xbar-mu0)/(sigma/sqrt(n))
pval = pnorm(z, lower.tail=FALSE)
pval

library(TeachingDemos)
test = z.test(x, mu=mu0, stdev=sigma, alternative="greater")
test$p.value



################################
# c11-s03
xbar = 14.6            # sample mean
mu0 = 15.4             # hypothesized value
sigma = 2.5            # population standard deviation
n = 35                 # sample size
z = (xbar-mu0)/(sigma/sqrt(n))
z                      # test statistic

alpha = .05
z.alpha = qnorm(1-alpha/2)
c(-z.alpha, z.alpha)

pval = 2 * pnorm(z)    # lower tail
pval                   # two-tailed p-value

pval = 2*ifelse(z < 0, pnorm(z),  
            pnorm(z, lower.tail=FALSE))
pval


# Ex 1
alpha = .01
z.alpha = qnorm(1-alpha/2)
c(-z.alpha, z.alpha)


# Ex 2
#set.seed(17)
#x = rnorm(35, mean = 14.6, sd = 2.5); x
x = scan("penguins.txt")

xbar = mean(x)
xbar                   # sample mean

mu0 = 15.4             # hypothesized value
sigma = 2.5            # population standard deviation
n = length(x)          # sample size
z = (xbar-mu0)/(sigma/sqrt(n))

pval = 2 * pnorm(z)    # as xbar <= mu0
pval                   # two-tailed p-value

library(TeachingDemos)
test = z.test(x, mu=mu0, stdev=sigma)
test$p.value



################################
# c11-s04
xbar = 9900            # sample mean
mu0 = 10000            # hypothesized value
s = 125                # sample standard deviation
n = 30                 # sample size
t.val = (xbar-mu0)/(s/sqrt(n))
t.val                  # test statistic

alpha = .05
t.alpha = qt(1-alpha, df=n-1)
-t.alpha               # critical value

pval = pt(t.val, df=n-1)
pval                   # lower tail p-value


# Ex 1
alpha = .01
n = 30
t.alpha = qt(1-alpha, df=n-1)
-t.alpha               # critical value


# Ex 2
#set.seed(17)
#x = as.integer(rnorm(30, mean = 9900, sd = 120)); x
x = scan("lightbulbs.txt")

xbar = mean(x)         # sample mean
mu0 = 10000            # hypothesized value
s = sd(x)              # sample standard deviation
n = length(x)          # sample size
t.val = (xbar-mu0)/(s/sqrt(n))
pval = pt(t.val, df=n-1)
pval                   # lower tail p-value

test = t.test(x, mu=mu0, alternative="less")
test$p.value



################################
# c11-s05
xbar = 2.1             # sample mean
mu0 = 2                # hypothesized value
s = 0.3                # sample standard deviation
n = 35                 # sample size
t.val = (xbar-mu0)/(s/sqrt(n))
t.val                  # test statistic

alpha = .05
t.alpha = qt(1-alpha, df=n-1)
t.alpha                # critical value

pval = pt(t.val, df=n-1, lower.tail=FALSE)
pval                   # upper tail p-value


# Ex 1
alpha = .01
n = 35
t.alpha = qt(1-alpha, df=n-1)
t.alpha                # critical value


# Ex 2
#set.seed(17)
#x = rnorm(35, mean = 2, sd = 0.25); x
x = scan("cookies.txt")

xbar = mean(x)         # sample mean
mu0 = 2                # hypothesized value
s = sd(x)              # sample standard deviation
n = length(x)          # sample size
t.val = (xbar-mu0)/(s/sqrt(n))
pval = pt(t.val, df=n-1, lower.tail=FALSE)
pval                   # upper tail p-value

test = t.test(x, mu=mu0, alternative="greater")
test$p.value


################################
# c11-s06
xbar = 14.6            # sample mean
mu0 = 15.4             # hypothesized value
s = 2.5                # sample standard deviation
n = 35                 # sample size
t.val = (xbar-mu0)/(s/sqrt(n))
t.val                  # test statistic

alpha = .05
t.alpha = qt(1-alpha/2, df=n-1)
c(-t.alpha, t.alpha)

pval = 2 * pt(t.val, df=n-1)  # lower tail
pval                      # two-tailed p-value

pval = 2 * ifelse(t.val < 0, pt(t.val, df=n-1),
          pt(t.val, df=n-1, lower.tail=FALSE))
pval                      # two-tailed p-value


# Ex 1
alpha = .01
n = 35
t.alpha = qt(1-alpha/2, df=n-1)
c(-t.alpha, t.alpha)


# Ex 2
#set.seed(17)
#x = rnorm(35, mean = 14.6, sd = 2.5); x
x = scan("penguins.txt")

xbar = mean(x)
xbar                   # sample mean

mu0 = 15.4             # hypothesized value
s = sd(x)              # sample standard deviation
n = length(x)          # sample size
t.val = (xbar-mu0)/(s/sqrt(n))
pval = 2 * pt(t.val, df=n-1) # as xbar <= mu0
pval                      # two-tailed p-value

test = t.test(x, mu=mu0)
test$p.value


################################
# c11-s07
pbar = 85/148          # sample proportion
p0 = .6                # hypothesized value
n = 148                # sample size
z = (pbar-p0)/sqrt(p0*(1-p0)/n)
z                      # test statistic

alpha = .05
z.alpha = qnorm(1-alpha)
-z.alpha               # critical value

pval = pnorm(z)
pval                   # lower tail p-value

prop.test(85, 148, p=.6, alt="less", correct=FALSE)


# Ex
alpha = .01
z.alpha = qnorm(1-alpha)
-z.alpha               # critical value


################################
# c11-s08
pbar = 30/214          # sample proportion
p0 = .12               # hypothesized value
n = 214                # sample size
z = (pbar-p0)/sqrt(p0*(1-p0)/n)
z                      # test statistic

alpha = .05
z.alpha = qnorm(1-alpha)
z.alpha                # critical value

pval = pnorm(z, lower.tail=FALSE)
pval                   # upper tail p-value

prop.test(30, 214, p=.12, alt="greater", correct=FALSE)


# Ex
alpha = .01
z.alpha = qnorm(1-alpha)
z.alpha                # critical value


################################
# c11-s09
pbar = 12/20           # sample proportion
p0 = .5                # hypothesized value
n = 20                 # sample size
z = (pbar-p0)/sqrt(p0*(1-p0)/n)
z                      # test statistic

alpha = .05
z.alpha = qnorm(1-alpha/2)
c(-z.alpha, z.alpha)

pval = 2 * pnorm(z, lower.tail=FALSE)  # upper tail
pval                   # two-tailed p-value

prop.test(12, 20, p=0.5, correct=FALSE)


# Ex
alpha = .01
z.alpha = qnorm(1-alpha/2)
c(-z.alpha, z.alpha)





