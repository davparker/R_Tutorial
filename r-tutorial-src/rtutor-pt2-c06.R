###########################################################
#
# Copyright (C) 2012 by Chi Yau
# All rights reserved
#
# http://www.r-tutor.com
#


################################
# c06
library(MASS)
head(painters)


################################
# c06-s01
school = painters$School
school.freq = table(school)

school.freq

cbind(school.freq)

# Ex 1
comp = painters$Composition
comp.freq = table(comp)

comp.freq

cbind(comp.freq)

# Ex 2
school = painters$School
school.freq = table(school)
school.freq.max = max(school.freq)
school.freq.max

L = school.freq == school.freq.max
x = school.freq[L]

x = which(school.freq == school.freq.max)
names(x)

y = which.max(school.freq)
names(y)


################################
# c06-s02
school = painters$School
school.freq = table(school)
school.relfreq = school.freq / nrow(painters)

old = options(digits=1)
school.relfreq
options(old)

old = options(digits=3)
cbind(school.relfreq*100)
options(old)

# Ex
comp = painters$Composition
comp.freq = table(comp)
comp.relfreq = comp.freq / nrow(painters)

old = options(digits=1)
comp.relfreq
options(old)

old = options(digits=3)
cbind(comp.relfreq*100)
options(old)


################################
# c06-s03
school = painters$School
school.freq = table(school)
barplot(school.freq) 

colors = c("red", "yellow", "green", "violet", "orange", "blue", "pink", "cyan") 
barplot(school.freq, col=colors)

# Ex
comp = painters$Composition
comp.freq = table(comp)
colors = c("red", "yellow", "green", "violet", "orange", "blue", "pink", "cyan") 
barplot(comp.freq, col=colors)


################################
# c06-s04
school = painters$School
school.freq = table(school)
pie(school.freq) 

colors = c("red", "yellow", "green", "violet", "orange", "blue", "pink", "cyan") 
pie(school.freq, col=colors)

# Ex
comp = painters$Composition
comp.freq = table(comp)
colors = c("red", "yellow", "green", "violet", "orange", "blue", "pink", "cyan") 
pie(comp.freq, col=colors)


################################
# c06-s05
school = painters$School
c_school = school == "C"
c_painters = painters[c_school, ]
mean(c_painters$Composition)

tapply(painters$Composition, painters$School, mean)

# Ex 1
comp = painters$Composition
school = painters$School

comp.school.max = tapply(comp, school, max)
comp.school.max

comp.max.all = max(comp)
comp.max.all

x = which(comp.school.max == comp.max.all)
names(x)

# Ex 2
colour = painters$Colour
x = which(colour >= 14)
length(x)/nrow(painters)



################################
# figures

# categorical-data1x
png(file="categorical-data1x.png", width=450, height=450)
barplot(table(painters$School))
dev.off()

# categorical-data1xz
png(file="categorical-data1xz.png", width=450, height=450)
barplot(table(painters$Composition))
dev.off()

# categorical-data2x
png(file="categorical-data2x.png", width=450, height=450)
colors = c("red", "yellow", "green", "violet", "orange", "blue", "pink", "cyan") 
barplot(table(painters$School), col=colors)
dev.off()

# categorical-data3x
png(file="categorical-data3x.png", width=450, height=450)
pie(table(painters$School))
dev.off()

# categorical-data3xz
png(file="categorical-data3xz.png", width=450, height=450)
pie(table(painters$Composition))
dev.off()

# categorical-data4x
png(file="categorical-data4x.png", width=450, height=450)
colors = c("red", "yellow", "green", "violet", "orange", "blue", "pink", "cyan") 
pie(table(painters$School), col=colors)
dev.off()




