###########################################################
#
# Copyright (C) 2012 by Chi Yau
# All rights reserved
#
# http://www.r-tutor.com
#


################################
# c08-s01
duration = faithful$eruptions
mean(duration)

# Ex
waiting = faithful$waiting
mean(waiting)



################################
# c08-s02
duration = faithful$eruptions
median(duration)

# Ex
waiting = faithful$waiting
median(waiting)



################################
# c08-s03
duration = faithful$eruptions
quantile(duration)

# Ex
waiting = faithful$waiting
quantile(waiting)



################################
# c08-s04
duration = faithful$eruptions
quantile(duration, c(.32, .57, .98))

# Ex
waiting = faithful$waiting
quantile(waiting, c(.17, .43, .67, .85))



################################
# c08-s05
duration = faithful$eruptions
max(duration) - min(duration)

# Ex
waiting = faithful$waiting
max(waiting) - min(waiting)



################################
# c08-s06
duration = faithful$eruptions
IQR(duration)

# Ex
waiting = faithful$waiting
IQR(waiting)



################################
# c08-s07
duration = faithful$eruptions
boxplot(duration, horizontal=TRUE)

# Ex
waiting = faithful$waiting
boxplot(waiting, horizontal=TRUE)



################################
# c08-s08
duration = faithful$eruptions
var(duration)

# Ex
waiting = faithful$waiting
var(waiting)



################################
# c08-s09
duration = faithful$eruptions
sd(duration)

# Ex
waiting = faithful$waiting
sd(waiting)



################################
# c08-s10
duration = faithful$eruptions
waiting = faithful$waiting
cov(duration, waiting)



################################
# c08-s11
duration = faithful$eruptions
waiting = faithful$waiting
cor(duration, waiting)



################################
# c08-s12
library(e1071) 
duration = faithful$eruptions
moment(duration, order=3, center=TRUE)

# Ex
waiting = faithful$waiting
moment(waiting, order=3, center=TRUE)


################################
# c08-s13
library(e1071) 
duration = faithful$eruptions
skewness(duration)

# Ex
waiting = faithful$waiting
skewness(waiting)



################################
# c08-s14
library(e1071) 
duration = faithful$eruptions
kurtosis(duration)

# Ex
waiting = faithful$waiting
kurtosis(waiting)


################################
# figures

# numerical-measures4x
png(file="numerical-measures4x.png", width=450, height=450)
duration = faithful$eruptions
boxplot(duration, horizontal=TRUE)
dev.off()

# numerical-measures4xz
png(file="numerical-measures4xz.png", width=450, height=450)
waiting = faithful$waiting
boxplot(waiting, horizontal=TRUE)
dev.off()



