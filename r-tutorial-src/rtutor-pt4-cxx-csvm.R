###########################################################
#
# Copyright (C) 2012 by Chi Yau
# All rights reserved
#
# http://www.r-tutor.com
#

library(rpud)             # load rpudplus

hs <- read.svm.data("heart_scale")
x <- hs$x
y <- hs$y

c.log <- seq(-5, 11, by=2)
g.log <- seq(-13, 3, by=2)

nc <- length(c.log)
ng <- length(g.log)
accuracy <- matrix(nrow=nc, ncol=ng)

for (i in 1:nc) {
     for (j in 1:ng) {
          c <- 2^c.log[i]
          g <- 2^g.log[j]
          svm.model <- rpusvm(x, y, 
               gamma=g, cost=c, scale=FALSE, cross=5)
          accuracy[i, j] = svm.model$tot.accuracy
          cat("accuracy(", c, ",", g, ") =", 
                    accuracy[i, j], "%\n")
     }
}

max.accuracy <- max(accuracy); max.accuracy
#[1] 84.815

max.index <- which(accuracy == max.accuracy) - 1
log.cost  <- c.log[max.index  %% nc + 1]
optimal.cost  <- 2^log.cost

log.gamma <- g.log[max.index %/% nc + 1]
optimal.gamma <- 2^log.gamma

cbind(log.cost, log.gamma, optimal.cost, optimal.gamma)
#     log.cost log.gamma optimal.cost optimal.gamma 
#[1,]        7        -9          128     0.0019531
#[2,]        1        -5            2     0.0312500

# contour map
png(file="rgpu-csvm-contour.png", width=450, height=450)
plot(0, 0, type = "n", 
          xlim = range(c.log), ylim = range(g.log), 
          xlab = "log cost", ylab = "log gamma")
contour(x=c.log, y=g.log, accuracy, lty = "solid", 
          add = TRUE,     vfont = c("sans serif", "plain"))
dev.off()


#> max.accuracy
#[1] 84.444
#
#> optimal.cost
#[1] 128
#
#> optimal.gamma
#[1] 0.00048828
#
