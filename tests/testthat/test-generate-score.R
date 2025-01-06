test_that("generate_score_ui() creates the expected HTML", {
  expect_snapshot(generate_score_ui("generate_score"))
})
