# example from Stack Overflow
# lines, labels, legends
# http://stackoverflow.com/questions/24123073/ggplot-missing-labels-in-legend
library('ggplot2')
n <- ncol(mtcars)
mtcars[,n+1] <- mean(mtcars$wt)
mtcars[,n+2] <- mean(mtcars$wt) + sd(mtcars$wt)
mtcars[,n+3] <- mean(mtcars$wt) - sd(mtcars$wt)
p <- qplot(mpg,wt,data = mtcars, colour="1")
p <- p + geom_smooth(method='lm',aes(x=mpg,y=wt,colour="2"),formula=y~x)
p <- p + geom_line(aes(x=mpg,y=mtcars[,n+1],colour="3"))
p <- p + geom_line(aes(x=mpg,y=mtcars[,n+2],colour="4"),linetype="dashed")
p <- p + geom_line(aes(x=mpg,y=mtcars[,n+3],colour="5"),linetype="dashed")
p <- p + labs(colour="")    
p <- p + scale_colour_manual(values = c("red","blue",  "green","green","green"),labels=c("Data","Regression","Mean","Mean + SD","Mean - SD"))
p <- p + guides(colour = guide_legend())
print(p)
