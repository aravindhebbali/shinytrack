test_that("docs_ui() creates the expected HTML", {
  expect_snapshot(docs_ui("documentation"))
})
