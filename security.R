# http://www.r-bloggers.com/new-and-updated-r-packages-for-security-data-science/

# We’ve got some new and updated R packages that are (hopefully) helpful to
# security folks who are endeavouring to use R in their quest to find and
# prevent malicious activity. All packages now incorporate a testthat workflow
# and are fully roxygen-ized and present some best practices in R package
# development (a post on that very topic is pending).

# We’ll start with the old and work our way to the new…

# Changes to the resolv package
# I’ve updated resolv for the newest Rcpp and for a better build on linux and OS
# X systems (still no Windows compatibiity). The package also includes
# vectorized versions of the core resolv_ functions. Here’s an example:

library(devtools)
install_github('MinGW')
install_github("hrbrmstr/resolv")
install.packages('resolv')
library(resolv)
library(data.table)
library(plyr)

# Read in the Alexa top 1 million list
alexa <- fread("data/top-1m.csv") # http://s3.amazonaws.com/alexa-static/top-1m.csv.zip
str(alexa)