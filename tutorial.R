
#In this tutorial, we will go over several techniques in R used to process and display 
# Geodata

#Introduciton to cleaning datasets using the filter command

#necessary packages

library(tidyverse)
library(sf)
library(spData)
data(us_states)

#We will first start with a simple filter to select only those states that are classified as being part of the midwest

us_states %>%
  filter(REGION == 'Midwest')
#*notes: make sure to use double = and to match both the column name and value name

#Now lets filter on multiple values at once. 

#Let's start with using an "and" condition to the filter (adding & to the filter). 
#With this we will look for all states in the midwest with a popultion of greater than 30 million in 2010.

us_states %>%
filter(REGION == 'Midwest' & total_pop_10 > 30000000)

#Next we will use an or statement ( done by adding | to the filter) to select all 
#states that are from the midwest or have a population that is greater than 30 million

us_states %>%
filter(REGION == 'Midwest' | total_pop_10 > 30000000)


#finally, lets put them all together and do multiple filters. We are going to find all
#states in the Midwest that have a population greater than 30 million, all states in the midwest that have a population under 10 million, and all states in the west with an area greater than 250,000 km squared.

us_states %>%
filter(REGION == 'Midwest' & total_pop_10 > 30000000|
REGION == 'Midwest' & total_pop_10 < 10000000|
  REGION == 'West' & AREA > 250000)

#*notes: we can filter for the same thing with different conditions like we are with 
#the Midwest in the example above but we have to filter for it twice. 


# Now, lets learn to plot our filtered results

# To crate a plot, we simply need the command plot() with the st_geometry command
# embedded

# We can specifically plot our filtered results by assigning them to a new dataframe
#to do this, we will set our filter using a <-. Good coding practice is to name your 
# new object something short and precise. It is often not a good idea to use the same
# name as the object you are working with as this will overwrite your original data

# lets create a new dataframe of Midwest states and then plot them
midwest <- us_states %>%
  filter(REGION == 'Midwest')

plot(st_geometry(midwest))

# now suppose we want to plot these states on top of a map of the entire US
# we can do that by first plotting the midwest states with an expandBB command 
# in the plot function. This will center the rest of the map on our Midwest states
# and allow us to change the zoom on our map. 
# this expand command takes a vector of four numbers 

plot(st_geometry(midwest), expandBB = c(0.4, 0.1, 0.4, 0.1))

# next we will simply plot the map of the entire US

plot(st_geometry(us_states))

# In order to make our midwest states stand out, we can add some color using 
# another plot command, this time using the col and add arguments.

plot(st_geometry(midwest), col = "green", add = TRUE)



# when we put it all together the code should look like this


plot(st_geometry(midwest), expandBB = c(0.4, 0.1, 0.4, 0.1))
plot(st_geometry(us_states))
plot(st_geometry(midwest), col = "green", add = TRUE)

# with these commands you can filter and put together any kind of map highlighting
# specific regions or features