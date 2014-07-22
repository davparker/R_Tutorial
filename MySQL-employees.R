## David Parker
## MySQL Sample Employees Database - available to download here:
## https://launchpad.net/test-db/
## Download the "full" version. Its easier to load into MySQL. Try:
## https://launchpad.net/test-db/employees-db-1/1.0.6/+download/employees_db-full-1.0.6.tar.bz2
## Documentation regarding the data/l
## https://dev.mysql.com/doc/employee/en/employees-introduction.html
require(data.table)
require(RMySQL)
# connect to database server with employees DB
emplDb <- dbConnect(MySQL(),user="employees",password="employees",host="localhost")
# send "show databases" sqlcmd and get response
respDb <- dbGetQuery(emplDb,"show databases;")
# disconnect DB
dbDisconnect(emplDb)
# [1] TRUE
head(respDb)
# Database
# 1 information_schema
# 2          employees
# 3               test
# this time connect to "employees" database on the server
emplDb <- dbConnect(MySQL(),user="employees",password="employees",db="employees",host="localhost")
# get list of tables in "employees" DB
emplTbl <- dbListTables(emplDb)
# display vector w/all table names
emplTbl
# [1] "departments"  "dept_emp"     "dept_manager" "employees"    "salaries"     "titles"
# build data dictionary; list of tbls & their fld names
for( i in 1:length(emplTbl)){
    emplDict[i] <- emplTbl[i]
    dbListFields(emplDb,emplTbl[i])
    emplDict[[emplTbl[i]]] <- dbListFields(emplDb,emplTbl[i])
    print(emplDict[i]) ; print(emplDict[[i]])
}
class(emplDict)
length(emplDict)
emplDict
# "nrow" of tables
dbGetQuery(emplDb,"select count(*) from departments")
# count(*)
# 1        9
dbGetQuery(emplDb,"select count(*) from dept_emp")
# count(*)
# 1   331603
dbGetQuery(emplDb,"select count(*) from dept_manager")
# count(*)
# 1       24
dbGetQuery(emplDb,"select count(*) from employees")
# count(*)
# 1   300024
dbGetQuery(emplDb,"select count(*) from salaries")
# count(*)
# 1  2844047
dbGetQuery(emplDb,"select count(*) from titles")
# count(*)
# 1   443308

