plot_buttons <- function(ns, title) {
  div(class = "plot-buttons",
      column(4, align = "left",
             div(class = "title-help",
                 div(class = "plot-title", h3(title)),
                 div(class = "plot-help",
                     a("", target = "_blank",
                       href = "https://rfm.rsquaredacademy.com",
                       icon("circle-question", "fa-1x"))))),
      column(6, align = "right", offset = 2,
             column(4, align = "center", offset = 4,
                    actionButton(
                      inputId = ns("btn_customize"),
                      label = "Modify",
                      width = '120px',
                      class = "btn_customize_plot",
                      onclick = "App.plotOptions(this, 'customize')")
             ),
             column(4, align = "right",
                    actionButton(
                      inputId = ns("btn_download_opt"),
                      label = "Export",
                      width = '120px',
                      class = "btn_download_opt",
                      onclick = "App.plotOptions(this, 'toggle')")
             )
      )
  )
}

plot_download_options <- function(ns) {
  div(
    column(6),
    column(6, align = "right",
           div(class = "download-options",
               column(4, align = "center", offset = 4,
                      inlineRadio(ns)
               ),
               column(4, align = "right",
                      downloadButton(ns("btn_download_plot"),
                                     "Download"))
           )
    )
  )
}

#' @importFrom htmltools tagQuery
#'
inlineRadio <- function(ns) {
  tag <- radioButtons(ns("download_type"), "",
                      c("PNG" = "png",
                        "JPEG" = "jpeg"))

  newInput <-
    tagQuery(tag)$
    find(".shiny-options-group")$
    addClass("inline-radio")

  newInput$allTags()
}

plot_modify_ui <- function(ns) {
  fluidRow(
    column(6, align = "center",
           actionButton(
             inputId = ns("btn_reset"),
             label = "Reset",
             width = '120px', icon = icon('undo'),
             class = "btn_reset_plot",
             onclick = "App.plotOptions(this, 'resize')")
    ),
    column(6, align = "center",
           actionButton(
             inputId = ns("btn_resize"),
             label = "Generate",
             width = '120px', icon = icon('check'),
             class = "btn_resize_plot",
             onclick = "App.plotOptions(this, 'resize')")
    )
  )
}

plot_title <- function(ns, value) {
  tags$details(
    tags$summary("Title"),
    column(12, align = "left",
           textInput(ns("plot_title"), label = "Plot title", value = value))
  )
}

plot_axis_labels <- function(ns, x_label, y_label) {
  tags$details(
    tags$summary("Axis Labels"),
    column(5, align = "left",
           textInput(ns("x_axis_label"),
                     label = "X Axis Label",
                     value = x_label)),
    column(5, align = "left", offset = 2,
           textInput(ns("y_axis_label"),
                     label = "Y Axis Label",
                     value = y_label))
  )
}

plot_sort <- function(ns) {
  tags$details(
    tags$summary("Sort"),
    column(6, align = "center",
           checkboxInput(ns("sort"), "Sort", FALSE)),
    column(6, align = "center",
           checkboxInput(ns("ascending"),
                         "Ascending", FALSE))
  )
}

plot_flip <- function(ns, flip_plot = TRUE, flip = FALSE, interact = FALSE) {
  tags$details(
    tags$summary("Flip / Interactive"),
    if (flip_plot) {
      tagList(
        column(6, align = "center",
               checkboxInput(ns("flip"), "Flip", flip)),
        column(6, align = "center",
               checkboxInput(ns("interactive"),
                             "Interactive", interact))
      )
    } else {
      column(6, align = "center",
             checkboxInput(ns("interactive"),
                           "Interactive", interact))
    }

  )
}

plot_axis_angle <- function(ns) {
  tags$details(
    tags$summary("Size / Angle"),
    div(class = "axis-labels",
        column(2, align = "right", h5('Size:')),
        column(4, align = "left",
               numericInput(ns("axis_label_size"),
                            label = "", value = 8)),
        column(2, align = "right", h5('Angle:')),
        column(4, align = "left",
               numericInput(ns("axis_label_angle"),
                            label = "", value = 315))
    )
  )
}

plot_bar_color <- function(ns, color = "#0f1a34") {
  tags$details(
    tags$summary("Color"),
    column(12, align = "left",
           colourInput(ns("bar_color"), "Select colour", color, width = "50%")
    )
  )}

plot_bar_label_color <- function(ns) {
  tags$details(
    tags$summary("Bar Labels"),
    div(class = "bar-labels",
        column(6, align = "center",
               checkboxInput(ns("bar_label"),
                             "Bar Labels", TRUE)),
        column(6, align = "center",
               colourInput(ns("bar_color"), "Select colour", "0f1a34", width = "50%")
        )
    )
  )
}

