test_that("demo_ui() creates the expected HTML", {
  expect_snapshot(demo_ui("demos"))
})
