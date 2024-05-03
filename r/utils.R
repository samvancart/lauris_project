

#' Modify YAML Settings
#'
#' This function modifies a YAML configuration file by updating specific keys
#' with new values provided as arguments.
#'
#' @param config_path Path to the existing YAML configuration file.
#' @param ... Key-value pairs representing settings to modify. Each argument
#'   should be named (e.g., new_speciesID = 2, new_csv_path = "data/new_data.csv").
#'
#' @examples
#' # Example usage:
#' modify_yaml_settings("config.yml", new_speciesID = 2, new_csv_path = "data/new_data.csv")
#'
#' @export
modify_yaml_settings <- function(config_path, ...) {
  # Read existing YAML configuration
  config <- yaml::yaml.load_file(config_path)
  
  # Modify specific settings based on provided key-value pairs
  for (i in seq_along(list(...))) {
    key <- names(list(...))[i]
    value <- list(...)[[i]]
    config[[key]] <- value
  }
  
  # Write the updated YAML back to the file
  yaml::write_yaml(config, config_path)
}



