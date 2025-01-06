global$plot_flag <- list(order_dist = FALSE,
                         histogram = FALSE,
                         heat_map = FALSE, 
                         bar_chart = FALSE,
                         segment_plot = FALSE,
                         summary_plot = FALSE,
                         revenue_plot = FALSE,
                         scatter_plot = FALSE,
                         med_frequency = FALSE,
                         med_recency = FALSE,
                         med_monetary = FALSE)

restore_order_dist <- function() {
  global$plot_flag$order_dist <- TRUE
}


restore_heat_map <- function() {
  global$plot_flag$heat_map <- TRUE
}


restore_histogram <- function() {
  global$plot_flag$histogram <- TRUE
}


restore_bar_chart <- function() {
  global$plot_flag$bar_chart <- TRUE
}


restore_segment_plot <- function() {
  global$plot_flag$segment_plot <- TRUE
}


restore_summary_plot <- function() {
  global$plot_flag$summary_plot <- TRUE
}


restore_revenue_plot <- function() {
  global$plot_flag$revenue_plot <- TRUE
}


restore_scatter_plot <- function() {
  global$plot_flag$scatter_plot <- TRUE
}


restore_med_recency <- function() {
  global$plot_flag$med_recency <- TRUE
}


restore_med_frequency <- function() {
  global$plot_flag$med_frequency <- TRUE
}


restore_med_monetary <- function() {
  global$plot_flag$med_monetary <- TRUE
}
