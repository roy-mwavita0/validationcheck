#' After Date Validator
#'
#' Flags dates that are NOT after a given reference date.
#'
#' @param date Reference date
#'
#' @return Validation function
#'
#' @family validators
#' @export

after_date <- function(date){

  ref_date <- as.Date(date)

  function(column){

    column <- as.Date(column)

    !is.na(column) &
      column <= ref_date
  }
}
