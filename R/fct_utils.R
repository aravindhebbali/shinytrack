#' Tab title
#'
#' Display tab title
#'
#' @param title Title of the tab
#'
#' @noRd
#'
tab_title <- function(title) {
  div(class = 'tab-title',
      fluidRow(
        column(6, align = "left", h3(title)),
        column(6, align = "right",
               a("", target = "_blank", href = "https://rfm.rsquaredacademy.com",
                 icon("circle-question", "fa-2x"))
        )
      ),
      fluidRow(
        column(12, hr())
      )
  )
}

#' Sub menu
#'
#' Second level menu
#'
#' @importFrom shinydashboard menuItem menuSubItem
#' @importFrom htmltools tagQuery
#' @noRd
#'
sub_menu <- function() {
  ui <-
    menuItem(
      "Median Plots",
      tabName = "tab_median_plot",
      menuSubItem("Median Recency", tabName = "tab_median_recency"),
      menuSubItem("Median Frequency", tabName = "tab_median_frequency"),
      menuSubItem("Median Monetary", tabName = "tab_median_monetary")
    )

  tagQuery(ui)$
    find('span')$
    addClass('sub-menu')$
    allTags()
}

#' Refresh projects
#'
#' Button to refresh projects list.
#' 
#' @param ns Namespace.
#' @param title Tab title.
#' @noRd
#'
tab_title_btn <- function(ns, title) {
  div(class = "tab-title-btn",
    div(class = "plot-buttons",
        column(6, align = "left", h3(title)),
        column(6, align = "right",
              column(4, align = "right", offset = 8,
                      actionButton(
                        inputId = ns("btn_refresh"),
                        label = "Refresh",
                        width = '120px',
                        class = "btn_customize_plot")
              )
        )
    ),
    fluidRow(
      column(12, hr())
    )
  )
}

#' Navigation buttons
#'
#' Back and Next buttons.
#'
#' @param ns Namespace.
#' @noRd
#'
nav_btns <- function(ns) {
  div(class = "nav-buttons",
      fluidRow(
        column(6, align = 'left',
               actionButton(inputId = ns('back'), label = "Back",
                            icon = icon("long-arrow-left"),
                            class = 'btn-back')
        ),
        column(6, align = 'right',
               actionButton(inputId = ns('next'), label = "Next",
                            icon = icon("long-arrow-right"),
                            class = 'btn-next')
        )
      )
  )
}

#' Delayed navigation buttons
#'
#' The back and next buttons are displayed after user performs intended action.
#'
#' @param ns Namespace.
#' @noRd
#'
btn_delay <- function(ns) {
  div(class = "nav-buttons",
      fluidRow(
        column(6, align = 'left',
               actionButton(inputId = ns('back'), label = "Back",
                            icon = icon("long-arrow-left"))
        ),
        column(6, align = 'right',
               actionButton(inputId = ns('next'), label = "Next",
                            icon = icon("long-arrow-right"),
                            class = 'btn-next-delay')
        )
      )
  )
}

#' Highlight sidebar
#'
#' @noRd
#'
sidebar_highlight <- function(ns, next_btn = TRUE, tab, view = FALSE) {

  btn_back <- actionButton(inputId = ns('back'), label = "Back",
                           icon = icon("long-arrow-left"),
                           class = 'btn-back')

  if (view) {
    btn_next <- actionButton(inputId = ns('next'), label = "Next",
                             icon = icon("long-arrow-right"),
                             class = 'btn-next')
  } else {
    btn_next <- actionButton(inputId = ns('next'), label = "Next",
                             icon = icon("long-arrow-right"),
                             class = 'btn-next btn-next-delay')
  }

  on_click <- paste0("App.highlightTab(this, ", tab, ")")

  if (next_btn) {
    btn_next <- tagAppendAttributes(btn_next, onclick = on_click)
  } else {
    btn_back <- tagAppendAttributes(btn_back, onclick = on_click)
  }

  div(class = "nav-buttons",
      fluidRow(column(6, align = 'left', btn_back),
               column(6, align = 'right', btn_next)
      )
  )

}
