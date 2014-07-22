###########################################################
#
# Copyright (C) 2012 by Chi Yau
# All rights reserved
#
# http://www.r-tutor.com
#


################################
# c19-s01
am.glm = glm(formula=am ~ hp + wt, 
               data=mtcars, 
               family=binomial)
newdata = data.frame(hp=120, wt=2.8)
predict(am.glm, newdata, type="response")


################################
# c19-s02
am.glm = glm(formula=am ~ hp + wt, 
          data=mtcars, 
          family=binomial)
summary(am.glm)






