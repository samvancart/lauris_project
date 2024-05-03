source("scripts/settings.R")
source("r/utils.R")



# Run script with different settings
for(i in 1:length(config$municipOriginalIDs)){
  new_municipID <- as.integer(i)
  modify_yaml_settings(config_path, municipID = new_municipID)
  source("scripts/process_rasterID.R")
}











