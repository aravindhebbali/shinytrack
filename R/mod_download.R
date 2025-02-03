#' Download segments
#'
#' Shiny module for downloading segment data.
#'
#' @param id Shiny module id.
#' @param parent Name of the parent session.
#' @param data Reactive; segments data.
#' @param btn Reactive; generate segments button.
#' @param currency Reactive; currency symbol.
#' @param input, output, session Internal parameters for {shiny}
#'
#' @importFrom utils write.csv
#' @noRd
#'
download_ui <- function(id) {
  ns <- NS(id)
  tabItem(tabName = "tab_download",
          div(class = "tab_container btn_end",
              div(
                tab_title('Download Segments'),
                fluidRow(column(12, align = "center",
                                selectInput(ns("download"), label = "Download",
                                            choices = NULL, selected = NULL)),
                         column(12, align = "center",
                                downloadButton(ns("btn_download"), "Download"))
                ),
                fluidRow(
                  column(12, align = "center", DTOutput(ns("table")))
                )
              ),
              div(class = "nav-buttons",
                  fluidRow(
                    column(6, align = 'left',
                           actionButton(inputId = ns('back'), label = "Back",
                                        icon = icon("long-arrow-left"))
                    ),
                    column(6, align = 'right',
                           actionButton(
                             inputId = ns('next'), label = "Next",
                             icon = icon("long-arrow-right"),
                             onclick = "App.highlightTab(this, 'exit-tab')")
                    )
                  )
              )
          )
  )
}

download_server <- function(id, parent, data, btn, currency) {
  moduleServer(id, function(input, output, session) {

    observeEvent(btn(), {
      updateSelectInput(session, "download", label = "Download",
                        choices = c("All", unique(data()$segment)),
                        selected = "All")
    })

    download_data <- reactive({
      if (input$download == "All") {
        data()
      } else {
        subset(data(), segment == input$download)
        # data() %>%
        #   filter(segment == input$download)
      }
    })

    output$table <- 
      renderDT({
        # datatable(
        #   # data <- 
        #     download_data() %>%
        #       select(customer_id, segment, rfm_score, transaction_count, recency_days, amount) %>%
        #       set_names(c("Customer ID", "Segment", "RFM Score", "Orders", "Recency (Days)", "Revenue"))
        #   # data
        # ) %>%
        # formatCurrency(column = 6, currency = currency())
        
        cols_select <- c("customer_id", "segment", "rfm_score", 
                         "transaction_count", "recency_days", "amount")
        data <- download_data()[cols_select]
        colnames(data) <- c("Customer ID", "Segment", "RFM Score", "Orders", "Recency (Days)", "Revenue")
        formatCurrency(datatable(data), column = 6, currency = currency())

      })

    output$btn_download <- downloadHandler(
      filename = function() {
        paste0(
          paste0(
            strsplit(
              tolower(input$download), " "
            )[[1]], collapse = "_"
          ), ".csv"
        )
      },
      content = function(file) {
        write.csv(download_data(), file, row.names = FALSE)
      }
    )

    observeEvent(input$back, {
      updateTabItems(session = parent, "tabs", "tab_scatter_plot")
    })

    observeEvent(input$`next`, {
      updateTabItems(session = parent, "tabs", "tab_exit")
    })
  })
}
