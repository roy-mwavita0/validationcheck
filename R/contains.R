#' Contains Validator
#'
#' Checks whether text values contain a given substring.
#'
#' Flags rows where the specified text is NOT found.
#'
#' Useful for:
#' \itemize{
#'   \item validating email domains
#'   \item checking required keywords
#'   \item verifying identifiers
#'   \item validating naming conventions
#' }
#'
#' @param text Character string to search for.
#'
#' @return
#' Returns a validation function used inside
#' \code{\link{add_validation}}.
#'
#' @details
#' The validator flags rows where:
#'
#' \itemize{
#'   \item the value does not contain the specified text
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
#' # example 1: email should contain @ -------------------------------
#'
#' report <- report %>%
#'
#'   add_validation(
#'
#'     label = "Invalid Email Format",
#'
#'     columns = "email_address",
#'
#'     rule =
#'       "Email address should contain @",
#'
#'     check = contains("@")
#'   )
#'
#' # example 2: phone number should contain country code ---------------
#'
#' report <- report %>%
#'
#'   add_validation(
#'
#'     label = "Missing Country Code",
#'
#'     columns = "phone_number",
#'
#'     rule =
#'       "Phone number should contain +254",
#'
#'     check = contains("+254")
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

contains <- function(text){

  function(column){

    !is.na(column) &
      !stringr::str_detect(
        column,
        stringr::fixed(text)
      )
  }
}
