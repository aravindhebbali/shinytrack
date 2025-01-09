#' Segment scatter plot
#' 
#' Shiny module for generating segment scatter plot. 
#'
#' @param id Shiny module id.
#' @param parent Name of the parent session.
#' @param data Reactive; sample or user submitted data.
#' @param btn Reactive; rfm score generation button.
#' @param engine Reactive; plotting engine.
#' @param file Reactive; download file type.
#' @param flag Reactive; project type.
#' @param input, output, session Internal parameters for {shiny}.
#'
#' @importFrom rfm rfm_plot_segment_scatter
#' @noRd
#'
scatter_plot_ui <- function(id) {
  ns <- NS(id)
  tabItem(tabName = "tab_scatter_plot",
          div(class = "tab_container btn_end",
              div(
                fluidRow(
                  plot_buttons(ns, 'Segment Scatter Plot'),
                  plot_download_options(ns),
                  column(12, align = "center", hr())
                ),
                div(class = "plot-order-dist",
                    div(class = "plot-settings",
                        div(class = "plot-details",
                            plot_minimize(ns),
                            tags$details(
                              tags$summary("Metric"),
                              column(5, align = "left",
                                     plot_metric(ns, "metric_x", "monetary")),
                              column(5, align = "left", offset = 2,
                                     plot_metric(ns, "metric_y", "recency"))
                            ),
                            plot_title(ns, "Recency vs Monetary Value"),
                            plot_axis_labels(ns, "Monetary Value", "Recency"),
                            plot_legend_title(ns, "Segment"),
                            plot_flip(ns, FALSE)
                        ),
                        plot_modify_ui(ns)
                    ),
                    div(class = "plot",
                        uiOutput(ns("plot_output"))
                    )
                )
              ),
              scatter_nav_btns(ns)
          )
  )
}

