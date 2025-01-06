test_that("histogram_ui() creates the expected HTML", {
  expect_snapshot(histogram_ui("distributions"))
})
