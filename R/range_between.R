#' Range Validator
#'
#' Checks whether values fall outside
#' a specified range.
#'
#' Flags rows where values are below the minimum
#' or above the maximum threshold.
#'
#' Useful for:
#' \itemize{
#'   \item validating age ranges
#'   \item checking laboratory measurements
#'   \item enforcing acceptable score limits
#'   \item validating date ranges
#' }
#'
#' @param min Minimum allowed value.
#' @param max Maximum allowed value.
#'
#' @return
#' Returns a validation function used inside
#' \code{\link{add_validation}}.
#'
#' @details
#' The validator flags rows where:
#'
#' \itemize{
#'   \item the value is below the minimum threshold
#'   \item the value is above the maximum threshold
#'   \item and the value is not missing
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
#' # example 1: age should be between 10 and 24 -------------------------
#'
#' report <- report %>%
#'
#'   add_validation(
#'
#'     label = "Age Outside Valid Range",
#'
#'     columns = "age",
#'
#'     rule =
#'       "Participant age should be between 10 and 24 years",
#'
#'     check = range_between(10, 24)
#'   )
#'
#' # example 2: enrollment dates should be within 2024 ------------------
#'
#' report <- report %>%
#'
#'   add_validation(
#'
#'     label = "Enrollment Dates Outside 2024",
#'
#'     columns = "date_enrolled",
#'
#'     rule =
#'       "Enrollment dates should occur within 2024",
#'
#'     check = range_between(
#'       as.Date("2024-01-01"),
#'       as.Date("2024-12-31")
#'     )
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

range_between <- function(min, max){

  function(column){

    !is.na(column) &
      (
        column < min |
          column > max
      )
  }
}
