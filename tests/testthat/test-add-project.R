test_that("add_project_ui() creates the expected HTML", {
  expect_snapshot(add_project_ui("add_project"))
})
