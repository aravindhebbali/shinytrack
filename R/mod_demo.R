#' Demo Videos
#'
#' Shiny module for demo videos.
#'
#' @param id Shiny module id.
#' @noRd
#'
demo_ui <- function(id) {
  ns <- NS(id)
  tabItem(tabName = "tab_demo",
          div(class = "tab_container",
              fluidRow(
                column(12, align = 'center',
                       h2("Thank you for using", strong("Segment Wizard"), "!")))
          )
  )
}

demo_server <- function(id) {
  moduleServer(id, function(input, output, session) {

  })
}
