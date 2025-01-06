segment_names <- c("Champions", "Potential Loyalist", "Loyal Customers",
                   "Promising", "New Customers", "Can't Lose Them",
                   "At Risk", "Need Attention", "About To Sleep", "Lost")

recency_lower <-   c(5, 3, 2, 3, 4, 1, 1, 1, 2, 1)

recency_upper <-   c(5, 5, 4, 4, 5, 2, 2, 3, 3, 1)

frequency_lower <- c(5, 3, 2, 1, 1, 3, 2, 3, 1, 1)

frequency_upper <- c(5, 5, 4, 3, 3, 4, 5, 5, 3, 5)

monetary_lower <-  c(5, 2, 2, 3, 1, 4, 4, 3, 1, 1)

monetary_upper <-  c(5, 5, 4, 5, 5, 5, 5, 5, 4, 5)

transaction_data <- rfm::rfm_data_orders

customer_data <- rfm::rfm_data_customer
