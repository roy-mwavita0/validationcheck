#' Starts With Validator
#'
#' Checks whether values start with
#' a specified prefix.
#'
#' Flags rows where values do NOT begin
#' with the expected text pattern.
#'
#' Useful for:
#' \itemize{
#'   \item validating identification codes
#'   \item checking program prefixes
#'   \item enforcing naming conventions
#'   \item validating facility identifiers
#' }
#'
#' @param text Prefix string.
#'
#' @return
#' Returns a validation function used inside
#' \code{\link{add_validation}}.
#'
#' @details
#' The validator flags rows where:
#'
#' \itemize{
#'   \item the value does not start with the prefix
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
#' # example 1: OVC IDs should start with OVC ---------------------------
#'
#' report <- report %>%
#'
#'   add_validation(
#'
#'     label = "Invalid OVC ID Prefix",
#'
#'     columns = "ovc_id",
#'
#'     rule =
#'       "OVC IDs should start with OVC",
#'
#'     check = starts_with("OVC")
#'   )
#'
#' # example 2: facility codes should start with FAC --------------------
#'
#' report <- report %>%
#'
#'   add_validation(
#'
#'     label = "Invalid Facility Code Prefix",
#'
#'     columns = "facility_code",
#'
#'     rule =
#'       "Facility codes should start with FAC",
#'
#'     check = starts_with("FAC")
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

starts_with <- function(text){

  function(column){

    !is.na(column) &
      !stringr::str_starts(
        column,
        stringr::fixed(text)
      )
  }
}
