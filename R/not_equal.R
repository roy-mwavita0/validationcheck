#' Not Equal Validator
#'
#' Checks whether values are equal to
#' a forbidden value.
#'
#' Flags rows where values match
#' the excluded value.
#'
#' Useful for:
#' \itemize{
#'   \item excluding invalid responses
#'   \item checking prohibited categories
#'   \item detecting placeholder values
#'   \item enforcing restricted entries
#' }
#'
#' @param x Value to exclude.
#'
#' @return
#' Returns a validation function used inside
#' \code{\link{add_validation}}.
#'
#' @details
#' The validator flags rows where:
#'
#' \itemize{
#'   \item the value is equal to the forbidden value
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
#' # example 1: unknown status should not exist -------------------------
#'
#' report <- report %>%
#'
#'   add_validation(
#'
#'     label = "Unknown Program Status",
#'
#'     columns = "program_status",
#'
#'     rule =
#'       "Program status should not be UNKNOWN",
#'
#'     check = not_equal("UNKNOWN")
#'   )
#'
#' # example 2: age should not equal zero -------------------------------
#'
#' report <- report %>%
#'
#'   add_validation(
#'
#'     label = "Zero Age Recorded",
#'
#'     columns = "age",
#'
#'     rule =
#'       "Age should not be recorded as zero",
#'
#'     check = not_equal(0)
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

not_equal <- function(x){

  function(column){

    !is.na(column) &
      column == x
  }
}
