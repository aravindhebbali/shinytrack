score_select_input <- function(id, label, ns, data) {
  tagList(
    column(4),
    column(2, align = "right", br(), h5(label)),
    column(6, align = "left",
           selectInput(ns(id), label = "", choices = data,
                       selected = data, width = "180px"
           )
    )
  )
}

restore_select_input <- function(id, label, ns, data, inputs) {
  tagList(
    column(4),
    column(2, align = "right", br(), h5(label)),
    column(6, align = "left",
           selectInput(ns(id), label = "", choices = names(data()),
                       selected = inputs, width = "180px"
           )
    )
  )
}

score_date_input <- function(id, label, ns) {
  tagList(
    column(4),
    column(2, align = "right", br(), h5(label)),
    column(6, align = "left",
           dateInput(ns(id), label = "", width = "180px")
    )
  )
}

sample_date_input <- function(id, label, ns) {
  tagList(
    column(4),
    column(2, align = "right", br(), h5(label)),
    column(6, align = "left",
           dateInput(ns(id), label = "",
                     value = as.Date('2006-12-31'), width = "180px")
    )
  )
}

restore_date_input <- function(id, label, ns, inputs) {
  tagList(
    column(4),
    column(2, align = "right", br(), h5(label)),
    column(6, align = "left",
           dateInput(ns(id), label = "",
                     value = as.Date(as.numeric(inputs)), width = "180px")
    )
  )
}

score_numeric_input <- function(id, label, ns) {
  tagList(
    column(4),
    column(2, align = "right", br(), h5(label)),
    column(6, align = "left",
           numericInput(ns(id), label = "", min = 1, step = 1, value = 5,
                        width = "180px"
           )
    )
  )
}

restore_numeric_input <- function(id, label, ns, inputs) {
  tagList(
    column(4),
    column(2, align = "right", br(), h5(label)),
    column(6, align = "left",
           numericInput(ns(id), label = "", min = 1, step = 1, value = inputs,
                        width = "180px"
           )
    )
  )
}

btn_generate_score <- function(ns) {
  column(12, align = "center",
         actionButton(
           inputId = ns("btn_generate_score"),
           label = "Submit",
           class = "btn-generate-score",
           onclick = "App.plotOptions(this, 'display')"
         ))
}

generate_score_ui <- function(ns) {
  tagList(
    score_date_input("analysis_date", "Analysis Date:", ns),
    score_numeric_input("bins", "Bins:", ns),
    btn_generate_score(ns))
}

transaction_data_ui <- function(ns, cust_id, date, revenue) {
  tagList(
    fluidRow(
      tab_title('Generate RFM Score')
    ),
    fluidRow(
      score_select_input("customer_id", "Unique ID:", ns, cust_id),
      score_select_input("order_date", "Transaction Date:", ns, date),
      score_select_input("revenue", "Revenue:", ns, revenue),
      generate_score_ui(ns),
    )
  )
}

restore_transaction_data_ui <- function(ns, data, inputs) {
  tagList(
    fluidRow(
      tab_title('Generate RFM Score')
    ),
    fluidRow(
      restore_select_input("customer_id", "Unique ID:", ns, data, inputs[1]),
      restore_select_input("order_date", "Transaction Date:", ns, data,
                           inputs[2]),
      restore_select_input("revenue", "Revenue:", ns, data, inputs[3]),
      restore_date_input("analysis_date", "Analysis Date:", ns, inputs[4]),
      restore_numeric_input("bins", "Bins:", ns, inputs[5]),
      btn_generate_score(ns)
    )
  )
}

sample_transaction_ui <- function(ns, data, inputs) {
  tagList(
    fluidRow(
      tab_title('Generate RFM Score')
    ),
    fluidRow(
      restore_select_input("customer_id", "Unique ID:", ns, data, inputs[1]),
      restore_select_input("order_date", "Transaction Date:", ns, data,
                           inputs[2]),
      restore_select_input("revenue", "Revenue:", ns, data, inputs[3]),
      sample_date_input("analysis_date", "Analysis Date:", ns),
      score_numeric_input("bins", "Bins:", ns),
      btn_generate_score(ns)
    )
  )
}

customer_days_ui <- function(ns, cust_id, orders, recency, revenue) {
  tagList(
    fluidRow(
      tab_title('Generate RFM Score')
    ),
    fluidRow(
      score_select_input("customer_id", "Unique ID:", ns, cust_id),
      score_select_input("n_transactions", "Transactions:", ns, orders),
      score_select_input("recency_days", "Recency (Days):", ns, recency),
      score_select_input("revenue", "Total Revenue:", ns, revenue),
      generate_score_ui(ns)
    )
  )
}

restore_customer_days_ui <- function(ns, data, inputs) {
  tagList(
    fluidRow(
      tab_title('Generate RFM Score')
    ),
    fluidRow(
      restore_select_input("customer_id", "Unique ID:", ns, data, inputs[1]),
      restore_select_input("n_transactions", "Transactions:", ns, data,
                           inputs[2]),
      restore_select_input("recency_days", "Recency (Days):", ns, data,
                           inputs[3]),
      restore_select_input("revenue", "Total Revenue:", ns, data, inputs[4]),
      restore_date_input("analysis_date", "Analysis Date:", ns, inputs[5]),
      restore_numeric_input("bins", "Bins:", ns, inputs[6]),
      btn_generate_score(ns)
    )
  )
}

