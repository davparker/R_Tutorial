###########################################################
#
# Copyright (C) 2012 by Chi Yau
# All rights reserved
#
# http://www.r-tutor.com
#


################################
# c18-s01
stackloss.lm = lm(stack.loss ~  
    Air.Flow + Water.Temp + Acid.Conc.,
    data=stackloss)
newdata = data.frame(Air.Flow=72, 
    Water.Temp=20, 
        Acid.Conc.=85)
predict(stackloss.lm, newdata)


################################
# c18-s02
stackloss.lm = lm(stack.loss ~  
     Air.Flow + Water.Temp + Acid.Conc.,
     data=stackloss)
summary(stackloss.lm)$r.squared


################################
# c18-s03
stackloss.lm = lm(stack.loss ~  
     Air.Flow + Water.Temp + Acid.Conc.,
     data=stackloss)
summary(stackloss.lm)$adj.r.squared


################################
# c18-s04
stackloss.lm = lm(stack.loss ~  
     Air.Flow + Water.Temp + Acid.Conc.,
     data=stackloss)
summary(stackloss.lm)


################################
# c18-s05
attach(stackloss)
stackloss.lm = lm(stack.loss ~  
     Air.Flow + Water.Temp + Acid.Conc.)
newdata = data.frame(Air.Flow=72,
     Water.Temp=20, 
     Acid.Conc.=85)
predict(stackloss.lm, newdata, 
     interval="confidence")
detach(stackloss)    # clean up


################################
# c18-s06
attach(stackloss)
stackloss.lm = lm(stack.loss ~  
     Air.Flow + Water.Temp + Acid.Conc.)
newdata = data.frame(Air.Flow=72,
     Water.Temp=20, 
     Acid.Conc.=85)
predict(stackloss.lm, newdata, 
     interval="predict")
detach(stackloss)    # clean up



