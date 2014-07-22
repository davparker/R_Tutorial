###########################################################
#
# Copyright (C) 2012-2013 by Chi Yau
# All rights reserved
#
# http://www.r-tutor.com
#


################################
# c30-s01
x <- mtcars["Honda Civic",]
y <- mtcars["Camaro Z28",]
dist(rbind(x, y))

z <- mtcars["Pontiac Firebird",]
dist(rbind(y, z))

dist(as.matrix(mtcars))


test.data <- function(dim, num, seed=17) {
    set.seed(seed)
    matrix(rnorm(dim * num), nrow=num)
}
m <- test.data(120, 4500)
system.time(dist(m))


library(rpud)             # load rpudplus
system.time(rpuDist(m))


# Ex 1
test.data <- function(dim, num, seed=17) {
     set.seed(seed)
     matrix(rnorm(dim * num), nrow=num)
}
m <- test.data(240, 6000)

system.time(dist(m))
system.time(rpuDist(m))


# Ex 2
test.data <- function(dim, num, seed=17) {
     set.seed(seed)
     matrix(rnorm(dim * num), nrow=num)
}
m <- test.data(120, 2400)

system.time(rpuDist(m, method="binary"))
system.time(rpuDist(m, method="canberra"))
system.time(rpuDist(m, method="manhattan"))
system.time(rpuDist(m, method="maximum"))
system.time(rpuDist(m, method="minkowski"))



################################
# c30-s02
d <- dist(as.matrix(mtcars))   # find distance matrix
hc <- hclust(d)                # hirarchical clustering
plot(hc)                       # plot the dendrogram

test.data <- function(dim, num, seed=17) {
    set.seed(seed)
    matrix(rnorm(dim * num), nrow=num)
}
m <- test.data(120, 4500)

library(rpud)                  # load rpudplus
d <- rpuDist(m)                # Euclidean distance

system.time(hclust(d))         # complete linkage
system.time(rpuHclust(d))      # rpuHclust in rpudplus


# Ex 1
test.data <- function(dim, num, seed=17) {
     set.seed(seed)
     matrix(rnorm(dim * num), nrow=num)
}
m <- test.data(240, 6000)
d <- rpuDist(m)

system.time(hclust(d))
system.time(rpuHclust(d))


# Ex 2
test.data <- function(dim, num, seed=17) {
     set.seed(seed)
     matrix(rnorm(dim * num), nrow=num)
}
m <- test.data(120, 2400)
d <- rpuDist(m)

system.time(rpuHclust(d, method="ward"))
system.time(rpuHclust(d, method="single"))
system.time(rpuHclust(d, method="average"))
system.time(rpuHclust(d, method="mcquitty"))
system.time(rpuHclust(d, method="median"))
system.time(rpuHclust(d, method="centroid"))



################################
# c30-s03
library(MASS)
smoke <- as.numeric(factor(survey$Smoke,
    levels=c("Never","Occas","Regul","Heavy")))
exer <- as.numeric(factor(survey$Exer,
    levels=c("None","Some","Freq")))

m <- cbind(exer, smoke)
cor(m, method="kendall", use="pairwise.complete.obs") 

test.data <- function(dim, num, seed=17) {
    set.seed(seed)
    matrix(rnorm(dim * num), nrow=num)
}

m <- test.data(dim=24, num=4000)
system.time(cor(m, method="kendall"))

library(rpud)                  # load rpudplus
system.time(rpuCor(m, method="kendall"))


# Ex 1
test.data <- function(dim, num, seed=17) {
     set.seed(seed)
     matrix(rnorm(dim * num), nrow=num)
}

m <- test.data(dim=36, num=4500)
system.time(cor(m, method="kendall"))

library(rpud)                  # load rpudplus
system.time(rpuCor(m, method="kendall"))


# Ex 2
library(MASS)
m <- cbind(exer=survey$Exer, smoke=survey$Smoke)

library(rpud)                  # load rpudplus
rpucor(m, method="kendall")
rpucor(m, method="kendall", use="all.obs") 
rpucor(m, method="kendall", use="complete.obs") 
rpucor(m, method="kendall", use="na.or.complete") 
rpucor(m, method="kendall", use="pairwise.complete.obs") 



# Ex 2
library(MASS)
m <- cbind(exer=survey$Exer, smoke=survey$Smoke)
cor(m, method="kendall", use="pairwise.complete.obs") 



################################
# c30-s04
library(MASS)
smoke <- as.numeric(factor(survey$Smoke,
    levels=c("Never","Occas","Regul","Heavy")))
