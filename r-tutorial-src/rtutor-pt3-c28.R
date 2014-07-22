###########################################################
#
# Copyright (C) 2012 by Chi Yau
# All rights reserved
#
# http://www.r-tutor.com
#


################################
# c28-s01

model <- function() {
    # Priors
    alpha ~ dnorm(0, 0.001)
    for (k in 1:p) {
        beta[k] ~ dnorm(0, 0.001)
    }

    # Likelihood
    for (i in 1:n) {
        y[i] ~ dbern(prob[i])
        logit(prob[i]) <- alpha + 
            inprod(beta[], x[i, ])
    }
}

x <- as.matrix(subset(mtcars, 
        select=c("hp", "wt")))
y <- mtcars$am

x.m <- apply(x, 2, mean); x.m
x.sd <- apply(x, 2, sd); x.sd

x <- sweep(x, 2, x.m)
x <- sweep(x, 2, x.sd, F="/"); x

n <- nrow(x)
p <- ncol(x)

x0 <- (c(120, 2.8)-x.m)/x.sd
data <- list(
    x=rbind(x0, x),
    y=c(NA, y),
    p=p,
    n=n+1)
params <- c("alpha", "beta", "prob", "y")
inits <- function() { 
    list(alpha=0, beta=numeric(p)) 
}

library(R2OpenBUGS)
model.file <- file.path(
    tempdir(), "model.txt")
write.model(model, model.file)
out <- bugs(data, inits, params, 
    model.file, n.iter=10000)
all(out$summary[,"Rhat"] < 1.1)

# regression coefficients
cbind(unlist(out$mean)[1:3])

out$summary[1:3,
    c("2.5%", "97.5%")]

# predicted probabilty
cbind(unlist(out$mean$prob[1]))

out$summary["prob[1]",
    c("2.5%", "97.5%")]

# frequentist prediction
am.glm <- glm(formula=am ~ hp + wt, 
    data=mtcars, family=binomial)
newdata = data.frame(hp=120, wt=2.8)
predict(am.glm, newdata, type="response")

summary(am.glm)



##############################################
# c28-s02

model <- function() {
    # Priors
    alpha ~ dnorm(0, 0.001)
    beta ~ dnorm(0, 0.001)

    # Likelihood
    for (i in 1:len) {
        y[i] ~ dbin(prob[i], n[i]) 
        logit(prob[i]) <- 
            alpha + beta*(x[i])
    }
}

x <- c(-1.2198, -0.5371, -0.3064, 
         0.1578, 0.7695)
y <- c(11, 8, 3, 2, 1)
n <- c(15, 20, 12, 18, 16)

x.m <- mean(x)
data <- list(
    x=c(-0.40, x)-x.m,
    y=c(NA, y),
    n=c(24, n),
    len=length(x)+1)

params <- c("alpha", "beta", "prob", "y")
inits <- function() { 
    list(alpha=0, beta=1) 
}

library(R2OpenBUGS)
model.file <- file.path(tempdir(), 
    "model.txt")
write.model(model, model.file)
out <- bugs(data, inits, params, 
    model.file, n.iter=10000)
all(out$summary[,"Rhat"] < 1.1)

out$mean$prob[1]
out$summary["prob[1]", 
    c("2.5%", "97.5%")]

print(out, digits=5)



##############################################
# c28-s03

model <- function() {
    # Priors
    alpha ~ dnorm(0, 0.001)
    beta ~ dnorm(0, 0.001)

    # Likelihood
    for (i in 1:len) {
        y[i] ~ dbin(prob[i], n[i]) 
        logit(prob[i]) <- 
            alpha + beta*(x[i])
    }

    # Derived
    x0 <- (logit(prob0) - alpha)/beta
}

x <- c(-1.2198, -0.5371, -0.3064, 
         0.1578, 0.7695)
y <- c(11, 8, 3, 2, 1)
n <- c(15, 20, 12, 18, 16)

x.m <- mean(x)
data <- list(
    prob0=0.10,
    x=x-x.m,
    y=y,
    n=n,
    len=length(x))
params <- c("alpha", "beta", "prob", "x0")
inits <- function() { 
    list(alpha=0, beta=1) 
}

library(R2OpenBUGS)
model.file <- file.path(tempdir(), 
    "model.txt")
write.model(model, model.file)
out <- bugs(data, inits, params, 
    model.file, n.iter=10000)
all(out$summary[,"Rhat"] < 1.1)

x.m + out$mean$x0

x.m + out$summary["x0", 
    c("2.5%", "97.5%")]

print(out, digits=5)





