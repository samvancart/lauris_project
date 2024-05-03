source("scripts/settings.R")
source("r/utils.R")



# Run test script with different settings
for(i in 1:length(config$species_vector)){
  new_speciesID <- as.integer(i)
  modify_yaml_settings(config_path, speciesID = new_speciesID)
  source("scripts/test.R")
}











