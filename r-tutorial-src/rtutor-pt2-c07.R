###########################################################
#
# Copyright (C) 2012 by Chi Yau
# All rights reserved
#
# http://www.r-tutor.com
#


################################
# c07-s01
duration = faithful$eruptions
range(duration)

breaks = seq(1.5, 5.5, by=0.5) 
breaks

duration.cut = cut(duration, breaks, right=FALSE)
duration.freq = table(duration.cut)
cbind(duration.freq)


# Ex 1
waiting = faithful$waiting
range(waiting)

breaks = seq(40, 100, by=5)
breaks

waiting.cut = cut(waiting, breaks, right=FALSE)
waiting.freq = table(waiting.cut)
cbind(waiting.freq)


# Ex 2
duration.freq.max = max(duration.freq)
duration.freq.max

x = which(duration.freq == duration.freq.max)
names(x)


# Ex 3
duration = faithful$eruptions

breaks = seq(1.5, 5.5, by=0.5) 
h = hist(duration, breaks=breaks, 
          right=FALSE, plot=FALSE)
duration.freq = h$counts

h = hist(duration, right=FALSE, plot=FALSE)
duration.freq = h$counts
duration.freq

len = length(h$breaks)
a = h$breaks[1:len-1]     # left endpoints
b = h$breaks[2:len]       # right endpoints
labels = paste("[", a, ", ", b, ")", sep="")

names(duration.freq) = labels
cbind(duration.freq)



################################
# c07-s02
duration = faithful$eruptions
hist(duration, right=FALSE)

colors = c("red", "yellow", "green", "violet", "orange", "blue", "pink", "cyan") 
hist(duration, right=FALSE, 
          col=colors, 
          main="Old Faithful Eruptions",
          xlab="Duration minutes")

# Ex
waiting = faithful$waiting
hist(waiting, right=FALSE)


################################
# c07-s03
duration = faithful$eruptions
breaks = seq(1.5, 5.5, by=0.5) 
duration.cut = cut(duration, breaks, right=FALSE)
duration.freq = table(duration.cut)

duration.relfreq = duration.freq / nrow(faithful)
old = options(digits=1)
duration.relfreq
options(old)

duration.percentage = duration.relfreq * 100
old = options(digits=3)
cbind(duration.freq, duration.percentage)
options(old)

# Ex
waiting = faithful$waiting
breaks = seq(40, 100, by=5) 
waiting.cut = cut(waiting, breaks, right=FALSE)
waiting.freq = table(waiting.cut)

waiting.relfreq = waiting.freq / nrow(faithful)
waiting.percentage = 100 * waiting.relfreq

old = options(digits=1)
cbind(waiting.freq, waiting.percentage)
options(old)


################################
# c07-s04
duration = faithful$eruptions
breaks = seq(1.5, 5.5, by=0.5) 
duration.cut = cut(duration, breaks, right=FALSE)
duration.freq = table(duration.cut)
duration.cumfreq = cumsum(duration.freq)
cbind(duration.cumfreq)

# Ex
waiting = faithful$waiting
breaks = seq(40, 100, by=5) 
waiting.cut = cut(waiting, breaks, right=FALSE)
waiting.freq = table(waiting.cut)
waiting.cumfreq = cumsum(waiting.freq)
cbind(waiting.cumfreq)


################################
# c07-s05
duration = faithful$eruptions
breaks = seq(1.5, 5.5, by=0.5) 
duration.cut = cut(duration, breaks, right=FALSE)
duration.freq = table(duration.cut)
cumfreq0 = c(0, cumsum(duration.freq))
plot(breaks, cumfreq0,
          main="Old Faithful Eruptions",
          xlab="Duration minutes",
          ylab="Cumulative eruptions")
lines(breaks, cumfreq0)

# Ex
waiting = faithful$waiting
breaks = seq(40, 100, by=5) 
waiting.cut = cut(waiting, breaks, right=FALSE)
waiting.freq = table(waiting.cut)
waiting.cumfreq0 = c(0, cumsum(waiting.cumfreq))
plot(breaks, waiting.cumfreq0,
          main="Old Faithful Eruptions",
          xlab="Waiting minutes",
          ylab="Cumulative eruptions")
lines(breaks, waiting.cumfreq0)


################################
# c07-s06
duration = faithful$eruptions
breaks = seq(1.5, 5.5, by=0.5) 
duration.cut = cut(duration, breaks, right=FALSE)
duration.freq = table(duration.cut)
duration.cumfreq = cumsum(duration.freq)

duration.cumrelfreq = duration.cumfreq / nrow(faithful)
duration.cumpercent = 100 * duration.cumrelfreq

old = options(digits=3)
cbind(duration.cumfreq, duration.cumpercent)
options(old)

# Ex
waiting = faithful$waiting
breaks = seq(40, 100, by=5) 
waiting.cut = cut(waiting, breaks, right=FALSE)
waiting.freq = table(waiting.cut)
waiting.cumfreq = cumsum(waiting.freq)

waiting.cumrelfreq = waiting.cumfreq / nrow(faithful)
waiting.cumpercent = 100 * waiting.cumrelfreq

old = options(digits=3)
cbind(waiting.cumfreq, waiting.cumpercent)
options(old)



################################
# c07-s07
duration = faithful$eruptions
breaks = seq(1.5, 5.5, by=0.5) 
duration.cut = cut(duration, breaks, right=FALSE)
duration.freq = table(duration.cut)
duration.cumfreq = cumsum(duration.freq)
duration.cumrelfreq = duration.cumfreq / nrow(faithful)

