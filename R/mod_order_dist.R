#' Order distribution plot
#'
#' Shiny module for generating visualizing order distribution.
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
#' @importFrom plotly config plotlyOutput renderPlotly
#' @importFrom rfm rfm_plot_order_dist
#' @noRd
#'
order_dist_ui <- function(id) {
  ns <- NS(id)
  tabItem(tabName = "tab_orders",
          div(class = "tab_container btn_end",
              div(
                fluidRow(
                  plot_buttons(ns, 'Order Distribution'),
                  plot_download_options(ns),
                  column(12, align = "center", hr())
                ),
                div(class = "plot-order-dist",
                    div(class = "plot-settings",
                        div(class = "plot-details",
                            plot_minimize(ns),
                            plot_title(ns, "Customer Distribution by Orders"),
                            plot_axis_labels(ns, "Orders", "Customers"),
                            plot_bar_color(ns),
                            plot_bar_label_size(ns),
                            plot_flip(ns)
                        ),
                        plot_modify_ui(ns)
                    ),
                    div(class = "plot",
                        uiOutput(ns("plot_output"))
                    )
                )
              ),
              sidebar_highlight(ns, FALSE, "'back-tab'", TRUE)
          )
  )
}

order_dist_server <- function(id, parent, data, btn, color, engine, file, flag) {
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
        threeDots(plotlyOutput(ns("plotly_order_dist")), color = "#0f1a34")
      } else {
        fluidRow(
          threeDots(plotOutput(ns("plot_order_dist")), color = "#0f1a34")
        )
      }
    })

    order_dist_plot <- reactiveVal()

    observeEvent(input$btn_resize, {
      if (flag() == "restore_project" || flag() == "clone_project") {
        restore_flag <- global$plot_flag$order_dist
        if (!restore_flag) {
          inputs <- global$proj_info$order_dist
          if (!is.null(inputs)) {
            order_dist_plot(
              rfm_plot_order_dist(data(), inputs[7], inputs[4],
                                  inputs[1], inputs[2],
                                  inputs[3], as.numeric(inputs[6]),
                                  inputs[5], inputs[8]))

            updateTextInput(session, "plot_title", "Plot title", inputs[1])
            updateTextInput(session, "x_axis_label", "X Axis Label", inputs[2])
            updateTextInput(session, "y_axis_label", "Y Axis Label", inputs[3])
            updateTextInput(session, "bar_color", "Bar Color", inputs[4])
            updateCheckboxInput(session, "bar_label", "Bar Labels", inputs[5])
            updateNumericInput(session, "bar_label_size", "", inputs[6])
            updateCheckboxInput(session, "flip", "Flip", inputs[7])
            updateCheckboxInput(session, "interactive", "Interactive",
                                as.logical(inputs[8]))

            output$plot_order_dist <- renderPlot({
              order_dist_plot()
            })
            restore_order_dist()
          } else {

            order_dist_plot(
              rfm_plot_order_dist(
                data(), input$flip, input$bar_color,
                input$plot_title, input$x_axis_label,
                input$y_axis_label, input$bar_label_size,
                input$bar_label, input$interactive))
            output$plot_order_dist <- renderPlot({ order_dist_plot() })
          }
        } else {
          order_dist_plot(
            rfm_plot_order_dist(
              data(), input$flip, input$bar_color,
              input$plot_title, input$x_axis_label,
              input$y_axis_label, input$bar_label_size,
              input$bar_label, input$interactive))
          output$plot_order_dist <- renderPlot({ order_dist_plot() })
        }
      } else {
        order_dist_plot(
          rfm_plot_order_dist(
            data(), input$flip, input$bar_color,
            input$plot_title, input$x_axis_label,
            input$y_axis_label, input$bar_label_size,
            input$bar_label, input$interactive))

        if (input$interactive) {
          output$plotly_order_dist <- renderPlotly({
            print(
              order_dist_plot() %>%
                config(
                  displayModeBar = TRUE,
                  modeBarButtonsToRemove = c("zoom2d", "zoomIn2d",
                                             "zoomOut2d", "pan2d",
                                             "lasso2d", "autoScale2d",
                                             "select2d", "resetScale2d")))
          })
        } else {
          output$plot_order_dist <- renderPlot({ order_dist_plot() })
        }

        get_order_dist_opts(c(input$plot_title, input$x_axis_label,
                                       input$y_axis_label, input$bar_color,
                                       input$bar_label, input$bar_label_size,
                                       input$flip, input$interactive))

      }
    })

    observeEvent(input$btn_reset, {

      updateTextInput(session, "plot_title", "Plot title",
                      "Customer Distribution by Orders")
      updateTextInput(session, "x_axis_label", "X Axis Label", "Orders")
      updateTextInput(session, "y_axis_label", "Y Axis Label", "Customers")
      updateTextInput(session, "bar_color", "Bar Color", "#0f1a34")
      updateCheckboxInput(session, "bar_label", "Bar Labels", TRUE)
      updateNumericInput(session, "bar_label_size", "", 3)
      updateCheckboxInput(session, "flip", "Flip", FALSE)
      updateCheckboxInput(session, "interactive", "Interactive", FALSE)

      order_dist_plot(rfm_plot_order_dist(data()))

      output$plot_order_dist <- renderPlot({ order_dist_plot() })

      get_order_dist_opts(c(input$plot_title, input$x_axis_label,
                                     input$y_axis_label, input$bar_color,
                                     input$bar_label, input$bar_label_size,
                                     input$flip, input$interactive))

    })

    plot_download(input, output, order_dist_plot,
                             "order-distribution")

    observeEvent(input$back, {
      updateTabItems(session = parent, "tabs", "tab_rfm_score")
    })

    observeEvent(input$`next`, {
      updateTabItems(session = parent, "tabs", "tab_distributions")
    })
  })
}
