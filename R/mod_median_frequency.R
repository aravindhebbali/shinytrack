#' Median frequency plot
#' 
#' Shiny module for generating median frequency plot.
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
#' @importFrom rfm rfm_plot_median_frequency
#' @noRd
#'
median_frequency_ui <- function(id) {
  ns <- NS(id)
  tabItem(tabName = "tab_median_frequency",
          div(class = "tab_container btn_end",
              div(
                fluidRow(
                  plot_buttons(ns, 'Median Frequency'),
                  plot_download_options(ns),
                  column(12, align = "center", hr())
                ),
                div(class = "plot-order-dist",
                    div(class = "plot-settings",
                        div(class = "plot-details",
                            plot_minimize(ns),
                            plot_title(ns, "Median Frequency by Segment"),
                            plot_axis_labels(ns, "Segment", "Median Frequency"),
                            plot_bar_label_color(ns),
                            plot_axis_angle(ns),
                            plot_sort(ns),
                            plot_flip(ns)
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

median_frequency_server <- function(id, parent, data, btn, btn_next, color, engine, file, flag) {
  moduleServer(id, function(input, output, session) {

    ns <- session$ns

    observeEvent(btn(), {
      updateTextInput(session, "bar_color", "Bar Color", color())
      updateCheckboxInput(
        session, "interactive", "Interactive", as.logical(engine()))

      updateRadioButtons(session, "download_type", "",
                         c("PNG" = "png",
                           "JPEG" = "jpeg"), file(), inline = TRUE)
    })

    output$plot_output <- renderUI({
      if (input$interactive) {
        threeDots(plotlyOutput(ns("plotly_median_frequency")), color = "#0f1a34")
      } else {
        threeDots(plotOutput(ns("plot_median_frequency")), color = "#0f1a34")
      }
    })

    median_frequency_plot <- reactiveVal()

    observeEvent(btn_next(), {
        median_frequency_plot(
          rfm_plot_median_frequency(
            data(), input$sort, input$ascending, input$flip,
            input$bar_color, input$plot_title,
            input$x_axis_label, input$y_axis_label,
            input$axis_label_size, input$axis_label_angle,
            input$bar_label, input$interactive))

        if (input$interactive) {
          output$plotly_median_frequency <- renderPlotly({
              median_frequency_plot() %>%
                config(displayModeBar = TRUE,
                       modeBarButtonsToRemove = c("zoom2d", "zoomIn2d",
                                                  "zoomOut2d", "pan2d",
                                                  "lasso2d", "autoScale2d",
                                                  "select2d", "resetScale2d"))
          })
        } else {
          output$plot_median_frequency <- renderPlot({ median_frequency_plot() })
        }
    })

    observeEvent(input$btn_resize, {
      if (flag() == "restore_project" || flag() == "clone_project") {
        restore_flag <- global$plot_flag$med_frequency
        if (!restore_flag) {
          inputs <- global$proj_info$median_frequency
          if (!is.null(inputs)) {
            median_frequency_plot(
              rfm_plot_median_frequency(
                data(), as.logical(inputs[8]), as.logical(inputs[9]),
                as.logical(inputs[10]), inputs[5], inputs[1], inputs[2],
                inputs[3], as.numeric(inputs[6]), as.numeric(inputs[7]),
                as.logical(inputs[4]), as.logical(inputs[11])
              )
            )

            updateTextInput(session, "plot_title", "Plot title", inputs[1])
            updateTextInput(session, "x_axis_label", "X Axis Label", inputs[2])
            updateTextInput(session, "y_axis_label", "Y Axis Label", inputs[3])
            updateTextInput(session, "bar_color", "Bar Color", inputs[5])
            updateCheckboxInput(session, "bar_label", "Bar Labels",
                                as.logical(inputs[4]))
            updateNumericInput(session, "axis_label_size", "",
                               as.numeric(inputs[6]))
            updateNumericInput(session, "axis_label_angle", "",
                               as.numeric(inputs[7]))
            updateCheckboxInput(session, "sort", "Sort", as.logical(inputs[8]))
            updateCheckboxInput(session, "ascending", "Ascending",
                                as.logical(inputs[9]))
            updateCheckboxInput(session, "flip", "Flip", as.logical(inputs[10]))
            updateCheckboxInput(session, "interactive", "Interactive",
                                as.logical(inputs[11]))


            output$plot_median_frequency <- renderPlot({
              median_frequency_plot()
            })

            restore_med_frequency()
          } else {
            median_frequency_plot(
              rfm_plot_median_frequency(
                data(), input$sort, input$ascending, input$flip, input$bar_color,
                input$plot_title, input$x_axis_label, input$y_axis_label,
                input$axis_label_size, input$axis_label_angle, input$bar_label,
                input$interactive
              )
            )

            output$plot_median_frequency <- renderPlot({ median_frequency_plot() })
          }
        } else {
          median_frequency_plot(
            rfm_plot_median_frequency(
              data(), input$sort, input$ascending, input$flip, input$bar_color,
              input$plot_title, input$x_axis_label, input$y_axis_label,
              input$axis_label_size, input$axis_label_angle, input$bar_label,
              input$interactive
            )
          )

          output$plot_median_frequency <- renderPlot({ median_frequency_plot() })
        }
      } else {


        median_frequency_plot(
          rfm_plot_median_frequency(
            data(), input$sort, input$ascending, input$flip,
            input$bar_color, input$plot_title,
            input$x_axis_label, input$y_axis_label,
            input$axis_label_size, input$axis_label_angle,
            input$bar_label, input$interactive))

        if (input$interactive) {
          output$plotly_median_frequency <- renderPlotly({
              median_frequency_plot() %>%
                config(displayModeBar = TRUE,
                       modeBarButtonsToRemove = c("zoom2d", "zoomIn2d",
                                                  "zoomOut2d", "pan2d",
                                                  "lasso2d", "autoScale2d",
                                                  "select2d", "resetScale2d"))
          })
        } else {
          output$plot_median_frequency <- renderPlot({ median_frequency_plot() })
        }

        get_med_frequency_opts(c(input$plot_title, input$x_axis_label,
                                          input$y_axis_label, input$bar_label,
                                          input$bar_color, input$axes_label_size,
                                          input$axes_label_angle, input$sort,
                                          input$ascending, input$flip,
                                          input$interactive))
      }

    })

    observeEvent(input$btn_reset, {
      updateTextInput(session, "plot_title", "Plot title",
                      "Median Frequency by Segment")
      updateTextInput(session, "x_axis_label", "X Axis Label", "Segment")
      updateTextInput(session, "y_axis_label", "Y Axis Label",
                      "Median Frequency")
      updateTextInput(session, "bar_color", "Bar Color", "#0f1a34")
      updateCheckboxInput(session, "bar_label", "Bar Labels", TRUE)
      updateNumericInput(session, "axis_label_size", "", 8)
      updateNumericInput(session, "axis_label_angle", "", 315)
      updateCheckboxInput(session, "sort", "Sort", FALSE)
      updateCheckboxInput(session, "ascending", "Ascending", FALSE)
      updateCheckboxInput(session, "flip", "Flip", FALSE)
      updateCheckboxInput(session, "interactive", "Interactive", FALSE)

      median_frequency_plot(rfm_plot_median_frequency(data()))

      output$plot_median_frequency <- renderPlot({ median_frequency_plot() })

      get_med_frequency_opts(c(input$plot_title, input$x_axis_label,
                                        input$y_axis_label, input$bar_label,
                                        input$bar_color, input$axes_label_size,
                                        input$axes_label_angle, input$sort,
                                        input$ascending, input$flip,
                                        input$interactive))

    })

    plot_download(input, output, median_frequency_plot,
                             "median-frequency-plot")

    observeEvent(input$back, {
      updateTabItems(session = parent, "tabs", "tab_median_recency")
    })

    observeEvent(input$`next`, {
      updateTabItems(session = parent, "tabs", "tab_median_monetary")
    })

    return(reactive({ input$`next` }))

  })
}
