###########################################################
#
# Copyright (C) 2012 by Chi Yau
# All rights reserved
#
# http://www.r-tutor.com
#


################################
# c20-s01
fac <- (1-0.97)*(1-0.01)/(0.99*0.01)
res <- 1/(1+fac); res

# Ex
fac <- (1-0.97)*(1-res)/(0.99*res)
res <- 1/(1+fac); res



################################
# c20-s02
N <- 6       # number of fruits
x <- 0:N     # number of apples
x

len <- length(x)
prior <- rep(1/len, len)

names(prior) <- x
cbind(prior)

y <- x/N    # likelihood
cbind(prior, y)

LP <- prior * y      # prior*likelihood
PP <- LP/sum(LP)     # posterior
cbind(prior, likelihood=y, LP, PP)

sum(PP*(x-1)/(N-1))

# Ex
z <- 1-x/N  # likelihood
cbind(prior, z)

LQ <- prior * z      # prior*likelihood
PQ <- LQ/sum(LQ)     # posterior
cbind(prior, likelihood=z, LQ, PQ)

sum(PQ*x/(N-1))


################################
# c20-s02
prior1 <- PP
cbind(prior1)

y1 <- (x-1)/(N-1)
cbind(prior1, y1)

LP1 <- prior1 * y1   # prior*likelihood
PP1 <- LP1/sum(LP1)  # posterior
cbind(prior1, y1, LP1, PP1)

sum(PP1*(x-2)/(N-2))


# Alternative
y2 <- x*(x-1)/(N*(N-1))
cbind(prior, y2)

LP2 <- prior * y2      # prior*likelihood
PP2 <- LP2/sum(LP2)    # posterior
cbind(prior, likelihood=y2, LP2, PP2)

sum(PP2*(x-2)/(N-2))

# Ex
prior.z <- PQ
cbind(prior.z)

z1 <- x/(N-1)
cbind(prior.z, z1)

LQ1 <- prior.z * z1   # prior*likelihood
PQ1 <- LQ1/sum(LQ1)  # posterior
cbind(prior.z, z1, LQ1, PQ1)

sum(PQ1*(x-1)/(N-2))










