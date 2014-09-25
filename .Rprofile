# Things you might want to change
# *dp set working directory
# setwd("~/Github")
# .Rprofile tips
# http://www.r-bloggers.com/fun-with-rprofile-and-customizing-r-startup/
local({r <- getOption("repos")
      r["CRAN"] <- "http://cran.revolutionanalytics.com"
      options(repos=r)})
options(rpubs.upload.method = "internal")

.First <- function(){
  if(interactive()){
    library(utils)
    timestamp(,prefix=paste("##------ [",getwd(),"] ",sep=""))
 
  }
}
.Last <- function(){
  if(interactive()){
    hist_file <- Sys.getenv("R_HISTFILE")
    if(hist_file=="") hist_file <- "~/.RHistory"
    savehistory(hist_file)
  }
}

# auto.loads <-c("dplyr", "ggplot2")

message("* Successfully loaded .Rprofile *")
