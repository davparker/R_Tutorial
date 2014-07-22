###########################################################
#
# Copyright (C) 2012 by Chi Yau
# All rights reserved
#
# http://www.r-tutor.com
#


################################
# c17-s01
eruption.lm = lm(eruptions ~ waiting, data=faithful)
coeffs = coefficients(eruption.lm); coeffs
waiting = 80           # the waiting time
duration = coeffs[1] + coeffs[2]*waiting
duration


################################
# c17-s02
eruption.lm = lm(eruptions ~ waiting, data=faithful)
summary(eruption.lm)$r.squared


################################
# c17-s03
eruption.lm = lm(eruptions ~ waiting, data=faithful)
summary(eruption.lm)


################################
# c17-s04
attach(faithful)     # attach the data frame
eruption.lm = lm(eruptions ~ waiting)
newdata = data.frame(waiting=80)
predict(eruption.lm, newdata, interval="confidence")
detach(faithful)     # clean up


################################
# c17-s05
attach(faithful)     # attach the data frame
eruption.lm = lm(eruptions ~ waiting)
newdata = data.frame(waiting=80)
predict(eruption.lm, newdata, interval="predict")
detach(faithful)     # clean up


################################
# figures

#simple-regression5x.png
png(file="simple-regression5x.png", width=450, height=450)
eruption.lm = lm(eruptions ~ waiting, data=faithful)
eruption.res = resid(eruption.lm)
plot(faithful$waiting, eruption.res,
     ylab="Residuals", xlab="Waiting Time", 
     main="Old Faithful Eruptions")
abline(0, 0)                  # the horizon
dev.off()

#simple-regression7x.png
png(file="simple-regression7x.png", width=450, height=450)
eruption.lm = lm(eruptions ~ waiting, data=faithful)
eruption.stdres = rstandard(eruption.lm)
plot(faithful$waiting, eruption.stdres,
     ylab="Standardized Residuals", 
     xlab="Waiting Time", 
     main="Old Faithful Eruptions")
abline(0, 0)                  # the horizon
dev.off()

#simple-regression8x.png
png(file="simple-regression8x.png", width=450, height=450)
eruption.lm = lm(eruptions ~ waiting, data=faithful)
eruption.stdres = rstandard(eruption.lm)
qqnorm(eruption.stdres, 
     ylab="Standardized Residuals", 
     xlab="Normal Scores", 
     main="Old Faithful Eruptions")
qqline(eruption.stdres)
dev.off()

#simple-regression9x.png
png(file="simple-regression9x.png", width=450, height=450)
eruption.lm = lm(eruptions ~ waiting, data=faithful)
plot(eruption.lm, which=2)
dev.off()




