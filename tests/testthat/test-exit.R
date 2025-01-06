test_that("exit_ui() creates the expected HTML", {
  expect_snapshot(exit_ui("exit_app"))
})
