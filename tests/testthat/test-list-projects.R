test_that("list_projects_ui() creates the expected HTML", {
  expect_snapshot(list_projects_ui("display_projects"))
})
