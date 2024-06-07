source("scripts/settings.R")
source("r/utils.R")


# Define vars
municipality <- config$municipalities[config$municipID]
all_dts_path <- paste0(config$rdata_path, tolower(municipality))

# Load all_dt
all_dt <- loadRDataFile(
  paste0(all_dts_path, "/data.all_maakunta_", config$municipOriginalIDs[config$municipID], "_municipID.RData"))

# Load n_dt
n_dt <- loadRDataFile(
  paste0(all_dts_path, "/private_public_n_", tolower(municipality), ".RData"))

# Get lookup tables
private_n_dt <- n_dt[private_N>0, .(maakuntaID=maakuntaID,N=private_N)]
public_n_dt <- n_dt[public_N>0, .(maakuntaID=maakuntaID,N=public_N)]

# Join and process
private_dt <- join_n_dts(private_n_dt, all_dt)
public_dt <- join_n_dts(public_n_dt, all_dt)

# # Save
# save(private_dt, file = paste0(all_dts_path, "/private_maakunta_", config$municipOriginalIDs[config$municipID], ".RData"))
# save(public_dt, file = paste0(all_dts_path, "/public_maakunta_", config$municipOriginalIDs[config$municipID], ".RData"))



# all_n_dt <- n_dt[, .(maakuntaID=maakuntaID, N=all_N)]
# dt <- join_n_dts(all_n_dt, all_dt)
# 
# save(dt, file = paste0(all_dts_path, "/all_maakunta_", config$municipOriginalIDs[config$municipID], ".RData"))


# # TEST
# setorderv(all_dt,"segID")
# setorderv(dt,"segID")
# dt[!which(all_dt$N == dt$N)]




## Check
# print(paste0("all_dt rows: ", nrow(all_dt)))
# print(paste0("private_n_dt rows: ", nrow(private_n_dt)))
# print(paste0("public_n_dt rows: ", nrow(public_n_dt)))
# print(paste0("private_dt rows: ", nrow(private_dt)))
# print(paste0("public_dt rows: ", nrow(public_dt)))
# print(private_dt[!complete.cases(private_dt)])
# print(public_dt[!complete.cases(public_dt)])

