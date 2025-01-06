#' Documentation
#'
#' Shiny module for documentation.
#' 
#' @param id Shiny module id.
#'
#' @noRd
#'
docs_ui <- function(id) {
  ns <- NS(id)
  tabItem(tabName = "tab_docs",
          div(class = "tab_container",
            div(class = "docs-box",
              div(class = "link-box",
                icon("leanpub", "fa-7x"),
                a("eBook", target = "_blank", href = "")
              ),
              div(class = "link-box",
                icon("video", "fa-7x"),
                a("Demo Videos", target = "_blank", href = "")
              ),
              div(class = "link-box",
                icon("graduation-cap", "fa-7x"),
                a("Online Course", target = "_blank", href = "")
              )
            ),
              
            div(class = "docs-box",
              div(class = "link-box",
                icon("book", "fa-7x"),
                a("User Guide", target = "_blank", href = "")
              ),
              div(class = "link-box",
                icon("r-project", "fa-7x"),
                a("R", target = "_blank", href = "")
              ),
              div(class = "link-box",
                icon("python", "fa-7x"),
                a("Python", target = "_blank", href = "")
              )
            )
          )
  )
}

docs_server <- function(id) {
  moduleServer(id, function(input, output, session) {

  })
}
