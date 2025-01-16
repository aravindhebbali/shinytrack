#' Server side
#'
#' Server side logic
#'
#' @param input, output, session Internal parameters for {shiny}
#'
#' @noRd
#'
app_server <- function(input, output, session) {
  type_flag <- home_server("home", parent = session)
  path <- path_server("add_path", session, type_flag)
  list_projects_server("display_projects", session, type_flag, path$btn)
  add_project_server("add_project", session)
  delete_project_server("remove_project", session, path$btn, path$path)
  raw_data <- upload_server("upload", session, type_flag, path$btn)
  rawdata_server("raw", session, type_flag, raw_data$data)
  inspect_server("checklist", session, raw_data$data, raw_data$btn, type_flag)
  info_server("info", session, raw_data$btn, raw_data$data, type_flag)
  dashboard_server("dashboard", session, raw_data$btn, type_flag)
  sel_data <- select_server("select", session, raw_data$data, type_flag,
    raw_data$btn, raw_data$sample)
  data <- transform_server("transform", session, sel_data$data, type_flag)
  screen_server("screen", session, data)
  view_server("view", session, data)
  config <- configure_server("config", session, raw_data$btn, raw_data$data,
    type_flag, raw_data$sample)
  rfm_score <- generate_score_server("generate_score", session,
    config$data_type, data, type_flag)
  score <- score_server("display_score", session, rfm_score$score,
    config$currency)
  order_dist <- order_dist_server("order_dist", session, rfm_score$score,
    config$btn, score$btn, config$color, config$engine, config$file_type,
    type_flag)
  hist <- histogram_server("distributions", session, rfm_score$score,
    config$btn, order_dist$btn, config$color, config$engine, config$file_type,
    type_flag)
  heat_map <- heatmap_server("heatmap", session, rfm_score$score, rfm_score$btn,
    hist$btn, rfm_score$bins, config$engine, config$file_type, type_flag)
  bar_chart_server("barchart", session, rfm_score$score, config$btn,
    heat_map$btn, config$color, config$file_type, type_flag)
  segment_data <- generate_segment_server("generate_segment", session,
    rfm_score$score, type_flag)
  segment_server("display_segment", session, segment_data$segment,
    config$currency)
  segment_summary <- segment_summary_server("segment_summary", session,
    segment_data$segment, segment_data$btn, config$currency)
  segment_plot <- segment_plot_server("segment_plot", session,
    segment_summary$overview, config$btn, segment_summary$btn, config$engine,
    config$file_type, type_flag)
  summary_plot <- segment_summary_plot_server("segment_summary_plot", session,
    segment_summary$overview, config$btn, segment_plot, config$color,
    config$engine, config$file_type, type_flag)
  revenue_plot <- revenue_plot_server("revenue_dist", session,
    segment_summary$overview, config$btn, summary_plot, config$engine,
    config$file_type, type_flag)
  recency_plot <- median_recency_server("median_recency_plot", session,
    segment_data$segment, config$btn, revenue_plot, config$color,
    config$engine, config$file_type, type_flag)
  frequency_plot <- median_frequency_server("median_frequency_plot", session,
    segment_data$segment, config$btn, recency_plot, config$color, config$engine,
    config$file_type, type_flag)
  monetary_plot <- median_monetary_server("median_monetary_plot", session,
    segment_data$segment, config$btn, frequency_plot, config$color,
    config$engine, config$file_type, type_flag)
  scatter_plot_server("scatter_plot", session, segment_data$segment, config$btn,
    monetary_plot, config$engine, config$file_type, type_flag)
  download_server("download_segment", session, segment_data$segments,
    segment_data$btn, config$currency)
  exit_server("exit_app", session, type_flag)
  docs_server("documentation")
  demo_server("demos")
}
