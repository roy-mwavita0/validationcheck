#' Exclude Validator
#'
#' Flags values that belong to a restricted list.
#'
#' Useful for:
#' \itemize{
#'   \item invalid categories
#'   \item prohibited responses
#'   \item restricted program statuses
#'   \item disallowed placeholder values
#' }
#'
#' @param values Character vector of forbidden values.
#'
#' @return
#' Returns a validation function used inside
#' \code{\link{add_validation}}.
#'
#' @details
#' The validator flags rows where:
#'
#' \itemize{
#'   \item the value belongs to the restricted list
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
#' # example 1: placeholder names should not exist ----------------------
#'
#' report <- report %>%
#'
#'   add_validation(
#'
#'     label = "Invalid Participant Names",
#'
#'     columns = "participant_name",
#'
#'     rule =
#'       "Participant names should not contain placeholders",
#'
#'     check = exclude(
#'       c(
#'         "TEST",
#'         "UNKNOWN",
#'         "N/A"
#'       )
#'     )
#'   )
#'
#' # example 2: restricted statuses -------------------------------------
#'
#' report <- report %>%
#'
#'   add_validation(
#'
#'     label = "Restricted Program Status",
#'
#'     columns = "program_status",
#'
#'     rule =
#'       "Program status should not contain restricted values",
#'
#'     check = exclude(
#'       c(
#'         "PENDING",
#'         "INVALID"
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

exclude <- function(values){

  function(column){

    !is.na(column) &
      column %in% values
  }
}
