test_that("rawdata_ui() creates the expected HTML", {
  expect_snapshot(rawdata_ui("raw"))
})
