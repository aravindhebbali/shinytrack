test_that("tab_title() creates expected HTML", {
  expect_snapshot(tab_title("Welcome"))
})

test_that("sub_menu() creates expected HTML", {
  expect_snapshot(sub_menu())
})

test_that("tab_title_btn() creates expected HTML", {
  expect_snapshot(tab_title_btn(NS("display_projects"), "View Projects"))
})

test_that("nav_btns() creates expected HTML", {
  expect_snapshot(nav_btns(NS("display_projects")))
})

test_that("btn_delay() creates expected HTML", {
  expect_snapshot(btn_delay(NS("display_projects")))
})

test_that("sidebar_highlight() creates expected HTML", {
  expect_snapshot(sidebar_highlight(NS("display_projects"), TRUE, "next-tab"))
  expect_snapshot(sidebar_highlight(NS("display_projects"), FALSE, "next-tab"))
  expect_snapshot(sidebar_highlight(NS("display_projects"), TRUE, "next-tab", TRUE))
  expect_snapshot(sidebar_highlight(NS("display_projects"), FALSE, "next-tab", FALSE))
})
