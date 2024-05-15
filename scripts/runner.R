source("scripts/settings.R")
source("r/utils.R")

run_script <- "scripts/process_private.R"

# Run script with different settings
for(i in 1:length(config$municipOriginalIDs)){
  new_municipID <- as.integer(i)
  modify_yaml_settings(config_path, municipID = new_municipID)
  source(run_script)
}











