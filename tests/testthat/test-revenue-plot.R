test_that("revenue_plot_ui() creates the expected HTML", {
  expect_snapshot(revenue_plot_ui("revenue_dist"))
})
