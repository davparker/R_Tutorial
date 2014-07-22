###########################################################
#
# Copyright (C) 2012 by Chi Yau
# All rights reserved
#
# http://www.r-tutor.com
#


################################
# c24-s01

model <- function() {
    # Priors
    mu ~ dunif(-1e10, 1e10)
    tau ~ dgamma(0.001, 0.001)

    # Likelihood
    for (i in 1:n) {
        y[i] ~ dnorm(mu, tau) 
    }
}


library(MASS)
y1 <- immer$Y1
y2 <- immer$Y2

y <- y1 - y2
n <- length(y)

data <- list("y", "n")
params <- c("mu")
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

out$summary[params, c("2.5%", "97.5%")]

t.test(y1, y2, pair=TRUE)

# Ex
alpha <- 0.01
I <- c(alpha/2, 1-alpha/2)
quantile(out$sims.list$mu, I)



################################
# c24-s02

model <- function() {
    # Priors
    mu1 ~ dunif(-1e10, 1e10)
    mu2 ~ dunif(-1e10, 1e10)
    tau ~ dgamma(0.001, 0.001)

    # Likelihood
    for (i in 1:n1) {
        y1[i] ~ dnorm(mu1, tau) 
    }

    for (j in 1:n2) {
        y2[j] ~ dnorm(mu2, tau) 
    }

    # Difference in means
    delta <- mu1 - mu2
}


L <- ToothGrowth$supp == "OJ"
len <- ToothGrowth$len
y1 <- len[L]
y2 <- len[!L]

n1 <- length(y1)
n2 <- length(y2)

data <- list("y1", "y2", "n1", "n2")
params <- c("mu1", "mu2", "delta")
inits <- function() { 
    list(mu1=0, mu2=0, tau=1) 
}

library(R2OpenBUGS)
model.file <- file.path(tempdir(), 
    "model.txt")
write.model(model, model.file)
out <- bugs(data, inits, params, 
    model.file, n.iter=10000)
all(out$summary[,"Rhat"] < 1.1)

unlist(out$mean[params])

out$summary[params, c("2.5%", "97.5%")]

var.test(y1, y2)

t.test(y1, y2)


# Ex
alpha <- 0.01
I <- c(alpha/2, 1-alpha/2)
quantile(out$sims.list$delta, I)



################################
# c24-s03

model <- function() {
    # Priors
    mu1 ~ dunif(-1e10, 1e10)
    tau1 ~ dgamma(0.001, 0.001)

    mu2 ~ dunif(-1e10, 1e10)
    tau2 ~ dgamma(0.001, 0.001)

    # Likelihood
    for (i in 1:n1) {
        y1[i] ~ dnorm(mu1, tau1) 
    }

    for (j in 1:n2) {
        y2[j] ~ dnorm(mu2, tau2) 
    }

    # Derived
    delta <- mu1 - mu2
}


y1 <- beaver1$temp
y2 <- beaver2$temp

n1 <- length(y1)
n2 <- length(y2)

data <- list("y1", "y2", "n1", "n2")
params <- c("mu1", "mu2", "delta")
inits <- function() { 
    list(mu1=0, mu2=0, tau1=1, tau2=1) 
}

library(R2OpenBUGS)
model.file <- file.path(tempdir(), 
    "model.txt")
write.model(model, model.file)
out <- bugs(data, inits, params, 
    model.file, n.iter=10000)
all(out$summary[,"Rhat"] < 1.1)

unlist(out$mean[params])

out$summary[params, c("2.5%", "97.5%")]

out$DIC

t.test(y1, y2)






