# http://thinktostart.wordpress.com/2014/03/10/using-google-bigquery-with-r/
# Using Google BigQuery with R
# BY JULIANHI MARCH 10, 2014 BIGQUERY DATA GOOGLE QUERY R SQL

devtools::install_github("assertthat")
devtools::install_github("bigrquery")

library(bigrquery)
project <- "decisive-circle-666" # put your projectID here
sql <- 'SELECT title,contributor_username,comment FROM[publicdata:samples.wikipedia] WHERE title CONTAINS "beer" LIMIT 100;'
mydata <- query_exec("publicdata", "samples", sql, billing = project)
mydata
