#' Conditional Required Validator
#'
#' Flags missing values when a condition is met.
#'
#' Useful for:
#' \itemize{
#'   \item required phone numbers for active participants
#'   \item mandatory exit dates for exited beneficiaries
#'   \item school details for enrolled children
#'   \item viral load dates for CALHIV records
#' }
#'
#' @param condition Function returning a logical condition.
#' @param field Field that becomes required.
#'
#' @return
#' Returns a validation function used inside
#' \code{\link{add_validation}}.
#'
#' @details
#' The validator flags rows where:
#'
#' \itemize{
#'   \item the condition evaluates to TRUE
#'   \item and the required field is missing
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
#' # example 1: exit date required for exited participants --------------
#'
#' report <- report %>%
#'
#'   add_validation(
#'
#'     label = "Missing Exit Date",
#'
#'     columns = c(
#'       "program_status",
#'       "date_exited"
#'     ),
#'
#'     rule =
#'       "Exited participants must have an exit date",
#'
#'     check = conditional_required(
#'
#'       condition = function(data){
#'         data$program_status == "EXITED"
#'       },
#'
#'       field = "date_exited"
#'     )
#'   )
#'
#' # example 2: school name required for enrolled children --------------
#'
#' report <- report %>%
#'
#'   add_validation(
#'
#'     label = "Missing School Name",
#'
#'     columns = c(
#'       "school_status",
#'       "school_name"
#'     ),
#'
#'     rule =
#'       "Children enrolled in school must have a school name",
#'
#'     check = conditional_required(
#'
#'       condition = function(data){
#'         data$school_status == "IN SCHOOL"
#'       },
#'
#'       field = "school_name"
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

conditional_required <- function(condition, field){

  function(data){

    condition(data) &
      is.na(data[[field]])
  }
}
