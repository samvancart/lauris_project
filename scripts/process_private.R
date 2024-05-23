source("scripts/settings.R")

# Paths
municipality <- config$municipalities[config$municipID]
private_sf_path <- paste0(config$sf_path, "private_forests/", tolower(municipality))

# Load private forests sf
private_sf <- st_read(dsn = private_sf_path, layer = paste0("private_singleParts_", tolower(municipality)), drivers = "ESRI Shapefile")
private_sf$privateID <- c(private_sf[,1])[[1]]
private_sf_ids <- private_sf[, length(private_sf)]
private_sf_ids$privateID <- seq_along(private_sf_ids$privateID)


# Rm
rm(private_sf)
gc()


# Load municipality segIDs sf
masked_maakID_sf <- st_read(dsn = private_sf_path, layer = paste0("masked_polygon_maakID_", config$municipOriginalIDs[config$municipID]), drivers = "ESRI Shapefile")
masked_maakID_sf <- st_transform(masked_maakID_sf, st_crs(private_sf_ids))

# Get private IDs
intersection_sf <- st_intersection(masked_maakID_sf, private_sf_ids)
# st_write(obj = intersection_sf , dsn = private_sf_path, layer = paste0("masked_private_", tolower(municipality)), driver = "ESRI Shapefile")

# Area private
base_area <- 16*16
intersection_sf$area <- as.numeric(st_area(intersection_sf))
filtered_intersection_sf <- filter(intersection_sf, intersection_sf$area >= base_area/2)

# Private N to dt
intersection_dt <- as.data.table(filtered_intersection_sf)
private_n_dt <- intersection_dt[, .(N = .N), by=VALUE]
colnames(private_n_dt)[which(colnames(private_n_dt) == "VALUE")] <- "maakuntaID"


# Rm
rm(intersection_dt, intersection_sf, filtered_intersection_sf)
gc()


# Masked to dt
masked_maakID_dt <- as.data.table(masked_maakID_sf)
all_n <- masked_maakID_dt[, .(N = .N), by=VALUE]
colnames(all_n)[which(colnames(all_n) == "VALUE")] <- "maakuntaID"


# Rm
rm(masked_maakID_dt, masked_maakID_sf)
gc()


# Public N
all_private_n_dt <- left_join(all_n, private_n_dt, by = "maakuntaID")
all_private_n_dt[is.na(N.y), N.y:=0]
colnames(all_private_n_dt) <- c("maakuntaID", "all_N", "private_N")

# If N in either group (private or public) is under 10% of total N, move all pixels to other group
all_private_n_dt[, private_N_percent := (private_N/all_N)*100]
under_10 <- all_private_n_dt[private_N_percent>0 & private_N_percent<10]
over_10 <- all_private_n_dt[private_N_percent>=90]
all_private_n_dt[maakuntaID %in% under_10$maakuntaID, private_N := 0]
all_private_n_dt[maakuntaID %in% over_10$maakuntaID, private_N := all_N]
all_private_n_dt[, public_N := all_N - private_N]


print(paste0("Minimum public_N == 0: ", setequal(min(all_private_n_dt$public_N),0)))


# Save
# save(all_private_n_dt, file = paste0(config$rdata_path, tolower(municipality), "/private_public_n_", tolower(municipality), ".RData"))




