exer <- as.numeric(factor(survey$Exer,
    levels=c("None","Some","Freq")))

m <- cbind(exer, smoke)
cor(m, method="kendall", use="pairwise") 

cor.test(exer, smoke, method="kendall")

library(rpud)                     # load rpudplus
rpucor(m, method="kendall", use="pairwise") 

rt <- rpucor.test(m, method="kendall", use="pairwise")
rt$estimate

rt$p.value
rt$p.value < 0.05

test.data <- function(dim, num, seed=17) {
    set.seed(seed)
    matrix(sample(1:16, dim*num, replace=TRUE), 
               nrow=num)
}
m <- test.data(24, 4000)

system.time(cor(m, method="kendall"))

system.time(rpucor(m, method="kendall"))
system.time(rpucor.test(m, method="kendall"))


# Ex 1
rpucor.test(USJudgeRatings)$p.value < 0.05


# Ex 2
m <- transform(ToothGrowth, supp=as.numeric(supp))
rpucor.test(m, method="kendall")$p.value < 0.05



################################
# c30-s05
library(rpud)                     # load rpudplus
cadata.scaled <- read.svm.data("cadata.scaled", fac=FALSE)
x <- cadata.scaled$x; y <- cadata.scaled$y

library(e1071)
system.time(cadata.libsvm <- 
     e1071::svm(x, y, type="eps-regression", scale=FALSE))

system.time(cadata.rpusvm <- 
     rpusvm(x, y, type="eps-regression", scale=FALSE))

res.libsvm <- cadata.libsvm$residuals
sum(res.libsvm*res.libsvm)/length(res.libsvm)

res.rpusvm <- cadata.rpusvm$residuals
sum(res.rpusvm*res.rpusvm)/length(res.rpusvm)


# Ex 1
library(rpud)                     # load rpudplus
a9a <- read.svm.data("a9a")
x <- a9a$x; y <- a9a$y

library(e1071)
system.time(a9a.libsvm <- e1071::svm(x, y, scale=FALSE))
a9a.libsvm

system.time(a9a.rpusvm <-rpusvm(x, y, scale=FALSE))
a9a.rpusvm

# Ex 2
library(rpud)                     # load rpudplus
system.time(cadata.rpusvm <- 
     rpusvm(x, y, type="eps-regression", 
          scale=FALSE, probability=TRUE))

# Ex 3
library(rpud)                     # load rpudplus
system.time(cadata.rpusvm <- 
     rpusvm(x, y, type="eps-regression", 
          scale=FALSE, cross=5))

cadata.rpusvm$MSE
cadata.rpusvm$tot.MSE
cadata.rpusvm$scorrcoeff


################################
# c30-s08

# Example 1
library(rpud)
x1 <- rvbm.sample.train$X[, 1]
x2 <- rvbm.sample.train$X[, 2] 
tc <- rvbm.sample.train$t.class

plot(x1, x2, type="n", xlab="X1", ylab="X2")
points(x1[tc==1], x2[tc==1], 
	type="p", col="blue", pch=19)
points(x1[tc==2], x2[tc==2], 
	type="p", col="red")
points(x1[tc==3], x2[tc==3], 
	type="p", col="green", pch=24)

source("http://bioconductor.org/biocLite.R")
biocLite("vbmp")

library(vbmp)
system.time(res.vbmp <- vbmp( 
	rvbm.sample.train$X, 
	rvbm.sample.train$t.class,
	rvbm.sample.test$X, 
	rvbm.sample.test$t.class, 
	theta = rep(1., ncol(rvbm.sample.train$X)), 
	control = list(
		sKernelType="gauss", 
		bThetaEstimate=TRUE, 
		bMonitor=TRUE,
		InfoLevel=1) 
	))
covParams(res.vbmp)
predError(res.vbmp)
predLik(res.vbmp)

library(rpud)     # load rpudplus
system.time(res.rvbm <- rvbm( 
	rvbm.sample.train$X, 
	rvbm.sample.train$t.class,
	rvbm.sample.test$X, 
	rvbm.sample.test$t.class, 
	theta = rep(1., ncol(rvbm.sample.train$X)), 
		control = list(
		sKernelType="gauss", 
		bThetaEstimate=TRUE, 
		bMonitor=TRUE,
		InfoLevel=1) 
		))
summary(res.rvbm)


# Example 2
library(vbmp)
data(BRCA12) 

source("http://bioconductor.org/biocLite.R")
biocLite("Biobase")

library(Biobase)
brca.x <- t(exprs(BRCA12))
brca.y <- BRCA12$Target.class

