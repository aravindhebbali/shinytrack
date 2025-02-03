#' Revenue plot
#' 
#' Shiny module for generating revenue distribution plot.
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
#' @importFrom rfm rfm_plot_revenue_dist
#' @noRd
#'
revenue_plot_ui <- function(id) {
  ns <- NS(id)
  tabItem(tabName = "tab_revenue_plot",
          div(class = "tab_container btn_end",
              div(
                fluidRow(
                  plot_buttons(ns, 'Revenue Distribution'),
                  plot_download_options(ns),
                  column(12, align = "center", hr())
                ),
                div(class = "plot-order-dist",
                    div(class = "plot-settings",
                        div(class = "plot-details",
                            plot_minimize(ns),
                            plot_title(ns, "Revenue & Customer Distribution"),
                            plot_axis_labels(ns, "", ""),
                            plot_revenue_colors(ns),
                            plot_revenue_labels(ns),
                            plot_bar_label_size(ns),
                            plot_axis_angle(ns),
                            plot_flip(ns)
                        ),
                        plot_modify_ui(ns)
                    ),
                    div(class = "plot",
                        uiOutput(ns("plot_output"))
                    )
                )
              ),
              sidebar_highlight(ns, TRUE, "'revenue-next'", TRUE)
          )
  )
}

