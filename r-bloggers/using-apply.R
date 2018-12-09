#https://www.r-bloggers.com/using-apply-sapply-lapply-in-r/
#Using apply, sapply, lapply in R

# We can simulate this data using rnorm, to create three sets of observations.
# The first has mean 0, second mean of 2, third of mean of 5, and with 30 rows.

m <- matrix(data=cbind(rnorm(30, 0), rnorm(30, 2), rnorm(30, 5)), nrow=30, ncol=3)

# When do we use apply? When we have some structured blob of data that we wish
# to perform operations on. Here structured means in some form of matrix. The
# operations may be informational, or perhaps transforming, subsetting, whatever
# to the data.

# We tell apply to traverse row wise or column wise by the second argument. In
# this case we expect to get three numbers at the end, the mean value for each
# column, so tell apply to work along columns by passing 2 as the second
# argument. But let’s do it wrong for the point of illustration:

apply(m, 1, mean)

# [1] 2.675699 1.144581 2.495878 2.009015 3.344778 2.445007 3.096205 1.685314 3.743009 2.599318
# [11] 2.666993 3.648348 2.665158 1.883913 2.849033 1.949763 1.958994 3.195795 2.984158 2.347687
# [21] 2.594813 1.980484 1.349775 1.864837 2.498416 1.804737 2.770353 1.624739 2.210476 1.713333

# Passing a 1 in the second argument, we get 30 values back, giving the mean of
# each row. Not the three numbers we were expecting, try again.

apply(m, 2, mean)

# [1] -0.2065699  2.3000921  5.0865389

# Great. We can see the mean of each column is roughly 0, 2, and 5 as we expected.

# Let’s say I see that negative number and realise I wanted to only look at
# positive values. Let’s see how many negative numbers each column has, using
# apply again:

apply(m, 2, function(x) length(x[x<0]))

# [1] 17  1  0

# Here we have used a simple function we defined in the call to apply, rather
# than some built in function. Note we did not specify a return value for our
# function. R will magically return the last evaluated value. The actual
# function is using subsetting to extract all the elements in x that are less
# than 0, and then counting how many are left are using length.