#' Less Than Validator
#'
#' Checks whether values are less than
#' a specified threshold.
#'
#' Flags rows where values are less than
#' the threshold.
#'
#' Useful for:
#' \itemize{
#'   \item identifying underage participants
#'   \item validating minimum limits
#'   \item detecting unusually low values
#'   \item enforcing lower boundaries
#' }
#'
#' @param x Numeric threshold.
#'
#' @return
#' Returns a validation function used inside
#' \code{\link{add_validation}}.
#'
#' @details
#' The validator flags rows where:
#'
#' \itemize{
#'   \item the value is less than the specified threshold
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
#' # example 1: age should not be below 10 ------------------------------
#'
#' report <- report %>%
#'
#'   add_validation(
#'
#'     label = "Age Below 10",
#'
#'     columns = "age",
#'
#'     rule =
#'       "Participant age should not be below 10 years",
#'
#'     check = less_than(10)
#'   )
#'
#' # example 2: income below minimum threshold --------------------------
#'
#' report <- report %>%
#'
#'   add_validation(
#'
#'     label = "Low Household Income",
#'
#'     columns = "household_income",
#'
#'     rule =
#'       "Household income should not be below 500",
#'
#'     check = less_than(500)
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

less_than <- function(x){

  function(column){

    !is.na(column) &
      column < x
  }
}
