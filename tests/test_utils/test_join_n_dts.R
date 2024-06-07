# TEST JOIN N DTS


# Sample data for testing
n_dt <- data.table(maakuntaID = 1:3, N = c(100, 150, 200))
all_dt <- data.table(maakuntaID = 1:3, N = c(100, 150, 20))

# Expected result
expected_dt <- data.table(maakuntaID = 1:3, N = c(100, 150, 200))
expected_dt$area <- expected_dt$N * (16*16) / 10000

test_that("join_n_dts joins data tables correctly", {
  result_dt <- join_n_dts(n_dt, all_dt)
  expect_equal(result_dt$maakuntaID, expected_dt$maakuntaID)
  expect_equal(result_dt$N, expected_dt$N)
})

test_that("join_n_dts sets column names correctly", {
  result_dt <- join_n_dts(n_dt, all_dt)
  expect_true("N" %in% colnames(result_dt))
  expect_false("N.x" %in% colnames(result_dt))
  expect_false("N.y" %in% colnames(result_dt))
})

test_that("join_n_dts calculates area correctly", {
  result_dt <- join_n_dts(n_dt, all_dt)
  expect_equal(result_dt$area, expected_dt$area)
})

