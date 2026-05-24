#' Extract Failed Records
#'
#' Returns failed records for a specific validation check.
#'
#' Useful for:
#' \itemize{
#'   \item reviewing validation failures
#'   \item exporting problematic records
#'   \item conducting data cleaning
#'   \item sharing error extracts with teams
#' }
#'
#' @param agent Validation object created using
#' \code{\link{validate_data}}.
#'
#' @param validation_name Character value specifying
#' the validation check label.
#'
#' @return
#' Returns a dataframe containing failed records
#' for the selected validation check.
#'
#' @details
#' Failed records are retrieved using the internally
#' stored validation ID linked to the validation label.
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
#' # add validation -----------------------------------------------------
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
#'   )
#'
#' # extract failed rows ------------------------------------------------
#'
#' failed_records <- get_failed(
#'   report,
#'   "Age Above 24"
#' )
#'
#' failed_records
#'
#' @seealso
#' \code{\link{add_validation}}
#' \code{\link{get_report}}
#' \code{\link{validate_data}}
#'
#' @export

get_failed <- function(
    agent,
    validation_name
){

  validation_id <- agent$report %>%

    dplyr::filter(
      validation_check == validation_name
    ) %>%

    dplyr::pull(validation_id)

  if(length(validation_id) == 0){

    stop(
      paste0(
        "Validation check '",
        validation_name,
        "' not found."
      )
    )
  }

  agent$failed_rows[[validation_id[1]]]
}
