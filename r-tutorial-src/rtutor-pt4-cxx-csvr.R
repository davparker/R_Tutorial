###########################################################
#
# Copyright (C) 2012 by Chi Yau
# All rights reserved
#
# http://www.r-tutor.com
#

library(rpud)             # load rpudplus

hs <- read.svm.data("heart_scale", fac=FALSE)
x <- hs$x
y <- hs$y

c.log <- seq(-5, 11, by=2)
g.log <- seq(-13, 3, by=2)

nc <- length(c.log)
ng <- length(g.log)
mse <- matrix(nrow=nc, ncol=ng)

for (i in 1:nc) {
     for (j in 1:ng) {
          c <- 2^c.log[i]
          g <- 2^g.log[j]
          svm.model <- rpusvm(x, y, type="eps-regression", 
                    gamma=g, cost=c, scale=FALSE, cross=5)
          mse[i, j] = svm.model$tot.MSE
          cat("mse(", c, ",", g, ") =", mse[i, j], "\n")
     }
}

min.mse <- min(mse); mse
#[1] 0.52383

min.index <- which(mse == min.mse) - 1
log.cost  <- c.log[min.index  %% nc + 1]
optimal.cost  <- 2^log.cost

log.gamma <- g.log[min.index %/% nc + 1]
optimal.gamma <- 2^log.gamma

cbind(log.cost, log.gamma, optimal.cost, optimal.gamma)
#     log.cost log.gamma optimal.cost optimal.gamma
#[1,]       -3        -3        0.125         0.125

# contour map
png(file="rgpu-esvr-contour.png", width=450, height=450)
plot(0, 0, type = "n", 
          xlim = range(c.log), ylim = range(g.log), 
          xlab = "log cost", ylab = "log gamma")
contour(x=c.log, y=g.log, mse, lty = "solid", 
          add = TRUE,     vfont = c("sans serif", "plain"))
dev.off()



#
#> min.MSE
#[1] 0.51373
#
#> optimal.cost
#[1] 0.5
#
#> optimal.gamma
#[1] 0.0078125
#

          
