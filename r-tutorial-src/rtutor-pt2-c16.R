###########################################################
#
# Copyright (C) 2012 by Chi Yau
# All rights reserved
#
# http://www.r-tutor.com
#


################################
# c16-s01
binom.test(5, 18)


################################
# c16-s02
library(MASS)

head(immer)
wilcox.test(immer$Y1, immer$Y2, paired=TRUE)


################################
# c16-s03
wilcox.test(mpg ~ am, data=mtcars)


################################
# c16-s04
head(airquality)
kruskal.test(Ozone ~ Month, data = airquality)

