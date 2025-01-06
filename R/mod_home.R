#' Home page
#'
#' Shiny module for home page.
#'
#' @param id Shiny module id.
#' @param parent Name of the parent session.
#' @param input, output, session Internal parameters for {shiny}
#'
#' @importFrom shinydashboard tabItem updateTabItems
#' @noRd
#'
home_ui <- function(id) {
  ns <- NS(id)
  tabItem(tabName = "tab_home",
          div(class = "tab_container",
              tab_title('Welcome'),
              fluidRow(
                div(
                  class = "data-type-options",
                  column(
                    12, align = "center",
                    radioButtons(ns("project_type"), "I would like to:",
                                 c("Explore sample data" = "sample",
                                   "Analyze data" = "analyze",
                                   "Start a new project" = "new_project",
                                   "Open an existing project" = "restore_project",
                                   "Clone an existing project" = "clone_project",
                                   "Delete an existing project" = "delete_project"))
                  )
                )
              ),
              fluidRow(
                column(
                  12,
                  align = 'center',
                  uiOutput(ns("welcome_nav_btns"))
                )
              )
          )
  )
}

home_server <- function(id, parent) {
  moduleServer(id, function(input, output, session) {

    ns <- session$ns

    project_type <- reactive({ input$project_type })

    next_tab <- reactive({
      switch(project_type(),
             "sample" = "tab_upload",
             "analyze" = "tab_upload",
             "new_project" = "tab_path",
             "restore_project" = "tab_path",
             "clone_project" = "tab_path",
             "delete_project" = "tab_path")
    })

    output$welcome_nav_btns <- renderUI({
      if (project_type() == "sample" || project_type() == "analyze") {
        actionButton(ns("btn_get_started"), "Get Started",
                     width = '150px', class = 'btn-get-started',
                     onclick = "App.highlightTab(this, 'home-next')")
      } else {
        actionButton(
          ns("btn_get_started"), "Get Started",
          width = '150px', class = 'btn-get-started',
          onclick = "App.highlightTab(this, 'home-tab');")
      }
    })

    observeEvent(input$btn_get_started, {
      updateTabItems(session = parent, "tabs", next_tab())
    })

    return(project_type)

  })
}
