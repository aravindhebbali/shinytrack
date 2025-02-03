#' Segment data
#' 
#' Shiny module for displaying RFM segments.
#'
#' @param id Shiny module id.
#' @param parent Name of the parent session.
#' @param data Reactive; RFM score data.
#' @param currency Reactive; Currency to be displayed.
#' 
#' @noRd
#'
segment_ui <- function(id) {
  ns <- NS(id)
  tabItem(tabName = "tab_segments",
          div(class = "tab_container btn_end",
              div(
                fluidRow(
                  tab_title('Segments'),
                  column(12, align = "center",
                         threeDots(DTOutput(ns("segment_data")),
                                   color = "#0f1a34")
                  )
                )
              ),
              nav_btns(ns)
          )
  )
}

segment_server <- function(id, parent, data, currency) {
  moduleServer(id, function(input, output, session) {
    output$segment_data <- renderDT({
      #datatable(
      #  data() %>%
      #    select(customer_id, segment, rfm_score, transaction_count, recency_days, amount) %>%
      #    set_names(c("Customer ID", "Segment", "RFM Score", "Orders", "Recency (Days)", "Revenue"))
      #) %>%
      #    formatCurrency(column = 6, currency = currency())
        cols_select <- c("customer_id", "segment", "rfm_score", 
                         "transaction_count", "recency_days", "amount")
        data <- data()[cols_select]
        colnames(data) <- c("Customer ID", "Segment", "RFM Score", "Orders", 
                            "Recency (Days)", "Revenue")
        formatCurrency(datatable(data), column = 6, currency = currency())
    })

    observeEvent(input$back, {
      updateTabItems(session = parent, "tabs", "tab_generate_segments")
    })

    observeEvent(input$`next`, {
      updateTabItems(session = parent, "tabs", "tab_segment_summary")
    })
  })
}
