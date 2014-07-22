# MYSQL_HOME=C:\UniServerZ\core\mysql\bin
# R_LIBS=C:\Program Files\R\R-3.1.0\library

# Now restart R if you have already opened it and install RMySQL from source:
# install.packages("RMySQL", type = "source")
require(RMySQL)

# UCSC Genome database
# http://genome.ucsc.edu/
# http://genome.ucsc.edu/goldenpath/help/mysql.html
# Connect to the MySQL server using the command:
# mysql --user=genome --host=genome-mysql.cse.ucsc.edu -A
# Using the MySQL Server with our Utilities
# add the following specifications to your $HOME/.hg.conf file
# db.host=genome-mysql.cse.ucsc.edu
# db.user=genomep
# db.password=password
# central.db=hgcentral

# connecting to genome mysql database
ucsDb <- dbConnect(MySQL(),user="genome",host="genome-mysql.cse.ucsc.edu")
result <- dbGetQuery(ucsDb,"show databases;") ; dbDisconnect(ucsDb)
head(result)
# [1] TRUE
head(result)
# Database
# 1 information_schema
# 2            ailMel1
# 3            allMis1
# 4            anoCar1
# 5            anoCar2
# 6            anoGam1
nrow(result)
# [1] 191

# connect to db hg19 and list its tables
hg19 <- dbConnect(MySQL(),user="genome",db="hg19",host="genome-mysql.cse.ucsc.edu")
hg19Tbls <- dbListTables(hg19)
length(hg19Tbls)
hg19Tbls[1:15]
# [1] "HInv"         "HInvGeneMrna" "acembly"      "acemblyClass" "acemblyPep"
hg19Tbls[grepl("affyU",hg19Tbls)]
# [1] "affyU133"      "affyU133Plus2" "affyU95"

# get dim for specific tbl
hg19Flds <- dbListFields(hg19,"affyU133Plus2") ; hg19Flds
# [1] "bin"         "matches"     "misMatches"  "repMatches"  "nCount"      "qNumInsert"  "qBaseInsert" "tNumInsert"  "tBaseInsert"
# [10] "strand"      "qName"       "qSize"       "qStart"      "qEnd"        "tName"       "tSize"       "tStart"      "tEnd"       
# [19] "blockCount"  "blockSizes"  "qStarts"     "tStarts"    

# "nrow" of hg19
dbGetQuery(hg19,"select count(*) from affyU133Plus2")
#  count(*)
# 1    58463

# read from tbl
affyData <- dbReadTable(hg19,"affyU133Plus2")
head(affyData)
# bin matches misMatches repMatches nCount qNumInsert qBaseInsert tNumInsert tBaseInsert strand        qName qSize qStart qEnd
# 1 585     530          4          0     23          3          41          3         898      -  225995_x_at   637      5  603
# 2 585    3355         17          0    109          9          67          9       11621      -  225035_x_at  3635      0 3548
# 3 585    4156         14          0     83         16          18          2          93      -  226340_x_at  4318      3 4274
# 4 585    4667          9          0     68         21          42          3        5743      - 1557034_s_at  4834     48 4834
# 5 585    5180         14          0    167         10          38          1          29      -    231811_at  5399      0 5399
# 6 585     468          5          0     14          0           0          0           0      -    236841_at   487      0  487
# tName     tSize tStart  tEnd blockCount                                                                 blockSizes
# 1  chr1 249250621  14361 15816          5                                                          93,144,229,70,21,
# 2  chr1 249250621  14381 29483         17              73,375,71,165,303,360,198,661,201,1,260,250,74,73,98,155,163,

# select a subset
query <- dbSendQuery(hg19,"select * from affyU133Plus2 where misMatches between 1 and 3")
affyMis <- fetch(query) ; quantile(affyMis$misMatches) 
# 0%  25%  50%  75% 100% 
# 1    1    2    2    3

# fetch only 10 rows (limit query to top n rows)
affyMisSmall <- fetch(query,n=10) ; dbClearResult(query)
# [1] TRUE
dim(affyMisSmall)
[1] 10 22

# remember to disconnect when done!
dbDisconnect(hg19)
# [1] TRUE

# Further Resources
# RMySQL Documentation
# http://cran.r-project.org/web/packages/RMySQL/RMySQL.pdf
# MySQL Commands
# http://www.pantz.org/software/mysql/mysqlcommands.html
# Blog summarizing commands
# http://www.r-bloggers.com/mysql-and-r/