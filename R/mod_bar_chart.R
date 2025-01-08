#' Bar chart 
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
#' @importFrom rfm rfm_plot_bar_chart
#' @noRd
#' 
bar_chart_ui <- function(id) {
  ns <- NS(id)
  tabItem(tabName = "tab_bar_chart",
          div(class = "tab_container btn_end",
              div(
                fluidRow(
                  plot_buttons(ns, 'Bar Chart'),
                  plot_download_options(ns),
                  column(12, align = "center", hr())
                ),
                div(class = "plot-order-dist",
                    div(class = "plot-settings",
                        div(class = "plot-details",
                            plot_minimize(ns),
                            plot_bar_primary_axis(ns),
                            plot_bar_secondary_axis(ns),
                            plot_bar_color(ns)
                        ),
                        plot_modify_ui(ns)
                    ),
                    div(class = "plot",
                        threeDots(
                          plotOutput(ns("plot_bar_chart")), color = "#0f1a34")
                    )
                )
              ),
              sidebar_highlight(ns, TRUE, "'next-tab'", TRUE)
          )
  )
}

bar_chart_server <- function(id, parent, data, btn, btn_next, color, file, flag) {
  moduleServer(id, function(input, output, session) {

    ns <- session$ns

    observeEvent(btn(), {
      updateTextInput(session, "bar_color", "Bar Color", color())
      updateRadioButtons(session, "download_type", "",
                         c("PNG" = "png",
                           "JPEG" = "jpeg"), file(), inline = TRUE)
    })

    bar_chart <- reactiveVal()

    observeEvent(btn_next(), {
        bar_chart(
          rfm_plot_bar_chart(data(), input$bar_color, input$x_axis_label,
                             input$sec_x_axis_label, input$y_axis_label,
                             input$sec_y_axis_label))

        output$plot_bar_chart <- renderPlot({ bar_chart() })
    })

    observeEvent(input$btn_resize, {
      if (flag() == "restore_project" || flag() == "clone_project") {
        restore_flag <- global$plot_flag$bar_chart
        if (!restore_flag) {
          inputs <- global$proj_info$bar_chart
          if (!is.null(inputs)) {
            bar_chart(rfm_plot_bar_chart(data(), inputs[5], inputs[1], inputs[3],
                                         inputs[2], inputs[4]))

            updateTextInput(session, "bar_color", "Bar Color", inputs[5])
            updateTextInput(session, "x_axis_label", "X Axis", inputs[1])
            updateTextInput(session, "y_axis_label", "Y Axis", inputs[2])
            updateTextInput(session, "sec_x_axis_label", "X Axis", inputs[3])
            updateTextInput(session, "sec_y_axis_label", "Y Axis", inputs[4])

            output$plot_bar_chart <- renderPlot({
              bar_chart()
            })
            restore_bar_chart()
          } else {
            bar_chart(
              rfm_plot_bar_chart(
                data(), input$bar_color, input$x_axis_label,
                input$sec_x_axis_label, input$y_axis_label,
                input$sec_y_axis_label))
            output$plot_bar_chart <- renderPlot({ bar_chart() })
          }
        } else {
          bar_chart(
            rfm_plot_bar_chart(
              data(), input$bar_color, input$x_axis_label,
              input$sec_x_axis_label, input$y_axis_label,
              input$sec_y_axis_label))
          output$plot_bar_chart <- renderPlot({ bar_chart() })
        }
      } else {
        bar_chart(
          rfm_plot_bar_chart(data(), input$bar_color, input$x_axis_label,
                             input$sec_x_axis_label, input$y_axis_label,
                             input$sec_y_axis_label))

        output$plot_bar_chart <- renderPlot({ bar_chart() })

        get_barchart_opts(c(input$x_axis_label, input$y_axis_label,
                                     input$sec_x_axis_label,
                                     input$sec_y_axis_label, input$bar_color))
      }
    })

    observeEvent(input$btn_reset, {
      updateTextInput(session, "bar_color", "Bar Color", "#0f1a34")
      updateTextInput(session, "x_axis_label", "X Axis", "Monetary Score")
      updateTextInput(session, "y_axis_label", "Y Axis", "")
      updateTextInput(session, "sec_x_axis_label", "X Axis", "Frequency Score")
      updateTextInput(session, "sec_y_axis_label", "Y Axis", "Recency Score")

      bar_chart(rfm_plot_bar_chart(data()))

      output$plot_bar_chart <- renderPlot({ bar_chart() })

      get_barchart_opts(c(input$x_axis_label, input$y_axis_label,
                                   input$sec_x_axis_label,
                                   input$sec_y_axis_label, input$bar_color))


    })

    plot_download(input, output, bar_chart, "rfm-bar-chart")

    observeEvent(input$back, {
      updateTabItems(session = parent, "tabs", "tab_heatmap")
    })

    observeEvent(input$`next`, {
      updateTabItems(session = parent, "tabs", "tab_generate_segments")
    })
  })
}
