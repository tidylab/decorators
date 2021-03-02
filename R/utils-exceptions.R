# BaseException -----------------------------------------------------------
#' @title Exception Base Class
#' @description Test an event and raise an exception if necessary.
#' @noRd
#' @keywords internal
#' @export
BaseException <- R6::R6Class("Exception", public = list())


# ValidationError ---------------------------------------------------------
#' @title ValidationError Exception
#' @family exceptions
#' @noRd
#' @keywords internal
#' @export
ValidationError <- R6::R6Class("ValidationError", inherit = BaseException, public = list(
    #' @description Test the class of an object and raise an exception if necessary.
    #' @param object (`?`) An object to examine.
    #' @param class (`character`) The expected class of \code{object}.
    #' @param name (`character`) The name of the \code{object}.
    initialize = function(object, class, name = NULL){
        class_expected <- class[1]
        class_actual <- class(object)

        if(class_expected %in% class_actual){
            NULL
        } else {
            msg <- paste0("\n", name %||% "object", " is of class `", class_actual[1], "` rather than `", class_expected, "`")
            stop(msg)
        }
    }
))


