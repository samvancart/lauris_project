

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

#' Modify YAML Settings Vector
#'
#' This function modifies specific settings in a YAML configuration file based on a provided named vector.
#'
#' @param config_path The file path to the YAML configuration file.
#' @param settings_vector A named vector containing key-value pairs where the key is the setting name
#' and the value is the new setting value.
#'
#' @return None
#'
#' @examples
#' settings <- c(setting1 = "value1", setting2 = "value2")
#' modify_yaml_settings_vector("path/to/config.yaml", settings)
#'
#' @export
#'
#' @importFrom yaml yaml.load_file write_yaml
modify_yaml_settings_vector <- function(config_path, settings_vector) {
  
  # Ensure that settings_vector is a named vector
  if (is.null(names(settings_vector))) {
    stop("settings_vector must be a named vector.")
  }
  
  # Read existing YAML configuration
  config <- yaml::yaml.load_file(config_path)
  
  # Modify specific settings based on provided key-value pairs in the named vector
  for (key in names(settings_vector)) {
    value <- settings_vector[[key]]
    config[[key]] <- value
  }
  
  # Write the updated YAML back to the file
  yaml::write_yaml(config, config_path)
}



#' Load an RData file into an environment and retrieve an object
#'
#' @param RDataFile Path to the RData file.
#' @return An object loaded from the RData file.
#'
#' @examples
#' loadRDataFile("my_data.RData")
#'
loadRDataFile <- function(RDataFile) {
  
  if(!file.exists(RDataFile)) {
    stop("The provided path does not exist.")
  }
  
  temp_env <- new.env()
  obj <- get(load(RDataFile), temp_env)
  return(obj)
}



#' Join two data tables and calculate area
#'
#' This function joins two data tables based on a common column and calculates the area.
#'
#' @param n_dt A data table to be joined.
#' @param all_dt A data table to be joined.
#' @param by A character string specifying the column name to join on. Default is "maakuntaID".
#' @param pixel_area The area of a single pixel. Default is 16*16.
#'
#' @return A data table after joining and calculating the area.
#'
#' @examples
#' \dontrun{
#' join_n_dts(n_dt = dt1, all_dt = dt2, by = "common_column", pixel_area = 16*16)
#' }
#'
#' @export
join_n_dts <- function(n_dt, all_dt, by="maakuntaID", pixel_area=16*16) {
  dt <- left_join(n_dt, all_dt, by = by)
  dt[, N.y := NULL]
  colnames(dt)[which(colnames(dt)=="N.x")] <- "N"
  setcolorder(dt, colnames(all_dt))
  dt$area <- dt$N*(pixel_area)/10000
  return(dt)
}


