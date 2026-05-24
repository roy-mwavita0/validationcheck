#' Future Date Validator
#'
#' Checks whether dates occur in the future.
#'
#' Flags rows where dates are NOT future dates.
#'
#' Useful for:
#' \itemize{
#'   \item appointment scheduling
#'   \item planned follow-up visits
#'   \item projected service dates
#'   \item expected review timelines
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
#'   \item the date is before today's date
#'   \item and the date is not missing
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
#' # example 1: follow-up date should be in the future ------------------
#'
#' report <- report %>%
#'
#'   add_validation(
#'
#'     label = "Past Follow-Up Dates",
#'
#'     columns = "follow_up_date",
#'
#'     rule =
#'       "Follow-up dates should occur in the future",
#'
#'     check = future_date()
#'   )
#'
#' # example 2: appointment date should be future -----------------------
#'
#' report <- report %>%
#'
#'   add_validation(
#'
#'     label = "Past Appointment Dates",
#'
#'     columns = "appointment_date",
#'
#'     rule =
#'       "Appointment dates should be future dates",
#'
#'     check = future_date()
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

future_date <- function(){

  function(column){

    column <- as.Date(column)

    !is.na(column) &
      column < Sys.Date()
  }
}
