test_that("segment_input() creates expected HTML", {
  expect_snapshot(segment_input(NS("segment")))
})

test_that("rfm_segment_headings() creates expected HTML", {
  expect_snapshot(rfm_segment_headings())
})

test_that("add_new_segment() creates expected HTML", {
  expect_snapshot(add_new_segment(NS("segment")))
})

test_that("segment_buttons() creates expected HTML", {
  expect_snapshot(segment_buttons(NS("segment")))
})

test_that("sub_menu() creates expected HTML", {
  expect_snapshot(sub_menu())
})
