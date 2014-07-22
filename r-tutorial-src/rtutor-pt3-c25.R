###########################################################
#
# Copyright (C) 2012 by Chi Yau
# All rights reserved
#
# http://www.r-tutor.com
#


################################
# c25-s01

model <- function() {
    # Priors
    alpha ~ dunif(-1e10, 1e10)

    beta[1] <- 0
    for (k in 2:ngroup) {
        beta[k] ~ dunif(-1e10, 1e10)
    }

    tau ~ dgamma(0.001, 0.001)

    # Likelihood
    for (i in 1:N) {
        y[i] ~ dnorm(mu[i], tau) 
        mu[i] <- alpha + beta[tm[i]]
    }

    # Derived
    eff <- beta[2] - beta[3]
}

inits <- function() { 
    beta <- numeric(ngroup)
    beta[1] <- NA

    list(alpha=0, beta=beta, tau=1) 
}

df <- read.table("fastfood-1.txt", 
    header=TRUE); df

ngroup <- ncol(df); ngroup
nsample <- nrow(df); nsample
N <- ngroup*nsample; N

tm <- gl(ngroup, nsample, N); tm
model.matrix(~tm)

y <- as.numeric(as.matrix(df))
data <- list(
    y = y,
    tm = as.numeric(tm),
    ngroup = ngroup,
    N = N
    )
params <- c("alpha", "beta", "eff")

library(R2OpenBUGS)
model.file <- file.path(tempdir(), 
    "model.txt")
write.model(model, model.file)
out <- bugs(data, inits, params, 
    model.file, n.iter=10000)
all(out$summary[,"Rhat"] < 1.1)

out$summary[,  c("2.5%", "97.5%")]

fastfood.lm <- lm(y ~ tm)
anova(fastfood.lm)

cbind(unlist(out$mean[params]))
cbind(coefficients(fastfood.lm))

print(out, digits=5)
summary(fastfood.lm)



################################
# c25-s02

model <- function() {
    # Priors
    alpha ~ dunif(-1e10, 1e10)

    tm.beta[1] <- 0
    for (k in 2:ngroup) {
        tm.beta[k] ~ dunif(-1e10, 1e10)
    }

    blk.beta[1] <- 0
    for (k in 2:nsample) {
        blk.beta[k] ~ dunif(-1e10, 1e10)
    }

    tau ~ dgamma(0.001, 0.001)

    # Likelihood
    for (i in 1:N) {
        y[i] ~ dnorm(mu[i], tau) 
        mu[i] <- alpha + 
                    tm.beta[tm[i]] + 
                    blk.beta[blk[i]]
    }

    # Derived
    tm.eff <- tm.beta[2] - tm.beta[3]
}

inits <- function() { 
    tm.beta <- numeric(ngroup)
    tm.beta[1] <- NA
    blk.beta <- numeric(nsample)
    blk.beta[1] <- NA

    list(alpha = 0,
        tm.beta = tm.beta,
        blk.beta = blk.beta,
        tau = 1
        )
}

df <- read.table("fastfood-2.txt", 
        header=TRUE); df

ngroup <- ncol(df); ngroup
nsample <- nrow(df); nsample
N <- ngroup*nsample; N

tm <- gl(ngroup, nsample, N); tm
blk <- gl(nsample, 1, N); blk
model.matrix(~tm + blk)

y <- as.numeric(as.matrix(df))
data <- list(
    y = y,
    tm = as.numeric(tm),
    blk = as.numeric(blk),
    ngroup = ngroup,
    nsample = nsample,
    N = N)
params <- c("alpha", 
    "tm.beta", "tm.eff", "blk.beta")

library(R2OpenBUGS)
model.file <- file.path(tempdir(), 
    "model.txt")
write.model(model, model.file)
out <- bugs(data, inits, params, 
    model.file, n.iter=10000)
all(out$summary[,"Rhat"] < 1.1)

out$summary[,  c("2.5%", "97.5%")]

fastfood.lm <- lm(y ~ tm + blk)
anova(fastfood.lm)

cbind(unlist(out$mean[params]))
cbind(coefficients(fastfood.lm))

print(out, digits=5)
summary(fastfood.lm)




################################
# c25-s03