library(rpud)     # load rpudplus
system.time(brca.rvbm <- rvbm(
	brca.x, brca.y, 
	brca.x, brca.y, 
	theta = rep(1.0, ncol(brca.x)),  
	control=list(
		sKernelType="linear", 
		bThetaEstimate=TRUE,
		bMonitor=TRUE,
		InfoLevel=1) 
		))
summary(brca.rvbm)
plot(brca.rvbm)



################################
# c30-s9

library(bayesm)
data(cheese)
str(cheese)

retailer <- levels(cheese$RETAILER)
nreg <- length(retailer)

regdata <- NULL
for (i in 1:nreg) {
	filter <- 
		cheese$RETAILER==retailer[i]

	y <- log(cheese$VOLUME[filter])
	X <- cbind(1,      # intercept placeholder 
			cheese$DISP[filter], 
			log(cheese$PRICE[filter]))
	
	regdata[[i]] <- list(y=y, X=X)
}


Data <- list(regdata=regdata)
Mcmc <- list(R=2000)

system.time(
out <- bayesm::rhierLinearModel(
        Data=Data,
        Mcmc=Mcmc))


library(rpud)
system.time(
out <- rpud::rhierLinearModel(
		Data=Data,
		Mcmc=Mcmc,
		output="bayesm"))

beta.3 <- mean(as.vector(out$betadraw[, 3, 201:2000]))
beta.3

exp(beta.3 * log(1.05))


# Ex 1
# created Data and Mcmc in previous code
out <- rpud::rhierLinearModel(
		Data=Data,
		Mcmc=Mcmc,
		output="coda")
attributes(out)

# Vbeta
xyplot(out$Vbeta.mcmc)
densityplot(out$Vbeta.mcmc)
acfplot(out$Vbeta.mcmc)

gelman.diag(out$Vbeta.mcmc)
gelman.plot(out$Vbeta.mcmc)

# Delta
xyplot(out$Delta.mcmc)
densityplot(out$Delta.mcmc)
acfplot(out$Delta.mcmc)

gelman.diag(out$Delta.mcmc)
gelman.plot(out$Vbeta.mcmc)

# mpsf
Vbeta.res <- 
	gelman.diag(out$Vbeta.mcmc)
Vbeta.res$mpsrf

Delta.res <- 
	gelman.diag(out$Delta.mcmc)
Delta.res$mpsrf

tau.res <- 
	gelman.diag(out$tau.mcmc)
tau.res$mpsrf

beta.res <- 
	gelman.diag(out$beta.mcmc)
beta.res$mpsrf

# Figures
png(file="rhierlmc-vbeta-xyplot.png", width=450, height=450)
xyplot(out$Vbeta.mcmc)
dev.off()

png(file="rhierlmc-vbeta-densityplot.png", width=450, height=450)
densityplot(out$Vbeta.mcmc)
dev.off()

png(file="rhierlmc-vbeta-acfplot.png", width=450, height=450)
acfplot(out$Vbeta.mcmc)
dev.off()

png(file="rhierlmc-vbeta-gelmanplot.png", width=450, height=450)
gelman.plot(out$Vbeta.mcmc)
dev.off()


# Ex 2
# created regdata in previous code
ls.regrs <- sapply(regdata, 
	function(item) {
		y <- item$y
		X <- item$X
		coefficients(lm(y ~ X-1))
	})	
dim(ls.regrs)

index <- 2	# display measure
ls.display <- ls.regrs[index,]

# gibbs prior
nvar <- ncol(regdata[[1]]$X)
nu <- nvar+3; nu
V <- 0.1*nu; V
Prior <- list(nu=nu, V=V)

# created Data and Mcmc in previous code
out <- rpud::rhierLinearModel(
		Data=Data,
		Prior=Prior,
		Mcmc=Mcmc,
		output="bayesm")

R <- Mcmc$R
burnin <- trunc(0.1*R)
filter <- (burnin+1):R
post.display <- apply(
	out$betadraw[,index,filter],
	1, mean)

plot(ls.display, post.display, 
		xlab="least square coeff", 
		ylab="posterior mean", 
		main="Display Measure",
		pch=21)
# line thru' origin with slope 1
lines(c(-15, 15), c(-15, 15))


# Ex 3
library("cudaBayesreg")

# load from cudaBayesregData
slicedata <- read.fmrislice(
	fbase = "fmri", slice = 3, 
	swap = TRUE)
X <- slicedata$X
nvar <- slicedata$nvar; nvar
nobs <- slicedata$nobs; nobs

