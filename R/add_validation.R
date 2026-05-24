#' Add Validation Rule
#'
#' Applies a validation rule to a validation agent object.
#'
#' This function evaluates user-defined validation checks
#' and stores validation results including:
#' \itemize{
#'   \item failed records
#'   \item failure rates
#'   \item severity classification
#'   \item validation summaries
#' }
#'
#' Validation rules can be used to identify:
#' \itemize{
#'   \item duplicate records
#'   \item missing values
#'   \item invalid dates
#'   \item age inconsistencies
#'   \item logical data errors
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
#' @param preconditions Optional preprocessing steps applied
#' before validation.
#'
#' @param check Validation condition used to identify failed rows.
#'
#' @return
#' Returns an updated validation object containing:
#' \itemize{
#'   \item validation results
#'   \item failure rates
#'   \item severity classification
#'   \item failed records (stored separately for reliability)
#' }
#'
#' @details
#' Severity classification is automatically assigned
#' based on failure rate:
#'
#' \itemize{
#'   \item GOOD = 0% to 2%
#'   \item WARNING = Above 2% to 20%
#'   \item CRITICAL = Above 20%
#' }
#'
#' @examples
#'
#' library(validationcheck)
#'
#' report <- validate_data(sample_registry)
#'
#' report <- report %>%
#'   add_validation(
#'     label = "Age Above 24",
#'     columns = "age",
#'     rule = "Participant age should not exceed 24 years",
#'     check = age > 24
#'   )
#'
#' @export
add_validation <- function(
    agent,
    label,
    columns,
    rule,
    preconditions = identity,
    check
){

  # -------------------- original dataset -------------------------------
  data <- agent$data

  # -------------------- apply preprocessing ----------------------------
  checked_data <- preconditions(data)

  # -------------------- evaluate condition -----------------------------
  failed_index <- tryCatch(

    {

      # dataframe validator ----------------------------------

      result <- check(checked_data)

      if(is.logical(result) &&
         length(result) == nrow(checked_data)){

        result

      } else {

        stop()
      }

    },

    error = function(e){

      # column validator -------------------------------------

      Reduce(

        `|`,

        lapply(columns, function(col){

          col_data <- checked_data[[col]]

          check(col_data)

        })
      )
    }
  )

  failed_rows <- checked_data[failed_index, , drop = FALSE]

  # -------------------- counts -----------------------------------------
  rows_checked <- nrow(checked_data)
  failed_validation <- nrow(failed_rows)

  # -------------------- failure rate -----------------------------------
  failure_rate <- ifelse(
    rows_checked == 0,
    0,
    round((failed_validation / rows_checked) * 100, 2)
  )

  # -------------------- severity classification ------------------------
  severity <- dplyr::case_when(
    failure_rate <= 2 ~ "GOOD",
    failure_rate > 2 & failure_rate <= 20 ~ "WARNING",
    TRUE ~ "CRITICAL"
  )

  # -------------------- stable validation ID ---------------------------
  validation_id <- paste0(
    gsub(" ", "_", label),
    "_",
    format(Sys.time(), "%Y%m%d%H%M%S")
  )

  # -------------------- store failed rows separately -------------------
  if (is.null(agent$failed_rows)) {
    agent$failed_rows <- list()
  }

  agent$failed_rows[[validation_id]] <- failed_rows

  # -------------------- validation result ------------------------------
  result <- tibble::tibble(
    validation_id = validation_id,
    validation_check = label,
    columns_checked = paste(columns, collapse = ", "),
    validation_rule = rule,
    rows_checked = rows_checked,
    failed_validation = failed_validation,
    failure_rate = failure_rate,
    severity = severity
  )

  # -------------------- append report ----------------------------------
  agent$report <- dplyr::bind_rows(
    agent$report,
    result
  )

  agent
}