# departments
deptQry <- dbSendQuery(emplDb,"select * from departments")
deptDt <- fetch(deptQry,n=100) 
deptDt <- as.data.table(deptDt)
dbClearResult(emplQry)
# dept_emp
emplDb <- dbConnect(MySQL(),user="employees",password="employees",db="employees",host="localhost")
dept_empQry <- dbSendQuery(emplDb,"select * from dept_emp")
dept_empDt <- fetch(dept_empQry,n=100) 
dept_empDt <- as.data.table(dept_empDt)
dbClearResult(dept_empQry)
# dept_manager
emplDb <- dbConnect(MySQL(),user="employees",password="employees",db="employees",host="localhost")
dept_mgrQry <- dbSendQuery(emplDb,"select * from dept_manager")
dept_mgrDt <- fetch(dept_mgrQry,n=100) 
dept_mgrDt <- as.data.table(dept_mgrDt)
dbClearResult(dept_mgrQry)
# employees
emplDb <- dbConnect(MySQL(),user="employees",password="employees",db="employees",host="localhost")
emplQry <- dbSendQuery(emplDb,"select * from employees")
emplDt <- fetch(emplQry,n=100) 
emplDt <- as.data.table(emplDt)
dbClearResult(emplQry)
# salaries
emplDb <- dbConnect(MySQL(),user="employees",password="employees",db="employees",host="localhost")
salQry <- dbSendQuery(emplDb,"select * from salaries")
salDt <- fetch(salQry,n=100) 
salDt <- as.data.table(salDt)
dbClearResult(salQry)
# titles
emplDb <- dbConnect(MySQL(),user="employees",password="employees",db="employees",host="localhost")
titlQry <- dbSendQuery(emplDb,"select * from employees")
titlDt <- fetch(titlQry,n=100) 
titlDt <- as.data.table(titlDt)
dbClearResult(titlQry)
#
# tables
head(deptDt)
# dept_no        dept_name
# 1:    d009 Customer Service
# 2:    d005      Development
# 3:    d002          Finance
# 4:    d003  Human Resources
# 5:    d001        Marketing
# 6:    d004       Production
head(dept_empDt)
# emp_no dept_no  from_date    to_date
# 1:  10001    d005 1986-06-26 9999-01-01
# 2:  10002    d007 1996-08-03 9999-01-01
# 3:  10003    d004 1995-12-03 9999-01-01
# 4:  10004    d004 1986-12-01 9999-01-01
# 5:  10005    d003 1989-09-12 9999-01-01
# 6:  10006    d005 1990-08-05 9999-01-01
head(dept_mgrDt)
# dept_no emp_no  from_date    to_date
# 1:    d001 110022 1985-01-01 1991-10-01
# 2:    d001 110039 1991-10-01 9999-01-01
# 3:    d002 110085 1985-01-01 1989-12-17
# 4:    d002 110114 1989-12-17 9999-01-01
# 5:    d003 110183 1985-01-01 1992-03-21
# 6:    d003 110228 1992-03-21 9999-01-01
head(emplDt)
# emp_no birth_date first_name last_name gender  hire_date
# 1  10001 1953-09-02     Georgi   Facello      M 1986-06-26
# 2  10002 1964-06-02    Bezalel    Simmel      F 1985-11-21
# 3  10003 1959-12-03      Parto   Bamford      M 1986-08-28
# 4  10004 1954-05-01  Chirstian   Koblick      M 1986-12-01
# 5  10005 1955-01-21    Kyoichi  Maliniak      M 1989-09-12
# 6  10006 1953-04-20     Anneke   Preusig      F 1989-06-02
head(salDt)
# emp_no salary  from_date    to_date
# 1:  10001  60117 1986-06-26 1987-06-26
# 2:  10001  62102 1987-06-26 1988-06-25
# 3:  10001  66074 1988-06-25 1989-06-25
# 4:  10001  66596 1989-06-25 1990-06-25
# 5:  10001  66961 1990-06-25 1991-06-25
# 6:  10001  71046 1991-06-25 1992-06-24
head(titlDt)
# emp_no birth_date first_name last_name gender  hire_date
# 1:  10001 1953-09-02     Georgi   Facello      M 1986-06-26
# 2:  10002 1964-06-02    Bezalel    Simmel      F 1985-11-21
# 3:  10003 1959-12-03      Parto   Bamford      M 1986-08-28
# 4:  10004 1954-05-01  Chirstian   Koblick      M 1986-12-01
# 5:  10005 1955-01-21    Kyoichi  Maliniak      M 1989-09-12
# 6:  10006 1953-04-20     Anneke   Preusig      F 1989-06-02
#
# housekeeping
on.exit(dbDisconnect(emplDb))
dbDisconnect(emplDb)
[1] TRUE
# 
# alternate way to build the list
# create list w/number of tables in "employee" DB
# emplDict <- vector(mode="list",length=length(emplTbl))
# name each element in list with table names to contain fieldnames
# names(emplDict) <- emplTbl
# display the table list


# employees
con <- dbConnect(MySQL(),user="employees",password="employees",db="employees",host="localhost")
rs <- dbSendQuery(con,"select * from employees")
emplDt <- NULL
while(!dbHasCompleted(rs)){
    emplDt <- rbind(emplDt,fetch(rs,n=5000))
}
emplRecs <- dbGetRowCount(rs)
dbClearResult(rs)
nrow(emplDt)
emplDt <- as.data.table(emplDt)
setkey(emplDt,"emp_no")


emplDt[order(emp_no)]
emplDt[order(-emp_no)]
class(emplDt)
names(emplDt)

dbClearResult(rs)
cat(list[1])
constr <- paste("select * from ", "employees", sep="")
constr
con <- dbConnect(MySQL(),user="employees",password="employees",db="employees",host="localhost")

constr <- paste("select * from ", emplTbl[i], sep="")
rs <- dbSendQuery(con,constr)

for(i in 1:length(emplTbl){
    
}





emplDb <- dbConnect(MySQL(),user="employees",password="employees",db="employees",host="localhost")
dbColumnInfo()