test_that("median_recency_ui() creates expected HTML", {
  expect_snapshot(median_recency_ui("median_recency_plot"))
})
