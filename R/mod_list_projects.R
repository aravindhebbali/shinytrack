#' List projects 
#'
#' Shiny module for listing existing projects. 
#'
#' @param id Shiny module id.
#' @param parent Name of the parent session.
#' @param flag Reactive; project type flag.
#' @param btn Reactive; retrieve and display projects.
#' @param input, output, session Internal parameters for {shiny}
#'
#' @importFrom DT DTOutput renderDT datatable formatDate
#' @noRd
#'
list_projects_ui <- function(id) {
  ns <- NS(id)
  tabItem(tabName = "tab_projects",
          div(class = "tab_container btn_end",
              div(
                tab_title_btn(ns, 'View Projects'),
                fluidRow(
                  uiOutput(ns("list_projects"))
                )
              ),
              fluidRow(
                column(6, align = 'left',
                       actionButton(inputId = ns('back'), label = "Back",
                                    icon = icon("long-arrow-left"))
                ),
                column(6, align = 'right',
                       uiOutput(ns("list_projects_next"))
                )
              )
          )
  )
}

list_projects_server <- function(id, parent, flag, btn) {
  moduleServer(id, function(input, output, session) {

    ns <- session$ns
    project_count <-
      reactive({
        get_project_list(global$meta_info$path)
      })

    output$list_projects <- renderUI({
      if (nrow(project_count()) > 0) {
        column(12, align = "center",
               DTOutput(ns("project_count"))
        )
      } else {
        column(12, align = "center",
               img(src = "wizard-0.1.0/img/no-project.svg"),
               h3("You have not created any projects yet"),
               actionButton(ns("btn_create_project"), "Create project",
                            width = '150px')
        )
      }
    })

    observeEvent(input$btn_refresh, {
      output$list_projects <- renderUI({
        if (nrow(project_count()) > 0) {
          column(12, align = "center",
                 DTOutput(ns("project_count"))
          )
        } else {
          column(12, align = "center",
                 img(src = "img/no-project.svg"),
                 h3("You have not created any projects yet"),
                 actionButton(ns("btn_create_project"), "Create project",
                              width = '150px')
          )
        }
      })
    })

    observeEvent(btn(), {
      if (nrow(project_count()) > 0) {
        output$project_count <- renderDT({
          #datatable(
          #  get_project_list(global$meta_info$path)) %>%
            formatDate(datatable(get_project_list(global$meta_info$path)), 
                       2:3, 
                       c("toLocaleString", "toLocaleString"))
        })
      }

      output$list_projects_next <- renderUI({
        if (flag() == "restore_project" || flag() == "clone_project") {
          actionButton(inputId = ns('next'), label = "Next",
                       icon = icon("long-arrow-right"),
                       onclick = "App.highlightTab(this, 'next-tab')")
        } else {
          actionButton(inputId = ns('next'), label = "Next",
                       icon = icon("long-arrow-right"))
        }

      })
    })

    observeEvent(input$btn_create_project, {
      updateTabItems(session = parent, "tabs", "tab_add_project")
    })

    observeEvent(input$back, {
      updateTabItems(session = parent, "tabs", "tab_path")
    })

    observeEvent(input$`next`, {
      if (flag() == "restore_project" || flag() == "clone_project") {
        updateTabItems(session = parent, "tabs", "tab_upload")
      } else if (flag() == "delete_project") {
        updateTabItems(session = parent, "tabs", "tab_del_project")
      } else {
        updateTabItems(session = parent, "tabs", "tab_add_project")
      }
    })
  })
}