ymaskdata <- premask(slicedata)
yn <- ymaskdata$yn
stopifnot(nobs == nrow(yn))

nreg <- ymaskdata$nreg; nreg
regdata <- NULL
for (i in 1:nreg) {
	regdata[[i]] <- list(
			y=yn[,i], 
			X=X)
}

# MCMC parameters
R <- 3000
keep <- 5

Data <- list(regdata=regdata)
Mcmc <- list(R=R,keep=keep)

system.time(
out <- rpud::rhierLinearModel(
		Data=Data, Mcmc=Mcmc,
		output="bayesm"))

post.ppm(out = out, vreg = 2, 
		slicedata = slicedata, 
		ymaskdata = ymaskdata, 
		col = heat.colors(256))


################################
# c30-s10

library(bayesm)

data(margarine)
attributes(margarine)

str(margarine$choicePrice)
str(margarine$demos)

# select columns
chpr <- subset(
		margarine$choicePrice,
		select=(hhid:PSS_Tub)[-PImp_Stk])

head(chpr)

# select rows
chpr <- subset(chpr,
		choice %in% c(1:5,7))

# patch choice column
L <- chpr[,2]==7
chpr[L,2] <- 6

# row filter
hhid.nobs <- 
		table(chpr[,"hhid"])
head(hhid.nobs, n=4)

hhid.upper <- 
		hhid.nobs[hhid.nobs >= 5]
hhid.target <- as.integer(
		dimnames(hhid.upper)[[1]])
nlgt <- length(hhid.target); nlgt

# number of choices
p <- ncol(chpr)-2; p

# design matrix example
i <- 1
id <- hhid.target[i]
filter <- (chpr[,1]==id)

Xa <- log(
		chpr[filter, c(-1,-2)])
Xa[1,]

X <- createX(
		p  = p,
		na = 1,
		Xa = Xa,
		nd = NULL,
		Xd = NULL,
		base = 1)
head(X, n=p)

# logit data
lgtdata <- NULL
for (i in 1:nlgt) {
	id <- hhid.target[i]
	filter <- (chpr[,1]==id)
	
	# log price
	Xa <- log(
			chpr[filter, c(-1,-2)])
	
	# design matrix
	X <- createX(
			p  = p,
			na = 1,
			Xa = Xa,
			nd = NULL,
			Xd = NULL,
			base = 1)
	
	# choice
	y <- chpr[filter, 2]
	names(y) <- NULL
	
	lgtdata[[i]] <- list(
			y=y, X=X, hhid=id)
}

# demographic data
demos <- as.matrix(
		margarine$demos[,c(1,2,5)])
Z <- matrix(0, nrow=nlgt, ncol=2)
for (i in 1:nlgt){
	id <- lgtdata[[i]]$hhid
	filter <- (demos[,1]==id)
	Z[i,] <- demos[filter, 2:3]
}

Z  <- log(Z)
zm <- apply(Z, 2, mean)
Z  <- sweep(Z, 2, zm)

# MCMC
keep <- 5
R <- 20000
mcmc1 <- list(keep=keep, R=R)

library(rpud)
system.time(
	out <- rpud::rhierMnlRwMixture(
		Data  = list(p=p, 
				lgtdata=lgtdata, Z=Z),
		Prior = list(ncomp=1),
		Mcmc  = mcmc1
))

beta.post <- out$mudraw[401:4000, 6]
quantile(beta.post, c(.025, .975))
summary(beta.post)


#Ex
# defined p, lgtdata, and Z in previous code
out <- rpud::rhierMnlRwMixture(
	Data  = list(p=p, 
			lgtdata=lgtdata, Z=Z),
	Prior = list(ncomp=1),
	Mcmc  = mcmc1,
	output = "coda")

attributes(out)

# mu
xyplot(out$mu.mcmc)
densityplot(out$mu.mcmc)
acfplot(out$mu.mcmc)

gelman.diag(out$mu.mcmc)
gelman.plot(out$mu.mcmc)

# Figures
png(file="rhiermnp-mu-xyplot.png", width=450, height=450)
xyplot(out$mu.mcmc)
dev.off()

png(file="rhiermnp-mu-densityplot.png", width=450, height=450)
densityplot(out$mu.mcmc)
dev.off()

png(file="rhiermnp-mu-acfplot.png", width=450, height=450)
acfplot(out$mu.mcmc)
dev.off()

png(file="rhiermnp-mu-gelmanplot.png", width=450, height=450)
gelman.plot(out$mu.mcmc)
dev.off()





