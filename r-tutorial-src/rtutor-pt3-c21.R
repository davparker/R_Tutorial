###########################################################
#
# Copyright (C) 2012 by Chi Yau
# All rights reserved
#
# http://www.r-tutor.com
#


################################
# c21-s01
library(MASS)
tbl <- table(survey$Smoke); tbl

N <- as.numeric(sum(tbl)); N
y <- N - as.numeric(tbl["Never"]); y

a <- 1+y; a
b <- 1+(N-y); b

c <- a+b
mu <- a/c; mu
sigma <- sqrt(a*b/(c*c*(c+1))); sigma

# Ex
a <- 82+y; a
b <- 120+(N-y); b

c <- a+b
mu <- a/c; mu
sigma <- sqrt(a*b/(c*c*(c+1))); sigma



################################
# c21-s02

library(MASS)
tbl <- table(survey$Smoke); tbl

N <- as.numeric(sum(tbl)); N
y <- N - as.numeric(tbl["Never"]); y

mu <- 0.35
sigma <- 0.025

c <- mu*(1-mu)/(sigma*sigma) - 1
a <- mu*c; a
b <- (1-mu)*c; b

a1 <- a+y; a1
b1 <- b+(N-y); b1

c1 <- a1+b1
mu1 <- a1/c1; mu1
sigma1 <- sqrt(a1*b1/(c1*c1*(c1+1))); sigma1


# Ex
mu <- 0.15
sigma <- 0.03

c <- mu*(1-mu)/(sigma*sigma) - 1
a <- mu*c; a
b <- (1-mu)*c; b

a1 <- a+y; a1
b1 <- b+(N-y); b1

c1 <- a1+b1
mu1 <- a1/c1; mu1
sigma1 <- sqrt(a1*b1/(c1*c1*(c1+1))); sigma1




################################
# c21-s03

model <- function() {
    # Prior
    p ~ dbeta(1, 1)

    # Likelihood
    y ~ dbin(p, N)
}

library(R2OpenBUGS)
model.file <- file.path(tempdir(), 
    "model.txt")
write.model(model, model.file)

library(MASS)
tbl <- table(survey$Smoke)
N <- as.numeric(sum(tbl)); N
y <- N - as.numeric(tbl["Never"]); y

data <- list("N", "y")
params <- c("p")
inits <- function() { list(p=0.5) }
out <- bugs(data, inits, params, 
    model.file, n.iter=10000)

all(out$summary[,"Rhat"] < 1.1)

out$mean["p"]
out$sd["p"]

print(out, digits=5)


# CODA
out <- bugs(data, inits, params, 
    model.file, codaPkg=TRUE, n.iter=10000)
out.coda <- read.bugs(out)

library(coda)
xyplot(out.coda)
densityplot(out.coda)
acfplot(out.coda)

gelman.diag(out.coda)
gelman.plot(out.coda)

out.summary <- summary(out.coda, 
    q=c(0.025, 0.975))
out.summary$stat["p",]
out.summary$q["p", ]


# Figures
png(file="bayesian-openbugs0x.png", width=360, height=360)
xyplot(out.coda)
dev.off()

png(file="bayesian-openbugs1x.png", width=360, height=360)
densityplot(out.coda)
dev.off()

png(file="bayesian-openbugs2x.png", width=360, height=360)
acfplot(out.coda)
dev.off()

png(file="bayesian-openbugs3x.png", width=360, height=360)
gelman.plot(out.coda)
dev.off()


# Ex
model <- function() {
    # Prior
    p ~ dbeta(85, 120)

    # Likelihood
    y ~ dbin(p, N)
}

library(R2OpenBUGS)
model.file <- file.path(tempdir(), 
    "model.txt")
write.model(model, model.file)

tbl <- table(survey$Smoke)
N <- as.numeric(sum(tbl)); N
y <- N - as.numeric(tbl["Never"]); y

data <- list("y", "N")
params <- c("p")
inits <- function() { list(p=0.5) }
out <- bugs(data, inits, params, 
    model.file, n.iter=10000)

all(out$summary[,"Rhat"] < 1.1)

out$mean["p"]
out$sd["p"]

print(out, digits=5)





