source("scripts/settings.R")

# Paths
municip_sf_path <- paste0(config$sf_path, "/SuomenHallinnollisetKuntajakopohjaisetAluejaot_2023_10k.gpkg")
raster_path <- paste0(config$raster_path, "mktaID.raster_mkta", config$municipOriginalIDs[config$municipID], ".tif")
municipality <- config$municipalities[config$municipID]

print(paste0("Municipality is ", municipality))

# Load municipality sf
# st_layers(municip_sf_path)
municip_sf_all <- st_read(municip_sf_path, layer = "Kunta", quiet = T)
municip_sf <- municip_sf_all[which(municip_sf_all$namefin %in% municipality),]

# Load maakuntaID raster
maakID_raster <- raster(raster_path)
masked_maakID_raster <- mask(maakID_raster, municip_sf)

# Rm
rm(maakID_raster)

# To dt
municipID_dt <- data.table(rasterToPoints(masked_maakID_raster))


# Write masked raster
raster_filename <- paste0(config$raster_path, "masked_maakID_", config$municipOriginalIDs[config$municipID], ".tif")
writeRaster(masked_maakID_raster, filename = raster_filename, format = "GTiff")
print(paste0("Wrote masked raster to ", raster_filename))

# Write IDs as rdata
rdata_filename <- paste0(config$rdata_path, "municipID_dt_", config$municipOriginalIDs[config$municipID], ".rdata")
save(municipID_dt, file = rdata_filename)
print(paste0("Wrote dt to ", rdata_filename))

# Rm
rm(masked_maakID_raster, municipID_dt)
gc()

