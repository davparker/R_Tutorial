# http://thinktostart.wordpress.com/2014/03/10/using-google-bigquery-with-r/
# Using Google BigQuery with R
# BY JULIANHI MARCH 10, 2014 BIGQUERY DATA GOOGLE QUERY R SQL
library("devtools")
devtools::install_github("hadley/assertthat")
devtools::install_github("hadley/bigrquery")

#  https://cloud.google.com/console
library(bigrquery)
project <- "warm-classifier-725" # put your project ID here
sql <- "SELECT year, month, day, weight_pounds FROM [publicdata:samples.natality] LIMIT 5"
query_exec(sql, project = project)
