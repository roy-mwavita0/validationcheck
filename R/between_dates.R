#' Between Dates Validator
#'
#' Flags dates outside a valid range.
#'
#' @param start Start date
#' @param end End date
#'
#' @return Validation function
#'
#' @family validators
#' @export

between_dates <- function(start, end){

  start <- as.Date(start)

  end <- as.Date(end)

  function(column){

    column <- as.Date(column)

    !is.na(column) &
      (
        column < start |
          column > end
      )
  }
}
