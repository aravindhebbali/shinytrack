#' RFM segment summary
#'
#' Shiny module for summarizing RFM segments.
#' 
#' @param id Shiny module id.
#' @param parent Name of the parent session.
#' @param data Reactive; rfm segments.
#' @param btn Reactive; segment generation button.
#' @param currency Reactive; currency symbol.
#' @param input, output, session Internal parameters for {shiny}
#'
#' @importFrom rfm rfm_segment_summary
#' @noRd
#'
segment_summary_ui <- function(id) {
  ns <- NS(id)
  tabItem(tabName = "tab_segment_summary",
          div(class = "tab_container btn_end",
              div(
                fluidRow(
                  tab_title('Segment Summary'),
                  column(12, align = "center",
                         threeDots(DTOutput(ns("segment_summary")),
                                   color = "#0f1a34")
                  )
                )
              ),
              nav_btns(ns)
          )
  )
}

segment_summary_server <- function(id, parent, data, btn, currency) {
  moduleServer(id, function(input, output, session) {

    segment_overview <- eventReactive(btn(), {
      rfm_segment_summary(data())
    })

    observeEvent(btn(), {
      output$segment_summary <-
        renderDT({ 
          datatable(
            segment_overview() %>%
              set_names(c("Segment", "Customers", "Orders", "Revenue", "AoV"))
          ) %>%
          formatCurrency(column = 4:5, currency = currency()) 
        })
      save_segment_summary(segment_overview())
    })

    observeEvent(input$back, {
      updateTabItems(session = parent, "tabs", "tab_segments")
    })

    observeEvent(input$`next`, {
      updateTabItems(session = parent, "tabs", "tab_segment_plot")
    })
    
    return(
        list(
            overview = segment_overview,
            btn = reactive({ input$`next` })
        )
    )

  })
}
