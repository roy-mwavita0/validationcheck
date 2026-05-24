#' Sample Registry Dataset
#'
#' A sample adolescent registry dataset included in validationcheck.
#'
#' The dataset contains intentionally introduced data quality issues
#' for testing validation rules.
#'
#' @format A tibble with 5 rows and 6 variables:
#' \describe{
#'   \item{registry_id}{Unique participant identifier}
#'   \item{county}{County of enrollment}
#'   \item{age}{Participant age}
#'   \item{birth_certificate_number}{Birth certificate number}
#'   \item{hiv_status}{Participant HIV status}
#'   \item{program_status}{Program participation status}
#' }
#'
#' @source Simulated dataset for demonstration
"sample_registry"
