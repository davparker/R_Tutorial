###########################################################
#
# Copyright (C) 2012 by Chi Yau
# All rights reserved
#
# http://www.r-tutor.com
#


################################
# c06
library(MASS)
head(survey)


################################
# c10-s01
height.survey = survey$Height
mean(height.survey, na.rm=TRUE) 


################################
# c10-s02
height.response = na.omit(survey$Height)

n = length(height.response)
sigma = 9.48                   # population standard deviation
sem = sigma/sqrt(n); sem 

E = qnorm(.975)*sem; E         # margin of error
xbar = mean(height.response)   # sample mean
xbar + c(-E, E)


library(TeachingDemos)
z.test(height.response, sd=sigma)


################################
# c10-s03
height.response = na.omit(survey$Height)

n = length(height.response)
s = sd(height.response)        # sample standard deviation
SE = s/sqrt(n); SE 

E = qt(.975, df=n-1)*SE; E     # margin of error
xbar = mean(height.response)   # sample mean
xbar + c(-E, E)


t.test(height.response)


################################
# c10-s04
zstar = qnorm(.975)
sigma = 9.48
E = 1.2
zstar^2 * sigma^2/ E^2


################################
# c10-s05
gender.response = na.omit(survey$Sex) 
n = length(gender.response)

k = sum(gender.response == "Female")
pbar = k/n; pbar


################################
# c10-s06
gender.response = na.omit(survey$Sex) 
n = length(gender.response)    # valid responses count
k = sum(gender.response == "Female")
pbar = k/n; pbar

SE = sqrt(pbar*(1-pbar)/n); SE     # standard error
E = qnorm(.975)*SE; E 
pbar + c(-E, E)

prop.test(k, n)


################################
# c10-s07
zstar = qnorm(.975)
p = 0.5
E = 0.05
zstar^2 * p * (1-p) / E^2





