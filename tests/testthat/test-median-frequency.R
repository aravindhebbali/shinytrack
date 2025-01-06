test_that("median_frequency_ui() creates expected HTML", {
  expect_snapshot(median_frequency_ui("median_frequency_plot"))
})
