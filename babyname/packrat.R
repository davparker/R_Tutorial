# packrat usage
# http://rstudio.github.io/packrat/walkthrough.html
packrat::init("~/GitHub/R Tutorial/babyname")
packrat::snapshot()
packrat::packify()
packrat::status()
packrat::restore()