plot_bar_label_size <- function(ns, show = TRUE, size = 2.5) {
  tags$details(
    tags$summary("Bar Labels"),
    div(class = "bar-labels",
        column(6, align = "center",
               checkboxInput(ns("bar_label"),
                             "Bar Labels", show)),
        column(2, align = "right", h5('Size:')),
        column(4, align = "left",
               numericInput(ns("bar_label_size"),
                            label = "", min = 1, step = 0.1, value = size))
    )
  )
}

plot_legend_title <- function(ns, title) {
  tags$details(
    tags$summary("Legend"),
    column(12, align = "left",
           textInput(ns("legend_title"),
                     label = "Title",
                     value = title))
  )
}

plot_revenue_colors <- function(ns) {
  tags$details(
    tags$summary("Colors"),
    column(5, align = "left",
           colourInput(ns("color_revenue"), "Revenue", "#3b5bdb",
                       width = "80%")),
    column(5, align = "left", offset = 2,
           colourInput(ns("color_customer"), "Customer", "#91a7ff",
                       width = "80%"))
  )
}

plot_revenue_labels <- function(ns) {
  tags$details(
    tags$summary("Legend Labels"),
    column(5, align = "left",
           textInput(ns("label_revenue"),
                     label = "Revenue",
                     value = "Revenue")),
    column(5, align = "left", offset = 2,
           textInput(ns("label_customer"),
                     label = "Customers",
                     value = "Customers"))
  )
}

plot_hist_color_bins <- function(ns) {
  tags$details(
    tags$summary("Bins / Color"),
    div(class = "bar-labels",
        column(6, align = "center",
               colourInput(ns("bar_color"), "Select colour", "0f1a34",
                           width = "50%")),
        column(2, align = "right", h5('Bins:')),
        column(4, align = "left",
               numericInput(ns("bins"),
                            label = "", value = 9))
    )
  )
}

plot_brewer_name <- function(ns) {
  tags$details(
    tags$summary("Color"),
    column(12, align = "left",
           textInput(ns("brewer_name"),
                     label = "Brewer Name",
                     value = "PuBu"))
  )
}

plot_bar_primary_axis <- function(ns) {
  tags$details(
    tags$summary("Primary Axis Labels"),
    column(5, align = "left",
           textInput(ns("x_axis_label"),
                     label = "X Axis",
                     value = "Monetary Score")),
    column(5, align = "left", offset = 2,
           textInput(ns("y_axis_label"),
                     label = "Y Axis",
                     value = ""))
  )
}

plot_bar_secondary_axis <- function(ns) {
  tags$details(
    tags$summary("Secondary Axis Labels"),
    column(5, align = "left",
           textInput(ns("sec_x_axis_label"),
                     label = "X Axis",
                     value = "Frequency Score")),
    column(5, align = "left", offset = 2,
           textInput(ns("sec_y_axis_label"),
                     label = "Y Axis",
                     value = "Recency Score"))
  )
}

plot_metric <- function(ns, id, selected) {
  selectInput(
    ns(id), "Metric",
    c("Recency" = "recency",
      "Frequency" = "frequency",
      "Monetary Value" = "monetary"),
    selected)
}

plot_segment_metric <- function(ns) {
  tags$details(
    tags$summary("Metric"),
    column(12, align = "left",
           selectInput(ns("metric"), "",
                       c("Customers" = "customers",
                         "Orders" = "orders",
                         "Revenue" = "revenue"),
                       "customers"))
  )
}

scatter_nav_btns <- function(ns) {
  div(class = "nav-buttons",
      fluidRow(
        column(6, align = 'left',
               actionButton(inputId = ns('back'), label = "Back",
                            icon = icon("long-arrow-left"),
                            class = 'btn-back',
                            onclick = "App.highlightTab(this, 'scatter-back')")
        ),
        column(6, align = 'right',
               actionButton(inputId = ns('next'), label = "Next",
                            icon = icon("long-arrow-right"),
                            class = 'btn-next')
        )
      )
  )
}

#' @importFrom grDevices png jpeg dev.off
#'
plot_download <- function(input, output, plot, file_name) {
  output$btn_download_plot <- downloadHandler(
    filename = function() {
      paste(file_name, input$download_type, sep = '.')
    },
    content = function(file){
      if (input$download_type == "png") {
        png(file)
      } else {
        jpeg(file)
      }

      print(plot())
      dev.off()
    }
  )
}

plot_minimize <- function(ns) {
  fluidRow(
    column(6, align = "left", h4("Modify Plot")),
    column(6, align = "right",
           actionButton(
             inputId = ns("btn_minimize"),
             label = "",
             icon = icon('window-minimize'),
             class = "btn_minimize",
             onclick = "App.plotOptions(this, 'resize')")
    ),
    column(12, align = "center", hr())
  )
}
