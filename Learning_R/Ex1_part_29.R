# Learn R channel Youtube
# https://www.youtube.com/watch?v=qibju4XJZ_U
setwd("~/GitHub/R Tutorial/Learning_R")
data(USArrests)
head(USArrests)
## Part 29
# From USArrrests select 25% of States with least Murders with:
# 1. Row positions changed
# 2. Row positions unchanged

## 1.
# two steps
order(USArrests[,1])
# returns vector of order of Murders ascending
USArrests[order(USArrests[,1]),] -> newdf
# created newdf ordered
newdf[1:round(nrow(USArrests)*.25),]
# lists the results of least 25%
#
# one step - no newdf
USArrests[order(USArrests[,1]),][1:round(nrow(USArrests)*.25),]

## 2.
quantile(USArrests[,1])
# takes top 0, 25, 50, 75, 100 pecentages
quantile(USArrests[,1])[2]
# lists 2nd quantile, 25%
which(USArrests[,1] < quantile(USArrests[,1])[2])
# returns vector of indexed rows satisfying query
USArrests[which(USArrests[,1] < quantile(USArrests[,1])[2]),]
# list results

## Part 30
# From USArrrests select states with more than 75% UrbanPop
# -or- Rape more than 20
which(USArrests[, 3] > 75 | USArrests[, 4] > 20)
# reurns a vector of indices satisfying criteria
USArrests[which(USArrests[, 3] > 75 | USArrests[, 4] > 20), ]
# list results
# From USArrrests select states with more than 75% UrbanPop
# -and- Rape more than 20
USArrests[which(USArrests[, 3] > 75 & USArrests[, 4] > 20), ]
# list results

## Part 31
# From USArrrests 
# Randomly select 75% of data as "trainingData"
# and the remaining 25% as "testData"
set.seed(100)
sample(1:nrow(USArrests), 0.75 * nrow(USArrests)) -> trainingVec
# creates a sample vector with random 75% of indices
trainingVec
# list vector
(1:nrow(USArrests))[-traningVec] -> testVec
# creates the inverse vector
testVec
# list vector, no results match trainingVec
USArrests[trainingVec, ] ->  trainingData
# creates tainingData
USArrests[testVec, ] ->  testData
# creates tainingData
trainingData
testData
