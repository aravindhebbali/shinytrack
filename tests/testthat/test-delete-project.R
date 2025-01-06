test_that("delete_project_ui() creates the expected HTML", {
  expect_snapshot(delete_project_ui("remove_project"))
})
