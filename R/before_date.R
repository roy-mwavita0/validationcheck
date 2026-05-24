#' Before Date Validator
#'
#' Flags dates that are NOT before a given reference date.
#'
#' @param date Reference date (character or Date)
#'
#' @family validators
#' @export
before_date <- function(date) {

  ref_date <- as.Date(date)

  function(column){

    column <- as.Date(column)

    !is.na(column) &
      column >= ref_date
  }
}