scatter_plot_server <- function(id, parent, data, btn, engine, file, flag) {
  moduleServer(id, function(input, output, session) {

    ns <- session$ns

    observeEvent(btn(), {
updateCheckboxInput(
  session, "interactive", "Interactive", as.logical(engine()))

      updateRadioButtons(session, "download_type", "",
                      c("PNG" = "png",
                        "JPEG" = "jpeg"), file(), inline = TRUE)
          })

    output$plot_output <- renderUI({
      if (input$interactive) {
        threeDots(plotlyOutput(ns("plotly_scatter")), color = "#0f1a34")
      } else {
        threeDots(plotOutput(ns("plot_scatter")), color = "#0f1a34")
      }
    })

    scatter <- reactiveVal()

    observe({
      updateTextInput(session, "plot_title", "Plot title",
                      paste(str_to_title(input$metric_y), "vs",
                            str_to_title(input$metric_x)))
      updateTextInput(session, "x_axis_label", "X Axis Label",
                      str_to_title(input$metric_x))
      updateTextInput(session, "y_axis_label", "Y Axis Label",
                      str_to_title(input$metric_y))
    })

    observeEvent(btn_next(), {
        scatter(
          rfm_plot_segment_scatter(
            data(), input$metric_x, input$metric_y,
            input$plot_title, input$legend_title,
            input$x_axis_label, input$y_axis_label,
            input$interactive))

        if (input$interactive) {
          output$plotly_scatter <- renderPlotly({
              scatter() %>%
                config(
                  displayModeBar = TRUE,
                  modeBarButtonsToRemove = c("zoom2d", "zoomIn2d",
                                             "zoomOut2d", "pan2d",
                                             "lasso2d", "autoScale2d",
                                             "select2d", "resetScale2d"))
          })
        } else {
          output$plot_scatter <- renderPlot({ scatter() })
        }
    })

    observeEvent(input$btn_resize, {
      if (flag() == "restore_project" || flag() == "clone_project") {
        restore_flag <- global$plot_flag$scatter_plot
        if (!restore_flag) {
          inputs <- global$proj_info$scatter_plot
          if (!is.null(inputs)) {
            scatter(
              rfm_plot_segment_scatter(
                data(), inputs[1], inputs[2], inputs[3], inputs[6], inputs[4],
                inputs[5], inputs[7]))

            updateSelectInput(session, "metric_x", "",
                              c("Recency" = "recency",
                                "Frequency" = "frequency",
                                "Monetary Value" = "monetary"),
                              inputs[1])
            updateSelectInput(session, "metric_y", "",
                              c("Recency" = "recency",
                                "Frequency" = "frequency",
                                "Monetary Value" = "monetary"),
                              inputs[2])
            updateTextInput(session, "plot_title", "Plot title", inputs[3])
            updateTextInput(session, "x_axis_label", "X Axis Label", inputs[4])
            updateTextInput(session, "y_axis_label", "Y Axis Label", inputs[5])
            updateTextInput(session, "legend_title", "Title", inputs[6])
            updateCheckboxInput(
              session, "interactive", "Interactive", as.logical(inputs[7]))

            output$plot_scatter <- renderPlot({
              scatter()
            })

            restore_scatter_plot()
          } else {
            scatter(
              rfm_plot_segment_scatter(
                data(), input$metric_x, input$metric_y, input$plot_title,
                input$legend_title, input$x_axis_label, input$y_axis_label,
                input$interactive))

            output$plot_scatter <- renderPlot({ scatter() })
          }
        } else {

          scatter(
            rfm_plot_segment_scatter(
              data(), input$metric_x, input$metric_y, input$plot_title,
              input$legend_title, input$x_axis_label, input$y_axis_label,
              input$interactive))

          output$plot_scatter <- renderPlot({ scatter() })
        }
      } else {

        scatter(
          rfm_plot_segment_scatter(
            data(), input$metric_x, input$metric_y,
            input$plot_title, input$legend_title,
            input$x_axis_label, input$y_axis_label,
            input$interactive))

        if (input$interactive) {
          output$plotly_scatter <- renderPlotly({
              scatter() %>%
                config(
                  displayModeBar = TRUE,
                  modeBarButtonsToRemove = c("zoom2d", "zoomIn2d",
                                             "zoomOut2d", "pan2d",
                                             "lasso2d", "autoScale2d",
                                             "select2d", "resetScale2d"))
          })
        } else {
          output$plot_scatter <- renderPlot({ scatter() })
        }

        get_scatter_plot_opts(c(input$metric_x, input$metric_y,
                                         input$plot_title, input$x_axis_label,
                                         input$y_axis_label, input$legend_title,
                                         input$interactive))
      }

    })

    observeEvent(input$btn_reset, {
      updateSelectInput(session, "metric_x", "",
                        c("Recency" = "recency",
                          "Frequency" = "frequency",
                          "Monetary Value" = "monetary"),
                        "monetary")
      updateSelectInput(session, "metric_y", "",
                        c("Recency" = "recency",
                          "Frequency" = "frequency",
                          "Monetary Value" = "monetary"),
                        "recency")
      updateTextInput(session, "plot_title", "Plot title",
                      "Recency vs Monetary Value")
      updateTextInput(session, "x_axis_label", "X Axis Label", "Monetary Value")
      updateTextInput(session, "y_axis_label", "Y Axis Label", "Recency")
      updateTextInput(session, "legend_title", "Title", "Segment")
      updateCheckboxInput(session, "interactive", "Interactive", FALSE)

      scatter(rfm_plot_segment_scatter(data()))

      output$plot_scatter <- renderPlot({ scatter() })

      get_scatter_plot_opts(c(input$metric_x, input$metric_y,
                                       input$plot_title, input$x_axis_label,
                                       input$y_axis_label, input$legend_title,
                                       input$interactive))

    })

    plot_download(input, output, scatter, "segment-scatter")

    observeEvent(input$back, {
      updateTabItems(session = parent, "tabs", "tab_median_monetary")
    })

    observeEvent(input$`next`, {
      updateTabItems(session = parent, "tabs", "tab_download")
    })
  })
}
