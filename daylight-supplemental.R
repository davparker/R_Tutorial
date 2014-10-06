library("RgoogleMaps")
library("mapproj")
library("rjson")
library("ggmap")

location <- "Bryan, TX"
timezone <- "America/Chicago"
location <- "Homer, AL"
timezone <- "US/Alaska"
location <- "Nome, AL"
datereq  <- "2014-09-01"
timzone  <- "Alaska, Alaska Time Zone"
coord    <- geocode(location)
coord
lon <- as.numeric(coord[1])
lat <- as.numeric(coord[2])
daylight(lat, lon, location, datereq, 365, timezone)
daylight(lat, lon, location, datereq, 365, tz="America/Chicago")
lon
lat
location
timezone
