#' Inspect meta data 
#'
#' Shiny module for inspecting meta data. 
#'
#' @param id Shiny module id.
#' @param parent Name of the parent session.
#' @param flag Reactive; project type flag.
#' @param data Reactive; raw data. 
#' @param btn Reactive; restore configuration for existing projects.
#' @param input, output, session Internal parameters for {shiny}
#'
#' @noRd
#'
inspect_ui <- function(id) {
  ns <- NS(id)
  tabItem(tabName = "tab_examine",
          div(class = "tab_container btn_end",
              div(
                tab_title("Project Metadata"),
                checkboxGroupInput(
                  ns("data_inputs"),
                  "Data",
                  c("Columns Selected" = "cols_selected",
                    "Column Names" = "col_new_names",
                    "Column Data Types" = "col_new_types"),
                  NULL, TRUE),
                checkboxGroupInput(
                  ns("config_inputs"),
                  "Configuration",
                  c("Currency" = "currency",
                    "Plot Color" = "plot_color",
                    "Plot Extension" = "plot_ext",
                    "Interactive Plots" = "plot_mode",
                    "Data Format" = "data_format"),
                  NULL, TRUE),
                checkboxGroupInput(
                  ns("score_inputs"),
                  "Score & Segments",
                  c("Score" = "score_inputs",
                    "Segments" = "segments_count"),
                  NULL, TRUE),
                checkboxGroupInput(
                  ns("eda_inputs"),
                  "Score Visualization",
                  c("Order Distribution" = "order_dist",
                    "Histograms" = "histogram",
                    "Heat Map" = "heatmap",
                    "Bar Chart" = "bar_chart"),
                  NULL, TRUE),
                checkboxGroupInput(
                  ns("viz_inputs"),
                  "Segment Visualization",
                  c("Segment Plot" = "segment_plot",
                    "Segment Summary Plot" = "summary_plot",
                    "Revenue Plot" = "revenue_plot",
                    "Scatter Plot" = "scatter_plot",
                    "Median Recency Plot" = "median_recency",
                    "Median Frequency Plot" = "median_frequency",
                    "Median Monetary Plot" = "median_monetary"),
                  NULL, TRUE),
                checkboxGroupInput(
                  ns("data_sets"),
                  "Data Sets",
                  c("Raw Data" = "raw_data",
                    "Selected Data" = "selected_data",
                    "Modified Data" = "modified_data",
                    "RFM Score" = "rfm_score",
                    "RFM Segments" = "rfm_segments",
                    "Segment Summary" = "segment_summary"),
                  NULL, TRUE)
              ),
              nav_btns(ns)
          )
  )
}

inspect_server <- function(id, parent, data, btn, flag) {
  moduleServer(id, function(input, output, session) {

    ns <- session$ns

    observeEvent(btn(), {
      if (flag() == "restore_project" || flag() == "clone_project") {

        proj_view <- global$proj_info

        updateCheckboxGroupInput(
          session,
          inputId = "data_inputs",
          choices = c("Columns Selected" = "cols_selected",
                      "Column Names" = "col_new_names",
                      "Column Data Types" = "col_new_types"),
          selected = names(proj_view),
          inline = TRUE
        )


        updateCheckboxGroupInput(
          session,
          inputId ="config_inputs",
          choices = c("Currency" = "currency",
                      "Plot Color" = "plot_color",
                      "Plot Extension" = "plot_ext",
                      "Interactive Plots" = "plot_mode",
                      "Data Format" = "data_format"),
          selected = names(proj_view),
          inline = TRUE)

        updateCheckboxGroupInput(
          session,
          inputId = "score_inputs",
          choices = c("Score" = "score_inputs",
                      "Segments" = "segments_count"),
          selected = names(proj_view),
          inline = TRUE
        )

        updateCheckboxGroupInput(
          session,
          inputId = "eda_inputs",
          choices = c("Order Distribution" = "order_dist",
                      "Histograms" = "histogram",
                      "Heat Map" = "heatmap",
                      "Bar Chart" = "bar_chart"),
          selected = names(proj_view),
          inline = TRUE
        )

        updateCheckboxGroupInput(
          session,
          inputId = "viz_inputs",
          choices = c("Segment Plot" = "segment_plot",
                      "Segment Summary Plot" = "summary_plot",
                      "Revenue Plot" = "revenue_plot",
                      "Scatter Plot" = "scatter_plot",
                      "Median Recency Plot" = "median_recency",
                      "Median Frequency Plot" = "median_frequency",
                      "Median Monetary Plot" = "median_monetary"),
          selected = names(proj_view),
          inline = TRUE
        )

        updateCheckboxGroupInput(
          session,
          inputId = "data_sets",
          choices = c("Raw Data" = "raw_data",
                      "Selected Data" = "selected_data",
                      "Modified Data" = "modified_data",
                      "RFM Score" = "rfm_score",
                      "RFM Segments" = "rfm_segments",
                      "Segment Summary" = "segment_summary"),
          selected = names(data()),
          inline = TRUE
        )

      }
    })

    observeEvent(input$back, {
      updateTabItems(session = parent, "tabs", "tab_raw")
    })

    observeEvent(input$`next`, {
      updateTabItems(session = parent, "tabs", "tab_project_info")
    })

  })
}
