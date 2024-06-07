
# TEST LOAD RDATA FILE

# Test that the function loads an RData file correctly
test_that("loadRDataFile loads an RData file correctly", {
  # Create a sample object and save it to a temporary RData file
  sample_object <- "sample_data"
  temp_RData_path <- tempfile(fileext = ".RData")
  save(sample_object, file = temp_RData_path)
  
  # Load the RData file using the function
  loaded_object <- loadRDataFile(temp_RData_path)
  

  # Check if the loaded object matches the original object
  expect_identical(loaded_object, sample_object)
  
  # Clean up the temporary file
  unlink(temp_RData_path)
})

# Test that the function returns an error for non-existent files
test_that("loadRDataFile returns an error for non-existent files", {
  non_existent_path <- "non_existent_file.RData"
  
  # Expect that trying to load a non-existent file will throw an error
  expect_error(loadRDataFile(non_existent_path), "The provided path does not exist.")
})
