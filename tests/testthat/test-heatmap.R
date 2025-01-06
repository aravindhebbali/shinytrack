test_that("heatmap_ui() creates the expected HTML", {
  expect_snapshot(heatmap_ui("heatmap"))
})
