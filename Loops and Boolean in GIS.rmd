#### Daniel Crownover
#### R script to implement loop
#### for GEOG 215, Assignment #4
####

#### The files contain the number of cellular devices that
#### detected and the number that stayed at home for the full
#### 24 hour period over a number of days in North Carolina
#### (by block group of residence)

## DEV = total number of COMP

## Load required libraries
library(tidyverse)
library(ggplot2)
## Get a list of the files
safegraph_files <- list.files("../Data",
                              full.names = TRUE)

## list of files in our folder--> full directory name
safegraph_files
## Create holder for data-->tibble= tidyvrs data frame
data_holder <- tibble(DATE = rep(NA, length(safegraph_files)),
                      DEV = rep(NA, length(safegraph_files)),
                      COMPHOME = rep(NA, length(safegraph_files)))

## Start loop here
## Use i for the iterator!
## Iterate from 1 to the number of files in Data
##   see loop exercise



## this for loop goes through our(perfect) data like this: Reads through first dataset ([1]), runs all comands(in for loop) for that data set
##The loop then runs through data set[2], runs all commands on data set[2]; It iterates--> 28 times ect.
for (i in 1:length(safegraph_files)) {

  ## Read file here using read_csv()--> reading in singular file that we are working on -- all commands in loop for first time[1]
  dat <- read_csv(safegraph_files[i])

  ## Get the date from the first row and put in holder --> reading through each and finding date
  data_holder$DATE[i] <- dat$DATE[1] %>% as.character()
  
  ## Get the sum of devices (DEV) and put in holder
  data_holder$DEV[i] <-  sum(dat$DEV)
  
  ## Get the sum of devices that stayed completely home (COMPHOME)
  ## and put in holder
data_holder$COMPHOME[i] <- sum(dat$COMPHOME)

## This is the end of the loop...
## Make sure to end the loop with a bracket!  
} ## end for loop

    
## Convert DATE column to date format
data_holder$DATE <- as.Date(data_holder$DATE)

## For extra credit, use ggplot to create a line plot of the
## PERCENT OF DEVICES STAYING COMPLETELY HOME over the
## time series for North Carolina...


## vectorized function-- able to change each row in data frame at same time

##this is a vectorized function- we are creating a percent of COMPH/DEV*100 and then plotting for each point in the line graph
data_holder$percentC <- data_holder$COMPHOME/data_holder$DEV * 100

##and write out as a
## .png file using ggsave()

## here is the linegraph function--> below we are plotting each COMPHOME percent point per cooresponding Date.
 ggplot(data = data_holder, aes(x = DATE, y = percentC)) +
  geom_line(color = "red",) +
  labs(x = "Date(Month,Day)", y = "Percent of Devices Stayed at Home",
       title = "Percent of Devices that Stayed at Home")

 ## Below is the ggplot save command- we are saving it to the working directory
ggsave("linegraph.png")
