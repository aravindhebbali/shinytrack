#' Project info 
#'
#' Shiny module for displaying project info.
#'
#' @param id Shiny module id.
#' @param parent Name of the parent session.
#' @param flag Reactive; project type flag.
#' @param data Reactive; raw data. 
#' @param btn Reactive; retrieve project info. 
#' @param input, output, session Internal parameters for {shiny}
#'
#' @noRd
#'
info_ui <- function(id) {
  ns <- NS(id)
  tabItem(tabName = "tab_project_info",
          div(class = "tab_container btn_end",
              div(
                tab_title("Project Overview"),
                uiOutput(ns("overview"))
              ),
              nav_btns(ns)
          )
  )
}

info_server <- function(id, parent, btn, data, flag) {
  moduleServer(id, function(input, output, session) {

    ns <- session$ns

    observeEvent(btn(), {
      if (flag() == "restore_project" || flag() == "clone_project") {

        dir_meta <- get_project_list(global$meta_info$path)
        proj_view <- global$proj_info

        if (length(proj_view) != 0) {
          dir_init <- subset(dir_meta, Project == proj_view$title)$Created
          # dir_init <-
          #   dir_meta %>%
          #   filter(Project == proj_view$title) %>%
          #   pull(Created)
          
          dir_mod <- subset(dir_meta, Project == proj_view$title)$`Last Modified`
          # dir_mod <-
          #   dir_meta %>%
          #   filter(Project == proj_view$title) %>%
          #   pull(`Last Modified`)

          data_format <-
            switch(proj_view$data_format,
                   "transaction" = "Transaction Level Data",
                   "customer_days" = "Customer Level Data (Days)",
                   "customer_time" = "Customer Level Data (Date)"
            )

          output$overview <- renderUI({

            div(class = "project-overview",
                div(class = "project-info",
                    fluidRow(
                      column(2, align = "left", h4(class = 'label', 'Title')),
                      column(1, align = "center", p(":")),
                      column(9, align = "left", p(class = 'value', proj_view$title))
                    )
                ),
                div(class = "project-info",
                    fluidRow(
                      column(2, align = "left", h4(class = 'label', 'Created')),
                      column(1, align = "center", p(":")),
                      column(9, align = "left", p(class = 'value', format(dir_init, "%Y-%m-%d %H:%M:%S")))
                    )
                ),
                div(class = "project-info",
                    fluidRow(
                      column(2, align = "left", h4(class = 'label', 'Last Modified')),
                      column(1, align = "center", p(":")),
                      column(9, align = "left", p(class = 'value', format(dir_mod, "%Y-%m-%d %H:%M:%S")))
                    )
                ),
                div(class = "project-info",
                    fluidRow(
                      column(2, align = "left", h4(class = 'label', 'Data Format')),
                      column(1, align = "center", p(":")),
                      column(9, align = "left", p(class = 'value', ifelse(is.null(proj_view$data_format), NA, data_format)))
                    )
                ),
                div(class = "project-info",
                    fluidRow(
                      column(2, align = "left", h4(class = 'label', 'Rows')),
                      column(1, align = "center", p(":")),
                      column(9, align = "left", p(class = 'value', ifelse(is.null(data()), NA, nrow(data()$raw_data))))
                    )
                ),
                div(class = "project-info",
                    fluidRow(
                      column(2, align = "left", h4(class = 'label', 'Columns')),
                      column(1, align = "center", p(":")),
                      column(9, align = "left", p(class = 'value', ifelse(is.null(data()), NA, ncol(data()$raw_data))))
                    )
                ),
                div(class = "project-info",
                    fluidRow(
                      column(2, align = "left", h4(class = 'label', 'Bins')),
                      column(1, align = "center", p(":")),
                      column(9, align = "left", 
                             p(class = 'value', 
                               ifelse(is.null(proj_view$score_inputs), NA, tail(proj_view$score_inputs, n = 1))
                              )
                      )
                    )
                ),
                div(class = "project-info",
                    fluidRow(
                      column(2, align = "left", h4(class = 'label', 'Segments')),
                      column(1, align = "center", p(":")),
                      column(9, align = "left", p(class = 'value', ifelse(is.null(proj_view$segments_count), NA, proj_view$segments_count)))
                    )
                )
            )
          })
        }
      } else {
        output$overview <- renderUI({
          fluidRow(
            column(12, align = "center",
                   h3("Project overview is displayed only for existing or cloned projects.")
            )
          )
        })
      }
    })

    observeEvent(input$back, {
      updateTabItems(session = parent, "tabs", "tab_examine")
    })

    observeEvent(input$`next`, {
      updateTabItems(session = parent, "tabs", "tab_dashboard")
    })

  })
}
