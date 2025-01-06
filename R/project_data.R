# global <- new.env()
global$project_data <- list()

save_raw_data <- function(data) {
  global$project_data[["raw_data"]] <- data
}

save_selected_data <- function(data) {
  global$project_data[["selected_data"]] <- data
}

save_modified_data <- function(data) {
  global$project_data[["modified_data"]] <- data
}

save_rfm_score <- function(score) {
  global$project_data[["rfm_score"]] <- score
}

save_rfm_segments <- function(segments) {
  global$project_data[["rfm_segments"]] <- segments
}

save_segment_summary <- function(segment_summary) {
  global$project_data[["segment_summary"]] <- segment_summary
}
