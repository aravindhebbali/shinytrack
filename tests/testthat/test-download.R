test_that("download_ui() creates the expected HTML", {
  expect_snapshot(download_ui("download_segment"))
})
