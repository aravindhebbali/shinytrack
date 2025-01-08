#' RFM score
#'
#' Shiny module for displaying RFM score.
#'
#' @param id Shiny module id.
#' @param parent Name of the parent session.
#' @param data Reactive; sample or user submitte data.
#' @param currency Reactive; currency to be displayed.
#' @param input, output, session Internal parameters for {shiny}.
#'
#' @importFrom standby threeDots useThreeDots
#' @noRd
#'
score_ui <- function(id) {
  ns <- NS(id)
  tabItem(tabName = "tab_rfm_score",
          div(class = "tab_container btn_end",
            div(
              fluidRow(
                tab_title('RFM Score'),
                column(12, align = "center",
                       useThreeDots(),
                       threeDots(DTOutput(outputId = ns("view_score")),
                                 color = "#0f1a34"))
              )
            ),
            sidebar_highlight(ns, TRUE, "'next-tab'", TRUE)
          )
  )
}

score_server <- function(id, parent, data, currency) {
  moduleServer(id, function(input, output, session) {
    output$view_score <- renderDT({
       datatable(
         data()$rfm %>%
           select(customer_id, recency_days, transaction_count, amount, rfm_score) %>%
           set_names(c("Customer ID", "Recency (Days)", "Orders", "Revenue", "RFM Score"))
       ) %>%
       formatCurrency(column = 4, currency = currency())
    })

    observeEvent(input$back, {
      updateTabItems(session = parent, "tabs", "tab_generate_score")
    })

    observeEvent(input$`next`, {
      updateTabItems(session = parent, "tabs", "tab_orders")
    })

    return(
      list(
        btn = reactive({ input$`next` })
      )
    )
  })
}
