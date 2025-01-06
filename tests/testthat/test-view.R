test_that("view_ui() creates the expected HTML", {
  expect_snapshot(view_ui("view"))
})
