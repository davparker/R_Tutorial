# http://rollingyours.wordpress.com/2014/05/15/the-apply-command-101/

# The apply command 101
# Posted: May 15, 2014 in Performance, R programming apply lapply tapply    

# I’ll start with the apply command which expects a matrix as input. Depending
# on what function you specify when using the apply command, you will get back
# either a vector or a matrix.

set.seed(1)  # Makes the call to rnorm generate the same numbers every time
( mymat <- matrix(round(rnorm(16,10),2),4,4) )

# [,1]  [,2]  [,3]  [,4]
# [1,]  9.37 10.33 10.58  9.38
# [2,] 10.18  9.18  9.69  7.79
# [3,]  9.16 10.49 11.51 11.12
# [4,] 11.60 10.74 10.39  9.96

# Let’s say that we want to take the mean of each column. Another way to say
# this is that we want to apply the mean function to each column in the matrix.
# This is the way to start thinking about things like this in R. But first, how
# might we do this if we don’t know anything about the apply command ?

mean(mymat[,1])
# [1] 10.0775

mean(mymat[,2])
# [1] 10.185

mean(mymat[,3])
# [1] 10.5425

mean(mymat[,4])
# [1] 9.5625

# Or we could stash the means into a vector if we need to use that information elsewhere

( mymatcolmean <- c(mean(mymat[,1]),mean(mymat[,2]),mean(mymat[,3]),mean(mymat[,4])) )

# [1] 10.0775 10.1850 10.5425  9.5625

# Well, if you have experience with programming languages like C, FORTRAN, Java,
# or Perl then you probably know how to use a for-loop structure to solve this
# problem. R supports for-loops too but it also offers some ways to avoid using
# them.

retvec <- vector()
for (ii in 1:ncol(mymat)) {
    retvec[ii] = mean(mymat[,ii])
}
retvec
# [1] 10.0775 10.1850 10.5425  9.5625

# We could even put this into a function for later use in case we need it.

myloop <- function(somemat) {
    retvec <- vector()
    length(retvec) <- ncol(somemat)
    for (ii in 1:ncol(somemat)) {
        retvec[ii] <- mean(somemat[,ii])
    }
    return(retvec)
}

myloop(mymat)
# [1] 10.0775 10.1850 10.5425  9.5625

# This will now work for any matrix but of course it is specific to the columns of the matrix.

set.seed(1)

newmat <- matrix(rnorm(100),10,10)

myloop(newmat)
# [1]  0.1322028  0.2488450 -0.1336732  0.1207302  0.1341367  0.1434569  0.4512100 -0.2477361
# [9]  0.1273603  0.1123413

# So this would work but what if we wanted to take the mean of the rows instead
# of the columns ? We could do that but we then have to rewrite our function.
# And, while we are at it, in order to make our function more general what about
# providing an argument that indicates whether we want to operate on the rows or
# the columns ? I’ll use “1” to indicate rows and “2” to indicate columns.

myloop <- function(somemat,rc=2) {
    retvec <- vector()
    length(retvec) <- ncol(somemat)
    
    # Check to see if we are taking the mean of the columns or rows
    # 1 indicates rows, 2 indicates columns
    
    if (rc == 2) {
        for (ii in 1:ncol(somemat)) {
            retvec[ii] <- mean(somemat[,ii])
        }
    } else {
        for (ii in 1:nrow(somemat)) {
            retvec[ii] <- mean(somemat[ii,])
        }
    }
    return(retvec)
}

# Okay let's make sure it works. 
myloop(mymat,2)   # This is correct
# [1] 10.0775 10.1850 10.5425  9.5625

myloop(mymat,1)   # This is correct
# [1]  9.9150  9.2100 10.5700 10.6725

mean(mymat[1,])  # A spot check
# [1] 9.915

# Doing it the easy way
# Well okay that’s good but what if we then wanted our myloop function to
# accommodate a function other than mean ? Like quantile, sum, fivenum, or even
# a function of our own design ? We could add another argument to our function
# to let the user specify the name of a function to be applied to the rows or
# columns. But before we do more work please consider that R already has
# something that will do the job for us – the apply command.

apply(mymat, 2, mean)
# [1] 10.0775 10.1850 10.5425  9.5625

apply(mymat, 1, mean)
# [1]  9.9150  9.2100 10.5700 10.6725

# See how much easier that is than writing our own looping function ? It has
# been my observation that those well versed in traditional programming
# languages have a bigger problem getting used to the apply function than
# newcomers simply because experienced programmers are more accustomed to
# writing their own summary functions. They just dive in and start coding. But R
# short circuits this approach by providing the apply family of commands. Note
# also that we can substitute in any function we want to.

apply(mymat,2,class)  # What class do the columns belong to ?
# [1] "numeric" "numeric" "numeric" "numeric"

apply(mymat,2,sum)    # Get the sum of all the columns
# [1] 40.31 40.74 42.17 38.25

apply(mymat,1,range)  # Get the range of all rows
#       [,1]  [,2]  [,3]  [,4]
# [1,]  9.37  7.79  9.16  9.96
# [2,] 10.58 10.18 11.51 11.60

apply(mymat,2,fivenum) # Get the fivenum summary for each column
#        [,1]   [,2]   [,3]   [,4]
# [1,]  9.160  9.180  9.690  7.790
# [2,]  9.265  9.755 10.040  8.585
# [3,]  9.775 10.410 10.485  9.670
# [4,] 10.890 10.615 11.045 10.540
# [5,] 11.600 10.740 11.510 11.120

rowMeans(mymat)     # Equivalent to apply(mymat,1,mean)
# [1]  9.9150  9.2100 10.5700 10.6725

colMeans(mymat)     # Equivalent to apply(mymat,2,mean)
# [1] 10.0775 10.1850 10.5425  9.5625

rowSums(mymat)      # Equivalent to apply(mymat,1,sum)
# [1] 39.66 36.84 42.28 42.69

colSums(mymat)      # Equivalent to apply(mymat,2,sum)
# [1] 40.31 40.74 42.17 38.25

#...cont...
# http://rollingyours.wordpress.com/2014/05/15/the-apply-command-101/