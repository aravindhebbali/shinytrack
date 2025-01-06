test_that("plot_buttons() creates expected HTML", {
  expect_snapshot(plot_buttons(NS("plot"), "Plot"))
})

test_that("plot_download_options() creates expected HTML", {
  expect_snapshot(plot_download_options(NS("plot")))
})

test_that("inlineRadio() creates expected HTML", {
  expect_snapshot(inlineRadio(NS("plot")))
})

test_that("plot_modify_ui() creates expected HTML", {
  expect_snapshot(plot_modify_ui(NS("plot")))
})

test_that("plot_title() creates expected HTML", {
  expect_snapshot(plot_title(NS("plot"), "Bar Chart"))
})

test_that("plot_axis_labels() creates expected HTML", {
  expect_snapshot(plot_axis_labels(NS("plot"), "Recency", "Frequency"))
})

test_that("plot_sort() creates expected HTML", {
  expect_snapshot(plot_sort(NS("plot")))
})

test_that("plot_flip() creates expected HTML", {
  expect_snapshot(plot_flip(NS("plot")))
  expect_snapshot(plot_flip(NS("plot"), FALSE))
})

test_that("plot_axis_angle() creates expected HTML", {
  expect_snapshot(plot_axis_angle(NS("plot")))
})

test_that("plot_bar_color() creates expected HTML", {
  expect_snapshot(plot_bar_color(NS("plot")))
})

test_that("plot_bar_label_color() creates expected HTML", {
  expect_snapshot(plot_bar_label_color(NS("plot")))
})

test_that("plot_bar_label_size() creates expected HTML", {
  expect_snapshot(plot_bar_label_size(NS("plot")))
})

test_that("plot_legend_title() creates expected HTML", {
  expect_snapshot(plot_legend_title(NS("plot"), "Bar Chart"))
})

test_that("plot_revenue_colors() creates expected HTML", {
  expect_snapshot(plot_revenue_colors(NS("plot")))
})

test_that("plot_revenue_labels() creates expected HTML", {
  expect_snapshot(plot_revenue_labels(NS("plot")))
})

test_that("plot_hist_color_bins() creates expected HTML", {
  expect_snapshot(plot_hist_color_bins(NS("plot")))
})

test_that("plot_brewer_name() creates expected HTML", {
  expect_snapshot(plot_brewer_name(NS("plot")))
})

test_that("plot_bar_primary_axis() creates expected HTML", {
  expect_snapshot(plot_bar_primary_axis(NS("plot")))
})

test_that("plot_bar_secondary_axis() creates expected HTML", {
  expect_snapshot(plot_bar_secondary_axis(NS("plot")))
})

test_that("plot_segment_metric() creates expected HTML", {
  expect_snapshot(plot_segment_metric(NS("plot")))
})

test_that("scatter_nav_btns() creates expected HTML", {
  expect_snapshot(scatter_nav_btns(NS("plot")))
})

test_that("plot_minimize() creates expected HTML", {
  expect_snapshot(plot_minimize(NS("plot")))
})
