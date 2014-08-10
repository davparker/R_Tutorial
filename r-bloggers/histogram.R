# http://www.r-bloggers.com/basics-of-histograms/
BMI<-rnorm(n=1000, m=24.2, sd=2.2) 
length(BMI)
# basic histogram
hist(BMI)
# info about histogram - notice returns a list
histinfo <- hist(BMI) 
histinfo
# $breaks
# [1] 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32 33
# 
# $counts
# [1]   1   1   7  18  40  77 137 177 168 158 101  64  33  11   5   1   1
# 
# $density
# [1] 0.001 0.001 0.007 0.018 0.040 0.077 0.137 0.177 0.168 0.158 0.101 0.064 0.033 0.011 0.005 0.001 0.001
# 
# $mids
# [1] 16.5 17.5 18.5 19.5 20.5 21.5 22.5 23.5 24.5 25.5 26.5 27.5 28.5 29.5 30.5 31.5 32.5
# 
# $xname
# [1] "BMI"
# 
# $equidist
# [1] TRUE
# 
# attr(,"class")
# [1] "histogram

# This shows the counts, intensity/density for each bin (same thing but two
# different names for R version compatibility), the midpoints of each bin, and
# then the name of the variable, whether the bins are equidistant, and the class
# of the object. You can of course take any one of these outputs by itself, i.e.
# histinfo$counts would give you just the vector of counts.
# the breaks go from 17 to 32 by 1

# You can use the breaks() option to change this in a number of ways.  An easy
# way is just to give it one number that gives the number of cells for the
# histogram:

# 1. Number of bins

hist(BMI, breaks=20, main="Beaks = 20")
hist(BMI, breaks=5, main="Beaks = 5")

# If you want more control over exactly the breakpoints between bins, you can be
# more precise with the breaks() option and give it a vector of breakpoints,
# like this:
# Notice the mids from histinfo above for the range # $mids
# [1] 16.5 17.5 18.5 19.5 20.5 21.5 22.5 23.5 24.5 25.5 26.5 27.5 28.5 29.5 30.5 31.5 32.5
# -or-
range(BMI)    
# [1] 16.81630 32.16767
hist(BMI, breaks=c(16,20,23,26,29,33), main="Breaks is vector of breakpoints")

# This dictates exactly the start and end point of each bin.  Of course, you
# could give the breaks vector as a sequence like this to cut down on the
# messiness of the code:
hist(BMI, breaks=seq(16,33), main="Breaks is vector of breakpoints")

# 2. Frequency vs Density 

# Instead of counting the number of datapoints per bin, R can give the
# probability densities using the freq=FALSE option:

hist(BMI, freq=FALSE, main="Density plot")

# Notice the y-axis now.  If the breaks are equidistant, with difference between
# breaks=1, then the height of each rectangle is proportional to the number of
# points falling into the cell, and thus the sum of the probability densities
# adds up to 1.  Here I specify plot=FALSE because I just want the histogram
# output, not the plot, and show how the sum of all of the densities is 1:

hist1 <- hist(BMI, freq=FALSE)
hist1$density
# [1] 0.001 0.001 0.007 0.018 0.040 0.077 0.137 0.177 0.168 0.158 0.101 0.064 0.033 0.011 0.005 0.001 0.001
sum(hist1$density)
# [1] 1

# However, if you choose to make bins that are not all separated by 1 (like
# breaks=c(17,25,26, 32) or something like that), then the plot still has an
# area of 1, but the area of the rectangles is the fraction of data points
# falling into the cells. The densities are calculated like this as
# counts/(n*diff(breaks).  Thus, this adds up to 1 if add up the areas of the
# rectangles, i.e. you multiply each density by the difference in the breaks
# like this:

hist2 <- hist(BMI, breaks=c(16,25,28,33))
hist2$density
# [1] 0.06955556 0.10766667 0.01020000
sum(hist2$density)
# [1] 0.1874222
sum(diff(hist2$breaks)*hist2$density)
# [1] 1

# 3. Plot aesthetics 

# Finally, we can make the histogram better looking by adjusting the x-axis,
# y-axis, axis labels, title, and color like this:

hist(BMI, freq=FALSE, xlab="Body mass index", main="Distribution of body mass index", 
     col="lightgreen", xlim=c(15,35), ylim=c(0,0.2))

# Finally, I can add a nice normal distribution curve to this plot using the
# curve() function, in which I specify a normal density function with mean and
# standard deviation that is equal to the mean and standard deviation of my
# data, and I add this to my previous plot with a dark blue color and a line
# width of 2. You can play around with these options to get the kind of line you
# want:
curve(dnorm(x, mean(BMI), sd(BMI)), add=TRUE, col="darkblue", lwd=2)
