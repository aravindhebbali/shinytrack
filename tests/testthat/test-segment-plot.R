test_that("segemnt_plot_ui() creates the expected HTML", {
  expect_snapshot(segment_plot_ui("segment_plot"))
})
