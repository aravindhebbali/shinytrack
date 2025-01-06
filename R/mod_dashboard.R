#' Dashboard 
#'
#' Shiny module for displaying dashboard of existing projects.
#'
#' @param id Shiny module id.
#' @param parent Name of the parent session.
#' @param flag Reactive; project type flag.
#' @param btn Reactive; retrieve and display project dashboard.
#' @param input, output, session Internal parameters for {shiny}
#'
#' @importFrom DT formatRound formatCurrency
#' @importFrom stringi stri_unescape_unicode
#' @noRd
#'
dashboard_ui <- function(id) {
  ns <- NS(id)
  tabItem(tabName = "tab_dashboard",
          div(class = "tab_container dashboard btn_end",
              div(
                tab_title("Segmentation Overview"),
                uiOutput(ns("indicators")),
                div(class = "dashboard-table",
                    fluidRow(
                      column(12, align = "center", DTOutput(ns("dashboard")))
                    )
                )
              ),
              nav_btns(ns)
          )
  )
}

dashboard_server <- function(id, parent, btn, flag) {
  moduleServer(id, function(input, output, session) {

    ns <- session$ns

    observeEvent(btn(), {
      if (flag() == "restore_project" || flag() == "clone_project") {
        data <- global$project_data$segment_summary
        output$indicators <- renderUI({
          if (is.null(data)) {
            column(12, align = "center",
                   img(src = "wizard-0.1.0/img/no-project.svg"),
                   h3("No data found."),
                   p("Looks like segmentation data was not saved when the project was created.")
            )
          } else {
            div(class = "value-box-container",
                div(class = "value-box",
                    icon("user", "fa-4x"),
                    div(
                      h6("Customers"),
                      p(format(sum(data[["customers"]]), big.mark = ","))
                    )
                ),
                div(class = "value-box",
                    icon("cart-shopping", "fa-4x"),
                    div(
                      h6("Orders"),
                      p(format(sum(data[["orders"]]), big.mark = ","))
                    )
                ),
                div(class = "value-box",
                    icon("sack-dollar", "fa-4x"),
                    div(
                      h6("Revenue"),
                      p(paste0(stri_unescape_unicode("\\u0024"),
                               format(sum(data[["revenue"]]), big.mark = ",")))
                    )
                ),
                div(class = "value-box",
                    icon("gauge", "fa-4x"),
                    div(
                      h6("AoV"),
                      p(paste0(stri_unescape_unicode("\\u0024"),
                               format(round((sum(data[["revenue"]]) / sum(data[["orders"]])), 2), big.mark = ",")))
                    )
                )
            )
          }
        })

        output$dashboard <-
          if (!is.null(data)) {
            renderDT({ datatable(data) %>%
                formatRound(2:3, digits = 0) %>%
                formatCurrency(4:5) })
          }

      } else {
        output$indicators <- renderUI({
          fluidRow(
            column(12, align = "center",
                   h3("Dashboard is available only for existing or cloned projects.")
            )
          )
        })
      }
    })

    observeEvent(input$back, {
      updateTabItems(session = parent, "tabs", "tab_project_info")
    })

    observeEvent(input$`next`, {
      updateTabItems(session = parent, "tabs", "tab_select")
    })

  })
}
