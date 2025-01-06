test_that("upload_csv() creates expected HTML", {
  expect_snapshot(upload_csv(NS("upload")))
})

test_that("upload_excel() creates expected HTML", {
  expect_snapshot(upload_excel(NS("upload")))
})

test_that("ui_sample_file() creates expected HTML", {
  expect_snapshot(ui_sample_file(NS("upload")))
})

test_that("ui_upload_file() creates expected HTML", {
  expect_snapshot(ui_upload_file(NS("upload")))
})

test_that("ui_list_projects() creates expected HTML", {
  expect_snapshot(ui_list_projects(NS("upload")))
})

test_that("ui_clone_project() creates expected HTML", {
  expect_snapshot(ui_clone_project(NS("upload")))
})
