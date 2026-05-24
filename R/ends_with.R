#' Ends With Validator
#'
#' Checks whether text values end with a given suffix.
#'
#' Flags rows where the specified suffix is NOT found.
#'
#' Useful for:
#' \itemize{
#'   \item validating file extensions
#'   \item checking email domains
#'   \item validating identifier formats
#'   \item enforcing naming conventions
#' }
#'
#' @param text Suffix string.
#'
#' @return
#' Returns a validation function used inside
#' \code{\link{add_validation}}.
#'
#' @details
#' The validator flags rows where:
#'
#' \itemize{
#'   \item the value does not end with the specified text
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
#' # example 1: email should end with gmail.com -------------------------
#'
#' report <- report %>%
#'
#'   add_validation(
#'
#'     label = "Invalid Gmail Address",
#'
#'     columns = "email_address",
#'
#'     rule =
#'       "Email address should end with gmail.com",
#'
#'     check = ends_with("gmail.com")
#'   )
#'
#' # example 2: files should end with .csv ------------------------------
#'
#' report <- report %>%
#'
#'   add_validation(
#'
#'     label = "Invalid File Extension",
#'
#'     columns = "file_name",
#'
#'     rule =
#'       "Files should end with .csv",
#'
#'     check = ends_with(".csv")
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

ends_with <- function(text){

  function(column){

    !is.na(column) &
      !stringr::str_ends(
        column,
        stringr::fixed(text)
      )
  }
}
