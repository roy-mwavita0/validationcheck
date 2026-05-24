#' Validation Functions
#'
#' Built-in validation functions used inside
#' \code{\link{add_validation}}.
#'
#' These validators help identify:
#' \itemize{
#'   \item numeric inconsistencies
#'   \item missing values
#'   \item duplicate records
#'   \item invalid categories
#'   \item text formatting issues
#'   \item invalid dates
#'   \item logical data inconsistencies
#' }
#'
#' Numeric Validators:
#' \itemize{
#'   \item \code{\link{greater_than}}
#'   \item \code{\link{less_than}}
#'   \item \code{\link{greater_equal}}
#'   \item \code{\link{less_equal}}
#'   \item \code{\link{equal_to}}
#'   \item \code{\link{not_equal}}
#'   \item \code{\link{range_between}}
#'   \item \code{\link{is_positive}}
#'   \item \code{\link{is_negative}}
#' }
#'
#' Missingness Validators:
#' \itemize{
#'   \item \code{\link{is_missing}}
#'   \item \code{\link{not_missing}}
#' }
#'
#' Duplicate Validators:
#' \itemize{
#'   \item \code{\link{duplicates}}
#'   \item \code{\link{unique_values}}
#' }
#'
#' Character Validators:
#' \itemize{
#'   \item \code{\link{include}}
#'   \item \code{\link{exclude}}
#'   \item \code{\link{contains}}
#'   \item \code{\link{starts_with}}
#'   \item \code{\link{ends_with}}
#'   \item \code{\link{matches_regex}}
#' }
#'
#' Date Validators:
#' \itemize{
#'   \item \code{\link{before_date}}
#'   \item \code{\link{after_date}}
#'   \item \code{\link{between_dates}}
#'   \item \code{\link{future_date}}
#'   \item \code{\link{past_date}}
#' }
#'
#' Cross-field Validators:
#' \itemize{
#'   \item \code{\link{compare_columns}}
#'   \item \code{\link{date_before}}
#'   \item \code{\link{conditional_required}}
#' }
#'
#' @seealso
#' \code{\link{add_validation}}
#' \code{\link{validate_data}}
#'
#' @name validators
NULL
