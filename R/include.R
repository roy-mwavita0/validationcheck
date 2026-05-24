#' Include Validator
#'
#' Checks whether values belong to an allowed
#' set of categories.
#'
#' Flags rows where values are NOT included
#' in the allowed list.
#'
#' Useful for:
#' \itemize{
#'   \item validating categorical variables
#'   \item checking program statuses
#'   \item enforcing standard response options
#'   \item validating coded values
#' }
#'
#' @param values Character vector of allowed values.
#'
#' @return
#' Returns a validation function used inside
#' \code{\link{add_validation}}.
#'
#' @details
#' The validator flags rows where:
#'
#' \itemize{
#'   \item the value is not found in the allowed list
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
#' # example 1: valid program status ------------------------------------
#'
#' report <- report %>%
#'
#'   add_validation(
#'
#'     label = "Invalid Program Status",
#'
#'     columns = "program_status",
#'
#'     rule =
#'       "Program status should be ACTIVE or EXITED",
#'
#'     check = include(
#'       c(
#'         "ACTIVE",
#'         "EXITED"
#'       )
#'     )
#'   )
#'
#' # example 2: valid sex categories ------------------------------------
#'
#' report <- report %>%
#'
#'   add_validation(
#'
#'     label = "Invalid Sex Category",
#'
#'     columns = "sex",
#'
#'     rule =
#'       "Sex should be MALE or FEMALE",
#'
#'     check = include(
#'       c(
#'         "MALE",
#'         "FEMALE"
#'       )
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

include <- function(values){

  function(column){

    !is.na(column) &
      !(column %in% values)
  }
}
