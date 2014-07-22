###########################################################
#
# Copyright (C) 2012 by Chi Yau
# All rights reserved
#
# http://www.r-tutor.com
#


################################
# c14-s01
library(MASS)
levels(survey$Smoke)

smoke.freq = table(survey$Smoke)
smoke.freq

smoke.prob = c(.045, .795, .085, .075)
chisq.test(smoke.freq, p=smoke.prob)

# Ex
f = table(survey$Smoke)
e = smoke.prob*length(survey$Smoke); e

d = f-e
chi = sum(d*d/e); chi

df = length(f)-1
pchisq(chi, df=df, lower=FALSE)



################################
# c14-s02
library(MASS)
tbl = table(survey$Smoke, survey$Exer)
tbl
chisq.test(tbl)

ctbl = cbind(
          tbl[,"Freq"], 
          tbl[,"None"] + tbl[,"Some"])
ctbl
chisq.test(ctbl)

# Ex
f = table(survey$Smoke, survey$Exer); f

rowsum = rowSums(f); rowsum
# rowsum = apply(f, 1, sum); rowsum

colsum = colSums(f); colsum
# colsum = apply(f, 2, sum); colsum

p = rowsum %*% t(colsum)
e = p / nrow(survey); e

d = f-e
chi = sum(d*d/e); chi

df = (nrow(f)-1)*(ncol(f)-1); df
pchisq(chi, df=df, lower=FALSE)




