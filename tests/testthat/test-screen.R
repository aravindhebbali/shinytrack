test_that("screen_ui() creates the expected HTML", {
  expect_snapshot(screen_ui("screen"))
})
