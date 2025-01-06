#' Screen data 
#'
#' Shiny module for data screening. 
#'
#' @param id Shiny module id.
#' @param parent Name of the parent session.
#' @param data Reactive; sample or user uploaded data. 
#' @param input, output, session Internal parameters for {shiny}
#'
#' @importFrom descriptr ds_screener
#' @noRd
#'
screen_ui <- function(id) {
  ns <- NS(id)
  tabItem(tabName = "tab_screen",
          div(class = "tab_container btn_end",
              div(
                fluidRow(
                  column(12, uiOutput(ns('screen_data'))),
                  column(12, uiOutput(ns('missing_info')))
                )
              ),
              nav_btns(ns)
          )
  )
}

screen_server <- function(id, parent, data) {
  moduleServer(id, function(input, output, session) {
    ns <- session$ns

    output$screen_data <- renderUI({

      x <- ds_screener(data())
      n <- as.integer(length(x$Variables))

      div( class = "screen-data",
           fluidRow(
             column(6, align = "left", h3("Data Screening")),
             column(6, align = "right",
                    a("", target = "_blank",
                      href = "https://rfm.rsquaredacademy.com",
                      icon("circle-question", "fa-2x"))
             ),
             column(12, align = "left",
                    p("Check column names, data types and examine data for missing values"))
           ),
           fluidRow(hr()),

           fluidRow(
             column(12, align = "center",
                    column(3, h4("Column")),
                    column(2, h4("Data Type")),
                    column(3, h4("Categories")),
                    column(2, h4("Missing")),
                    column(2, h4("Missing(%)"))
             )
           ),

           fluidRow(hr()),

           lapply(1:n, function(i) {
             fluidRow(
               column(12, align = "center",
                      column(3, p(x$Variables[i])),
                      column(2, p(x$Types[i])),
                      column(3, p(x$levels[i])),
                      column(2, p(x$Missing[i])),
                      column(2, p(x$MissingPer[i]))
               )
             )
           }),

           fluidRow(hr()),

           fluidRow(
             checkboxInput(ns("display_missing"),
                           "Display row/column level missing value info")
           )
      )
    })

    output$missing_info <- renderUI({

      req(input$display_missing)

      if (input$display_missing) {

        x <- ds_screener(data())

        div(class = "screen-info",
            fluidRow(
              column(12, align = "center", h4("Missing Values")),
              column(12, align = "center", hr())
            ),
            fluidRow(
              column(3, align = "left", offset = 1, h5("Rows")),
              column(2, align = "right", p(nrow(data()))),
              column(3, align = "left", offset = 1, h5("Columns")),
              column(1, align = "right", p(ncol(data())))
            ),
            fluidRow(
              column(3, align = "left", offset = 1,
                     h5("Rows with missing values")),
              column(2, align = "right", p(x$MissingRows)),
              column(3, align = "left", offset = 1,
                     h5("Columns with missing values")),
              column(1, align = "right", p(x$MissingCols))
            ),
            fluidRow(
              column(3, align = "left", offset = 1,
                     h5("Overall missing values")),
              column(2, align = "right", p(x$MissingTotal)),
              column(3, align = "left", offset = 1,
                     h5("% of missing values")),
              column(1, align = "right", p(paste0(x$MissingTotPer, "%")))
            )
        )
      }

    })

    observeEvent(input$back, {
      updateTabItems(session = parent, "tabs", "tab_transform")
    })

    observeEvent(input$`next`, {
      updateTabItems(session = parent, "tabs", "tab_view")
    })
  })
}
