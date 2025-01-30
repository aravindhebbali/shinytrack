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

check_df <- function(data) {
  data_name <- deparse(substitute(data))
  if (!is.data.frame(data)) {
    stop(paste0(data_name, ' must be a `data.frame` or `tibble`.'), call. = FALSE)
  }
}
