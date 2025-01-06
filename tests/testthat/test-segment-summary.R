test_that("segment_summary_ui() creates the expected HTML", {
  expect_snapshot(segment_summary_ui("segment_summary"))
})
