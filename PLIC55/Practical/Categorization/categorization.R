###
### Speech Perception Practical Session
### Code Skeleton
###

# install and load packages
install.packages("RCurl") # for getting files from the web
library(RCurl)
library(tidyverse)
library(ggplot2)

# downlad data file
dataURL = "http://www.davewkush.github.io/PLIC55/Practical/Categorization/categorization.csv"
download.file(dataURL, destfile = "categorization.csv")

# load your data into R as a dataframe/tibble
# your data file will be in .csv format, so we can use the 
# function read_csv()
# we'll call the data frame that we read in "categ"

categ = read_csv()

# we can check the dimensions of the dataframe (generally good practice)
dim(categ) # 600 rows, 4 columns


# Let's see what the data frame looks like
# you can use view() to do this

view(categ)

## We see that there are 4 columns: "subjectNumber", "response", "VOT", "RT"
## "VOT" gives you the VOT for the stimulus played
## "response" tells you if the participant categorized the stimulus as /t/ or /d/
## RT tells you how long the participant took to make their decision


# Let's just refresh our memories about some R basics 
# "vectors" are sequences/arrays of values (numbers, strings, ...)
# columns in a data frame are just vectors
# For example, if I wanted to see all the RTs in the dataframe I could type:

categ$RT     # use the $ to specify a column in a dataframe


# You can apply functions to vectors, for example, I could get the average
# reaction time across all trials in the experiment, like so:

mean(categ$RT) # mean() is the function, "categ$RT" is the argument


# suppose we wanted to plot the results of our categorization experiment
# what's our independent variable?
# what's our dependent variable?

# we need to calculate a value for our dependent variable 
# right now "response" just gives us "T" or "D", but we can't take the average
# of letters. We need to CREATE A NEW COLUMN that we can use to calculate %/t/

# one way to create a new column is using the $ operator
# we can create a column called "percentT" and just fill it with empty
# values for now

categ$percentT = NA  # NA == 'not applicable', R interprets NA as no value

# now we want our column to encode whether someone picked T or D, but as a number
# let's use 1 to mean "yes, picked T", 0 to mean "no, picked D"
# we can use an ifelse() statement to assign 1 or 0 to the column depending on
# what's in the "response" column
# syntax of ifelse(): ifelse(CONDITION,x,y), 
# outputs 'x' if CONDITION is TRUE 
# outputs 'y' if CONDITION is FALSE

categ$percentT = ifelse()   
                               
# you can take the mean of our column to see how often people chose T across
# the whole experiment

mean(categ$percentT)

# but, just taking the mean of all trials doesn't tell us what we care about,
# which is how the probability of choosing T changes as our independent variable
# changes. 

# To see that, we need to calculate the %/t/ for *each VOT value*
# luckily, there's a function, group_by(), which can help separate out different
# subsets of our data, according to the values in one or more column

# here's one way to use group_by() to do what we want:
# create a new dataframe broken up into groups by "VOT" 

data.groupVOT = group_by(categ,VOT) # first argument is your "input" dataframe
                                       # second argument is your grouping column

# once we've got a grouped data frame, we can create a summary of various 
# things using the summarize() function. summarize spits out new dataframes
# you have to tell summarize():
#           - what dataframe you're using as input
#           - what you want to summarize

summarize(data.groupVOT, meanPercentT = mean(percentT))

# that does what we want, but we need to save that summary so we can use it 
# in our plot, so lets save it as a datframe called categ.means

categ.means = summarize(data.groupVOT, meanPercentT = mean(percentT))

# now let's say we want to plot it
# we'll be using the package ggplot2 to do our plotting in this course
# all plots start out with a function ggplot(), where you need to specify:
#         - the dataframe that contains what you want to plot
#         - "aesthetic parameters", in aes(), in this case what values you want 
#           to use as x and y in your plot

ggplot(data = categ.means, aes(x=VOT,y=meanPercentT))

# notice if we run that, we create an empty plot.
# we need to tell ggplot HOW we want it to plot the values
# we do this by adding "layers" or other specifications using the "+" operator
# there are different functions you can add, plot styles are all "geoms"
# so if we want to plot points, we can use "geom_point()"

ggplot(data = categ.means, aes(x=VOT,y=meanPercentT))+geom_point()

# if we want to add a line, we can add geom_line()

ggplot(data = categ.means, aes(x=VOT,y=meanPercentT))+geom_point()+geom_line()

# if we want to add a title we can use labs() and then specify what title we want

ggplot(data = categ.means, aes(x=VOT,y=meanPercentT))+
                                          geom_point()+
                                          geom_line()+
                                          labs(title="T/D Identification Curve")





