###########################################################
#
# Copyright (C) 2012 by Chi Yau
# All rights reserved
#
# http://www.r-tutor.com
#


################################
# c26-s01
model <- function() {
    # Priors
    alpha ~ dnorm(0, 0.001)
    beta ~ dnorm(0, 0.001)
    tau ~ dgamma(0.001, 0.001)

    # Likelihood
    for (i in 1:n) {
        # y[i] ~ dt(mu[i], tau, 2) 
        y[i] ~ dnorm(mu[i], tau) 
        mu[i] <- alpha + beta*x[i]
    }
}


waiting <- faithful$waiting
x.m <- mean(waiting)

x <- waiting - x.m
y <- faithful$eruptions
n <- length(waiting)

data <- list("x", "y", "n")
params <- c("alpha", "beta", "mu")
inits <- function() { 
    list(alpha=0, beta=0, tau=1) 
}

library(R2OpenBUGS)
model.file <- file.path(tempdir(), 
    "model.txt")
write.model(model, model.file)
out <- bugs(data, inits, params, 
    model.file, n.iter=5000)
all(out$summary[,"Rhat"] < 1.1)

# fitting the model
cbind(unlist(out$mean[
    c("alpha", "beta")]))

# credible intervals
out$summary[c("alpha", "beta"),  
    c("2.5%", "97.5%")]

faithful.lm <- lm(y ~ x)
cbind(coefficients(faithful.lm))

summary(faithful.lm)



################################
# c26-s02

model <- function() {
    # Priors
    alpha ~ dnorm(0, 0.001)
    beta ~ dnorm(0, 0.001)
    tau ~ dgamma(0.001, 0.001)

    # Likelihood
    for (i in 1:n) {
        # y[i] ~ dt(mu[i], tau, 2) 
        y[i] ~ dnorm(mu[i], tau) 
        mu[i] <- alpha + beta*x[i]
    }
}

waiting <- faithful$waiting
x.m <- mean(waiting)

x <- waiting - x.m
y <- faithful$eruptions

x0 <- 80 - x.m
n <- length(x)
data <- list(
    x=c(x0, x),
    y=c(NA, y), 
    n=n+1)
params <- c("mu", "y")
inits <- function() { 
    list(alpha=0, beta=0, tau=1) 
}

library(R2OpenBUGS)
model.file <- file.path(tempdir(), 
    "model.txt")
write.model(model, model.file)
out <- bugs(data, inits, params, 
    model.file, n.iter=5000)
all(out$summary[,"Rhat"] < 1.1)

# prediction
out$mean$y
cbind(c(mu=out$mean$mu[1], y=out$mean$y))

# credible intervals
out$summary[c("mu[1]", "y[1]"),  
    c("2.5%", "97.5%")]


# frequentist prediction
faithful.lm <- lm(y ~ x)
newdata <- data.frame(x=x0) 
predict(faithful.lm, newdata, 
    interval="confidence")
predict(faithful.lm, newdata, 
    interval="predict")



# Alternative
model <- function() {
    # Priors
    alpha ~ dnorm(0, 0.001)
    beta ~ dnorm(0, 0.001)
    tau ~ dgamma(0.001, 0.001)

    # Likelihood
    for (i in 1:n) {
        y[i] ~ dnorm(mu[i], tau) 
        mu[i] <- alpha + beta*x[i]
    }

    # Prediction
    y0 ~ dnorm(mu0, tau)
    mu0 <- alpha + beta*x0
}


waiting <- faithful$waiting
x.m <- mean(waiting)
x0 <- 80 - x.m

x <- waiting - x.m
y <- faithful$eruptions

n <- length(x)
data <- list("x", "y", "n", "x0")
params <- c("y0", "mu0")
inits <- function() { 
    list(alpha=0, beta=0, tau=1)
    }

library(R2OpenBUGS)
model.file <- file.path(tempdir(), "model.txt")
write.model(model, model.file)
out <- bugs(data, inits, params, model.file, n.iter=5000)
all(out$summary[,"Rhat"] < 1.1)

# prediction
cbind(unlist(
    out$mean[c("mu0", "y0")]))

# credible intervals
out$summary[c("mu0", "y0"),  
    c("2.5%", "97.5%")]



################################
# c26-s03
model <- function() {
    # Priors
    alpha ~ dnorm(0, 0.001)
    beta ~ dnorm(0, 0.001)

    tau ~ dgamma(0.001, 0.001)
    sigma <- 1/sqrt(tau)

    for (i in 1:n) {
        # Likelihood
        y[i] ~ dnorm(mu[i], tau) 
        mu[i] <- alpha + beta*x[i]

        # Derived
        stdres[i] <- (y[i]-mu[i])/sigma
    }
}


waiting <- faithful$waiting
x.m <- mean(waiting)

x <- waiting - x.m
y <- faithful$eruptions

n <- length(x)
data <- list("x", "y", "n")
params <- c("alpha", "beta", "mu", "stdres")
inits <- function() { 
    list(alpha=0, beta=0, tau=1) 
}

library(R2OpenBUGS)
model.file <- file.path(tempdir(), 
    "model.txt")
write.model(model, model.file)
out <- bugs(data, inits, params, 
    model.file, n.iter=5000)
all(out$summary[,"Rhat"] < 1.1)

eruption.stdres <- out$mean$stdres

plot(faithful$waiting, eruption.stdres, 
     ylab="Standardized Residuals", 
     xlab="Waiting Time", 
     main="Old Faithful Eruptions") 
abline(0, 0)                  # the horizon

qqnorm(eruption.stdres, 
     ylab="Standardized Residuals", 
     xlab="Normal Scores", 
     main="Old Faithful Eruptions") 
qqline(eruption.stdres) 









