---
title: 'Assignment #1'
author: "Daniel Crownover"
date: '`r format(Sys.Date(), "%B %d, %Y")`'
output:
 html_document:
  theme: cosmo
  highlight: espresso
  

---

```{r setup, include=FALSE}
knitr::opts_chunk$set(echo = TRUE)
```
### Dowload and Read Data

```{r}
## here we are dowloading the file to the computer
download.file("https://delamater.web.unc.edu/files/2019/08/CA_kind_0015_Sch_Counts_PBE.csv", "CA_kind_0015_Sch_Counts_PBE.csv")
# here we are reading in the file to the studio
cavac <- read.csv("CA_kind_0015_Sch_Counts_PBE.csv")


```



### Data Summary

The number of schools/rows in the table: `r nrow(cavac) ` 
The number of columns in the table: `r ncol(cavac) ` 

```{r}
##above we are labeling the rows with the nrow(cavac) command and we are labeling the columns with the ncol(cavac) command

```



### Aggregating data

```{r}
## Sum the values in each column
##colsum() command adding below
names(cavac)
## we have to have numeric values--> next time you see this ask yourself "what data are we trying to read in- then we can use the "which(search index)" to find our accurate data places and values
CA.sums <- colSums(cavac[,6:37], na.rm = TRUE)
##
## here we are removing the N/A values from the calculations with the na.rm function
CA.sums


## creating a new object for percent of all kinderg with PBE-- the object will be called "CA.pbe.00.15" and it will represent a percent value
CA.pbe.00.15 <- 100 * CA.sums[17:32] / CA.sums[1:16]
## above divides the two vectors by each other because the “years” line up for PBEs and Enrollment. The basic form of this is 100 * PBEs / Enrollment
CA.pbe.00.15

## putting in variable name to search for index value  which(colnames(cavac) == "PBE00")

##which(colnames(cavac) == "PBE00") -- searching index 

## here we are using the paste0 command to rename the observations and objects to reflect what they are-- so we are wenaming PBER to 2000 and 2015 because that makes it easier to interperet in the code

paste0("PBER", 2000:2015)
names(CA.pbe.00.15) <- paste0("PBER", 2000:2015)
CA.pbe.00.15








## here, we are using our ability to work with subsets of the data to accomplish this task by subtracting the prior year value for each year, e.g., the “change” value in 2015 will be the difference between the PBE percent in 2014 and 2015: the following command will accomplish this for that subset of data


## here I am printing the output to the console to demonstrate that this process takes place in the later lines
CA.pbe.00.15[1]
CA.pbe.00.15[2]
#here we are subtracting the prior year value for each year
CA.pbe.00.15[2] - CA.pbe.00.15[1]
## here we are calculating the one-year change in the PBE percent for all years from 2001 to 2015
CA.pbe.ch.01.15 <- CA.pbe.00.15[2:16] - CA.pbe.00.15[1:15]
## here we are "renaming" the values like we did earlier to PBERCH and we are iterating it to do this every year from 2001--> 20015$
names(CA.pbe.ch.01.15) <- paste("PBERCH", 2001:2015, sep="")
CA.pbe.ch.01.15









```


### Plots

```{r}


## In this R code chunk we are creating a basic plot of the geographic locations of all of the schools in California (use the cavac object for this)

## scatter plot -- here we are using this cool command that we learned in class "plot(cavac$lon,cavac$lat)"-- make sure to use the $-- then it will search/ know where to look for the desried thing in the data
plot(cavac$lon,cavac$lat)

##line graph
plot(2000:2015, CA.pbe.00.15, type="l", col="red", lwd=2, xlab="Year", ylab="PBE (%)", main="Percent Change")

## above we are constructing the line graph --use this line of code to construct line plots in the future



```














