test_that("segment_summary_plot_ui() creates the expected HTML", {
  expect_snapshot(segment_summary_plot_ui("segment_summary_plot"))
})
