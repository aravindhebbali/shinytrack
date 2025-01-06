test_that("upload_ui() creates the expected HTML", {
  expect_snapshot(upload_ui("upload"))
})
