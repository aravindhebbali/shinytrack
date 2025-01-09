#' Segment summary plot
#' 
#' Shiny module for generating segment summary plot.
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
#' @importFrom rfm rfm_plot_segment_summary
#' @noRd
#'
segment_summary_plot_ui <- function(id) {
  ns <- NS(id)
  tabItem(tabName = "tab_segment_summary_plot",
          div(class = "tab_container btn_end",
              div(
                fluidRow(
                  plot_buttons(ns, 'Segment Summary Plot'),
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
                                     selectInput(ns("metric"), "",
                                                 c("Customers" = "customers",
                                                   "Orders" = "orders",
                                                   "Revenue" = "revenue",
                                                   "AOV" = "aov"),
                                                 "customers"))
                            ),
                            plot_title(ns, "Customer Distribution by Segment"),
                            plot_axis_labels(ns, "Segment", "Customers"),
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

segment_summary_plot_server <- function(id, parent, data, btn, btn_next, color, engine, file, flag) {
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
        threeDots(plotlyOutput(ns("plotly_segment_summary")), color = "#0f1a34")
      } else {
        threeDots(plotOutput(ns("plot_segment_summary")), color = "#0f1a34")
      }
    })

    segment_summary_plot <- reactiveVal()

    observe({
      updateTextInput(session, "plot_title", "Plot title",
                      paste(str_to_title(input$metric),
                            "Distribution by Segment"))
      updateTextInput(session, "y_axis_label", "Y Axis Label",
                      str_to_title(input$metric))
    })

    observeEvent(btn_next(), {
          segment_summary_plot(
            rfm_plot_segment_summary(
              data(), input$metric, input$sort, input$ascending, input$flip,
              input$bar_color, input$plot_title, input$x_axis_label,
              input$y_axis_label, input$axis_label_size, input$axis_label_angle,
              input$bar_label, input$interactive))

          if (input$interactive) {
            output$plotly_segment_summary <- renderPlotly({
                segment_summary_plot() %>%
                  config(
                    displayModeBar = TRUE,
                    modeBarButtonsToRemove = c("zoom2d", "zoomIn2d",
                                               "zoomOut2d", "pan2d",
                                               "lasso2d", "autoScale2d",
                                               "select2d", "resetScale2d"))
            })
          } else {
            output$plot_segment_summary <- renderPlot({
              segment_summary_plot()
            })
          }
    })

    observeEvent(
      input$btn_resize, {
        if (flag() == "restore_project" || flag() == "clone_project") {
          restore_flag <- global$plot_flag$summary_plot
          if (!restore_flag) {
            inputs <- global$proj_info$summary_plot
            if (!is.null(inputs)) {
              segment_summary_plot(
                rfm_plot_segment_summary(
                  data(), inputs[1], as.logical(inputs[9]),
                  as.logical(inputs[10]), as.logical(inputs[11]), inputs[6],
                  inputs[2], inputs[3], inputs[4], as.numeric(inputs[7]),
                  as.numeric(inputs[8]), as.logical(inputs[5]),
                  as.logical(inputs[12])))

              updateSelectInput(session, "metric", "",
                                c("Customers" = "customers",
                                  "Orders" = "orders",
                                  "Revenue" = "revenue",
                                  "AOV" = "aov"),
                                inputs[1])

              updateTextInput(session, "plot_title", "Plot title", inputs[2])
              updateTextInput(session, "x_axis_label", "X Axis Label",
                              inputs[3])
              updateTextInput(session, "y_axis_label", "Y Axis Label",
                              inputs[4])
              updateTextInput(session, "bar_color", "Bar Color", inputs[6])
              updateCheckboxInput(
                session, "bar_label", "Bar Labels", as.logical(inputs[5]))
              updateNumericInput(
                session, "axis_label_size", "",  as.numeric(inputs[7]))
              updateNumericInput(session, "axis_label_angle", "", inputs[8])
              updateCheckboxInput(session, "sort", "Sort",
                                  as.logical(inputs[9]))
              updateCheckboxInput(
                session, "ascending", "Ascending", as.logical(inputs[10]))
              updateCheckboxInput(session, "flip", "Flip",
                                  as.logical(inputs[11]))
              updateCheckboxInput(
                session, "interactive", "Interactive", as.logical(inputs[12]))

              output$plot_segment_summary <- renderPlot({
                segment_summary_plot()
              })
              restore_summary_plot()
            } else {
              segment_summary_plot(
                rfm_plot_segment_summary(
                  data(), input$metric, input$sort, input$ascending, input$flip,
                  input$bar_color, input$plot_title, input$x_axis_label,
                  input$y_axis_label, input$axis_label_size,
                  input$axis_label_angle,
                  input$bar_label, input$interactive))

              output$plot_segment_summary <- renderPlot({
                segment_summary_plot()
              })
            }
          } else {
            segment_summary_plot(
              rfm_plot_segment_summary(
                data(), input$metric, input$sort, input$ascending, input$flip,
                input$bar_color, input$plot_title, input$x_axis_label,
                input$y_axis_label, input$axis_label_size,
                input$axis_label_angle, input$bar_label, input$interactive))

            output$plot_segment_summary <- renderPlot({
              segment_summary_plot()
            })
          }
        } else {

          segment_summary_plot(
            rfm_plot_segment_summary(
              data(), input$metric, input$sort, input$ascending, input$flip,
              input$bar_color, input$plot_title, input$x_axis_label,
              input$y_axis_label, input$axis_label_size, input$axis_label_angle,
              input$bar_label, input$interactive))

          if (input$interactive) {
            output$plotly_segment_summary <- renderPlotly({
                segment_summary_plot() %>%
                  config(
                    displayModeBar = TRUE,
                    modeBarButtonsToRemove = c("zoom2d", "zoomIn2d",
                                               "zoomOut2d", "pan2d",
                                               "lasso2d", "autoScale2d",
                                               "select2d", "resetScale2d"))
            })
          } else {
            output$plot_segment_summary <- renderPlot({
              segment_summary_plot()
            })
          }

          get_summary_plot_opts(c(input$metric, input$plot_title,
                                           input$x_axis_label,
                                           input$y_axis_label,
                                           input$bar_label, input$bar_color,
                                           input$axis_label_size,
                                           input$axis_label_angle,
                                           input$sort, input$ascending,
                                           input$flip, input$interactive))
        }

      })

    observeEvent(input$btn_reset, {
      updateSelectInput(session, "metric", "",
                        c("Customers" = "customers",
                          "Orders" = "orders",
                          "Revenue" = "revenue",
                          "AOV" = "aov"),
                        "customers")
      updateTextInput(session, "plot_title", "Plot title",
                      "Customer Distribution by Segment")
      updateTextInput(session, "x_axis_label", "X Axis Label", "Segment")
      updateTextInput(session, "y_axis_label", "Y Axis Label", "Customers")
      updateTextInput(session, "bar_color", "Bar Color", "#0f1a34")
      updateCheckboxInput(session, "bar_label", "Bar Labels", TRUE)
      updateNumericInput(session, "axis_label_size", "", 10)
      updateNumericInput(session, "axis_label_angle", "", 315)
      updateCheckboxInput(session, "sort", "Sort", FALSE)
      updateCheckboxInput(session, "ascending", "Ascending", FALSE)
      updateCheckboxInput(session, "flip", "Flip", FALSE)
      updateCheckboxInput(session, "interactive", "Interactive", FALSE)

      segment_summary_plot(rfm_plot_segment_summary(data()))

      output$plot_segment_summary <- renderPlot({
        segment_summary_plot()
      })

      get_summary_plot_opts(c(input$metric, input$plot_title,
                                       input$x_axis_label, input$y_axis_label,
                                       input$bar_label, input$bar_color,
                                       input$axis_label_size,
                                       input$axis_label_angle,
                                       input$sort, input$ascending, input$flip,
                                       input$interactive))


    })

    plot_download(input, output, segment_summary_plot,
                             "segment-summary-plot")

    observeEvent(input$back, {
      updateTabItems(session = parent, "tabs", "tab_segment_plot")
    })

    observeEvent(input$`next`, {
      updateTabItems(session = parent, "tabs", "tab_revenue_plot")
    })

    return(reactive({ input$`next` }))

  })
}
