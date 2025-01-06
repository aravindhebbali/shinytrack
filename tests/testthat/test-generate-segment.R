test_that("generate_segment_ui() creates the expected HTML", {
  expect_snapshot(generate_segment_ui("generate_segment"))
})
