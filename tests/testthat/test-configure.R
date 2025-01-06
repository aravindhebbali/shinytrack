test_that("configure_ui() creates the expected HTML", {
  expect_snapshot(configure_ui("config"))
})
