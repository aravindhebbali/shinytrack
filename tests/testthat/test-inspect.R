test_that("inspect_ui() creates the expected HTML", {
  expect_snapshot(inspect_ui("checklist"))
})
