#' Greater or Equal Validator
#'
#' Checks whether values are greater than or equal
#' to a specified threshold.
#'
#' Flags rows where values are greater than or equal
#' to the threshold.
#'
#' Useful for:
#' \itemize{
#'   \item identifying age limits
#'   \item validating minimum thresholds
#'   \item detecting high-risk values
#'   \item program eligibility checks
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
#'   \item the value is greater than or equal to
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
#' # example 1: age should be below 18 -------------------------------
#'
#' report <- report %>%
#'
#'   add_validation(
#'
#'     label = "Age 18 And Above",
#'
#'     columns = "age",
#'
#'     rule =
#'       "Participant age should be below 18 years",
#'
#'     check = greater_equal(18)
#'   )
#'
#' # example 2: viral load threshold -----------------------------------
#'
#' report <- report %>%
#'
#'   add_validation(
#'
#'     label = "High Viral Load",
#'
#'     columns = "viral_load",
#'
#'     rule =
#'       "Viral load should be below 1000 copies/ml",
#'
#'     check = greater_equal(1000)
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

greater_equal <- function(x){

  function(column){

    !is.na(column) &
      column >= x
  }
}
