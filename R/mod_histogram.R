#' RFM Distribution 
#'
#' Shiny module for visualizing RFM score distribution. 
#'
#' @param id Shiny module id.
#' @param parent Name of the parent session.
#' @param data Reactive; sample or user submitted data.
#' @param btn Reactive; rfm score generation button.
#' @param color Reactive; plot color.
#' @param engine Reactive; plotting engine.
#' @param file Reactive; download file type.
#' @param flag Reactive; project type.
#' @param input, output, session Internal parameters for {shiny}.
#'
#' @importFrom rfm rfm_plot_histogram
#' @noRd
#' 
histogram_ui <- function(id) {
  ns <- NS(id)
  tabItem(tabName = "tab_distributions",
          div(class = "tab_container btn_end",
              div(
                fluidRow(
                  plot_buttons(ns, 'RFM Distribution'),
                  plot_download_options(ns),
                  column(12, align = "center", hr())
                ),
                div(class = "plot-order-dist",
                    div(class = "plot-settings",
                        div(class = "plot-details",
                            plot_minimize(ns),
                            tags$details(
                              tags$summary("Metric"),
                              column(12, align = "left",
                                     plot_metric(ns, "metric", "recency"))
                            ),
                            plot_title(ns, "Recency Distribution"),
                            plot_axis_labels(ns, "Recency", "Count"),
                            plot_hist_color_bins(ns),
                            plot_flip(ns, FALSE)
                        ),
                        plot_modify_ui(ns)
                    ),
                    div(class = "plot",
                        uiOutput(ns("plot_output"))
                    )
                )
              ),
              nav_btns(ns)
          )
  )
}

histogram_server <- function(id, parent, data, btn, btn_next, color, engine, file, flag) {
  moduleServer(id, function(input, output, session) {

    ns <- session$ns

    observeEvent(btn(), {
      updateTextInput(session, "bar_color", "Bar Color", color())
      updateCheckboxInput(session, "interactive", "Interactive",
                          as.logical(engine()))
      updateRadioButtons(session, "download_type", "",
                         c("PNG" = "png",
                           "JPEG" = "jpeg"), file(), inline = TRUE)
    })

    output$plot_output <- renderUI({
      if (input$interactive) {
        threeDots(plotlyOutput(ns("plotly_hist")), color = "#0f1a34")
      } else {
        fluidRow(
          threeDots(plotOutput(ns("plot_hist")), color = "#0f1a34")
        )

      }
    })

    hist_plot <- reactiveVal()

    observeEvent(btn_next(), {

            hist_plot(
              rfm_plot_histogram(
                data(), input$metric, input$bins, input$bar_color,
                input$plot_title, input$x_axis_label, input$y_axis_label,
                input$interactive))

        if (input$interactive) {
          output$plotly_hist <- renderPlotly({
              # hist_plot() %>%
                config(hist_plot(), displayModeBar = TRUE,
                       modeBarButtonsToRemove = c("zoom2d", "zoomIn2d",
                                                  "zoomOut2d", "pan2d",
                                                  "lasso2d", "autoScale2d",
                                                  "select2d", "resetScale2d"))
          })
        } else {
          output$plot_hist <- renderPlot({ hist_plot() })
        }
    })

    observe({
      updateTextInput(session, "plot_title", "Plot title",
                      paste(to_title_case(input$metric), " Distribution"))
      updateTextInput(session, "x_axis_label", "X Axis Label",
                      to_title_case(input$metric))
    })

    observeEvent(input$btn_resize, {
      if (flag() == "restore_project" || flag() == "clone_project") {
        restore_flag <- global$plot_flag$histogram
        if (!restore_flag) {
          inputs <- global$proj_info$histogram
          if (!is.null(inputs)) {
            hist_plot(
              rfm_plot_histogram(
                data(), inputs[1], as.numeric(inputs[6]), inputs[5], inputs[2],
                inputs[3], inputs[4], inputs[7]))

            updateSelectInput(session, "metric", "Metric",
                              c("Recency" = "recency",
                                "Frequency" = "frequency",
                                "Monetary Value" = "monetary"),
                              inputs[1])
            updateTextInput(session, "plot_title", "Plot title",
                            inputs[2])
            updateTextInput(session, "x_axis_label", "X Axis Label", inputs[3])
            updateTextInput(session, "y_axis_label", "Y Axis Label", inputs[4])
            updateTextInput(session, "bar_color", "Bar Color", inputs[5])
            updateNumericInput(session, "bins", "", as.numeric(inputs[6]))
            updateCheckboxInput(session, "interactive", "Interactive",
                                as.logical(inputs[7]))

            output$plot_hist <- renderPlot({
              hist_plot()
            })

            restore_histogram()
          } else {

            hist_plot(
              rfm_plot_histogram(
                data(), input$metric, input$bins, input$bar_color,
                input$plot_title, input$x_axis_label, input$y_axis_label,
                input$interactive))
            output$plot_hist <- renderPlot({ hist_plot() })
          }
        } else {
          hist_plot(
            rfm_plot_histogram(
              data(), input$metric, input$bins, input$bar_color,
              input$plot_title, input$x_axis_label,
              input$y_axis_label, input$interactive))
          output$plot_hist <- renderPlot({ hist_plot() })
        }
      } else {

        hist_plot(
          rfm_plot_histogram(data(), input$metric, input$bins, input$bar_color,
                             input$plot_title, input$x_axis_label,
                             input$y_axis_label, input$interactive))

        if (input$interactive) {
          output$plotly_hist <- renderPlotly({
              # hist_plot() %>%
                config(hist_plot(), displayModeBar = TRUE,
                       modeBarButtonsToRemove = c("zoom2d", "zoomIn2d",
                                                  "zoomOut2d", "pan2d",
                                                  "lasso2d", "autoScale2d",
                                                  "select2d", "resetScale2d"))
          })
        } else {
          output$plot_hist <- renderPlot({ hist_plot() })
        }

        get_hist_opts(c(input$metric, input$plot_title,
                                 input$x_axis_label, input$y_axis_label,
                                 input$bar_color, input$bins,
                                 input$interactive))
      }

    })

    observeEvent(input$btn_reset, {
      updateSelectInput(session, "metric", "Metric",
                        c("Recency" = "recency",
                          "Frequency" = "frequency",
                          "Monetary Value" = "monetary"),
                        "recency")
      updateTextInput(session, "plot_title", "Plot title",
                      "Recency Distribution")
      updateTextInput(session, "x_axis_label", "X Axis Label", "Recency")
      updateTextInput(session, "y_axis_label", "Y Axis Label", "Count")
      updateTextInput(session, "bar_color", "Bar Color", "#0f1a34")
      updateNumericInput(session, "bins", "", 9)
      updateCheckboxInput(session, "interactive", "Interactive", FALSE)

      hist_plot(rfm_plot_histogram(data()))

      output$plot_hist <- renderPlot({ hist_plot() })

      get_hist_opts(c(input$metric, input$plot_title,
                               input$x_axis_label, input$y_axis_label,
                               input$bar_color, input$bins,
                               input$interactive))


    })

    plot_download(input, output, hist_plot,
                             paste0(input$metric, '-distribution'))

    observeEvent(input$back, {
      updateTabItems(session = parent, "tabs", "tab_orders")
    })

    observeEvent(input$`next`, {
      updateTabItems(session = parent, "tabs", "tab_heatmap")
    })
    
    return(
      list(
        btn = reactive({ input$`next` })
      )
    )

  })
}
