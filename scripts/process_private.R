source("scripts/settings.R")

# Paths
municip <- tolower(config$municipalities[config$municipID])
private_sf_path <- paste0(config$sf_path, "private_forests/", municip)
raster_path <- paste0(config$raster_path, "masked_maakID_", config$municipOriginalIDs[config$municipID], ".tif")


# Load private forests sf
private_sf <- st_read(dsn = private_sf_path, layer = paste0("private_fixed_dissolved_", municip), drivers = "ESRI Shapefile")
private_sf$privateID <- c(private_sf[,1])[[1]]
private_sf_ids <- private_sf[, length(private_sf)]



# Load masked raster
masked_maakID_raster <- raster(raster_path)
# masked_privateID_raster <- mask(masked_maakID_raster, head(private_sf_ids))




