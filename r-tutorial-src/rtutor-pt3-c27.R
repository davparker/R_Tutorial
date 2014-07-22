###########################################################
#
# Copyright (C) 2012 by Chi Yau
# All rights reserved
#
# http://www.r-tutor.com
#


################################
# c27-s01

model <- function() {
    # Priors
    alpha ~ dnorm(0, 0.001)
    for (k in 1:p) {
        beta[k] ~ dnorm(0, 0.001)
    }
    tau ~ dgamma(0.001, 0.001)

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
params <- c("alpha", "beta", "mu")
inits <- function() { 
    list(alpha=0, beta=numeric(p), tau=1) 
}

library(R2OpenBUGS)
model.file <- file.path(tempdir(), "model.txt")
write.model(model, model.file)
out <- bugs(data, inits, params, model.file, n.iter=10000)
all(out$summary[,"Rhat"] < 1.1)

# fitting
cbind(unlist(out$mean[c("alpha", "beta")]))

# credible intervals
out$summary[1:4,  
    c("2.5%", "97.5%")]

# frequentist
stackloss.lm <- lm(y ~ x)
cbind(coefficients(stackloss.lm))



################################
# c27-s02

model <- function() {
    # Priors
    alpha ~ dnorm(0, 0.001)
    for (k in 1:p) {
        beta[k] ~ dnorm(0, 0.001)
    }
    tau ~ dgamma(0.001, 0.001)

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

x0 <- (c(72, 20, 85)-x.m)/x.sd
data <- list(
    x=rbind(x0, x),
    y=c(NA, y), 
    p=p,
    n=n+1
    )
params <- c("mu", "y")
inits <- function() { 
    list(alpha=0, beta=numeric(p), tau=1) 
}

library(R2OpenBUGS)
model.file <- file.path(tempdir(), "model.txt")
write.model(model, model.file)
out <- bugs(data, inits, params, model.file, n.iter=10000)
all(out$summary[,"Rhat"] < 1.1)

# prediction
out$mean$y
cbind(c(mu=out$mean$mu[1], y=out$mean$y))

# credible intervals
out$summary[c("mu[1]", "y[1]"),  
    c("2.5%", "97.5%")]

# frequentist prediction
stackloss.lm <- lm(stack.loss ~
  Air.Flow + Water.Temp + Acid.Conc.,
  data=stackloss)
newdata <- data.frame(Air.Flow=72,
  Water.Temp=20, Acid.Conc.=85)
predict(stackloss.lm, newdata)
predict(stackloss.lm, newdata,
    interval="confidence")
predict(stackloss.lm, newdata,
    interval="predict")




