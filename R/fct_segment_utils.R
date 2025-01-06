segment_input <- function(ns) {
  tagList(
    hr(),
    fluidRow(
      column(2, align = "center", h5('Segment')),
      rfm_segment_headings()
    ),
    hr(),
    div(class = "segment_line",
        lapply(1:10, function(i) {
          fluidRow(
            div(class = "segment_delete",
                column(2,
                       align = "center",
                       textInput(ns(paste("segment_name_", i)), label = '',
                                 width = '150px',
                                 value = segment_names[i])
                ),
                rfm_segment_inputs(ns, i),
                column(1,
                       align = "center",
                       actionButton(
                         inputId = ns(paste0("btn_remove_segment_", i)),
                         label = "Remove", class = 'btn-delete'))
            )
          )
        })
    ),
    hr(),
    segment_buttons(ns)
  )
}

restore_segment_input <- function(ns, constants) {
  ncol <- segments_count

  tagList(
    hr(),
    fluidRow(
      column(2, align = "center", h5('Segment')),
      rfm_segment_headings()
    ),
    hr(),
    div(class = "segment_line",
        lapply(1:ncol, function(i) {

          fluidRow(
            div(
              class = "segment_delete",
              column(
                2,
                textInput(ns(paste("segment_name_", i)), label = '',
                          width = '150px', value = segment_names[i])
              ),
              column(
                3, align = "center",
                sliderInput(ns(paste("recency_interval_", i)), label = '',
                            min = 1, max = 5, step = 1,
                            value = c(lower_recency[i],
                                      upper_recency[i]))
              ),
              column(
                3, align = "center",
                sliderInput(ns(paste("frequency_interval_", i)), label = '',
                            min = 1, max = 5, step = 1,
                            value = c(lower_frequency[i],
                                      upper_frequency[i]))
              ),
              column(
                3, align = "center",
                sliderInput(ns(paste("monetary_interval_", i)), label = '',
                            min = 1, max = 5, step = 1,
                            value = c(lower_monetary[i],
                                      upper_monetary[i]))
              ),
              column(1,
                     align = "center",
                     actionButton(inputId = ns(paste0("btn_remove_segment_", i)),
                                  label = "Remove", class = 'btn-delete'))

            )
          )

        })
    ),
    hr(),
    segment_buttons(ns)
  )
}

rfm_segment_headings <- function() {
  tagList(
    column(3, align = "center", h5('Recency Score')),
    column(3, align = "center", h5('Frequency Score')),
    column(3, align = "center", h5('Monetary Score'))
  )
}

rfm_segment_inputs <- function(ns, i) {
  tagList(
    column(3, sliderInput(ns(paste("recency_interval_", i)),
                          label = '', min = 1, max = 5, step = 1,
                          value = c(recency_lower[i],
                                    recency_upper[i]),
                          width = '80%')
    ),
    column(3, sliderInput(ns(paste("frequency_interval_", i)),
                          label = '', min = 1, max = 5, step = 1,
                          value = c(frequency_lower[i],
                                    frequency_upper[i]),
                          width = '80%')
    ),
    column(3, sliderInput(ns(paste("monetary_interval_", i)),
                          label = '', min = 1, max = 5, step = 1,
                          value = c(monetary_lower[i],
                                    monetary_upper[i]),
                          width = '80%')
    )
  )
}

get_segment_names <- function(input, n, type) {

  if (type == "predefined") {
    n_col <- 10
  } else {
    n_col <- n
  }

  collect <- list(lapply(1:n_col, function(i) {
    input[[paste("segment_name_", i)]]
  }))

  unlist(collect)
}

#' @importFrom purrr map_int
segment_intervals <- function(input, n, param, index = 1, type) {

  if (type == "predefined") {
    n_col <- 10
  } else {
    n_col <- n
  }

  collect <- list(lapply(1:n_col, function(i) {
    input[[paste(param, i)]]
  }))

  map_int(collect[[1]], index)
}

add_new_segment <- function(ns) {
  div(class = "custom_segment",
      hr(),
      fluidRow(
        column(2, align = "center", h5('Segment')),
        rfm_segment_headings(),
        column(1)
      ),
      hr(),
      new_segment(ns, 1),
      hr(),
      segment_buttons(ns)
  )
}

segment_buttons <- function(ns) {
  fluidRow(
    column(8, align = "left", br(),
           actionButton(inputId = ns('restore_segment'),
                        label = "Restore Segments"),
           br(), br()
    ),
    column(2, align = "right", br(),
           actionButton(inputId = ns('add_new_segment'),
                        label = "Add Segment"),
           br(), br()
    ),
    column(2, align = "right", br(),
           actionButton(inputId = ns("btn_create_segments"),
                        label = "Generate Segments",
                        onclick = "App.plotOptions(this, 'display')"),
           br(), br()
    )
  )
}

new_segment <- function(ns, i) {
  div(class = "segment_line",
      fluidRow(
        div(class = "segment_delete",
            column(2,
                   align = "center",
                   textInput(ns(paste("segment_name_", i)), label = '',
                             width = '150px',
                             value = segment_names[i])
            ),
            rfm_segment_inputs(ns, i),
            column(1,
                   align = "center",
                   actionButton(inputId = ns(paste0("btn_remove_segment_", i)),
                                label = "Remove", class = 'btn-delete'))
        )
      )
  )
}

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
