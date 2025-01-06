test_that("menu_item_home() creates expected HTML", {
  expect_snapshot(menu_item_home())
})

test_that("menu_item_project() creates expected HTML", {
  expect_snapshot(menu_item_project())
})

test_that("menu_item_data() creates expected HTML", {
  expect_snapshot(menu_item_data())
})

test_that("menu_item_eda() creates expected HTML", {
  expect_snapshot(menu_item_eda())
})

test_that("menu_item_rfm() creates expected HTML", {
  expect_snapshot(menu_item_rfm())
})

test_that("menu_item_segment() creates expected HTML", {
  expect_snapshot(menu_item_segment())
})

test_that("menu_item_exit() creates expected HTML", {
  expect_snapshot(menu_item_exit())
})

test_that("menu_item_help() creates expected HTML", {
  expect_snapshot(menu_item_help())
})
