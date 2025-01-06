test_that("segment_ui() creates the expected HTML", {
  expect_snapshot(segment_ui("display_segment"))
})
