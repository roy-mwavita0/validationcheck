#' Date Order Validator
#'
#' Ensures one date occurs before another date.
#'
#' Flags rows where:
#' \itemize{
#'   \item both dates are available
#'   \item and the first date is greater than or equal to the second date
#' }
#'
#' Useful for:
#' \itemize{
#'   \item enrollment and exit dates
#'   \item appointment scheduling
#'   \item birth and registration dates
#'   \item referral and service timelines
#' }
#'
#' @param col1 Earlier date column.
#' @param col2 Later date column.
#'
#' @return
#' Returns a validation function used inside
#' \code{\link{add_validation}}.
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
#' # example 1: enrollment should occur before exit ---------------------
#'
#' report <- report %>%
#'
#'   add_validation(
#'
#'     label = "Invalid Exit Timeline",
#'
#'     columns = c(
#'       "date_enrolled",
#'       "date_exited"
#'     ),
#'
#'     rule =
#'       "Enrollment date should occur before exit date",
#'
#'     check = date_before(
#'       col1 = "date_enrolled",
#'       col2 = "date_exited"
#'     )
#'   )
#'
#' # example 2: birth date should occur before registration -------------
#'
#' report <- report %>%
#'
#'   add_validation(
#'
#'     label = "Birth Date After Registration",
#'
#'     columns = c(
#'       "date_of_birth",
#'       "registration_date"
#'     ),
#'
#'     rule =
#'       "Date of birth should occur before registration date",
#'
#'     check = date_before(
#'       col1 = "date_of_birth",
#'       col2 = "registration_date"
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

date_before <- function(col1, col2){

  function(data){

    x <- as.Date(data[[col1]])

    y <- as.Date(data[[col2]])

    !is.na(x) &
      !is.na(y) &
      x >= y
  }
}
