
# Libs

library(data.table)
library(Rprebasso)
library(ggplot2)
library(reshape2)
library(gridExtra)
library(dplyr)
library(factoextra)
library(hash)
library(lubridate)
library(ncdf4)
library(geosphere)
library(zoo)
library(parallel)
library(doParallel)
library(foreach)
library(ggpubr)
library(sf)
library(foreign)
library(stars)
library(geoTS)
library(parallelly)
library(R.utils)
library(snow)
library(stringr)
library(raster)
library(yaml)
library(gtools)
library(terra)



# Path to config file
config_path <- paste0("config.yaml")

# Load configuration file
config <- yaml.load_file(config_path)











