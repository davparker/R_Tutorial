#https://www.r-bloggers.com/using-apply-sapply-lapply-in-r/
#Using apply, sapply, lapply in R

# We have three columns, one for each method, and lets say 30 rows, representing
# 30 different subsets that the three methods were applied to.
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

apply(m, 2, function(x) length(x[x < 0]))

# [1] 17  1  0

# Here we have used a simple function we defined in the call to apply, rather
# than some built in function. Note we did not specify a return value for our
# function. R will magically return the last evaluated value. The actual
# function is using subsetting to extract all the elements in x that are less
# than 0, and then counting how many are left are using length.

# The function takes one argument, which I have arbitrarily called x. In this
# case x will be a single column of the matrix. Is it a 1 column matrix or a
# just a vector? Let’s have a look:

apply(m, 2, function(x) is.matrix(x))
# [1] FALSE FALSE FALSE

# Not a matrix. Here the function definition is not required, we could instead
# just pass the is.matrix function, as it only takes one argument and has
# already been wrapped up in a function for us. Let’s check they are vectors as
# we might expect.

apply(m, 2, function(x) is.vector(x))
# [1] TRUE TRUE TRUE

# Why then did we need to wrap up our length function? When we want to define
# our own handling function for apply, we must at a minimum give a name to the
# incoming data, so we can use it in our function.

apply(m, 2, length(x[x<0]))
# Error in match.fun(FUN) : object ‘x’ not found

# We are referring to some value x in the function, but R does not know where
# that is and so gives us an error. There are other forces at play here, but for
# simplicity just remember to wrap any code up in a function. For example, let’s
# look at the mean value of only the positive values:

apply(m, 2, function(x) mean(x[x>0]))
# [1] 0.7894574 2.3809189 5.0865389

# Using sapply and lapply 
# These two functions work in a similar way, traversing over a set of data like a
# list or vector, and calling the specified function for each item.

# Here we will use sapply, which works on a list or vector of data. 

sapply(1:3, function(x) x^2)
# [1] 1 4 9

# lapply is very similar, however it will return a list rather than a vector:

lapply(1:3, function(x) x^2)
# [[1]]
# [1] 1
# 
# [[2]]
# [1] 4
# 
# [[3]]
# [1] 9

# Passing simplify=FALSE to sapply will also give you a list:

sapply(1:3, function(x) x^2, simplify = FALSE)
# [[1]]
# [1] 1
# 
# [[2]]
# [1] 4
# 
# [[3]]
# [1] 9

# And you can use unlist with lapply to get a vector.

unlist(lapply(1:3, function(x) x^2))
# [1] 1 4 9

# Dirty Deeds

# Anyway, a cheap trick is to pass sapply a vector of indexes and write your
# function making some assumptions about the structure of the underlying data.
# Let’s look at our mean example again:

sapply(1:3, function(x) mean(m[,x]))
# [1] -0.2065699  2.3000921  5.0865389

# We pass the column indexes (1,2,3) to our function, which assumes some
# variable m has our data. Fine for quickies but not very nice, and will likely
# turn into a maintainability bomb down the line.

# We can neaten things up a bit by passing our data in an argument to our
# function, and using the … special argument which all the apply functions have
# for passing extra arguments:

sapply(1:3, function(x, y) mean(y[ ,x]), y=m)

# This time, our function has 2 arguments, x and y. The x variable will be as it
# was before, whatever sapply is currently going through. The y variable we will
# pass using the optional arguments to sapply.
