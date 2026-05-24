#' Past Date Validator
#'
#' Checks whether dates occur in the past.
#'
#' Flags rows where dates are future dates.
#'
#' Useful for:
#' \itemize{
#'   \item validating birth dates
#'   \item checking enrollment dates
#'   \item verifying historical records
#'   \item ensuring completed event dates
#' }
#'
#' @return
#' Returns a validation function used inside
#' \code{\link{add_validation}}.
#'
#' @details
#' The validator flags rows where:
#'
#' \itemize{
#'   \item the date is after today's date
#'   \item and the date is not missing
#' }
#'
#' @examples
#'
#' library(validationcheck)
#' library(magrittr)
#'
#' # initialize validation agent ----------------------------------------
#'
#' report <- validate_data(sample_registry)
#'
#' # example 1: birth date should be in the past ------------------------
#'
#' report <- report %>%
#'
#'   add_validation(
#'
#'     label = "Future Birth Dates",
#'
#'     columns = "date_of_birth",
#'
#'     rule =
#'       "Date of birth should occur in the past",
#'
#'     check = past_date()
#'   )
#'
#' # example 2: enrollment date should not be future --------------------
#'
#' report <- report %>%
#'
#'   add_validation(
#'
#'     label = "Future Enrollment Dates",
#'
#'     columns = "date_enrolled",
#'
#'     rule =
#'       "Enrollment date should not be in the future",
#'
#'     check = past_date()
#'   )
#'
#' # generate report ----------------------------------------------------
#'
#' get_report(report)
#'
#' @seealso
#' \code{\link{add_validation}}
#' \code{\link{validate_data}}
#'
#' @family validators
#' @export

past_date <- function(){

  function(column){

    column <- as.Date(column)

    !is.na(column) &
      column > Sys.Date()
  }
}
