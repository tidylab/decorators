#' @title Not Available / Missing Values
#' @description
#' \code{NA} is a logical constant of length 1 which contains a missing value
#' indicator. Other built-in constants \code{NA_integer_}, \code{NA_real_},
#' \code{NA_complex_} and \code{NA_character_} are missing value place-holder of
#' a particular type.
#'
#' NA constants have two typical uses:
#'
#' 1. Signifying the user what data type a function expect in its input; and
#' 2. Representing missing values of a specific type.
#'
#' This package provides additional \code{NA} types.
#' @return \code{NA} value of a particular type.
#' @name NA_x_
#' @examples
#' class(NA_Date_)
#' class(NA_POSIXct_)
NULL

#' @rdname NA_x_
#' @export
NA_Date_ <- structure(NA_real_, class = "Date")

#' @rdname NA_x_
#' @export
NA_POSIXct_ <- structure(NA_real_, class = c("POSIXct", "POSIXt"))
