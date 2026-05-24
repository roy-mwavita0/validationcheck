#' Greater Than Validator
#'
#' Checks whether values are greater than a threshold.
#'
#' @param x numeric threshold
#'
#' @return logical expression for validation
#'
#' @family validators
#' @export
greater_than <- function(x) {

  function(column) {
    column > x
  }
}
