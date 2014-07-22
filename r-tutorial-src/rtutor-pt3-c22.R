###########################################################
#
# Copyright (C) 2012 by Chi Yau
# All rights reserved
#
# http://www.r-tutor.com
#


################################
# c22-s01

y <- as.numeric(discoveries)

a <- 1+sum(y); a
b <- 0+length(y); b

mu <- a/b; mu
sigma <- sqrt(a)/b; sigma

qgamma(0.5, a, b)


# Ex
a <- 250 + sum(y); a
b <- 120 + length(y); b

mu <- a/b; mu
sigma <- sqrt(a)/b; sigma

qgamma(0.5, a, b)



################################
# c22-s02

y <- as.numeric(discoveries)

mu <- 2.15
sigma <- 0.15

b <- mu/(sigma*sigma); b
a <- mu*b; a

a1 <- a+sum(y); a1
b1 <- b+length(y); b1

mu1 <- a1/b1; mu1
sigma1 <- sqrt(a1)/b1; sigma1

qgamma(0.5, a1, b1)


# Ex
mu <- 3.82
sigma <- 0.17

b <- mu/(sigma*sigma); b
a <- mu*b; a

a1 <- a+sum(y); a1
b1 <- b+length(y); b1

mu1 <- a1/b1; mu1
sigma1 <- sqrt(a1)/b1; sigma1

qgamma(0.5, a1, b1)



################################
# c22-s03

model <- function() {
    # Prior
    lambda ~ dunif(0, 1e10)

    # Likelihood
    for (i in 1:m) {
        y[i] ~ dpois(lambda)
    }
}

library(R2OpenBUGS)
model.file <- file.path(tempdir(), "model.txt")
write.model(model, model.file)

y <- as.numeric(discoveries)
data <- list(y=y, m=length(y))
params <- c("lambda")
inits <- function() { list(lambda=1) }

out <- bugs(data, inits, params, model.file, n.iter=10000)
all(out$summary[,"Rhat"] < 1.1)

out$mean["lambda"]
out$median["lambda"]
out$sd["lambda"]

print(out, digits=5)

# Ex
model <- function() {
    # Prior
    lambda ~ dgamma(250, 120)

    # Likelihood
    for (i in 1:m){
        y[i] ~ dpois(lambda)
    }
}

library(R2OpenBUGS)
model.file <- file.path(tempdir(), "model.txt")
write.model(model, model.file)

y <- as.numeric(discoveries)
data <- list(y=y, m=length(y))
params <- c("lambda")
inits <- function() { list(lambda=1) }

out <- bugs(data, inits, params, model.file, n.iter=10000)
all(out$summary[,"Rhat"] < 1.1)

out$mean["lambda"]
out$median["lambda"]
out$sd["lambda"]

print(out, digits=5)









