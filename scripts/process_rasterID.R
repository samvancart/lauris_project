source("scripts/settings.R")

# Paths
municip_sf_path <- paste0(config$sf_path, "/SuomenHallinnollisetKuntajakopohjaisetAluejaot_2023_10k.gpkg")
raster_path <- paste0(config$raster_path, "mktaID.raster_mkta", config$municipOriginalIDs[config$municipID], ".tif")
municipality <- config$municipalities[config$municipID]

# Load municipality sf
st_layers(municip_sf_path)
municip_sf_all <- st_read(municip_sf_path, layer = "Kunta")
municip_sf <- municip_sf_all[which(municip_sf_all$namefin %in% municipality),]

# Load maakuntaID raster
maakID_raster <- raster(raster_path)

masked_maakID_raster <- mask(maakID_raster, municip_sf)

# raster_filename <- paste0(config$raster_path, "masked_maakID_", config$municipOriginalIDs[config$municipID], ".tif")
# writeRaster(masked_maakID_raster, filename = raster_filename, format = "GTiff")
