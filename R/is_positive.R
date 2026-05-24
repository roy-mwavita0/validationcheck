#' Positive Value Validator
#'
#' Checks whether values are positive.
#'
#' Flags rows where values are zero or negative.
#'
#' Useful for:
#' \itemize{
#'   \item validating income values
#'   \item checking quantities
#'   \item verifying service counts
#'   \item ensuring positive measurements
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
#'   \item the value is less than or equal to zero
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
#' # example 1: household income should be positive ---------------------
#'
#' report <- report %>%
#'
#'   add_validation(
#'
#'     label = "Non-Positive Household Income",
#'
#'     columns = "household_income",
#'
#'     rule =
#'       "Household income should be a positive value",
#'
#'     check = is_positive()
#'   )
#'
#' # example 2: service count should be above zero ----------------------
#'
#' report <- report %>%
#'
#'   add_validation(
#'
#'     label = "Invalid Service Count",
#'
#'     columns = "service_count",
#'
#'     rule =
#'       "Service count should be greater than zero",
#'
#'     check = is_positive()
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

is_positive <- function(){

  function(column){

    !is.na(column) &
      column <= 0
  }
}