model <- function() {
    # Priors
    alpha ~ dunif(-1e10, 1e10)

    t1.beta[1] <- 0
    for (k in 2:n1) {
        t1.beta[k] ~ dunif(-1e10, 1e10)
    }

    t2.beta[1] <- 0
    for (k in 2:n2) {
        t2.beta[k] ~ dunif(-1e10, 1e10)
    }

    t3.beta[1] <- 0
    for (k in 2:n3) {
        t3.beta[k] ~ dunif(-1e10, 1e10)
    }

    tau ~ dgamma(0.001, 0.001)

    # Likelihood
    for (i in 1:N) {
        y[i] ~ dnorm(mu[i], tau) 
        mu[i] <- alpha + 
                    t1.beta[t1[i]] + 
                    t2.beta[t2[i]] + 
                    t3.beta[t3[i]]
    }

}

inits <- function() { 
    t1.beta <- numeric(n1)
    t1.beta[1] <- NA
    t2.beta <- numeric(n2)
    t2.beta[1] <- NA
    t3.beta <- numeric(n3)
    t3.beta[1] <- NA

    list(alpha = 0, 
        t1.beta = t1.beta, 
        t2.beta = t2.beta, 
        t3.beta = t3.beta,
        tau = 1
        )
}


df <- read.csv("fastfood-3.csv"); df

f1 <- c("Item1", "Item2", "Item3")
f2 <- c("East", "West")
n1 <- length(f1) 
n2 <- length(f2)  

nsample <- 4
N <- n1*n2*nsample; N

tm1 <- gl(n1, nsample*n2, N); tm1
tm2 <- gl(n2, nsample, N); tm2

model.matrix(~tm1 * tm2)

t1 <- as.numeric(tm1)
t2 <- as.numeric(tm2)

t3 <- ifelse(t1==1 | t2==1, 1,
        (t2-2)*(n1-1)+t1)
t3

n3 <- (n1-1)*(n2-1)+1
n3

y <- as.numeric(as.matrix(df))
data <- list("y", "t1", "t2", "t3", 
            "n1", "n2", "n3", "N")
params <- c("alpha", "t1.beta", 
            "t2.beta", "t3.beta")

library(R2OpenBUGS)
model.file <- file.path(tempdir(), 
    "model.txt")
write.model(model, model.file)
out <- bugs(data, inits, params, 
    model.file, n.iter=10000)
all(out$summary[,"Rhat"] < 1.1)

out$summary[,  c("2.5%", "97.5%")]

fastfood.lm <- lm(y ~ tm1 * tm2)
anova(fastfood.lm)

cbind(unlist(out$mean[params]))
cbind(coefficients(fastfood.lm))

print(out, digits=5)
summary(fastfood.lm)



################################
# c25-s04

model <- function() {
    # Priors
    alpha ~ dunif(-1e10, 1e10)

    beta[1] <- 0
    for (k in 2:ngroup) {
        beta[k] ~ dunif(-1e10, 1e10)
    }

    for (k in 1:ngroup) {
        prec[k] ~ dgamma(0.001, 0.001)
        sigma[k] <- sqrt(1/prec[k])
    }

    # Likelihood
    for (i in 1:N) {
        y[i] ~ dnorm(mu[i], tau[i]) 
        mu[i] <- alpha + beta[tm[i]]
        tau[i] <- prec[tm[i]]
    }

    # Derived
    eff <- beta[2] - beta[3]
}

inits <- function() { 
    beta <- numeric(ngroup)
    beta[1] <- NA

    prec <- rep(1, ngroup)
    list(alpha=0, beta=beta, prec=prec) 
}

df <- read.table("fastfood-1.txt", 
    header=TRUE); df

ngroup <- ncol(df); ngroup
nsample <- nrow(df); nsample
N <- ngroup*nsample; N

tm <- gl(ngroup, nsample, N); tm
model.matrix(~tm)

y <- as.numeric(as.matrix(df))
data <- list(
    y = y,
    tm = as.numeric(tm),
    ngroup = ngroup,
    N = N
    )
params <- c("alpha", "beta", 
    "eff", "sigma")

library(R2OpenBUGS)
model.file <- file.path(tempdir(), 
    "model.txt")
write.model(model, model.file)
out <- bugs(data, inits, params, 
    model.file, n.iter=10000)
all(out$summary[,"Rhat"] < 1.1)

out$summary[,  c("2.5%", "97.5%")]

fastfood.lm <- lm(y ~ tm)
anova(fastfood.lm)

cbind(unlist(out$mean[params]))
cbind(coefficients(fastfood.lm))

print(out, digits=5)
summary(fastfood.lm)




