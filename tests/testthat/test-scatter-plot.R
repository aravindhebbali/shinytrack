test_that("scatter_plot_ui() creates the expected HTML", {
  expect_snapshot(scatter_plot_ui("scatter_plot"))
})
