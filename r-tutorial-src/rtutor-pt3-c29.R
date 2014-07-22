###########################################################
#
# Copyright (C) 2012 by Chi Yau
# All rights reserved
#
# http://www.r-tutor.com
#


################################
# c29-s01

model <- function() {
    # Priors
    alpha ~ dnorm(0, 0.001)
    for (k in 1:p) {
        # ridge regression
        beta[k] ~ dnorm(0, phi)
    }
    tau ~ dgamma(0.001, 0.001)
    phi ~ dgamma(0.001, 0.001)

    # Likelihood
    for (i in 1:n) {
        y[i] ~ dnorm(mu[i], tau) 

        mu[i] <- alpha + 
            inprod(beta[], x[i, ])
    }

}


x <- as.matrix(subset(stackloss, select=
      c("Air.Flow", "Water.Temp", "Acid.Conc.")
      ))
y <- stackloss$stack.loss

x.m <- apply(x, 2, mean); x.m
x.sd <- apply(x, 2, sd); x.sd

x <- sweep(x, 2, x.m)
x <- sweep(x, 2, x.sd, F="/"); x

n <- nrow(x)
p <- ncol(x)

data <- list("x", "y", "n", "p")
params <- c("alpha", "beta")
inits <- function() { 
    list(alpha=0, beta=numeric(p), tau=1, phi=1) 
}

library(R2OpenBUGS)
model.file <- file.path(tempdir(), "model.txt")
write.model(model, model.file)
out <- bugs(data, inits, params, model.file, 
        codaPkg=TRUE, n.iter=12000)
out.coda <- read.bugs(out)

library(coda)
xyplot(out.coda)
densityplot(out.coda)
acfplot(out.coda)

gelman.diag(out.coda)
gelman.plot(out.coda)

out.summary <- summary(out.coda, 
    q=c(0.025, 0.975))
out.summary$stat[1:4, 
    "Mean", drop=FALSE]
out.summary$q[1:4, ]


library(coda)
help(summary.mcmc)
help(densityplot.mcmc)


# Figures
png(file="coda-ridge-xyplot.png", width=450, height=450)
xyplot(out.coda)
dev.off()

png(file="coda-ridge-densityplot.png", width=450, height=450)
densityplot(out.coda)
dev.off()

png(file="coda-ridge-acfplot.png", width=450, height=450)
acfplot(out.coda)
dev.off()

png(file="coda-ridge-gelmanplot.png", width=450, height=450)
gelman.plot(out.coda)
dev.off()




################################
# c29-s02

model <- function() {
    # Priors
    mu ~ dnorm(0, 0.001)
    tau ~ dgamma(0.001, 0.001)

    # Likelihood
    for (i in 1:k) {
        y[i] ~ dbin(prob[i], n[i]) 
        logit(prob[i]) <- x[i]
        x[i] ~ dnorm(mu, tau)
    }

    # Derived
    logit(pbar) <- mu
}

y <- c( 0, 18,  8, 46,  8, 13,
        9, 31, 14,  8, 29, 24)
n <- c( 47, 148, 119, 810, 211, 196, 
       148, 215, 207,  97, 256, 360)

k <- 12
data <- list("y", "n", "k")
params <- c("mu", "pbar")
inits <- function() { 
    list(mu=0, tau=1, x=numeric(k)) 
}

library(R2OpenBUGS)
model.file <- file.path(tempdir(), "model.txt")
write.model(model, model.file)
out <- bugs(data, inits, params, model.file, 
        codaPkg=TRUE, n.iter=12000)
out.coda <- read.bugs(out)

library(coda)
xyplot(out.coda)
densityplot(out.coda)
acfplot(out.coda)

gelman.diag(out.coda)
gelman.plot(out.coda)

out.summary <- summary(out.coda, 
    q=c(0.025, 0.975))
out.summary$stat["pbar", 
    "Mean", drop=FALSE]
out.summary$q["pbar", ]


# Figures
png(file="coda-surgical-xyplot.png", width=450, height=450)
xyplot(out.coda)
dev.off()

png(file="coda-surgical-densityplot.png", width=450, height=450)
densityplot(out.coda)
dev.off()

png(file="coda-surgical-acfplot.png", width=450, height=450)
acfplot(out.coda)
dev.off()

png(file="coda-surgical-gelmanplot.png", width=450, height=450)
gelman.plot(out.coda)
dev.off()




################################
# c29-s03

model <- function() {
    # Priors
    alpha ~ dnorm(0, 0.001)
    beta ~ dnorm(0, 0.001)

    for (i in 1:k) {
		# logistic regression
        y[i] ~ dbin(prob[i], n[i]) 
        logit(prob[i]) <- alpha + beta*x[i]

		# linear regression
        x[i] ~ dnorm(mu[i], 0.01234)
        mu[i] <- 4.48 + 0.76*z[i]
    }
}

z <- c(10, 30, 50)
y <- c(21, 20, 15)
n <- c(48, 34, 21)

k <- length(n)
data <- list("z", "y", "n", "k")
params <- c("alpha", "beta")
inits <- function() { 
    list(alpha=0, beta=0, x=numeric(k)) 
}

library(R2OpenBUGS)
model.file <- file.path(tempdir(), "model.txt")
write.model(model, model.file)
out <- bugs(data, inits, params, model.file, 
        codaPkg=TRUE, n.iter=12000)
out.coda <- read.bugs(out)

library(coda)
xyplot(out.coda)
densityplot(out.coda)
acfplot(out.coda)

gelman.diag(out.coda)
gelman.plot(out.coda)

out.summary <- summary(out.coda, 
    q=c(0.025, 0.975))
out.summary$stat[params, 
    "Mean", drop=FALSE]
out.summary$q[params, ]


# Figures
png(file="coda-air-xyplot.png", width=450, height=450)
xyplot(out.coda)
dev.off()

png(file="coda-air-densityplot.png", width=450, height=450)
densityplot(out.coda)
dev.off()

png(file="coda-air-acfplot.png", width=450, height=450)
acfplot(out.coda)
dev.off()

png(file="coda-air-gelmanplot.png", width=450, height=450)
gelman.plot(out.coda)
dev.off()




