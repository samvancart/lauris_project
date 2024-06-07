
# TEST MODIFY YAML SETTINGS VECTOR

# Write sample configuration to a temporary file
temp_config_path <- tempfile(fileext = ".yaml")
writeLines("speciesID: 1\n", temp_config_path)

# Test that the function updates the settings correctly
test_that("modify_yaml_settings updates settings correctly", {
  settings_to_change <- c(speciesID = as.integer(3), setting1 = "new_value1",  setting3 = "new_value3")
  modify_yaml_settings_vector(temp_config_path, settings_to_change)
  
  updated_config <- yaml.load_file(temp_config_path)
  
  expect_equal(updated_config$speciesID, "3")
  expect_equal(updated_config$setting1, "new_value1")
  expect_equal(updated_config$setting3, "new_value3")
})

# Test that the function stops if settings_vector is not named
test_that("modify_yaml_settings stops if settings_vector is not named", {
  unnamed_vector <- c("new_value1", "new_value3")
  
  expect_error(
    modify_yaml_settings_vector(temp_config_path, unnamed_vector),
    "settings_vector must be a named vector."
  )
})

# Clean up the temporary file
unlink(temp_config_path)
