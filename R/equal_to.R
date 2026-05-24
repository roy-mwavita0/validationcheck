#' Equal To Validator
#'
#' Checks whether values are equal to an expected value.
#'
#' Flags rows where values are NOT equal to the specified value.
#'
#' Useful for:
#' \itemize{
#'   \item validating fixed categories
#'   \item checking expected status values
#'   \item enforcing standard responses
#'   \item validating binary indicators
#' }
#'
#' @param x Expected value.
#'
#' @return
#' Returns a validation function used inside
#' \code{\link{add_validation}}.
#'
#' @details
#' The validator flags rows where:
#'
#' \itemize{
#'   \item the value is not equal to the expected value
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
#' # example 1: status should be ACTIVE ---------------------------------
#'
#' report <- report %>%
#'
#'   add_validation(
#'
#'     label = "Inactive Participants",
#'
#'     columns = "program_status",
#'
#'     rule =
#'       "Program status should be ACTIVE",
#'
#'     check = equal_to("ACTIVE")
#'   )
#'
#' # example 2: consent indicator should equal YES ----------------------
#'
#' report <- report %>%
#'
#'   add_validation(
#'
#'     label = "Missing Consent",
#'
#'     columns = "consent_provided",
#'
#'     rule =
#'       "Consent should be marked as YES",
#'
#'     check = equal_to("YES")
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

equal_to <- function(x){

  function(column){

    !is.na(column) &
      column != x
  }
}
