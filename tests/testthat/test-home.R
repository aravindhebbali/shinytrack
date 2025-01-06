test_that("home_ui() creates the expected HTML", {
  expect_snapshot(home_ui("welcome"))
})
