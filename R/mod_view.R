#' View data 
#'
#' Shiny module for viewing data.
#'
#' @param id Shiny module id.
#' @param parent Name of the parent session.
#' @param data Reactive; sample or user uploaded data. 
#' @param input, output, session Internal parameters for {shiny}
#'
#' @noRd
#'
view_ui <- function(id) {
  ns <- NS(id)
  tabItem(tabName = "tab_view",
          div(class = "tab_container btn_end",
              div(
                fluidRow(
                  column(12, uiOutput(ns('display_data')))
                )
              ),
              nav_btns(ns)

          )
  )
}

view_server <- function(id, parent, data) {
  moduleServer(id, function(input, output, session) {

    ns <- session$ns

    output$display_data <- renderUI({
      tagList(
        tab_title('Data'),
        fluidRow(
          column(12, align = "center", DTOutput(outputId = ns("view_data")))
        )
      )
    })

    output$view_data <- renderDT({
      data()
    })

    observeEvent(input$back, {
      updateTabItems(session = parent, "tabs", "tab_screen")
    })

    observeEvent(input$`next`, {
      updateTabItems(session = parent, "tabs", "tab_config")
    })
  })
}
