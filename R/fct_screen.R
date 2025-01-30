ds_screener <- function(data) {

  check_df(data)

  rows     <- nrow(data)
  cols     <- ncol(data)
  varnames <- names(data)
  datatype <- sapply(data, class)
  counts   <- sapply(data, length)
  nlev     <- lapply(data, nlevels)
  lev      <- lapply(data, levels)

  for (i in seq_len(length(lev))) {
    if (is.null(lev[[i]])) {
      lev[[i]] <- NA
    }
  }

  mvalues    <- sapply(data, function(z) sum(is.na(z)))
  mvaluesper <- round((mvalues / counts) * 100, 2)
  mtotal     <- sum(is.na(data))
  mtotalper  <- round((mtotal / sum(counts)) * 100, 2)
  mrows      <- sum(!complete.cases(data))
  mcols      <- sum(mvalues != 0)

  result <- list(Rows          = rows,
                 Columns       = cols,
                 Variables     = varnames,
                 Types         = datatype,
                 Count         = counts,
                 nlevels       = nlev,
                 levels        = lev,
                 Missing       = mvalues,
                 MissingPer    = mvaluesper,
                 MissingTotal  = mtotal,
                 MissingTotPer = mtotalper,
                 MissingRows   = mrows,
                 MissingCols   = mcols)

  return(result)
}

print_screen <- function(x) {
  columns <- c("  Column Name  ", "  Data Type  ", "  Levels  ", "  Missing  ", "  Missing (%)  ")
  len_col <- as.vector(sapply(columns, nchar))
  xlev <- lapply(x$levels, paste, collapse = " ") %>%
    lapply(nchar) %>%
    unlist() %>%
    max()
  # If there are several classes, join them into one string:
  x$Types <- lapply(x$Types, paste, collapse = ", ")
  lengths <- list(x$Variables, x$Types, xlev, x$Missing, x$MissingPer)
  n <- length(columns)
  nlist <- list()
  for (i in seq_len(n)) {
    nlist[[i]] <- max(len_col[i], max(sapply(lengths[[i]], nchar)))
  }
  clengths <- unlist(nlist)
  clengths[3] <- max(10, xlev)
  dash <- sum(clengths) + 6
  cat(rep("-", dash), sep = "")
  cat("\n|")
  for (i in seq_len(n)) {
    cat(format(columns[i], width = clengths[i], justify = "centre"), "|", sep = "")
  }
  cat("\n", rep("-", dash), sep = "")
  cat("\n")
  for (i in seq_len(x$Columns)) {
    cat(
      "|", format(x$Variables[i], width = clengths[1], justify = "centre"), "|",
      format(x$Types[i], width = clengths[2], justify = "centre"), "|",
      format(paste(x$levels[[i]], collapse = " "), width = clengths[3], justify = "centre"), "|",
      format(as.character(x$Missing[i]), width = clengths[4], justify = "centre"), "|",
      format(as.character(x$MissingPer[i]), width = clengths[5], justify = "centre"), "|\n", sep = ""
    )
  }
  cat(rep("-", dash), sep = "")
  cat("\n\n")
  cat(
    " Overall Missing Values          ", x$MissingTotal, "\n", "Percentage of Missing Values    ", x$MissingTotPer, "%\n",
    "Rows with Missing Values        ", x$MissingRows, "\n", "Columns With Missing Values     ", x$MissingCols, "\n"
  )
}

check_df <- function(data) {
  data_name <- deparse(substitute(data))
  if (!is.data.frame(data)) {
    stop(paste0(data_name, ' must be a `data.frame` or `tibble`.'), call. = FALSE)
  }
}
