#' Configure 
#'
#' Shiny module for configuration. 
#'
#' @param id Shiny module id.
#' @param parent Name of the parent session.
#' @param flag Reactive; project type flag.
#' @param data Reactive; sample or user uploaded data. 
#' @param btn Reactive; retrieve configuration. 
#' @param sample Reactive; sample data type.
#' @param input, output, session Internal parameters for {shiny}
#'
#' @importFrom colourpicker colourInput updateColourInput
#' @importFrom stringi stri_unescape_unicode stri_replace_all
#' @importFrom magrittr use_series
#' 
#' @noRd
#'
configure_ui <- function(id) {
  ns <- NS(id)
  tabItem(tabName = "tab_config",
          div(class = "tab_container btn_end",
              div(
                tab_title("Configure"),
                div(class = "set_options",
                    div(class = "config",
                        column(3,
                               selectInput(
                                 ns("set_data_format"), "Data Format",
                                 c("Transaction Level Data" = "transaction",
                                   "Customer Level Data (Days)" = "customer_days",
                                   "Customer Level Data (Date)" = "customer_date")
                               )
                        )
                    ),
                    div(class = "config",
                        column(
                          3, align = "left",
                          selectInput(
                            ns("set_currency"), "Currency",
                            c("Dollar" = stri_unescape_unicode("\\u0024"),
                              "Euro" = stri_unescape_unicode("\\u20ac"),
                              "Pound Sterling" = stri_unescape_unicode("\\u00a3"),
                              "Indian Rupee" = stri_unescape_unicode("\\u20b9"),
                              "Franc" = stri_unescape_unicode("\\u20a3"),
                              "Russian Ruble" = stri_unescape_unicode("\\u20bd"),
                              "Rupees" = stri_unescape_unicode("\\u20a8"),
                              "Iranian Rial" = stri_unescape_unicode("\\ufdfc"),
                              "Turkish Lira" = stri_unescape_unicode("\\u20ba"),
                              "Thai Baht" = stri_unescape_unicode("\\u0e3f"),
                              "Ghanian Cedi" = stri_unescape_unicode("\\u20b5"),
                              "Costa Rican Colon" = stri_unescape_unicode("\\u20a1"),
                              "Vietnamese Dong" = stri_unescape_unicode("\\u20ab"),
                              "Armenian Dram" = stri_unescape_unicode("\\u058f"),
                              "Paraguayan Guarani" = stri_unescape_unicode("\\u20b2"),
                              "Ukrainian Hryvnia" = stri_unescape_unicode("\\u20b4"),
                              "Laotian Kip" = stri_unescape_unicode("\\u20ad"),
                              "Georgian Lari" = stri_unescape_unicode("\\u20be"),
                              "Azerbaijani Manat" = stri_unescape_unicode("\\u20bc"),
                              "Philippine Peso" = stri_unescape_unicode("\\u20b1"),
                              "Nigerian Naira" = stri_unescape_unicode("\\u20a6"),
                              "None" = " "
                            ),
                            selected = " ",
                            width = "100%"
                          )
                        )
                    ),
                    div(class = "config",
                        column(3, align = "left",
                               colourInput(ns("set_color"), "Plot Color", "0f1a34",
                                           width = "100%")
                        )
                    ),
                    div(class = "config",
                        column(3, align = "left",
                               p("Plot Type"),
                               checkboxInput(ns("set_engine"), "Interactive", FALSE),
                        )
                    ),
                    div(class = "config",
                        column(3, align = "left",
                               radioButtons(ns("set_file_type"), "Plot File Type",
                                            c("PNG" = "png",
                                              "JPEG" = "jpeg"), inline = TRUE)
                        )
                    )
                ),
                fluidRow(
                  column(12, align = "center",
                         actionButton(
                           ns("btn_config"), "Update",
                           onclick = "App.highlightTab(this, 'next-tab')")
                  )
                )
              ),
              sidebar_highlight(ns, TRUE, "'next-tab'", TRUE)

          )
  )
}

