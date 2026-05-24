#' Less or Equal Validator
#'
#' Checks whether values are less than or equal
#' to a specified threshold.
#'
#' Flags rows where values are less than or equal
#' to the threshold.
#'
#' Useful for:
#' \itemize{
#'   \item identifying minimum age violations
#'   \item validating lower thresholds
#'   \item detecting low-risk values
#'   \item enforcing minimum acceptable limits
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
#'   \item the value is less than or equal to
#'   the specified threshold
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
#' # example 1: age should be above 5 -----------------------------------
#'
#' report <- report %>%
#'
#'   add_validation(
#'
#'     label = "Age 5 And Below",
#'
#'     columns = "age",
#'
#'     rule =
#'       "Participant age should be above 5 years",
#'
#'     check = less_equal(5)
#'   )
#'
#' # example 2: weight should exceed minimum threshold ------------------
#'
#' report <- report %>%
#'
#'   add_validation(
#'
#'     label = "Low Weight Measurement",
#'
#'     columns = "weight",
#'
#'     rule =
#'       "Weight should be greater than 2.5 kg",
#'
#'     check = less_equal(2.5)
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

less_equal <- function(x){

  function(column){

    !is.na(column) &
      column <= x
  }
}