cumrelfreq0 = c(0, duration.cumrelfreq)
plot(breaks, cumrelfreq0,
  main="Old Faithful Eruptions",  # main title
  xlab="Duration minutes", 
  ylab="Cumulative eruption proportion")
lines(breaks, cumrelfreq0)        # join the points

Fn = ecdf(duration)              
plot(Fn, main="Old Faithful Eruptions",   
          xlab="Duration minutes",         
          ylab="Cumulative eruption proportion") 

# Ex
waiting = faithful$waiting
breaks = seq(40, 100, by=5) 
waiting.cut = cut(waiting, breaks, right=FALSE)
waiting.freq = table(waiting.cut)
waiting.cumfreq = cumsum(waiting.freq)
waiting.cumrelfreq = waiting.cumfreq / nrow(faithful)

cumrelfreq0 = c(0, waiting.cumrelfreq)
plot(breaks, cumrelfreq0,
          main="Old Faithful Eruptions",  # main title
          xlab="Waiting minutes", 
          ylab="Cumulative eruption proportion")
lines(breaks, cumrelfreq0)        # join the points


################################
# c07-s08
duration = faithful$eruptions    # eruption durations
waiting = faithful$waiting       # waiting interval
plot(duration, waiting,          # plot the variables
          xlab="Eruption duration",      # x-axis label
          ylab="Time waited")    
abline(lm(waiting ~ duration))


################################
# c07-s09
stem(faithful$eruptions)

#Ex
stem(faithful$waiting)


################################
# figures

# numerical-data0x
png(file="numerical-data0x.png", width=450, height=450)
duration = faithful$eruptions
hist(duration, right=FALSE)
dev.off()

# numerical-data0xz
png(file="numerical-data0xz.png", width=450, height=450)
waiting = faithful$waiting
hist(waiting, right=FALSE)
dev.off()

# numerical-data1x
png(file="numerical-data1x.png", width=450, height=450)
duration = faithful$eruptions
colors = c("red", "yellow", "green", "violet", "orange", "blue", "pink", "cyan") 
hist(duration, right=FALSE, 
          col=colors, 
          main="Old Faithful Eruptions",
          xlab="Duration minutes")
dev.off()

# numerical-data3x
png(file="numerical-data3x.png", width=450, height=450)
duration = faithful$eruptions
breaks = seq(1.5, 5.5, by=0.5) 
duration.cut = cut(duration, breaks, right=FALSE)
duration.freq = table(duration.cut)
duration.cumfreq = cumsum(duration.freq)
cumfreq0 = c(0, duration.cumfreq)
plot(breaks, cumfreq0,
          main="Old Faithful Eruptions",
          xlab="Duration minutes",
          ylab="Cumulative eruptions")
lines(breaks, cumfreq0)
dev.off()

# numerical-data3xz
png(file="numerical-data3xz.png", width=450, height=450)
waiting = faithful$waiting
breaks = seq(40, 100, by=5) 
waiting.cut = cut(waiting, breaks, right=FALSE)
waiting.freq = table(waiting.cut)
waiting.cumfreq = cumsum(waiting.freq)
cumfreq0 = c(0, waiting.cumfreq)
plot(breaks, cumfreq0,
          main="Old Faithful Eruptions",
          xlab="Waiting minutes",
          ylab="Cumulative eruptions")
lines(breaks, cumfreq0)
dev.off()

# numerical-data5x
png(file="numerical-data5x.png", width=450, height=450)
duration = faithful$eruptions
breaks = seq(1.5, 5.5, by=0.5) 
duration.cut = cut(duration, breaks, right=FALSE)
duration.freq = table(duration.cut)
duration.cumfreq = cumsum(duration.freq)
duration.cumrelfreq = duration.cumfreq / nrow(faithful)
cumrelfreq0 = c(0, duration.cumrelfreq)
plot(breaks, cumrelfreq0,
          main="Old Faithful Eruptions",  # main title
          xlab="Duration minutes", 
          ylab="Cumulative eruption proportion")
lines(breaks, cumrelfreq0)        # join the points
dev.off()

# numerical-data5xz
png(file="numerical-data5xz.png", width=450, height=450)
waiting = faithful$waiting
breaks = seq(40, 100, by=5) 
waiting.cut = cut(waiting, breaks, right=FALSE)
waiting.freq = table(waiting.cut)
waiting.cumfreq = cumsum(waiting.freq)
waiting.cumrelfreq = waiting.cumfreq / nrow(faithful)
cumrelfreq0 = c(0, waiting.cumrelfreq)
plot(breaks, cumrelfreq0,
          main="Old Faithful Eruptions",  # main title
          xlab="Waiting minutes", 
          ylab="Cumulative eruption proportion")
lines(breaks, cumrelfreq0)        # join the points
dev.off()

# numerical-data6x
png(file="numerical-data6x.png", width=450, height=450)
duration = faithful$eruptions
Fn = ecdf(duration)              
plot(Fn, main="Old Faithful Eruptions",   
          xlab="Duration minutes",         
          ylab="Cumulative eruption proportion") 
dev.off()

# numerical-data7x
png(file="numerical-data7x.png", width=450, height=450)
duration = faithful$eruptions    # eruption durations
waiting = faithful$waiting       # waiting interval
plot(duration, waiting,          # plot the variables
          xlab="Eruption duration",      # x-axis label
          ylab="Time waited")    
dev.off()

# numerical-data8x
png(file="numerical-data8x.png", width=450, height=450)
duration = faithful$eruptions    # eruption durations
waiting = faithful$waiting       # waiting interval
plot(duration, waiting,          # plot the variables
          xlab="Eruption duration",      # x-axis label
          ylab="Time waited")    
abline(lm(waiting ~ duration))
dev.off()