configure_server <- function(id, parent, btn, data, flag, sample) {
  moduleServer(id, function(input, output, session) {

    ns <- session$ns

    observeEvent(btn(), {
      if (flag() == "sample") {
        updateSelectInput(session, "set_data_format", "Data Format",
                          c("Transaction Level Data" = "transaction",
                            "Customer Level Data (Days)" = "customer_days",
                            "Customer Level Data (Date)" = "customer_date"),
                          sample()
        )
      } else if (flag() == "restore_project" || flag() == "clone_project") {
        inputs <- global$proj_info
        updateColourInput(session, "set_color", "Plot Color", inputs$plot_color)

        updateSelectInput(session, "set_data_format", "Data Format",
                          c("Transaction Level Data" = "transaction",
                            "Customer Level Data (Days)" = "customer_days",
                            "Customer Level Data (Date)" = "customer_date"),
                          inputs$data_format
        )

        updateRadioButtons(session, "set_file_type", "Plot File Type",
                           c("PNG" = "png",
                             "JPEG" = "jpeg"),
                           inputs$plot_ext,
                           inline = TRUE)


        updateCheckboxInput(session, "set_engine", "Interactive",
                            as.logical(inputs$plot_mode))

        legal_tender <-
          inputs %>%
          use_series(currency) %>%
          stri_replace_all(regex = "<", replacement = "") %>%
          stri_replace_all(regex = ">", replacement = "") %>%
          stri_replace_all(regex = "\\+", replacement = "") %>%
          tolower()

        updateSelectInput(
          session, "set_currency", "Currency",
          c("Dollar" = stri_unescape_unicode("\\u0024"),
            "Euro" = stri_unescape_unicode("\\u20ac"),
            "Pound Sterling" = stri_unescape_unicode("\\u00a3"),
            "Indian Rupee" = stri_unescape_unicode("\\u20b9"),
            "Franc" = stri_unescape_unicode("\\u20a3"),
            "Russian Ruble" = stri_unescape_unicode("\\u20bd"),
            "Rupees" = stri_unescape_unicode("\\u20a8"),
            "Iranian Rial" = stri_unescape_unicode("\\ufdfc"),
            "Turkish Lira" = stri_unescape_unicode("\\u20ba"),
            "Thai Baht" = stri_unescape_unicode("\\u0e3f"),
            "Ghanian Cedi" = stri_unescape_unicode("\\u20b5"),
            "Costa Rican Colon" = stri_unescape_unicode("\\u20a1"),
            "Vietnamese Dong" = stri_unescape_unicode("\\u20ab"),
            "Armenian Dram" = stri_unescape_unicode("\\u058f"),
            "Paraguayan Guarani" = stri_unescape_unicode("\\u20b2"),
            "Ukrainian Hryvnia" = stri_unescape_unicode("\\u20b4"),
            "Laotian Kip" = stri_unescape_unicode("\\u20ad"),
            "Georgian Lari" = stri_unescape_unicode("\\u20be"),
            "Azerbaijani Manat" = stri_unescape_unicode("\\u20bc"),
            "Philippine Peso" = stri_unescape_unicode("\\u20b1"),
            "Nigerian Naira" = stri_unescape_unicode("\\u20a6"),
            "None" = " "
          ),
          stri_unescape_unicode(paste0("\\", legal_tender))
        )
      }

    })

    observeEvent(input$btn_config, {
      get_data_format(input$set_data_format)
      get_currency(input$set_currency)
      get_plot_color(input$set_color)
      get_plot_ext(input$set_file_type)
      get_plot_mode(input$set_engine)
      updateTabItems(session = parent, "tabs", "tab_generate_score")
    })

    observeEvent(input$back, {
      updateTabItems(session = parent, "tabs", "tab_view")
    })

    observeEvent(input$`next`, {
      updateTabItems(session = parent, "tabs", "tab_generate_score")
    })

    return(
      list(
        color = reactive({ input$set_color }),
        engine = reactive({ input$set_engine }),
        file_type = reactive({ input$set_file_type }),
        currency = reactive({ input$set_currency }),
        data_type = reactive({ input$set_data_format }),
        btn = reactive({ input$btn_config })
      )
    )
  })
}
