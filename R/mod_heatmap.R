#' Heatmap 
#'
#' Shiny module for visualizing RFM score distribution. 
#'
#' @param id Shiny module id.
#' @param parent Name of the parent session.
#' @param data Reactive; sample or user submitted data.
#' @param btn Reactive; rfm score generation button.
#' @param bins Reactive: heatmap bins.
#' @param color Reactive; plot color.
#' @param engine Reactive; plotting engine.
#' @param file Reactive; download file type.
#' @param flag Reactive; project type.
#' @param input, output, session Internal parameters for {shiny}.
#'
#' @importFrom rfm rfm_plot_heatmap
#' @noRd
#' 
heatmap_ui <- function(id) {
  ns <- NS(id)
  tabItem(tabName = "tab_heatmap",
          div(class = "tab_container btn_end",
              div(
                fluidRow(
                  plot_buttons(ns, 'Heat Map'),
                  plot_download_options(ns),
                  column(12, align = "center", hr())
                ),
                div(class = "plot-order-dist",
                    div(class = "plot-settings",
                        div(class = "plot-details",
                            plot_minimize(ns),
                            plot_title(ns, "RFM Heat Map"),
                            plot_axis_labels(ns, "Frequency Score", "Recency Score"),
                            plot_brewer_name(ns),
                            plot_legend_title(ns, "Mean Monetary Value"),
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

heatmap_server <- function(id, parent, data, btn, bins, engine, file, flag) {
  moduleServer(id, function(input, output, session) {

    ns <- session$ns

    observeEvent(btn(), {
      updateCheckboxInput(session, "interactive", "Interactive",
                          as.logical(engine()))
      updateRadioButtons(session, "download_type", "",
                         c("PNG" = "png",
                           "JPEG" = "jpeg"), file(), inline = TRUE)
    })

    output$plot_output <- renderUI({
      if (input$interactive) {
        threeDots(plotlyOutput(ns("plotly_heat_map")), color = "#0f1a34")
      } else {
        fluidRow(
          threeDots(plotOutput(ns("plot_heat_map")), color = "#0f1a34")
        )
      }
    })

    heat_map <- reactiveVal()

    observeEvent(input$btn_resize, {
      if (flag() == "restore_project" || flag() == "clone_project") {
        restore_flag <- global$plot_flag$heat_map
        if (!restore_flag) {
          inputs <- global$proj_info$heatmap
          if (!is.null(inputs)) {
            heat_map(rfm_plot_heatmap(data(), bins(), inputs[4], inputs[2],
                                      inputs[3], inputs[1], inputs[5],
                                      as.logical(inputs[6])))

            updateTextInput(session, "plot_title", "Plot title", inputs[1])
            updateTextInput(session, "x_axis_label", "X Axis Label", inputs[2])
            updateTextInput(session, "y_axis_label", "Y Axis Label", inputs[3])
            updateTextInput(session, "brewer_name", "Brewer Name", inputs[4])
            updateTextInput(session, "legend_title", "Legend Title", inputs[5])
            updateCheckboxInput(session, "interactive", "Interactive",
                                as.logical(inputs[6]))

            output$plot_heat_map <- renderPlot({
              heat_map()
            })
            restore_heat_map()
          } else {
            heat_map(rfm_plot_heatmap(data(), bins(), input$brewer_name,
                                      input$x_axis_label, input$y_axis_label,
                                      input$plot_title, input$legend_title,
                                      input$interactive))
            output$plot_heat_map <- renderPlot({ heat_map() })
          }
        } else {
          heat_map(rfm_plot_heatmap(data(), bins(), input$brewer_name,
                                    input$x_axis_label, input$y_axis_label,
                                    input$plot_title, input$legend_title,
                                    input$interactive))
          output$plot_heat_map <- renderPlot({ heat_map() })
        }
      } else {


        heat_map(rfm_plot_heatmap(data(), bins(), input$brewer_name,
                                  input$x_axis_label, input$y_axis_label,
                                  input$plot_title, input$legend_title,
                                  input$interactive))

        if (input$interactive) {
          output$plotly_heat_map <- renderPlotly({
            print(
              heat_map() %>%
                config(displayModeBar = TRUE,
                       modeBarButtonsToRemove = c("zoom2d", "zoomIn2d",
                                                  "zoomOut2d", "pan2d",
                                                  "lasso2d", "autoScale2d",
                                                  "select2d", "resetScale2d")))
          })
        } else {
          output$plot_heat_map <- renderPlot({ heat_map() })
        }

        get_heatmap_opts(c(input$plot_title, input$x_axis_label,
                                    input$y_axis_label, input$brewer_name,
                                    input$legend_title, input$interactive))
      }

    })

    observeEvent(input$btn_reset, {
      updateTextInput(session, "plot_title", "Plot title", "RFM Heat Map")
      updateTextInput(session, "x_axis_label", "X Axis Label",
                      "Frequency Score")
      updateTextInput(session, "y_axis_label", "Y Axis Label", "Recency Score")
      updateTextInput(session, "brewer_name", "Brewer Name", "PuBu")
      updateTextInput(session, "legend_title", "Legend Title",
                      "Mean Monetary Value")
      updateCheckboxInput(session, "interactive", "Interactive", FALSE)

      heat_map(rfm_plot_heatmap(data()))

      output$plot_heat_map <- renderPlot({ heat_map() })

      get_heatmap_opts(c(input$plot_title, input$x_axis_label,
                                  input$y_axis_label, input$brewer_name,
                                  input$legend_title, input$interactive))


    })

    plot_download(input, output, heat_map, "rfm-heatmap")

    observeEvent(input$back, {
      updateTabItems(session = parent, "tabs", "tab_distributions")
    })

    observeEvent(input$`next`, {
      updateTabItems(session = parent, "tabs", "tab_bar_chart")
    })
  })
}
