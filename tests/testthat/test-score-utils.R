test_that("btn_generate_score() creates expected HTML", {
  expect_snapshot(btn_generate_score(NS("data")))
})