sample_customer_days_ui <- function(ns, data, inputs) {
  tagList(
    fluidRow(
      tab_title('Generate RFM Score')
    ),
    fluidRow(
      restore_select_input("customer_id", "Unique ID:", ns, data, inputs[1]),
      restore_select_input("n_transactions", "Transactions:", ns, data,
                           inputs[4]),
      restore_select_input("recency_days", "Recency (Days):", ns, data,
                           inputs[5]),
      restore_select_input("revenue", "Total Revenue:", ns, data, inputs[2]),
      sample_date_input("analysis_date", "Analysis Date:", ns),
      score_numeric_input("bins", "Bins:", ns),
      btn_generate_score(ns)
    )
  )
}

customer_date_ui <- function(ns, cust_id, orders, recency, revenue) {
  tagList(
    fluidRow(
      tab_title('Generate RFM Score')
    ),
    fluidRow(
      score_select_input("customer_id", "Unique ID:", ns, cust_id),
      score_select_input("n_transactions", "Transactions:", ns, orders),
      score_select_input("latest_visit_date", "Latest Visit Date:", ns,
                         recency),
      score_select_input("revenue", "Total Revenue:", ns, revenue),
      generate_score_ui(ns)
    )
  )
}

restore_customer_date_ui <- function(ns, data, inputs) {
  tagList(
    fluidRow(
      tab_title('Generate RFM Score')
    ),
    fluidRow(
      restore_select_input("customer_id", "Unique ID:", ns, data, inputs[1]),
      restore_select_input("n_transactions", "Transactions:", ns, data,
                           inputs[2]),
      restore_select_input("latest_visit_date", "Latest Visit Date:", ns,
                           data, inputs[3]),
      restore_select_input("revenue", "Total Revenue:", ns, data, inputs[4]),
      restore_date_input("analysis_date", "Analysis Date:", ns, inputs[5]),
      restore_numeric_input("bins", "Bins:", ns, inputs[6]),
      btn_generate_score(ns)
    )
  )
}

sample_customer_date_ui <- function(ns, data, inputs) {
  tagList(
    fluidRow(
      tab_title('Generate RFM Score')
    ),
    fluidRow(
      restore_select_input("customer_id", "Unique ID:", ns, data, inputs[1]),
      restore_select_input("n_transactions", "Transactions:", ns, data,
                           inputs[4]),
      restore_select_input("latest_visit_date", "Latest Visit Date:", ns,
                           data, inputs[3]),
      restore_select_input("revenue", "Total Revenue:", ns, data, inputs[2]),
      sample_date_input("analysis_date", "Analysis Date:", ns),
      score_numeric_input("bins", "Bins:", ns),
      btn_generate_score(ns)
    )
  )
}

trans_data_ui <- function(ns, data) {
  
  tagList(
    fluidRow(
      tab_title('Generate RFM Score')
    ),
    fluidRow(
      get_score_id_columns("customer_id", "Unique ID:", ns, data),
      get_score_date_columns("order_date", "Transaction Date:", ns, data),
      get_score_revenue_columns("revenue", "Revenue:", ns, data),
      gen_score_ui(ns)
    )
  )
}

cust_days_ui <- function(ns, data) {
  tagList(
    fluidRow(
      tab_title('Generate RFM Score')
    ),
    fluidRow(
      get_score_id_columns("customer_id", "Unique ID:", ns, data),
      get_score_revenue_columns("n_transactions", "Transactions:", ns, data),
      get_score_revenue_columns("recency_days", "Recency (Days):", ns, data),
      get_score_revenue_columns("revenue", "Revenue:", ns, data),
      gen_score_ui(ns)
    )
  )
}

cust_date_ui <- function(ns, data) {
  tagList(
    fluidRow(
      tab_title('Generate RFM Score')
    ),
    fluidRow(
      get_score_id_columns("customer_id", "Unique ID:", ns, data),
      get_score_revenue_columns("n_transactions", "Transactions:", ns, data),
      get_score_date_columns("latest_visit_date", "Latest Visit Date:", ns, data),
      get_score_revenue_columns("revenue", "Total Revenue:", ns, data),
      gen_score_ui(ns)
    )
  )
}

get_score_id_columns <- function(id, label, ns, data) {

 # type_id <- reactive({ c(data() %>% select(where(is.numeric)) %>% names(),
 #               data() %>% select(where(is.character)) %>% names()) })

 type_id <- reactive({ c(names(Filter(is.numeric, data())),
                       names(Filter(is.character, data()))) })

             tagList(
              column(4),
              column(2, align = "right", br(), h5(label)),
              column(6, align = "left",
                     selectInput(ns(id), label = "", choices = type_id(), 
                                 selected = type_id(), width = "180px"
                     )
              )
            )
}

get_score_date_columns <- function(id, label, ns, data) {

 # type_id <- reactive({ 
 #   data() %>% 
 #    select(where(is.Date)) %>% 
 #    names()
 # })

 type_id <- names(Filter(function(x) inherits(x, "Date"), data()))            

             tagList(
              column(4),
              column(2, align = "right", br(), h5(label)),
              column(6, align = "left",
                     selectInput(ns(id), label = "", choices = type_id(), 
                                 selected = type_id(), width = "180px"
                     )
              )
            )
}

get_score_revenue_columns <- function(id, label, ns, data) {

 # type_id <- reactive({ 
 #   data() %>% 
 #    select(where(is.numeric)) %>% 
 #    names()
 # })
               
 type_id <- reactive({ names(Filter(is.numeric, data())) })
             
   tagList(
              column(4),
              column(2, align = "right", br(), h5(label)),
              column(6, align = "left",
                     selectInput(ns(id), label = "", choices = type_id(), 
                                 selected = type_id(), width = "180px"
                     )
              )
            )
}

gen_score_ui <- function(ns) {
  tagList(
    score_date_input("analysis_date", "Analysis Date:", ns),
    score_numeric_input("bins", "Bins:", ns),
    btn_generate_score(ns)
  )
}
