###########################################################
#
# Copyright (C) 2012 by Chi Yau
# All rights reserved
#
# http://www.r-tutor.com
#


################################
# c23-s01
library(MASS)
y <- na.omit(survey$Height)
n <- length(y)

mean(y)
10/sqrt(n)

# Ex
library(MASS)
y <- na.omit(survey$Pulse)
n <- length(y)

mean(y)
12/sqrt(n)



################################
# c23-s02
library(MASS)
y <- na.omit(survey$Height)
n <- length(y)

tau <- 1/(10*10)
t.prior <- 1/(1.2*1.2)

t.post <- t.prior + n * tau
s.post <- sqrt(1/t.post); s.post

m.prior <- 160
m.post <- (1/t.post) *
    (m.prior * t.prior + sum(y) * tau)
m.post


# Ex
y <- na.omit(survey$Pulse)
n <- length(y)

tau <- 1/(12*12)
t.prior <- 1/(1.4*1.4)

t.post <- t.prior + n * tau
s.post <- sqrt(1/t.post); s.post

m.prior <- 68
m.post <- (1/t.post) *
    (m.prior * t.prior + sum(y) * tau)
m.post



##############################################
# c23-s03

model <- function() {
    # Prior
    mu ~ dunif(-1e10, 1e10)

    # Likelihood
    for (i in 1:n) {
        y[i] ~ dnorm(mu, tau)
    }
}

library(MASS)
y <- as.numeric(na.omit(survey$Height))
n <- length(y)

tau <- 1/(10*10)
data <- list("y", "n", "tau")
params <- c("mu")
inits <- function() { list(mu = 0) }

library(R2OpenBUGS)
model.file <- file.path(tempdir(), 
    "model.txt")
write.model(model, model.file)
out <- bugs(data, inits, params, 
    model.file, n.iter=10000)
all(out$summary[,"Rhat"] < 1.1)

out$mean["mu"]
out$sd["mu"]

print(out, digits=5)


# Ex
model <- function() {
    # Prior
    mu ~ dunif(-1e10, 1e10)

    # Likelihood
    for (i in 1:n) {
        y[i] ~ dnorm(mu, tau)
    }
}

y <- as.numeric(na.omit(survey$Pulse))
n <- length(y)

tau <- 1/(12*12)
data <- list("y", "n", "tau")
params <- c("mu")
inits <- function() { list(mu = 0) }

library(R2OpenBUGS)
model.file <- file.path(tempdir(), "model.txt")
write.model(model, model.file)
out <- bugs(data, inits, params, model.file, n.iter=10000)
all(out$summary[,"Rhat"] < 1.1)

out$mean["mu"]
out$sd["mu"]

print(out, digits=5)



################################
# c23-s04
model <- function() {
    # Prior
    mu ~ dunif(-1e10, 1e10)
    tau ~ dgamma(0.001, 0.001)

    # Likelihood
    for (i in 1:n) {
        y[i] ~ dnorm(mu, tau)
    }

    # Derived
    sigma <- sqrt(1/tau)
}

library(MASS)
y <- as.numeric(
    na.omit(survey$Height))
n <- length(y)

data <- list("y", "n")
params <- c("mu", "sigma")
inits <- function() { 
    list(mu=0, tau=1) 
}

library(R2OpenBUGS)
model.file <- file.path(tempdir(), 
    "model.txt")
write.model(model, model.file)
out <- bugs(data, inits, params, 
    model.file, n.iter=10000)
all(out$summary[,"Rhat"] < 1.1)

unlist(out$mean[params])
unlist(out$sd[params])

print(out, digits=5)


# Ex
model <- function() {
    # Prior
    mu ~ dunif(-1e10, 1e10)
    tau ~ dgamma(0.001, 0.001)

    # Likelihood
    for (i in 1:n) {
        y[i] ~ dnorm(mu, tau)
    }

    # Derived
    sigma <- sqrt(1/tau)
}

y <- as.numeric(na.omit(survey$Pulse))
n <- length(y)

data <- list("y", "n")
params <- c("mu", "sigma")
inits <- function() { 
    list(mu=0, tau=1) 
}

library(R2OpenBUGS)
model.file <- file.path(tempdir(), 
    "model.txt")
write.model(model, model.file)
out <- bugs(data, inits, params, 
    model.file, n.iter=10000)
all(out$summary[,"Rhat"] < 1.1)

unlist(out$mean[params])
unlist(out$sd[params])

print(out, digits=5)




