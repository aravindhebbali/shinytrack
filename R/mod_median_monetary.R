#' Median monetary plot
#' 
#' Shiny module for generating median monetary plot.
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
#' @importFrom rfm rfm_plot_median_monetary
#' @noRd
#'
median_monetary_ui <- function(id) {
  ns <- NS(id)
  tabItem(tabName = "tab_median_monetary",
          div(class = "tab_container btn_end",
              div(
                fluidRow(
                  plot_buttons(ns, 'Median Monetary Value'),
                  plot_download_options(ns),
                  column(12, align = "center", hr())
                ),
                div(class = "plot-order-dist",
                    div(class = "plot-settings",
                        div(class = "plot-details",
                            plot_minimize(ns),
                            plot_title(ns, "Median Monetary by Segment"),
                            plot_axis_labels(ns, "Segment", "Median Monetary"),
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
              sidebar_highlight(ns, TRUE, "'median'", TRUE)
          )
  )
}

median_monetary_server <- function(id, parent, data, btn, color, engine, file, flag) {
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
        threeDots(plotlyOutput(ns("plotly_median_monetary")), color = "#0f1a34")
      } else {
        threeDots(plotOutput(ns("plot_median_monetary")), color = "#0f1a34")
      }
    })

    median_monetary_plot <- reactiveVal()

    observeEvent(input$btn_resize, {
      if (flag() == "restore_project" || flag() == "clone_project") {
        restore_flag <- global$plot_flag$med_monetary
        if (!restore_flag) {
          inputs <- global$proj_info$median_monetary
          if (!is.null(inputs)) {
            median_monetary_plot(
              rfm_plot_median_monetary(
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

            output$plot_median_monetary <- renderPlot({
              median_monetary_plot()
            })

            restore_med_monetary()
          } else {
            median_monetary_plot(
              rfm_plot_median_monetary(
                data(), input$sort, input$ascending, input$flip, input$bar_color,
                input$plot_title, input$x_axis_label, input$y_axis_label,
                input$axis_label_size, input$axis_label_angle, input$bar_label,
                input$interactive
              )
            )

            output$plot_median_monetary <- renderPlot({ median_monetary_plot() })
          }
        } else {
          median_monetary_plot(
            rfm_plot_median_monetary(
              data(), input$sort, input$ascending, input$flip, input$bar_color,
              input$plot_title, input$x_axis_label, input$y_axis_label,
              input$axis_label_size, input$axis_label_angle, input$bar_label,
              input$interactive
            )
          )

          output$plot_median_monetary <- renderPlot({ median_monetary_plot() })
        }
      } else {


        median_monetary_plot(
          rfm_plot_median_monetary(
            data(), input$sort, input$ascending, input$flip,
            input$bar_color, input$plot_title,
            input$x_axis_label, input$y_axis_label,
            input$axis_label_size, input$axis_label_angle,
            input$bar_label, input$interactive))

        if (input$interactive) {
          output$plotly_median_monetary <- renderPlotly({
            print(
              median_monetary_plot() %>%
                config(displayModeBar = TRUE,
                       modeBarButtonsToRemove = c("zoom2d", "zoomIn2d",
                                                  "zoomOut2d", "pan2d",
                                                  "lasso2d", "autoScale2d",
                                                  "select2d", "resetScale2d")))
          })
        } else {
          output$plot_median_monetary <- renderPlot({ median_monetary_plot() })
        }

        get_med_monetary_opts(c(input$plot_title, input$x_axis_label,
                                         input$y_axis_label, input$bar_label,
                                         input$bar_color, input$axes_label_size,
                                         input$axes_label_angle, input$sort,
                                         input$ascending, input$flip,
                                         input$interactive))
      }

    })

    observeEvent(input$btn_reset, {
      updateTextInput(session, "plot_title", "Plot title",
                      "Median Monetary by Segment")
      updateTextInput(session, "x_axis_label", "X Axis Label", "Segment")
      updateTextInput(session, "y_axis_label", "Y Axis Label",
                      "Median Monetary")
      updateTextInput(session, "bar_color", "Bar Color", "#0f1a34")
      updateCheckboxInput(session, "bar_label", "Bar Labels", TRUE)
      updateNumericInput(session, "axis_label_size", "", 8)
      updateNumericInput(session, "axis_label_angle", "", 315)
      updateCheckboxInput(session, "sort", "Sort", FALSE)
      updateCheckboxInput(session, "ascending", "Ascending", FALSE)
      updateCheckboxInput(session, "flip", "Flip", FALSE)
      updateCheckboxInput(session, "interactive", "Interactive", FALSE)

      median_monetary_plot(rfm_plot_median_monetary(data()))

      output$plot_median_monetary <- renderPlot({ median_monetary_plot() })

      get_med_monetary_opts(c(input$plot_title, input$x_axis_label,
                                       input$y_axis_label, input$bar_label,
                                       input$bar_color, input$axes_label_size,
                                       input$axes_label_angle, input$sort,
                                       input$ascending, input$flip,
                                       input$interactive))


    })

    plot_download(input, output, median_monetary_plot,
                             "median-monetary-plot")

    observeEvent(input$back, {
      updateTabItems(session = parent, "tabs", "tab_median_frequency")
    })

    observeEvent(input$`next`, {
      updateTabItems(session = parent, "tabs", "tab_scatter_plot")
    })
  })
}
