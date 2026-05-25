#' Add Validation Rule
#'
#' Applies validation rules to a validation agent object.
#'
#' This function evaluates validation checks and stores:
#' \itemize{
#'   \item validation summaries
#'   \item failed records
#'   \item failure rates
#'   \item severity classifications
#' }
#'
#' Validation checks can identify:
#' \itemize{
#'   \item duplicate records
#'   \item missing values
#'   \item invalid dates
#'   \item invalid ranges
#'   \item logical inconsistencies
#'   \item program eligibility issues
#' }
#'
#' @param agent Validation object created using
#' \code{\link{validate_data}}.
#'
#' @param label Character value describing the validation check.
#'
#' @param columns Character vector of columns being validated.
#'
#' @param rule Description of the validation rule.
#'
#' @param preconditions Optional preprocessing pipeline applied
#' before validation.
#'
#' @param check Validation function used to identify failed rows.
#'
#' @return
#' Returns an updated validation object containing:
#' \itemize{
#'   \item validation results
#'   \item failure rates
#'   \item severity classifications
#'   \item failed records
#' }
#'
#' @details
#' Severity is automatically assigned based on failure rate:
#'
#' \itemize{
#'   \item GOOD = 0% to 2%
#'   \item WARNING = Above 2% to 20%
#'   \item CRITICAL = Above 20%
#' }
#'
#' Preconditions allow users to preprocess data before
#' validation using dplyr pipelines.
#'
#' @examples
#'
#' library(validationcheck)
#' library(dplyr)
#'
#' report <- validate_data(sample_registry)
#'
#' report <- report %>%
#'
#'   add_validation(
#'
#'     label = "Age Above 24",
#'
#'     columns = "age",
#'
#'     rule = "Participant age should not exceed 24 years",
#'
#'     preconditions =
#'       filter(hiv_status == "POSITIVE") %>%
#'       distinct(id_number, .keep_all = TRUE),
#'
#'     check = greater_than(24)
#'   ) %>%
#'
#'   add_validation(
#'
#'     label = "Duplicate IDs",
#'
#'     columns = "id_number",
#'
#'     rule = "ID numbers should be unique",
#'
#'     check = duplicates()
#'   )
#'
#' @export

add_validation <- function(
    agent,
    label,
    columns,
    rule,
    preconditions = NULL,
    check
){

  # -----------------------------------------------------------------------
  # ORIGINAL DATA
  # -----------------------------------------------------------------------

  data <- agent$data

  # -----------------------------------------------------------------------
  # CAPTURE PRECONDITIONS
  # -----------------------------------------------------------------------

  preconditions <- rlang::enexpr(preconditions)

  # -----------------------------------------------------------------------
  # APPLY PRECONDITIONS
  # -----------------------------------------------------------------------

  checked_data <- data

  if (!rlang::is_null(preconditions)) {

    checked_data <- rlang::eval_tidy(

      rlang::expr(
        data %>% !!preconditions
      )
    )
  }

  # -----------------------------------------------------------------------
  # VALIDATION CHECK
  # -----------------------------------------------------------------------

  failed_index <- tryCatch(

    {

      # dataframe-level validation ----------------------------------------

      result <- check(checked_data)

      if(
        is.logical(result) &&
        length(result) == nrow(checked_data)
      ){

        result

      } else {

        stop()
      }
    },

    error = function(e){

      # column-level validation -------------------------------------------

      Reduce(

        `|`,

        lapply(columns, function(col){

          col_data <- checked_data[[col]]

          check(col_data)
        })
      )
    }
  )

  # -----------------------------------------------------------------------
  # FAILED ROWS
  # -----------------------------------------------------------------------

  failed_rows <- checked_data[
    failed_index,
    ,
    drop = FALSE
  ]

  # -----------------------------------------------------------------------
  # COUNTS
  # -----------------------------------------------------------------------

  rows_checked <- nrow(checked_data)

  failed_validation <- nrow(failed_rows)

  # -----------------------------------------------------------------------
  # FAILURE RATE
  # -----------------------------------------------------------------------

  failure_rate <- ifelse(

    rows_checked == 0,

    0,

    round(
      (failed_validation / rows_checked) * 100,
      2
    )
  )

  # -----------------------------------------------------------------------
  # SEVERITY CLASSIFICATION
  # -----------------------------------------------------------------------

  severity <- dplyr::case_when(

    failure_rate <= 2 ~ "GOOD",

    failure_rate > 2 &
      failure_rate <= 20 ~ "WARNING",

    TRUE ~ "CRITICAL"
  )

  # -----------------------------------------------------------------------
  # VALIDATION ID
  # -----------------------------------------------------------------------

  validation_id <- paste0(

    gsub(" ", "_", label),

    "_",

    format(
      Sys.time(),
      "%Y%m%d%H%M%S"
    )
  )

  # -----------------------------------------------------------------------
  # STORE FAILED ROWS
  # -----------------------------------------------------------------------

  if (is.null(agent$failed_rows)) {

    agent$failed_rows <- list()
  }

  agent$failed_rows[[validation_id]] <- failed_rows

  # -----------------------------------------------------------------------
  # VALIDATION RESULT
  # -----------------------------------------------------------------------

  result <- tibble::tibble(

    validation_id = validation_id,

    validation_check = label,

    columns_checked =
      paste(columns, collapse = ", "),

    validation_rule = rule,

    rows_checked = rows_checked,

    failed_validation = failed_validation,

    failure_rate = failure_rate,

    severity = severity
  )

  # -----------------------------------------------------------------------
  # APPEND REPORT
  # -----------------------------------------------------------------------

  agent$report <- dplyr::bind_rows(

    agent$report,

    result
  )

  # -----------------------------------------------------------------------
  # RETURN UPDATED AGENT
  # -----------------------------------------------------------------------

  agent
}
