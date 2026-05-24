#' Regex Validator
#'
#' Validates values against a regular expression pattern.
#'
#' Flags rows where values do NOT match
#' the specified regex pattern.
#'
#' Useful for:
#' \itemize{
#'   \item validating phone numbers
#'   \item checking email formats
#'   \item validating identification numbers
#'   \item enforcing structured text formats
#' }
#'
#' @param pattern Regular expression pattern.
#'
#' @return
#' Returns a validation function used inside
#' \code{\link{add_validation}}.
#'
#' @details
#' The validator flags rows where:
#'
#' \itemize{
#'   \item the value does not match the regex pattern
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
#' # example 1: phone number validation ---------------------------------
#'
#' report <- report %>%
#'
#'   add_validation(
#'
#'     label = "Invalid Phone Number",
#'
#'     columns = "phone_number",
#'
#'     rule =
#'       "Phone number should contain 10 digits",
#'
#'     check = matches_regex("^\\\d{10}$")
#'   )
#'
#' # example 2: email validation ----------------------------------------
#'
#' report <- report %>%
#'
#'   add_validation(
#'
#'     label = "Invalid Email Address",
#'
#'     columns = "email_address",
#'
#'     rule =
#'       "Email address should follow standard format",
#'
#'     check = matches_regex(
#'       "^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\\\\.[A-Za-z]{2,}$"
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

matches_regex <- function(pattern){

  function(column){

    !is.na(column) &
      !stringr::str_detect(
        column,
        pattern
      )
  }
}
