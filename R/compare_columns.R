#' Compare Columns Validator
#'
#' Compares values between two columns.
#'
#' Flags rows where the comparison condition is TRUE.
#'
#' Useful for:
#' \itemize{
#'   \item chronological checks
#'   \item age consistency checks
#'   \item enrollment and exit validations
#'   \item minimum and maximum comparisons
#' }
#'
#' @param col1 First column
#' @param col2 Second column
#' @param operator Comparison operator.
#'
#' Supported operators:
#' \itemize{
#'   \item \code{"<"}
#'   \item \code{">"}
#'   \item \code{"<="}
#'   \item \code{">="}
#'   \item \code{"=="}
#'   \item \code{"!="}
#' }
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
#' # example 1: exit date before enrollment date ------------------------
#'
#' report <- report %>%
#'
#'   add_validation(
#'
#'     label = "Exit Before Enrollment",
#'
#'     columns = c(
#'       "date_enrolled",
#'       "date_exited"
#'     ),
#'
#'     rule =
#'       "Exit date should not be before enrollment date",
#'
#'     check = compare_columns(
#'       col1 = "date_exited",
#'       col2 = "date_enrolled",
#'       operator = "<"
#'     )
#'   )
#'
#' # example 2: age less than minimum age -------------------------------
#'
#' report <- report %>%
#'
#'   add_validation(
#'
#'     label = "Caregiver Younger Than Child",
#'
#'     columns = c(
#'       "caregiver_age",
#'       "child_age"
#'     ),
#'
#'     rule =
#'       "Caregiver age should be greater than child age",
#'
#'     check = compare_columns(
#'       col1 = "caregiver_age",
#'       col2 = "child_age",
#'       operator = "<="
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

compare_columns <- function(
    col1,
    col2,
    operator = "<"
){

  op <- switch(

    operator,

    "<"  = `<`,
    ">"  = `>`,
    "<=" = `<=`,
    ">=" = `>=`,
    "==" = `==`,
    "!=" = `!=`,

    stop("Invalid operator.")
  )

  function(data){

    x <- data[[col1]]

    y <- data[[col2]]

    !is.na(x) &
      !is.na(y) &
      op(x, y)
  }
}
