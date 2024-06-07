source("scripts/settings.R")
source("r/utils.R")

# run_script <- "scripts/process_private.R"
# run_script <- "scripts/private_public_dts.R"

# Run script with different settings
for(i in 1:length(config$municipOriginalIDs)){
  new_municipID <- as.integer(i)
  modify_yaml_settings(config_path, municipID = new_municipID)
  source(run_script)
}

# Modify with named vector
ids <- c(municipID_2 = as.integer(1), speciesID = as.integer(3))
modify_yaml_settings_vector(config_path, ids)





