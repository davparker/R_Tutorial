# http://cran.r-project.org/web/packages/httr/vignettes/quickstart.html
# 
# *example(http)*
#     
#     httr basics
# 
# To make a request, first load httr, then call GET() with a url:
# 
browseVignettes(package = 'httr')

library(httr)
r <- GET("http://httpbin.org/get")  

# This gives you a response object. Printing a response object gives you some
# useful information: the actual url used (after any redirects), the http
# status, the file (content) type, the size, and if it's a text file, the first
# few lines of output.

r
# Response [http://httpbin.org/get]
# Status: 200
# Content-type: application/json
# {
#     "args": {}, 
#     "headers": {
#         "Accept": "*/*", 
#         "Accept-Encoding": "gzip", 
#         "Connection": "close", 
#         "Host": "httpbin.org", 
#         "User-Agent": "curl/7.19.6 Rcurl/1.95.4.1 httr/0.3", 
#         "X-Request-Id": "1eff9175-ed9f-4cc9-8db1-ed1280ca7e2a"
#     },  ...

# You can pull out important parts of the response with various helper methods,
# or dig directly into the object:

status_code(r)
# [1] 200

headers(r)
# $`access-control-allow-credentials`
# [1] "true"
# 
# $`access-control-allow-origin`
# [1] "*"
# 
# $`content-type`
# [1] "application/json"
# 
# $date
# [1] "Fri, 01 Aug 2014 21:49:42 GMT"
# 
# $server
# [1] "gunicorn/18.0"
# 
# $`content-length`
# [1] "329"
# 
# $connection
# [1] "keep-alive"
# 
# attr(,"class")
# [1] "insensitive" "list"  

I'll use httpbin.org throughout this introduction. It accepts many types of http request and returns json that describes the data that it recieved. This makes it easy to see what httr is doing.

# As well as GET(), you can also use the 
#  HEAD(), POST(), PATCH(), PUT() and DELETE() verbs. 
# You're probably most familiar with GET() and POST(): GET() is used by your
# browser when requesting a page, and POST() is (usually) used when submitting a
# form to a server. PUT(), PATCH() and DELETE() are used most often by web APIs.

# The response
# 
# The data sent back from the server consists of three parts: the status line,
# the headers and the body. The most important part of the status line is the
# http status code: it tells you whether or not the request was successful. I'll
# show you how to access that data, then how to access the body and headers.
# 
# The status code

# The status code is a three digit number that summarises whether or not the
# request was succesful (as defined by the server that you're talking to). You
# can access the status code along with a descriptive message using http_status()

r <- GET("http://httpbin.org/get")
# Get an informative description:
http_status(r)
#> $category
#> [1] "success"
#> 
#> $message
#> [1] "success: (200) OK"

# Or just access the raw code:
r$status_code
#> [1] 200

# A succesful request always returns a status of 200. Common errors are 404
# (file not found) and 403 (permission denied). If you're talking to web APIs
# you might also see 500, which is a generic failure code (and thus not very
# helpful). If you'd like to learn more, the most memorable guides are the
# https://www.flickr.com/photos/girliemac/sets/72157628409467125.

# You can automatically throw a warning or raise an error if a request did not
# succeed:
    
warn_for_status(r)
stop_for_status(r)

# I highly recommend using one of these functions whenever you're using httr
# inside a function (i.e. not interactively) to make sure you find out about
# errors as soon as possible.