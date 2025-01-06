#' Display raw data 
#'
#' Shiny module for displaying raw data. 
#'
#' @param id Shiny module id.
#' @param parent Name of the parent session.
#' @param flag Reactive; project type flag.
#' @param data Reactive; raw data. 
#' @param input, output, session Internal parameters for {shiny}
#'
#' @noRd
#'
rawdata_ui <- function(id) {
  ns <- NS(id)
  tabItem(tabName = "tab_raw",
          div(class = "tab_container btn_end",
              div(
                fluidRow(
                  column(12, uiOutput(ns('display_raw')))
                )
              ),
              nav_btns(ns)
          )
  )
}

rawdata_server <- function(id, parent, flag, data) {
  moduleServer(id, function(input, output, session) {

    ns <- session$ns

    output$display_raw <- renderUI({
      tagList(
        tab_title('Raw Data'),
        fluidRow(
          column(12, align = "center", DTOutput(outputId = ns("view_data")))
        )
      )
    })

    output$view_data <- renderDT({
      if (flag() == "restore_project" | flag() == "clone_project") {
        global$project_data$raw_data
      } else {
      data()
      }
    })

    observeEvent(input$back, {
      updateTabItems(session = parent, "tabs", "tab_upload")
    })

    observeEvent(input$`next`, {
      if (flag() == "restore_project" | flag() == "clone_project") {
        updateTabItems(session = parent, "tabs", "tab_examine")
      } else {
        updateTabItems(session = parent, "tabs", "tab_select")
      }
    })
  })
}
