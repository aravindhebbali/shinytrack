menu_item_home <- function() {
  menuItem("Home", tabName = "tab_home",
           icon = icon("home", class = "sidebar-icon"))
}

menu_item_project <- function() {
  menuItem("Project", tabName = "tab_project",
           icon = icon("list-check", class = "sidebar-icon"),
           menuSubItem("Retrieve", tabName = "tab_path"),
           menuSubItem("View", tabName = "tab_projects"),
           menuSubItem("Add", tabName = "tab_add_project"),
           menuSubItem("Delete", tabName = "tab_del_project")
  )
}

menu_item_data <- function() {
  menuItem("Data", tabName = "tab_data",
           icon = icon("database", class = "sidebar-icon"),
           menuSubItem("Upload", tabName = "tab_upload"),
           menuSubItem("Raw Data", tabName = "tab_raw"),
           menuSubItem("Metadata", tabName = "tab_examine"),
           menuSubItem("Overview", tabName = "tab_project_info"),
           menuSubItem("Dashboard", tabName = "tab_dashboard"),
           menuSubItem("Select", tabName = "tab_select"),
           menuSubItem("Transform", tabName = "tab_transform"),
           menuSubItem("Screen", tabName = "tab_screen"),
           menuSubItem("View Data", tabName = "tab_view"),
           menuSubItem("Configure", tabName = "tab_config")
  )
}

menu_item_eda <- function() {
  menuItem("EDA", tabName = "tab_eda",
           icon = icon("magnifying-glass", class = "sidebar-icon"),
           menuSubItem("Orders", tabName = "tab_orders"),
           menuSubItem("Distributions", tabName = "tab_distributions"),
           menuSubItem("Heat Map", tabName = "tab_heatmap"),
           menuSubItem("Bar Chart", tabName = "tab_bar_chart")
  )
}

menu_item_rfm <- function() {
  menuItem("RFM", tabName = "tab_rfm",
           icon = icon("sitemap", class = "sidebar-icon"),
           menuSubItem("Generate Score", tabName = "tab_generate_score"),
           menuSubItem("RFM Score", tabName = "tab_rfm_score")
  )
}

menu_item_segment <- function() {
  menuItem("Segmentation", tabName = "tab_segmentation",
           icon = icon("layer-group", class = "sidebar-icon"),
           menuSubItem("Generate Segments", tabName = "tab_generate_segments"),
           menuSubItem("Segments", tabName = "tab_segments"),
           menuSubItem("Summary", tabName = "tab_segment_summary"),
           menuSubItem("Segments Plot", tabName = "tab_segment_plot"),
           menuSubItem("Summary Plot", tabName = "tab_segment_summary_plot"),
           menuSubItem("Revenue Plot", tabName = "tab_revenue_plot"),
           sub_menu(),
           menuSubItem("Scatter Plot", tabName = "tab_scatter_plot"),
           menuSubItem("Download", tabName = "tab_download")
  )
}

menu_item_exit <- function() {
  menuItem("Exit", tabName = "tab_exit", icon =
             icon("power-off", class = "sidebar-icon"))
}

menu_item_help <- function() {
  menuItem("Help", tabName = "tab_help",
           icon = icon("circle-info", class = "sidebar-icon"),
           menuSubItem("Documentation", tabName = "tab_docs"),
           menuSubItem("Demo", tabName = "tab_demo")

  )
}
