test_that("dashboard_ui() creates the expected HTML", {
  expect_snapshot(dashboard_ui("dashboard"))
})
