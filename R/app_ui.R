#' User interface
#'
#' Main interface of the package
#'
#' @import shinydashboardPlus
#' @importFrom shinydashboard dashboardBody sidebarMenu tabItems
#' @noRd
#'
app_ui <- function() {
  tagList(
    dashboardPage(
      md = FALSE,
      skin = "midnight",
      title = "Segment Wizard",
      header = dashboardHeader(title = "Segment Wizard"),
      sidebar = dashboardSidebar(
        sidebarMenu(
          id = "tabs",
          menu_item_home(),
          menu_item_project(),
          menu_item_data(),
          menu_item_rfm(),
          menu_item_eda(),
          menu_item_segment(),
          menu_item_exit(),
          menu_item_help()
        )
      ),
      body = dashboardBody(
        tabItems(
          home_ui("home"),
          path_ui("add_path"),
          list_projects_ui("display_projects"),
          add_project_ui("add_project"),
          delete_project_ui("remove_project"),
          upload_ui("upload"),
          rawdata_ui("raw"),
          inspect_ui("checklist"),
          info_ui("info"),
          dashboard_ui("dashboard"),
          select_ui("select"),
          transform_ui("transform"),
          screen_ui("screen"),
          view_ui("view"),
          configure_ui("config"),
          generate_score_ui("generate_score"),
          score_ui("display_score"),
          order_dist_ui("order_dist"),
          histogram_ui("distributions"),
          heatmap_ui("heatmap"),
          bar_chart_ui("barchart"),
          generate_segment_ui("generate_segment"),
          segment_ui("display_segment"),
          segment_summary_ui("segment_summary"),
          segment_plot_ui("segment_plot"),
          segment_summary_plot_ui("segment_summary_plot"),
          revenue_plot_ui("revenue_dist"),
          median_recency_ui("median_recency_plot"),
          median_frequency_ui("median_frequency_plot"),
          median_monetary_ui("median_monetary_plot"),
          scatter_plot_ui("scatter_plot"),
          download_ui("download_segment"),
          exit_ui("exit_app"),
          docs_ui("documentation"),
          demo_ui("demos")
        )
      )
    ),
    useDeps()
  )
}
