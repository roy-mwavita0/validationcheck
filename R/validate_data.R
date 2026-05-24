#' Initialize Validation Agent
#'
#' Creates a validation object used to run and store
#' data quality validation checks.
#'
#' The validation agent acts as the main object
#' for the validation workflow in the validationcheck package.
#'
#' Users can:
#' \itemize{
#'   \item add validation rules using \code{\link{add_validation}}
#'   \item generate interactive reports using \code{\link{get_report}}
#'   \item extract failed records using \code{\link{get_failed}}
#' }
#'
#' @param data A dataframe or tibble to validate.
#'
#' @return
#' Returns a validation agent object containing:
#' \itemize{
#'   \item original dataset
#'   \item validation results
#'   \item failed records
#' }
#'
#' @details
#' The validation agent stores validation checks and
#' produces interactive data quality reports.
#'
#' This function is the first step in the
#' validation workflow.
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
#' # add validation checks ----------------------------------------------
#'
#' report <- report %>%
#'
#'   add_validation(
#'
#'     label = "Age Above 24",
#'
#'     columns = "age",
#'
#'     rule =
#'       "Participant age should not exceed 24 years",
#'
#'     check = greater_than(24)
#'   ) %>%
#'
#'   add_validation(
#'
#'     label = "Missing Sex",
#'
#'     columns = "sex",
#'
#'     rule =
#'       "Sex should not be missing",
#'
#'     check = is_missing()
#'   )
#'
#' # generate report ----------------------------------------------------
#'
#' get_report(report)
#'
#' @seealso
#' \code{\link{add_validation}}
#' \code{\link{get_report}}
#' \code{\link{get_failed}}
#'
#' @export

validate_data <- function(data){

  structure(

    list(

      # original dataset -----------------------------------------------

      data = data,

      # validation summary results -------------------------------------

      report = tibble::tibble(),

      # failed rows stored separately ----------------------------------

      failed_rows = list()
    ),

    class = "validationcheck"
  )
}
