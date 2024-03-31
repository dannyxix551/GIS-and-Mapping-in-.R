####
#### Assignment #3, GEOG215
#### Introduction to Spatial Data Science
####
#### R code for data analysis and processing
####   Reads in data, makes some calculations,
####   and writes out data for presentation
####
#### Daniel Crownover
#### 07/11/23
####

########################                       
###  Load libraries  ###
########################

library(tidyverse)

######################      
###  Read in data  ###
######################   

# Read in covid and population data
nc.cvd.pop <- read_csv("../Output/NC_ZIP_COVID_POP_2020-09-23.csv")



# Read in reported Zip Code to Spatial Data Zip Code 
#  crosswalk table
nc.xwalk <- read_csv("../Data/tabular/ZIP_reportdata_map_crosswalk.csv")


######################
###  Process data  ###
###################### 

# Merge/join the covid/pop data with crosswalk table
nc.cvd.pop <- merge(nc.cvd.pop, 
                    nc.xwalk, 
                    by = "ZIPCODE")




## below there are duplicated zip codes -- we are combining duplicated zip codes with the command sumarize_all, which summarizes all the columns. group_by(ZIPCODEmap) %>%) command grouped the observation by zip codes through columns 2-5
## it happened in the order ---> column definition(2-5), group by observation, summarize colomns--> remove N/A values
nc.zip.cvd.pop.agg <- nc.cvd.pop[,2:5] %>% 
  group_by(ZIPCODEmap) %>%
  summarize_all(sum, na.rm = TRUE)




# Calculate Cases and Deaths per 1000 people
nc.zip.cvd.pop.agg$CASERATE <- 1000 * nc.zip.cvd.pop.agg$CASES / nc.zip.cvd.pop.agg$POP
nc.zip.cvd.pop.agg$DEATHRATE <- 1000 * nc.zip.cvd.pop.agg$DEATHS / nc.zip.cvd.pop.agg$POP



## colSums used to calculate the sum of the values in each column of a matrix for the nc.cvd.pop data frame, and assigning it to the object nc.st.cvd.pop.agg 
## na.rm = true removes the NA values from the data frame 
nc.st.cvd.pop.agg <- colSums(nc.cvd.pop[,2:5], na.rm = TRUE)



# Calculate Cases and Deaths per 1000 people
nc.st.cvd.pop.agg[4] <- 1000 * nc.st.cvd.pop.agg[2] / nc.st.cvd.pop.agg[1]
nc.st.cvd.pop.agg[5] <- 1000 * nc.st.cvd.pop.agg[3] / nc.st.cvd.pop.agg[1]




# Add names to values that were just calculated
names(nc.st.cvd.pop.agg)[4:5] <- c("CASERATE", "DEATHRATE")


# Convert to dataframe
nc.st.df <- data.frame("Metric" = names(nc.st.cvd.pop.agg), 
                       "Value" = nc.st.cvd.pop.agg)




########################### 
###  Write out results  ###
########################### 


# Write out Zip Code table-- saving to computer
write_csv(nc.zip.cvd.pop.agg, "../Output/NC_ZIPmapping_COVID_POP_2020-09-23.csv")



# Write out State table-- saving to computer
write_csv(nc.st.df, "../Output/NC_State_COVID_POP_2020-09-23.csv")

