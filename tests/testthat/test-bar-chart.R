test_that("bar_chart_ui() creates the expected HTML", {
  expect_snapshot(bar_chart_ui("barchart"))
})
