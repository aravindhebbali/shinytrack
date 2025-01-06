#' Add path environment variable
#'
#' Creates a `.Renviron` file and adds project path environment variable.
#'
#' @importFrom fs file_create
#' 
#' @export
#'
add_path_env <- function() {
  cwd <- getwd()
  file_create(cwd, ".Renviron")
  path_env <- paste0('RFM_PROJECT_PATH="', cwd, '"')
  write(path_env, '.Renviron', append = TRUE)
}
