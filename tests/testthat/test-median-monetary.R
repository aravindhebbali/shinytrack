test_that("median_monetary_ui() creates expected HTML", {
  expect_snapshot(median_monetary_ui("median_monetary_plot"))
})
