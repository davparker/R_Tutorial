####################
# Module 7 - Lab
# 7/1/2014
####################

## Part A

# Bike Lanes Dataset: BikeBaltimore is the Department of Transportation's bike program.
# https://data.baltimorecity.gov/Transportation/Bike-Lanes/xzfj-gyms
# Download as a CSV (like the Monuments dataset) in your current working directory

# 1. Using tapply():
# 	(a) Which project category has the longest average bike lane?
#	(b) What was the average bike lane length per year that they were installed?

# 2. (a) Numerically [hint: `quantile()`] and (b) graphically [hint: `hist()` or `plot(density())`]
#	 describe the distribution of bike "lane" lengths.

# 3. Then describe the bike length distributions after stratifying by 
#		i) type then ii) number of lanes [hint: tapply, boxplot]


## Part B

# Download the CSV: http://biostat.jhsph.edu/~ajaffe/files/indicatordeadkids35.csv
# Via: http://www.gapminder.org/data/
# Definition of indicator: How many children the average couple had that die before the age 35.

# 4. Plot the distribution of average country's count across all years.

# 5.(a) How many entries are less than 1?
#   (b) Which array indices do they correspond to? [hint: `arr.ind` argument in `which()`]

# 6. Plot the count for each country across year in a line plot [hint: `matplot()`]
