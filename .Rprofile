# Things you might want to change
# *dp set working directory
# setwd("~/Github")
# .Rprofile tips
# http://www.r-bloggers.com/fun-with-rprofile-and-customizing-r-startup/
local({r <- getOption("repos")
      r["CRAN"] <- "http://cran.revolutionanalytics.com"
      options(repos=r)})
options(stringsAsFactors=FALSE)
options(max.print=100)
options(scipen=10)
options(width=80)
# options(prompt="> ")
# options(continue="... ")
options(rpubs.upload.method = "internal")
q <- function (save="no", ...) {
  quit(save=save, ...)
}

# This snippet allows you to tab-complete package names for use in "library()" or "require()" calls. 
# Credit for this one goes to @mikelove.
utils::rc.settings(ipck=TRUE)

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

# Enables the colorized output from R (provided by the colorout package) on appropriate consoles.
if(Sys.getenv("TERM") == "xterm-256color")
  library("colorout")

sshhh <- function(a.package){
  suppressWarnings(suppressPackageStartupMessages(
    library(a.package, character.only=TRUE)))
}
auto.loads <-c("dplyr", "ggplot2")

if(interactive()){
  invisible(sapply(auto.loads, sshhh))
}

.env <- new.env()
attach(.env)

.env$unrowname <- function(x) {
  rownames(x) <- NULL
  x
}
 
.env$unfactor <- function(df){
  id <- sapply(df, is.factor)
  df[id] <- lapply(df[id], as.character)
  df
}

message("n*** Successfully loaded .Rprofile ***n")
