#' Negative Value Validator
#'
#' Checks whether values are negative.
#'
#' Flags rows where values are zero or positive.
#'
#' Useful for:
#' \itemize{
#'   \item validating debt balances
#'   \item checking negative adjustments
#'   \item identifying incorrect financial entries
#'   \item enforcing expected negative values
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
#'   \item the value is greater than or equal to zero
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
#' # example 1: adjustment values should be negative --------------------
#'
#' report <- report %>%
#'
#'   add_validation(
#'
#'     label = "Non-Negative Adjustments",
#'
#'     columns = "adjustment_amount",
#'
#'     rule =
#'       "Adjustment amounts should be negative values",
#'
#'     check = is_negative()
#'   )
#'
#' # example 2: account balance should remain negative ------------------
#'
#' report <- report %>%
#'
#'   add_validation(
#'
#'     label = "Positive Debt Balance",
#'
#'     columns = "debt_balance",
#'
#'     rule =
#'       "Debt balance should be negative",
#'
#'     check = is_negative()
#'   )
#'
#' # generate report ----------------------------------------------------
#'
#' get_report(report)
#'
#' @seealso
#' \code{\link{add_validation}}
#' \code{\link{validate_data}}
#' @family validators
#' @export

is_negative <- function(){

  function(column){

    !is.na(column) &
      column >= 0
  }
}
