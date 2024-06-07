
# TEST MODIFY YAML SETTINGS 


# Define a test case
test_that("modify_yaml_settings correctly updates YAML", {
  # Create a temporary YAML file for testing
  temp_config <- tempfile(fileext = ".yaml")
  writeLines("speciesID: 1\n", temp_config)
  
  # Call the function to modify the YAML
  modify_yaml_settings(temp_config, speciesID = 2)
  modify_yaml_settings(temp_config, speciesID = 3)
  
  # Read the modified YAML
  modified_config <- yaml::yaml.load_file(temp_config)
  
  # Check if speciesID was updated
  expect_equal(modified_config$speciesID, 3)
  
  # Clean up temporary file
  unlink(temp_config)
})

test_that("modified YAML has correct length", {
  # Create a temporary YAML file for testing
  temp_config <- tempfile(fileext = ".yaml")
  writeLines("speciesID: 1\n", temp_config)
  
  # Call the function to modify the YAML
  modify_yaml_settings(temp_config, speciesID = 2)
  
  # Read the modified YAML
  modified_lines <- readLines(temp_config)
  
  # Check if the modified YAML has the expected number of lines
  expect_equal(length(modified_lines), 1)  # Assuming 2 lines after modification
  
  # Clean up temporary file
  unlink(temp_config)
})

