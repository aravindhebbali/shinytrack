global <- new.env()
global$meta_info <- list(dir_flag = FALSE,
                         global_dir = "rfm-projects")

global$proj_info <- list(data_format = "transaction",
                         currency = "u0024",
                         plot_color = "0f1a34",
                         plot_ext = "PNG",
                         plot_mode = FALSE)

set_path <- function(dir) {
  global$meta_info[["path"]] <- dir
}

set_dir_flag <- function() {
  global$meta_info$dir_flag <- !global$meta_info$dir_flag
}

set_project_title <- function(title) {
  global$proj_info[["title"]] <- title
}

get_columns_selected <- function(col_names) {
  global$proj_info[["cols_selected"]] <- col_names
}

get_new_col_names <- function(new_names) {
  global$proj_info[["col_new_names"]] <- new_names
}

get_new_col_types <- function(new_types) {
  global$proj_info[["col_new_types"]] <- new_types
}

get_data_format <- function(format) {
  global$proj_info[["data_format"]] <- format
}

get_currency <- function(currency) {
  global$proj_info[["currency"]] <- currency
}

get_plot_color <- function(color) {
  global$proj_info[["plot_color"]] <- color
}

get_plot_ext <- function(ext) {
  global$proj_info[["plot_ext"]] <- ext
}

get_plot_mode <- function(mode) {
  global$proj_info[["plot_mode"]] <- mode
}

get_score_inputs <- function(inputs) {
  global$proj_info[["score_inputs"]] <- inputs
}

get_segments_count <- function(inputs) {
  global$proj_info[["segments_count"]] <- inputs
}

get_segment_names_meta <- function(inputs) {
  global$proj_info[["segment_names"]] <- inputs
}

get_lower_recency <- function(inputs) {
  global$proj_info[["lower_recency"]] <- inputs
}

get_lower_frequency <- function(inputs) {
  global$proj_info[["lower_frequency"]] <- inputs
}

get_lower_monetary <- function(inputs) {
  global$proj_info[["lower_monetary"]] <- inputs
}

get_upper_recency <- function(inputs) {
  global$proj_info[["upper_recency"]] <- inputs
}

get_upper_frequency <- function(inputs) {
  global$proj_info[["upper_frequency"]] <- inputs
}

get_upper_monetary <- function(inputs) {
  global$proj_info[["upper_monetary"]] <- inputs
}

get_order_dist_opts <- function(inputs) {
  global$proj_info[["order_dist"]] <- inputs
}

get_hist_opts <- function(inputs) {
  global$proj_info[["histogram"]] <- inputs
}

get_heatmap_opts <- function(inputs) {
  global$proj_info[["heatmap"]] <- inputs
}

get_barchart_opts <- function(inputs) {
  global$proj_info[["bar_chart"]] <- inputs
}

get_segment_plot_opts <- function(inputs) {
  global$proj_info[["segment_plot"]] <- inputs
}

get_summary_plot_opts <- function(inputs) {
  global$proj_info[["summary_plot"]] <- inputs
}

get_revenue_plot_opts <- function(inputs) {
  global$proj_info[["revenue_plot"]] <- inputs
}

get_scatter_plot_opts <- function(inputs) {
  global$proj_info[["scatter_plot"]] <- inputs
}

get_med_recency_opts <- function(inputs) {
  global$proj_info[["median_recency"]] <- inputs
}

get_med_frequency_opts <- function(inputs) {
  global$proj_info[["median_frequency"]] <- inputs
}

get_med_monetary_opts <- function(inputs) {
  global$proj_info[["median_monetary"]] <- inputs
}
