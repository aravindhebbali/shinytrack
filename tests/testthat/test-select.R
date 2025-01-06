test_that("select_ui() creates the expected HTML", {
  expect_snapshot(select_ui("select"))
})