revenue_plot_server <- function(id, parent, data, btn, btn_next, engine, file, flag) {
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
        threeDots(plotlyOutput(ns("plotly_revenue")), color = "#0f1a34")
      } else {
        threeDots(plotOutput(ns("plot_revenue")), color = "#0f1a34")
      }
    })

    revenue_plot <- reactiveVal()

    observeEvent(btn_next(), {
        revenue_plot(
          rfm_plot_revenue_dist(
            data(), input$flip,
            c(input$color_revenue, input$color_customer),
            c(input$label_revenue, input$label_customer),
            input$plot_title, input$x_axis_label,
            input$y_axis_label, input$axis_label_size,
            input$axis_label_angle, input$bar_label,
            input$bar_label_size, input$interactive))

        if (input$interactive) {
          output$plotly_revenue <- renderPlotly({
              # revenue_plot() %>%
                config(revenue_plot(),
                  displayModeBar = TRUE,
                  modeBarButtonsToRemove = c("zoom2d", "zoomIn2d",
                                             "zoomOut2d", "pan2d",
                                             "lasso2d", "autoScale2d",
                                             "select2d", "resetScale2d"))
          })
        } else {
          output$plot_revenue <- renderPlot({ revenue_plot() })
        }
    })

    observeEvent(input$btn_resize, {
      if (flag() == "restore_project" || flag() == "clone_project") {
        restore_flag <- global$plot_flag$revenue_plot
        if (!restore_flag) {
          inputs <- global$proj_info$revenue_plot
          if (!is.null(inputs)) {
            revenue_plot(
              rfm_plot_revenue_dist(
                data(), as.logical(inputs[12]), c(inputs[4], inputs[5]),
                c(inputs[6], inputs[7]), inputs[1], inputs[2], inputs[3],
                as.numeric(inputs[10]), as.numeric(inputs[11]),
                as.logical(inputs[8]), as.numeric(inputs[9]),
                as.logical(inputs[13])
              )
            )

            updateTextInput(session, "plot_title", "Plot title", inputs[1])
            updateTextInput(session, "x_axis_label", "X Axis Label", inputs[2])
            updateTextInput(session, "y_axis_label", "Y Axis Label", inputs[3])
            updateTextInput(session, "color_revenue", "Revenue", inputs[4])
            updateTextInput(session, "color_customer", "Customer", inputs[5])
            updateTextInput(session, "label_revenue", "Revenue", inputs[6])
            updateTextInput(session, "label_customer", "Customer", inputs[7])
            updateCheckboxInput(
              session, "bar_label", "Bar Labels", as.logical(inputs[8]))
            updateNumericInput(
              session, "bar_label_size", "", as.numeric(inputs[9]))
            updateNumericInput(
              session, "axis_label_size", "", as.numeric(inputs[10]))
            updateNumericInput(
              session, "axis_label_angle", "", as.numeric(inputs[11]))
            updateCheckboxInput(session, "flip", "Flip", as.logical(inputs[12]))
            updateCheckboxInput(
              session, "interactive", "Interactive", as.logical(inputs[13]))

            output$plot_revenue <- renderPlot({
              revenue_plot()
            })

            restore_revenue_plot()
          } else {
            revenue_plot(rfm_plot_revenue_dist(data()))
            output$plot_revenue <- renderPlot({
              rfm_plot_revenue_dist(
                data(), input$flip,
                c(input$color_revenue, input$color_customer),
                c(input$label_revenue, input$label_customer),
                input$plot_title, input$x_axis_label,
                input$y_axis_label, input$axis_label_size,
                input$axis_label_angle, input$bar_label,
                input$bar_label_size, input$interactive)
            })
          }
        } else {
          revenue_plot(rfm_plot_revenue_dist(data()))
          output$plot_revenue <- renderPlot({
            rfm_plot_revenue_dist(
              data(), input$flip,
              c(input$color_revenue, input$color_customer),
              c(input$label_revenue, input$label_customer),
              input$plot_title, input$x_axis_label,
              input$y_axis_label, input$axis_label_size,
              input$axis_label_angle, input$bar_label,
              input$bar_label_size, input$interactive)
          })
        }
      } else {


        revenue_plot(
          rfm_plot_revenue_dist(
            data(), input$flip,
            c(input$color_revenue, input$color_customer),
            c(input$label_revenue, input$label_customer),
            input$plot_title, input$x_axis_label,
            input$y_axis_label, input$axis_label_size,
            input$axis_label_angle, input$bar_label,
            input$bar_label_size, input$interactive))

        if (input$interactive) {
          output$plotly_revenue <- renderPlotly({
              # revenue_plot() %>%
                config(revenue_plot(),
                  displayModeBar = TRUE,
                  modeBarButtonsToRemove = c("zoom2d", "zoomIn2d",
                                             "zoomOut2d", "pan2d",
                                             "lasso2d", "autoScale2d",
                                             "select2d", "resetScale2d"))
          })
        } else {
          output$plot_revenue <- renderPlot({ revenue_plot() })
        }

        get_revenue_plot_opts(
          c(input$plot_title, input$x_axis_label, input$y_axis_label,
            input$color_revenue, input$color_customer, input$label_revenue,
            input$label_customer, input$bar_label, input$bar_label_size,
            input$axis_label_size, input$axis_label_angle, input$flip,
            input$interactive))
      }

    })

    observeEvent(input$btn_reset, {

      updateTextInput(session, "plot_title", "Plot title",
                      "Revenue & Customer Distribution")
      updateTextInput(session, "x_axis_label", "X Axis Label", "")
      updateTextInput(session, "y_axis_label", "Y Axis Label", "")
      updateTextInput(session, "color_revenue", "Revenue", "#3b5bdb")
      updateTextInput(session, "color_customer", "Customer", "#91a7ff")
      updateTextInput(session, "label_revenue", "Revenue", "Revenue")
      updateTextInput(session, "label_customer", "Customer", "Customers")
      updateCheckboxInput(session, "bar_label", "Bar Labels", FALSE)
      updateNumericInput(session, "bar_label_size", "", 2)
      updateNumericInput(session, "axis_label_size", "", 8)
      updateNumericInput(session, "axis_label_angle", "", 315)
      updateCheckboxInput(session, "flip", "Flip", FALSE)
      updateCheckboxInput(session, "interactive", "Interactive", FALSE)

      revenue_plot(rfm_plot_revenue_dist(data()))

      output$plot_revenue <- renderPlot({ revenue_plot() })

      get_revenue_plot_opts(
        c(input$plot_title, input$x_axis_label, input$y_axis_label,
          input$color_revenue, input$color_customer, input$label_revenue,
          input$label_customer, input$bar_label, input$bar_label_size,
          input$axis_label_size, input$axis_label_angle, input$flip,
          input$interactive))


    })

    plot_download(input, output, revenue_plot, "revenue-plot")

    observeEvent(input$back, {
      updateTabItems(session = parent, "tabs", "tab_segment_summary_plot")
    })

    observeEvent(input$`next`, {
      updateTabItems(session = parent, "tabs", "tab_median_recency")
    })

    return(reactive({ input$`next` }))

  })
}
