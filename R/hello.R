#' Run app
#'
#' Run the shiny application.
#'
#' @import shiny
#' @export
#'
run_app <- function() {
  shinyApp(
    ui = app_ui,
    server = app_server
  )
}
