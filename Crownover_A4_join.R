####
#### R script to perform a table join and create a map
#### for GEOG 215, Assignment #4
####

#### Shows how to retrieve geojson data as well!

## Load required libraries
library(tidyverse)
library(sf)
library(geojsonsf)
library(tmap)

#### Read geojson data directly as sf object
#### Big-ish file... might take a minute to retrieve
nc_bg_polys <- geojson_sf("https://opendata.arcgis.com/datasets/7d3c48062ffc4cf781835bfa530497e4_8.geojson")

# Remove block groups with 0 population
nc_bg_polys <- nc_bg_polys %>% filter(total_pop > 0)

#### Read Stay at Home data for 4/16
nc_SAT <- read_csv("../Data/Safegraph_StayAtHome_2021-04-16.csv")

#### Calculate Stay at Home percent
nc_SAT$COMPHOME_PCT <- 100 * nc_SAT$COMPHOME / nc_SAT$DEV

####
#### Join attributes of nc_SAT to nc_bg_polys
####
#### Use   merge()
#### Use   all.x = TRUE   (keeps all spatial features in output)
#### Use   all.y = FALSE  (does not include things found only in the tabular data)
####

merged_data_new <- merge(nc_bg_polys, nc_SAT, by.x = "geoid10", by.y = "GEOID", 
                         all.x = TRUE, all.y = FALSE)


####
#### Create a choropleth map of the percent of all
#### people staying home, using the COMPHOME_PCT column
#### using tmap
####
tm <- tm_shape(merged_data_new) + tm_polygons("COMPHOME_PCT", lwd = 0, border.alpha = 0  )





####  Because block groups are very small, we will not display
####  the lines of their boundaries
####     In    tm_polygons() 
####     Use   lwd = 0               (set polygon border width to 0)
####     Use   border.alpha = 0      (set polygon border to fully transparent)
####



tmap_save(tm, filename = "Crownover_A5_join_map.png")
####
#### Export (save) your map
#### See https://cran.r-project.org/web/packages/tmap/vignettes/tmap-getstarted.html#exporting-maps
####
#### Save file as Lastname_A5_join_map.png  (using your last name)
####