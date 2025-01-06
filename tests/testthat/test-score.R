test_that("score_ui() generates the expected HTML", {
  expect_snapshot(score_ui("display_score"))
})
