#' Pipe operator
#'
#' @name %>%
#' @rdname pipe
#' @keywords internal
#' @export
#' @importFrom purrr %>%
#' @usage lhs \%>\% rhs
#' @return The result of \code{rhs(lfs)}.
NULL

#' NULL operator
#'
#' @name %||%
#' @rdname pipe
#' @keywords internal
#' @export
#' @importFrom purrr %||%
#' @usage x \%||\% y
#' @return If \code{rhs} is NULL, will return \code{lhs}; otherwise returns \code{rhs}.
NULL
